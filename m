Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970C15FAA0E
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 03:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiJKB0b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 21:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbiJKB0L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 21:26:11 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C073B83222
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:25:53 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id l4so11835356plb.8
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OD3EPkTKGBgNbXKL97MOegQWnNjgGT9dmBv7QHvdDDA=;
        b=AA4qJyuq+MgSrcuQkeQ3rihUO6yMbaGfEMHpRYQ3ahaGfvtQQRoq3/Bea/0Xetrvyy
         huq+lHTmAc+4m567v59rgeFrMnvPd4DfxHsijIbX5mplJ7b0IzzYfHolWNwbXbkurtmq
         kL5BKWG20yhZ4YRdsnY0Cu5N1FE8aYJzf1fqosf24Bj9cFJw/JTOgxTy1PCSnNK+qNE4
         pz8e4Byh2vWz+6dKGHP1kTNGazoPh/wANv0KF5IJNSPJ8hyfHUlpUJ46kVSfbWhzjJWs
         MBENp59ESEDEMOv4NjJfcS/TZVYR/GOJ19oGJtLSsO9BUYq11IHymQw1+iqUwS5TKzIn
         NMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OD3EPkTKGBgNbXKL97MOegQWnNjgGT9dmBv7QHvdDDA=;
        b=Kdlt6XnKt66Ty5C831xKDRKNh8gT57dIwqxywrXjHT29LiOOywXPfQL8TVZy4evdE1
         quKhT+VP9CWvGApIxx+Q7sHt1baJjSM7vIoMYlHt7E9r35m4preng/b44X3rwKXtPIed
         PUUu9x9EQPN07MWOzMdznN8dU4VQKe6p2HCfHhPq92bLzFWk85JcYPkOWQdPoDgYWL2e
         tlW5T+L+KsW12HFaEOoBsC07AEtw42O4OguDd+Ove8vLUlnZhwO3y8gcXhG9D985HKXj
         CLpTNytTVeIHeqD5MgUyo+i8Ob5RijCVg0Alk2y2KClzxGBTwKdHBNf2ZuR/LOdqPlUr
         E+og==
X-Gm-Message-State: ACrzQf0hdRta3q64BQkyPvAeD1DLiHocLZG7lF6aoQggYwCxdQYqN6nE
        mE7v94wPaMFrHxBgiGRMhODMoIb4KHPiGQ==
X-Google-Smtp-Source: AMsMyM5L4s5TOjAQi4gML5ttMXRLWHd/SXgs1yAKlIctV5MljvKEj5TuSOQQ4S6w43XtOd23qgKvsQ==
X-Received: by 2002:a17:90a:ac11:b0:20b:10d2:e837 with SMTP id o17-20020a17090aac1100b0020b10d2e837mr24258149pjq.165.1665451551929;
        Mon, 10 Oct 2022 18:25:51 -0700 (PDT)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902ce9100b00172f4835f60sm102821plg.189.2022.10.10.18.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 18:25:51 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH bpf-next v1 14/25] bpf: Allow locking bpf_spin_lock global variables
Date:   Tue, 11 Oct 2022 06:52:29 +0530
Message-Id: <20221011012240.3149-15-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011012240.3149-1-memxor@gmail.com>
References: <20221011012240.3149-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5597; i=memxor@gmail.com; h=from:subject; bh=jl8HZI3LOMxhyBxpQmBBrRK1LoDDhx4/Jv+N418DcOU=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjRMUbqSORDODU0+EUKFOamzXLIJe4padwJNUgySSE h2mHEYqJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0TFGwAKCRBM4MiGSL8RyuvUEA C4qtPPqnARAMsD4hMASj8bd38m6IS6PouW9MsOdQVrh6/ZQ3AXK27js6dBt3DbRr+YM5TO8yXf/DLa gwsRhBO4RN3cpTBbryUhyVpYswl5ZxJTtDa7rZj76e6t358cchJaivRoj0wWEZTdVKv3RBjk7Kp7Aa ysU7yowhgqdHAQTAoyiJ3yAV6ZQG+xkuyni9YcxiW8gPzVZXTYxb5KqbYR3ZI3/r9qDlTlM3L1vgBP IZ4ETd7+/A1HHPNzsW+BvnmFMUkp5LG0xVHwYXSPhWSRblyKCJRIe7WAPNcmH5KmTgvWWXYxeR5Llm BI/ZjU6iv+sKQJf54kKhvrkqpjeq45pSKLeSpud+ZJqkccvjvGkibfj7rTd/IJyXo8TleqreNdiKJJ YG3hBoTGtz8WQH2X+HDhxOn29eo+RYsI3docXIouF7tt3O6aiOErKlAeImlq+iSahoAFN2um9nGw3t 6ZkAD9RSMQ/tUyFZyx8FblAp5w3fmcZiRBkW4wZiHmCrnPuwe7CZsgCdFnAFxTi+D4MNb3JvdFASku asFm5wK2AlVy+6lFO29BgXYYBlNDTcTTYlRECFF4zL9vd8iqXxs/VHc3w30CoEN9EHth6hvkTethDQ 3bTP8jxIfHSmAX4RkGN+I2kCO329uaDpKWD5hpTzU06Fhs28CABmNhK96CbA==
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
index 156c1a1254d5..bf3176325d8b 100644
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
2.34.1

