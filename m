Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1A15B3E3F
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 19:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiIIRwr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 13:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbiIIRwp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 13:52:45 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E43C12B28A;
        Fri,  9 Sep 2022 10:52:43 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so2350389pjl.0;
        Fri, 09 Sep 2022 10:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=nnZVN7GsQJzh7p6I12EKKFy7ReVxa2w2WN+uEU+5yNU=;
        b=eQbyzUpEdqi/SfaSyFx6h2R4dW5AF9qV/JM6SJrjA654l0Haj7dfULurIyv9T+mU76
         D+QgOEuEj3uVBk8vv+alZ51/9HKBB56xwi1Gac/ITIggoDXNpYnC9BAkeL8SADd84cdr
         cPk7wi0ktU7CanW7qt5cmlVogXzzN/bHUvAL+Gob73+fLSLcF8yOH1q1gO5PRrBhB4qs
         iVVvn/OqumkPgCh8orC5ypWgopJNogVwkWuXtcssLwOfjLsNeAhaZexMqcgAE4r4uLin
         PmDVnZ0adZCHEAWZGK4Lga5BV3K05LVcM9bX0gOEKQkqjG2Z2uKYGn1HYa++O5UjLHvw
         UaBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=nnZVN7GsQJzh7p6I12EKKFy7ReVxa2w2WN+uEU+5yNU=;
        b=le/3nditz7IVELk/3bVUtOJz+6SHnnk2RVWuzWuDjZKh0UtiNYGi4Jog2q41du5Wlk
         3Ogc6lZhmwh5YLk/0o+8cPZJsM3VGhKqbkNO/qhhy5mnNIytcV8Czoe9OKpwhnDXeUv4
         eAQo2CW8Ao6FpqgF0TfIq63Wm75q0xrRmTvLrqbE0b3K95Kl3P68AVuG1tz1K8j0Z05u
         ha+aQ7xFxdK6xl7vaekxN17cxsfALC2AtxHPaL1jIEKbZN1HDZ9z2yFpeR8WzjoUKV/N
         cnL+B+s05vFw1bF9qiG08SrtwluGAvXKQWIzDqFDj7z/4XdoC1ZjWQFH3fJvp9TPe+81
         Desw==
X-Gm-Message-State: ACgBeo04WKgpcJEwP7La/JZgszeW0LS5XJe/BQ2ovLvUU1pUcr12Er5V
        toxkMiaymw01X+eIgj2/JCg=
X-Google-Smtp-Source: AA6agR5zk4CxPmbcz+xAGJaIx+pJSKVlZ7HMxLEvo8jpmPW2Ej5lXROrUrW1asjR9d7DFFWuuMHccg==
X-Received: by 2002:a17:902:f08a:b0:176:b477:8be0 with SMTP id p10-20020a170902f08a00b00176b4778be0mr15237536pla.66.1662745962407;
        Fri, 09 Sep 2022 10:52:42 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:b77b:e812:1879:ec2f])
        by smtp.gmail.com with ESMTPSA id w207-20020a627bd8000000b0052d46b43006sm4275pfc.156.2022.09.09.10.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 10:52:41 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        bpf@vger.kernel.org
Subject: [PATCH 0/3] perf stat: Fix bperf cgroup counters
Date:   Fri,  9 Sep 2022 10:52:36 -0700
Message-Id: <20220909175239.206268-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

This fixes a random failures in the perf stat cgroup BPF counters (bperf).
I've also added a new test to ensure it working properly.

You can get it from 'perf/bperf-cgrp-fix-v1' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (3):
  perf stat: Fix BPF program section name
  perf stat: Fix cpu map index in bperf cgroup code
  perf test: Add a new test for perf stat cgroup BPF counter

 .../tests/shell/stat_bpf_counters_cgrp.sh     | 83 +++++++++++++++++++
 tools/perf/util/bpf_counter_cgroup.c          |  4 +-
 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c   |  2 +-
 3 files changed, 86 insertions(+), 3 deletions(-)
 create mode 100755 tools/perf/tests/shell/stat_bpf_counters_cgrp.sh


base-commit: 715a6dea8483ff2035de766857f962ac198eb195
-- 
2.37.2.789.g6183377224-goog

