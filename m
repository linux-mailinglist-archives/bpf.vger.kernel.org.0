Return-Path: <bpf+bounces-48120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0E3A04194
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFB633A6B13
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 14:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FC51F4E25;
	Tue,  7 Jan 2025 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZj6Ed9z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68B91F3D48;
	Tue,  7 Jan 2025 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258453; cv=none; b=aK6yGF3acOhsTALzkVAGxI8Ym7XpKFcphuQy29Fek8PI+l4642R9WE7UfKldvMEol4n//yjj7kn/WH/PzYjldlJRdjcoUAa5RiWIDeaIaatu66VIvwwFaVz/C3l6uZ+XUUXaSWbxMBAJtV++dLfU9N38oenrC1FPpf4Da4dITFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258453; c=relaxed/simple;
	bh=FBR0eFp2XW2HZA+qyWkxTYz5iZeScNdFDaNVHD4Qz3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWMYZ9PZm+vKg50iva5YTKLXprzTYmelLhulzsxvgUztACcEcnGSRpHbnQTy6kwmnJ2EqslkylzZ2t7gJ0s1MsuVLm7A5ItsaBBJusCtENIu+IkHA8IYjxNbhZ8N0YpicbOmChbXw1D8+3KgEIrOiKYa8yzWhI1jooroQauhQSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZj6Ed9z; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4362bae4d7dso111559715e9.1;
        Tue, 07 Jan 2025 06:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736258444; x=1736863244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zo4OiIkRFhOWBPmum8Y5hXiAQUzWDaGmQz5kzCgn6+I=;
        b=eZj6Ed9ze5wqlBmo7IFIPsP+V9iob/0SSFqUxvCs1A1khh4bBc0cQvU63zfEPYJSaK
         zTWMVHZY3QoLk0U6s6ZmPLrogbaMxqeO90wOz57rr7VaDsMZpchKrECNhCsUE/3xlKGK
         uV4YYNUFcOUj9/75SHD88QlqXmcBKR/UFeh2dN223U4rI0XUuLGTW+m35mgUzrasKFIk
         OM/U3ykywP12T4NlR6S28jZCZbEe2KRz9Mz6hoNK1oQKubjxBWXEgWNM1uW44hAhaTlj
         wZGcnDC7e3SxVC+e7xjhvI7cVv4L3uXqpr/Hztr1HakXNBCs+DwqwoKsNx/rjeHmr6SL
         nicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736258444; x=1736863244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zo4OiIkRFhOWBPmum8Y5hXiAQUzWDaGmQz5kzCgn6+I=;
        b=borKHVY248QocQdli0HlbucjqWR7jc8/Axv4ytFti1U1Wo3F9tHTzB+FYTDyPAEqxv
         QII1DATGX1Wy+mo6jVI29AGxCTbwjkIB1k55lYtqNZAPnMc3eWDziqm9gFd94Q1GTT0f
         Xq0u94iK0zJ5OGGINL/B5IlfDAjSA3Tq2SFqte0SS3Uj+/Si8aqfL2M5UJeGXamd+sZR
         IPqQJXDIUfYEgUqqHDDkMg/rhfKE6xintvfFuLx4x9RN7BDqd7+bPMh5yxdMfBoDvI4B
         YhOL5kJ3BjvnB3mvochyNPetZNGYa9YW35gi1StHwrxdQgwZO/WMVKSztiPWUWGVrwXd
         Lu8A==
X-Forwarded-Encrypted: i=1; AJvYcCXKZTg1nHk7Y0jGwpQ14Fpd2spVCJKgoR4X0AVRSxPpZVJVSMwnyvlPIlptBC1dl/gJM0xTIvqEuXAuIJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5HV+0R485KokkMmFeCcV1gYKaFIEhO7BxffKE3sDCrTXnm5BG
	NuR/gdbebnw6K6AzuMxD0uMYoFztDDTTI1vwj7InuD7X0SX18CoLYzh3ZLWxfPH0Ag==
X-Gm-Gg: ASbGncsmvO5NkJ/bD504mvSmNi5IfP3ZwwZU9t6jWKRJFm2qXBQGc8SiDNzaXeSYmeg
	WiN5nGK2tdM0nTxF1882u8F5ME9k/8gd9BXJ+aHIbrRWMuulrXmeJ2yaXxo2HgPWET+c+JJfQDr
	Yu5WO+bmPAzRWiajUuJY0Zawr0U4f+kEkIVZ7HmhhuuNl2LmYawdQDsY8TRYqvBkW8yyknA1SIS
	Si7/jP2HInbX0vxDEQ0tSEiq574hGoUbBjp22E0p0LYMbg=
X-Google-Smtp-Source: AGHT+IF75O8Kf8yVjIrKj6IThBxkNnWISNGuSICcidlf1g84tGFy1GH2je7f5vgj+qBlBS9i76BkpQ==
X-Received: by 2002:a05:6000:704:b0:386:1c13:30d5 with SMTP id ffacd0b85a97d-38a221e2efcmr53226450f8f.7.1736258443482;
        Tue, 07 Jan 2025 06:00:43 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:70::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661289995sm596241935e9.36.2025.01.07.06.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 06:00:42 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 22/22] selftests/bpf: Add tests for rqspinlock
