Return-Path: <bpf+bounces-34507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0566892DF72
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 07:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED9AA1C21581
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 05:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5EF5A7A0;
	Thu, 11 Jul 2024 05:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IX3Nj+MC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79E07829C
	for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 05:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720675635; cv=none; b=CzqZ24CfwMPNeR+bklJIYlWdVZCvGpKFRJt/F99Hl3tLH8uw7nztyfdPHbT1HW7Vb3trWKaV5c/xsQTYasWQ0lOAcbKMt4/aTj/c73SgCREUG1hWL3PrsbBtLxM99fWhmNFGIguctHvnmLu4nk2sqocEgVPbV6okEet2e3dvYeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720675635; c=relaxed/simple;
	bh=JsTZ6nxT74f2K3DipnCgTWoPFOB9ZdJhXCavJYQrJSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QoqMYfa/suOn4K9dFkZsXWLcPMK2nISbzGorajd+lqMElx33aZVM5ZSCfX2kdb9OgCuIQL85IIlIolBNZ3fwxuW7N2Dkjjgu5pkVdxQgmYV9FXPCHFsKExpaXW7TuNcalO3k7F084tvulrJKS57utjbPnxf/h+rSRydp1+RlLFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IX3Nj+MC; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-a77d876273dso40542466b.0
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 22:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720675631; x=1721280431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UhDm0d65C5vQMEMJp/5novvS5xegeRZHz592L67jIBY=;
        b=IX3Nj+MCQ7zn23D8iezNuUN1Eriq6ETfpPtPSka08fRrs9L3xg5pONNTNY0Qw/bVaQ
         a+8B0BxR/HJJWgNC3egkU32SFkEBENGxbKWFA00PgdJDINwBErrEcQ8o0v3Dj/Gcp5jm
         VW81Ik97lACvKJwR/2WlToviQaA7SPh+8ZNnEGKPv4rtf5QnR5SXoNn8kPQRYA+ChIUm
         IsSD3tlv1z2foZCaGnwc4YdbBm4cVLJHuMDyO5pB45KRgIlfUNTmWxATac3E4YD0C4aQ
         cIEQ2SaBmZzeLzbRj8AOvXAXx3meAzgeBwk+FZ8pQT0GBnNg2gGovO3TteZRSWeH8ZVI
         XRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720675631; x=1721280431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UhDm0d65C5vQMEMJp/5novvS5xegeRZHz592L67jIBY=;
        b=lnaffQCj2TI6x6MH9pjc3HTEF1lsbQwuYewc6oJshsixbbQQPJoWGTETitom5x3TP1
         ujz5TKyKnFHW0JedlvMQt+QqYxKkQnlMtyhxZ5sOL6D2Pu95m4izgby3S1osKlPmpTmL
         tcovkPjwSdipYwWFuwQwHSqNVXQDNNXjlly7dfg9blezKz/dw9+SqZf+yJM2ONnG2xqP
         0vxQHPTHT3fGgbAZh7D+yLUe9ZDzy3xLKLjkcFyKPnDdIqGnuPHKP0OYpnCYU18d65AL
         QkVTxChDdG5POf8KqmGSgIoZSGcdSBrvxlwCy+QBDXCPb92CWxGhpR+y3fMqP0H7cXpb
         K1rg==
X-Gm-Message-State: AOJu0YyE6AkzZu0UkjTqUhfRY7l1zUwupBmz6cGfT+ZhbKcJTKJrLcv6
	hc56zzURJQTZsFvXYWLLBlH5nkuZmkwais8MGCoIjhEuV7GPidF/FkiKmnLa
X-Google-Smtp-Source: AGHT+IFa0gyOgKVnkk9lFLpHAmiJzWfYWD9azuk7BP/Pv2/peexPYX6QE4rejdEj/3g15cg2NBZ2Sg==
X-Received: by 2002:a05:6402:6c6:b0:587:2dd1:4b6c with SMTP id 4fb4d7f45d1cf-594bc7cabe8mr6880581a12.30.1720675631043;
        Wed, 10 Jul 2024 22:27:11 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6dc5e4sm222566066b.48.2024.07.10.22.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 22:27:10 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Dohyun Kim <dohyunkim@google.com>,
	Neel Natu <neelnatu@google.com>,
	Barret Rhoden <brho@google.com>,
	Tejun Heo <htejun@gmail.com>,
	David Vernet <void@manifault.com>
