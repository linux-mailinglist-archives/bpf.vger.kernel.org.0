Return-Path: <bpf+bounces-73473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE524C325A7
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 18:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B750189CA17
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 17:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4355933CEAE;
	Tue,  4 Nov 2025 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsjxyWCy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E03133BBD5
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 17:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277225; cv=none; b=SnI88eD6SGlS3+WhtS6c1xhLg2ElpXU2J/N1Onycf9ELLCK8RvUR4PRQP9ZlaAFmV+uByTYS32DnAJbOEFtDEsR/bILGjrBmpxvCLARHA7Ptc1/qj6/FzZLjzeRZPXPwCRIUgiN5OXSQ+nwqFt8UmdXbKuW5avJJj7iF+esuJjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277225; c=relaxed/simple;
	bh=Ukmat4iodYlriSv1+mz7+gNn16Z0QLkY99DSDy0qnb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyViIJiQFoTu9Dj5Zf2KphxcjQCn8+oY38cVB9NUJqbNaHG+hMhDPf9WNqPwMykKy0Kxnw2Ue2lHKaDFwn+Cqq0ZgFIazPUVeQRGaIj/3j9iWO6avOBknW0aSnSRdnCh4mTWMMOoqEg+zqVVhXZoOMGzAWhb9ljNyEP6c53oTZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsjxyWCy; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7aca3e4f575so1393934b3a.2
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 09:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762277223; x=1762882023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HsFCuKGr8g/ehZwxV4iu/c9RB/skJFIi88iS2PlZx4=;
        b=DsjxyWCyVl+t/WNkrfupy0rAlUvGngPnulu6c3lSL4GatJGz3SrtAfY1r4BPJ5bYiE
         M+VSALx+jx3/3gcxOlnAp5/7UgadympiU3N1bVcOvTfeccwulbb+7aWwbv+37oon4M8X
         Fezsf7bZfU117ZVRfh0tsjqGf3Jw6fkxoyBuWguYtuK1r3qxnk2FwmNZrVKhFohENThO
         ROnMCQydHBBvxa9k+f0Slaqu1tthH0mGMvpNjrkSGIq71baggmbI2ebQ9nR+wRO6rWyi
         P5bhuzolVlfIPHyXYV94lbMiChdG5VkyQnalCsxmiC2jGcsedpywJzfS67i1olYcv/B8
         GUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762277223; x=1762882023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6HsFCuKGr8g/ehZwxV4iu/c9RB/skJFIi88iS2PlZx4=;
        b=reEPj9S1jw8cyUVGzHNVBk8lBL6l4nXpV+z3g86NluNjxtrDHdkP2l/q7JKO5MFrzT
         JBfURBs9YQkH3uB+MPOm0Oy2Wea6mfb6LcaH5mm41qIJVwbX8UfXExkXdoBaHEaAIO2U
         knkZfrJZJowONsRFhMEAk5egOKsuRJ0szgTwPr9KastZldLfhKVv0i8JwB0I+wfWSO+S
         CWouPgS+U0Jzd4vuliBTj0HvDh84B79Ex+/z+TZsSDRHSFLO2ZTBTXWylIj0aoZ+sZfi
         nyklGy005B87pXitQD/06srulve6c+1GPdWDr6+u8V/QpF6i2q8oVpWx8l+66RWRsyMd
         m7Ww==
X-Gm-Message-State: AOJu0YwEq8eYGGnks+L8URdfmz+7/6/y3t18D/kLVjfP4xkKd+KxRLg7
	PoE2sDbGWjjiKAjAP87QdnZJWyNpHgfbMX8vACENl+yXkqcvEPv6gazebbK2Rw==
