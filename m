Return-Path: <bpf+bounces-52958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E1FA4A836
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 04:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0D01897D65
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 03:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BAA1A7264;
	Sat,  1 Mar 2025 03:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZD+S94OY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3527715ECD7
	for <bpf@vger.kernel.org>; Sat,  1 Mar 2025 03:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740798138; cv=none; b=fhTTVW7Bs9ouokZzQgDqKRAjXEaNYq/k8sVI3tiopYFb4KuIRPCm5ZWsYdEErAlcjL/M+A0sTYYq1L1H7VZEj90/KltBufaGqauTrokfDFCVhkUnM0ywY+TlVT6QqAaq38UYQamBBYp/kDwJms6iVlst0+ZVYuKqJxayy0kAhUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740798138; c=relaxed/simple;
	bh=y+sHsLEqdew+DfOuBOU9KArsJMmccspgbdU2aqyaCd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLnhXIAdjDPASMR2kjBEmMoLc9eMMDbJHMyktHgQ70GNI5cogQoFwIQYVa18uFgck83uK1Zm7gLDAQ0aVaNosvl1ozXW2ZkccLJsGxNtGqqN2G4gabKY5R9QdQiuoUJbDKVbvf3O4QiX3ksbTxGILYYwQ/UfHigFeXPfREdKSy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZD+S94OY; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-38f6475f747so1363824f8f.3
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 19:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740798133; x=1741402933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ErwRhf6FvDxB2tk+JTbXqp+BUu3Yb98sxSMDVeInZk=;
        b=ZD+S94OYaYLGWr3itRIAM3L18fZ5RwXoqOU+q8ytXxdtp1xisvEcydsYinhnla5fMw
         CCIKnIu19fCLiuZB7LcmqDYMaTR/VB2n5NWpJCQEBNQuN89rF404emusdh1t0V9ZJ5xo
         UpX7qyAkgtd9qG8JwqWZ+nUEvPs5HNUGmksMkGoJeHr7yexfzviWG2Y5FUrKhP7S5wVu
         TLcs9boHCALuaEydXsm8HRqnxR1cNq/QfbbhcBFqmdFaKSgy0I+8qi/jwIg/qfVfl5Ij
         Rze4RcQl0V43uPS0yMbPjKuiw4n07OpAr5VF6smR595+wKuNcJAZqP/+8rKZ+tAyAxuz
         JaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740798133; x=1741402933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ErwRhf6FvDxB2tk+JTbXqp+BUu3Yb98sxSMDVeInZk=;
        b=FeMfjaRVErrYhvwUIRPIq5Z3cF+NR+eYwKx5Um0tWvbsOQjtA0fqVzcwaj+BOq8Ete
         +wLcl4jvDV5UYJ29bAyRreJ36V2LINCcfza5LDjbhkjicZLqPISp39AqexfYPYmZVpJu
         VZLgQN2VBcWyJED1p11kCaLYKRUB+wOwez3eV1RD1Sv3X40dxKyc4TxqCUeheIirVk6x
         JXGdbDJFg5XTjQ42VyMqA/gXXWFS+RMoyotqJlXHRLRpLwt23IFvMonIizd7MCP2Dghr
         T3yeMJbJz2DWJWJltqqVff2LZVG3EcggSMbg+buumwjgdE++FMv8BZvBVl07JeRDovLe
         KT5A==
X-Gm-Message-State: AOJu0Yw88UUDiQuomoPq4OL/jacbMTKUDGUQkfFrTlqF/YOWQlOpfXeP
	HWQJh/pixsgqCQeNQ5y0Ew0fOZMWft6LJMgYMBYIgKzq5czVnzprezQR1b2GkHg=
X-Gm-Gg: ASbGncug6Z0i7bfkhj3kW++B2k1rBXOmZ+NTAKq3xEyI8VR/GNOkfQ3BZuRThyRqIBr
	lpIqc7ZkGE6fUYCu9YnrWsdtlDp5uJyX5/+DbW2jYTuKd8zd2wjqWNsjgmO4X7M+LJjT5prj8rS
	kaIGpZIn9uJYFzmppFCTrTXHJT0OJcM0Ko2IJLlFBMiYdE9rv0wuqfcR+Z/yZJe2NbpfrK+LZVu
	iRl9+zCBa52RC1V9CCaCwkWW0dkJqEcW1HUob0GIxYF7vhMeChIVCbEMrdLzA7VqgC2nguLLGGz
	JXB39JaWkNN3okF5tkhQ9daryWioxI4=
X-Google-Smtp-Source: AGHT+IFXvNegqS9lVKQHqGTXpAf0nm/MCxfEWfzVEpacmC0LjbydWuC9oS7eNxe/V5/NwrLkUepcnw==
X-Received: by 2002:a05:6000:2ce:b0:390:f9d0:5e3 with SMTP id ffacd0b85a97d-390f9d0075cmr340248f8f.1.1740798132978;
        Fri, 28 Feb 2025 19:02:12 -0800 (PST)
Received: from localhost ([2a03:2880:31ff::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4796600sm6852616f8f.20.2025.02.28.19.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 19:02:12 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: Test sleepable global subprogs in atomic contexts
Date: Fri, 28 Feb 2025 19:02:04 -0800
Message-ID: <20250301030205.1221223-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250301030205.1221223-1-memxor@gmail.com>
References: <20250301030205.1221223-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10038; h=from:subject; bh=y+sHsLEqdew+DfOuBOU9KArsJMmccspgbdU2aqyaCd4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnwnVALKOHjfLJChnSeMHFb6wygHu2qIeh/03QGtK5 /KZs9+SJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8J1QAAKCRBM4MiGSL8Ryi5GD/ 9oUPRj7MVngil40eTjNQQHO28/bQT2R0poyjvDOnVx5oipqDM461im1uWcalz0A/PT7AmPRVTeKpgN O2tHlwEhA65BO2oKkbblTwrO4AQSluEQGs3xY/OvYb7MCCWe+IWODZToNb7RMmV+5hiir3i2CifhV0 fBpCNnPm/8+O2SFHSFW9/fRRpiEvtdMnW7CoLN0/GpZE79vE9R0c1N+Qk5bvT3tw3bOGDUG+/LeSSj eqiNc0aKHEO/9FNw8F3PU87864Zl3Ae3Lw/khfaRtHlk0qqCESjhKXMHfzX44NSYtR5UD2KtEAt1Bc XKqbBMPw50TyznlK4ER9iWjkZYh8O2LYZzT0mIhFy5y1woHjOFW8gYKOgJ7vzrIr6f3XzsvSM+B7vW 16dQgFyq5jH7pzO9rW8I+oDx0QDNcgewajXPYPuz6SwqB5l7SamF4r/11bfK0Kg0SVrlUyILOaHhIv 8iNy8cQJBDKIOT8X6AEo4DqE6+mmDI3CdktAWhpMCf4kvNJOXjxCznRP4M9Bo3GZJ19sozayiR8M+i 90g6LTlR/QJfhDc30BmZ/mpTHZr1jnCox2juL5wFzIQpLc8KD7iQ+r8H1x/9YuU1EdUgetw4YOK9ej 9aK15AVosyEYVN8bENaR46tMV1qh+ofCFOTQo9OLsLldJ9siIPFFgZHVDQSw==
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


