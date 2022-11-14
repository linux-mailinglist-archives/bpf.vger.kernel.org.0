Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8816628912
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 20:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbiKNTQf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 14:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237123AbiKNTQ3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 14:16:29 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6612655F
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:16:28 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id z26so11954986pff.1
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bdRYjhA7/4SvqymiC//VxctBitwMX6pPdrBNrwmhX4=;
        b=l/QSM8H2DALnmB8T2BI2ZPtIpiYkDTQPMLc7Xk7gsbbTJVECAYTgBj4ZTYO9PY0Sa/
         fZ9miuXvUnKxm3wRTvZIb+D+L3i1tyvLgodhGd8I+ZbGcWZ9n89w7ICwPPSvEnVjkdqh
         7ByanSBxKNVmXlVRiAxsk3jkr/6u1MBue3qm/17JFHFD5hfk7a3ok5MaxhTZK+aBrWBd
         UpbFaQ23OcddT3ZsPEwLhkybCHe3MBCpj90yoaUcbDJmHUNvWD5RBIzhdvHtg+mTUOKr
         L6zBkk4xHK3HFD3aDm7QfZooEuu3ih/P4XFTrDfG8Lbi5T8lV3CIGBWfLNZW+iZ+KhBF
         ITDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bdRYjhA7/4SvqymiC//VxctBitwMX6pPdrBNrwmhX4=;
        b=ln+r6NZ6QHy2JFDtMU43KvRjTUVoQfKIiB0DEDEXYk/WRf2jPgjdhEkmh6DBvPz1li
         y+Gd7aZEkKxYm8n0GpMgRQx+BiNsOGiQIobe2BwMzVEUlN5ELkx+SAZ3Epwixb3pB6Mx
         KQQRLCuwJSNAxMlFldP8EFDnT/Fcra+EdQOvkrbN2V+XNpZocE4pqvA5MMH94+FFeYI+
         EzQX3oznZwdv41L0jHofv/QwVMLwLpHL4mUeT0BxzpujoTNN6qIGF6rcKoFnU4i+QpMs
         r/KXQlkCT72LBOl6RA+3rXZRMyuV2ye0PhIWcHjN+MS0ef32jJyWL/LSH92ySkqlmj4H
         vcFg==
X-Gm-Message-State: ANoB5plQiEZioIb7sqXHGTfpBObF/iaf9ZuDzhWdeLsy6ljwew4ftmPp
        JtEMlZm7c+zS/zVajVAQXMh34FwoectQuA==
X-Google-Smtp-Source: AA0mqf5QasjN9cJayGn0Uo91NlE0ZgBvC9eA0GEVg9AZiPXoYS480VLPDxy0dsOUlQDwrkkCJuubug==
X-Received: by 2002:a65:4984:0:b0:470:8e:6003 with SMTP id r4-20020a654984000000b00470008e6003mr12944213pgs.19.1668453387858;
        Mon, 14 Nov 2022 11:16:27 -0800 (PST)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903120500b0018863dbf3b0sm7974862plh.45.2022.11.14.11.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 11:16:27 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v7 12/26] bpf: Allow locking bpf_spin_lock global variables
