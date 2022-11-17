Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DD362E1A7
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 17:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239719AbiKQQ0r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 11:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240494AbiKQQ0Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 11:26:25 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EB379900
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 08:25:17 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id m14so2120789pji.0
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 08:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ol7OxizXuiJ4eB7qeHuriIXAY7pywx1ZJI0gazh/20=;
        b=FfwioyLKnKJzuGPkjP+hVNEk0QIkO8lUDZQejsY8+cgsMRAhw6cQd6bOJWERDiezs5
         4pllJ29XOFNNBXyJsgWd2CaRVvD2dPwKpD+y1eZnrMkUqOnbab5osl8r1i4wpcQGNGCh
         B9puMdEqgibOfvf6UzSe9cbAJHA8lqGn22dQGI3ocJrxxJLdw8oZt78YmIn8Q5FUUJlL
         XPqNqwIyfDIvjrkRwDBjg+NCWIzOlCLQ8zBufsN71JOcgCePXjG6EgSzVhz/SL4vmJRX
         SizOwZz3RaOhQNDxYIA34rhMs65IVncLoorgd5gU3oWH3FTra4nduUM8yFP0KUm+lDvk
         fPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ol7OxizXuiJ4eB7qeHuriIXAY7pywx1ZJI0gazh/20=;
        b=j/jSg/haU63ofQfG3LXAnfgiyDgRiMRyHiRAqn/K+7no7pnplWrYW4LZhskSZeKC+d
         NSrpZNdUDbfX+gYsm0hOxZXC+Ksou0jt2VU7CYJnbXgdtf1blUumZShQQN40ib7QARkd
         hkL0RPa24HaCZTLvFV1/6eN6HmUQtb9HcpoW/RUmQ2Cl8O0ovDCT9dFTn2wRVqrTg6YA
         Nqo81mIzQQL2zcYIwa1g/EisKN+1JRUbbLqkOMvQiV+bratloP893YnFeuFQ/hrQwoJX
         wIfJ/VmmMUs+uFrqZ0KZwrRegkQ+3EFvWk2wFFjGtXVvQJRF77PPYr3AfRmPQw84pImP
         SGmQ==
X-Gm-Message-State: ANoB5pmqelTmaR4MFVd+bUulMh3XkDkJ4nFM0Y5t2hOpngObjJvpnsox
        uUBunATwXPf3AtpKBlyXnsGJn8XCcUQ=
X-Google-Smtp-Source: AA0mqf74BhbOc+C7AcKqMmfSXGcvUp/JSXOwf/BnsjYhJqhGfs5y6JnYkg9twO7ST39/LPVgG6CosQ==
X-Received: by 2002:a17:903:3282:b0:17e:c0f0:96a4 with SMTP id jh2-20020a170903328200b0017ec0f096a4mr3470457plb.80.1668702316947;
        Thu, 17 Nov 2022 08:25:16 -0800 (PST)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id qa7-20020a17090b4fc700b00213a9e1f863sm1149783pjb.4.2022.11.17.08.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 08:25:16 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v8 09/22] bpf: Allow locking bpf_spin_lock global variables
