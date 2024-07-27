Return-Path: <bpf+bounces-35898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B4493FBC5
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 18:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3851C226D3
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 16:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE99818A935;
	Mon, 29 Jul 2024 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="mJyZycx+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD200189F30
	for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271580; cv=none; b=Yt++IE7MGsMgtJhQzpCWeebBetM5MeA8BJACixo+0TLw9XJJD6VrQCtEOQmuiA5qKRzGv1NPhdT0IjN3ZCCH1YBsdh2kDeNm6vpDRcSGsawGLM6MVj3y4Ud/x8/sumvGUwZFf/GczAOS5LuVWvmtKHixU4/cGrO59jzfirHbuT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271580; c=relaxed/simple;
	bh=DcCALxIHVCUK+9WrmJFTXpoeJxfw9pHG1sO9q8SD+00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YlwoY3HkJc5NbsXlu3jHF7r/NIKdEBGLgO0SdLsFKF1ms0jlN96l17RtJsEdnBdfIDFHne3+sMpcuDRnBIMmeMRYe9PmqDWitWjF1BCRnLya1XQEqgaa1Hu+BME0nCxPBntWA8Cn9DaODxoAfJd6Ugfq4wrImfGNPWV4OUAO8DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=mJyZycx+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fed72d23a7so22058745ad.1
        for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 09:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722271578; x=1722876378; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=esv+2bQw0aEMT9KM4UokUyH6FGgrDkyBUaVhFoJhC+U=;
        b=mJyZycx+hMEodAzZe9rbUdYqULnRVrcPJN0Y0oBMluGhX7EROrWyv/Rj7aqLnRorml
         tRmoyulT9QlLciumW9EVqeQYxBg3Um/woe6WrkyZ4iEUL54YvinHk0wN+WwCriZGELGI
         y2x4Xvi4Dee0ICkK6yDO6GB9/RTItdpsLn6jVhn410NJEhfkw7HpFLFqYckGaMBN7uLl
         7ILn1M5v0bgPftZD3RkuEV4G9R5Hck6JLLnSDcq22USvZ5Gg4adW40pVXpTFi/3L/xuW
         XtNzQNrqHI1EU3YrocfJLmOkGjjvi0vOY09xEAkzjh/bIJf9lZL9w8U7EhHVBH0WpaG+
         8iBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722271578; x=1722876378;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=esv+2bQw0aEMT9KM4UokUyH6FGgrDkyBUaVhFoJhC+U=;
        b=HCOpt/lqLNeXUV1cNh41ohiet74Y8sG0qOs8e5fHp2/MXCoK/sM5jFK/CeWlOmfLyX
         CQyp0KaHtUJRLNvHCw/76yLIfpgJZfylPWcijK1e7JxthrhvmhcNX6k7tp1cWhy5TF6R
         KbCMSLCdnK9Q4w7wwwnZdN+oAkViHBZp47VUAi062TneEQlPIrtrzbwGO7/wV2ASJz7K
         8UIl2niwC7mfrMMw05qksBHQigKuW+FVGHGszE5jK1Bl6VJh9gUVKS37Q6dXXWRXF9af
         i0OfPoYNqp6ZlfbhkyG1pBylm+WB4moMB22XBa+eUs8sUDAHEwR3Jr8SAXXdgQA4D1tB
         08yg==
X-Forwarded-Encrypted: i=1; AJvYcCUZvnGfHX+HDWwi7BgAjBRV1CmfRo1c70P/Fmmivs0wi5Wtt4B6Bl9ZM6YeiX3UXNAh2VqzeWjpZ2TryEUbLXzcCXrq
X-Gm-Message-State: AOJu0YxgeBJ/tdCXfMV+fFjwvdR02DP27HcH6pkPANUBrBo8oDSvbBsI
	4nHixJAu+EkPFdo4n3u8uCxkYEkCXIK34V9MGsY2B/JA9FW4o8JomqzspxEbeo8=
X-Google-Smtp-Source: AGHT+IFSQceV8kL40vzasoKkWICuL+b5k2ukcYwrsTHg9WGugoQ3cfB1FuG9VUzxm2y6klGdQ4UbgQ==
X-Received: by 2002:a17:902:ecd1:b0:1fd:a412:5ded with SMTP id d9443c01a7336-1ff0482c4b4mr61845635ad.26.1722271578209;
        Mon, 29 Jul 2024 09:46:18 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7d401c6sm85480545ad.117.2024.07.29.09.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:46:17 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 26 Jul 2024 22:29:37 -0700
