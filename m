Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAAD616EB1
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 21:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiKBU2M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 16:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiKBU1z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 16:27:55 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB94626A
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 13:27:54 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id b62so6844245pgc.0
        for <bpf@vger.kernel.org>; Wed, 02 Nov 2022 13:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msYUqo9YV9jUemiFMURwrqJvEmFzzEkk4M4kZlV5dOQ=;
        b=J6NsvQV8eTgJ9OnJ14SPBaKPmZSeOsoHw56l2lZm1/koK+TCxZ6dtXG9Kh+BiuQiiO
         Muq5JDRfGEYde0SMrr5Hvx5BZ0hQhEYnLsV4k0lNWQ4SEfw2Rzlx6oGVz1gaZTaxCz9v
         3/EBd/Zn7eUADLboKRd68JcLAqWGx7/YxlV+nrkYlBReu7AXz708Prx9mf/WBf+Z4pxG
         qscIXwp7Z/vJp1EIHNHNr+tFOvnrHzZusDWmZZsHwePXgHw2m1/7qNT1wOkHVCY059CQ
         nOo0yweBWpYAA6FvqkPj2rRiUBipx4Rtcf8LLI4/XSk+XHHu+zKWkDTOc4S2/N70dtQV
         YE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msYUqo9YV9jUemiFMURwrqJvEmFzzEkk4M4kZlV5dOQ=;
        b=3ZPl4QRjtGjQUaX5KGVT6Qqj6GcS7zd3pTFeiDFgK22atlslLTL4jiC+0Pw5vj5G3k
         WB2jslVtPetHQZoCHSdwi+sLIFyo1mCfgw1d+zouL26Y+s0OI80AQYLG5sB7fsZVe4wz
         AfChOM1PuEBWbtVwoRPIwEkacPy+Ov0amij401aEBYFVqyMOvw/gRLq5Pw+WE1AmbdOG
         sAH4TToM7JamIgryhC8ZyOTA7NH1ftkOvygX/pyzBtBuDJ1D2FAo+ElgdRgGCRiTbarg
         Gu/1AEUjg3nekZw32a5KNIkI0bvzwTm9CV2TgKhJ7KuIZTpfNpHXvev6TxztAXWCcHXI
         Iz1g==
X-Gm-Message-State: ACrzQf1HxISg6vO4cTX1+WVe8sfiLSyak5J8vuGKuiNbbyDBNrUtz1fv
        c4QjTWiN3RZ51EJqpfm0aLkyZR99Y1fkcQ==
X-Google-Smtp-Source: AMsMyM5MDkijT6Q31lEZa4YE6WBSlcvzN7POqZu1+MNybcIauDMqOD8dJ3n9i1P9Qk8KkWVxFAszbQ==
X-Received: by 2002:a05:6a00:bd2:b0:56d:8bb9:5a0b with SMTP id x18-20020a056a000bd200b0056d8bb95a0bmr15795793pfu.20.1667420874064;
        Wed, 02 Nov 2022 13:27:54 -0700 (PDT)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001753654d9c5sm8713970pld.95.2022.11.02.13.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:27:53 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v3 14/24] bpf: Allow locking bpf_spin_lock global variables
Date:   Thu,  3 Nov 2022 01:56:48 +0530
Message-Id: <20221102202658.963008-15-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102202658.963008-1-memxor@gmail.com>
References: <20221102202658.963008-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5588; i=memxor@gmail.com; h=from:subject; bh=ftf7JExPKtCTN0EOCZmRZrIXyOQfZpHEoQwfhVGI4VU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjYtID+xjaPAbKs6LEPPGRTRqjk0af5/yZB3+qfaqf 0sEDAtSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2LSAwAKCRBM4MiGSL8RypIYD/ 9UsyGQylWVGvdUQRLJOvzB1JGFFxs0HbFZYCqd3MNXSTwjbG2j/joXiUM9Fd2qRBNJA2PUA9T5G8aJ Wdgouvd9zSvYlU2PKNJUaS/CvDKOVat4ClB9E9swBrzroN+JkFg07HDOgrEPSB85Sl9/s8F6+W1XHt SkThT3tq6Ggp4v/t+rYMnJm7Tj+f7oHDhd0CYz5kJleU5W5xlbzLBnjg3gH4/eiZv2dzlH7PuHFXCS +JY9h9r5r9IdkTrS9so9icclJakQjz1AxmK9TuiHD4ymJ5FJGNgtgszudSfUGOZVkhUFVWoyz5LGj5 LYp5lNhcz6as9L4Ij3ebIoRop2ENPTbsYK1e7jxlGwK2v3RZMHWcB1vZmz4avUCStbsgx2lmqHcXHm IIxR3MWAeIKB/Z8memZYo+x4JZHlQ5r4v3YbTIW8etHPLoAtKWu65p/fYQo7BLagfetClVMqPnBnNR nSNDKBqvlXUaqQGE8h7aMbtVWrp/27fn/osTNbkB0PKGB8bBrgdZaaRXsdee4rTiqeGX8vUZ1h3fb9 cuCHA2bqbwNI2xoT1Svc+eKhwGlspBY5HKVyWncPKsBDldyRoSYLaPlsO/kyoXnKDIpHKz0iK+SNz+ gcmyxctmdv/kgBRt8lGfcCFnLoEghZjSw9PYNs7mRNgo/aSEFeq9wrGIg8yQ==
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
index bbb5449630a1..b91b5a790d3e 100644
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
@@ -10392,8 +10406,8 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
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
@@ -10471,7 +10485,7 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		return err;
 	}
 
-	if (env->cur_state->active_spin_lock) {
+	if (env->cur_state->active_spin_lock_ptr) {
 		verbose(env, "BPF_LD_[ABS|IND] cannot be used inside bpf_spin_lock-ed region\n");
 		return -EINVAL;
 	}
@@ -11737,7 +11751,8 @@ static bool states_equal(struct bpf_verifier_env *env,
 	if (old->speculative && !cur->speculative)
 		return false;
 
-	if (old->active_spin_lock != cur->active_spin_lock)
+	if (old->active_spin_lock_ptr != cur->active_spin_lock_ptr ||
+	    old->active_spin_lock_id != cur->active_spin_lock_id)
 		return false;
 
 	/* for states to be equal callsites have to be the same
@@ -12376,7 +12391,7 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
-				if (env->cur_state->active_spin_lock &&
+				if (env->cur_state->active_spin_lock_ptr &&
 				    (insn->src_reg == BPF_PSEUDO_CALL ||
 				     insn->imm != BPF_FUNC_spin_unlock)) {
 					verbose(env, "function calls are not allowed while holding a lock\n");
@@ -12413,7 +12428,7 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
-				if (env->cur_state->active_spin_lock) {
+				if (env->cur_state->active_spin_lock_ptr) {
 					verbose(env, "bpf_spin_unlock is missing\n");
 					return -EINVAL;
 				}
-- 
2.38.1

