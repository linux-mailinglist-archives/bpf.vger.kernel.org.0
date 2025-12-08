Return-Path: <bpf+bounces-76234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 372BCCABC30
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 02:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 907563001BF0
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 01:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E87245012;
	Mon,  8 Dec 2025 01:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpkkoN0M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F97242D79
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 01:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765159018; cv=none; b=GdMQ9Dix1zSpTNFunvwCY2BUkaBNCo3k40tA3QUYuz83RrH72Nf8rMam36sHPvVdizJfpsxF5uKw8jSsZIy8Xqqmf2sDziAVZEQ1/ZOmLAhEfVeP+/DlpvYjX3RKTR4C1Vkk052zHwXDpb0kURY/6XBoP0J4MLcOJ5Q0S9fyc8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765159018; c=relaxed/simple;
	bh=zp7DCe3OPNUE7Gs5lDIrOSgrrum+Uomuj52oDMjwgqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bT0A7ztec/7A+gJ4AmqR5+9k1sLJspsuZLTlszHdSgU1StfDWYKVG+WBtn2GauedpnQphGGlu1PymAIwz0K4qnwTtR58O3zEEaJoIcS16JIEcfatpo5PcGvE5QvygQjRTmQDzTU7B6WR1fYJRBzzZ+EI/+jML4FLE1pZW51ABbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpkkoN0M; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso6329631b3a.1
        for <bpf@vger.kernel.org>; Sun, 07 Dec 2025 17:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765159015; x=1765763815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3K1aiztFWVbLc9YGbXfDE+d485fnE36nV6vysp1loIc=;
        b=lpkkoN0MCJusix3gJGUfCb0R1kEwz9p9RZhL2ZNneLRT5DZ1cubyRcz7EFjqFs9pRx
         1XCLovt7Dx8LYA9lk4mN/ho+aXMcyLYIty8SVBoGwckGO2IpwdPCzZLcuadYSSdqH+hj
         K+EU9Jt1gl3XXRSxMPQbe1Ximh8ACqPgXOUPNTKtp27M1HEmI5bBHuAZVuFApWQ3HwBw
         InlCQ1H6mPvoxZWIF1QIxdxdath0xfB+iMR6oIdo5HBNpSs4msBch8NS6/ep0vyblpXo
         3sny2e3oKpPTstjjvDH5aeH1OEhKtfIKwWQyT3mWI6LsF4L5+sJq3KbW5aofDcey0xdA
         uYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765159015; x=1765763815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3K1aiztFWVbLc9YGbXfDE+d485fnE36nV6vysp1loIc=;
        b=QgpaJUfHsH7Vo6kpbpXmOMBsNkmCxx1lSkA8v58h1YmKZ80edapy8wfmf6m1JS3T0j
         e4+IaQY4RvbRuyRQZZgXcuvgDQTibpJXGUODVmi/TyEApwAo9Ms2HvRaPRgDWIZpC1++
         +FE9SByYUk17rX6DNIE6zcE1cJXF8aczzyYTrl2WhVkr84uyEGryPkoDZxG5snRiFRkt
         VElbgGuXHZ2+bqWQBKIWIvfongK+64O0sZ0cp/PbSWvVwBbMIpFzKvK2B4kb6Gt6220/
         SV2WQ9F6DFQv4YhHYY+35d9X2rDXBT+iVosC/qQr8vFZ+evK0Kzrtunw2X95tu0Q8P16
         MHCw==
X-Gm-Message-State: AOJu0YydXZU9+f0ketLT7/gRsfAG+Jgu9a8CO83JEhy4690ktkYsujX4
	uokRZaqquWfOlpgVR/YJNm6Aue28eKfb52rKgjfRt9sfMucOt+TlWDA/luHa1d/u
X-Gm-Gg: ASbGncsNN3P3hJsS/5r9MmfL7bID9yBGcu8eIfHuiACgC85wb+84fQgsI+FsjX8yKY2
	s7M+3Dh0KWu4rj34pAbLkxyu46MSw2S/KinT/ZQEYsRx9lf2hfzR2gRbITSBzcePVmm9tr6kOVg
	8JpVyuyjev/yk8mleb/XijbQkBMYQtTekoQEVs1aNsvldvUjLUv4Gx3DVVso5sqN668MJ6qvfM9
	Qazmok2WOz/eKMVQwTUTw++oehgI8pIwhK0Rb32vMJRtqJLBEPqTqnuv9sARfjnAK+dYqvf7xLQ
	KQEMz1VqQICHYspr2nuoqEieU40NRhqpqUN7PnLMk67CWdRhW3XPD7oQy4S+Dma1OfJinnKzedJ
	uIjTpk3I5z0Oq6AVeLlSFRZ9iaCny0au/vavRC0ldaPiAvHI/tYFsXvd/SCEUYd1gXw4u25KalN
	VdOu4Akg==
