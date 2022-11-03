Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF1F61884E
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 20:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiKCTLV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 15:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiKCTLU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 15:11:20 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54AA12AB2
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 12:11:19 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gw22so2574282pjb.3
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 12:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oossh50hX6KThx7EV0GEvA4hKiPC1hqKezYVQYo5IiA=;
        b=BJd0+xjxa7MYKtOANVgTpBp2b12Cq/EcWhxe7bVUy+7Vp02r1a4AqE2o/yq+t6kXk3
         7uFt1/KrOZ2DHuBMA9FEp+BH0vRCzollcTsbOV00g+i171/f2sH6RTmYQ7dHnk93VBPu
         SzD33aeV/m57orThZBpHdZzfrprMfPf9+fZgHgmG8iXzflB5HyVP3+H+VohMwSCtpP0O
         QotljHqXmGKRw6MPcfN86rNrMfVUYSpjEu64xk+KH+aUe2BLPoPw/T/i3el0Eo+QOKyd
         EY4OGF/aLnSbDthhmqEaAygfBXZW8vRLwkPS7iLYm9gi2uzAg0uPLBQmLouKX7XjDS+X
         jklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oossh50hX6KThx7EV0GEvA4hKiPC1hqKezYVQYo5IiA=;
        b=W4oGX89uGZ9iTa7jRNOW5ZC+t9nKd5LfBPfwd2FlTGGl5yigrgjpo2W7ueyZJP+TDJ
         2i+VFKTvEqdx/+aX7KdEYBAYERHpxahoqiF6+vWPbkf9iURf6agdrc8xf+/KwG9ESJ7i
         W/D6EmahF9AlPv8qS6QPOtXWEbj8ZsrN1lzXPMpv9h1TxB91tzJpPkt234KqVEEKu5tz
         onVCkvDhBcLtW+hSu6VmNZAUzJzW66eQS2nGoal3IB88yqNertn+Ip1ht6unlMVU6Yca
         hPXgzpg6iM0DoH+GK8XuGogNpXQ9g5tH+tkwu3GyPI6uMfMsbUrrsNcs9kyuBCDgkMPb
         dL3w==
X-Gm-Message-State: ACrzQf09PeRzYqdTdQ0zw4QFWRDTZYau3N11juG3WK/JjK33DyYXRYTb
        lStXYqmP3EISkqvKsumUsnIZ5tmR7C+zjg==
X-Google-Smtp-Source: AMsMyM4XndFF1yrFF+W0yC1wU5z5a19c7up1TUgkLvU/05Bgl21xe3U2BYq5Uwq0ptz7wqZtDQ6MPg==
X-Received: by 2002:a17:903:234c:b0:187:28b2:85f6 with SMTP id c12-20020a170903234c00b0018728b285f6mr20682523plh.106.1667502678929;
        Thu, 03 Nov 2022 12:11:18 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id d13-20020a656b8d000000b0046f56534d9fsm1108804pgw.21.2022.11.03.12.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:11:18 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v4 14/24] bpf: Allow locking bpf_spin_lock global variables
Date:   Fri,  4 Nov 2022 00:40:03 +0530
Message-Id: <20221103191013.1236066-15-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103191013.1236066-1-memxor@gmail.com>
References: <20221103191013.1236066-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5588; i=memxor@gmail.com; h=from:subject; bh=/qGcBqBYf8Q9UqNsywj9mSmvVBUwUWPlBmrS+1O61Xg=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjZBIBojg+6E7I43gDTX/adbCoLPIyAsaQfCe9mCOA TNsTywSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2QSAQAKCRBM4MiGSL8RypswD/ 4sYahGLssBoGa1QiKL1aL+r7rgSihnk3jtXUeVIlv5vIdpNXvfS6uISsvMpNx+FXUUHNHxKAt8Fp5n 7DvZeXp5nOBWsqIWPf2U0dbBaeXC357Nbm0eD2ngQVHj7Y5b9eY+9d9ZKFJ6JkdATtZuZCEjP9klzT DUArKefwaArVX0ppYQtRv61L8fSppcVScDCNwkAuvvL7S7tnZJruYGchIoAHH19QzHQtPodMngIzNs MiUvYPh6U9UdorD8vVI3m+iZQ/R/O+mK5OTWahwhOSZs3yHNpIExigP1M814nCfHojXU3B/nFwrj2M aWIsSrnD4w2xpNc9A4JLK3pp7Mg5K3ANq68toqEXbOJAuStYc7soTDdLksVpAVoj6nUXS7Z/ghGYqx xPWApN+ZOrEjLKp8gURWUtgURCh0OiFw4mJodUe3yNyRXZ/iZiYdB0SveHhmdkymXwkB5BtZl6tx2J O1CHi6vyQu6VJ9aORDoJigRSoPLv578fNJuNWWWflhidKt6zLHHj1m5hOx0w0BB0mi5A/WzTfh5W+H TxpODPOBlXsAFDzv7EVJwMUx3F0TMeAzvYmTMCP+xdVlNN03DxP6V24aqr073iHNY0IHd5u8P951gg wK889GeILFkVre2TdVud2LFPjgp3T7qHaq1EsJg33PRmAq0gSTEldcP+lHPA==
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
index 1a32baa78ce2..bb71c59f21f6 100644
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
index c31f20aed30c..4a43cde0ff4c 100644
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
@@ -5470,22 +5471,35 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
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
@@ -10393,8 +10407,8 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
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
@@ -10472,7 +10486,7 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		return err;
 	}
 
-	if (env->cur_state->active_spin_lock) {
+	if (env->cur_state->active_spin_lock_ptr) {
 		verbose(env, "BPF_LD_[ABS|IND] cannot be used inside bpf_spin_lock-ed region\n");
 		return -EINVAL;
 	}
@@ -11738,7 +11752,8 @@ static bool states_equal(struct bpf_verifier_env *env,
 	if (old->speculative && !cur->speculative)
 		return false;
 
-	if (old->active_spin_lock != cur->active_spin_lock)
+	if (old->active_spin_lock_ptr != cur->active_spin_lock_ptr ||
+	    old->active_spin_lock_id != cur->active_spin_lock_id)
 		return false;
 
 	/* for states to be equal callsites have to be the same
@@ -12377,7 +12392,7 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
-				if (env->cur_state->active_spin_lock &&
+				if (env->cur_state->active_spin_lock_ptr &&
 				    (insn->src_reg == BPF_PSEUDO_CALL ||
 				     insn->imm != BPF_FUNC_spin_unlock)) {
 					verbose(env, "function calls are not allowed while holding a lock\n");
@@ -12414,7 +12429,7 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
-				if (env->cur_state->active_spin_lock) {
+				if (env->cur_state->active_spin_lock_ptr) {
 					verbose(env, "bpf_spin_unlock is missing\n");
 					return -EINVAL;
 				}
-- 
2.38.1

