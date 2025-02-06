Return-Path: <bpf+bounces-50660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAA8A2A697
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 12:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26CA0188620F
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 11:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A6623312B;
	Thu,  6 Feb 2025 10:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2pLSIy/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6EA233D91;
	Thu,  6 Feb 2025 10:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839317; cv=none; b=ZF+s7ZlDbIfSMkTqh53IYowkl+QApPn3dMZZhWJOUthWmo/kWVC7GBeGRB7Pjbcp+pOxDSJLSw/i94rQ6w5tdWRIZNH89taRivvu4krLbMn2R6M8eA+wKea4V4DKeYBkv+UetSNabuIVXukRw8UMFz28UgH3MVRE1GJ1ddzrDVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839317; c=relaxed/simple;
	bh=T/KW/xDA8UwHhiAJo3V+JzDoebizVQBXrYloT3/u9JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ne1hKwAfwR0meYgz9z7D2Mmhw9SObYc4vuJayi7AJP0KPBACg8DrG3ZGxtteJZf0pTAWwxpuiyCfQqMs3Kzo4gvnSx/ASAuMNFWciHu/8iLw5+miVLfoQ6DEywVhiE/BzZvJ4IRpQ1k7zZtcmo6hhb4fznVAZAZ+DFxZtmdYXWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2pLSIy/; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-436249df846so4628725e9.3;
        Thu, 06 Feb 2025 02:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738839313; x=1739444113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XI5mR9awotpFmMGmD6PyGcm5Yi9TOUmCSpGD+JUgaXI=;
        b=Y2pLSIy/yIvGmi+QmX5ue8cDuzNtvBDEH2Y0IMzeHWbP0UrM6NGYnFP5bDmuJIisRY
         pFZFmH1FTjZbHYP6c3B6BNWM7gjnYGiEqOsZtYuvWmC54vsmV/n6JB93QEVrOjm60eaT
         ktxyJhnfwXRYn53SPSIoGI71xUXAolzDsBRuO4dZyM8qN6QzXaleqa17xDFklRuI9g5B
         Yr7RfMJT7oDpm9oQPm8xY4CYzBXWIztpfLvrvw5d/Ef5pJc83OBggS9PhmP1Lw/qjOfj
         DiEM8r1Y13iGB4BP9RmvP/PR3XSYLb00bZeA2xsNhTpojinQmkrkckiq3XOa01RvGybZ
         1YMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839313; x=1739444113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XI5mR9awotpFmMGmD6PyGcm5Yi9TOUmCSpGD+JUgaXI=;
        b=jxqky431f5srgqDsSty5NcoNYfu5VcHhsZL4qE1/T0TwzFjG2jgy6jOh6FygaQ+cBt
         OOzaJ2u1WDb4OhSYmtbNxIXmq3jsSR2lSXfy2T69+mgJkVfxiRnauL3RrbSveAkcdKvi
         q3TDCjg+LWf6XRBkYDJXUczlMAdDZbwtpQDSGqOufa6byqv0DdMl63jIdnAiRedywGSj
         1bDSp8zjfaLkH7joIcQ6/bYbMUL34jEfeKVY5Vej65TMQTlIvw0nTOhRW+p5lYrBMnhY
         nh60BNYAlNNWcspKjf6klC13rUBTOVSJha3fe5LCxWxGfcUv70XtMr8zb9pHxQSmnOQD
         HAfw==
X-Forwarded-Encrypted: i=1; AJvYcCWd7af2xupI1JVwz+zCysqwKfevAMKbzL3NnnbrdjYATGtoPa0d+0b2cbFkH2rGBdpxoELYBmJDm4FrZMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdcXuYO7K1VgdthTt6tQrwsqqetrM2JpMNWPtMsAWOmKhYwF4f
	tAdTpOvGsWh7Z+FINlpgo7ZLzs7oV8N3OcsZ8ZXeHixHLNfuIirIm7SXnQTs8Nw=
X-Gm-Gg: ASbGncv7dWvuNROvIxwY0jVRSvyPhcxMATaXi6JfP/xXiah/IKpRGv+OHKq2LZyLT/K
	UIA1LJtYny7hg+JT8V+2bHpRZqb5ati4arUz4OrK/MFE+5/8R/aYD3QuAHBmy+EGhfrwGXOKbPX
	o7A8tvZKLd6raud3OY/ROBGc6wyRv5cp8g4gmm5WWncTOPIgtkt9pojJVfBlUtMlSyMw1RUQJQw
	zwbn7UekmyE7OZWIPAk8MFQDcB0s/FNSMq9B96F+0koEuKcvwTQ0tc8xHVS5bCjJ44RqZC2Dlaz
	m353yA==
