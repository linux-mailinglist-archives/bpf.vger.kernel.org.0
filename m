Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758385FD4B8
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 08:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiJMGYN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 02:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJMGYL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 02:24:11 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1382912345F
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:24:10 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so1065856pjf.5
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPjFt0x0ZGMgRHoaUrgZdDhkjsDLFx3EbQINDr5QavE=;
        b=VLSwygsiMW7I32G4Juv4VmP6Pf+469Wmr151nc6/ynUj4LupqWKZiKqgK4ibysXsAP
         h2+uqFCIJe2ndRt82fkv+GqrQTwJPMoviDzgkekTIhd4emxPbexz5cMuHZ4BWg0ViCGH
         IQP79sZ1AatFcWrIJ9cTMJ99yj4FHTyA6O/t7lJe3S1Y9mJ3SdnZCvmDjklx5BqQvmvA
         O8PfWUmQRrHXHJxoZ606jVtlgEVEiCBbvtbpiTDvwXFvEF+A5rE486QMzNgQPYTrJK2b
         Ow6HOC0KQV3zwYm8adw0EXXNp9ZOvFdyOwPuvcwy1dSCaNx7E/G/o3J4ptLORfqHjQPf
         NIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPjFt0x0ZGMgRHoaUrgZdDhkjsDLFx3EbQINDr5QavE=;
        b=Fp8D2ODK5tBNkMzriiTJIXdAIpBKP1HlvEi9Y80e2Tr2Q8+4fbYKW5Gyt4JZJTkwbo
         zRvl7zl+qeIVFZ3jeGDJ3hAnpncpthuEmGzEZ5FZ8f1BoCR3pWZ19WDCaPo7FGVHnrfR
         jCbs0XScZv5wkKiwOlinsv1gLM19lH9rml+dPdaRIkAZUTAxq6nuSXkDDoBJWNmvXOH8
         ez+gu4b74CXmBj0HO5JdVNMV5pPkGk+7dYr/X0UWiJomwbuY+W08OBI7S60nI68uRYhJ
         xpkrK+KbvMKrTd6KrVecLXVtY3sc8KRnV042PM9Xf3lqmtlvqhZvDUhdsaXr15hwd+Uk
         S4QQ==
X-Gm-Message-State: ACrzQf14997IdF/DfCOWFGc0PuKNk36WpCBp52SBmvEs7cmlOFWPZuNL
        ihSKovn3MdoQM1uuZJSyQeqVXqtv0UM=
X-Google-Smtp-Source: AMsMyM7Xi4xVbOwgfAi53egAf9F4GJcS9cWn8loJ4p5QZQfozAFrTEHF7Jv/xSlsb6rEmEqT7VBqtg==
X-Received: by 2002:a17:90b:3a90:b0:20d:a54c:e5cd with SMTP id om16-20020a17090b3a9000b0020da54ce5cdmr2387076pjb.183.1665642249228;
        Wed, 12 Oct 2022 23:24:09 -0700 (PDT)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id 5-20020a620405000000b00562832fc0ffsm1008664pfe.56.2022.10.12.23.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 23:24:08 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v2 14/25] bpf: Allow locking bpf_spin_lock global variables
Date:   Thu, 13 Oct 2022 11:52:52 +0530
Message-Id: <20221013062303.896469-15-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013062303.896469-1-memxor@gmail.com>
References: <20221013062303.896469-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5597; i=memxor@gmail.com; h=from:subject; bh=89Cf5ARZlB2TiH4IPC2c9c9P+jgappSduCQrrFzDTc0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjR67DX9bnOgooSfVqpGXDMoa1cUQEVQd1ydUV0j0n di43Gg+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0euwwAKCRBM4MiGSL8RyhVcD/ 9cVn/R2sq7ZtRBLdeP80PlKjyWnMPypsF9KlgT/gm3aKQr5/ZWMXF0dSHA9fI2co9KUwvAAb+WyqjG Hh6X2yS0JXeYrQodAuiFFzNYn7lbntk9QQYzlye/A6wkg/g4IgRRZRh1tp4scnUFJ1fwRHwwffaiM5 Jz4vCTIgsj8W/YxH0UC6xihwWVNMHFBGp4NeGjAbfm13z8cSbKFeCbGAYnfrXbNmNah9YAq4nbZ85r T6pnicvAGUBMGqGxDEjZsYRT7z3oq2dbHH7MbXCxbBifYGX91xzralYeIgmrsCh5mtFd28yxxfVIgl nWCyVmFROeJhZI5wSl5f9ABkH/kZEWXWIj+2t6LF7Xg5jc3fM2TuW4mBygbV2p29iOYaSeOksZoRJw THkhFwts4lvW3fd2N8+TnQT0j+kBkjqaxwhrXFL1OtnBPP5uIRldainLt/OfobNXGA74TKc8iXi1yW EHkdhAsaLd7HKaI3JVYRoSK5YU69mZ83ecANViK8LwMcl8gV/t+E7nZejhtJW+uf4Db3eSJRNuIV8R n93HBqIVnpJtbsaPTDKvokDs+e4JxvgsEu74U5BEtXr+OvUWHDuDvgebF8E9Vp6zrthL8G74Nqr4D/ U2l0BrCNl2poynt1RsCnTV4hOJ2VzpfX0MHuP1WoalrKgn3yg7hIA29JqSmQ==
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