Date:   Tue, 15 Nov 2022 00:45:33 +0530
Message-Id: <20221114191547.1694267-13-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114191547.1694267-1-memxor@gmail.com>
References: <20221114191547.1694267-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6954; i=memxor@gmail.com; h=from:subject; bh=nE42Ao32jrqG05ryyQ1whpx3jrA83r4xm2MpN5cZW+o=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjcpPJbQ8mcMrlLy8wMaVInXdyPzuSQ27PEHq0dxF7 m0odajmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3KTyQAKCRBM4MiGSL8Ryq6fD/ 91RexHoptmSd2alUPArzSM/f2GJHhV8XIguwVtPsqcyXL4wQKw7hC24VzvCmRC8UNVUW0WQ199qKmQ eleP3fnnZEGbwWiATUOWpCq2HKM8M64G0/SNCQ1PZWN3Kxg82tYcFKA2PxPcne6sONIiDbvUjtZVwn zCV/50Zow8jJgGVLi49ZLU9Xgt5IIq3nNz6Y8WvrKUi/b9wLjCVVX2Z0nPxmmDTc0UraXVw7ifHvbI PgCG5Zd0VraalCm7MdwxPcRWB0eSDTY7pj9ZxsiwXqQSm1UQjGSDgEwefri5A2x6qBXTSQbFehS6H+ NLlg0/+lSIKy4XFFTxJ/4USgNGmpel0UfIGKKHAECRt/OQi/fv2XdPPzW6N+4OLw5WD4bI5KFrSw76 fMtroMGeK4pOeIbVC9WvcL1IImjOGtEO6CV4M1oj0mzZ/ADf69vp/2m7V3mcyhBvAutBNOc0/cPfwz MEiumDtHZFLNvRUGgp1JIWCZ48dKY9IRibvu+/VMKqlY6bRgheEB+ZIt3DYY2ATK3cFc6dASOy4Pvb ZQfD8yPJ96xFQCrsKD4PVQr8+RrjeUBtOmZXpxXBmbUkydoMMw19vgRf/FJb/W8t3ZILF5MbHAYHC1 zVcYZ54G1uOvkzaKJq7NDehNK0neL/ExNKwfUJfIxGdS+TgZsEuYjtwQR47Q==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Global variables reside in maps accessible using direct_value_addr
callbacks, so giving each load instruction's rewrite a unique reg->id
disallows us from holding locks which are global.

The reason for preserving reg->id as a unique value for registers that
may point to spin lock is that two separate lookups are treated as two
separate memory regions, and any possible aliasing is ignored for the
purposes of spin lock correctness.

This is not great especially for the global variable case, which are
served from maps that have max_entries == 1, i.e. they always lead to
map values pointing into the same map value.

So refactor the active_spin_lock into a 'active_lock' structure which
represents the lock identity, and instead of the reg->id, remember two
fields, a pointer and the reg->id. The pointer will store reg->map_ptr
or reg->btf. It's only necessary to distinguish for the id == 0 case of
global variables, but always setting the pointer to a non-NULL value and
using the pointer to check whether the lock is held simplifies code in
the verifier.

This is generic enough to allow it for global variables, map lookups,
and allocated objects at the same time.

Note that while whether a lock is held can be answered by just comparing
active_lock.ptr to NULL, to determine whether the register is pointing
to the same held lock requires comparing _both_ ptr and id.

Finally, as a result of this refactoring, pseudo load instructions are
not given a unique reg->id, as they are doing lookup for the same map
value (max_entries is never greater than 1).

Essentially, we consider that the tuple of (ptr, id) will always be
unique for any kind of argument to bpf_spin_{lock,unlock}.

Note that this can be extended in the future to also remember offset
used for locking, so that we can introduce multiple bpf_spin_lock fields
in the same allocation.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h | 10 ++++++++-
 kernel/bpf/verifier.c        | 41 ++++++++++++++++++++++++------------
 2 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1a32baa78ce2..fa738abea267 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -323,7 +323,15 @@ struct bpf_verifier_state {
 	u32 branches;
 	u32 insn_idx;
 	u32 curframe;
-	u32 active_spin_lock;
+	struct {
+		/* This can either be reg->map_ptr or reg->btf, but it is only
+		 * used to check whether the lock is held or not by comparing to
+		 * NULL.
+		 */
+		void *ptr;
+		/* This will be reg->id */
+		u32 id;
+	} active_lock;
 	bool speculative;
 
 	/* first and last insn idx of this verifier state */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 070d003a99f0..99b5edb56978 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1215,7 +1215,8 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	}
 	dst_state->speculative = src->speculative;
 	dst_state->curframe = src->curframe;
-	dst_state->active_spin_lock = src->active_spin_lock;
+	dst_state->active_lock.ptr = src->active_lock.ptr;
+	dst_state->active_lock.id = src->active_lock.id;
 	dst_state->branches = src->branches;
 	dst_state->parent = src->parent;
 	dst_state->first_insn_idx = src->first_insn_idx;
