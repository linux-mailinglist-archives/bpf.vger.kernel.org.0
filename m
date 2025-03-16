Return-Path: <bpf+bounces-54140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC66A633AF
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 05:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7429A3A9B64
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 04:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC381AF0B6;
	Sun, 16 Mar 2025 04:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHypsgx5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CF81A8405;
	Sun, 16 Mar 2025 04:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742097979; cv=none; b=UMANXvrDBSAxdwTi/rBdOapMAqXoov7ZMLxSyic5wy2reANvsmLzanCND7tUPBVlC9cy/rxjusqvxhqthrxAB1OjYXDZE1eN7QnTQ8q7ykioSz2gSKG7z592F4cFgKJd45WvEUgLbFSdEdT2Zc/E4UhPONTuIM+T5KlhWqMfLv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742097979; c=relaxed/simple;
	bh=WzglPmerkocCQhDWbBighUyfP7AwOFpfdLvye4wcaoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U04NiLVFUdzu92yRcnEZJk7qpxtzhQHVddmPhGIm4S/0+nh4pc+Bb0unlR6hfZY+SC0vqp+i/VUp1tF4zdkUDDw36bYeIgdk6KzYKWC9JmwIqTWu00S+S4wTPY83i2kvwQnAZUwqA0de12BwQ0IgMYZUSMkHH34LerSqjVrckEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHypsgx5; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so5252755e9.1;
        Sat, 15 Mar 2025 21:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742097975; x=1742702775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqTweZiejAx9T/E+eHkWTTmWDjmG9az608PXOpULayA=;
        b=CHypsgx5AnwiCMKxHf7mj5LJcsMpnutecfe7xQYf34hRa34KeAS+r+nu7yMseASeBZ
         VqbTMZVhMyXKmy51rOQv2H9X3dzu6FwvIqd3yF4LsQYT+DRfFri2uVOIKb00OZntcnzE
         g4jPB3NqIy11nZKTVDVUJVn1cXKdGEcE0AhtEH4J9+YJ8Fak2YbRIYLPoCRzDVTkX753
         JPoIf8hA8SbNsCWMUjm58FZd1Hg+GnO3a72Ws6zl6PRmjDfBMmWaZIXHX/cRWSnn1Q4M
         qkbzuyExjuzzbPVTbtULaPQdXTEh2F9O5qOQX/GqGGAvwc91nNmwd3QO3bCzh6nR3LIO
         CxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742097975; x=1742702775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqTweZiejAx9T/E+eHkWTTmWDjmG9az608PXOpULayA=;
        b=FousrDKdG7cDZqoAeBMKRut7OxDHixRXIjvB8Q9qILDAyqhHSq1G++QaZKq60OYGQ7
         ZB7c4u7ia7ZxFqnWrs5GbFF7tl9Ss3HbOc9kp36/kITMDm/B0LBTuqCa5UJ8JbOJ9cdL
         jEvwbqSOzv15LjgcymCwRuoXDIDbhNiiOjkNAdrDZM4pBG7BM9z77cVEPXlaI8a32E8f
         +q4ZLWIiUq0fmLI61CBtCCmG9exOGjgwUv8Z4GqJW0CwkXRI5deV8sOzuiVgx6UicsmH
         oQmQ1O4GXcGfOeluR3Cgs4mh1PaY+u2pPGIY5j9pv9MGMH27c6af8oCsQeUS3ORtJWYV
         70og==
X-Forwarded-Encrypted: i=1; AJvYcCUyDc/TLKMojGi5uoTg4taqCa+Ygk4Y6y8l+wt5WI1dJPQUMlGiYj0zbPqkXfrNI4cax/pdgyHDZ0hOanU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGnLuYjrWtVc3R2wN7Tx94awaLKTC8bLHqC3eH1UJvuwI0Sg/N
	4Ryig8vHN5PyYj7Tr2cmP08nHFI6jhmbw+WUBCgJ+4Xwh/9IUSAR2V4VvsQFoSQ=
X-Gm-Gg: ASbGncuxd+fvxQonGmbS2HEfBjNSKMCTm7A/7xlFotYhkxEXgLuZtxBnb1RJkowBtCW
	JwNE1D3xXL/HqYt86LYAl516RejJ7ELNnhyHsGsK7gTPydS0XqGiM2e4wrzXgud7Odo4j/ryaPU
	tJ1VuKupCZrkbQThRyRILxzPbdvU4hBkGCNWjNjTAt2hyKPzsHwSDfHWaM8RwiVXzSbuAPExZRE
	cIVIejrWMuABje6Ms/TGzr0tcfcNjYJPXSuUMY/7m9SuPL17tGnexfj7wTGsvVqGAHQ3/YTIV5e
	l8OC5FPk1JCVkq6qdurvhdBU+sLvngKpNQ==