Subject: [PATCH bpf v2] selftests/bpf: Add timer lockup selftest
Date: Thu, 11 Jul 2024 05:27:09 +0000
Message-ID: <20240711052709.2148616-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5618; i=memxor@gmail.com; h=from:subject; bh=JsTZ6nxT74f2K3DipnCgTWoPFOB9ZdJhXCavJYQrJSc=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBmj2wfR8J/PBzq+vDZkv0XletWyVIivtTItxAb8 VY8+yPmwuaJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZo9sHwAKCRBM4MiGSL8R yovEEACzXTtIFKUX52qp3B/MZT4L7O+iiw6eVsK45+zTbLJM5xAaoOC0MOVxk8fTRVvwf7WOb9i 2qPUa/B0Dz7zPAwo992jYcI6W11UGMejgwR+HifZuxFqssraGmuTShQ5QjI47hHxGBkm9HhiEXy CFNbF+YwIncymoMho86oxPXA0EYsPPmZQFdZ6rFpYzLD5LMe2nRlbYB7VgHh7R54B7h8pPlMrHu EHlJbu8XfR5mYmgN2A1kw9CepcN3swAfmO3kVLAYoEZeHoYe+DCgrhpUIYhzn4IMwixKwdZVwz8 Szeca0v+lDaHomkQOpvq+8JMTdKyWFsmkaoV2LPfVyLqyC5OxvrC5jHG5quCvoY8wTA6CkPeX4S ARBbu+8C0dPh1xTAMhMrHN8KJJrQxMhnuo5pR32+5EEs4AyOORg1FlnelItqrYJA3rAURVxdtPz 7JnfoolHjYWrjUC4D9JMAMx57JLXEMQT2M8KpsE1g7yWuzaAHeMBH/duSHcugtOiBDsC8c9LeGJ 8zmQNUU6yUmPjXI7r4WpCXWWkjXwjLOwwTkhzRMyDjJpV3EnQ2Eq44plGesimjGquvP9fI4p3+s rWp65TDViSScuFm8GZqaof8zwb/T6JY55rOlQTF3Md1pkhZwXVea+g+0fx3ksAUjJhgZoJzjkXP R4BOgndYLMaRcvg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add a selftest that tries to trigger a situation where two timer
callbacks are attempting to cancel each other's timer. By running them
continuously, we hit a condition where both run in parallel and cancel
each other. Without the fix in the previous patch, this would cause a
lockup as hrtimer_cancel on either side will wait for forward progress
from the callback.

Ensure that this situation leads to a EDEADLK error.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
Changelog:
 * Add missing timer_lockup__destroy.
 * Fix inline declarations (Alexei).
 * Shorten pthread_create line (Alexei).
 * Fix type of map value parameter to time cb (Alexei).
 * Add a counter to skip test if race does not reproduce (Alexei).
---
 .../selftests/bpf/prog_tests/timer_lockup.c   | 86 ++++++++++++++++++
 .../selftests/bpf/progs/timer_lockup.c        | 87 +++++++++++++++++++
 2 files changed, 173 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/timer_lockup.c
 create mode 100644 tools/testing/selftests/bpf/progs/timer_lockup.c

