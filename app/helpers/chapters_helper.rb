# frozen_string_literal: true

module ChaptersHelper
  def related_sites
    [
        ['salah.jpg', 'http://salah.com/', _t('related_sites.salah'), _t('related_sites.salah_description')],
        ['sunnah.png', 'http://sunnah.com/', _t('related_sites.sunnah'), _t('related_sites.sunnah_description')],
        ['audio.png', 'http://quranicaudio.com/', _t('related_sites.audio'), _t('related_sites.audio_description')]
    ]
  end

  def quran_script_types
    [
        ['KFGQPC Font v1', 'v1'],
        ['KFGQPC Font v2', 'v2'],
        ['Uthmani Script', 'uthmani'],
        ['Imlaei Script', 'imlaei'],
        ['Indopak Script', 'indopak'],
        ['Uthmani with tajweed', 'tajweed']
    ]
  end

  def chapter_next_page_link
    if @presenter.next_page
      next_page_link = if @presenter.reading_mode?
                         surah_reading_page_link
                       else
                         ayah_range_path(@presenter.chapter.id,
                                         @presenter.ayah_range,
                                         page: @presenter.next_page,
                                         translations: @presenter.valid_translations,
                                         reading: @presenter.reading_mode?)

                       end

      link_to 'load more',
              next_page_link,
              rel: 'next',
              data: {remote: true},
              class: 'btn btn--lightgrey btn--large  btn--arrow-down'

    end
  end

  def surah_reading_page_link
    if (last = @presenter.last_verse)
      ayah_range_path(
          @presenter.chapter,
          @presenter.ayah_range,
          page: @presenter.next_page,
          after: last.id + 1,
          reading: true
      )
    end
  end

  def juz_next_page_link
    if @presenter.next_page
      if @presenter.reading_mode?
        next_page_link = juz_next_page_for_reading
      else
        next_page_link = quran_juz_path(@presenter.current_juz,
                                        page: @presenter.next_page,
                                        reading: @presenter.reading_mode?)
      end

      if next_page_link
        link_to 'load more',
                next_page_link,
                rel: 'next',
                data: {remote: true},
                class: 'btn btn--lightgrey btn--large  btn--arrow-down'
      end
    end
  end

  def juz_next_page_for_reading
    if (last = @presenter.last_verse)
      quran_juz_path(@presenter.current_juz,
                     page: @presenter.next_page,
                     after: last.id + 1,
                     reading: @presenter.reading_mode?)
    end
  end

  def font_ids(verses)
    verses.map(&:page_number).uniq
  end

  def popular_searches
    [
        ['/ayatul-kursi', _t('search.ayatul_kursi')],
        ['/surah-ya-sin', _t('search.yaseen')],
        ['/surah-al-mulk', _t('search.al_mulk')],
        ['/surah-ar-rahman', _t('search.ar_rahman')],
        ['/surah-al-waqiah', _t('search.al_waqiah')],
        ['/surah-al-kahf', _t('search.al_kahf')],
        ['/surah-al-muzzammil', _t('search.al_muzammil')]
    ]
  end
end
