Return-Path: <bpf+bounces-52984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F30C2A4AC89
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 16:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE97C3B7891
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 15:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9D01E3769;
	Sat,  1 Mar 2025 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltYC1aGx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5A323F386
	for <bpf@vger.kernel.org>; Sat,  1 Mar 2025 15:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740842335; cv=none; b=eXXvKrU/vrzONLopwL+KYFHP8zZAB5iblZxt4K6nX6yO3D5B3lTh6ax9N0V87WLSLe6QQ2eBLBoSMW67jYhqje1P1SvVu4QUrWQQk7bM7utN678109jDDzvgK/buFkYwwulIJigKc3ae9kdmlkkJOONf2pcq5s/dCnPolDDW2tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740842335; c=relaxed/simple;
	bh=y+sHsLEqdew+DfOuBOU9KArsJMmccspgbdU2aqyaCd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OGg68KJhgL7MulC4KzIO+QZpfWSUPlqDrmg+7LFoiA4HNm/7hUw9DilkHxneZdq1U4iRuays9Q1EtQQagJ/+o7zBGjhC9Ld3y/3L9+/mAHUW8JdMKP0q4QX2R2nFibGFKX8A0TqfviAH/y55bk1n0uo7ZAh+13kF2L7aMQcFYng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltYC1aGx; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-390e6ac844fso2672286f8f.3
        for <bpf@vger.kernel.org>; Sat, 01 Mar 2025 07:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740842330; x=1741447130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ErwRhf6FvDxB2tk+JTbXqp+BUu3Yb98sxSMDVeInZk=;
        b=ltYC1aGxt50E64/fOrVzfAEMZHJQ3+AlNvcXZ8zjgm/3y+dhRMxu5wBiK0Sj6aQtYB
         rCffG61/0tVq+XFj3lGbDBmLWoAMIUIN0JckjfggHsz3oma9ZuIS094YU1BBWNkCRtgh
         +mvToal/A22OM7U6dbqDeCPzb59SaN0Xd7MvrMTKJhCUED6TeNSEGrNDw4zUibVPok9+
         K/rxHnWWzvxSqOpE2OE/p0gkwVWkC0LJU5dexXyGNUKUhVUcpPpHtlrCXnf/vRfoeRzp
         8zyNmIgeif5+NVyU4HDdL10BDYmjw8VsJ298Qc0zYkxeeV3OoEIrOghfdmRcKnHlv/4l
         aUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740842330; x=1741447130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ErwRhf6FvDxB2tk+JTbXqp+BUu3Yb98sxSMDVeInZk=;
        b=UpTFBMrAMdJvWpG+OTvxNuW7FDbN/NhgA+CSiGd/k0ERqz7Pl/uzWOIPiUrHPgkjTe
         Hharj9I7E+zu3IFm1rDuJlYnYTaY4U6LDDuSqprphQ235E7BOQsLUbbYKAIr/j5DF84w
         kuvw/giDtaduMuR9EWmL3+1wb+NHbMMSW9oz+c/pv5LpFPZwvP47jK685DSrcMfFkvvV
         Q5pTlSIE8Qd8B9Qe/nMgB51gFEsUvXI2g/F5jQBJ0Rq3/AhZ7hhA3/XAxvIP7p/rx9WN
         7OptbfZjfjobTcXfM/bV/3Q/YUG5fyOFe4bnT9n2FnqRz9SJvirRx5r/nOietw0gSyZz
         DA/A==
X-Gm-Message-State: AOJu0YzyZKzdO9OtneYQcMVX5oTmr21ppVokPpnY8d/4cP0gDaimApIq
	lkaKcl6u6R05TbtLDv292fnIiJlhvYYZ139Y8B/lQCq5TZphnoEvD7FhSEIvcmw=
X-Gm-Gg: ASbGncsvwzdiI7tBTHUw1HjVim0DMNXLLDMLMjMGinYEfnDNREWmxiY15dM9CZDrNMz
	GJ3QMIX22hQU/EJDDgsxY9HFOdKhe6tmgO7ihbyFWe/P8uABrMVD3n4iHR2J4C6+sENAV96ByBl
	Y/EuxcgXF34rGnufJzR951q6lOcSlLcN5zF/lMzWFtiYbqmhjiTJnJF19f1l7V4qIY8yzv1ZfmG
	PMLlq3V+XsKTdDzRmvACw5KmjbBHpEizKK8jBOwUxvdkv0A8A1/GB2WG5uVptPiMRyj803OVqGv
	Nf2+/b318ARpUkxhwRzwSDe98W0vsO+ECw==
