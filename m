Return-Path: <bpf+bounces-45849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB589DBE32
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 01:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AD4FB2274D
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 00:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F150F79CD;
	Fri, 29 Nov 2024 00:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4VPj0w2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FB8C125
	for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 00:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732839404; cv=none; b=S7qem2QU8I29tA744E/+NkoQAE0dk/J5RcBGszu0Glp1sCLtYkkLo36YplQCO60+knVGk6tC8wlyS32/PX1/U9FYvdKN/a9xoQnQKMRIV8n0nAFXfiOHCHTmGhlxrkeA4a4CP0kOMDiJdpNGfiB3mkU3jGBNBLv+E7KYP6hc6vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732839404; c=relaxed/simple;
	bh=Eqist5EF6kM0g9yDwdKlpnv8BU/DoFwUHhQOQODmouQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KSE9JE17BZMYTBnBF2yZFVJG3o1cvn335/SaZZJs3ymNlY0GZjYkNQWSK8c8lzMFaahbnXdBhlOu9jffjfhP6viuZnsyg/VuEErtXGduZhpNTHNm0r4M/4mRFImMzGOA2T2CD5R+7VCe+MlA9nlBMgJlWtwKDI8xQXRwazQ4olM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4VPj0w2; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-434a90fed23so11619445e9.1
        for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 16:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732839400; x=1733444200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6N/ktO79YDm8YOvCtZMcch3+5HiPxcrffnU4/297hE=;
        b=Y4VPj0w23EdrDHGxqXQ1pD99wSpKb7QPVmAxe5SSrxMvn9Q7DYvaUvv/Id2McNA1KE
         GSHJlWCqI7SaNFpnEex4aSC3HSg4t9XG/rd0oe6NnODZl6ADjk1HuBvMRDqtZCvplgJI
         F2p8QkxAFu/04Dl1v2QISwNo5cx0mqR+JAw5NK6b5O40J5aYUKehNw5TlmjiW1bnzyD+
         bfFgfgVqnZxQxOqKfsh7u6Y3WvMnQtinkzjGq11GCx3nDy19HfqRM3Ipj0ky6hEjWnn7
         2iZgHm+vwoPINkn8PwHXjHP7OMqEKN1QTX/AEqNMERGpDddyE+I7egDg1zKnuF62ZC8c
         9wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732839400; x=1733444200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6N/ktO79YDm8YOvCtZMcch3+5HiPxcrffnU4/297hE=;
        b=oxaoTNbMTMxARPKC80udLWYJjQecmNZHxVyhuZlpcAydP/DTZ8q44tbqOwNYRImHtp
         ftS+LrSWPeJNxnDOj2JDJIClBkDqf5O1JBMlMPdsu8B8SWVGm6LYKZgOH5PqA1E0P7+p
         chkGwpNJ13NK2/mfCwu6yh49axKIs1JX5vURo6P9ST9A/M7YA2uWHJQIK06xjC2MepSm
         97VsvuJ9a5Dyrrwjlzdzl70h4FhHGnZb3fI2w+2JDdum3HrvCJJDEp27GG2tYreeVdVD
         RKHyEtq8BJ1Ljkwss5nQA8DZFDqJ9+TejPS+LlrfSs6Q0RCt5TbxScFlOvAKT0YJQt/v
         d38g==
X-Gm-Message-State: AOJu0YxyTOjds8y7DOjMc9VL4UofaMA2OanI4S7g8c8ykjEitxCDx0Qk
	vfYY5nwTKepN6XpT8BXyA6IZ6rvEQd/M0lTrJhloA2weVq1pTiK7gObsWHYtG4g=
X-Gm-Gg: ASbGncsOFPoZobH/A9saUKBbXnD5w+vWY06XpgTb5dNjcCUo4dofngB+RHjEnag48No
	Zi7vA7tt9k5WwR7Xl87n9eKAOMncDbdT28QSxxz/MkIoH9uCkdfzIK6qfOtIli+Goj50OFqUARK
	erUw8hMrLCxd8t3GqA01I3Fzm0uI5Z83gafBJQ5cTnuGZ78h/F0asaAGZ7x9yd1fyMlkHbk6dyI
	b3UMIS+F/kPS/BHvPNQGC1iCN+pb4JAtyytsVqqCfTsG24DTEBH5SEOGersMkUS7TkMbTkBbbkz
	Lw==
