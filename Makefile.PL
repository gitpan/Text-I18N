use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'         => 'Text::I18N',
    'VERSION_FROM' => 'I18N.pm',
    'PREREQ_PM'    => { 'I18N::LangTags' => 0, 'I18N::LangTags::Detect' => 0 }
);
