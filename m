Return-Path: <bpf+bounces-53093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8884DA4C522
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 16:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE0717554A
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 15:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B30923A58B;
	Mon,  3 Mar 2025 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2gOlkK8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D14239561;
	Mon,  3 Mar 2025 15:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015426; cv=none; b=suKoWTd7Hrs3xVfFFGqcqfngpgyIOAaoK14KdQzf6To8em0CN3nvwsjdVsod28evG9Rf3GjpoMFlmZQQ2frLFem4Tf55rGcwqvm5cACP3lFe5cLOVDASvox9LfsYNrMeV/qeL/0AUUkgG/kd/+u6ZFr7qRljG7lLvev4k4cLinE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015426; c=relaxed/simple;
	bh=U3o4FRMgSYlK94f6p6XtgMmHxSWNXlOtPMuGZSejx2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOeHIJqXzcf7DcklNF7QB6UmbSn0dA3c7dvP8UfyH1YtGemiWrBusT6UdswSzaxCElZq4WmoVD+rLVU7rIhos2tBkd5/x/Us8grshtcOC4H4ei6SFk6uniNgrg/hUmxMcKnvxi8OJyFfl+VcX6oqKbmZqwAdymhEWhRNOJ3OtXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2gOlkK8; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4399ee18a57so28857335e9.1;
        Mon, 03 Mar 2025 07:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741015422; x=1741620222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2YDELerz8rU9E2PXmGNUF4c5wFbG0aqMQwnamqYdcU=;
        b=a2gOlkK8VwPr1Q+d8pMxXIbPi8dxxEcZw5KN5x4R2QGHwdRuC8dILbaGLbk/xldmGE
         3ABfQJ6ThsKkJarNNyY/Gqm1fkR5UUYlKGg8daTYzxc9tXvMg/QlGN/C4hfDw6SOkzZT
         Ipb1FpNxlf9Itqx4tbT9SQVDTSsRdzIHMp3Q7rpmwfto1bGXSBiODwvBXq7zXUJYKiPu
         K+ceTyqk3ITXmP5uDMN1UptA74wQbnXATzMKYHerUuOZa3yo6ac3oFyHipeh7Nwh54BO
         1uK3N2DCE52uRABiG0QcR4uGqjZDO/eaQFUps14/SveXBPTUu6e3Rx96sBSeziiiip06
         a+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015422; x=1741620222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2YDELerz8rU9E2PXmGNUF4c5wFbG0aqMQwnamqYdcU=;
        b=KLWDJR7SyRAckK3EXZH1NHZscYn3SntYuUvF33bEQzwjmiBa5tCceTDfzfIfD2o0bi
         +yVkWtV0BuUBIvhZUwOxDIgpKX1PdIS3MadFRMZwu5EG7NyE7AYK7hl7fdKDYrL0+dH1
         Ldu/bsgfzzfE6FKGaYYhdoZbSq+eiSVqokIU/veB90BK4qQ7woevhImdzSrFtfHfIdm5
         U9/aslNlVRMAirVQDiQrQMrtY1Q0n1RSdcxXOmNyW1pf4ehO+epiL/7+IF3+GWjgCSER
         LWP2oow9KYjuY2Fr5v7Cp0ungeNzEHV+NrFg1tM+oMhkwAt3o7/hO1Y5Oe+bY+GOfLGO
         RE7g==
X-Forwarded-Encrypted: i=1; AJvYcCVN/4qt6hP2a+BlrrpnGOaet6F8Td9C711cGHvxXUil7Aq+vqyjQqTZ9Wb6WHsu8+qGnWTjAeKOLcKODBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0GkQVZevUDlU5970UPjRF1/HtpARakx0CWUYy7DgchKSq5ZX2
	trBAF7Ab+cCTmobH8thIH0YH7b4+tyfnL2W3Xm6HX2H/cHCgWa58Gxm4ZXTBgdw=
X-Gm-Gg: ASbGncs/YC8fPRAspVhCJJIv83eY3AU40ze8YI4AKLNbd3uvomg7Gf0CnBkrCVCn9W5
	gYSglScJEqw2bKHM2+wLCPmJli4s9tC4HpjsAaMjo96G1zdLdrDcBvtovjq3cVu5rp5q7S+813S
	BOaBQ8T14yT6cZpN+dDO4WQtHHTE3V1JofDXHb4zIVg+E3+3OEqpaUOp1abGO03JPTgH1Q0G3Yf
	k61ZFo3lXbFuS/BIJsxp5xNql9BqWsWJ0elV08GxRLbMHWQP7kGy/x+KmhLohTNagG7G3jm9Fz5
	VYzVa/SgI1D2+IFFYY9f6wN5Rv6Jf7zrWXE=
