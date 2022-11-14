Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C6662891F
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 20:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbiKNTRN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 14:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237153AbiKNTRB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 14:17:01 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0885927B3F
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:16:56 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso11630996pjc.5
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7tY5u6yMRQNosh2VIGkVKHtaOl/+ZUuNBZUXf6u/ww=;
        b=AC8qPZXjjllbsHT1b+PgGcYQKTXmodAtdXbhOK+vnwORoqfihD05sUV5X7ydklf3qz
         6yYOfsFWhYkH9OP78IKJFodmskQLeYFwxmHD09Zm9uIjpLtpnTDvfuR+i5LSn/MeRfmu
         /wOQeDdiuflZxN9SvFy6SGYn3hinSrdeziOjw0euYEKvYy8V8cqQfZxrpgPMgucBUpYV
         uw6CtMZ1hDdphGrYCjt1SCcn9VSJ833cZ4FT46YYXbqQg5pdrCdbNRBlkCqLcAHYMFmH
         jT3V0/D6YQO3HdUCwkj+3hv5u1g3f2aQMDHiOsezHKGZPBPaTzrGfW0Er1GZUbulKwEI
         sFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7tY5u6yMRQNosh2VIGkVKHtaOl/+ZUuNBZUXf6u/ww=;
        b=3wA/SDzktCDWf0MKtMNEYp2Wx8E5wuoFj1gGPFzL/S5haQEADTnM+f4fSx0iijkYBr
         JQ+LCR8IC/ZAJuYYZi5fIrV1UZkrPFA4LhLDsnrWfnJzwiyEd0vXZFohWh5eHgQKifj7
         9rlQM3Gdc+YaaxhJ6cLPaD/2krXfDsIB9HtpNjT9UPNsyMearXtoK5271FHc7Pf6BqJs
         d1MmuGpkgMoS+LDV4lY2odo5MWx/he8iCzqx3+TNbf9l3PGtIF76KpvE/eoZCPGalECE
         o9twjLDxvM+zgpoaOeSOsu2FLw70yJafgl1IQOrcO4tZsPC6+G+iDvb4S23qINn2imDN
         Zydg==
X-Gm-Message-State: ANoB5pnmvQoMaxp6FNIgp18PBtju9We2mGf1JpjmR5uuiqiZYrOQhfhF
        vXlEUbbOS2/IanwOS70gYtmIOfg+wcHZyQ==
X-Google-Smtp-Source: AA0mqf4Ud+dtR8uDqSCWe7lNt4Evkp9ody7ZQCzl9f4YH/d2n8OqSt1Kv5V4Dz0EI5lm/KsQ2C1/Lw==
X-Received: by 2002:a17:90a:ea98:b0:212:ec36:4d04 with SMTP id h24-20020a17090aea9800b00212ec364d04mr15196658pjz.158.1668453415176;
        Mon, 14 Nov 2022 11:16:55 -0800 (PST)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id y17-20020a17090322d100b0017bb38e4588sm7923159plg.135.2022.11.14.11.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 11:16:54 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v7 21/26] bpf: Add 'release on unlock' logic for bpf_list_push_{front,back}
Date:   Tue, 15 Nov 2022 00:45:42 +0530
Message-Id: <20221114191547.1694267-22-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114191547.1694267-1-memxor@gmail.com>
References: <20221114191547.1694267-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5174; i=memxor@gmail.com; h=from:subject; bh=CRPhTjFlo/zGiQz/ST2tY8babKNLG0Y1BEeMid8sYPs=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjcpPJaY1RS8gBjKbZ9dEeB6QXy2sCIZP9eT449jiM MxES8VaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3KTyQAKCRBM4MiGSL8RyvheEA CkLsEihclOj8QG4z0EUkEkBbQMUIoCoYVMPSCz87SzVKjJihuiwweFmKM0RJxAab5MZL77iHOF8uAv 9utPqhHpZeoG3xYrt9+cd0r707Ce+qY6oL7UAVBSvybQmO32LKOYGcfRWiTLzWxe94bsxg+Uk7resk j9IBwOz5Uel60Gp/eUdXreXpPf+JH08SI1KSr2LZJGyDw+1Q3wgK4Jpn2mbYArXUSL8B7FNp+tZcGX 6aZOfMfFS6WqLIx8DeAZk1a32BmNcf+pbhR2eLPKe3lLI6TxpKL+BLYOPJ+OgV/qzUTHs0bW1J2Kwu ruJ2Ud5E7gcnVm00O6K5w8HCcfZH2TAPUY7pHZTFDikTw6O3F09F4vfdd+1yMyhfcTsmQdZm6Dju0N 0sFnKjgWvfIuQ3OorrPiLVb600PCkZgZ9LhzjlFGLAlVUAMrmlhya7fERiPzD8xKHh79lY/Qw75I4y M+z2JY4y833OhX605VdOF8y+ABBr2VQNfPMSYLU/JfnPNJKkxkgd8QXG5cWrPPFNrWJyAPWP2ovpXC wBxk2LT6OdGUJtPda1DLReYv5ZRldKRvrEOhkTnD5AD5omYRvjl7FKl1SoTSjASm5WRZ6qug/VaVyk W9tRFGvQAQ7iIBEZxw+TT4lRbzpfcdEaAylNGp6Fh+I9ttbF+JdQ1KSXXAWw==
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