X-Gm-Gg: ASbGnctwhhYN1OgRENcduyLKhKLi+Y2z+4BE7CTflxOyOJEJV9w8tW9U4VoNBxx+kP1
	EFGtczL+FUI5ShYQhHb4CrCzcT5Ukfk8jMPnVuriiELA0DgugpSAbi3Js4bEJp1hwWWT+GNWvYN
	wbjsKWR0E7hDFAb9mmYbIQxWyEGb998YtxygPJzODyThiE3lLCfQSi6VJZQbkJG9yq3PSfO6Q9d
	LBtBIjtIR4p4hFKe8qyUryC/cBaySuarPZ8D96EynW29STf4JAjm6yHicqa7QSsKGHfNRda8I5f
	zu76ZdaLj9mLRUu9+kvCeiNx4rKpV/4yg24tDrd9xXxs7A1nmcz3WvFAY6ou3rdagoxXZqmZCp+
	+mZSoXDFtb/RGRAY9hBir8cQ34Zjc/OlWIRqbOwTd7xgkJ1Br8ZF4QcQdfdc3uJcLbGI=
X-Google-Smtp-Source: AGHT+IHV81E//XicfZmJg8CpFFLC0AoyaEq9aXi84kDyzKh4oLDQzJFzg7shyH8yIP1tvuecdikSow==
X-Received: by 2002:a05:6a00:10d0:b0:7ab:e007:dedc with SMTP id d2e1a72fcca58-7ae1f8811b3mr32374b3a.23.1762277223142;
        Tue, 04 Nov 2025 09:27:03 -0800 (PST)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd586bf62sm3612937b3a.48.2025.11.04.09.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 09:27:02 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 7/7] selftests/bpf: Test getting associated struct_ops in timer callback
Date: Tue,  4 Nov 2025 09:26:52 -0800
Message-ID: <20251104172652.1746988-8-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251104172652.1746988-1-ameryhung@gmail.com>
References: <20251104172652.1746988-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure 1) a timer callback can also reference the associated
struct_ops, and then make sure 2) the timer callback cannot get a
dangled pointer to the struct_ops when the map is freed.

The test schedules a timer callback from a struct_ops program since
struct_ops programs do not pin the map. It is possible for the timer
callback to run after the map is freed. The timer callback calls a
kfunc that runs .test_1() of the associated struct_ops, which should
return MAP_MAGIC when the map is still alive or -1 when the map is
gone.

The first subtest added in this patch schedules the timer callback to
run immediately, while the map is still alive. The second subtest added
schedules the callback to run 500ms after syscall_prog runs and then
frees the map right after syscall_prog runs. Both subtests then wait
until the callback runs to check the return of the kfunc.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_assoc.c    | 84 +++++++++++++++++++
 .../bpf/progs/struct_ops_assoc_in_timer.c     | 77 +++++++++++++++++
 2 files changed, 161 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
index f69306cb8974..902d210a3551 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
@@ -3,6 +3,7 @@
 #include <test_progs.h>
 #include "struct_ops_assoc.skel.h"
 #include "struct_ops_assoc_reuse.skel.h"
+#include "struct_ops_assoc_in_timer.skel.h"
 
 static void test_st_ops_assoc(void)
 {
@@ -101,10 +102,93 @@ static void test_st_ops_assoc_reuse(void)
 	struct_ops_assoc_reuse__destroy(skel);
 }
 
