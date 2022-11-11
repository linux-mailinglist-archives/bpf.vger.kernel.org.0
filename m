Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5171C626202
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 20:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbiKKTdy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 14:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbiKKTdx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 14:33:53 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A39EFD1B
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:33:52 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id j12so4973042plj.5
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ruv1j+cZdobWg2qL9jWAKCo/MTt4/bsWMBmKgD+pRUI=;
        b=AxG4jxUjB+Ed9plYgaBG0b3OEDq+1B7E6tPLMv9OPYVDCno9tUIJE+akGJsrsb/meq
         N6NEBd1J/hsj1rWPZ7cD2jqg4xD8b5kSjY4mzk/Ba9cdnzgvNZGFOM4mk6deXUEW5XeN
         htx8aGne7Fzr0X/+zZizvspwHhWXu6uwneq2OIU1DczrtQW2gl34882WilLXEjuovz6q
         NFGBnArlc4ILzZo5ePwbEtrCAfhKmlPq6uqYX7s3sy5z1Q8ece+8DfdO0DTBaXRyEDec
         2RUi0uJMEIzY3JcpoNQpF/AHW2wRiVf24ckje+gC+uEmWI991bsyZ8x2pxG1IRTSn/yf
         nDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ruv1j+cZdobWg2qL9jWAKCo/MTt4/bsWMBmKgD+pRUI=;
        b=aMHrhub+kSqYbd4RksSBxBRFF2ypVygLifaq7rwaE7ogrbyO/bn3gJdzyA8BJ5f3en
         sTnGOpWW86u1Dv4Fy8md30Sani+v8N0EYrhZgfyP5St610F0sjF+PPI6YGpOhMYq+oH7
         vUXxfjrfjLubKMDr8YNT+2SnWWeOOZZ7+ymGVRSEnUddGtMXC2DclR3TkegPTl1Ek43O
         duw6mIaVvH9IuAQ4sjOKTV1qkl+pq2KzYzBq/BPXqYgop04bF0vxgP/5Tr5fp2fgyU4O
         CvXGG3YkKN4k92BKUYxIHQvR6VmCHwg1un2bDcK5U0wCJReORgFcmkAvI4CkwN69ebOB
         hvYg==
X-Gm-Message-State: ANoB5pnmi2YqcqMEXn0zVPCndtDqLMMEh8xbNbDC2KmoZ56FRCM5JmMO
        JhrQeKx9lz/yi/wCurHPaPWekSuLx7aW6Q==
X-Google-Smtp-Source: AA0mqf6XygZDbvgqzx8wHb7otizhDh/3BiDe5r0CHyqV0bP6n6QY1WEDsoE4M2pbSx1PxKj7OFl4Lg==
X-Received: by 2002:a17:902:9a84:b0:186:dd96:ce45 with SMTP id w4-20020a1709029a8400b00186dd96ce45mr3876133plp.73.1668195231349;
        Fri, 11 Nov 2022 11:33:51 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902dac800b0018725c2fc46sm2053778plx.303.2022.11.11.11.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:33:51 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v6 12/26] bpf: Allow locking bpf_spin_lock global variables
