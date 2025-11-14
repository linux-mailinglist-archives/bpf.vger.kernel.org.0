Return-Path: <bpf+bounces-74583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 85832C5F809
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 23:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E031035EF18
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 22:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C421035CB75;
	Fri, 14 Nov 2025 22:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GADDbBDW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13AC3081BA
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 22:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763158674; cv=none; b=FnuPjABDLLAorfJAtSvuc/kFv/mNPFVKQ2mzzg+gRFsrA7ETSUJnIcOXIxJxCBFEg3BFodc0FrOnWHgCc3Wd2JZp/W4LoaGJDX272B7/BgarZ9LpB4aWcRpuarV4E0CKXFpEoAN/LZpWoLh726xwp+Jds/3fHN7R9Gz/UddSMfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763158674; c=relaxed/simple;
	bh=eAzR6OfhG/nKMvSrfLLK+T8VinbPiWt9HkWUfFC2YGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDbmf6ll2Qa9F2dHQRu87acqnGlB2tj2qcJ0Ea08U9RYcd+Bctyy33f1RIy7jZ7NPKN2ZyTJtAhk06axQ8xnw4WBwyYIuTigGjhAAUL9m3jlVi76XtDvHZhHynXvdpqaX6VzShHewFLYKTAB/oqxBLwXbCqYll1c6VIsIH0tmVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GADDbBDW; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso2827670b3a.3
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 14:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763158671; x=1763763471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gZKszhlKtmiGlrkeF64jf+z7a8MZgR3nm4zhRfB1nM=;
        b=GADDbBDW5NzofQYrNK7WnxgceBoOQhfSS/rC7zYCLddbAjCrYpnZ4AhsI0/4T0S0bZ
         lWdEO+bk/70vFPqXuWaoyaTO9cImimC2IbRdCpK56VAmAUR2HSPfPQSs42sdA5GtYq+J
         yMhw0GCAWj+Jg61SqIPNYxqFX8atEhtyzj+spaJDHkqG5FhuaRb+DkQT7h/2MEwiezH2
         yk0MstHTAfMWkN5QiEy76EsBvFIjS3iwz+XyfJx2SU8CnJrPnvjidGrLPovtu5m+A4km
         yQDMSdwJU5LAd/ErOOdO05g6qZ8dnC+WXBeDa9E4G9CkOIFji8e0Ey2lL1P77DVneR2Q
         5SwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763158671; x=1763763471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3gZKszhlKtmiGlrkeF64jf+z7a8MZgR3nm4zhRfB1nM=;
        b=GTbgNv6J/KX2nRDDoHv48VedIjWnqhXAeJipzEltotIGLatAfQvjsTkCsiDjVJtR38
         djjJUn6eDRTh57u+o6mKbcKkUYPDB4M0PjfX6bFcwSdDgX+Xxezgeao5ITGLO4V4QROg
         PsBX57ZsZfn/rrBqPoFj7SqBSlSsZY7LG+nmrCJW3DZj8DtBJkhlfgHBom0pUY9p8p+M
         GBWkV4bWHNW9Lswtc42y0kTvsBCMftWCkoa5na5cwL33uDTa26BeNz0im8OE9kMeS1fE
         A1QFhAmAMY0JP/KyJT6eaVYeIiNF6TYHmb0dL2IK+wy08YgAJn1Ddj/4RRFgdFoDqXYB
         +vaQ==
X-Gm-Message-State: AOJu0YyBT0pGi+gCBH7aW7yCz47Or0uv0+WoMg2CbHsCGADkTlj0XFFe
	GUIFdtiID2AxgUyKJxU2TYjYQk8bMCeyM1pcRA6gpEnacw8IuRcpv6KPn0bGLg==
X-Gm-Gg: ASbGncsND27mIhcF/2r+AyHRX6QcHefkNCwa1z0+m48oL9eR2WYsgif2eV8OsHaNKi6
	/m63+fr/aV12QTv/n+HRJGN17YrfRPnDoXoJoBzevcozLTnucJ4AMjZS4MlrEnGMp4pKb6iHJv8
	yIDBO2LHRI8/tG1Q0ZoQq27u52VN3nOJgyqsAOAe1jPWx0ojMB880hcM5M5kydWnAuSpgyMUagY
	RuOTG0/pw9RAFuV7e62Mi5Ggg56iMQg9Q37/GTL9uDY+N/RVwtHkIVTPhpl8aaF2kXgtnIddXgD
	IsrfLD8qqI3llpkp39tPmKgieSpcU+fzDHi37kngH0L5zKdCLHMcgp5/JAt6LlAWHFsuio6yRjE
	1YBopf4960IjzexEJXIvIH6EL3j0SNJ9zwtR6lT1GqNIiWgZEJUGsrOVUBz6T2K4PpiJ2fzrlNF
	xw8g==
X-Google-Smtp-Source: AGHT+IG9wWL6lqEYB7UBlbg9LN9TJyfr0tOzNiC+rSDOYMa4+tQoCcSEimXGm5X0HBhL6XSyo0Qo/Q==
X-Received: by 2002:a05:6a00:80f:b0:781:1b5a:95b2 with SMTP id d2e1a72fcca58-7ba3c275690mr6273239b3a.28.1763158669446;
        Fri, 14 Nov 2025 14:17:49 -0800 (PST)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924aed60bsm6253136b3a.4.2025.11.14.14.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 14:17:49 -0800 (PST)
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
Subject: [PATCH bpf-next v6 6/6] selftests/bpf: Test getting associated struct_ops in timer callback
Date: Fri, 14 Nov 2025 14:17:41 -0800
Message-ID: <20251114221741.317631-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114221741.317631-1-ameryhung@gmail.com>
References: <20251114221741.317631-1-ameryhung@gmail.com>
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
 .../bpf/prog_tests/test_struct_ops_assoc.c    | 81 +++++++++++++++++++
 .../bpf/progs/struct_ops_assoc_in_timer.c     | 77 ++++++++++++++++++
 2 files changed, 158 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
index f69306cb8974..e09436442d07 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
@@ -3,6 +3,7 @@
 #include <test_progs.h>
 #include "struct_ops_assoc.skel.h"
 #include "struct_ops_assoc_reuse.skel.h"
+#include "struct_ops_assoc_in_timer.skel.h"
 
 static void test_st_ops_assoc(void)
 {
@@ -101,10 +102,90 @@ static void test_st_ops_assoc_reuse(void)
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
+	/* Detach and close struct_ops map to cause it to be freed */
+	bpf_link__destroy(link);
+	close(bpf_program__fd(skel->progs.syscall_prog));
+	close(bpf_map__fd(skel->maps.st_ops_map));
+
+	/* Check the return of the kfunc after timer_cb runs */
+	while (!READ_ONCE(skel->bss->timer_cb_run))
+		sched_yield();
+	ASSERT_EQ(skel->bss->timer_test_1_ret, -1, "skel->bss->timer_test_1_ret");
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