X-Google-Smtp-Source: AGHT+IH+KJf9oVOloEGQkaEOd4Vfc86vOQFsIKF3d/R2AlZjTxnwkORJgIV6e81e1QxDIIo7E/pHFQ==
X-Received: by 2002:a05:6a20:4303:b0:35d:5d40:6d7e with SMTP id adf61e73a8af0-36617e8d8a5mr6554372637.34.1765159014977;
        Sun, 07 Dec 2025 17:56:54 -0800 (PST)
Received: from Tunnel ([64.104.44.99])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf748c6bcacsm10046882a12.0.2025.12.07.17.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 17:56:53 -0800 (PST)
Date: Mon, 8 Dec 2025 10:56:49 +0900
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next 1/8] bpf: Save pruning point states in oracle
Message-ID: <8739a850ecbb0454e4cbb2dc1103ba9429ea0aef.1765158924.git.paul.chaignon@gmail.com>
References: <cover.1765158924.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1765158924.git.paul.chaignon@gmail.com>

This patch saves information on the verifier states, at each pruning
point, into bpf_insn_aux_data, for use by the BPF oracle. The verifier
is already saving states into explored_states for state pruning, but we
can't reuse it for the oracle.

For state pruning, we only save a subset of all states at each pruning
point. Specifically, we will only save a new state if we've seen at
least 8 instructions and 2 BPF_JMPs since we last saved a state. For the
oracle, we will use the saved information to ensure that concrete values
match at least one verifier state. If we are missing states, we will
have false positives.

This patch therefore saves information on verifier states at every
pruning point, regardless of existing heuristics. A later patch will
limit this behavior to CONFIG_BPF_ORACLE.

At the moment, the oracle only saves information on the type and ranges
(in case of scalars) of registers. No information is kept for stack
slots. More checks can be added later.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 include/linux/bpf_verifier.h | 34 +++++++++++++++++++
 kernel/bpf/Makefile          |  2 +-
 kernel/bpf/oracle.c          | 63 ++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        | 11 +++----
 4 files changed, 103 insertions(+), 7 deletions(-)
 create mode 100644 kernel/bpf/oracle.c

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 130bcbd66f60..adaeff35aaa6 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -485,6 +485,30 @@ struct bpf_verifier_state_list {
 	u32 in_free_list:1;
 };
 
+struct bpf_reg_oracle_state {
+	bool scalar;
+	bool ptr_not_null;
+
+	struct tnum var_off;
+	s64 smin_value;
+	s64 smax_value;
+	u64 umin_value;
+	u64 umax_value;
+	s32 s32_min_value;
+	s32 s32_max_value;
+	u32 u32_min_value;
+	u32 u32_max_value;
+};
+
+struct bpf_oracle_state {
+	struct bpf_reg_oracle_state regs[MAX_BPF_REG - 1];
+};
+
+struct bpf_oracle_state_list {
+	struct bpf_oracle_state state;
+	struct list_head node;
+};
+
 struct bpf_loop_inline_state {
 	unsigned int initialized:1; /* set to true upon first entry */
 	unsigned int fit_for_inline:1; /* true if callback function is the same
@@ -551,6 +575,7 @@ struct bpf_insn_aux_data {
 	};
 	struct bpf_iarray *jt;	/* jump table for gotox or bpf_tailcall call instruction */
 	struct btf_struct_meta *kptr_struct_meta;
+	struct list_head *oracle_states;
 	u64 map_key_state; /* constant (32 bit) key tracking for maps */
 	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
 	u32 seen; /* this insn was processed by the verifier at env->pass_cnt */
@@ -1060,11 +1085,18 @@ static inline bool insn_is_gotox(struct bpf_insn *insn)
 	       BPF_SRC(insn->code) == BPF_X;
 }
 
+static inline struct bpf_insn_aux_data *cur_aux(const struct bpf_verifier_env *env)
+{
+	return &env->insn_aux_data[env->insn_idx];
+}
+
 const char *reg_type_str(struct bpf_verifier_env *env, enum bpf_reg_type type);
 const char *dynptr_type_str(enum bpf_dynptr_type type);
 const char *iter_type_str(const struct btf *btf, u32 btf_id);
 const char *iter_state_str(enum bpf_iter_state state);
 