X-Google-Smtp-Source: AGHT+IFeh67jTgD5TP0qheSUJfU7LLF64eXr0kHndM6htg+7j04x+U4+nQOzqvFPpjLVDRYSpnbm9w==
X-Received: by 2002:a05:600c:2e49:b0:439:91c7:895a with SMTP id 5b1f17b1804b1-43d18077785mr127539315e9.7.1742097975149;
        Sat, 15 Mar 2025 21:06:15 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:9::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fdda29esm67800095e9.7.2025.03.15.21.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 21:06:14 -0700 (PDT)
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
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 25/25] selftests/bpf: Add tests for rqspinlock
Date: Sat, 15 Mar 2025 21:05:41 -0700
Message-ID: <20250316040541.108729-26-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250316040541.108729-1-memxor@gmail.com>
References: <20250316040541.108729-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15835; h=from:subject; bh=WzglPmerkocCQhDWbBighUyfP7AwOFpfdLvye4wcaoE=; b=owEBbAKT/ZANAwAIAUzgyIZIvxHKAcsmYgBn1k3f2c4rqqrAQ0kVuTGJPhKGv2EW1Y8So7OlkvKH pijdeFmJAjIEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ9ZN3wAKCRBM4MiGSL8RyhbbD/ UUdDj3C6OQQLLspCJ/FjFqMb7Rh+TPjsp+ezYfCepntai3KXcaf5EXMkD2hxkq5UXjWrPDc0/qRlWe g6SqGPxSDkawyNrLqqJpettdZ9Otv3dfHFcqnUVbvcXce+/Dv0KK8Z0LHNXMVSLNQosrLZZIcUYlK8 q9tIL79uS9UZsjCswHctVclK3kG6/j/pbYNePRmaOGvS28U4vYwkPCR4ukGUTpzSGhCRQyKQ9mfots AD4s5cwsLVJD6mn6JW+T8NQsw5fc4cL+jcmEGw4eFZKfhEtRtSq4pDO8W9npT0aOUuL7n2tR6LUqA9 PCLIgaddMWt+ZBb7ZAl9a4R0eVngKUmjipW2nVbuPrXlPprmGukFj7ffLLfzBiXeEar8Z+qNs7m+k1 3TNBqf/k6JRgsBDMD+KAV17zrogSxgoabbMqJr/Qks7HK3qFuuT/rcVvPct457i9heREK/rh+iPOSx geTMgx8BdnqZP8XlUbLhCrhS5F+aIEhGOZDRvkC2VNavkKhnKCTmkgwWnXwWul6mxGQQyG5ogs40ic Y5lSr36ZMAApoVgCM1E40+g4hc4Va8xlVF2bp0ST/A+GOJVdV5WycxpHNj/qPaS0F//8vnPdY7EVE/ zBJ5rHbNyk57EKt+zdORu09tY/48U3/03l0OWSyN6pXSWzI3uoRnsPzxWV
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Introduce selftests that trigger AA, ABBA deadlocks, and test the edge
case where the held locks table runs out of entries, since we then
fallback to the timeout as the final line of defense. Also exercise
verifier's AA detection where applicable.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/res_spin_lock.c  |  98 +++++++
 tools/testing/selftests/bpf/progs/irq.c       |  53 ++++
 .../selftests/bpf/progs/res_spin_lock.c       | 143 ++++++++++
 .../selftests/bpf/progs/res_spin_lock_fail.c  | 244 ++++++++++++++++++
 4 files changed, 538 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/res_spin_lock.c
 create mode 100644 tools/testing/selftests/bpf/progs/res_spin_lock.c
 create mode 100644 tools/testing/selftests/bpf/progs/res_spin_lock_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/res_spin_lock.c b/tools/testing/selftests/bpf/prog_tests/res_spin_lock.c
new file mode 100644
index 000000000000..115287ba441b
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/res_spin_lock.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024-2025 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <network_helpers.h>
+#include <sys/sysinfo.h>
+
+#include "res_spin_lock.skel.h"
+#include "res_spin_lock_fail.skel.h"
+
+void test_res_spin_lock_failure(void)
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
+void test_res_spin_lock_success(void)
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
+	if (get_nprocs() < 2) {
+		test__skip();
+		return;
+	}
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
+	topts.retval = 0;
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
diff --git a/tools/testing/selftests/bpf/progs/irq.c b/tools/testing/selftests/bpf/progs/irq.c
index 298d48d7886d..74d912b22de9 100644
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
@@ -510,4 +513,54 @@ int irq_sleepable_global_subprog_indirect(void *ctx)
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
index 000000000000..b33385dfbd35
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/res_spin_lock.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024-2025 Meta Platforms, Inc. and affiliates. */
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
+	_Static_assert(ARRAY_SIZE(((struct rqspinlock_held){}).locks) == 31,
+		       "RES_NR_HELD assumed to be 31");
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
+	/* Time spent should be easily above our limit (1/4 s), since AA
+	 * detection won't be expedited due to lack of held lock entry.
+	 */
+	return ret ?: (time > 1000000000 / 4 ? 0 : 1);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/res_spin_lock_fail.c b/tools/testing/selftests/bpf/progs/res_spin_lock_fail.c
new file mode 100644
index 000000000000..330682a88c16
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/res_spin_lock_fail.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024-2025 Meta Platforms, Inc. and affiliates. */
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
2.47.1


