Return-Path: <bpf+bounces-52880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE01A49EC6
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 17:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BEE3189A4FC
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 16:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F244427424F;
	Fri, 28 Feb 2025 16:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ns3alpPx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21EF26A0DB
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760147; cv=none; b=DkILsvKhtKCPCnjiJ8xcel00zMUVRxX66erSy4FU/TUAYOZrKaF0MreXIfLk7sBHMKkZFfticw1BKGQed+4H1jVoot1khDUQBEH1BsyBD/up88pAoTbqnPlfPJFV9dvqDA9Be0HZs0Nn0/KtxpkLCz+/zCT+251TF/VeCpgq6iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760147; c=relaxed/simple;
	bh=AG0zxT0Y+bM+xTx0wPhj/IAXI28+jmTxN5e/JFSct1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RlwIUKZ5XhtmqowDSIx/nnV537B8SeX/w5vG3AK/31uOe9UkWwMKg55GterdeTTqnI501MXsvmiW/afpwRDTxkimWR/U+D4gQBIXwszRhlYyPpzyEMIUD1+3Lu3IxeX/lJlM6gXu1WnKBUlrJZWTZ/LgroewNXzJ2+luyWT+gGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ns3alpPx; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-390df0138beso1333074f8f.0
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 08:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740760144; x=1741364944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sR0LCwQAT6BfH0Ja8fuTKM4sTupUtoZqymFDS0oD0g=;
        b=Ns3alpPxrtJ+3eXeo1arJAPEMyoUNHD1VBQb3IwBiQ9gOqCfKlvGiu3GK3oCWKqIO2
         BUJkN+RMCBJVzbt+7nNNP7hVTWJc1pSQMGWF4+OohDx1SB7r/nyLfH6QAKfmkLvM/ICw
         E1CJkQzI+8zxYPpZ3wOU3pXYMUTN7lYggFgP1qG3jmlR8TJ33YHLi2R1RenK9SEnk5Vv
         gWElZadMMebaXfMXR+xwAmWkF6Upl+yNJUGQPV0rLcwmqtJOcpSJtcbDxl/QOJwVybcV
         DFCt7KLU6H7QmgyNNEJOYMJ3ZL54tCyz0kiKuycdpM7RfyEA6RjfyXdXbOqB35ydnfu+
         MeGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740760144; x=1741364944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sR0LCwQAT6BfH0Ja8fuTKM4sTupUtoZqymFDS0oD0g=;
        b=RGiA39X419kvKKoEp7jBGh/C1dpoIFy+a5grIF0BOUpy9J15QBi4Blh9EhAbdzFSbM
         ebi8aXBvVC81LcaGqjtOTg/azp7bJ+vMAd/rOzNZOONIW361eY+X05m9RFHBRxjyk1Gy
         m910b/m2DVnKYf8qmvqakNiaPUYkXQWF47f/BNYzacfP1PbZmGSCYX2+R+/+jXWbNMHH
         DAJHHthEyFqAkpOq+5A3w4g+fQnpm/w3DLf+iy9JQePAcYbo3y2XvJYrijWIGK+KIvjN
         uOCLsGlwHvSCiAX1RxmQgnrdncly9zibP7AcwOfWHCoQCoGYeu1y3ebcCQthq6kfqrGH
         CoNg==
X-Gm-Message-State: AOJu0YwSC1YgUR9UoXJHlyW/ZhCOiiFzvxdQaz5BUPWlak0AjT6LZ5Tc
	JFCWTB2PCw9YHJU4MUzMRc6RfUrdUI+1jFUNlBIy3v1b1rptRcz2pWfCmrZSmuc=
X-Gm-Gg: ASbGnctHk/3GrC7HipUuYoEW/vmu9tV3Vs8u8Gob5bSsItY8TUBhySv+oHbxfp5BXWT
	tOz6vlkhptakLeHSpPv8IADg3liktaYr5eQf5zrJV8bzufC6Sg2wmmoiMpuChDyX51lFhfl5kkS
	j/bnpZISPtvZsJ3JJVtBUauIiDNsz3ow2dLH8efZvy+gB8HJzP+xoe+TEATvLxItpEyNfvh2w4H
	dS/drR9h8Fjza6Kv6HDl3j4t+nj2WhfIueB5BPS8BibW+1beBfpznVvlsygTxR26Dgf+DrSjvqE
	UsNtSk3M8Ffh/aXj
X-Google-Smtp-Source: AGHT+IGme5Dz5PwBNjoKPcO6BAyq+fc7LP8UGoK4W/eluu7FCfQ5WShj+TOMuavU7cJwBpFoXZVmzQ==
X-Received: by 2002:a05:6000:1849:b0:390:f698:ecd0 with SMTP id ffacd0b85a97d-390f698ed13mr702877f8f.11.1740760143418;
        Fri, 28 Feb 2025 08:29:03 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:72::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47965ddsm5826099f8f.18.2025.02.28.08.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 08:29:02 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Test sleepable global subprogs in atomic contexts