This is not great, so refactor the active_spin_lock into two separate
fields, active_spin_lock_ptr and active_spin_lock_id, which is generic
enough to allow it for global variables, map lookups, and local kptr
registers at the same time.

Held vs non-held is indicated by active_spin_lock_ptr, which stores the
reg->map_ptr or reg->btf pointer of the register used for locking spin
lock. But the active_spin_lock_id also needs to be compared to ensure
whether bpf_spin_unlock is for the same register.

Next, pseudo load instructions are not given a unique reg->id, as they
are doing lookup for the same map value (max_entries is never greater
than 1).

Essentially, we consider that the tuple of (active_spin_lock_ptr,
active_spin_lock_id) will always be unique for any kind of argument to
bpf_spin_{lock,unlock}.

Note that this can be extended in the future to also remember offset
used for locking, so that we can introduce multiple bpf_spin_lock fields
in the same allocation.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  3 ++-
 kernel/bpf/verifier.c        | 39 +++++++++++++++++++++++++-----------
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 9e1e6965f407..c283484f8b94 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -323,7 +323,8 @@ struct bpf_verifier_state {
 	u32 branches;
 	u32 insn_idx;
 	u32 curframe;
-	u32 active_spin_lock;
+	void *active_spin_lock_ptr;
+	u32 active_spin_lock_id;
 	bool speculative;
 
 	/* first and last insn idx of this verifier state */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5114cc97cdd4..41a5cc5fbcd4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1201,7 +1201,8 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	}
 	dst_state->speculative = src->speculative;
 	dst_state->curframe = src->curframe;
-	dst_state->active_spin_lock = src->active_spin_lock;
+	dst_state->active_spin_lock_ptr = src->active_spin_lock_ptr;
+	dst_state->active_spin_lock_id = src->active_spin_lock_id;
 	dst_state->branches = src->branches;
 	dst_state->parent = src->parent;
 	dst_state->first_insn_idx = src->first_insn_idx;
@@ -5460,22 +5461,35 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 		return -EINVAL;
 	}
 	if (is_lock) {
-		if (cur->active_spin_lock) {
+		if (cur->active_spin_lock_ptr) {
 			verbose(env,
 				"Locking two bpf_spin_locks are not allowed\n");
 			return -EINVAL;
 		}
-		cur->active_spin_lock = reg->id;
+		if (map)
+			cur->active_spin_lock_ptr = map;
+		else
+			cur->active_spin_lock_ptr = btf;
+		cur->active_spin_lock_id = reg->id;
 	} else {
-		if (!cur->active_spin_lock) {
+		void *ptr;
+
+		if (map)
+			ptr = map;
+		else
+			ptr = btf;
+
+		if (!cur->active_spin_lock_ptr) {
 			verbose(env, "bpf_spin_unlock without taking a lock\n");
 			return -EINVAL;
 		}
-		if (cur->active_spin_lock != reg->id) {
+		if (cur->active_spin_lock_ptr != ptr ||
+		    cur->active_spin_lock_id != reg->id) {
 			verbose(env, "bpf_spin_unlock of different lock\n");
 			return -EINVAL;
 		}
-		cur->active_spin_lock = 0;
+		cur->active_spin_lock_ptr = NULL;
+		cur->active_spin_lock_id = 0;
 	}
 	return 0;
 }
@@ -10382,8 +10396,8 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	    insn->src_reg == BPF_PSEUDO_MAP_IDX_VALUE) {
 		dst_reg->type = PTR_TO_MAP_VALUE;
 		dst_reg->off = aux->map_off;
-		if (btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK))
-			dst_reg->id = ++env->id_gen;
+		WARN_ON_ONCE(map->max_entries != 1);
+		/* We want reg->id to be same (0) as map_value is not distinct */
 	} else if (insn->src_reg == BPF_PSEUDO_MAP_FD ||
 		   insn->src_reg == BPF_PSEUDO_MAP_IDX) {
 		dst_reg->type = CONST_PTR_TO_MAP;
@@ -10461,7 +10475,7 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		return err;
 	}
 
-	if (env->cur_state->active_spin_lock) {
+	if (env->cur_state->active_spin_lock_ptr) {
 		verbose(env, "BPF_LD_[ABS|IND] cannot be used inside bpf_spin_lock-ed region\n");
 		return -EINVAL;
 	}
@@ -11727,7 +11741,8 @@ static bool states_equal(struct bpf_verifier_env *env,
 	if (old->speculative && !cur->speculative)
 		return false;
 
-	if (old->active_spin_lock != cur->active_spin_lock)
+	if (old->active_spin_lock_ptr != cur->active_spin_lock_ptr ||
+	    old->active_spin_lock_id != cur->active_spin_lock_id)
 		return false;
 
 	/* for states to be equal callsites have to be the same
@@ -12366,7 +12381,7 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
-				if (env->cur_state->active_spin_lock &&
+				if (env->cur_state->active_spin_lock_ptr &&
 				    (insn->src_reg == BPF_PSEUDO_CALL ||
 				     insn->imm != BPF_FUNC_spin_unlock)) {
 					verbose(env, "function calls are not allowed while holding a lock\n");
@@ -12403,7 +12418,7 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
-				if (env->cur_state->active_spin_lock) {
+				if (env->cur_state->active_spin_lock_ptr) {
 					verbose(env, "bpf_spin_unlock is missing\n");
 					return -EINVAL;
 				}
-- 
2.38.0