Date: Tue,  7 Jan 2025 06:00:04 -0800
Message-ID: <20250107140004.2732830-23-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250107140004.2732830-1-memxor@gmail.com>
References: <20250107140004.2732830-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16838; h=from:subject; bh=FBR0eFp2XW2HZA+qyWkxTYz5iZeScNdFDaNVHD4Qz3A=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnfTCfBgLimPqxMSYRHgRb0agCRulR6yMrQBMlBN46 TUCIZuKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ30wnwAKCRBM4MiGSL8RylwpD/ 0ZZdsMszNOBioSf554AHzfzcMUnTmTu25N/acvHgjWdSbHTS1jdsXcuPSIfV55rVRfhh3oZx5/aITS Ak15rCP8/ZjIV8cEWTKBIdnsmnXLnoUSYKqH6sgbWAxpmyvgilpIEqSRrey5KGGVBVY7iuzEZcYHlV jqYJ/bqr2Y1YiJQh0fHa+AfdaRUxcE6EOVpvwqaYfm7exFVJ5RaNmEXc7ZJ3cBlDY8cf8xPSTVEqe4 iVTWKMsiOF8QFBjdmsdesvfTnPAJ9Sf18vwzCZQ0PfDj20hbTMcm8lY+oEF8Ja2MV45PTY1o43XgvS oM9QxwJl2m1nyPaUFmNIeqC6Z5RiD0TjfliSBqtW02Pq3eu7jz4xQR81XZhi1z/XVsNybm/1mokQAE 07G+21/Ey2HJtkfnNaYKhOEjBhn4GrzIaGgwz36nC5oPGAPZHQTE/fEHdmoFjrUDSLmpaWiAOGA1Ij bjgIQKRtg8qx9li/pmDuzqkq4AtEKo0Wa9+BftmlPQt7OBfGeUVAnSk8UGpqBZZtlZg45uxjN5Qt4Y C/8Eem2MMCIOnhiMS+9PwKzjXFpJlwJDcOaMqtxy8bHmkVFSxyYHcbF4ARwHlCbOma/NdeVEsd9wU7 BXxvSt3CLPoR4jMZGPQY8hTWRyMXvb3oeeNEhLf0WGGvE7aZbjIPU89cC7lg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Introduce selftests that trigger AA, ABBA deadlocks, and test the edge
case where the held locks table runs out of entries, since we then
fallback to the timeout as the final line of defense. Also exercise
verifier's AA detection where applicable.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/res_spin_lock.c  | 103 ++++++++
 tools/testing/selftests/bpf/progs/irq.c       |  53 ++++
 .../selftests/bpf/progs/res_spin_lock.c       | 189 +++++++++++++++
 .../selftests/bpf/progs/res_spin_lock_fail.c  | 226 ++++++++++++++++++
 4 files changed, 571 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/res_spin_lock.c
 create mode 100644 tools/testing/selftests/bpf/progs/res_spin_lock.c
 create mode 100644 tools/testing/selftests/bpf/progs/res_spin_lock_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/res_spin_lock.c b/tools/testing/selftests/bpf/prog_tests/res_spin_lock.c
new file mode 100644
index 000000000000..547f76381d3a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/res_spin_lock.c
@@ -0,0 +1,103 @@
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
+	while (!skip) {
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
+	/* AA deadlock missed detection due to OoO unlock */
+	prog_fd = bpf_program__fd(skel->progs.res_spin_lock_test_ooo_missed_AA);
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
+	while (!topts.retval && !err && !skel->bss->err) {
+		err = bpf_prog_test_run_opts(fd, &topts);
+	}
+	ASSERT_EQ(skel->bss->err, -EDEADLK, "timeout err");
+	ASSERT_OK(err, "err");
+	ASSERT_EQ(topts.retval, -EDEADLK, "timeout");
+
+	skip = true;
+
+	for (i = 0; i < 16; i++) {
+		if (!ASSERT_OK(pthread_join(thread_id[i], &ret), "pthread_join"))
+			goto end;
+		if (!ASSERT_EQ(ret, &prog_fd, "ret == prog_fd"))
+			goto end;
+	}
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
index 000000000000..6d98e8f99e04
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/res_spin_lock.c
@@ -0,0 +1,189 @@
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
+int res_spin_lock_test_ooo_missed_AA(struct __sk_buff *ctx)
+{
+	struct arr_elem *elem1, *elem2, *elem3;
+	int r;
+
+	elem1 = bpf_map_lookup_elem(&arrmap, &(int){0});
+	if (!elem1)
+		return 1;
+	elem2 = bpf_map_lookup_elem(&arrmap, &(int){1});
+	if (!elem2)
+		return 2;
+	elem3 = bpf_map_lookup_elem(&arrmap, &(int){1});
+	if (!elem3)
+		return 3;
+	if (elem3 != elem2)
+		return 4;
+
+	r = bpf_res_spin_lock(&elem1->lock);
+	if (r)
+		return r;
+	if (bpf_res_spin_lock(&elem2->lock)) {
+		bpf_res_spin_unlock(&elem1->lock);
+		return 5;
+	}
+	/* Held locks shows elem1 but should be elem2 */
+	bpf_res_spin_unlock(&elem1->lock);
+	/* Distinct lookup gives a fresh id for elem3,
+	 * but it's the same address as elem2...
+	 */
+	r = bpf_res_spin_lock(&elem3->lock);
+	if (!r) {
+		/* Something is broken, how?? */
+		bpf_res_spin_unlock(&elem3->lock);
+		bpf_res_spin_unlock(&elem2->lock);
+		return 6;
+	}
+	/* We should get -ETIMEDOUT, as AA detection will fail to catch this. */
+	if (r != -ETIMEDOUT) {
+		bpf_res_spin_unlock(&elem2->lock);
+		return 7;
+	}
+	bpf_res_spin_unlock(&elem2->lock);
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
+	return -EDEADLK;
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
index 000000000000..dc402497a99e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/res_spin_lock_fail.c
@@ -0,0 +1,226 @@
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