diff --git a/tools/testing/selftests/bpf/prog_tests/timer_lockup.c b/tools/testing/selftests/bpf/prog_tests/timer_lockup.c
new file mode 100644
index 000000000000..2894fdb7942c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/timer_lockup.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sched.h>
+#include <test_progs.h>
+#include <pthread.h>
+#include <network_helpers.h>
+#include "timer_lockup.skel.h"
+
+static long cpu;
+static int *timer1_err;
+static int *timer2_err;
+static bool skip;
+
+volatile int k = 0;
+static void *timer_lockup_thread(void *arg)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.repeat = 1000,
+	);
+	int prog_fd = *(int *)arg;
+	cpu_set_t cpuset;
+	int i;
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(__sync_fetch_and_add(&cpu, 1), &cpuset);
+	ASSERT_OK(pthread_setaffinity_np(pthread_self(), sizeof(cpuset), &cpuset), "cpu affinity");
+
+	for (i = 0; !READ_ONCE(*timer1_err) && !READ_ONCE(*timer2_err); i++) {
+		bpf_prog_test_run_opts(prog_fd, &opts);
+		/* Skip the test if we can't reproduce the race in a reasonable
+		 * amount of time.
+		 */
+		if (i > 50) {
+			WRITE_ONCE(skip, true);
+			break;
+		}
+	}
+
+	return NULL;
+}
+
+void test_timer_lockup(void)
+{
+	int timer1_prog, timer2_prog;
+	struct timer_lockup *skel;
+	pthread_t thrds[2];
+	void *ret;
+
+	skel = timer_lockup__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "timer_lockup__open_and_load"))
+		return;
+
+	timer1_prog = bpf_program__fd(skel->progs.timer1_prog);
+	timer2_prog = bpf_program__fd(skel->progs.timer2_prog);
+
+	timer1_err = &skel->bss->timer1_err;
+	timer2_err = &skel->bss->timer2_err;
+
+	if (!ASSERT_OK(pthread_create(&thrds[0], NULL, timer_lockup_thread, &timer1_prog),
+		       "pthread_create thread1"))
+		goto out;
+	if (!ASSERT_OK(pthread_create(&thrds[1], NULL, timer_lockup_thread, &timer2_prog),
+		       "pthread_create thread2")) {
+		pthread_exit(&thrds[0]);
+		goto out;
+	}
+
+	pthread_join(thrds[1], &ret);
+	pthread_join(thrds[0], &ret);
+
+	if (skip) {
+		test__skip();
+		goto out;
+	}
+
+	if (*timer1_err != -EDEADLK && *timer1_err != 0)
+		ASSERT_FAIL("timer1_err bad value");
+	if (*timer2_err != -EDEADLK && *timer2_err != 0)
+		ASSERT_FAIL("timer2_err bad value");
+
+out:
+	timer_lockup__destroy(skel);
+	return;
+}
diff --git a/tools/testing/selftests/bpf/progs/timer_lockup.c b/tools/testing/selftests/bpf/progs/timer_lockup.c
new file mode 100644
index 000000000000..ec0629c7151c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/timer_lockup.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <time.h>
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct elem {
+	struct bpf_timer t;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct elem);
+} timer1_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct elem);
+} timer2_map SEC(".maps");
+
+int timer1_err;
+int timer2_err;
+
+static int timer_cb1(void *map, int *k, struct elem *v)
+{
+	struct bpf_timer *timer;
+	int key = 0;
+
+	timer = bpf_map_lookup_elem(&timer2_map, &key);
+	if (timer) {
+		timer2_err = bpf_timer_cancel(timer);
+	}
+	return 0;
+}
+
+static int timer_cb2(void *map, int *k, struct elem *v)
+{
+	struct bpf_timer *timer;
+	int key = 0;
+
+	timer = bpf_map_lookup_elem(&timer1_map, &key);
+	if (timer) {
+		timer1_err = bpf_timer_cancel(timer);
+	}
+	return 0;
+}
+
+SEC("tc")
+int timer1_prog(void *ctx)
+{
+	struct bpf_timer *timer;
+	int key = 0;
+
+	timer = bpf_map_lookup_elem(&timer1_map, &key);
+	if (timer) {
+		bpf_timer_init(timer, &timer1_map, CLOCK_BOOTTIME);
+		bpf_timer_set_callback(timer, timer_cb1);
+		bpf_timer_start(timer, 1, BPF_F_TIMER_CPU_PIN);
+	}
+
+	return 0;
+}
+
+SEC("tc")
+int timer2_prog(void *ctx)
+{
+	struct bpf_timer *timer;
+	int key = 0;
+
+	timer = bpf_map_lookup_elem(&timer2_map, &key);
+	if (timer) {
+		bpf_timer_init(timer, &timer2_map, CLOCK_BOOTTIME);
+		bpf_timer_set_callback(timer, timer_cb2);
+		bpf_timer_start(timer, 1, BPF_F_TIMER_CPU_PIN);
+	}
+
+	return 0;
+}
--
2.43.0


