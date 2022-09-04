Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219115AC677
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 22:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbiIDUmW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 16:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbiIDUmQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 16:42:16 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1882CDEF
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 13:42:12 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id lx1so13401418ejb.12
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 13:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8A6Rz6RwTxplQ30FpZrSzUy0UamtJdoZTNUGrlTHv2s=;
        b=Tc9RXfBYgXrD1Q8+hrguauIp/Vlg3qVfDxJdE/9CTCXuYMPLzTW00Ux7ToumfWFKFz
         za0N091DPXbksLVj9fso+n0fUzzK997V6yKiXhA08XcBQ2ybtbyRkF5Vpjr9eOzwR6+R
         /377Kpqs4HCPM3IpL3x31xuii3TMMm6JmVs/PBL7NFMxLcGtG8A1y6mip71LjCMGfi4W
         bUBjzvBmJZaBR/djdRk5HvE14VDqrfACQURepD3YH2+a+fTFp6mCk+xvsVGzIbt2GiO+
         yhBCfpu61tZGbK1fDAuIDo1+lNo7oAWMzE3nf8faGL6+FonLcESWRCzq6jx9RqkAnuL4
         KdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8A6Rz6RwTxplQ30FpZrSzUy0UamtJdoZTNUGrlTHv2s=;
        b=njDxqo59RZtHB2ag7lhlRt3ofNIAfSU6VB47HSC8oKIUYF3dj4J9RMow7h1B6zRA6e
         MPq3IAyWcqy3cymvwsLW36Fj3vy2rYX3oPi0gQAWtE87jQbzVzFb3YwA8IHlFMxBbuh9
         1T7TvSTlPiVM6USXPNvTayTDFPFQicarpBdspeBg6r8cE96wMOjHMMvI+PZVI3oisQZw
         oKKYqBgCPbKi/lIjSUPlKERi8ljewbmb3mCUxcEfDwtW8lMwPgodzgwITdYDVyXQwSap
         wRY7IfzBvW8pYXb5pPfjCVV+z/bGdlN960BUHyGMfd1NhfshBlslmvEKb+IVrXRD00b0
         pqWg==
X-Gm-Message-State: ACgBeo3HM/Q5M4hqqiANRDZjpVeKrs9LeHK1fL4iNiOm8K3pYOu9Pmzg
        oJJbVo15w8CN+Zv4DRCDDswgYopozkZ/jw==
X-Google-Smtp-Source: AA6agR6RJSatr4pKmaBdy8R6Ravjgb9zXBqfOkUW/NZYThL9UMX7mv+0M5Z3mEhv9wfh5/G7QdJ/wg==
X-Received: by 2002:a17:907:2173:b0:73d:c95d:1179 with SMTP id rl19-20020a170907217300b0073dc95d1179mr33255203ejb.89.1662324131386;
        Sun, 04 Sep 2022 13:42:11 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id v14-20020a056402348e00b004464c3de6dasm5257471edc.65.2022.09.04.13.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:42:11 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH RFC bpf-next v1 21/32] bpf: Allow locking bpf_spin_lock global variables
