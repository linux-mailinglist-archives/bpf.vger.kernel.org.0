Return-Path: <bpf+bounces-8658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F82788D44
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 18:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E029B1C20B8C
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 16:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A9417FEA;
	Fri, 25 Aug 2023 16:41:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624CA1079A
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 16:41:59 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD6D212C;
	Fri, 25 Aug 2023 09:41:57 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bf5c314a57so9081295ad.1;
        Fri, 25 Aug 2023 09:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692981716; x=1693586516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUtgrW6eNd+ei4mrqfgy4UMuQKUiyhEwVP11RhXLPpE=;
        b=Jc8X8yAx1DkKrdHZdfxfOShgApLb+rIQH7GDU1xK03aYl4kfwcTVeUL1Nva2yxD/Bk
         PWlIz+A+sF72o7hsB8GmFaHzRX4VE712f70f+YXRE0J9DunyUQqCy6SIJTOAB9Oco7Nz
         9SIniGHbc4J5yKHQULUAvnKvyNfmA9Yuq6FWnbNOQGhkjWpK+LlRve8peiO8wGv45Hfr
         bAmb5zD583GpZ6jAlItk1HsNfXxHf3TkTuXc2tVW3WCVTn8pfYmrg5Us8nuK8PRJEFjg
         7dVkDYFBHAlHofdteF2X3eItKSBeBabNmHMNL0GSFXe9NTMY9wanhEL2jxCp61o+dAMs
         WCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692981716; x=1693586516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cUtgrW6eNd+ei4mrqfgy4UMuQKUiyhEwVP11RhXLPpE=;
        b=HO6+47q5TBgO/F+RX+mC8h/iLF1OeB7BnoUHyIrQDOlZA/tLuYRrYgrNMWC3izXBzM
         KRNc6IZItlABld86EizNXQiTPCzojoVRm4zD4/o2aNf3LYTzwFDS/rlbulVNFwoKsBYN
         cyTiazbw5otSQpcDs3DhHBviVHmFtGm1mAl4iiuRe9Co4V6sXmPUMGOwjFV1d2Lt94H6
         i1SiCdLvB21swhtJTtkPtgKY/jbhLhDgF/KAi3uv4QxJuRQkYGQS0LYrUcsnGC/XZOpv
         ACvstwS9cheoQz4l2iHcHItsh81+mrQyPFWXPXORp6eYo12P9wRfRWQ6G0Ai4WNFjYzZ
         TeGw==
X-Gm-Message-State: AOJu0Yy2jI2TxGXdONx14UQqH0c1V6F8ef7rwdIjp6UVS4SJNjd7clVz
	2gIWUZsMjQmesBS5k1r3+yU=
X-Google-Smtp-Source: AGHT+IGBzD+cTTDWVDeNmzMsaaNe4yOvAqQcp4oy39lViMnAhnidtdmiguACypbme5KwYbGWBM5kXQ==
X-Received: by 2002:a17:902:744a:b0:1bc:9794:22ef with SMTP id e10-20020a170902744a00b001bc979422efmr15194104plt.1.1692981716413;
        Fri, 25 Aug 2023 09:41:56 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:a7ba:1788:3b00:4316])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902ecc600b001a5fccab02dsm1938755plh.177.2023.08.25.09.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 09:41:55 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	Song Liu <song@kernel.org>
Subject: [PATCH 2/3] perf test: Fix perf stat bpf counters test on Intel
Date: Fri, 25 Aug 2023 09:41:51 -0700
Message-ID: <20230825164152.165610-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230825164152.165610-1-namhyung@kernel.org>
References: <20230825164152.165610-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As of now, bpf counters (bperf) don't support event groups.  But the
default perf stat includes topdown metrics if supported (on recent Intel
machines) which require groups.  That makes perf stat exiting.

  $ sudo perf stat --bpf-counter true
  bpf managed perf events do not yet support groups.

Actually the test explicitly uses cycles event only, but it missed to
pass the option when it checks the availability of the command.

Fixes: 2c0cb9f56020d ("perf test: Add a shell test for 'perf stat --bpf-counters' new option")
Cc: stable@vger.kernel.org
Cc: Song Liu <song@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/stat_bpf_counters.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
index 513cd1e58e0e..a87bb2814b4c 100755
--- a/tools/perf/tests/shell/stat_bpf_counters.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters.sh
@@ -22,10 +22,10 @@ compare_number()
 }
 
 # skip if --bpf-counters is not supported
-if ! perf stat --bpf-counters true > /dev/null 2>&1; then
+if ! perf stat -e cycles --bpf-counters true > /dev/null 2>&1; then
 	if [ "$1" = "-v" ]; then
 		echo "Skipping: --bpf-counters not supported"
-		perf --no-pager stat --bpf-counters true || true
+		perf --no-pager stat -e cycles --bpf-counters true || true
 	fi
 	exit 2
 fi
-- 
2.42.0.rc1.204.g551eb34607-goog


