Return-Path: <bpf+bounces-53168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E51A4D546
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 08:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B90718834E6
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 07:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13CB1F9A8B;
	Tue,  4 Mar 2025 07:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSv9g/pL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68F31F9A86
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 07:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074222; cv=none; b=PWPJVy/Pn0jZ2Nex7skDDDqCHhHmPqfvTrAp6/YrjTmvSEtAT+RZGuIgIZ5jCKqoLoF6Dwpa3rSDwCZzlUeRlkwhvGffggMrRnPNTgwFL0VClI0aDPU1hyPLAYxMdo8rTtCm0PKk6RLv0y7v4HuTXS05jndy1m52nrTYz4B0wlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074222; c=relaxed/simple;
	bh=D8ZEKVn64Sd5axtddKMZqk8ljAOwuL71ctoGRhSaCQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rkw0s9/b3SZInPYCOyI51qeXvtMZepx/fzBKPvRpAOEqjiKT9YwRChYsTjCKeTn6UwhPCkv2sWujWG8WuNJoAVwKs2FWYuodnmTQdgEj+6NsXREoZwJ+i6rCtU9fmUpnLcuoKUrhnRuzB4qsRQ7NFNW2nSpxbUWufWfGTunFPos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSv9g/pL; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223a7065ff8so51731485ad.0
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 23:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741074220; x=1741679020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coac0IMqhgbNlsTguy9T8pdlS35mZJeiVU0PCL9zvew=;
        b=gSv9g/pLBOpTq7KnQ9qgWExvtBZpg1BSJYta1LCrnLyfrZWrOlwHpkl26j00XWV9Ve
         NILjg3Ro4m00t8PEUkxL9plm4WPOkL9jg++WM8+co7TGKSIAfd1ntGeaTsbCpR9n4gu9
         z4aCrW2kwW9D+dktt5VDvDsaZH301KtRxQ0cAbYfMbTPH6y26+Ag4LKmcmMKHGdb8UeF
         ETH+CqwJ1yNEQmGh7WKw7shHowrwD+3qx0Qm6qKP6Lt1NP6xfqBK5zhZpKWa1UGY7YnR
         k3vFAWV8GXaOdFbpECr1HdYAEe0cuJ7X3beueNhZTm4s3kax4rLgbZknSLY6Z81N3/WO
         PswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741074220; x=1741679020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=coac0IMqhgbNlsTguy9T8pdlS35mZJeiVU0PCL9zvew=;
        b=cLOaPeyY4esnby3F1qi4D57JdRx5yVwKPPOb3xSOqe+DDy/ttFWZ6UBhMs6r9nmd2/
         Zmze27HkMyvxu2gcBw3t3QFc8K/Ykj0u7luDG/Un9dPFgv452U4lRWQxxrUUL9Z85LvK
         YIhTS+s+Z/9u12v3N4gRlgIIiCrZP5nu/9hKYheKSbMREKwNzPRIIQZthikn7liWHXhu
         DMhtXeMOz/JjCE4W1u2zUNaBQ++WvazHkllz7UeeMYMhKpIqFXGtKKEnElhHEsQaJV2r
         HSABOg076OMU3McaKgatspEvAWKHR6JlQgIaZzGprktVJTRAPaYAagwDc1G1hH5f7CQ0
         I0ow==
X-Gm-Message-State: AOJu0YzEE0sPLmuSw2/VwRYAECg9eudSRaq657P9HZ+kzrEmuUDbfJUL
	CtjB1U3inM3DI6zaH4mj+x6mXUYMtusKdd4JGJD/RaLb3Ojx8uflnbUlbg==
X-Gm-Gg: ASbGncsmD3WFYuB33KT5uMReHyDeipjGrulOgPWulW31+flQbTHcBtjx73ivcg5qxzi
	D5lKTgyqQu3GjbxqNDihm/Mh+QRJ4vAkkxM5njH/4u6ZiYcCG9hbeV+L6K6lY4jS7v3fWVWhLkh
	+pHxLdMBYsBivR9+h5bphIulF1AHmBGq4J9lxDp6Kxt20eJou71Lfy2tdgG+Ldi4pB+3EmBif3B
	is0gEomXxjwYjjMMKTz1yukJqEDiiQwovJGoIRbGOb/dCjGXJs/1oP/B9gVajCKId/xhYdXA7vc
	p0698CSav8KJt7mAur93vGGu6gURXYZTYAEWPYL7