+bool reg_not_null(const struct bpf_reg_state *reg);
+
 void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifier_state *vstate,
 			  u32 frameno, bool print_all);
 void print_insn_state(struct bpf_verifier_env *env, const struct bpf_verifier_state *vstate,
@@ -1087,4 +1119,6 @@ int bpf_live_stack_query_init(struct bpf_verifier_env *env, struct bpf_verifier_
 bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 spi);
 void bpf_reset_live_stack_callchain(struct bpf_verifier_env *env);
 
+int save_state_in_oracle(struct bpf_verifier_env *env, int insn_idx);
+
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 232cbc97434d..b94c9af3288a 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -6,7 +6,7 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
 endif
 CFLAGS_core.o += -Wno-override-init $(cflags-nogcse-yy)
 
-obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o token.o liveness.o
+obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o oracle.o log.o token.o liveness.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_insn_array.o
diff --git a/kernel/bpf/oracle.c b/kernel/bpf/oracle.c
new file mode 100644
index 000000000000..adbb153aadee
--- /dev/null
+++ b/kernel/bpf/oracle.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This file implements a test oracle for the verifier. When the oracle is enabled, the verifier
+ * saves information on variables at regular points throughout the program. This information is
+ * then compared at runtime with the concrete values to ensure that the verifier's information is
+ * correct.
+ */
+
+#include <linux/bpf_verifier.h>
+
+static void convert_oracle_state(struct bpf_verifier_state *istate, struct bpf_oracle_state *ostate)
+{
+	struct bpf_func_state *frame = istate->frame[istate->curframe];
+	struct bpf_reg_oracle_state *oreg;
+	struct bpf_reg_state *ireg;
+	int i;
+
+	/* No need to check R10 with the oracle. */
+	for (i = 0; i < MAX_BPF_REG - 1; i++) {
+		ireg = &frame->regs[i];
+		oreg = &ostate->regs[i];
+
+		oreg->scalar = ireg->type == SCALAR_VALUE;
+		oreg->ptr_not_null = reg_not_null(ireg);
+
+		oreg->var_off = ireg->var_off;
+		oreg->smin_value = ireg->smin_value;
+		oreg->smax_value = ireg->smax_value;
+		oreg->umin_value = ireg->umin_value;
+		oreg->umax_value = ireg->umax_value;
+		oreg->s32_min_value = ireg->s32_min_value;
+		oreg->s32_max_value = ireg->s32_max_value;
+		oreg->u32_min_value = ireg->u32_min_value;
+		oreg->u32_max_value = ireg->u32_max_value;
+	}
+}
+
+int save_state_in_oracle(struct bpf_verifier_env *env, int insn_idx)
+{
+	struct bpf_verifier_state *cur = env->cur_state;
+	struct bpf_insn_aux_data *aux = cur_aux(env);
+	struct bpf_oracle_state_list *new_sl;
+
+	if (env->subprog_cnt > 1)
+		/* Skip the oracle if subprogs are used. */
+		return 0;
+
+	if (!aux->oracle_states) {
+		aux->oracle_states = kmalloc(sizeof(*aux->oracle_states), GFP_KERNEL_ACCOUNT);
+		if (!aux->oracle_states)
+			return -ENOMEM;
+
+		INIT_LIST_HEAD(aux->oracle_states);
+	}
+
+	new_sl = kzalloc(sizeof(*new_sl), GFP_KERNEL_ACCOUNT);
+	if (!new_sl)
+		return -ENOMEM;
+	convert_oracle_state(cur, &new_sl->state);
+	list_add(&new_sl->node, aux->oracle_states);
+
+	return 0;
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb7eca1025c3..2e48e5c9abae 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -394,7 +394,7 @@ static void verbose_invalid_scalar(struct bpf_verifier_env *env,
 	verbose(env, " should have been in [%d, %d]\n", range.minval, range.maxval);
 }
 
-static bool reg_not_null(const struct bpf_reg_state *reg)
+bool reg_not_null(const struct bpf_reg_state *reg)
 {
 	enum bpf_reg_type type;
 
@@ -11398,11 +11398,6 @@ static int check_get_func_ip(struct bpf_verifier_env *env)
 	return -ENOTSUPP;
 }
 
-static struct bpf_insn_aux_data *cur_aux(const struct bpf_verifier_env *env)
-{
-	return &env->insn_aux_data[env->insn_idx];
-}
-
 static bool loop_flag_is_zero(struct bpf_verifier_env *env)
 {
 	struct bpf_reg_state *regs = cur_regs(env);
@@ -20508,6 +20503,10 @@ static int do_check(struct bpf_verifier_env *env)
 		state->insn_idx = env->insn_idx;
 
 		if (is_prune_point(env, env->insn_idx)) {
+			err = save_state_in_oracle(env, env->insn_idx);
+			if (err < 0)
+				return err;
+
 			err = is_state_visited(env, env->insn_idx);
 			if (err < 0)
 				return err;
-- 
2.43.0