+static void test_st_ops_assoc_in_timer(void)
+{
+	struct struct_ops_assoc_in_timer *skel = NULL;
+	int err;
+
+	skel = struct_ops_assoc_in_timer__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_assoc_reuse__open"))
+		goto out;
+
+	err = bpf_program__assoc_struct_ops(skel->progs.syscall_prog,
+					    skel->maps.st_ops_map, NULL);
+	ASSERT_OK(err, "bpf_program__assoc_struct_ops");
+
+	err = struct_ops_assoc_in_timer__attach(skel);
+	if (!ASSERT_OK(err, "struct_ops_assoc__attach"))
+		goto out;
+
+	/*
+	 * Run .test_1 by calling kfunc bpf_kfunc_multi_st_ops_test_1_prog_arg() and checks
+	 * the return value. .test_1 will also schedule timer_cb that runs .test_1 again
+	 * immediately.
+	 */
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.syscall_prog), NULL);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+
+	/* Check the return of the kfunc after timer_cb runs */
+	while (!READ_ONCE(skel->bss->timer_cb_run))
+		sched_yield();
+	ASSERT_EQ(skel->bss->timer_test_1_ret, 1234, "skel->bss->timer_test_1_ret");
+	ASSERT_EQ(skel->bss->test_err, 0, "skel->bss->test_err_a");
+out:
+	struct_ops_assoc_in_timer__destroy(skel);
+}
+
+static void test_st_ops_assoc_in_timer_no_uref(void)
+{
+	struct struct_ops_assoc_in_timer *skel = NULL;
+	struct bpf_link *link;
+	int err;
+
+	skel = struct_ops_assoc_in_timer__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_assoc_reuse__open"))
+		goto out;
+
+	err = bpf_program__assoc_struct_ops(skel->progs.syscall_prog,
+					    skel->maps.st_ops_map, NULL);
+	ASSERT_OK(err, "bpf_program__assoc_struct_ops");
+
+	link = bpf_map__attach_struct_ops(skel->maps.st_ops_map);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops"))
+		goto out;
+
+	/*
+	 * Run .test_1 by calling kfunc bpf_kfunc_multi_st_ops_test_1_prog_arg() and checks
+	 * the return value. .test_1 will also schedule timer_cb that runs .test_1 again.
+	 * timer_cb will run 500ms after syscall_prog runs, when the user space no longer
+	 * holds a reference to st_ops_map.
+	 */
+	skel->bss->timer_ns = 500000000;
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.syscall_prog), NULL);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+
+	/*
+	 * Detach and close struct_ops map. timer_cb holding a reference to the map should
+	 * prevent it from being freed.
+	 */
+	bpf_link__destroy(link);
+	close(bpf_program__fd(skel->progs.syscall_prog));
+	close(bpf_map__fd(skel->maps.st_ops_map));
+
+	/* Check the return of the kfunc after timer_cb runs */
+	while (!READ_ONCE(skel->bss->timer_cb_run))
+		sched_yield();
+	ASSERT_EQ(skel->bss->timer_test_1_ret, 1234, "skel->bss->timer_test_1_ret");
+	ASSERT_EQ(skel->bss->test_err, 0, "skel->bss->test_err_a");
+out:
+	struct_ops_assoc_in_timer__destroy(skel);
+}
+
 void test_struct_ops_assoc(void)
 {
 	if (test__start_subtest("st_ops_assoc"))
 		test_st_ops_assoc();
 	if (test__start_subtest("st_ops_assoc_reuse"))
 		test_st_ops_assoc_reuse();
+	if (test__start_subtest("st_ops_assoc_in_timer"))
+		test_st_ops_assoc_in_timer();
+	if (test__start_subtest("st_ops_assoc_in_timer_no_uref"))
+		test_st_ops_assoc_in_timer_no_uref();
 }
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c b/tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c
new file mode 100644
index 000000000000..9d4e427568b2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct elem {
+	struct bpf_timer timer;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct elem);
+} array_map SEC(".maps");
+
+#define MAP_MAGIC 1234
+int recur;
+int test_err;
+int timer_ns;
+int timer_test_1_ret;
+int timer_cb_run;
+
+__noinline static int timer_cb(void *map, int *key, struct bpf_timer *timer)
+{
+	struct st_ops_args args = {};
+
+	recur++;
+	timer_test_1_ret = bpf_kfunc_multi_st_ops_test_1_prog_arg(&args, NULL);
+	recur--;
+
+	timer_cb_run++;
+
+	return 0;
+}
+
+SEC("struct_ops")
+int BPF_PROG(test_1, struct st_ops_args *args)
+{
+	struct bpf_timer *timer;
+	int key = 0;
+
+	if (!recur) {
+		timer = bpf_map_lookup_elem(&array_map, &key);
+		if (!timer)
+			return 0;
+
+		bpf_timer_init(timer, &array_map, 1);
+		bpf_timer_set_callback(timer, timer_cb);
+		bpf_timer_start(timer, timer_ns, 0);
+	}
+
+	return MAP_MAGIC;
+}
+
+SEC("syscall")
+int syscall_prog(void *ctx)
+{
+	struct st_ops_args args = {};
+	int ret;
+
+	ret = bpf_kfunc_multi_st_ops_test_1_prog_arg(&args, NULL);
+	if (ret != MAP_MAGIC)
+		test_err++;
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_multi_st_ops st_ops_map = {
+	.test_1 = (void *)test_1,
+};
-- 
2.47.3


