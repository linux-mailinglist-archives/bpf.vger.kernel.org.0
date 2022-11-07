Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034E2620362
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 00:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbiKGXKf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 18:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbiKGXKa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 18:10:30 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9CF21255
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 15:10:29 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id l6so12165185pjj.0
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 15:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIhIL4dohOPWzRl2T6wUmZxNEb9GITrVnG/bgpRugSQ=;
        b=WLRRZ6+WeqHicYGu0U+xoh9qk3/p56N3w+uxJjdIx6Me6Dm3w32BxKX0T0SLgofi+M
         MnI1XVq50i+1BDzId6us2PLoPlXUNaP45Cu1aOvCKTrh1Cn3Q/tTFSv8V+mgFjG97qfP
         RPlQ6sH8Gh5iEvuV02OiwqZN7/r8mFCbTeCcYseZ60iJNvMBnhhH98hi1xUP4pZctC+t
         qxJ5mfw4pKDERl1lLISg57bXuO5gmHpIta8O2ujtiEi8roPJ0P4T1iRmSw/cfKlGI5bx
         BYjKesfGoe1Xz/UI2Izet0zsiJIAq4AuiJWT6Xbh3KxDi8cD5QgvdtOOhFyD3Uw+igbe
         y4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MIhIL4dohOPWzRl2T6wUmZxNEb9GITrVnG/bgpRugSQ=;
        b=ZO0Q7moJLEmNxxyLlpo01VRV5d4YIzFgLtStwtX2iBvrpAgtECLaYCm8rnpELMFSlu
         LFsGx3o82o/HTr9tr+hC+SscbkRCTDu3Wbz1pIEnX3AEMn0Q2+dSmkIOZCcjwso2YXlF
         I2PdxropWIXL0Ofm5qwJMQc/hDHX4bHuiAduJjWOnguNlpYc7lEDI5GxyO+WHU3T4N1D
         imhBaYSzr4qwTesOyyox2rUP4v3y2u2vPMY0nTZG3UYezgzXcA3314xFMGksnD956DjE
         QBa00DJSLvlt+heza1dq9Ls6SMxpXL0bF+x+LwruhDyn6Ik3QaQlmfzttVu+zLW/+59Y
         Culg==
X-Gm-Message-State: ACrzQf1aiD8BHtYak6TP3i0uvN7m7w3oVRfuzV4zMYMVacGVPCFSxOxk
        xRTLmqq1bX87wWIU3mitDc8nhBZLE06zvA==
X-Google-Smtp-Source: AMsMyM4iOspFN7t12MUXGMe9ghtYJLmDHe6DhI6t4lAX2XZlcpnoy2VRT9tUgeTjhglnwv8hcgVD7Q==
X-Received: by 2002:a17:90b:4ac5:b0:213:e936:a843 with SMTP id mh5-20020a17090b4ac500b00213e936a843mr44487853pjb.156.1667862628971;
        Mon, 07 Nov 2022 15:10:28 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id d20-20020a170902e15400b00182d25a1e4bsm5455414pla.259.2022.11.07.15.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:10:28 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v5 10/25] bpf: Allow locking bpf_spin_lock global variables
Date:   Tue,  8 Nov 2022 04:39:35 +0530
Message-Id: <20221107230950.7117-11-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107230950.7117-1-memxor@gmail.com>
References: <20221107230950.7117-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6765; i=memxor@gmail.com; h=from:subject; bh=UFBOFJul7eTIVrFTDVKBsNyvEBE0cydPvbeqN/Sbkyg=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjaY+2P4r9T5QYfKewSp5U3NNvqyeqM8Tgt0RtJfIm K06P7vqJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2mPtgAKCRBM4MiGSL8RyugTD/ 9cPEzwBc7gyeLMXytoL6DZQuzQoweFQX4faoVJKfSQyEGncqMBZBMNs9k95HO+GmAlVneJIEbK55sE n+zryU9FizhAQR4kxw+Jzvm/GMsr4bQUO497hMWoVF2GXmPqXSg+fF+ZBJrDTjB1N4/Ht6rWnlORsx PaNcM9jTaMgMQDKoKqKQ7t974ZeMPpY35q4EaTvd1PMGXU927Jk4pwUQUQ0gWaLbh1nsZx4ym6TN9y W2PvAa/jdhPwBU2Uk65FRb8J16EiaDaE3GIx1uWwt7PvyrZI/AzSkJeFOpKCBKVLpl8/efoPKx+M/R mlgpBI0Kwav2BE6aErVwyAN0l9vm/A5zQ9Zoqy5JbZxxSooIwsskUzjCQjX6zBKNu1BX7TxhWtecam 72ZJVCKTmbIWWZ7BHO+go9MBbDfMVB1efQ/+J5mWrsmIdvuDxwbSQGmauaRetS0AlnYFZbRsXN4ryT aVf5LqCeEUuC7HPjjW+pwNgJPADESPJNFAo1/zuIEcDpgFnvNIqgpsZtE4tJvp54z7yLx2IWNLoBQY uYam5hdUQIF3/CuPmt7VUl8ILpvQpPB+s1YeA2KGMYszPkVjyP7PSff5m0Hs2zAqBohhz6T6Pl3FSO C7g7ZxKH45jdjVDyBQJHYSTb/uzXvShoJtQ4EvAw+r4fpLZnqSndriMVO1sg==
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
and local kptr registers at the same time.

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
 include/linux/bpf_verifier.h |  5 ++++-
 kernel/bpf/verifier.c        | 41 ++++++++++++++++++++++++------------
 2 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1a32baa78ce2..70cccac62a15 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -323,7 +323,10 @@ struct bpf_verifier_state {
 	u32 branches;
 	u32 insn_idx;
 	u32 curframe;
-	u32 active_spin_lock;
+	struct {
+		void *ptr;
+		u32 id;
+	} active_lock;
 	bool speculative;
 
 	/* first and last insn idx of this verifier state */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f1170e9db699..281a6a04a0d8 100644
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

