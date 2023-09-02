package com.akshaytest4;

import android.app.NotificationManager;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.widget.Toast;

import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContract;
import androidx.activity.result.contract.ActivityResultContracts;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.content.ContextCompat;

import com.clevertap.android.sdk.CTInboxListener;
import com.clevertap.android.sdk.CleverTapAPI;
import com.clevertap.android.sdk.displayunits.DisplayUnitListener;
import com.clevertap.android.sdk.displayunits.model.CleverTapDisplayUnit;
import com.facebook.react.ReactActivity;
import com.facebook.react.ReactActivityDelegate;
import com.facebook.react.defaults.DefaultNewArchitectureEntryPoint;
import com.facebook.react.defaults.DefaultReactActivityDelegate;

import java.util.ArrayList;

import expo.modules.ReactActivityDelegateWrapper;

public class MainActivity extends ReactActivity implements CTInboxListener, DisplayUnitListener {

  CleverTapAPI clevertapDefaultInstance;
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    // Set the theme to AppTheme BEFORE onCreate to support 
    // coloring the background, status bar, and navigation bar.
    // This is required for expo-splash-screen.
    setTheme(R.style.AppTheme);
    super.onCreate(null);
    initCleverTap();

    if (ContextCompat.checkSelfPermission(
            this, android.Manifest.permission.POST_NOTIFICATIONS) ==
            PackageManager.PERMISSION_GRANTED) {
      // You can use the API that requires the permission.
      createNotificationChannel();
    } else if (shouldShowRequestPermissionRationale("")) {
      // In an educational UI, explain to the user why your app requires this
      // permission for a specific feature to behave as expected, and what
      // features are disabled if it's declined. In this UI, include a
      // "cancel" or "no thanks" button that lets the user continue
      // using your app without granting the permission.

    } else {
      // You can directly ask for the permission.
      // The registered ActivityResultCallback gets the result of this request.
      requestPermissionLauncher.launch(
              android.Manifest.permission.POST_NOTIFICATIONS);
    }



  }


  // Register the permissions callback, which handles the user's response to the
// system permissions dialog. Save the return value, an instance of
// ActivityResultLauncher, as an instance variable.
  private ActivityResultLauncher<String> requestPermissionLauncher =
          registerForActivityResult(new ActivityResultContracts.RequestPermission(), isGranted -> {
            if (isGranted) {
              // Permission is granted. Continue the action or workflow in your
              // app.
              createNotificationChannel();
            } else {
              // Explain to the user that the feature is unavailable because the
              // feature requires a permission that the user has denied. At the
              // same time, respect the user's decision. Don't link to system
              // settings in an effort to convince the user to change their
              // decision.
            }
          });

  /**
   * Returns the name of the main component registered from JavaScript.
   * This is used to schedule rendering of the component.
   */
  @Override
  protected String getMainComponentName() {
    return "main";
  }

  /**
   * Returns the instance of the {@link ReactActivityDelegate}. Here we use a util class {@link
   * DefaultReactActivityDelegate} which allows you to easily enable Fabric and Concurrent React
   * (aka React 18) with two boolean flags.
   */
  @Override
  protected ReactActivityDelegate createReactActivityDelegate() {
    return new ReactActivityDelegateWrapper(this, BuildConfig.IS_NEW_ARCHITECTURE_ENABLED, new DefaultReactActivityDelegate(
        this,
        getMainComponentName(),
        // If you opted-in for the New Architecture, we enable the Fabric Renderer.
        DefaultNewArchitectureEntryPoint.getFabricEnabled(), // fabricEnabled
        // If you opted-in for the New Architecture, we enable Concurrent React (i.e. React 18).
        DefaultNewArchitectureEntryPoint.getConcurrentReactEnabled() // concurrentRootEnabled
        ));
  }

  /**
   * Align the back button behavior with Android S
   * where moving root activities to background instead of finishing activities.
   * @see <a href="https://developer.android.com/reference/android/app/Activity#onBackPressed()">onBackPressed</a>
   */
  @Override
  public void invokeDefaultOnBackPressed() {
    if (Build.VERSION.SDK_INT <= Build.VERSION_CODES.R) {
      if (!moveTaskToBack(false)) {
        // For non-root activities, use the default implementation to finish them.
        super.invokeDefaultOnBackPressed();
      }
      return;
    }

    // Use the default back button implementation on Android S
    // because it's doing more than {@link Activity#moveTaskToBack} in fact.
    super.invokeDefaultOnBackPressed();
  }

  private void initCleverTap() {
    //Set Debug level for CleverTap
    CleverTapAPI.setDebugLevel(CleverTapAPI.LogLevel.DEBUG);
    //Create CleverTap's default instance
    clevertapDefaultInstance = CleverTapAPI.getDefaultInstance(getApplicationContext());
    clevertapDefaultInstance.enableDeviceNetworkInfoReporting(true);
      //Set the Notification Inbox Listener
    clevertapDefaultInstance.setCTNotificationInboxListener(MainActivity.this);
              //Set the Display Unit Listener
    clevertapDefaultInstance.setDisplayUnitListener(MainActivity.this);
  }

  private void createNotificationChannel() {
    Toast.makeText(this, "Permission granted!", Toast.LENGTH_SHORT).show();

    //For Android 13+ we need to create notification channel after notification permission is accepted
    CleverTapAPI.createNotificationChannel(
            this, "AKSHAY", "Core",
            "Core notifications", NotificationManager.IMPORTANCE_MAX, true
    );

    CleverTapAPI.createNotificationChannel(
            this, "AKSHAY_PT", "Push templates",
            "All push templates", NotificationManager.IMPORTANCE_MAX, true
    );
  }

  @Override
  public void inboxDidInitialize() {

  }

  @Override
  public void inboxMessagesDidUpdate() {

  }

  @Override
  public void onDisplayUnitsLoaded(ArrayList<CleverTapDisplayUnit> units) {

  }
}
