import 'package:flutter/material.dart';

class AppConfig {
  static const String appName = 'AhilyaNagar TrafficGuard Pro';
  static const String appVersion = '1.0.0';
  
  // API Configuration
  static const String baseUrl = 'https://api.ahilyanagar-trafficguard.com';
  static const int apiTimeout = 30000; // 30 seconds
  
  // Map Configuration
  static const double defaultMapZoom = 15.0;
  static const double defaultMapTilt = 45.0;
  static const double defaultMapBearing = 0.0;
  
  // Location Configuration
  static const double locationAccuracy = 10.0; // meters
  static const int locationInterval = 5000; // 5 seconds
  static const int locationFastestInterval = 2000; // 2 seconds
  
  // Camera Configuration
  static const int maxImageSize = 1920; // pixels
  static const int maxVideoDuration = 60; // seconds
  static const int maxVideoSize = 100 * 1024 * 1024; // 100MB
  
  // Cache Configuration
  static const int maxCacheSize = 100 * 1024 * 1024; // 100MB
  static const Duration cacheDuration = Duration(days: 7);
  
  // Theme Configuration
  static const Color primaryColor = Color(0xFF1E88E5);
  static const Color secondaryColor = Color(0xFF42A5F5);
  static const Color accentColor = Color(0xFF64B5F6);
  static const Color errorColor = Color(0xFFE53935);
  static const Color successColor = Color(0xFF43A047);
  static const Color warningColor = Color(0xFFFFA000);
  
  // Text Configuration
  static const String defaultFontFamily = 'Poppins';
  static const double defaultFontSize = 16.0;
  static const double headingFontSize = 24.0;
  static const double subheadingFontSize = 20.0;
  
  // Animation Configuration
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);
  
  // Security Configuration
  static const int minPasswordLength = 8;
  static const int maxLoginAttempts = 3;
  static const Duration sessionTimeout = Duration(hours: 24);
  
  // Emergency Configuration
  static const List<String> emergencyNumbers = [
    '100', // Police
    '101', // Fire
    '108', // Ambulance
    '1091', // Women Helpline
  ];
  
  // Feature Flags
  static const bool enableBiometricAuth = true;
  static const bool enableOfflineMode = true;
  static const bool enableDarkMode = true;
  static const bool enableNotifications = true;
  static const bool enableLocationTracking = true;
  static const bool enableCameraFeatures = true;
  
  // Analytics Configuration
  static const bool enableCrashReporting = true;
  static const bool enableUsageAnalytics = true;
  static const bool enablePerformanceMonitoring = true;
  
  // Localization
  static const List<String> supportedLocales = ['en', 'mr']; // English and Marathi
  static const String defaultLocale = 'en';
  
  // Social Media
  static const Map<String, String> socialMediaLinks = {
    'facebook': 'https://facebook.com/ahilyanagar-trafficguard',
    'twitter': 'https://twitter.com/ahilyanagar-trafficguard',
    'instagram': 'https://instagram.com/ahilyanagar-trafficguard',
  };
  
  // Contact Information
  static const Map<String, String> contactInfo = {
    'email': 'support@ahilyanagar-trafficguard.com',
    'phone': '+91-XXXXXXXXXX',
    'address': 'AhilyaNagar Police Station, Maharashtra, India',
  };
} 