Date:   Sun,  4 Sep 2022 22:41:34 +0200
Message-Id: <20220904204145.3089-22-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220904204145.3089-1-memxor@gmail.com>
References: <20220904204145.3089-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5568; i=memxor@gmail.com; h=from:subject; bh=8ASdlTj49Q/yMOwuOC+YzSFahyZQ4IxJui6Beo9JwY8=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjFQ1xxKn8tpYhjGOZg2Oqk5HcU+A/C4FTkEja4aBx 3XNJlA+JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYxUNcQAKCRBM4MiGSL8RysVYEA Ckd0rIEUPkXxuVmhw6fUVumLDfhNMRszR1i5nuqn/7UVykQ57mxIx4O75D9gvUsKZcqe7f4NSgjn7K 1ytOlle72lPVzOxu3GJvUn6mYEjbESJkfe6LbOdvp3g2FZyD6cZP1APxA15iALfIKnVDuw8vGbgtgU yVlhrg5gHw4ONXTIY/jB6QJ0Yy9DbXPQ0w+ce/39gOC7qYv2hW8VwHeZlOcAtfc9OCHli3FlnBvwNU bvgogq53HONl/AAtUzfnq9okMS2s1DUQ1aG9X1siOqJzdwTfcCfKTPvwp/JTGufNfdlR3U1mcFkc73 tQTNwAKTwetVZU/TpaaAbU+FZyqD7aCznaHjBlfZHmQvwR5hoT8TBP7mBi/puX0lhCAajo7AoL6kZx AtG3OWmiuFE9X5pwtgMNSpECBsH77Is4QtBABn0Xj2BHZMBqfK4xyBTrlyWjmoN5vxCZUtf+9rh4lm 5b2g2VAR7Ee+74ZS2Ctc6U6eVJJbefjxxwQXrSAr+ZEJVAx+vuhoFgSvlttQ8mrmsezWayvhtXNyXJ MOK4RbYujz9Q0EcjFSpM3eWwxbFUyf7+3BsNdHYcUsWxHYl1MAQogFbskXSTU7Nk2DLlE8IGGFJ1vG BOH/qyCV5Rv9d8qqY94GcoK2dGzmQTO4LITeFfQi93Ri3wuZP0yUj7IAPB1A==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 2a9dcefca3b6..00c21ad6f61c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -348,7 +348,8 @@ struct bpf_verifier_state {
 	u32 branches;
 	u32 insn_idx;
 	u32 curframe;
-	u32 active_spin_lock;
+	void *active_spin_lock_ptr;
+	u32 active_spin_lock_id;
 	bool speculative;
 
 	/* first and last insn idx of this verifier state */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b1754fd69f7d..ed19e4036b0a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1202,7 +1202,8 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	}
 	dst_state->speculative = src->speculative;
 	dst_state->curframe = src->curframe;
-	dst_state->active_spin_lock = src->active_spin_lock;
+	dst_state->active_spin_lock_ptr = src->active_spin_lock_ptr;
+	dst_state->active_spin_lock_id = src->active_spin_lock_id;
 	dst_state->branches = src->branches;
 	dst_state->parent = src->parent;
 	dst_state->first_insn_idx = src->first_insn_idx;
@@ -5504,22 +5505,35 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
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
@@ -11207,8 +11221,8 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	    insn->src_reg == BPF_PSEUDO_MAP_IDX_VALUE) {
 		dst_reg->type = PTR_TO_MAP_VALUE;
 		dst_reg->off = aux->map_off;
-		if (map_value_has_spin_lock(map))
-			dst_reg->id = ++env->id_gen;
+		WARN_ON_ONCE(map->max_entries != 1);
+		/* We want reg->id to be same (0) as map_value is not distinct */
 	} else if (insn->src_reg == BPF_PSEUDO_MAP_FD ||
 		   insn->src_reg == BPF_PSEUDO_MAP_IDX) {
 		dst_reg->type = CONST_PTR_TO_MAP;
@@ -11286,7 +11300,7 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		return err;
 	}
 
-	if (env->cur_state->active_spin_lock) {
+	if (env->cur_state->active_spin_lock_ptr) {
 		verbose(env, "BPF_LD_[ABS|IND] cannot be used inside bpf_spin_lock-ed region\n");
 		return -EINVAL;
 	}
@@ -12566,7 +12580,8 @@ static bool states_equal(struct bpf_verifier_env *env,
 	if (old->speculative && !cur->speculative)
 		return false;
 
-	if (old->active_spin_lock != cur->active_spin_lock)
+	if (old->active_spin_lock_ptr != cur->active_spin_lock_ptr ||
+	    old->active_spin_lock_id != cur->active_spin_lock_id)
 		return false;
 
 	/* for states to be equal callsites have to be the same
@@ -13213,7 +13228,7 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
-				if (env->cur_state->active_spin_lock &&
+				if (env->cur_state->active_spin_lock_ptr &&
 				    (insn->src_reg == BPF_PSEUDO_CALL ||
 				     insn->imm != BPF_FUNC_spin_unlock)) {
 					verbose(env, "function calls are not allowed while holding a lock\n");
@@ -13250,7 +13265,7 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
-				if (env->cur_state->active_spin_lock) {
+				if (env->cur_state->active_spin_lock_ptr) {
 					verbose(env, "bpf_spin_unlock is missing\n");
 					return -EINVAL;
 				}
-- 
2.34.1

