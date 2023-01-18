Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176AC6713C7
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 07:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjARGU1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 01:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjARGSR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 01:18:17 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DA9193DE;
        Tue, 17 Jan 2023 22:06:03 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id d10so23711138pgm.13;
        Tue, 17 Jan 2023 22:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=AJM2l+mABefkfyEbBF+RzKX6IR1PByT45QHpW0h3qe4=;
        b=Uk9EEPHa9abUvjhRIQIWoxZOrA4S++vJR7Iml2l67ItI4NgzfFUOz1vV9Q63tFOjUm
         +QDRMwrVP7wbKL/UfKcz0XLrcmk5e32iTNT/I5grbXwJRvkLJnjCkYa+PrzAHHaIocjd
         uUtNOfaBvIUfMoTHFl8A7zTRslSf2vZPGjD9ijvZhaiqU66TeOxuFwSDxa+rlMS1wewi
         V4d0JUaeSZU9li9O4KdejcCLA88DVAhh4Vrp06iPXC/A3UOgbKQXznTgqh+4Cnz3z4Am
         iFtYE6EqMhZVXjwXvbIkYL/14mJS/XVDjY1S4HOxTFH+WMiR6KemWXi6zvzOhN53dQSV
         59+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJM2l+mABefkfyEbBF+RzKX6IR1PByT45QHpW0h3qe4=;
        b=2BMNowzCbHzbQC4fZS2fhgVVmQnGKRy0lHmlcs1NGnksJMMIiXcCHU9F1iFwQg3M2Y
         6ITpS0HDIx9s+q0r1J1v/hYr16zvr+QaCLnlUSPFxe0fgxhz92ixBI4tI1za5FtqrXzs
         Pm0lCphsi2+DOY/snZ4mhBbPwVEnH6Nx79BnBWOwIZHlCtidAUM3jqtu03dnR8YybIZF
         /B7vw9/eyYF1iGmyFIHK+vZJKcfNx8K9Qe1H6MzFhBr/UbWBI4dXbJo3rsXpWmNLKkGL
         YRjTEJMsXO0rkE42FSZj12aLPG57/RriHjctZz5qXSQm0rSASKXvp6tMNuEH07peOzRY
         6aag==
X-Gm-Message-State: AFqh2kpN9ez7JgRRVNLFLeGC2+V9HKB51HLfmd/Ymmx/ovPgJpBuyTKt
        mus8L1BOICciQJhrobWJJwU=
X-Google-Smtp-Source: AMrXdXvJj/WuxPD1+Xma7Enk9QJHUshgvQ19l5+RsLJDTd/eY1Ms6gJENO1+HU9ZaSxZaP5H9LwKlg==
X-Received: by 2002:a05:6a00:180d:b0:58d:c694:9a9e with SMTP id y13-20020a056a00180d00b0058dc6949a9emr7449718pfa.18.1674021960598;
        Tue, 17 Jan 2023 22:06:00 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:3749:9eb3:dfb5:f449])
        by smtp.gmail.com with ESMTPSA id b126-20020a62cf84000000b00574e84ed847sm10990180pfg.24.2023.01.17.22.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 22:06:00 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Song Liu <song@kernel.org>,
        bpf@vger.kernel.org
Subject: [PATCHSET 0/8] perf/core: Prepare sample data for BPF (v3)
Date:   Tue, 17 Jan 2023 22:05:51 -0800
Message-Id: <20230118060559.615653-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

The perf_prepare_sample() is to fill the perf sample data and update the
header info before sending it to the ring buffer.  But we want to use it
for BPF overflow handler so that it can access the sample data to filter
relevant ones.

Changes in v3)
 * update data->sample_flags in __perf_event_header__init_id()  (PeterZ)
 * add Acked-by's from Jiri and Song

Changes in v2)
 * the layout change is merged
 * reduce branches using __cond_set  (PeterZ)
 * add helpers to set dynamic sample data  (PeterZ)
 * introduce perf_prepare_header()  (PeterZ)
 * call perf_prepare_sample() before bpf_overflow_handler unconditionally

This means the perf_prepare_handler() can be called more than once.  To
avoid duplicate work, use the data->sample_flags and save the data size.

I also added a few of helpers to set those information accordingly.
But it looks some fields like REGS_USER, STACK_USER and AUX are saved in
the perf_prepare_sample() so I didn't add the helpers for them.

After than we can just check the filtered_sample_type flags begin zero
to determine if it has more work.  In that case, it needs to update the
data->type since it's possible to miss when PMU driver sets all required
sample flags before calling perf_prepare_sample().

The code is also available at 'perf/prepare-sample-v3' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung

Cc: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org

Namhyung Kim (8):
  perf/core: Save the dynamic parts of sample data size
  perf/core: Add perf_sample_save_callchain() helper
  perf/core: Add perf_sample_save_raw_data() helper
  perf/core: Add perf_sample_save_brstack() helper
  perf/core: Set data->sample_flags in perf_prepare_sample()
  perf/core: Do not pass header for sample id init
  perf/core: Introduce perf_prepare_header()
  perf/core: Call perf_prepare_sample() before running BPF

 arch/powerpc/perf/core-book3s.c    |   3 +-
 arch/s390/kernel/perf_cpum_cf.c    |   4 +-
 arch/s390/kernel/perf_cpum_sf.c    |   3 +-
 arch/s390/kernel/perf_pai_crypto.c |   4 +-
 arch/s390/kernel/perf_pai_ext.c    |   4 +-
 arch/x86/events/amd/core.c         |   6 +-
 arch/x86/events/amd/ibs.c          |   9 +-
 arch/x86/events/intel/core.c       |   6 +-
 arch/x86/events/intel/ds.c         |  24 ++--
 include/linux/perf_event.h         | 133 +++++++++++++-----
 kernel/events/core.c               | 207 ++++++++++++++++-------------
 kernel/trace/bpf_trace.c           |   6 +-
 12 files changed, 236 insertions(+), 173 deletions(-)


base-commit: 9fcad995c6c52cc9791f7ee9f1386a5684055f9c
-- 
2.39.0.314.g84b9a713c41-goog