X-Google-Smtp-Source: AGHT+IFdnxnHGbOMWpo9J2tQHABa0tFCSAwClKjYKbCb2fe0KY0TOA7OTXMkQUIP9+bwON7/UaCecg==
X-Received: by 2002:a5d:64e2:0:b0:38d:dfdc:52b6 with SMTP id ffacd0b85a97d-390eca27b9bmr5202760f8f.37.1740842330544;
        Sat, 01 Mar 2025 07:18:50 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:8::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485db77sm8452694f8f.86.2025.03.01.07.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 07:18:49 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 2/3] selftests/bpf: Test sleepable global subprogs in atomic contexts
Date: Sat,  1 Mar 2025 07:18:45 -0800
Message-ID: <20250301151846.1552362-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250301151846.1552362-1-memxor@gmail.com>
References: <20250301151846.1552362-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10038; h=from:subject; bh=y+sHsLEqdew+DfOuBOU9KArsJMmccspgbdU2aqyaCd4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnwyScLKOHjfLJChnSeMHFb6wygHu2qIeh/03QGtK5 /KZs9+SJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8MknAAKCRBM4MiGSL8Ryg6dD/ 99sFBXejDwjAU3J2dB3+wOGmLPUSnnn7jnQt1mepdnXKJBnL2i8E71zbdN1YxKyfMr7LBTRC3KHEHy MHgN2orjstIZ4zF579HIjkLem4kjicwhAkqOuTrjoXvHx1zOoKle/vSgkKb2HyPh0TbkhWqSdX8Kl3 f3lGQw802x7qhTMb5T0hEqTBrr7xpcfe54FW9mMfU5pHWikzNILt/xb4LMzVTqSwFhCyhkPa19A8fb grI8NeS3kuoZACXeSReJgxFwPu3HDuyVG8M6HUlatH4xXxjrfV8CZ4wEZ0lwUNKbhYtv5oH3eBLXZG AHmmy0lTrkP1LSWiXweE/EGW3mLk/TLEjAl1mU+BKwtoyAO349gH/mCCDfA/jxHpyqU3//0Pn+wfv5 lDsGNqOknVrxvZnXpS1tkbJia7XhXGTEeQeIQQSStn4hxjkvOgOq/t7Uaz4AiEF9zZG00wED0zaNbF 1pvDPbehV9zgZ2nKqjwzrK+Koi517rCOKDx5TCZxclyMosc73Ir8YEgZ038KLri8UVUjcZntDjbY7V g99CO46BEfWumVlhX+tOPZhh4VRnWntr/JKzuyTtzbWJgu53KnWcocEZCU3NHUmjXY6QII2TA37W9J JfWJX+FA24eVS4e946pTjBP56b9zIxLGr/BAppScao82ABDu730aY6BN4A3g==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add tests for rejecting sleepable and accepting non-sleepable global
function calls in atomic contexts. For spin locks, we still reject
all global function calls. Once resilient spin locks land, we will
carefully lift in cases where we deem it safe.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/rcu_read_lock.c  |  3 +
 .../selftests/bpf/prog_tests/spin_lock.c      |  3 +
 tools/testing/selftests/bpf/progs/irq.c       | 71 ++++++++++++++++++-
 .../selftests/bpf/progs/preempt_lock.c        | 68 +++++++++++++++++-
 .../selftests/bpf/progs/rcu_read_lock.c       | 58 +++++++++++++++
 .../selftests/bpf/progs/test_spin_lock_fail.c | 69 ++++++++++++++++++
 6 files changed, 270 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
index ebe0c12b5536..c9f855e5da24 100644
--- a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
@@ -81,6 +81,9 @@ static const char * const inproper_region_tests[] = {
 	"nested_rcu_region",
 	"rcu_read_lock_global_subprog_lock",
 	"rcu_read_lock_global_subprog_unlock",
+	"rcu_read_lock_sleepable_helper_global_subprog",
+	"rcu_read_lock_sleepable_kfunc_global_subprog",
+	"rcu_read_lock_sleepable_global_subprog_indirect",
 };
 
 static void test_inproper_region(void)
diff --git a/tools/testing/selftests/bpf/prog_tests/spin_lock.c b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
index 2b0068742ef9..e3ea5dc2f697 100644
--- a/tools/testing/selftests/bpf/prog_tests/spin_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
@@ -50,6 +50,9 @@ static struct {
 	{ "lock_id_mismatch_innermapval_mapval", "bpf_spin_unlock of different lock" },
 	{ "lock_global_subprog_call1", "global function calls are not allowed while holding a lock" },
 	{ "lock_global_subprog_call2", "global function calls are not allowed while holding a lock" },
+	{ "lock_global_sleepable_helper_subprog", "global function calls are not allowed while holding a lock" },
+	{ "lock_global_sleepable_kfunc_subprog", "global function calls are not allowed while holding a lock" },
+	{ "lock_global_sleepable_subprog_indirect", "global function calls are not allowed while holding a lock" },
 };
 
 static int match_regex(const char *pattern, const char *string)