X-Google-Smtp-Source: AGHT+IHxQpWySsSSj+am/9movA5RR05zhmTuyQQ7kRFsu9/Thv/ZrVIRrKuBYgF71sqgdttaSpcNlA==
X-Received: by 2002:a05:600c:1d01:b0:434:f335:855 with SMTP id 5b1f17b1804b1-4390d5a3b1amr46396125e9.28.1738839312912;
        Thu, 06 Feb 2025 02:55:12 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:1e::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d9334e7sm50903345e9.6.2025.02.06.02.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 02:55:12 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	linux-arm-kernel@lists.infradead.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 26/26] selftests/bpf: Add tests for rqspinlock
Date: Thu,  6 Feb 2025 02:54:34 -0800
Message-ID: <20250206105435.2159977-27-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250206105435.2159977-1-memxor@gmail.com>
References: <20250206105435.2159977-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15931; h=from:subject; bh=T/KW/xDA8UwHhiAJo3V+JzDoebizVQBXrYloT3/u9JY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnpJRnrlHnn/tBJ6oJ5t/DtGyjE2XhsWglV3leICP3 GP9uxzCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ6SUZwAKCRBM4MiGSL8RygPCEA C9S+AZeaRDMKdILDKrL+7frf+PUkXKd4iu4zWS7lzhMl7sqS4Nh9t1j2+axKLBCR5GW16UadRkev9l 4AqI35PX5zJhmHuS98mojbAK0CpS2CGHXnEXEpFuaCyNsa1YcLtCp8cDsiMtko27s7eQKM+0JRXgV+ AHn3SqCKzv/56wYO8tQGN0xPhYGQyIQ358ZD+GyyR3NdWiQb7vmIK5qkZqGMpNOL1HQvR8gRQR6ptA 1PW4+UutQskXBQHy4BPCv1jc6WKr+5Dd2aa0c1PBdcGQ7fUZs9/wTKkNT+FDdNx7MlEYXg8Woa9RaX 14OIHH8WAYCA+BnP1Y20WdBptw0RU82vmXwQ5iwUyfjNyUeysFqk1dyT4ly8Wbg5CV4CXoBTsnyN6Y Sx5LJXb4UWDkzQm5GxqC7CXVXeFuV7ziqEu7dPwt7sqeT/WA9HEesT7Sc7e8S5gWuSULdoaCcKXMMz TxZWf652+WNHPkKtVodaoP4JvTJc8Vy2F+Li5/I7kMaVt2ZkqX18Qvf/4YXl2tJ/gWb6R9YYamNkwq EMJZ+zkvqv4Il+pSYLhiaoVY+mwAId1+LWNwv6b8UDTr5yVtRGYkxuTFGQWj7zgc3fxNJAX/9H6jHi OlLJLdnUrJZafds/4uVLPPoZVywAm415gF0IkMsXK0ujQlvIw6wx9VqTeeog==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Introduce selftests that trigger AA, ABBA deadlocks, and test the edge
case where the held locks table runs out of entries, since we then
fallback to the timeout as the final line of defense. Also exercise
verifier's AA detection where applicable.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/res_spin_lock.c  |  99 +++++++
 tools/testing/selftests/bpf/progs/irq.c       |  53 ++++
 .../selftests/bpf/progs/res_spin_lock.c       | 143 ++++++++++
 .../selftests/bpf/progs/res_spin_lock_fail.c  | 244 ++++++++++++++++++
 4 files changed, 539 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/res_spin_lock.c
 create mode 100644 tools/testing/selftests/bpf/progs/res_spin_lock.c
 create mode 100644 tools/testing/selftests/bpf/progs/res_spin_lock_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/res_spin_lock.c b/tools/testing/selftests/bpf/prog_tests/res_spin_lock.c
