Return-Path: <bpf+bounces-66279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D5AB31B52
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 16:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8611D274B1
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 14:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B605C3093C9;
	Fri, 22 Aug 2025 14:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kXLIR20p"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70261CAA6C
	for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 14:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872282; cv=none; b=D1LbAfdyGuzILU+qPRTFKC+zdWqPiEbz2Ho3oeHMbgQzLBOFMdAi2QGm0WdHh53NNn/92Fq9+QsBliVF72O7gALU9o7Hu9E2KLsCMc4vAtHuHnONQcRPftO1JnPk2VAuw5Y7BoqZmORogBu8Bit9FSCXlMqCQajsMK0Yo8ZESxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872282; c=relaxed/simple;
	bh=JDQHePOwIKsPKcNNL8ymLgyMUyblE28u2PdNrQ/Vu6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8XF0dcUnbJyD4jR1JSC+NzeiTu+0ite6kKqRmagEIAipdy5VXDOVtzVMLUsQ069cyPgEqgT3qE9oQHiazq5bxqV5zA2kO3zfO509RirhUFUGUJEq+LDec8VmCsiYWxio0LlnQ24p84ehSj9qknAlTaF0eQJmvztFfYPAYwmmrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kXLIR20p; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755872278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tdoTIuwmrHPNfnij8vsvynTTVefuDTtLZgNCpWIbWfE=;
	b=kXLIR20p+D/j/M1Nkv+EzwKSAg5/CQPRMGBibrjn7uoDJ3mfi3cl6g7EcMHhRjao1i9/om
	BSR08s2A35sm0NMFiVjVYgZ2kZ+ZAAGk/04Hp/tCaui+9XxDxJkOTs44EPsUk4aaYGJlmP
	8YTHgmBQbz2F8o6S53ytwzZ+OId8TMs=
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
Subject: [PATCH bpf-next 1/2] bpf: Introduce bpf_in_interrupt kfunc
Date: Fri, 22 Aug 2025 22:17:20 +0800
Message-ID: <20250822141722.25318-2-leon.hwang@linux.dev>
In-Reply-To: <20250822141722.25318-1-leon.hwang@linux.dev>
References: <20250822141722.25318-1-leon.hwang@linux.dev>
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
index cdffd74ddbe65..21e14697804e5 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3714,6 +3714,14 @@ __bpf_kfunc int bpf_strstr(const char *s1__ign, const char *s2__ign)
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
@@ -3754,6 +3762,7 @@ BTF_ID_FLAGS(func, bpf_throw)
 #ifdef CONFIG_BPF_EVENTS
 BTF_ID_FLAGS(func, bpf_send_signal_task, KF_TRUSTED_ARGS)
 #endif
+BTF_ID_FLAGS(func, bpf_in_interrupt, KF_FASTCALL)
 BTF_KFUNCS_END(generic_btf_ids)
 
 static const struct btf_kfunc_id_set generic_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4e47992361ea1..365d42140941d 100644
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
@@ -21973,6 +21975,15 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
 		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 		*cnt = 1;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_in_interrupt]) {
+#ifdef CONFIG_X86_64
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


