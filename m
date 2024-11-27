Return-Path: <bpf+bounces-45765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B61C89DAEFB
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 22:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF5616295D
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 21:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646CF203706;
	Wed, 27 Nov 2024 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LokaIAYv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F232036ED
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 21:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732743348; cv=none; b=k/wWTIBUKC/+3i2/5PjGOEJQFI77l4F4eP8YAePWJrq0P7F/1ZiTpY3qBhvo2qaJV87dUz+EaKrN+L7L0xifc9ZQ/zDNYNWcjc2ubn96gxo83/nZUlcrDrVxTzFWWlY0uGDmTcDPAUg2kmSMmgByuM0KjFR9p9toysuM+fMPUQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732743348; c=relaxed/simple;
	bh=ksfDgRFYGSzuQqYjxVro5/xmUohsFt6GMMmBfQY4zQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3q7HdzXsqLWFaewDOreYhQXxucAy5F4ZCfBJ5q+oPrdmZe4oHy2Jq12DzfuPbTq0BBbzTJblRyrb9rePn35gq4BIVtf1bGOiBUkRorUJwX7ANlMyUwd3ye5DpOmdqubU2H/J6X2vz6EsqWF9HPPAgt4TGcyvBvtnqG6j+Nkicg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LokaIAYv; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-434a90fed23so1030805e9.1
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 13:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732743343; x=1733348143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dei7sXfXu27xPHTSY3naVcqGF4Znp8drdSDEYj5Ma3g=;
        b=LokaIAYvFNehkZuRyTAv6qthtkRwwZVYOTHrXvUEZktmknrZGFGOAApgSwqZ2r3sV9
         q26gicynJ2qv28+w6tjKSkip2LCIqaLH0KYGHIsIIURcAoqF+A0BQ/1iPvTaB7DKXVpe
         zdlIuN2kM0cyZ5QvAm8GpEfkZeBhWFsVl5qthhtRRE76+zbW62y+Ujs4+vyp1FRdi15+
         CQRL6mS8a10kClYlSF8wXP6AorvVd4sLLhZbzpfMjTizHIfdx4bC0ljW9Ja/fkriTJKH
         Bng7aS/HZzq8FHT0VcaZgEhiQTmFtbXBnyz4Rkma8ViH0WP1K9myXLMNps4H+tLOBFOq
         QolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732743343; x=1733348143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dei7sXfXu27xPHTSY3naVcqGF4Znp8drdSDEYj5Ma3g=;
        b=K67tPlyCa2u77RzQGUBeNOenkBeKiqt5faGmX6CTiKdkyQNisa+b/mjXvXslwy4kU0
         llI4D/GBSeSldq7XjSt+TGP2x1R4LA+ARCaWf22wr9+LAoymziy8Hr3gtXXcmosind1O
         FFJ6xLNgd15y98UHVHVPTfIXpkayYCKmeNwb7AcHP9NLyb6SXTSgNAM+D+KNiACbugmY
         Nl80w1tpL4s3S5CshUIotGBiTXObXsmj2Gyf0B+CnKScSc0u/ckbQPanfmCevT0lO6KL
         NV7gXL77vbmuJjSRhqtAeZaCzXUOCoo9SQGZeZH87WOQ8wPFUHGOJCDhDUJ4IcwbvsvE
         h9IQ==
X-Gm-Message-State: AOJu0YxyhpZOC9pFpuaQUJ7oHaGXkJadibpkz4rmsiaGfD1D4SanRgZc
	ccgdrqQvN8uMPnwlYmITAfLWSmLsLGOHxlEc5Q/5tnKxe0YOrcgzf34qbuqP5N8=