This commit implements the delayed release logic for bpf_list_push_front
and bpf_list_push_back.

Once a node has been added to the list, it's pointer changes to
PTR_UNTRUSTED. However, it is only released once the lock protecting the
list is unlocked. For such PTR_TO_BTF_ID | MEM_ALLOC with PTR_UNTRUSTED
set but an active ref_obj_id, it is still permitted to read them as long
as the lock is held. Writing to them is not allowed.

This allows having read access to push items we no longer own until we
release the lock guarding the list, allowing a little more flexibility
when working with these APIs.

Note that enabling write support has fairly tricky interactions with
what happens inside the critical section. Just as an example, currently,
bpf_obj_drop is not permitted, but if it were, being able to write to
the PTR_UNTRUSTED pointer while the object gets released back to the
memory allocator would violate safety properties we wish to guarantee
(i.e. not crashing the kernel). The memory could be reused for a
different type in the BPF program or even in the kernel as it gets
eventually kfree'd.

Not enabling bpf_obj_drop inside the critical section would appear to
prevent all of the above, but that is more of an artifical limitation
right now. Since the write support is tangled with how we handle
potential aliasing of nodes inside the critical section that may or may
not be part of the list anymore, it has been deferred to a future patch.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  5 ++++
 kernel/bpf/verifier.c        | 48 +++++++++++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 306fc1d6cc4a..740e774e1c7a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -223,6 +223,11 @@ struct bpf_reference_state {
 	 * exiting a callback function.
 	 */
 	int callback_ref;
+	/* Mark the reference state to release the registers sharing the same id
+	 * on bpf_spin_unlock (for nodes that we will lose ownership to but are
+	 * safe to access inside the critical section).
+	 */
+	bool release_on_unlock;
 };
 
 /* state of the program:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c034ca2d9479..8725c2ee7eb4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5648,7 +5648,9 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 			cur->active_lock.ptr = btf;
 		cur->active_lock.id = reg->id;
 	} else {
+		struct bpf_func_state *fstate = cur_func(env);
 		void *ptr;
+		int i;
 
 		if (map)
 			ptr = map;
@@ -5666,6 +5668,16 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 		}
 		cur->active_lock.ptr = NULL;
 		cur->active_lock.id = 0;
+
+		for (i = 0; i < fstate->acquired_refs; i++) {
+			/* WARN because this reference state cannot be freed
+			 * before this point, as bpf_spin_lock critical section
+			 * does not allow functions that release the allocated
+			 * object immediately.
+			 */
+			if (fstate->refs[i].release_on_unlock)
+				WARN_ON_ONCE(release_reference(env, fstate->refs[i].id));
+		}
 	}
 	return 0;
 }
@@ -8262,6 +8274,39 @@ static int process_kf_arg_ptr_to_kptr_strong(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static int ref_set_release_on_unlock(struct bpf_verifier_env *env, u32 ref_obj_id)
+{
+	struct bpf_func_state *state = cur_func(env);
+	struct bpf_reg_state *reg;
+	int i;
+
+	/* bpf_spin_lock only allows calling list_push and list_pop, no BPF
+	 * subprogs, no global functions. This means that the references would
+	 * not be released inside the critical section but they may be added to
+	 * the reference state, and the acquired_refs are never copied out for a
+	 * different frame as BPF to BPF calls don't work in bpf_spin_lock
+	 * critical sections.
+	 */
+	if (!ref_obj_id) {
+		verbose(env, "verifier internal error: ref_obj_id is zero for release_on_unlock\n");
+		return -EFAULT;
+	}
+	for (i = 0; i < state->acquired_refs; i++) {
+		if (state->refs[i].id == ref_obj_id) {
+			WARN_ON_ONCE(state->refs[i].release_on_unlock);
+			state->refs[i].release_on_unlock = true;
+			/* Now mark everyone sharing same ref_obj_id as untrusted */
+			bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
+				if (reg->ref_obj_id == ref_obj_id)
+					reg->type |= PTR_UNTRUSTED;
+			}));
+			return 0;
+		}
+	}
+	verbose(env, "verifier internal error: ref state missing for ref_obj_id\n");
+	return -EFAULT;
+}
+
 /* Implementation details:
  *
  * Each register points to some region of memory, which we define as an
@@ -8447,7 +8492,8 @@ static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
 			field->list_head.node_offset);
 		return -EINVAL;
 	}
-	return 0;
+	/* Set arg#1 for expiration after unlock */
+	return ref_set_release_on_unlock(env, reg->ref_obj_id);
 }
 
 static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta)
-- 
2.38.1

