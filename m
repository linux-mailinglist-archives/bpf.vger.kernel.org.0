Return-Path: <bpf+bounces-76002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5A8CA1F7E
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 00:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4ABA430136E5
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 23:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4C02FB63A;
	Wed,  3 Dec 2025 23:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6jIap+e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE492EC0AD
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 23:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764805080; cv=none; b=AHQAhVu5fnghyddBxWXB3o1e11aa5wNW6xpVW6mUOWEaCJalR4ikNMhM3J0iIa96BUWS0fqwCO+Viwkv6W6vEOgu9nnbmJ6Ugv0erEz9E35K4CQkIOn5Y6bljbBpHmYWqDp4ZRw1+9onEGbsF+rPIf3n/QU66ckDwnnIy48stgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764805080; c=relaxed/simple;
	bh=8NLOqWpy8a/MH0MMPMLfZ6h0+k39D7hvZU/ngyrCqQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQGoUY0iiMu/OGRp6N1xPx+v5Qr1Cix2/2voDv95N4pnN3GfZ/SnKGaggZQ8Z36ltGEh+DowJDax//6y8YMLQucMWfJ3hjxPdrElP8QYtnmwdCGLgqHEyCM/MAgFIUa2vy4YwqEpyasxfrzG3bZUl6Yy/niJg/bNb8QqUqLkezc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6jIap+e; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-340e525487eso179089a91.3
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 15:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764805077; x=1765409877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOAg0Vgw0476GlI1Inqs3Yf2nsrBp/ozmOPyb10gL2M=;
        b=c6jIap+eTgsMowY5Xz7O6fKpWMPZQWp8y5Y50nZnw00YBRnmTGnK1pHEetLiBiqn1U
         aj0CZ65QGKdN0efpekwYNR9mikUiFS/2rHREdFaCOSfKQNs+ow7ygaOG94aionyWxk4d
         nA3DNWiU2sFyv6Rj9PZyCdYydU5ludML79Zsajwepeb26JeyZMSWwrwi9iLnGDixybhf
         mqYuUzEI7pLSKJThhJn8mw+7QOqiNGmT5Pgl3BGUPaCQ7OcNEcnEiaSlaWOrLU0foEeR
         xRj7GIoarPtI6LndYsrAmmVU8Otr7W+ohLYovKtkNioy81vI8EIUoJYIYB4o9CyCM+lV
         ZlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764805077; x=1765409877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eOAg0Vgw0476GlI1Inqs3Yf2nsrBp/ozmOPyb10gL2M=;
        b=wBLUJ4/O4nIQIXUODpBU8DVDtkbM3mWSJkfVHFma3EljfqvHP3tuzICQj8dpdqO+Te
         cNFazaZvqR9TU7xTU5ejEVQEkEhvQ4X6iZtGotF7fmS1YWhA7i+XIbC1a1gyoGYRO+EZ
         OSJwamJH07jsDtOmjReplNImrG5QU9qv5N2HAX5cyVdXkcmThb9LDLNw17ZpMGsGEsdj
         BtvAqbGwhY9kOLHnfpt1wniM7nywaoui4a2bFNyXJrvSLYVst+IICypI6nzk6VCeFuQL
         MDcIcWyLu/BlBIOnvcyv+0g3Miu6+//MgulQi8Z1jZ75YgxkArddMlKrLrxp9qVs25/o
         LXPw==
X-Gm-Message-State: AOJu0YwaSMo66hgUs26e5akHLYu/0oeuhm5WWL19zn/rHcaetuAZnbZu
	4oKoWxpzM7E2ALdEtpeiC1hRLs0xNRSm4DlIv/I7EiC95MuInOP8vLMmOsHadw==
X-Gm-Gg: ASbGncuJERcLudYGxA2Jrw6mh46ra6Clsc21vo11dV+VUf72C9q64FDBXYuV+okFakj
	jDyfF8RXeTZWrCONSL2CwHzkT7iJKrPZwcBxyglrqSBfOSl86AQfB35Iu9wNP+IbCWohTOrDtcl
	PSSZKkBawNl/9QZoSBST/qpx18roZgF228V/m/uY0cpZ6Wu417ZMSuFmdGkPSPpawvqph5+V9Pv
	vAg8HyLwf8RbQW8n56tuSe+bmlckoCFnQNLg6IYamK/Z/FNvAyPadKs4s1+n8aibUZuyhtYw2mV
	fILdql+7b+RgJklKPeNapiafeoapEhBrNQDpYlrfyzDGXo1Al/qbqUwB2LRPWX4N6Cn1U3RiAIu
	LGtkxueCdGau8uhnetxBaAM5vviVfB+CKaWfA0gL7IioJkuje6krr399s64z909jzThiixbN836
	zmAWYhJnyOLn/C
X-Google-Smtp-Source: AGHT+IGiIe5fSv49kIYchgHbKHUlodIWmlai40URoBJmwcLqDlBxcUIBHjpvix1/X37kkdJ4ynyTaQ==
X-Received: by 2002:a17:90b:4b85:b0:349:3fe6:ab97 with SMTP id 98e67ed59e1d1-3493fe6ad75mr1256359a91.22.1764805077212;
        Wed, 03 Dec 2025 15:37:57 -0800 (PST)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3494e84f577sm93288a91.6.2025.12.03.15.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 15:37:56 -0800 (PST)
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
Subject: [PATCH bpf-next v8 6/6] selftests/bpf: Test getting associated struct_ops in timer callback
Date: Wed,  3 Dec 2025 15:37:48 -0800
Message-ID: <20251203233748.668365-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251203233748.668365-1-ameryhung@gmail.com>
References: <20251203233748.668365-1-ameryhung@gmail.com>
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
index 02173504f675..461ded722351 100644
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
+	if (!ASSERT_OK_PTR(skel, "struct_ops_assoc_in_timer__open"))
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
+	if (!ASSERT_OK_PTR(skel, "struct_ops_assoc_in_timer__open"))
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
index 000000000000..d5a2ea934284
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
+	timer_test_1_ret = bpf_kfunc_multi_st_ops_test_1_impl(&args, NULL);
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
+	ret = bpf_kfunc_multi_st_ops_test_1_impl(&args, NULL);
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