new file mode 100644
index 000000000000..5a46b3e4a842
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/res_spin_lock.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <network_helpers.h>
+
+#include "res_spin_lock.skel.h"
+#include "res_spin_lock_fail.skel.h"
+
+static void test_res_spin_lock_failure(void)
+{
+	RUN_TESTS(res_spin_lock_fail);
+}
+
+static volatile int skip;
+
+static void *spin_lock_thread(void *arg)
+{
+	int err, prog_fd = *(u32 *) arg;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.repeat = 10000,
+	);
+
+	while (!READ_ONCE(skip)) {
+		err = bpf_prog_test_run_opts(prog_fd, &topts);
+		ASSERT_OK(err, "test_run");
+		ASSERT_OK(topts.retval, "test_run retval");
+	}
+	pthread_exit(arg);
+}
+
+static void test_res_spin_lock_success(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.repeat = 1,
+	);
+	struct res_spin_lock *skel;
+	pthread_t thread_id[16];
+	int prog_fd, i, err;
+	void *ret;
+
+	skel = res_spin_lock__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "res_spin_lock__open_and_load"))
+		return;
+	/* AA deadlock */
+	prog_fd = bpf_program__fd(skel->progs.res_spin_lock_test);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "error");
+	ASSERT_OK(topts.retval, "retval");
+
+	prog_fd = bpf_program__fd(skel->progs.res_spin_lock_test_held_lock_max);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "error");
+	ASSERT_OK(topts.retval, "retval");
+
+	/* Multi-threaded ABBA deadlock. */
+
+	prog_fd = bpf_program__fd(skel->progs.res_spin_lock_test_AB);
+	for (i = 0; i < 16; i++) {
+		int err;
+
+		err = pthread_create(&thread_id[i], NULL, &spin_lock_thread, &prog_fd);
+		if (!ASSERT_OK(err, "pthread_create"))
+			goto end;
+	}
+
+	topts.repeat = 1000;
+	int fd = bpf_program__fd(skel->progs.res_spin_lock_test_BA);
+	while (!topts.retval && !err && !READ_ONCE(skel->bss->err)) {
+		err = bpf_prog_test_run_opts(fd, &topts);
+	}
+
+	WRITE_ONCE(skip, true);
+
+	for (i = 0; i < 16; i++) {
+		if (!ASSERT_OK(pthread_join(thread_id[i], &ret), "pthread_join"))
+			goto end;
+		if (!ASSERT_EQ(ret, &prog_fd, "ret == prog_fd"))
+			goto end;
+	}
+
+	ASSERT_EQ(READ_ONCE(skel->bss->err), -EDEADLK, "timeout err");
+	ASSERT_OK(err, "err");
+	ASSERT_EQ(topts.retval, -EDEADLK, "timeout");
+end:
+	res_spin_lock__destroy(skel);
+	return;
+}
+
+void test_res_spin_lock(void)
+{
+	if (test__start_subtest("res_spin_lock_success"))
+		test_res_spin_lock_success();
+	if (test__start_subtest("res_spin_lock_failure"))
+		test_res_spin_lock_failure();
+}
diff --git a/tools/testing/selftests/bpf/progs/irq.c b/tools/testing/selftests/bpf/progs/irq.c
index b0b53d980964..3d4fee83a5be 100644
--- a/tools/testing/selftests/bpf/progs/irq.c
+++ b/tools/testing/selftests/bpf/progs/irq.c
@@ -11,6 +11,9 @@ extern void bpf_local_irq_save(unsigned long *) __weak __ksym;
 extern void bpf_local_irq_restore(unsigned long *) __weak __ksym;
 extern int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void *unsafe_ptr__ign, u64 flags) __weak __ksym;
 
+struct bpf_res_spin_lock lockA __hidden SEC(".data.A");
+struct bpf_res_spin_lock lockB __hidden SEC(".data.B");
+
 SEC("?tc")
 __failure __msg("arg#0 doesn't point to an irq flag on stack")
 int irq_save_bad_arg(struct __sk_buff *ctx)
@@ -441,4 +444,54 @@ int irq_ooo_refs_array(struct __sk_buff *ctx)
 	return 0;
 }
 
