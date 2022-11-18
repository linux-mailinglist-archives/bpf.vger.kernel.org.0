Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE1E62EB6B
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 02:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbiKRB45 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 20:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240959AbiKRB4u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 20:56:50 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15E98756A
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:56:48 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso3483921pjt.0
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=680O5ghX0Kvi4oZdK0wuqtRrRb8KoMWSYqDIANShvnM=;
        b=DI+hr6rzWmHFS40ffOGbJ8BGaQE5X8/S99olis3w32uizZLEROXMw948j4O0TotCG+
         4krw/IJhHNc2d8ykegaut2G5smOfHpFn5hEnPxzwENDYSKWi0DSwegq47fiXgAyit8dZ
         1hXAPfhGGM/gsmsw5VFpdvUjkkI22e7pPQCfbMYxu1/lgp21Jw1+2TxqVG+cOklSgFcr
         YuFSxu4sLfpjpi9E4GMCMeG/cAGbjbWjvNTvQ0YkPnMs9frVKZo7iUdqHUwVcHHgm/QR
         zWmPUa5mM1hf/9Z8tvBgfyXbR5zVEcPkXReXGgz4TVgNLeebbBOXmaF2tfSLDf0Su9+m
         p9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=680O5ghX0Kvi4oZdK0wuqtRrRb8KoMWSYqDIANShvnM=;
        b=iPZArkr/fGXzvXs7/3BlCSW6y9wsA3hChlxdMk8MWyJotapoEIP3kKRACK9VYSzHif
         9JZAlHBrrjIkY0sW8oPJuKNLiyC8TEY9WYmQZrIrmrS1eL+S5FH3R5+a0QjKkd1Xtgkr
         f330GXSmxFtEqbR2l6M6DJ7/xlz2eVbh46pvwBC0fPuy+BpvyqclND7VrFIFPFC6YK/0
         +lVjMs5c01lOb7ase8rvWbVHkAIprC89q5cbGpSlsZ17iSviY0IJ4Vv4kLAiARvQW1kE
         bexPQFCM+m2ZGTbIipW/C5MjGSZ8F0PvtKeMIPfOfmUyNWbjpbXkPjKkGgADt8Q49xmV
         jSwg==
X-Gm-Message-State: ANoB5plG1HSwzqCTZtjhAvbuNTEcUSDT1hj7Cr38C6CH235uOEUMwmhL
        0ZK76pTWexLDSIcNKkSHf9eAEUjvLh8=
X-Google-Smtp-Source: AA0mqf553s3GGoYQ/tAWcN8MsQO9okI1QCVNXs/7lLGKFPQ1sE87OMHioOUDNfsV+JVGAivwylHJOg==
X-Received: by 2002:a17:902:b782:b0:188:6300:57ad with SMTP id e2-20020a170902b78200b00188630057admr5443210pls.7.1668736608004;
        Thu, 17 Nov 2022 17:56:48 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c20c00b00172f6726d8esm2031423pll.277.2022.11.17.17.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:56:47 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v10 09/24] bpf: Allow locking bpf_spin_lock global variables
