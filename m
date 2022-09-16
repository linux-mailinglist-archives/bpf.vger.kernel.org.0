Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD405BB24B
	for <lists+bpf@lfdr.de>; Fri, 16 Sep 2022 20:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiIPSli (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Sep 2022 14:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiIPSlh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Sep 2022 14:41:37 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E23B72B3;
        Fri, 16 Sep 2022 11:41:36 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id d64-20020a17090a6f4600b00202ce056566so538845pjk.4;
        Fri, 16 Sep 2022 11:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=MsSWtdWwfm5LI2aqosdwjTcepxpQuXiiTGguKXhf+OM=;
        b=ZX3v+k6yLkRZCjM4GLmnEOKZ+IIHCQyHvdURpyjbdh0z1Aqikn2rg4Qzg2m/YW1Jv1
         4KRdCS4xX2Wk0yqWP9nxN7uVEQQa5PauMFGsr24NguSAZT4OD8dIZ19hjTPyTJv7q8AK
         MG2KOLJR8KrdBooRbfWkX3+YehfW7C7xhdafppQ0Y2WKMdncaCpQbXpuZALg3OiGVJ36
         579THWCfst73XI8FvQ+VFHtUCjkAElFWTuOXTmELHNf84o/9aVkvOHf33xBT1PYHLliM
         u0FD3gsvI2IOvg1oSMV15Avb8s6e5if/pBpVSSJ02TCnxPYCq7j5F+Kl1lo3wr9HuI6T
         AVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=MsSWtdWwfm5LI2aqosdwjTcepxpQuXiiTGguKXhf+OM=;
        b=pVlnlOePSKJldq6vEc2gAuPmT1kSEW7Y7Dcex5B8rtndgkU7q9jJ+5jkfElk1071Fl
         aCcyxKOoxkLzb2IuxPsicaBArlugqpVNfzB2jIsrDAD9zUVyFwqWd6EBNHoyU74vSAzq
         sdKaD15vbd45NjgC7pYHdWX3Q7St1wFTSOhKUgziKJtcK2N/L4gf/Rbor2l6EKUDTaH1
         CzkptcbcyuWdyzklYEF0HhjHFnkhg6w3iDSLK4LGjMA+A7N4OWTsbIWIvY9AA9RIAOdr
         aSOEg0J61FYAwc7gmrLl/LVfxNOcE3Btn+dYATG5blpGGDqA6e3xqrgQ2nVDaP8ZVryP
         /QLQ==
X-Gm-Message-State: ACrzQf3Yg/bo8hL3F8psOLQ0D9+HJCFPkXfQgfIGj4jCO8jqDmS/+8wp
        Z7zkYfYlRWB0xgM2i0Wwpf8=
X-Google-Smtp-Source: AMsMyM6ZtfrD+bhBriidhHqxTVdNbmggn6FfJIIvwYTcJTMVcQyWCrt0Ir1LwpV911dN90MusAD4kw==
X-Received: by 2002:a17:90a:5993:b0:202:be54:1689 with SMTP id l19-20020a17090a599300b00202be541689mr17222955pji.207.1663353695770;
        Fri, 16 Sep 2022 11:41:35 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:2952:dee7:a35e:6428])
        by smtp.gmail.com with ESMTPSA id y18-20020a170902b49200b0016dcbdf9492sm15093004plr.92.2022.09.16.11.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 11:41:35 -0700 (PDT)
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
Subject: [PATCH 0/4] perf stat: Fix bperf cgroup counters (v2)
Date:   Fri, 16 Sep 2022 11:41:28 -0700
Message-Id: <20220916184132.1161506-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
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

This fixes random failures in the perf stat cgroup BPF counters (bperf).
I've also added a new test to ensure it working properly.

v2 changes)
 * fix a segfault with uncore event

You can get it from 'perf/bperf-cgrp-fix-v2' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (4):
  perf stat: Fix BPF program section name
  perf stat: Fix cpu map index in bperf cgroup code
  perf stat: Use evsel->core.cpus to iterate cpus in BPF cgroup counters
  perf test: Add a new test for perf stat cgroup BPF counter

 .../tests/shell/stat_bpf_counters_cgrp.sh     | 83 +++++++++++++++++++
 tools/perf/util/bpf_counter_cgroup.c          | 10 +--
 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c   |  2 +-
 3 files changed, 89 insertions(+), 6 deletions(-)
 create mode 100755 tools/perf/tests/shell/stat_bpf_counters_cgrp.sh


base-commit: 62e64c9d2fd12839c02f1b3e8b873e7cb34e8720
-- 
2.37.3.968.ga6b4b080e4-goog

