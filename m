Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045795B53A7
	for <lists+bpf@lfdr.de>; Mon, 12 Sep 2022 07:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiILFxT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Sep 2022 01:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiILFxT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Sep 2022 01:53:19 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B058252A3;
        Sun, 11 Sep 2022 22:53:18 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id u132so7581034pfc.6;
        Sun, 11 Sep 2022 22:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=zioV+Q4Idi0u9Z8VpvEHPcYo6VqqAXDmJIhKmCqBD34=;
        b=cn3D9OY29lqGt69vIMOfZ0JqRnKkfp92vIIVrexwylgTz4J0W+eeAjysmOBIzVo9WS
         QmzMl0Bt5046Kmd5fhW+saZuBWe1Lrm9k+LnI++ZyfNlp0KevmRrnaGsAR111ynIb/k/
         Gey/UaL4wZhonb2/sLx+DWChDY5g3KeIFih23Kgk79oB32ZIn3fuk7vCRSpIvKOTLoF/
         wWS+PCnjpFXkQAGcwjKeCfIaPK9WeEilOooTamTbxixcHHiGsWQzqR5tBA+0O089+p/y
         Aw80CP1imfE3S8c6hVgMVFrYGSNr9/Wom/A4tRZOSAvt0qPg732dw+MJH+gLwn58N+32
         BLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=zioV+Q4Idi0u9Z8VpvEHPcYo6VqqAXDmJIhKmCqBD34=;
        b=qpc/i/EVGw/UYsz24FT6F2IyxSaZ/+N88AXEvgIl6Nj+mD8lrxIUQ/zJpbD2a4O9+b
         1ZxP3n16+hCB5fSns+MshVwVFYEzh7wa336XFTD9GGZQSIv66DzguLCBsTQZ/6OPN8ly
         5MrShAC9sH3cU4GybUCdN6N/BGqfdIjrS23gn/T2Jqg4wD/Hj4EX8/B9++s1uKQZvbkD
         frdVSNKOaAFHu+QL/iWQ8h60R0NopiP14D+9vrlnmroEoTgmuVd5Z9BPznZOad9piEol
         1Taac/fX09TBQtIwZdVzA2JFxFxorohts/rGtHHEbMN/w38IKCpLpATSIhV0WDYd2OB+
         QCiw==
X-Gm-Message-State: ACgBeo0zf3cUiL7WK07wdi49I75svQnhIo0E+3NJDbjwV7kvDebOJ8Vx
        58g0X7Kmnjj0Zzj1wtt1pAYb/bBBwTA=
X-Google-Smtp-Source: AA6agR4bJDosJnzK1wiZUboz9P/kmQBFxs+BShwhtNVh3ecm+7qiLJt8tN2bweAqCP5CraZWw9cZ7A==
X-Received: by 2002:a63:5b61:0:b0:41d:3227:37b8 with SMTP id l33-20020a635b61000000b0041d322737b8mr21926914pgm.265.1662961997987;
        Sun, 11 Sep 2022 22:53:17 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:cfe7:8794:a807:6746])
        by smtp.gmail.com with ESMTPSA id l10-20020a170903244a00b00176b87a697fsm4882736pls.269.2022.09.11.22.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 22:53:16 -0700 (PDT)
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
Subject: [PATCH 0/4] perf lock contention: Improve call stack handling (v2)
Date:   Sun, 11 Sep 2022 22:53:10 -0700
Message-Id: <20220912055314.744552-1-namhyung@kernel.org>
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

v2 changes)
 * rebased to the latest acme/perf/core
 * added a simplified callchain copy

The perf lock contention relies on the stack trace to get the lock
caller names, this kind of difference can be annoying.  Ideally we could
skip stack trace entries for internal BPF or lock functions and get the
correct caller, but it's not the case as of today.  Currently it's hard
coded to control the behavior of stack traces for the lock contention
tracepoints.

To handle those differences, add two new options to control the number of
stack entries and how many it skips.  The default value worked well on
my VM setup, but I had to use --stack-skip=5 on real machines.

You can get it from 'perf/lock-stack-v2' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (4):
  perf lock contention: Factor out get_symbol_name_offset()
  perf lock contention: Show full callstack with -v option
  perf lock contention: Allow to change stack depth and skip
  perf lock contention: Skip stack trace from BPF

 tools/perf/Documentation/perf-lock.txt        |  6 ++
 tools/perf/builtin-lock.c                     | 97 +++++++++++++++----
 tools/perf/util/bpf_lock_contention.c         | 21 +++-
 .../perf/util/bpf_skel/lock_contention.bpf.c  |  3 +-
 tools/perf/util/lock-contention.h             |  3 +
 5 files changed, 107 insertions(+), 23 deletions(-)


base-commit: 62e64c9d2fd12839c02f1b3e8b873e7cb34e8720
-- 
2.37.2.789.g6183377224-goog