Subject: [PATCH v2 7/8] libperf test: Add test_stat_overflow()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-overflow_check_libperf-v2-7-7d154dcf6bea@rivosinc.com>
References: <20240726-overflow_check_libperf-v2-0-7d154dcf6bea@rivosinc.com>
In-Reply-To: <20240726-overflow_check_libperf-v2-0-7d154dcf6bea@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 Shunsuke Nakamura <nakamura.shun@fujitsu.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722271564; l=6608;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=A//Q40WQ+t6MAB7Qrx+4soh8s9dOFzIWFwFxUkcU1xQ=;
 b=+cUdR4bb9FAKj9f/4IUP2R/tUuPZM+LqB0IMO5aNFMPM4mX7d13LQVKXc6rmVNnaFYgiGulWk
 PlzGGTIQ9umDJIit7xHV/tS7FtHPUUN0OsO1VqzI/T/ntOXJ8jerbFS
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

From: Shunsuke Nakamura <nakamura.shun@fujitsu.com>

Added overflow test using refresh and period.

Confirmation
 - That the overflow occurs the number of times specified by
   perf_evse__refresh()
 - That the period can be updated by perf_evsel__period()

Committer testing:

  $ sudo make tests -C ./tools/lib/perf V=1
  make: Entering directory '/home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/lib/perf'
  make -f /home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/build/Makefile.build dir=. obj=libperf
  make -C /home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/lib/api/ O= libapi.a
  make -f /home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/build/Makefile.build dir=./fd obj=libapi
  make -f /home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/build/Makefile.build dir=./fs obj=libapi
  make -f /home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/build/Makefile.build dir=. obj=tests
  make -f /home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/build/Makefile.build dir=./tests obj=tests
  running static:
  - running tests/test-cpumap.c...OK
  - running tests/test-threadmap.c...OK
  - running tests/test-evlist.c...

  <SNIP>

  OK
  - running tests/test-evsel.c...

  <SNIP>

          period = 1000000
          overflow limit = 3, overflow count = 3, POLL_IN = 2, POLL_HUP = 1, other signal event = 0
          period = 2000000
          overflow limit = 3, overflow count = 3, POLL_IN = 2, POLL_HUP = 1, other signal event = 0
          period = 1000000
          overflow limit = 3, overflow count = 3, POLL_IN = 2, POLL_HUP = 1, other signal event = 0
          period = 2000000
          overflow limit = 3, overflow count = 3, POLL_IN = 2, POLL_HUP = 1, other signal event = 0
  OK
  running dynamic:
  - running tests/test-cpumap.c...OK
  - running tests/test-threadmap.c...OK
  - running tests/test-evlist.c...

  <SNIP>

  OK
  - running tests/test-evsel.c...

  <SNIP>

          period = 1000000
          overflow limit = 3, overflow count = 3, POLL_IN = 2, POLL_HUP = 1, other signal event = 0
          period = 2000000
          overflow limit = 3, overflow count = 3, POLL_IN = 2, POLL_HUP = 1, other signal event = 0
          period = 1000000
          overflow limit = 3, overflow count = 3, POLL_IN = 2, POLL_HUP = 1, other signal event = 0
          period = 2000000
          overflow limit = 3, overflow count = 3, POLL_IN = 2, POLL_HUP = 1, other signal event = 0
  OK
  make: Leaving directory '/home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/lib/perf'

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/lib/perf/tests/test-evsel.c | 107 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/tools/lib/perf/tests/test-evsel.c b/tools/lib/perf/tests/test-evsel.c
index 545ec3150546..b27dd65f2ec9 100644
--- a/tools/lib/perf/tests/test-evsel.c
+++ b/tools/lib/perf/tests/test-evsel.c
@@ -1,7 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <inttypes.h>
 #include <stdarg.h>
 #include <stdio.h>
 #include <string.h>
+#include <signal.h>
+#include <unistd.h>
+#include <fcntl.h>
 #include <linux/perf_event.h>
 #include <linux/kernel.h>
 #include <perf/cpumap.h>
@@ -11,6 +15,15 @@
 #include <internal/tests.h>
 #include "tests.h"
 
