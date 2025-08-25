Return-Path: <bpf+bounces-66386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06251B34077
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 15:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DE3F7A2158
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 13:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA365269AE9;
	Mon, 25 Aug 2025 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rr22+v4D"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5236581749
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 13:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756127746; cv=none; b=AiXPSiIe/Gmb8Su3Y+uDPRpFobG4eJojineH+GayX7hxHKqz9UbUUm3qkWNu2rdr70RwGLkgdAy4WMgoWJEBsF9nPfCl6+vUVpXV+ZKJX6tmofm8VOKCfzlT9ciBm9cflHXDOoo7XzciSmgcxeFer4cCRQPr/WQwM+BungtJ79g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756127746; c=relaxed/simple;
	bh=8HHeGLwPrrOq1ESeIkbM7laWSaSaCmWjERF+oLr6+dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJmQZeCXuMOdUGyo/3meoMV23S9VFa838ApsI4UbXFFKPBF008QDHsEs2yAei/7ppcUiwWeV315jQajNqgyZlbwzRacoVvhawXoeHEafkKQVnglr81e+JiJYn3xnaJ/tq9sDqPMm8opOM7c+awdPh7fyNBWpEbMCnZdn5m8gQt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rr22+v4D; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756127742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BfIdF2YjMMonEr1ZQIa8jOh5sIYlN9BQa7m4Ssn10gs=;
	b=Rr22+v4DDZ6R0VnmhPp+6V6B97SxFjg0TcpUgF7ITdVuFaNIPvjDGLcLuBG10IFFoVS3L3
	u0jmOPWx9Kvka6dTxVEy1rIPSEDuUDUphngRqR0qdzMxbvQjxXiCKLB1C9tAvlpwQl8KRO
	qNNiG+uRCD88rDmVk4btiCtZchSrZ1o=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v2 1/2] bpf: Introduce bpf_in_interrupt kfunc
Date: Mon, 25 Aug 2025 21:15:00 +0800
Message-ID: <20250825131502.54269-2-leon.hwang@linux.dev>
In-Reply-To: <20250825131502.54269-1-leon.hwang@linux.dev>
References: <20250825131502.54269-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Filtering pid_tgid is meaningless when the current task is preempted by
an interrupt.

To address this, introduce the bpf_in_interrupt kfunc, which allows BPF
programs to determine whether they are executing in interrupt context.

This enables programs to avoid applying pid_tgid filtering when running
in such contexts.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/helpers.c  |  9 +++++++++
 kernel/bpf/verifier.c | 11 +++++++++++
 2 files changed, 20 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 401b4932cc49f..38991b7b4a9e9 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3711,6 +3711,14 @@ __bpf_kfunc int bpf_strstr(const char *s1__ign, const char *s2__ign)
 	return bpf_strnstr(s1__ign, s2__ign, XATTR_SIZE_MAX);
 }
 
+/**
+ * bpf_in_interrupt - Check whether it's in interrupt context
+ */
+__bpf_kfunc int bpf_in_interrupt(void)
+{
+	return in_interrupt();
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -3751,6 +3759,7 @@ BTF_ID_FLAGS(func, bpf_throw)
 #ifdef CONFIG_BPF_EVENTS
 BTF_ID_FLAGS(func, bpf_send_signal_task, KF_TRUSTED_ARGS)
 #endif
+BTF_ID_FLAGS(func, bpf_in_interrupt, KF_FASTCALL)
 BTF_KFUNCS_END(generic_btf_ids)
 
 static const struct btf_kfunc_id_set generic_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5c9dd16b2c56b..e30ecbfc29dad 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12259,6 +12259,7 @@ enum special_kfunc_type {
 	KF_bpf_res_spin_lock_irqsave,
 	KF_bpf_res_spin_unlock_irqrestore,
 	KF___bpf_trap,
+	KF_bpf_in_interrupt,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12327,6 +12328,7 @@ BTF_ID(func, bpf_res_spin_unlock)
 BTF_ID(func, bpf_res_spin_lock_irqsave)
 BTF_ID(func, bpf_res_spin_unlock_irqrestore)
 BTF_ID(func, __bpf_trap)
+BTF_ID(func, bpf_in_interrupt)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -21977,6 +21979,15 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
 		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 		*cnt = 1;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_in_interrupt]) {
+#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
+		insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, (u32)(unsigned long)&__preempt_count);
+		insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
+		insn_buf[2] = BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0);
+		insn_buf[3] = BPF_ALU32_IMM(BPF_AND, BPF_REG_0, NMI_MASK | HARDIRQ_MASK |
+					    (IS_ENABLED(CONFIG_PREEMPT_RT) ? 0 : SOFTIRQ_MASK));
+		*cnt = 4;
+#endif
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
-- 
2.50.1