X-Google-Smtp-Source: AGHT+IFsnBsr6qsweeL6EuR9EQZVuf6ULCn9MVBWSbXuPHNnaVz1h/qhyKDmKxqg9s5dZGBKyPrq5g==
X-Received: by 2002:a05:600c:354e:b0:434:a802:e9b2 with SMTP id 5b1f17b1804b1-434a9dbc589mr86194995e9.4.1732839399548;
        Thu, 28 Nov 2024 16:16:39 -0800 (PST)
Received: from localhost (fwdproxy-cln-038.fbsv.net. [2a03:2880:31ff:26::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd80435sm2804370f8f.100.2024.11.28.16.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 16:16:38 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 4/7] bpf: Introduce support for bpf_local_irq_{save,restore}
Date: Thu, 28 Nov 2024 16:16:29 -0800
Message-ID: <20241129001632.3828611-5-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241129001632.3828611-1-memxor@gmail.com>
References: <20241129001632.3828611-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=20208; h=from:subject; bh=Eqist5EF6kM0g9yDwdKlpnv8BU/DoFwUHhQOQODmouQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnSQfcn2aMT0RwjJT+JuhEPr+jGWxiAEqRMpaalawH OJX9XkSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0kH3AAKCRBM4MiGSL8Ryo9DD/ 9GMwlL8FRR+0dCTCiNLJ7Av3Rq7h/GO3Ho7AyLikLdHJG4uC+xuazJJYB0CXaP+Wf8RTGvyI54/VVV cdI+nIluyOB1eqSqRVfsflykp5uPiL4g63X+QRYORpO4sQJBiqodC9Sd4v/vCT7us8dfdyn6fkWYzG 36Pne3XKF94ByYvPDXC1fcBrKxEPINMuXalzEqo2UYoldZZ7Eccy41jJPxdTUau/Zwa0KKbDUoyYHX PofpkleblnT/Cr2BodvX+cZAeJpCtwATevlPDbyUOEq64Sk6mWZe+Dm9Fv5HeO3n3pDSZp0ZZeHBVM 0eNInblCEH8nO6fpFN/tLYhIeq0eoXG8dZY8ym8UVbjJ4eJWVsjhqsifdtVLzUFaNDYoqDocYzRdmd zRWtKR6tjadbhiEL5d66+bLJtbCHWTSWBo0D6OYKdMUK2lHTGOlpW3YE6yn8cdiRLppS1os4UgUbQf V0dQuTr2JuO0K+DZiNsKVLQ8ZR4v50jh97+ZmFr0hzNW8a7/v3jZQy9yrhr7pwCXrdtfinhC7RVL/B YKyZbscIFLSgt7jd/M5rvSdERLb403gh7b63h3Alq9PjA4I4pUivKLBsh/Bcv/VdgzLSZuW4wdRof8 8ob8lF/4bRtGY/gsNjtmxH2nCBoHUAPFQJvU2kkHp9J6x+jGXJvlCz+Y+wsg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Teach the verifier about IRQ-disabled sections through the introduction
of two new kfuncs, bpf_local_irq_save, to save IRQ state and disable
them, and bpf_local_irq_restore, to restore IRQ state and enable them
back again.

For the purposes of tracking the saved IRQ state, the verifier is taught
about a new special object on the stack of type STACK_IRQ_FLAG. This is
a 8 byte value which saves the IRQ flags which are to be passed back to
the IRQ restore kfunc.

Renumber the enums for REF_TYPE_* to simplify the check in
find_lock_state, filtering out non-lock types as they grow will become
cumbersome and is unecessary.

To track a dynamic number of IRQ-disabled regions and their associated
saved states, a new resource type RES_TYPE_IRQ is introduced, which its
state management functions: acquire_irq_state and release_irq_state,
taking advantage of the refactoring and clean ups made in earlier
commits.

One notable requirement of the kernel's IRQ save and restore API is that
they cannot happen out of order. For this purpose, when releasing reference
we keep track of the prev_id we saw with REF_TYPE_IRQ. Since reference
states are inserted in increasing order of the index, this is used to
remember the ordering of acquisitions of IRQ saved states, so that we
maintain a logical stack in acquisition order of resource identities,
and can enforce LIFO ordering when restoring IRQ state. The top of the
stack is maintained using bpf_verifier_state's active_irq_id.

To maintain the stack property when releasing reference states, we need
to modify release_reference_state to instead shift the remaining array
left using memmove instead of swapping deleted element with last that
might break the ordering. A selftest to test this subtle behavior is
added in late patches.

The logic to detect initialized and unitialized irq flag slots, marking
and unmarking is similar to how it's done for iterators. No additional
checks are needed in refsafe for REF_TYPE_IRQ, apart from the usual
check_id satisfiability check on the ref[i].id. We have to perform the
same check_ids check on state->active_irq_id as well.

The kfuncs themselves are plain wrappers over local_irq_save and
local_irq_restore macros.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |   8 +-
 kernel/bpf/helpers.c         |  17 ++
 kernel/bpf/log.c             |   1 +
 kernel/bpf/verifier.c        | 298 ++++++++++++++++++++++++++++++++++-
 4 files changed, 320 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 03e351c43fa8..c8ea5efd147b 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -233,6 +233,7 @@ enum bpf_stack_slot_type {
 	 */
 	STACK_DYNPTR,
 	STACK_ITER,
+	STACK_IRQ_FLAG,
 };
 
 #define BPF_REG_SIZE 8	/* size of eBPF register in bytes */
@@ -254,8 +255,10 @@ struct bpf_reference_state {
 	 * default to pointer reference on zero initialization of a state.
 	 */
 	enum ref_state_type {
-		REF_TYPE_PTR = 0,
-		REF_TYPE_LOCK,
+		REF_TYPE_PTR	= 1,
+		REF_TYPE_IRQ	= 2,
+
+		REF_TYPE_LOCK	= 3,
 	} type;
 	/* Track each reference created with a unique id, even if the same
 	 * instruction creates the reference multiple times (eg, via CALL).
@@ -421,6 +424,7 @@ struct bpf_verifier_state {
 	u32 acquired_refs;
 	u32 active_locks;
 	u32 active_preempt_locks;
+	u32 active_irq_id;
 	bool active_rcu_lock;
 
 	bool speculative;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 751c150f9e1c..532ea74d4850 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3057,6 +3057,21 @@ __bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void __user
 	return ret + 1;
 }
 
+/* Keep unsinged long in prototype so that kfunc is usable when emitted to
+ * vmlinux.h in BPF programs directly, but note that while in BPF prog, the
+ * unsigned long always points to 8-byte region on stack, the kernel may only
+ * read and write the 4-bytes on 32-bit.
+ */
+__bpf_kfunc void bpf_local_irq_save(unsigned long *flags__irq_flag)
+{
+	local_irq_save(*flags__irq_flag);
+}
+
+__bpf_kfunc void bpf_local_irq_restore(unsigned long *flags__irq_flag)
+{
+	local_irq_restore(*flags__irq_flag);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -3149,6 +3164,8 @@ BTF_ID_FLAGS(func, bpf_get_kmem_cache)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_new, KF_ITER_NEW | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_local_irq_save)
+BTF_ID_FLAGS(func, bpf_local_irq_restore)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 2d28ce926053..38050f4ee400 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -537,6 +537,7 @@ static char slot_type_char[] = {
 	[STACK_ZERO]	= '0',
 	[STACK_DYNPTR]	= 'd',
 	[STACK_ITER]	= 'i',
+	[STACK_IRQ_FLAG] = 'f'
 };
 
 static void print_liveness(struct bpf_verifier_env *env,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 992992816308..9c0315fffa07 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -661,6 +661,11 @@ static int iter_get_spi(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 	return stack_slot_obj_get_spi(env, reg, "iter", nr_slots);
 }
 
+static int irq_flag_get_spi(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+{
+	return stack_slot_obj_get_spi(env, reg, "irq_flag", 1);
+}
+
 static enum bpf_dynptr_type arg_to_dynptr_type(enum bpf_arg_type arg_type)
 {
 	switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
@@ -1156,10 +1161,136 @@ static int is_iter_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_s
 	return 0;
 }
 
+static int acquire_irq_state(struct bpf_verifier_env *env, int insn_idx);
+static int release_irq_state(struct bpf_verifier_state *state, int id);
+
+static int mark_stack_slot_irq_flag(struct bpf_verifier_env *env,
+				     struct bpf_kfunc_call_arg_meta *meta,
+				     struct bpf_reg_state *reg, int insn_idx)
+{
+	struct bpf_func_state *state = func(env, reg);
+	struct bpf_stack_state *slot;
+	struct bpf_reg_state *st;
+	int spi, i, id;
+
+	spi = irq_flag_get_spi(env, reg);
+	if (spi < 0)
+		return spi;
+
+	id = acquire_irq_state(env, insn_idx);
+	if (id < 0)
+		return id;
+
+	slot = &state->stack[spi];
+	st = &slot->spilled_ptr;
+
+	__mark_reg_known_zero(st);
+	st->type = PTR_TO_STACK; /* we don't have dedicated reg type */
+	st->live |= REG_LIVE_WRITTEN;
+	st->ref_obj_id = id;
+
+	for (i = 0; i < BPF_REG_SIZE; i++)
+		slot->slot_type[i] = STACK_IRQ_FLAG;
+
+	mark_stack_slot_scratched(env, spi);
+	return 0;
+}
+
+static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+{
+	struct bpf_func_state *state = func(env, reg);
+	struct bpf_stack_state *slot;
+	struct bpf_reg_state *st;
+	int spi, i, err;
+
+	spi = irq_flag_get_spi(env, reg);
+	if (spi < 0)
+		return spi;
+
+	slot = &state->stack[spi];
+	st = &slot->spilled_ptr;
+
+	err = release_irq_state(env->cur_state, st->ref_obj_id);
+	WARN_ON_ONCE(err && err != -EACCES);
+	if (err) {
+		int insn_idx = 0;
+
+		for (int i = 0; i < env->cur_state->acquired_refs; i++) {
+			if (env->cur_state->refs[i].id == env->cur_state->active_irq_id) {
+				insn_idx = env->cur_state->refs[i].insn_idx;
+				break;
+			}
+		}
+
+		verbose(env, "cannot restore irq state out of order, expected id=%d acquired at insn_idx=%d\n",
+			env->cur_state->active_irq_id, insn_idx);
+		return err;
+	}
+
+	__mark_reg_not_init(env, st);
+
+	/* see unmark_stack_slots_dynptr() for why we need to set REG_LIVE_WRITTEN */
+	st->live |= REG_LIVE_WRITTEN;
+
+	for (i = 0; i < BPF_REG_SIZE; i++)
+		slot->slot_type[i] = STACK_INVALID;
+
+	mark_stack_slot_scratched(env, spi);
+	return 0;
+}
+
+static bool is_irq_flag_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+{
+	struct bpf_func_state *state = func(env, reg);
+	struct bpf_stack_state *slot;
+	int spi, i;
+
+	/* For -ERANGE (i.e. spi not falling into allocated stack slots), we
+	 * will do check_mem_access to check and update stack bounds later, so
+	 * return true for that case.
+	 */
+	spi = irq_flag_get_spi(env, reg);
+	if (spi == -ERANGE)
+		return true;
+	if (spi < 0)
+		return false;
+
+	slot = &state->stack[spi];
+
+	for (i = 0; i < BPF_REG_SIZE; i++)
+		if (slot->slot_type[i] == STACK_IRQ_FLAG)
+			return false;
+	return true;
+}
+
+static int is_irq_flag_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+{
+	struct bpf_func_state *state = func(env, reg);
+	struct bpf_stack_state *slot;
+	struct bpf_reg_state *st;
+	int spi, i;
+
+	spi = irq_flag_get_spi(env, reg);
+	if (spi < 0)
+		return -EINVAL;
+
+	slot = &state->stack[spi];
+	st = &slot->spilled_ptr;
+
+	if (!st->ref_obj_id)
+		return -EINVAL;
+
+	for (i = 0; i < BPF_REG_SIZE; i++)
+		if (slot->slot_type[i] != STACK_IRQ_FLAG)
+			return -EINVAL;
+	return 0;
+}
+
 /* Check if given stack slot is "special":
  *   - spilled register state (STACK_SPILL);
  *   - dynptr state (STACK_DYNPTR);
  *   - iter state (STACK_ITER).
+ *   - irq flag state (STACK_IRQ_FLAG)
  */
 static bool is_stack_slot_special(const struct bpf_stack_state *stack)
 {
@@ -1169,6 +1300,7 @@ static bool is_stack_slot_special(const struct bpf_stack_state *stack)
 	case STACK_SPILL:
 	case STACK_DYNPTR:
 	case STACK_ITER:
+	case STACK_IRQ_FLAG:
 		return true;
 	case STACK_INVALID:
 	case STACK_MISC:
@@ -1291,6 +1423,7 @@ static int copy_reference_state(struct bpf_verifier_state *dst, const struct bpf
 	dst->active_locks = src->active_locks;
 	dst->active_preempt_locks = src->active_preempt_locks;
 	dst->active_rcu_lock = src->active_rcu_lock;
+	dst->active_irq_id = src->active_irq_id;
 	return 0;
 }
 
@@ -1392,13 +1525,34 @@ static int acquire_lock_state(struct bpf_verifier_env *env, int insn_idx, enum r
 	return 0;
 }
 
+static int acquire_irq_state(struct bpf_verifier_env *env, int insn_idx)
+{
+	struct bpf_verifier_state *state = env->cur_state;
+	struct bpf_reference_state *s;
+
+	s = acquire_reference_state(env, insn_idx, true);
+	if (!s)
+		return -ENOMEM;
+	s->type = REF_TYPE_IRQ;
+
+	state->active_irq_id = s->id;
+	return s->id;
+}
+
 static void release_reference_state(struct bpf_verifier_state *state, int idx)
 {
 	int last_idx;
+	size_t rem;
 
+	/* IRQ state requires the relative ordering of elements remaining the
+	 * same, since it relies on the refs array to behave as a stack, so that
+	 * it can detect out-of-order IRQ restore. Hence use memmove to shift
+	 * the array instead of swapping the final element into the deleted idx.
+	 */
 	last_idx = state->acquired_refs - 1;
+	rem = state->acquired_refs - idx - 1;
 	if (last_idx && idx != last_idx)
-		memcpy(&state->refs[idx], &state->refs[last_idx], sizeof(*state->refs));
+		memmove(&state->refs[idx], &state->refs[idx + 1], sizeof(*state->refs) * rem);
 	memset(&state->refs[last_idx], 0, sizeof(*state->refs));
 	state->acquired_refs--;
 	return;
@@ -1420,6 +1574,28 @@ static int release_lock_state(struct bpf_verifier_state *state, int type, int id
 	return -EINVAL;
 }
 
+static int release_irq_state(struct bpf_verifier_state *state, int id)
+{
+	u32 prev_id = 0;
+	int i;
+
+	if (id != state->active_irq_id)
+		return -EACCES;
+
+	for (i = 0; i < state->acquired_refs; i++) {
+		if (state->refs[i].type != REF_TYPE_IRQ)
+			continue;
+		if (state->refs[i].id == id) {
+			release_reference_state(state, i);
+			state->active_irq_id = prev_id;
+			return 0;
+		} else {
+			prev_id = state->refs[i].id;
+		}
+	}
+	return -EINVAL;
+}
+
 static struct bpf_reference_state *find_lock_state(struct bpf_verifier_state *state, enum ref_state_type type,
 						   int id, void *ptr)
 {
@@ -1428,7 +1604,7 @@ static struct bpf_reference_state *find_lock_state(struct bpf_verifier_state *st
 	for (i = 0; i < state->acquired_refs; i++) {
 		struct bpf_reference_state *s = &state->refs[i];
 
-		if (s->type == REF_TYPE_PTR || s->type != type)
+		if (s->type != type)
 			continue;
 
 		if (s->id == id && s->ptr == ptr)
@@ -3236,6 +3412,16 @@ static int mark_iter_read(struct bpf_verifier_env *env, struct bpf_reg_state *re
 	return mark_stack_slot_obj_read(env, reg, spi, nr_slots);
 }
 
+static int mark_irq_flag_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+{
+	int spi;
+
+	spi = irq_flag_get_spi(env, reg);
+	if (spi < 0)
+		return spi;
+	return mark_stack_slot_obj_read(env, reg, spi, 1);
+}
+
 /* This function is supposed to be used by the following 32-bit optimization
  * code only. It returns TRUE if the source or destination register operates
  * on 64-bit, otherwise return FALSE.
@@ -10009,6 +10195,12 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return -EINVAL;
 		}
 
+		if (env->cur_state->active_irq_id) {
+			verbose(env, "global function calls are not allowed with IRQs disabled,\n"
+				     "use static function instead\n");
+			return -EINVAL;
+		}
+
 		if (err) {
 			verbose(env, "Caller passes invalid args into func#%d ('%s')\n",
 				subprog, sub_name);
@@ -10533,6 +10725,11 @@ static int check_resource_leak(struct bpf_verifier_env *env, bool exception_exit
 		return err;
 	}
 
+	if (check_lock && env->cur_state->active_irq_id) {
+		verbose(env, "%s cannot be used inside bpf_local_irq_save-ed region\n", prefix);
+		return -EINVAL;
+	}
+
 	if (check_lock && env->cur_state->active_rcu_lock) {
 		verbose(env, "%s cannot be used inside bpf_rcu_read_lock-ed region\n", prefix);
 		return -EINVAL;
@@ -10737,6 +10934,17 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			env->insn_aux_data[insn_idx].storage_get_func_atomic = true;
 	}
 
+	if (env->cur_state->active_irq_id) {
+		if (fn->might_sleep) {
+			verbose(env, "sleepable helper %s#%d in IRQ-disabled region\n",
+				func_id_name(func_id), func_id);
+			return -EINVAL;
+		}
+
+		if (in_sleepable(env) && is_storage_get_function(func_id))
+			env->insn_aux_data[insn_idx].storage_get_func_atomic = true;
+	}
+
 	meta.func_id = func_id;
 	/* check args */
 	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
@@ -11298,6 +11506,11 @@ static bool is_kfunc_arg_const_str(const struct btf *btf, const struct btf_param
 	return btf_param_match_suffix(btf, arg, "__str");
 }
 
+static bool is_kfunc_arg_irq_flag(const struct btf *btf, const struct btf_param *arg)
+{
+	return btf_param_match_suffix(btf, arg, "__irq_flag");
+}
+
 static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
 					  const struct btf_param *arg,
 					  const char *name)
@@ -11451,6 +11664,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_CONST_STR,
 	KF_ARG_PTR_TO_MAP,
 	KF_ARG_PTR_TO_WORKQUEUE,
+	KF_ARG_PTR_TO_IRQ_FLAG,
 };
 
 enum special_kfunc_type {
@@ -11482,6 +11696,8 @@ enum special_kfunc_type {
 	KF_bpf_iter_css_task_new,
 	KF_bpf_session_cookie,
 	KF_bpf_get_kmem_cache,
+	KF_bpf_local_irq_save,
+	KF_bpf_local_irq_restore,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -11548,6 +11764,8 @@ BTF_ID(func, bpf_session_cookie)
 BTF_ID_UNUSED
 #endif
 BTF_ID(func, bpf_get_kmem_cache)
+BTF_ID(func, bpf_local_irq_save)
+BTF_ID(func, bpf_local_irq_restore)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -11638,6 +11856,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (is_kfunc_arg_wq(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_WORKQUEUE;
 
+	if (is_kfunc_arg_irq_flag(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_IRQ_FLAG;
+
 	if ((base_type(reg->type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
 		if (!btf_type_is_struct(ref_t)) {
 			verbose(env, "kernel function %s args#%d pointer type %s %s is not supported\n",
@@ -11741,6 +11962,54 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static int process_irq_flag(struct bpf_verifier_env *env, int regno,
+			     struct bpf_kfunc_call_arg_meta *meta)
+{
+	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	bool irq_save;
+	int err;
+
+	if (meta->func_id == special_kfunc_list[KF_bpf_local_irq_save]) {
+		irq_save = true;
+	} else if (meta->func_id == special_kfunc_list[KF_bpf_local_irq_restore]) {
+		irq_save = false;
+	} else {
+		verbose(env, "verifier internal error: unknown irq flags kfunc\n");
+		return -EFAULT;
+	}
+
+	if (irq_save) {
+		if (!is_irq_flag_reg_valid_uninit(env, reg)) {
+			verbose(env, "expected uninitialized irq flag as arg#%d\n", regno - 1);
+			return -EINVAL;
+		}
+
+		err = check_mem_access(env, env->insn_idx, regno, 0, BPF_DW, BPF_WRITE, -1, false, false);
+		if (err)
+			return err;
+
+		err = mark_stack_slot_irq_flag(env, meta, reg, env->insn_idx);
+		if (err)
+			return err;
+	} else {
+		err = is_irq_flag_reg_valid_init(env, reg);
+		if (err) {
+			verbose(env, "expected an initialized irq flag as arg#%d\n", regno - 1);
+			return err;
+		}
+
+		err = mark_irq_flag_read(env, reg);
+		if (err)
+			return err;
+
+		err = unmark_stack_slot_irq_flag(env, reg);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+
 static int ref_set_non_owning(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct btf_record *rec = reg_btf_record(reg);
@@ -12329,6 +12598,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
 		case KF_ARG_PTR_TO_CONST_STR:
 		case KF_ARG_PTR_TO_WORKQUEUE:
+		case KF_ARG_PTR_TO_IRQ_FLAG:
 			break;
 		default:
 			WARN_ON_ONCE(1);
@@ -12623,6 +12893,15 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			if (ret < 0)
 				return ret;
 			break;
+		case KF_ARG_PTR_TO_IRQ_FLAG:
+			if (reg->type != PTR_TO_STACK) {
+				verbose(env, "arg#%d doesn't point to an irq flag on stack\n", i);
+				return -EINVAL;
+			}
+			ret = process_irq_flag(env, regno, meta);
+			if (ret < 0)
+				return ret;
+			break;
 		}
 	}
 
@@ -12803,6 +13082,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EINVAL;
 	}
 
+	if (env->cur_state->active_irq_id && sleepable) {
+		verbose(env, "kernel func %s is sleepable within IRQ-disabled region\n", func_name);
+		return -EACCES;
+	}
+
 	/* In case of release function, we get register number of refcounted
 	 * PTR_TO_BTF_ID in bpf_kfunc_arg_meta, do the release now.
 	 */
@@ -17736,6 +18020,12 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			    !check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap))
 				return false;
 			break;
+		case STACK_IRQ_FLAG:
+			old_reg = &old->stack[spi].spilled_ptr;
+			cur_reg = &cur->stack[spi].spilled_ptr;
+			if (!check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap))
+				return false;
+			break;
 		case STACK_MISC:
 		case STACK_ZERO:
 		case STACK_INVALID:
@@ -17765,12 +18055,16 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
 	if (old->active_rcu_lock != cur->active_rcu_lock)
 		return false;
 
+	if (!check_ids(old->active_irq_id, cur->active_irq_id, idmap))
+		return false;
+
 	for (i = 0; i < old->acquired_refs; i++) {
 		if (!check_ids(old->refs[i].id, cur->refs[i].id, idmap) ||
 		    old->refs[i].type != cur->refs[i].type)
 			return false;
 		switch (old->refs[i].type) {
 		case REF_TYPE_PTR:
+		case REF_TYPE_IRQ:
 			break;
 		case REF_TYPE_LOCK:
 			if (old->refs[i].ptr != cur->refs[i].ptr)
-- 
2.43.5