Date:   Thu, 17 Nov 2022 21:54:17 +0530
Message-Id: <20221117162430.1213770-10-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117162430.1213770-1-memxor@gmail.com>
References: <20221117162430.1213770-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7353; i=memxor@gmail.com; h=from:subject; bh=6Vv4lEhpsQX066e3Wnco5QRfk4WP+T5sUnI+NWbYFw4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjdl7/8Zv5F6jnmv0dZ31LuaSqMWJy1JocMzVB/Fne /JTeMQSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3Ze/wAKCRBM4MiGSL8RyiwaD/ 4jOX0f6tkaeg9tihNuMurTetlwKtGfbNVhzRa0eozRzL3o8E0YsrfMrBij93rBJB8Tv682j1Rj9nlp QNGttprjhllA6O5KctnQzNShHYZl+RZhoK6aAvk3xSLTJNKyEWkOSpk0cYPqGcgQAcINT2YFxkro17 VIOZ3eJ7BGmjbqJHE4/qZnN+v43FMmdW3L9iLt2OOAJNRw6gaVVuqkMpmPtByrzsmQueCydDK3mY/p pqmhYmMhh70i6l7DFLv5YHDtQQT3vA3TntO+W93p4kJE115Verfi2IKeebmYqpZHj2ZYU+yFGAflPz oFOc8cWX3bEyqff47trE7YSdvBSh0hmUBoyPXI9BJoozn6NyNHcorv/WfzmtZuUkwRKhnmHhLCQ8uP fLyr1NCnSNpgZD/vGPeHKYOgRB3puZVig42/hxe9fSRTmS4FhWKjwsdGK0o4WVbRxTL0f+dTvPCL7g 0xsbd7NuZifY8gtmVMqt2sQ/KHTI3NZ2QB2z63Jl0QR+NGY5rcdJJHt+/V0kFcdMZ16wtlaW7g+yiy dYcxy9pw39Yx2nWBu9LvMrs6mUJPtF/QlDWkcHIBPp7s6T3vYtA/iLRPuKdUNvZ00AAUhoRIpwAWqT LVfSQz5oBfeNhos8YJO/podJfe8TWR6l135fBWOO715S0+05BQZReBGDdWqQ==
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
 include/linux/bpf_verifier.h | 16 +++++++++++++-
 kernel/bpf/verifier.c        | 41 ++++++++++++++++++++++++------------
 2 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1a32baa78ce2..3770bb1a6f62 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -323,7 +323,21 @@ struct bpf_verifier_state {
 	u32 branches;
 	u32 insn_idx;
 	u32 curframe;
-	u32 active_spin_lock;
+	/* For every reg representing a map value of allocated object pointer,
+	 * we consider the tuple of (ptr, id) for them to be unique in verifier
+	 * context and conside them to not alias each other for the purposes of
+	 * tracking lock state.
+	 */
+	struct {
+		/* This can either be reg->map_ptr or reg->btf. If ptr is NULL,
+		 * there's no active lock held, and other fields have no
+		 * meaning. If non-NULL, it indicates that a lock is held and
+		 * id member has the reg->id of the register which can be >= 0.
+		 */
+		void *ptr;
+		/* This will be reg->id */
+		u32 id;
+	} active_lock;
 	bool speculative;
 
 	/* first and last insn idx of this verifier state */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8eddecfc3a5e..b231abbeaf55 100644
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
@@ -5590,7 +5591,7 @@ int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
  * Since only one bpf_spin_lock is allowed the checks are simpler than
  * reg_is_refcounted() logic. The verifier needs to remember only
  * one spin_lock instead of array of acquired_refs.
- * cur_state->active_spin_lock remembers which map value element or allocated
+ * cur_state->active_lock remembers which map value element or allocated
  * object got locked and clears it after bpf_spin_unlock.
  */
 static int process_spin_lock(struct bpf_verifier_env *env, int regno,
@@ -5639,22 +5640,35 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
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
@@ -10616,8 +10630,8 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
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
@@ -10695,7 +10709,7 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		return err;
 	}
 
-	if (env->cur_state->active_spin_lock) {
+	if (env->cur_state->active_lock.ptr) {
 		verbose(env, "BPF_LD_[ABS|IND] cannot be used inside bpf_spin_lock-ed region\n");
 		return -EINVAL;
 	}
@@ -11961,7 +11975,8 @@ static bool states_equal(struct bpf_verifier_env *env,
 	if (old->speculative && !cur->speculative)
 		return false;
 
-	if (old->active_spin_lock != cur->active_spin_lock)
+	if (old->active_lock.ptr != cur->active_lock.ptr ||
+	    old->active_lock.id != cur->active_lock.id)
 		return false;
 
 	/* for states to be equal callsites have to be the same
@@ -12606,7 +12621,7 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
-				if (env->cur_state->active_spin_lock &&
+				if (env->cur_state->active_lock.ptr &&
 				    (insn->src_reg == BPF_PSEUDO_CALL ||
 				     insn->imm != BPF_FUNC_spin_unlock)) {
 					verbose(env, "function calls are not allowed while holding a lock\n");
@@ -12643,7 +12658,7 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
-				if (env->cur_state->active_spin_lock) {
+				if (env->cur_state->active_lock.ptr) {
 					verbose(env, "bpf_spin_unlock is missing\n");
 					return -EINVAL;
 				}
-- 
2.38.1