X-Google-Smtp-Source: AGHT+IF1BwyKpBxufZL15FHfV1K+xkaoboqbhKYSSMajj4aWR8VsvlX6AMmLz83+PD1s+XMRyoVIXQ==
X-Received: by 2002:a05:600c:ca:b0:439:91c7:895a with SMTP id 5b1f17b1804b1-43afddc6489mr144850385e9.7.1741015422319;
        Mon, 03 Mar 2025 07:23:42 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:73::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bc24a51bfsm38651415e9.10.2025.03.03.07.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:23:41 -0800 (PST)
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
Subject: [PATCH bpf-next v3 25/25] selftests/bpf: Add tests for rqspinlock
Date: Mon,  3 Mar 2025 07:23:05 -0800
Message-ID: <20250303152305.3195648-26-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250303152305.3195648-1-memxor@gmail.com>
References: <20250303152305.3195648-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15728; h=from:subject; bh=U3o4FRMgSYlK94f6p6XtgMmHxSWNXlOtPMuGZSejx2w=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnxcWZzKIrFm1iuCUUDDtfLRnhLPc+SCt9cT5eXF6o 6N+GSmqJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8XFmQAKCRBM4MiGSL8RysxCD/ 0USidd7H00hBTlGhkNe1qL1P8T3pcVx1ejxkBbgrAma8ybJKZyercWVHVXCW8eQg784Ri97C4xBbFo 3V9qUCkJUJZUX4AnPiNsAdiAQCHKECTLYm0p0KqI9BcdgZKQv+HVHH54QDArzyN9nBuG4Uks81oq90 LbGJLfxQ/EP7x8KvPJqEa3auefyGtsq6f6d5JT+n+8gWtbOpnhncsq5NPk+Cfh4XjdHGw1ij0f6kb8 sYkYXwCPxGNbt7GuxA7DUA28RLTd+CWeLMnLz8sqlSHEqT3geqqTQ7zCGroosld1WZxYffYop/FpWT CK438ZkEWr6oW0Z9sokHWAwu5YnrGNcsZCNzUGyAnTFnYrhqn4p2oXPPWxdJP4MkivrQbM7nFp9g0W oGzGvCmn61ww7IdcCEK09nEtye3GvefEpTNPahCH5W1538XTcMV+ivRdfq2TzV48irQGjQEOLSEamT opLsWsX/ngZ8TSUM8rHQd6R1Xn/nxAehi9yFiEr8Afb4nBBoSL5SIDxtqDnDYjMBMZv/cHK/f0yOuL QwW/1Dd+qnhEq3YSKQmvGN8vnM1bubpAJGBgYYiv5mH/KDdvzmV0IA20+gJ8g+d9P9Z/RnqFZnIFPw ciMScGjt5UN3k63SRNESddfekGf3gq1yUKZbJrWdML5Zi9tRdfNR7DtyAqgg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Introduce selftests that trigger AA, ABBA deadlocks, and test the edge
case where the held locks table runs out of entries, since we then
fallback to the timeout as the final line of defense. Also exercise
verifier's AA detection where applicable.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/res_spin_lock.c  |  92 +++++++
 tools/testing/selftests/bpf/progs/irq.c       |  53 ++++
 .../selftests/bpf/progs/res_spin_lock.c       | 143 ++++++++++
 .../selftests/bpf/progs/res_spin_lock_fail.c  | 244 ++++++++++++++++++
 4 files changed, 532 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/res_spin_lock.c
 create mode 100644 tools/testing/selftests/bpf/progs/res_spin_lock.c
 create mode 100644 tools/testing/selftests/bpf/progs/res_spin_lock_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/res_spin_lock.c b/tools/testing/selftests/bpf/prog_tests/res_spin_lock.c
new file mode 100644
index 000000000000..563d0d2801bb
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/res_spin_lock.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <network_helpers.h>
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
index 000000000000..40ac06c91779
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


