Return-Path: <bpf+bounces-45317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A067E9D4527
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 01:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 273981F22160
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 00:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FDF7082D;
	Thu, 21 Nov 2024 00:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbhO4pkM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273A02F2A
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 00:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732150422; cv=none; b=r7w31klXqQJiPNIZIcTzpdOQuQSzpmX7EsLdPRmmK/SckMqgA4s4XSOVi43Y9lsypx5a/Hz8KpricwaWpeqhNdRXePmMvZYNB1JBzUPAf4LcgEJ8TizLLxEnwGgHrHYVbYxwaUIvoQa+HYJ/ROldkJNpqBnX4d3poAFmGD+gcLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732150422; c=relaxed/simple;
	bh=FQo9duHK46sEWRGMNte2SEUVOGGejYuS/q7JFGBdc/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rIMmnH1wVuL/S6t4YF5ttvhoveWU6G2p2LJg7Ped6pO71w6DTdADn2M1hDWH82H8tiGOC0Sb+4aTLyXUWoZjp7OEZwjfP4gBqNOMI7LofztkRncIw4Ls9HPnZc+tA6K1rAJ93VcFmgCY7ePmvciyqZmALRsmHjQOiFQcFC2+aGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbhO4pkM; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43159c9f617so2331045e9.2
        for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 16:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732150418; x=1732755218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1zorZsS8MqTIRv0YtIJ1N35ObPq7rbsaXF5dIIWjJ8=;
        b=AbhO4pkMsiqxtRpJvjzhH+T5pbA3WIPlMB0XRw5Z3OLSWdROOCci1iGr6mDhemNJp2
         3R+C7Bb/948PUZPgAUGw7YJ2Pt3qJK0jrQzxa0kGwEdqp30BzjtHQpLK+Cbs+3cXvqB2
         PyYPZHN9oJwlZgasCXvI5rFWn6KgBALvfs2mWiyQTemjh7vRr9rPh8pRnhvkotA83Dyu
         e+etDsz2ZxhR6PKrh2vvVW69Aw7UrFjXwnp+P+RVaHObcQfX0RYLqOc4FEvHVi2lF0kg
         ysCWdHW+0KQwj2ZS890eB4tOxKL+Lwv8s+0Dwa+wcOXCLLkVgTb/p7ufXMXUW35US9oF
         +0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732150418; x=1732755218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1zorZsS8MqTIRv0YtIJ1N35ObPq7rbsaXF5dIIWjJ8=;
        b=mZPIAHhJyoB06rehUzRP1GHqQhXe+DF9CeaVQ6qi+0OwleVxmzGXdfj1oWYvqzGZgI
         QnzDiFUUAyIwbdfUStxfpXdmQGokTrNZCDxFjVJZyEMHrn49vldCMssPGUlhSooepvz5
         8azouNl6j/F50LBHY5qEBKP9yyoFd9hXs70DtPhWVt4cqYO2P8CPXcJ7ytGVo84CCel/
         p1IHFmUqfZiNmLC080cNLoyMXMuYNyAg6VNcv7zGZ8nzYUdyNkI4V0jTk1ETjnuUJ5+l
         7U5GBXnzk+uOl/+4JlG4O2fT6UI5R5/N+a8Glhrjr7F3sucNr81voofeQHAzGzAON7IZ
         Mlsw==
X-Gm-Message-State: AOJu0Yy7ZGQHvLqmCXdczL1llPdXyW4S41R+gWWoOmYcjaSHHZRHhH1S
	xHLaoXWv2xtPOWu7FKoq9ELLC6MvImKkymS7M1DrAnG6tO3VWZrv7BfYARtAtNk=