+SEC("?tc")
+__failure __msg("cannot restore irq state out of order")
+int irq_ooo_lock_cond_inv(struct __sk_buff *ctx)
+{
+	unsigned long flags1, flags2;
+
+	if (bpf_res_spin_lock_irqsave(&lockA, &flags1))
+		return 0;
+	if (bpf_res_spin_lock_irqsave(&lockB, &flags2)) {
+		bpf_res_spin_unlock_irqrestore(&lockA, &flags1);
+		return 0;
+	}
+
+	bpf_res_spin_unlock_irqrestore(&lockB, &flags1);
+	bpf_res_spin_unlock_irqrestore(&lockA, &flags2);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("function calls are not allowed")
+int irq_wrong_kfunc_class_1(struct __sk_buff *ctx)
+{
+	unsigned long flags1;
+
+	if (bpf_res_spin_lock_irqsave(&lockA, &flags1))
+		return 0;
+	/* For now, bpf_local_irq_restore is not allowed in critical section,
+	 * but this test ensures error will be caught with kfunc_class when it's
+	 * opened up. Tested by temporarily permitting this kfunc in critical
+	 * section.
+	 */
+	bpf_local_irq_restore(&flags1);
+	bpf_res_spin_unlock_irqrestore(&lockA, &flags1);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("function calls are not allowed")
+int irq_wrong_kfunc_class_2(struct __sk_buff *ctx)
+{
+	unsigned long flags1, flags2;
+
+	bpf_local_irq_save(&flags1);
+	if (bpf_res_spin_lock_irqsave(&lockA, &flags2))
+		return 0;
+	bpf_local_irq_restore(&flags2);
+	bpf_res_spin_unlock_irqrestore(&lockA, &flags1);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/res_spin_lock.c b/tools/testing/selftests/bpf/progs/res_spin_lock.c
new file mode 100644
index 000000000000..f68aa2ccccc2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/res_spin_lock.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#define EDEADLK 35
+#define ETIMEDOUT 110
+
+struct arr_elem {
+	struct bpf_res_spin_lock lock;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 64);
+	__type(key, int);
+	__type(value, struct arr_elem);
+} arrmap SEC(".maps");
+
+struct bpf_res_spin_lock lockA __hidden SEC(".data.A");
+struct bpf_res_spin_lock lockB __hidden SEC(".data.B");
+
+SEC("tc")
+int res_spin_lock_test(struct __sk_buff *ctx)
+{
+	struct arr_elem *elem1, *elem2;
+	int r;
+
+	elem1 = bpf_map_lookup_elem(&arrmap, &(int){0});
+	if (!elem1)
+		return -1;
+	elem2 = bpf_map_lookup_elem(&arrmap, &(int){0});
+	if (!elem2)
+		return -1;
+
+	r = bpf_res_spin_lock(&elem1->lock);
+	if (r)
+		return r;
+	if (!bpf_res_spin_lock(&elem2->lock)) {
+		bpf_res_spin_unlock(&elem2->lock);
+		bpf_res_spin_unlock(&elem1->lock);
+		return -1;
+	}
+	bpf_res_spin_unlock(&elem1->lock);
+	return 0;
+}
+
+SEC("tc")
+int res_spin_lock_test_AB(struct __sk_buff *ctx)
+{
+	int r;
+
+	r = bpf_res_spin_lock(&lockA);
+	if (r)
+		return !r;
+	/* Only unlock if we took the lock. */
+	if (!bpf_res_spin_lock(&lockB))
+		bpf_res_spin_unlock(&lockB);
+	bpf_res_spin_unlock(&lockA);
+	return 0;
+}
+
+int err;
+
+SEC("tc")
+int res_spin_lock_test_BA(struct __sk_buff *ctx)
+{
+	int r;
+
+	r = bpf_res_spin_lock(&lockB);
+	if (r)
+		return !r;
+	if (!bpf_res_spin_lock(&lockA))
+		bpf_res_spin_unlock(&lockA);
+	else
+		err = -EDEADLK;
+	bpf_res_spin_unlock(&lockB);
+	return err ?: 0;
+}
+
+SEC("tc")
+int res_spin_lock_test_held_lock_max(struct __sk_buff *ctx)
+{
+	struct bpf_res_spin_lock *locks[48] = {};
+	struct arr_elem *e;
+	u64 time_beg, time;
+	int ret = 0, i;
+
+	_Static_assert(ARRAY_SIZE(((struct rqspinlock_held){}).locks) == 32,
+		       "RES_NR_HELD assumed to be 32");
+
+	for (i = 0; i < 34; i++) {
+		int key = i;
+
+		/* We cannot pass in i as it will get spilled/filled by the compiler and
+		 * loses bounds in verifier state.
+		 */
+		e = bpf_map_lookup_elem(&arrmap, &key);
+		if (!e)
+			return 1;
+		locks[i] = &e->lock;
+	}
+
+	for (; i < 48; i++) {
+		int key = i - 2;
+
+		/* We cannot pass in i as it will get spilled/filled by the compiler and
+		 * loses bounds in verifier state.
+		 */
+		e = bpf_map_lookup_elem(&arrmap, &key);
+		if (!e)
+			return 1;
+		locks[i] = &e->lock;
+	}
+
+	time_beg = bpf_ktime_get_ns();
+	for (i = 0; i < 34; i++) {
+		if (bpf_res_spin_lock(locks[i]))
+			goto end;
+	}
+
+	/* Trigger AA, after exhausting entries in the held lock table. This
+	 * time, only the timeout can save us, as AA detection won't succeed.
+	 */
+	if (!bpf_res_spin_lock(locks[34])) {
+		bpf_res_spin_unlock(locks[34]);
+		ret = 1;
+		goto end;
+	}
+
+end:
+	for (i = i - 1; i >= 0; i--)
+		bpf_res_spin_unlock(locks[i]);
+	time = bpf_ktime_get_ns() - time_beg;
+	/* Time spent should be easily above our limit (1/2 s), since AA
+	 * detection won't be expedited due to lack of held lock entry.
+	 */
+	return ret ?: (time > 1000000000 / 2 ? 0 : 1);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/res_spin_lock_fail.c b/tools/testing/selftests/bpf/progs/res_spin_lock_fail.c
new file mode 100644
index 000000000000..3222e9283c78
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/res_spin_lock_fail.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+struct arr_elem {
+	struct bpf_res_spin_lock lock;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct arr_elem);
+} arrmap SEC(".maps");
+
+long value;
+
+struct bpf_spin_lock lock __hidden SEC(".data.A");
+struct bpf_res_spin_lock res_lock __hidden SEC(".data.B");
+
+SEC("?tc")
+__failure __msg("point to map value or allocated object")
+int res_spin_lock_arg(struct __sk_buff *ctx)
+{
+	struct arr_elem *elem;
+
+	elem = bpf_map_lookup_elem(&arrmap, &(int){0});
+	if (!elem)
+		return 0;
+	bpf_res_spin_lock((struct bpf_res_spin_lock *)bpf_core_cast(&elem->lock, struct __sk_buff));
+	bpf_res_spin_lock(&elem->lock);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("AA deadlock detected")
+int res_spin_lock_AA(struct __sk_buff *ctx)
+{
+	struct arr_elem *elem;
+
+	elem = bpf_map_lookup_elem(&arrmap, &(int){0});
+	if (!elem)
+		return 0;
+	bpf_res_spin_lock(&elem->lock);
+	bpf_res_spin_lock(&elem->lock);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("AA deadlock detected")
+int res_spin_lock_cond_AA(struct __sk_buff *ctx)
+{
+	struct arr_elem *elem;
+
+	elem = bpf_map_lookup_elem(&arrmap, &(int){0});
+	if (!elem)
+		return 0;
+	if (bpf_res_spin_lock(&elem->lock))
+		return 0;
+	bpf_res_spin_lock(&elem->lock);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("unlock of different lock")
+int res_spin_lock_mismatch_1(struct __sk_buff *ctx)
+{
+	struct arr_elem *elem;
+
+	elem = bpf_map_lookup_elem(&arrmap, &(int){0});
+	if (!elem)
+		return 0;
+	if (bpf_res_spin_lock(&elem->lock))
+		return 0;
+	bpf_res_spin_unlock(&res_lock);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("unlock of different lock")
+int res_spin_lock_mismatch_2(struct __sk_buff *ctx)
+{
+	struct arr_elem *elem;
+
+	elem = bpf_map_lookup_elem(&arrmap, &(int){0});
+	if (!elem)
+		return 0;
+	if (bpf_res_spin_lock(&res_lock))
+		return 0;
+	bpf_res_spin_unlock(&elem->lock);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("unlock of different lock")
+int res_spin_lock_irq_mismatch_1(struct __sk_buff *ctx)
+{
+	struct arr_elem *elem;
+	unsigned long f1;
+
+	elem = bpf_map_lookup_elem(&arrmap, &(int){0});
+	if (!elem)
+		return 0;
+	bpf_local_irq_save(&f1);
+	if (bpf_res_spin_lock(&res_lock))
+		return 0;
+	bpf_res_spin_unlock_irqrestore(&res_lock, &f1);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("unlock of different lock")
+int res_spin_lock_irq_mismatch_2(struct __sk_buff *ctx)
+{
+	struct arr_elem *elem;
+	unsigned long f1;
+
+	elem = bpf_map_lookup_elem(&arrmap, &(int){0});
+	if (!elem)
+		return 0;
+	if (bpf_res_spin_lock_irqsave(&res_lock, &f1))
+		return 0;
+	bpf_res_spin_unlock(&res_lock);
+	return 0;
+}
+
+SEC("?tc")
+__success
+int res_spin_lock_ooo(struct __sk_buff *ctx)
+{
+	struct arr_elem *elem;
+
+	elem = bpf_map_lookup_elem(&arrmap, &(int){0});
+	if (!elem)
+		return 0;
+	if (bpf_res_spin_lock(&res_lock))
+		return 0;
+	if (bpf_res_spin_lock(&elem->lock)) {
+		bpf_res_spin_unlock(&res_lock);
+		return 0;
+	}
+	bpf_res_spin_unlock(&elem->lock);
+	bpf_res_spin_unlock(&res_lock);
+	return 0;
+}
+
+SEC("?tc")
+__success
+int res_spin_lock_ooo_irq(struct __sk_buff *ctx)
+{
+	struct arr_elem *elem;
+	unsigned long f1, f2;
+
+	elem = bpf_map_lookup_elem(&arrmap, &(int){0});
+	if (!elem)
+		return 0;
+	if (bpf_res_spin_lock_irqsave(&res_lock, &f1))
+		return 0;
+	if (bpf_res_spin_lock_irqsave(&elem->lock, &f2)) {
+		bpf_res_spin_unlock_irqrestore(&res_lock, &f1);
+		/* We won't have a unreleased IRQ flag error here. */
+		return 0;
+	}
+	bpf_res_spin_unlock_irqrestore(&elem->lock, &f2);
+	bpf_res_spin_unlock_irqrestore(&res_lock, &f1);
+	return 0;
+}
+
+struct bpf_res_spin_lock lock1 __hidden SEC(".data.OO1");
+struct bpf_res_spin_lock lock2 __hidden SEC(".data.OO2");
+
+SEC("?tc")
+__failure __msg("bpf_res_spin_unlock cannot be out of order")
+int res_spin_lock_ooo_unlock(struct __sk_buff *ctx)
+{
+	if (bpf_res_spin_lock(&lock1))
+		return 0;
+	if (bpf_res_spin_lock(&lock2)) {
+		bpf_res_spin_unlock(&lock1);
+		return 0;
+	}
+	bpf_res_spin_unlock(&lock1);
+	bpf_res_spin_unlock(&lock2);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("off 1 doesn't point to 'struct bpf_res_spin_lock' that is at 0")
+int res_spin_lock_bad_off(struct __sk_buff *ctx)
+{
+	struct arr_elem *elem;
+
+	elem = bpf_map_lookup_elem(&arrmap, &(int){0});
+	if (!elem)
+		return 0;
+	bpf_res_spin_lock((void *)&elem->lock + 1);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("R1 doesn't have constant offset. bpf_res_spin_lock has to be at the constant offset")
+int res_spin_lock_var_off(struct __sk_buff *ctx)
+{
+	struct arr_elem *elem;
+	u64 val = value;
+
+	elem = bpf_map_lookup_elem(&arrmap, &(int){0});
+	if (!elem) {
+		// FIXME: Only inline assembly use in assert macro doesn't emit
+		//	  BTF definition.
+		bpf_throw(0);
+		return 0;
+	}
+	bpf_assert_range(val, 0, 40);
+	bpf_res_spin_lock((void *)&value + val);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("map 'res_spin.bss' has no valid bpf_res_spin_lock")
+int res_spin_lock_no_lock_map(struct __sk_buff *ctx)
+{
+	bpf_res_spin_lock((void *)&value + 1);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("local 'kptr' has no valid bpf_res_spin_lock")
+int res_spin_lock_no_lock_kptr(struct __sk_buff *ctx)
+{
+	struct { int i; } *p = bpf_obj_new(typeof(*p));
+
+	if (!p)
+		return 0;
+	bpf_res_spin_lock((void *)p);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.5