diff --git a/tools/testing/selftests/bpf/progs/irq.c b/tools/testing/selftests/bpf/progs/irq.c
index b0b53d980964..298d48d7886d 100644
--- a/tools/testing/selftests/bpf/progs/irq.c
+++ b/tools/testing/selftests/bpf/progs/irq.c
@@ -222,7 +222,7 @@ int __noinline global_local_irq_balance(void)
 }
 
 SEC("?tc")
-__failure __msg("global function calls are not allowed with IRQs disabled")
+__success
 int irq_global_subprog(struct __sk_buff *ctx)
 {
 	unsigned long flags;
@@ -441,4 +441,73 @@ int irq_ooo_refs_array(struct __sk_buff *ctx)
 	return 0;
 }
 
+int __noinline
+global_subprog(int i)
+{
+	if (i)
+		bpf_printk("%p", &i);
+	return i;
+}
+
+int __noinline
+global_sleepable_helper_subprog(int i)
+{
+	if (i)
+		bpf_copy_from_user(&i, sizeof(i), NULL);
+	return i;
+}
+
+int __noinline
+global_sleepable_kfunc_subprog(int i)
+{
+	if (i)
+		bpf_copy_from_user_str(&i, sizeof(i), NULL, 0);
+	global_subprog(i);
+	return i;
+}
+
+int __noinline
+global_subprog_calling_sleepable_global(int i)
+{
+	if (!i)
+		global_sleepable_kfunc_subprog(i);
+	return i;
+}
+
+SEC("?syscall")
+__success
+int irq_non_sleepable_global_subprog(void *ctx)
+{
+	unsigned long flags;
+
+	bpf_local_irq_save(&flags);
+	global_subprog(0);
+	bpf_local_irq_restore(&flags);
+	return 0;
+}
+
+SEC("?syscall")
+__failure __msg("global functions that may sleep are not allowed in non-sleepable context")
+int irq_sleepable_helper_global_subprog(void *ctx)
+{
+	unsigned long flags;
+
+	bpf_local_irq_save(&flags);
+	global_sleepable_helper_subprog(0);
+	bpf_local_irq_restore(&flags);
+	return 0;
+}
+
+SEC("?syscall")
+__failure __msg("global functions that may sleep are not allowed in non-sleepable context")
+int irq_sleepable_global_subprog_indirect(void *ctx)
+{
+	unsigned long flags;
+
+	bpf_local_irq_save(&flags);
+	global_subprog_calling_sleepable_global(0);
+	bpf_local_irq_restore(&flags);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/preempt_lock.c b/tools/testing/selftests/bpf/progs/preempt_lock.c
index 6c5797bf0ead..7d04254e61f1 100644
--- a/tools/testing/selftests/bpf/progs/preempt_lock.c
+++ b/tools/testing/selftests/bpf/progs/preempt_lock.c
@@ -134,7 +134,7 @@ int __noinline preempt_global_subprog(void)
 }
 
 SEC("?tc")
-__failure __msg("global function calls are not allowed with preemption disabled")
+__success
 int preempt_global_subprog_test(struct __sk_buff *ctx)
 {
 	preempt_disable();
@@ -143,4 +143,70 @@ int preempt_global_subprog_test(struct __sk_buff *ctx)
 	return 0;
 }
 
+int __noinline
+global_subprog(int i)
+{
+	if (i)
+		bpf_printk("%p", &i);
+	return i;
+}
+
+int __noinline
+global_sleepable_helper_subprog(int i)
+{
+	if (i)
+		bpf_copy_from_user(&i, sizeof(i), NULL);
+	return i;
+}
+
+int __noinline
+global_sleepable_kfunc_subprog(int i)
+{
+	if (i)
+		bpf_copy_from_user_str(&i, sizeof(i), NULL, 0);
+	global_subprog(i);
+	return i;
+}
+
+int __noinline
+global_subprog_calling_sleepable_global(int i)
+{
+	if (!i)
+		global_sleepable_kfunc_subprog(i);
+	return i;
+}
+
+SEC("?syscall")
+__failure __msg("global functions that may sleep are not allowed in non-sleepable context")
+int preempt_global_sleepable_helper_subprog(struct __sk_buff *ctx)
+{
+	preempt_disable();
+	if (ctx->mark)
+		global_sleepable_helper_subprog(ctx->mark);
+	preempt_enable();
+	return 0;
+}
+
+SEC("?syscall")
+__failure __msg("global functions that may sleep are not allowed in non-sleepable context")
+int preempt_global_sleepable_kfunc_subprog(struct __sk_buff *ctx)
+{
+	preempt_disable();
+	if (ctx->mark)
+		global_sleepable_kfunc_subprog(ctx->mark);
+	preempt_enable();
+	return 0;
+}
+
+SEC("?syscall")
+__failure __msg("global functions that may sleep are not allowed in non-sleepable context")
+int preempt_global_sleepable_subprog_indirect(struct __sk_buff *ctx)
+{
+	preempt_disable();
+	if (ctx->mark)
+		global_subprog_calling_sleepable_global(ctx->mark);
+	preempt_enable();
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
index ab3a532b7dd6..5cf1ae637ec7 100644
--- a/tools/testing/selftests/bpf/progs/rcu_read_lock.c
+++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
@@ -439,3 +439,61 @@ int rcu_read_lock_global_subprog_unlock(void *ctx)
 	ret += global_subprog_unlock(ret);
 	return 0;
 }
