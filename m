Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E905B14C5
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 08:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiIHGiC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 02:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiIHGiB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 02:38:01 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3FEC6515;
        Wed,  7 Sep 2022 23:37:59 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id z187so16919677pfb.12;
        Wed, 07 Sep 2022 23:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=cvQFVKfsfpYxMErEhYXJffwhmqD/tkknSq1Emm1w1rc=;
        b=OG40dAmcsya0mIfrs6M7VTGhsPQyc99M2zpnYeKUWlGxufzblnKLD/nYUPy/4B242c
         PJj8eBvGrP7BtFMn0mr5prdEbu5LAT9j5o7d/nuGcYH9f2HLhkhsc7RGC8gDVmdc7J3G
         tzq3zR+BUw5sSdJ6By3uj/31+WciaGyDV2UWLhkTTFXf3QhfufE79HLfGrMMBMyp+ufh
         NyrR/9LU9nqQw3dsHNwJJrsqrgbNAGLUU0uzg2y2HmvGaSQWt4F1sR4k03w/FrwUUtuR
         rMqv/xKkEy36HVFUD3E4daujJ7oZd3Dda5/aszKzA2NhcRDa2r9cKFQc/3ftaj5mEixu
         vLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=cvQFVKfsfpYxMErEhYXJffwhmqD/tkknSq1Emm1w1rc=;
        b=2K1tqeUQ9D9sC/+Cgf4eNmD5RKwBgP5GD3Mi6DETPkYSJVNoDqhFMTdvxRwV+QNBeQ
         X/VuvMvtP36LBVWlE5ABNMEAuvzLVh5usDBj0UmddszwIJc37EX4x+C7r5e7vx13ntA2
         XbsZ6iaMW2Uzp5poxflFs3b5YmlFH/2NGrQQP8LNcq+4PvTJSbPGc6tHPEOkgYSd8X6v
         OXYQ6/ctFCTkOgw+gYWuBDfk/7xsVnHZ1wKxfbb5QrZTIkVeASbl29ivG1689ofDkDBG
         QU1FmWtSD32VGKL89+8nJKI9WbP33lN0OhzNINP5uvnavGHgmXNhkx3B/nG+JPKMNV4L
         01/A==
X-Gm-Message-State: ACgBeo1kiVBTLo/ndpXy8l1nNF4M7/GCR4UT5SR+aM91wVgnUKnWlPRE
        BAv0O5txUEgeBidLdyNrGHWPgfmn99k=
X-Google-Smtp-Source: AA6agR5HuV/ew0Uwj8ErnMLTC7jyrabpINK0Zcppz8U66W1F9QiUbP2zlOOEyMagiUtMQOTWu1S+PA==
X-Received: by 2002:a65:5941:0:b0:41d:a203:c043 with SMTP id g1-20020a655941000000b0041da203c043mr6466422pgu.483.1662619078869;
        Wed, 07 Sep 2022 23:37:58 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:7f21:d032:3f14:a4e6])
        by smtp.gmail.com with ESMTPSA id o33-20020a17090a0a2400b001fb0fc33d72sm890716pjo.47.2022.09.07.23.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 23:37:56 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        bpf@vger.kernel.org
Subject: [PATCH 0/4] perf lock contention: Improve call stack handling (v1)
Date:   Wed,  7 Sep 2022 23:37:50 -0700
Message-Id: <20220908063754.1369709-1-namhyung@kernel.org>
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

I found that call stack from the lock tracepoint (using bpf_get_stackid)
can be different on each configuration.  For example it's very different
when I run it on a VM than on a real machine.

The perf lock contention relies on the stack trace to get the lock
caller names, this kind of difference can be annoying.  Ideally we could
skip stack trace entries for internal BPF or lock functions and get the
correct caller, but it's not the case as of today.  Currently it's hard
coded to control the behavior of stack traces for the lock contention
tracepoints.

To handle those differences, add two new options to control the number of
stack entries and how many it skips.  The default value worked well on
my VM setup, but I had to use --stack-skip=5 on real machines.

You can get it from 'perf/lock-stack-v1' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (4):
  perf lock contention: Factor out get_symbol_name_offset()
  perf lock contention: Show full callstack with -v option
  perf lock contention: Allow to change stack depth and skip
  perf lock contention: Skip stack trace from BPF

 tools/perf/Documentation/perf-lock.txt        |  6 ++
 tools/perf/builtin-lock.c                     | 89 ++++++++++++++-----
 tools/perf/util/bpf_lock_contention.c         | 21 +++--
 .../perf/util/bpf_skel/lock_contention.bpf.c  |  3 +-
 tools/perf/util/lock-contention.h             |  3 +
 5 files changed, 96 insertions(+), 26 deletions(-)


base-commit: 6c3bd8d3e01d9014312caa52e4ef1c29d5249648
-- 
2.37.2.789.g6183377224-goog