@@ -5587,7 +5588,7 @@ int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
  * Since only one bpf_spin_lock is allowed the checks are simpler than
  * reg_is_refcounted() logic. The verifier needs to remember only
  * one spin_lock instead of array of acquired_refs.
- * cur_state->active_spin_lock remembers which map value element got locked
+ * cur_state->active_lock remembers which map value element got locked
  * and clears it after bpf_spin_unlock.
  */
 static int process_spin_lock(struct bpf_verifier_env *env, int regno,
@@ -5636,22 +5637,35 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 		return -EINVAL;
 	}
 	if (is_lock) {
-		if (cur->active_spin_lock) {
+		if (cur->active_lock.ptr) {
 			verbose(env,
 				"Locking two bpf_spin_locks are not allowed\n");
 			return -EINVAL;
 		}
-		cur->active_spin_lock = reg->id;
+		if (map)
+			cur->active_lock.ptr = map;
+		else
+			cur->active_lock.ptr = btf;
+		cur->active_lock.id = reg->id;
 	} else {
-		if (!cur->active_spin_lock) {
+		void *ptr;
+
+		if (map)
+			ptr = map;
+		else
+			ptr = btf;
+
+		if (!cur->active_lock.ptr) {
 			verbose(env, "bpf_spin_unlock without taking a lock\n");
 			return -EINVAL;
 		}
-		if (cur->active_spin_lock != reg->id) {
+		if (cur->active_lock.ptr != ptr ||
+		    cur->active_lock.id != reg->id) {
 			verbose(env, "bpf_spin_unlock of different lock\n");
 			return -EINVAL;
 		}
-		cur->active_spin_lock = 0;
+		cur->active_lock.ptr = NULL;
+		cur->active_lock.id = 0;
 	}
 	return 0;
 }
@@ -10582,8 +10596,8 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	    insn->src_reg == BPF_PSEUDO_MAP_IDX_VALUE) {
 		dst_reg->type = PTR_TO_MAP_VALUE;
 		dst_reg->off = aux->map_off;
-		if (btf_record_has_field(map->record, BPF_SPIN_LOCK))
-			dst_reg->id = ++env->id_gen;
+		WARN_ON_ONCE(map->max_entries != 1);
+		/* We want reg->id to be same (0) as map_value is not distinct */
 	} else if (insn->src_reg == BPF_PSEUDO_MAP_FD ||
 		   insn->src_reg == BPF_PSEUDO_MAP_IDX) {
 		dst_reg->type = CONST_PTR_TO_MAP;
@@ -10661,7 +10675,7 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		return err;
 	}
 
-	if (env->cur_state->active_spin_lock) {
+	if (env->cur_state->active_lock.ptr) {
 		verbose(env, "BPF_LD_[ABS|IND] cannot be used inside bpf_spin_lock-ed region\n");
 		return -EINVAL;
 	}
@@ -11927,7 +11941,8 @@ static bool states_equal(struct bpf_verifier_env *env,
 	if (old->speculative && !cur->speculative)
 		return false;
 
-	if (old->active_spin_lock != cur->active_spin_lock)
+	if (old->active_lock.ptr != cur->active_lock.ptr ||
+	    old->active_lock.id != cur->active_lock.id)
 		return false;
 
 	/* for states to be equal callsites have to be the same
@@ -12572,7 +12587,7 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
-				if (env->cur_state->active_spin_lock &&
+				if (env->cur_state->active_lock.ptr &&
 				    (insn->src_reg == BPF_PSEUDO_CALL ||
 				     insn->imm != BPF_FUNC_spin_unlock)) {
 					verbose(env, "function calls are not allowed while holding a lock\n");
@@ -12609,7 +12624,7 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
-				if (env->cur_state->active_spin_lock) {
+				if (env->cur_state->active_lock.ptr) {
 					verbose(env, "bpf_spin_unlock is missing\n");
 					return -EINVAL;
 				}
-- 
2.38.1