+
+int __noinline
+global_sleepable_helper_subprog(int i)
+{
+	if (i)
+		bpf_copy_from_user(&i, sizeof(i), NULL);
+	return i;
+}
+
+int __noinline
+global_sleepable_kfunc_subprog(int i)
+{
+	if (i)
+		bpf_copy_from_user_str(&i, sizeof(i), NULL, 0);
+	global_subprog(i);
+	return i;
+}
+
+int __noinline
+global_subprog_calling_sleepable_global(int i)
+{
+	if (!i)
+		global_sleepable_kfunc_subprog(i);
+	return i;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+int rcu_read_lock_sleepable_helper_global_subprog(void *ctx)
+{
+	volatile int ret = 0;
+
+	bpf_rcu_read_lock();
+	ret += global_sleepable_helper_subprog(ret);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+int rcu_read_lock_sleepable_kfunc_global_subprog(void *ctx)
+{
+	volatile int ret = 0;
+
+	bpf_rcu_read_lock();
+	ret += global_sleepable_kfunc_subprog(ret);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+int rcu_read_lock_sleepable_global_subprog_indirect(void *ctx)
+{
+	volatile int ret = 0;
+
+	bpf_rcu_read_lock();
+	ret += global_subprog_calling_sleepable_global(ret);
+	bpf_rcu_read_unlock();
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/test_spin_lock_fail.c b/tools/testing/selftests/bpf/progs/test_spin_lock_fail.c
index 1c8b678e2e9a..f678ee6bd7ea 100644
--- a/tools/testing/selftests/bpf/progs/test_spin_lock_fail.c
+++ b/tools/testing/selftests/bpf/progs/test_spin_lock_fail.c
@@ -245,4 +245,73 @@ int lock_global_subprog_call2(struct __sk_buff *ctx)
 	return ret;
 }
 
+int __noinline
+global_subprog_int(int i)
+{
+	if (i)
+		bpf_printk("%p", &i);
+	return i;
+}
+
+int __noinline
+global_sleepable_helper_subprog(int i)
+{
+	if (i)
+		bpf_copy_from_user(&i, sizeof(i), NULL);
+	return i;
+}
+
+int __noinline
+global_sleepable_kfunc_subprog(int i)
+{
+	if (i)
+		bpf_copy_from_user_str(&i, sizeof(i), NULL, 0);
+	global_subprog_int(i);
+	return i;
+}
+
+int __noinline
+global_subprog_calling_sleepable_global(int i)
+{
+	if (!i)
+		global_sleepable_kfunc_subprog(i);
+	return i;
+}
+
+SEC("?syscall")
+int lock_global_sleepable_helper_subprog(struct __sk_buff *ctx)
+{
+	int ret = 0;
+
+	bpf_spin_lock(&lockA);
+	if (ctx->mark == 42)
+		ret = global_sleepable_helper_subprog(ctx->mark);
+	bpf_spin_unlock(&lockA);
+	return ret;
+}
+
+SEC("?syscall")
+int lock_global_sleepable_kfunc_subprog(struct __sk_buff *ctx)
+{
+	int ret = 0;
+
+	bpf_spin_lock(&lockA);
+	if (ctx->mark == 42)
+		ret = global_sleepable_kfunc_subprog(ctx->mark);
+	bpf_spin_unlock(&lockA);
+	return ret;
+}
+
+SEC("?syscall")
+int lock_global_sleepable_subprog_indirect(struct __sk_buff *ctx)
+{
+	int ret = 0;
+
+	bpf_spin_lock(&lockA);
+	if (ctx->mark == 42)
+		ret = global_subprog_calling_sleepable_global(ctx->mark);
+	bpf_spin_unlock(&lockA);
+	return ret;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.5