+#define WAIT_COUNT 10000000UL
+static struct signal_counts {
+	int in;
+	int hup;
+	int others;
+	int overflow;
+} sig_count;
+static struct perf_evsel *s_evsel;
+
 static int libperf_print(enum libperf_print_level level,
 			 const char *fmt, va_list ap)
 {
@@ -349,6 +362,98 @@ static int test_stat_read_format(void)
 	return 0;
 }
 
+static void sig_handler(int signo, siginfo_t *info, void *uc)
+{
+	switch (info->si_code) {
+	case POLL_IN:
+		sig_count.in++;
+		break;
+	case POLL_HUP:
+		sig_count.hup++;
+		break;
+	default:
+		sig_count.others++;
+	}
+
+	sig_count.overflow++;
+}
+
+static int test_stat_overflow(int owner)
+{
+	static struct sigaction sig;
+	u64 period = 1000000;
+	int overflow_limit = 3;
+
+	struct perf_thread_map *threads;
+	struct perf_event_attr attr = {
+		.type           = PERF_TYPE_SOFTWARE,
+		.config         = PERF_COUNT_SW_TASK_CLOCK,
+		.sample_type    = PERF_SAMPLE_PERIOD,
+		.sample_period  = period,
+		.disabled       = 1,
+	};
+	struct perf_event_attr *tmp_attr;
+	int err = 0, i;
+
+	LIBPERF_OPTS(perf_evsel_open_opts, opts,
+		     .open_flags = PERF_FLAG_FD_CLOEXEC,
+		     .flags	 = (O_RDWR | O_NONBLOCK | O_ASYNC),
+		     .signal	 = SIGRTMIN + 1,
+		     .owner_type = owner,
+		     .sig	 = &sig);
+
+	/* setup signal handler */
+	memset(&sig, 0, sizeof(struct sigaction));
+	sig.sa_sigaction = (void *)sig_handler;
+	sig.sa_flags = SA_SIGINFO;
+
+	threads = perf_thread_map__new_dummy();
+	__T("failed to create threads", threads);
+
+	perf_thread_map__set_pid(threads, 0, 0);
+
+	s_evsel = perf_evsel__new(&attr);
+	__T("failed to create evsel", s_evsel);
+
+	err = perf_evsel__open_opts(s_evsel, NULL, threads, &opts);
+	__T("failed to open evsel", err == 0);
+
+	for (i = 0; i < 2; i++) {
+		volatile unsigned int wait_count = WAIT_COUNT;
+
+		sig_count.in = 0;
+		sig_count.hup = 0;
+		sig_count.others = 0;
+		sig_count.overflow = 0;
+
+		period = period << i;
+		err = perf_evsel__period(s_evsel, period);
+		__T("failed to period evsel", err == 0);
+
+		tmp_attr = perf_evsel__attr(s_evsel);
+		__T_VERBOSE("\tperiod = %llu\n", tmp_attr->sample_period);
+
+		err = perf_evsel__refresh(s_evsel, overflow_limit);
+		__T("failed to refresh evsel", err == 0);
+
+		while (wait_count--)
+			;
+
+		__T_VERBOSE("\toverflow limit = %d, overflow count = %d, ",
+			    overflow_limit, sig_count.overflow);
+		__T_VERBOSE("POLL_IN = %d, POLL_HUP = %d, other signal event = %d\n",
+			    sig_count.in, sig_count.hup, sig_count.others);
+
+		__T("failed to overflow count", overflow_limit == sig_count.overflow);
+	}
+
+	perf_evsel__close(s_evsel);
+	perf_evsel__delete(s_evsel);
+	perf_thread_map__put(threads);
+
+	return 0;
+}
+
 int test_evsel(int argc, char **argv)
 {
 	__T_START;
@@ -361,6 +466,8 @@ int test_evsel(int argc, char **argv)
 	test_stat_user_read(PERF_COUNT_HW_INSTRUCTIONS);
 	test_stat_user_read(PERF_COUNT_HW_CPU_CYCLES);
 	test_stat_read_format();
+	test_stat_overflow(F_OWNER_PID);
+	test_stat_overflow(F_OWNER_TID);
 
 	__T_END;
 	return tests_failed == 0 ? 0 : -1;

-- 
2.44.0