X-Gm-Gg: ASbGncuoljv1YcWQ7ldiZTno25tWBPD2vIq667769Yp/8JU9xM8qJ/kefDLbX7jkMhj
	wQnvR74twAVyXXl2+E47Z7HlOuxVNXW+cBW8wjq+MeUhoUMGNQketi/e0WhF52EM2doLxq18/zi
	QQl2UVN4esWqVASB0PO4R0igHUh/wEMAKR6UeHHMFuYLAFmcuBmGwCWpN5OxzRdqSE4/uJWgoc9
	txgKPR/1yfIjl9XyM1U3F1UeZaIaXDYnJFxfcfs6rGVEoIj5wQqYhy1Vujq6PmXopcl+yvFRqKG
	hA==
X-Google-Smtp-Source: AGHT+IEwjSkJPamKVxcjDtlZBnq11pPhmtWFTcSUrH1HmJOSkQlX4cn4X8I8YJnYhWSonouUl3zsYQ==
X-Received: by 2002:a05:6000:1a87:b0:37e:f1ed:67e8 with SMTP id ffacd0b85a97d-385c6ebb946mr4286334f8f.35.1732743343144;
        Wed, 27 Nov 2024 13:35:43 -0800 (PST)
Received: from localhost (fwdproxy-cln-029.fbsv.net. [2a03:2880:31ff:1d::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbc3defsm17913903f8f.70.2024.11.27.13.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 13:35:42 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 4/7] bpf: Introduce support for bpf_local_irq_{save,restore}
Date: Wed, 27 Nov 2024 13:35:32 -0800
Message-ID: <20241127213535.3657472-5-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241127213535.3657472-1-memxor@gmail.com>
References: <20241127213535.3657472-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=18865; h=from:subject; bh=ksfDgRFYGSzuQqYjxVro5/xmUohsFt6GMMmBfQY4zQ4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnR46tkHr0BjF8hSkZcrVhwaOXgwyYqOZFTIyFJfd9 O26XLe6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0eOrQAKCRBM4MiGSL8RynQMEA DBwCAMbzEjTFPw9QMgb0Y6hPHeHFoJAN3iFI3M/I4IMTYTuvEqJv0LteOsLjeLmW84WfclST6DEZr+ 3hayBmbcxwTGc04te/iH2ojxE+VRig6ROJayTUYapThEKLGMo9Mp+Rdoe+iv3x9C2N+QvG69p1LRij rbjsfw6tCoW6EGR5vmLanSwAQAQQxbWrNg36cK9ihCizj1T5v0dA72d0SqT5TdtiYZHEeJgfxyM97o qVM0s0s1QyL0Fyies7yDaSkjKlXz1XeXsbcb1lFaPdphgEL6/OvzvWdY1w1TwMUohmWUkdtOWzcSzt vvDlVj4iotes9dJaZmIBX698iiuM4GUjWzxBGh9s0U6LK/9qetqr7djG0c5MO0vVwNwWLKnT4daV8q IX7Z7y55nOgz1fh9KW1T9L7xwkqPz3IZZ2IEcgyA+mBRrJ3l1uHm2/gSO93ufv0aufvAFJC2RSSUsX DRSIG58KjAbzxyLM5wwmCoWlQ6FPGGAsvvAVT5yleMkiwb1KAzrjQLC3WkIAtR0PlZNpO0d6EvSzCx eROwnVoaD6GmKrcUZ2ArK+elz62b8Z6dTD13Uy9NrOEsM0NWKFow+V9NsjXEqbVqJpCSu1LzQSACSz jwRKqE1xQ+SJPrdW75KIGezUVHZGT49GfED86TkdO7G1bDx4ut/waCOpPB5A==
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
 kernel/bpf/helpers.c         |  17 +++
 kernel/bpf/log.c             |   1 +
 kernel/bpf/verifier.c        | 279 ++++++++++++++++++++++++++++++++++-
 4 files changed, 302 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index af64b5415df8..3da7ae6c7bba 100644
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
@@ -420,6 +423,7 @@ struct bpf_verifier_state {
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
index 8b52e5b7504c..434fc320ba1d 100644
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
index be2365a9794a..c6b40da49835 100644
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
@@ -1156,10 +1161,126 @@ static int is_iter_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_s
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
+		verbose(env, "cannot restore irq state out of order\n");
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
@@ -1169,6 +1290,7 @@ static bool is_stack_slot_special(const struct bpf_stack_state *stack)
 	case STACK_SPILL:
 	case STACK_DYNPTR:
 	case STACK_ITER:
+	case STACK_IRQ_FLAG:
 		return true;
 	case STACK_INVALID:
 	case STACK_MISC:
@@ -1291,6 +1413,7 @@ static int copy_reference_state(struct bpf_verifier_state *dst, const struct bpf
 	dst->active_locks = src->active_locks;
 	dst->active_preempt_locks = src->active_preempt_locks;
 	dst->active_rcu_lock = src->active_rcu_lock;
+	dst->active_irq_id = src->active_irq_id;
 	return 0;
 }
 
@@ -1392,6 +1515,20 @@ static int acquire_lock_state(struct bpf_verifier_env *env, int insn_idx, enum r
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
@@ -1420,6 +1557,28 @@ static int release_lock_state(struct bpf_verifier_state *state, int type, int id
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
@@ -1428,7 +1587,7 @@ static struct bpf_reference_state *find_lock_state(struct bpf_verifier_state *st
 	for (i = 0; i < state->acquired_refs; i++) {
 		struct bpf_reference_state *s = &state->refs[i];
 
-		if (s->type == REF_TYPE_PTR || s->type != type)
+		if (s->type != type)
 			continue;
 
 		if (s->id == id && s->ptr == ptr)
@@ -3236,6 +3395,16 @@ static int mark_iter_read(struct bpf_verifier_env *env, struct bpf_reg_state *re
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
@@ -10012,6 +10181,12 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -10536,6 +10711,11 @@ static int check_resource_leak(struct bpf_verifier_env *env, bool exception_exit
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
@@ -10740,6 +10920,17 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
@@ -11301,6 +11492,11 @@ static bool is_kfunc_arg_const_str(const struct btf *btf, const struct btf_param
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
@@ -11454,6 +11650,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_CONST_STR,
 	KF_ARG_PTR_TO_MAP,
 	KF_ARG_PTR_TO_WORKQUEUE,
+	KF_ARG_PTR_TO_IRQ_FLAG,
 };
 
 enum special_kfunc_type {
@@ -11485,6 +11682,8 @@ enum special_kfunc_type {
 	KF_bpf_iter_css_task_new,
 	KF_bpf_session_cookie,
 	KF_bpf_get_kmem_cache,
+	KF_bpf_local_irq_save,
+	KF_bpf_local_irq_restore,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -11551,6 +11750,8 @@ BTF_ID(func, bpf_session_cookie)
 BTF_ID_UNUSED
 #endif
 BTF_ID(func, bpf_get_kmem_cache)
+BTF_ID(func, bpf_local_irq_save)
+BTF_ID(func, bpf_local_irq_restore)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -11641,6 +11842,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (is_kfunc_arg_wq(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_WORKQUEUE;
 
+	if (is_kfunc_arg_irq_flag(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_IRQ_FLAG;
+
 	if ((base_type(reg->type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
 		if (!btf_type_is_struct(ref_t)) {
 			verbose(env, "kernel function %s args#%d pointer type %s %s is not supported\n",
@@ -11744,6 +11948,54 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
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
+			verbose(env, "expected uninitialized irq flag as arg#%d\n", regno);
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
+			verbose(env, "expected an initialized irq flag as arg#%d\n", regno);
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
@@ -12332,6 +12584,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
 		case KF_ARG_PTR_TO_CONST_STR:
 		case KF_ARG_PTR_TO_WORKQUEUE:
+		case KF_ARG_PTR_TO_IRQ_FLAG:
 			break;
 		default:
 			WARN_ON_ONCE(1);
@@ -12626,6 +12879,15 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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
 
@@ -12806,6 +13068,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -17739,6 +18006,12 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
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
@@ -17768,12 +18041,16 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
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