Date:   Sat, 12 Nov 2022 01:02:10 +0530
Message-Id: <20221111193224.876706-13-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111193224.876706-1-memxor@gmail.com>
References: <20221111193224.876706-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6954; i=memxor@gmail.com; h=from:subject; bh=Tbs9M3TN39iyfYHv7AxXD1oQurmlF6bK44azbWHrVsw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjbqIoIFIyshcZo+KB+O/XZEVYBEvH2TmA3BZEv985 FpmVvBGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY26iKAAKCRBM4MiGSL8Ryg9lD/ 9FhRw6RGpuqMVHa61/3IzGFdVL0uVqanJ8aUUH7mmK4pJ/p9iNeNlZZRSMayMKOH4M7mlWzVf3ebol EUDoMMmbVL28PF62Ri8yDToIVJt8zCWQgdiRoIXaa0SAPy/lIO7fqlbr6IC8jZWZoxzsMEyKOrtTjl zvG1JnyujsMELbIORDXp/ujBYPXTnt5pWy9blzRBUftcJIlp6CydNSCkpmMh+gP42NOEt7tKIom+Xb xN9HyZucbnmncv+YvBHxqeFP6wfTDKlMebDase2vLG7DuYd2pgv9eG2KA5vWOSw1Rs3ts4Ztlmb5De 19baOkrMbNbCBcVZkdKTGJnA9UQD0bzBNrL2vh33TcKV8JlhVJatztFsI6f9TiGCJOQDxaiwArRR7A dux0l2+pSkkfolBsvJrxI2Ab1u38qwedvuMZ8EAFuOYTS2ySlEWpRuLLfmPQ6cPCbbH1QXJlqP0dF9 Xq66GxueF4qP1UzNjprieZDTK5k+M5tvlCqXzYalvM4PTw8efTphdeSWcWEqPj5abaEKvl2HLo1vBw HBuqKOJ3QHjG62HnC/mla+zy4OX/1/S7BYnVNJKfvBGZXhGP5jNks15Q9U/R16ds0bC6mqQ9vaqtvh 834j+PRwSix/mHtJdYTSqqLJujPiYUAbWdRyk4QAPStHA4zr+hGGgmf8Kclg==
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
index 3831364af1ce..bd13104b018a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1210,7 +1210,8 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	}
 	dst_state->speculative = src->speculative;
 	dst_state->curframe = src->curframe;
-	dst_state->active_spin_lock = src->active_spin_lock;
+	dst_state->active_lock.ptr = src->active_lock.ptr;
+	dst_state->active_lock.id = src->active_lock.id;
 	dst_state->branches = src->branches;
 	dst_state->parent = src->parent;
 	dst_state->first_insn_idx = src->first_insn_idx;
@@ -5582,7 +5583,7 @@ int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
  * Since only one bpf_spin_lock is allowed the checks are simpler than
  * reg_is_refcounted() logic. The verifier needs to remember only
  * one spin_lock instead of array of acquired_refs.
- * cur_state->active_spin_lock remembers which map value element got locked
+ * cur_state->active_lock remembers which map value element got locked
  * and clears it after bpf_spin_unlock.
  */
 static int process_spin_lock(struct bpf_verifier_env *env, int regno,
@@ -5631,22 +5632,35 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
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
@@ -10573,8 +10587,8 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
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
@@ -10652,7 +10666,7 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		return err;
 	}
 
-	if (env->cur_state->active_spin_lock) {
+	if (env->cur_state->active_lock.ptr) {
 		verbose(env, "BPF_LD_[ABS|IND] cannot be used inside bpf_spin_lock-ed region\n");
 		return -EINVAL;
 	}
@@ -11918,7 +11932,8 @@ static bool states_equal(struct bpf_verifier_env *env,
 	if (old->speculative && !cur->speculative)
 		return false;
 
-	if (old->active_spin_lock != cur->active_spin_lock)
+	if (old->active_lock.ptr != cur->active_lock.ptr ||
+	    old->active_lock.id != cur->active_lock.id)
 		return false;
 
 	/* for states to be equal callsites have to be the same
@@ -12563,7 +12578,7 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
-				if (env->cur_state->active_spin_lock &&
+				if (env->cur_state->active_lock.ptr &&
 				    (insn->src_reg == BPF_PSEUDO_CALL ||
 				     insn->imm != BPF_FUNC_spin_unlock)) {
 					verbose(env, "function calls are not allowed while holding a lock\n");
@@ -12600,7 +12615,7 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
-				if (env->cur_state->active_spin_lock) {
+				if (env->cur_state->active_lock.ptr) {
 					verbose(env, "bpf_spin_unlock is missing\n");
 					return -EINVAL;
 				}
-- 
2.38.1