X-Google-Smtp-Source: AGHT+IH7Qxam26rkGXcXexRRCCTf2J5BdcbMcXKGvSA+TOpZb0VbYO4lkt6tWtY50FKrJtCzVOxjoA==
X-Received: by 2002:a17:902:fc84:b0:220:d28a:c5c7 with SMTP id d9443c01a7336-22368fc267emr274906045ad.21.1741074219875;
        Mon, 03 Mar 2025 23:43:39 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235050d7c1sm89545125ad.198.2025.03.03.23.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 23:43:39 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	tj@kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 2/5] bpf: get_call_summary() utility function
Date: Mon,  3 Mar 2025 23:42:36 -0800
Message-ID: <20250304074239.2328752-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304074239.2328752-1-eddyz87@gmail.com>
References: <20250304074239.2328752-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor mark_fastcall_pattern_for_call() to extract a utility
function get_call_summary(). For a helper or kfunc call this function
fills the following information: {num_params, is_void, fastcall}.

This function would be used in the next patch in order to get number
of parameters of a helper or kfunc call.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 121 ++++++++++++++++++++----------------------
 1 file changed, 57 insertions(+), 64 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 25910b740bbc..5cc1b6ed0e92 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17019,27 +17019,6 @@ static int visit_func_call_insn(int t, struct bpf_insn *insns,
 /* Bitmask with 1s for all caller saved registers */
 #define ALL_CALLER_SAVED_REGS ((1u << CALLER_SAVED_REGS) - 1)
 
-/* Return a bitmask specifying which caller saved registers are
- * clobbered by a call to a helper *as if* this helper follows
- * bpf_fastcall contract:
- * - includes R0 if function is non-void;
- * - includes R1-R5 if corresponding parameter has is described
- *   in the function prototype.
- */
-static u32 helper_fastcall_clobber_mask(const struct bpf_func_proto *fn)
-{
-	u32 mask;
-	int i;
-
-	mask = 0;
-	if (fn->ret_type != RET_VOID)
-		mask |= BIT(BPF_REG_0);
-	for (i = 0; i < ARRAY_SIZE(fn->arg_type); ++i)
-		if (fn->arg_type[i] != ARG_DONTCARE)
-			mask |= BIT(BPF_REG_1 + i);
-	return mask;
-}
-
 /* True if do_misc_fixups() replaces calls to helper number 'imm',
  * replacement patch is presumed to follow bpf_fastcall contract
  * (see mark_fastcall_pattern_for_call() below).
@@ -17056,24 +17035,54 @@ static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
 	}
 }
 
-/* Same as helper_fastcall_clobber_mask() but for kfuncs, see comment above */
-static u32 kfunc_fastcall_clobber_mask(struct bpf_kfunc_call_arg_meta *meta)
+struct call_summary {
+	u8 num_params;
+	bool is_void;
+	bool fastcall;
+};
+
+/* If @call is a kfunc or helper call, fills @cs and returns true,
+ * otherwise returns false.
+ */
+static bool get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
+			     struct call_summary *cs)
 {
-	u32 vlen, i, mask;
+	struct bpf_kfunc_call_arg_meta meta;
+	const struct bpf_func_proto *fn;
+	int i;
 
-	vlen = btf_type_vlen(meta->func_proto);
-	mask = 0;
-	if (!btf_type_is_void(btf_type_by_id(meta->btf, meta->func_proto->type)))
-		mask |= BIT(BPF_REG_0);
-	for (i = 0; i < vlen; ++i)
-		mask |= BIT(BPF_REG_1 + i);
-	return mask;
-}
+	if (bpf_helper_call(call)) {
 
-/* Same as verifier_inlines_helper_call() but for kfuncs, see comment above */
-static bool is_fastcall_kfunc_call(struct bpf_kfunc_call_arg_meta *meta)
-{
-	return meta->kfunc_flags & KF_FASTCALL;
+		if (get_helper_proto(env, call->imm, &fn) < 0)
+			/* error would be reported later */
+			return false;
+		cs->fastcall = fn->allow_fastcall &&
+			       (verifier_inlines_helper_call(env, call->imm) ||
+				bpf_jit_inlines_helper_call(call->imm));
+		cs->is_void = fn->ret_type == RET_VOID;
+		cs->num_params = 0;
+		for (i = 0; i < ARRAY_SIZE(fn->arg_type); ++i) {
+			if (fn->arg_type[i] == ARG_DONTCARE)
+				break;
+			cs->num_params++;
+		}
+		return true;
+	}
+
+	if (bpf_pseudo_kfunc_call(call)) {
+		int err;
+
+		err = fetch_kfunc_meta(env, call, &meta, NULL);
+		if (err < 0)
+			/* error would be reported later */
+			return false;
+		cs->num_params = btf_type_vlen(meta.func_proto);
+		cs->fastcall = meta.kfunc_flags & KF_FASTCALL;
+		cs->is_void = btf_type_is_void(btf_type_by_id(meta.btf, meta.func_proto->type));
+		return true;
+	}
+
+	return false;
 }
 
 /* LLVM define a bpf_fastcall function attribute.
@@ -17156,39 +17165,23 @@ static void mark_fastcall_pattern_for_call(struct bpf_verifier_env *env,
 {
 	struct bpf_insn *insns = env->prog->insnsi, *stx, *ldx;
 	struct bpf_insn *call = &env->prog->insnsi[insn_idx];
-	const struct bpf_func_proto *fn;
-	u32 clobbered_regs_mask = ALL_CALLER_SAVED_REGS;
+	u32 clobbered_regs_mask;
+	struct call_summary cs;
 	u32 expected_regs_mask;
-	bool can_be_inlined = false;
 	s16 off;
 	int i;
 
-	if (bpf_helper_call(call)) {
-		if (get_helper_proto(env, call->imm, &fn) < 0)
-			/* error would be reported later */
-			return;
-		clobbered_regs_mask = helper_fastcall_clobber_mask(fn);
-		can_be_inlined = fn->allow_fastcall &&
-				 (verifier_inlines_helper_call(env, call->imm) ||
-				  bpf_jit_inlines_helper_call(call->imm));
-	}
-
-	if (bpf_pseudo_kfunc_call(call)) {
-		struct bpf_kfunc_call_arg_meta meta;
-		int err;
-
-		err = fetch_kfunc_meta(env, call, &meta, NULL);
-		if (err < 0)
-			/* error would be reported later */
-			return;
-
-		clobbered_regs_mask = kfunc_fastcall_clobber_mask(&meta);
-		can_be_inlined = is_fastcall_kfunc_call(&meta);
-	}
-
-	if (clobbered_regs_mask == ALL_CALLER_SAVED_REGS)
+	if (!get_call_summary(env, call, &cs))
 		return;
 
+	/* A bitmask specifying which caller saved registers are clobbered
+	 * by a call to a helper/kfunc *as if* this helper/kfunc follows
+	 * bpf_fastcall contract:
+	 * - includes R0 if function is non-void;
+	 * - includes R1-R5 if corresponding parameter has is described
+	 *   in the function prototype.
+	 */
+	clobbered_regs_mask = GENMASK(cs.num_params, cs.is_void ? 1 : 0);
 	/* e.g. if helper call clobbers r{0,1}, expect r{2,3,4,5} in the pattern */
 	expected_regs_mask = ~clobbered_regs_mask & ALL_CALLER_SAVED_REGS;
 
@@ -17246,7 +17239,7 @@ static void mark_fastcall_pattern_for_call(struct bpf_verifier_env *env,
 	 * don't set 'fastcall_spills_num' for call B so that remove_fastcall_spills_fills()
 	 * does not remove spill/fill pair {4,6}.
 	 */
-	if (can_be_inlined)
+	if (cs.fastcall)
 		env->insn_aux_data[insn_idx].fastcall_spills_num = i - 1;
 	else
 		subprog->keep_fastcall_stack = 1;
-- 
2.48.1