Date: Fri, 28 Feb 2025 08:28:58 -0800
Message-ID: <20250228162858.1073529-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250228162858.1073529-1-memxor@gmail.com>
References: <20250228162858.1073529-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8125; h=from:subject; bh=AG0zxT0Y+bM+xTx0wPhj/IAXI28+jmTxN5e/JFSct1s=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnwePvO4WYpHu+4wzob+3WUHJ8lb/xvyY8VjRTuqqw R3+c9lqJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8Hj7wAKCRBM4MiGSL8RykXjD/ 9FwjcQ11YWYkvwO212GisiPHOG/wuM01Wd2MZ34gNnNlY+HBceWL7T5GZ0uf+ImCA32L2yXxCPlPzW vPzTowg/VS1H6nBo9bN8CHqvEY+6fCdSmvpCwh6Gc74Vsdjvycu3c/2rGPV2hOHgVEvvbsnHPbmTBO 1XF/gXfNOUyhbY62p+04Z67ii3gpcjBVSc7hmNsFWeE2af95m87i2ZZJFpanUvne8jZ8j1y0ODFDGV rZYWZYOkVLK+LOrcdhK4alFNrTBrz60m+SdCBTzc8tNHaVJzN7mrn44VMaPJDHCOEW+y//FT2DQmOG 4zmCy5K9p712YZ8ZIjR/DtNNJCUHrWkxOShBcSAizvVRM4yDjX4lGxj/gBO7smQSMrrYrvOcpqu2vB lwAAW9DUb6FfOWr9XcLauf8XzQ5p4/vcgnpAK0eVUYl7lY+AixWN/doVjsHqAV4bhboAHJragrmZHK OtWMqSvXuiFLtPTXNWZK/PrXjI+JQvDTybCjXUdJBAooDFg7ZHzg9mQnhdKWOetf+v4snVOHe3Q9SA 69yLbeqcCOzuGicnQCnkhKln8hsI2x8nu2gRyH9qyr5YUvDfggawDkL5cHOo8uTAiT7whkvPOdCXIt 130TeqM8SDK9MdIDIOAr94BugzUep5h45jWDlot44kHhtobe/oV6oI1/UhQQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add tests for rejecting sleepable and accepting non-sleepable global
function calls in atomic contexts. For spin locks, we still reject
all global function calls. Once resilient spin locks land, we will
carefully lift in cases where we deem it safe.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/rcu_read_lock.c  |  2 +
 .../selftests/bpf/prog_tests/spin_lock.c      |  2 +
 tools/testing/selftests/bpf/progs/irq.c       | 62 ++++++++++++++++++-
 .../selftests/bpf/progs/preempt_lock.c        | 40 +++++++++++-
 .../selftests/bpf/progs/rcu_read_lock.c       | 38 ++++++++++++
 .../selftests/bpf/progs/test_spin_lock_fail.c | 40 ++++++++++++
 6 files changed, 182 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
index ebe0c12b5536..2a2e3a3b4c20 100644
--- a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
@@ -81,6 +81,8 @@ static const char * const inproper_region_tests[] = {
 	"nested_rcu_region",
 	"rcu_read_lock_global_subprog_lock",
 	"rcu_read_lock_global_subprog_unlock",
+	"rcu_read_lock_sleepable_helper_global_subprog",
+	"rcu_read_lock_sleepable_kfunc_global_subprog",
 };
 
 static void test_inproper_region(void)
diff --git a/tools/testing/selftests/bpf/prog_tests/spin_lock.c b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
index 2b0068742ef9..4652c44a0346 100644
--- a/tools/testing/selftests/bpf/prog_tests/spin_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
@@ -50,6 +50,8 @@ static struct {
 	{ "lock_id_mismatch_innermapval_mapval", "bpf_spin_unlock of different lock" },
 	{ "lock_global_subprog_call1", "global function calls are not allowed while holding a lock" },
 	{ "lock_global_subprog_call2", "global function calls are not allowed while holding a lock" },
+	{ "lock_global_sleepable_helper_subprog", "global function calls are not allowed while holding a lock" },
+	{ "lock_global_sleepable_kfunc_subprog", "global function calls are not allowed while holding a lock" },
 };
 
 static int match_regex(const char *pattern, const char *string)
diff --git a/tools/testing/selftests/bpf/progs/irq.c b/tools/testing/selftests/bpf/progs/irq.c
index b0b53d980964..e5e19f96faa0 100644
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
@@ -441,4 +441,64 @@ int irq_ooo_refs_array(struct __sk_buff *ctx)
 	return 0;
 }
 
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
+	return i;
+}
+
+int __noinline
+global_subprog(int i)
+{
+	if (i)
+		bpf_printk("%p", &i);
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
+int irq_sleepable_kfunc_global_subprog(void *ctx)
+{
+	unsigned long flags;
+
+	bpf_local_irq_save(&flags);
+	global_sleepable_kfunc_subprog(0);
+	bpf_local_irq_restore(&flags);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/preempt_lock.c b/tools/testing/selftests/bpf/progs/preempt_lock.c
index 6c5797bf0ead..c3bb7918442e 100644
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
@@ -143,4 +143,42 @@ int preempt_global_subprog_test(struct __sk_buff *ctx)
 	return 0;
 }
 
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
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
index ab3a532b7dd6..f7d2bdaed612 100644
--- a/tools/testing/selftests/bpf/progs/rcu_read_lock.c
+++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
@@ -439,3 +439,41 @@ int rcu_read_lock_global_subprog_unlock(void *ctx)
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
diff --git a/tools/testing/selftests/bpf/progs/test_spin_lock_fail.c b/tools/testing/selftests/bpf/progs/test_spin_lock_fail.c
index 1c8b678e2e9a..278ce14e3470 100644
--- a/tools/testing/selftests/bpf/progs/test_spin_lock_fail.c
+++ b/tools/testing/selftests/bpf/progs/test_spin_lock_fail.c
@@ -245,4 +245,44 @@ int lock_global_subprog_call2(struct __sk_buff *ctx)
 	return ret;
 }
 
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
 char _license[] SEC("license") = "GPL";
-- 
2.43.5