X-Gm-Gg: ASbGnctIBCdpwRj69h8XbEtxYbxwmIiZjid0yPA/oMM9YMPq1ldTjULw+B9aHUTE6Cm
	9M0yFXMPVzuTOx1IWmGu5zjrIy2zaibe271IO4O8nHddd8dok8u1OdcMOUjoqEskyaEd8kLJW1W
	KMk1l8ClPIQnpNerwBhVfG0DXkmoRZh+/LmlCr7PDcKRIcOH0n+vxqqCVJTxGiIY84UwyK98lTR
	GD1q4L5heCgttCJ0qw9mdpDtj0Ydv5fPg1QOXI+47P56DrtQUwj6iMd0BhcYswOEbGV7zwOgI7p
	kw==
X-Google-Smtp-Source: AGHT+IE/qjmxzkucCk44OzGFH6NgoApGW6JANrkNFakC0PMIh2EeUEeAX0yJAI0sw0C0Di1H/WnIgw==
X-Received: by 2002:a05:600c:4f84:b0:431:5c1c:71b6 with SMTP id 5b1f17b1804b1-433489d5ad0mr46876495e9.17.1732150417475;
        Wed, 20 Nov 2024 16:53:37 -0800 (PST)
Received: from localhost (fwdproxy-cln-019.fbsv.net. [2a03:2880:31ff:13::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b463af68sm35620825e9.40.2024.11.20.16.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 16:53:37 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v1 5/7] bpf: Introduce support for bpf_local_irq_{save,restore}
Date: Wed, 20 Nov 2024 16:53:27 -0800
Message-ID: <20241121005329.408873-6-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241121005329.408873-1-memxor@gmail.com>
References: <20241121005329.408873-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=19464; h=from:subject; bh=FQo9duHK46sEWRGMNte2SEUVOGGejYuS/q7JFGBdc/E=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnPoQ3htJ12xkCDq/FGznb9myyqVLsZPJoFJEI/VVv bWTxdkOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZz6ENwAKCRBM4MiGSL8RytSpD/ 9x9bzoK09sRZWrTymfW4DCHEALKkZGeSDItcT8kwQ7QvNSWnpR/AmrY+n2X8r71xMsAtoVd/o0adSr X+ptxNbDyAn2hP0PK9RiDJN21Wl/NHA4uZHydAHzQb3S/DOsYWHsoJLyjMKqnaiagRnPuYszKPW9dR 7zdgaq3Hs76rFQhjg2riH4gQ7gdq22U+xAF9R+YN2Me/0rruFeB7vgvGfW4G0qAcAnqklAvrtPMTH0 T2PRFUwLK4BLWKBwROLLQGvmbLyNuiYmd6kL+5BLI39aRXSn6LCCHPWWyOL/EjAdTHgM+vttJFkPWR QQuJ0LzrTI8GOiFo2j0ZOcW346D3S/tvk/X1jOsXFfHaVJTwoqkV6dxv1VQi0y+v2xO2x+qsCV2YMd xznGgIrVilKbeiyr1OhEPGfmP8daGolUx4NfXLTUwHi0c+0i/03Y9MS2sCvAS0l0dGYarJ1w2URrkk AvDV1MVDfxvzosrbvN9g4baO5r4BbrWiTiLYQ7LbQzsArQsPdRFPobsC+mlyz3XtRTKP+QPrGJX5oo Ax5YaKEXqH8T0w9M2SdLSE3PqCO/1hsPjfeVp8y7SH0Isffhu4hY51/z/4baSx5lAzvLVK9euY+ldR 67Y6Y/nghSK+3xEFHRfWM5S+q879CKN4ViUZuG6XrtwszHGmgFKN5vGhIG2w==
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

To track a dynamic number of IRQ-disabled regions and their associated
saved states, a new resource type RES_TYPE_IRQ is introduced, which its
state management functions: acquire_irq_state and release_irq_state,
taking advantage of the refactoring and clean ups made in earlier
commits.

One notable requirement of the kernel's IRQ save and restore API is that
they cannot happen out of order. For this purpose, resource state is
extended with a new type-specific member 'prev_id'. This is used to
remember the ordering of acquisitions of IRQ saved states, so that we
maintain a logical stack in acquisition order of resource identities,
and can enforce LIFO ordering when restoring IRQ state. The top of the
stack is maintained using bpf_func_state's active_irq_id.

The logic to detect initialized and unitialized irq flag slots, marking
and unmarking is similar to how it's done for iterators. We do need to
update ressafe to perform check_ids based satisfiability check, and
additionally match prev_id for RES_TYPE_IRQ entries in the resource
array.

The kfuncs themselves are plain wrappers over local_irq_save and
local_irq_restore macros.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  19 ++-
 kernel/bpf/helpers.c         |  24 +++
 kernel/bpf/log.c             |   1 +
 kernel/bpf/verifier.c        | 283 ++++++++++++++++++++++++++++++++++-
 4 files changed, 322 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index fa09538a35bc..f44961dccbac 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -233,6 +233,7 @@ enum bpf_stack_slot_type {
 	 */
 	STACK_DYNPTR,
 	STACK_ITER,
+	STACK_IRQ_FLAG,
 };
 
 #define BPF_REG_SIZE 8	/* size of eBPF register in bytes */
@@ -253,6 +254,9 @@ struct bpf_resource_state {
 	enum res_state_type {
 		RES_TYPE_INV = -1,
 		RES_TYPE_PTR = 0,
+		RES_TYPE_IRQ,
+
+		__RES_TYPE_LOCK_BEGIN,
 		RES_TYPE_LOCK,
 	} type;
 	/* Track each resource created with a unique id, even if the same
@@ -263,10 +267,16 @@ struct bpf_resource_state {
 	 * is used purely to inform the user of a resource leak.
 	 */
 	int insn_idx;
-	/* Use to keep track of the source object of a lock, to ensure
-	 * it matches on unlock.
-	 */
-	void *ptr;
+	union {
+		/* Use to keep track of the source object of a lock, to ensure
+		 * it matches on unlock.
+		 */
+		void *ptr;
+		/* Track the reference id preceding the IRQ entry in acquisition
+		 * order, to enforce an ordering on the release.
+		 */
+		int prev_id;
+	};
 };
 
 struct bpf_retval_range {
@@ -317,6 +327,7 @@ struct bpf_func_state {
 	int active_locks;
 	int active_preempt_locks;
 	bool active_rcu_lock;
+	int active_irq_id;
 	struct bpf_resource_state *res;
 	/* The state of the stack. Each element of the array describes BPF_REG_SIZE
 	 * (i.e. 8) bytes worth of stack memory.
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 751c150f9e1c..302f0d5976be 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3057,6 +3057,28 @@ __bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void __user
 	return ret + 1;
 }
 
+/* Keep unsinged long in prototype so that kfunc is usable when emitted to
+ * vmlinux.h in BPF programs directly, but since unsigned long may potentially
+ * be 4 byte, always cast to u64 when reading/writing from this pointer as it
+ * always points to an 8-byte memory region in BPF stack.
+ */
+__bpf_kfunc void bpf_local_irq_save(unsigned long *flags__irq_flag)
+{
+	u64 *ptr = (u64 *)flags__irq_flag;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	*ptr = flags;
+}
+
+__bpf_kfunc void bpf_local_irq_restore(unsigned long *flags__irq_flag)
+{
+	u64 *ptr = (u64 *)flags__irq_flag;
+	unsigned long flags = *ptr;
+
+	local_irq_restore(flags);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -3149,6 +3171,8 @@ BTF_ID_FLAGS(func, bpf_get_kmem_cache)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_new, KF_ITER_NEW | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_local_irq_save)
+BTF_ID_FLAGS(func, bpf_local_irq_restore)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 0ad6f0737c57..fc5520782e5d 100644
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
index 6cd2bbed4583..67ffcbb963bd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -660,6 +660,11 @@ static int iter_get_spi(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
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
@@ -1155,10 +1160,126 @@ static int is_iter_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_s
 	return 0;
 }
 
+static int acquire_irq_state(struct bpf_verifier_env *env, int insn_idx);
+static int release_irq_state(struct bpf_func_state *state, int id);
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
+	err = release_irq_state(cur_func(env), st->ref_obj_id);
+	WARN_ON_ONCE(err && err != -EPROTO);
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
+	mark_stack_slot_scratched(env, spi - i);
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
@@ -1168,6 +1289,7 @@ static bool is_stack_slot_special(const struct bpf_stack_state *stack)
 	case STACK_SPILL:
 	case STACK_DYNPTR:
 	case STACK_ITER:
+	case STACK_IRQ_FLAG:
 		return true;
 	case STACK_INVALID:
 	case STACK_MISC:
@@ -1291,6 +1413,7 @@ static int copy_resource_state(struct bpf_func_state *dst, const struct bpf_func
 	dst->active_locks = src->active_locks;
 	dst->active_preempt_locks = src->active_preempt_locks;
 	dst->active_rcu_lock = src->active_rcu_lock;
+	dst->active_irq_id = src->active_irq_id;
 	return 0;
 }
 
@@ -1398,6 +1521,22 @@ static int acquire_lock_state(struct bpf_verifier_env *env, int insn_idx, enum r
 	return 0;
 }
 
+static int acquire_irq_state(struct bpf_verifier_env *env, int insn_idx)
+{
+	struct bpf_func_state *state = cur_func(env);
+	struct bpf_resource_state *s;
+	int id;
+
+	s = acquire_resource_state(env, insn_idx, &id);
+	if (!s)
+		return -ENOMEM;
+	s->type = RES_TYPE_IRQ;
+	s->prev_id = state->active_irq_id;
+
+	state->active_irq_id = id;
+	return id;
+}
+
 static void erase_resource_state(struct bpf_func_state *state, int res_idx)
 {
 	int last_idx = state->acquired_res - 1;
@@ -1439,6 +1578,27 @@ static int release_lock_state(struct bpf_func_state *state, int type, int id, vo
 	return -EINVAL;
 }
 
+static int release_irq_state(struct bpf_func_state *state, int id)
+{
+	int i;
+
+	if (id != state->active_irq_id)
+		return -EPROTO;
+
+	for (i = 0; i < state->acquired_res; i++) {
+		if (state->res[i].type != RES_TYPE_IRQ)
+			continue;
+		if (state->res[i].id == id) {
+			int prev_id = state->res[i].prev_id;
+
+			erase_resource_state(state, i);
+			state->active_irq_id = prev_id;
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
 static struct bpf_resource_state *find_lock_state(struct bpf_func_state *state, enum res_state_type type,
 						   int id, void *ptr)
 {
@@ -1447,7 +1607,7 @@ static struct bpf_resource_state *find_lock_state(struct bpf_func_state *state,
 	for (i = 0; i < state->acquired_res; i++) {
 		struct bpf_resource_state *s = &state->res[i];
 
-		if (s->type == RES_TYPE_PTR || s->type != type)
+		if (s->type < __RES_TYPE_LOCK_BEGIN || s->type != type)
 			continue;
 
 		if (s->id == id && s->ptr == ptr)
@@ -3257,6 +3417,16 @@ static int mark_iter_read(struct bpf_verifier_env *env, struct bpf_reg_state *re
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
@@ -10015,6 +10185,12 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return -EINVAL;
 		}
 
+		if (cur_func(env)->active_irq_id) {
+			verbose(env, "global function calls are not allowed with IRQs disabled,\n"
+				     "use static function instead\n");
+			return -EINVAL;
+		}
+
 		if (err) {
 			verbose(env, "Caller passes invalid args into func#%d ('%s')\n",
 				subprog, sub_name);
@@ -10544,6 +10720,11 @@ static int check_resource_leak(struct bpf_verifier_env *env, bool exception_exit
 		return err;
 	}
 
+	if (check_lock && cur_func(env)->active_irq_id) {
+		verbose(env, "%s cannot be used inside bpf_local_irq_save-ed region\n", prefix);
+		return -EINVAL;
+	}
+
 	if (check_lock && cur_func(env)->active_rcu_lock) {
 		verbose(env, "%s cannot be used inside bpf_rcu_read_lock-ed region\n", prefix);
 		return -EINVAL;
@@ -10748,6 +10929,17 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			env->insn_aux_data[insn_idx].storage_get_func_atomic = true;
 	}
 
+	if (cur_func(env)->active_irq_id) {
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
@@ -11309,6 +11501,11 @@ static bool is_kfunc_arg_const_str(const struct btf *btf, const struct btf_param
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
@@ -11462,6 +11659,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_CONST_STR,
 	KF_ARG_PTR_TO_MAP,
 	KF_ARG_PTR_TO_WORKQUEUE,
+	KF_ARG_PTR_TO_IRQ_FLAG,
 };
 
 enum special_kfunc_type {
@@ -11493,6 +11691,8 @@ enum special_kfunc_type {
 	KF_bpf_iter_css_task_new,
 	KF_bpf_session_cookie,
 	KF_bpf_get_kmem_cache,
+	KF_bpf_local_irq_save,
+	KF_bpf_local_irq_restore,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -11559,6 +11759,8 @@ BTF_ID(func, bpf_session_cookie)
 BTF_ID_UNUSED
 #endif
 BTF_ID(func, bpf_get_kmem_cache)
+BTF_ID(func, bpf_local_irq_save)
+BTF_ID(func, bpf_local_irq_restore)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -11649,6 +11851,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (is_kfunc_arg_wq(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_WORKQUEUE;
 
+	if (is_kfunc_arg_irq_flag(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_IRQ_FLAG;
+
 	if ((base_type(reg->type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
 		if (!btf_type_is_struct(ref_t)) {
 			verbose(env, "kernel function %s args#%d pointer type %s %s is not supported\n",
@@ -11752,6 +11957,54 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static int process_irq_flag(struct bpf_verifier_env *env, int regno,
+			     struct bpf_kfunc_call_arg_meta *meta)
+{
+	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	bool irq_save = false, irq_restore = false;
+	int err;
+
+	if (meta->func_id == special_kfunc_list[KF_bpf_local_irq_save]) {
+		irq_save = true;
+	} else if (meta->func_id == special_kfunc_list[KF_bpf_local_irq_restore]) {
+		irq_restore = true;
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
@@ -12341,6 +12594,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
 		case KF_ARG_PTR_TO_CONST_STR:
 		case KF_ARG_PTR_TO_WORKQUEUE:
+		case KF_ARG_PTR_TO_IRQ_FLAG:
 			break;
 		default:
 			WARN_ON_ONCE(1);
@@ -12635,6 +12889,15 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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
 
@@ -12815,6 +13078,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EINVAL;
 	}
 
+	if (cur_func(env)->active_irq_id && sleepable) {
+		verbose(env, "kernel func %s is sleepable within IRQ-disabled region\n", func_name);
+		return -EACCES;
+	}
+
 	/* In case of release function, we get register number of refcounted
 	 * PTR_TO_BTF_ID in bpf_kfunc_arg_meta, do the release now.
 	 */
@@ -17748,6 +18016,12 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
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
@@ -17777,6 +18051,9 @@ static bool ressafe(struct bpf_func_state *old, struct bpf_func_state *cur,
 	if (old->active_rcu_lock != cur->active_rcu_lock)
 		return false;
 
+	if (!check_ids(old->active_irq_id, cur->active_irq_id, idmap))
+		return false;
+
 	for (i = 0; i < old->acquired_res; i++) {
 		if (!check_ids(old->res[i].id, cur->res[i].id, idmap) ||
 		    old->res[i].type != cur->res[i].type)
@@ -17784,6 +18061,10 @@ static bool ressafe(struct bpf_func_state *old, struct bpf_func_state *cur,
 		switch (old->res[i].type) {
 		case RES_TYPE_PTR:
 			break;
+		case RES_TYPE_IRQ:
+			if (!check_ids(old->res[i].prev_id, cur->res[i].prev_id, idmap))
+				return false;
+			break;
 		case RES_TYPE_LOCK:
 			if (old->res[i].ptr != cur->res[i].ptr)
 				return false;
-- 
2.43.5


