Pod::Spec.new do |s|

s.name         = "KActionMenu"
s.version      = "1.0"
s.summary      = "Like to iOS 3D touch menu"
s.description  = <<-DESC
Like to iOS 3D touch menu
DESC
s.homepage     = "https://github.com/KenanAtmaca/KActionMenu"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author             = { "KenanAtmaca" => "mail.kenanatmaca@gmail.com" }
s.social_media_url   = "https://twitter.com/uikenan"

s.platform     = :ios, "11.0"
s.requires_arc = true
s.ios.deployment_target = "11.0"

s.source       = { :git => "https://github.com/KenanAtmaca/KActionMenu", :tag => "#{s.version}" }
s.source_files  = "KActionMenu", "KActionMenu/**/*.{h,m,swift}"
s.resources = "KActionMenu/**/*.{xib,png}"
s.resource_bundles = {
'KActionMenu' => [
'KActionMenu/**/*.{xib,png}'
]
}

s.swift_version = '4.2'
s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.2'}
end