Date:   Fri, 18 Nov 2022 07:25:59 +0530
Message-Id: <20221118015614.2013203-10-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118015614.2013203-1-memxor@gmail.com>
References: <20221118015614.2013203-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7353; i=memxor@gmail.com; h=from:subject; bh=xOb0HmxbHFXCl145PGXBVuOK0IaP2FoJId5LwZB4IUo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjduXO1SX4kqJ2ZkXfjomhw409xsV+EhgodsH+nwvf nOmQZVyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3blzgAKCRBM4MiGSL8Ryr7rEA COFZevUyMaJ/O5ZknNrAlMhd+enrZ/GK3ols+FP7C74Mc6/Fi0QSykmT4hbFL0EbDQMXAoe03ZV4Ys pvcW3ivWmDsZ6nFZB7MAC6m1YyqXYqYOlQZ4O21aAcZhSzqR1CYej01eU1UQY/Irwo5eeysKLiQwAB qJZRBRP16R62VtdICavAXsXPC4FK4l5HbGEOeQCoIEfyHmIi1oCuJ46NPLJZ8qV1bmTMmPuMOePwJL jeRx+IJqLP7V0DX/IsMGnbzmObD3bIxTraWC3KjMPfwMeC+nO5qvzYcEYyTxMBWrmhKzL0zhgmgeor feTVdsBZmr6xxy+SgUxOvE6Xd/veaYx3aefe3wtZU70qav0g2xbCMBnMbs/j7/p6obx7CfOBdi9ELS Bk/C1ZAauSGH/YLUKfh83MkGiYSYJz2IFKAOPkfwVXMWELL6tPNTAwWzxY+WOU0O1ZowFqfEsm73J8 4KSO2V9HCDggsXzZo+cWZ2g0b0KiL77a9NGuLVZO7J7OnvSK+tEEeTDx/UyA0hn7CtKu4ZgImVQeHR KDsbP53pSNdCmdot+BrEx0Hqf6RwMJn0KViN2+mXcRTe3mgtIT4EIu7JqusYpjGzmv/IJaQwn0hpU0 bNd4w6CVaxyNwwG44bamE6LhTKYCBjq2ilkkBZ3dKXb2l5/0dwIhFJCp/zKA==
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
index 1a32baa78ce2..1db2b4dc7009 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -323,7 +323,21 @@ struct bpf_verifier_state {
 	u32 branches;
 	u32 insn_idx;
 	u32 curframe;
-	u32 active_spin_lock;
+	/* For every reg representing a map value or allocated object pointer,
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
index 19467dda5dd9..c8f3abe9b08e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1221,7 +1221,8 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	}
 	dst_state->speculative = src->speculative;
 	dst_state->curframe = src->curframe;
-	dst_state->active_spin_lock = src->active_spin_lock;
+	dst_state->active_lock.ptr = src->active_lock.ptr;
+	dst_state->active_lock.id = src->active_lock.id;
 	dst_state->branches = src->branches;
 	dst_state->parent = src->parent;
 	dst_state->first_insn_idx = src->first_insn_idx;
@@ -5596,7 +5597,7 @@ int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
  * Since only one bpf_spin_lock is allowed the checks are simpler than
  * reg_is_refcounted() logic. The verifier needs to remember only
  * one spin_lock instead of array of acquired_refs.
- * cur_state->active_spin_lock remembers which map value element or allocated
+ * cur_state->active_lock remembers which map value element or allocated
  * object got locked and clears it after bpf_spin_unlock.
  */
 static int process_spin_lock(struct bpf_verifier_env *env, int regno,
@@ -5640,22 +5641,35 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
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
@@ -10617,8 +10631,8 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
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
@@ -10696,7 +10710,7 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		return err;
 	}
 
-	if (env->cur_state->active_spin_lock) {
+	if (env->cur_state->active_lock.ptr) {
 		verbose(env, "BPF_LD_[ABS|IND] cannot be used inside bpf_spin_lock-ed region\n");
 		return -EINVAL;
 	}
@@ -11962,7 +11976,8 @@ static bool states_equal(struct bpf_verifier_env *env,
 	if (old->speculative && !cur->speculative)
 		return false;
 
-	if (old->active_spin_lock != cur->active_spin_lock)
+	if (old->active_lock.ptr != cur->active_lock.ptr ||
+	    old->active_lock.id != cur->active_lock.id)
 		return false;
 
 	/* for states to be equal callsites have to be the same
@@ -12607,7 +12622,7 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
-				if (env->cur_state->active_spin_lock &&
+				if (env->cur_state->active_lock.ptr &&
 				    (insn->src_reg == BPF_PSEUDO_CALL ||
 				     insn->imm != BPF_FUNC_spin_unlock)) {
 					verbose(env, "function calls are not allowed while holding a lock\n");
@@ -12644,7 +12659,7 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
-				if (env->cur_state->active_spin_lock) {
+				if (env->cur_state->active_lock.ptr) {
 					verbose(env, "bpf_spin_unlock is missing\n");
 					return -EINVAL;
 				}
-- 
2.38.1

