Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1220B62036F
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 00:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbiKGXLT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 18:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbiKGXLO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 18:11:14 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3644224BDD
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 15:11:12 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id v28so12183519pfi.12
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 15:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WErGwUy0Dg6GQhKNp6eaQMti1iGRFV8I7VW8cRQQLXU=;
        b=UmjRD0FWSD5uzytfRHaearCqGlfthg6eDpbwPQQno9OMnfYEzsbawD7fOCgaG2c8Gr
         3/qYyJH7vwyKCwWXLQq9Jap1Bt3Gx0jT8jV7LxHacisqCfGLH89YH2BIcugvcJn2tulj
         d71/wlwYv6XZun4Rfy8cnNNTOmgvj0lUzOM2HDYb8jSIFCeMzfP8e+4/W7TmI32aMqMt
         kAiQTju1OvDATgYs8jwcHbm4Kps0uBTjKptN+K4Em+q/Okb7Or9Gk/kkV3Q8C5iJ2Tz+
         jLtu8j2yJyS+5p+eXWRS5+2V/Gz32wAKUgJoTx3lCJ7kmx0lt7f0Qcp2GaMzeRz4R8K0
         rstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WErGwUy0Dg6GQhKNp6eaQMti1iGRFV8I7VW8cRQQLXU=;
        b=Zuzx9T6UNVY+9c1pTpsbChCCVfsJ6HiRRYsE0xsbFiu+SV47u1fI1tRcsUMK0rA9Rr
         gxkdGUWl+lBL/r2K+apkZdkLDannskvj/n6y2yQCRCbU+C+PXTboaDmmq9Wyc1hIM9jy
         /ql1juDEnee+ppWXvhlGWl/OrtSHs5fGDE1ZnTYv/xRqbDr0r7LhNDjCRPrT6KztU4rH
         Lneud/RFkKXTZMv6sxkmMGon2v2IgsV35bGNdbV+1IlqmGiGbO0nkLTTvG3KqW4UXN38
         xMnA61VJ/hC+xhLSeK4qSe768xox2OicPWU/c/QOt8J5EezLfsFeWZyu2ItNwBNk8b+l
         Gefg==
X-Gm-Message-State: ACrzQf26b11uMU0vjEAcr+GRbIad8FLv+q1kzzp+jeX1mfjamLymhHu1
        Lr81GYVq1Ywq8GwPlD5k4NKeT6hQcUclOQ==
X-Google-Smtp-Source: AMsMyM7K2skyDF+xdYBQaD6t/dpPQAypkN4MSOeLobuxKY1q1iQNDsflyZ+rA/Eob8fmQbbYLVQGWQ==
X-Received: by 2002:a63:4182:0:b0:46f:1263:1f6 with SMTP id o124-20020a634182000000b0046f126301f6mr45269279pga.611.1667862671459;
        Mon, 07 Nov 2022 15:11:11 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id d1-20020a63f241000000b0043ae1797e2bsm4586931pgk.63.2022.11.07.15.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:11:11 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v5 20/25] bpf: Add 'release on unlock' logic for bpf_list_push_{front,back}
Date:   Tue,  8 Nov 2022 04:39:45 +0530
Message-Id: <20221107230950.7117-21-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107230950.7117-1-memxor@gmail.com>
References: <20221107230950.7117-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5140; i=memxor@gmail.com; h=from:subject; bh=788X7f/Hodk3UU/0udiU3xZj5ZUkK6rnpr5rcLgSNkQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjaY+3pPqRc6i+i8PmjSYiDV/gwTdI1rWSvcVKUxtq a1eXHLKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2mPtwAKCRBM4MiGSL8RyjF1D/ 47NO5OeZXfqxSKyoPAJoV9/Ehjr7KxP8u7cSwg7sc7WeRf49b8c3NlIw0dvZ/SGilG/nUe3UECKquG XBcL/q/gLIIzuOqA6Z/GuLR7zER+k6Odyb4SilBrDrL75VpxGaHf0nKsaK9zXItukoKpIvf2BP/SJS l61CFM+y9mlZ4IEkv1E8579sSTXL3kDEKTiJ5xYKLmJXX/Ab/m0zF0AHPdOqDi/haBDnLB8cv0wOX3 G0lr3UNPf0vqXL/MQPgNTtKZ/TurMZzHQxQEGof2CBnDFHGjre6o7ruY49Ze08Je9BiM1a1yDeXu96 L9KVLwl2T5TLWCJH7iZFr1ClEC5ZpG6z3EiskOJznFScrv6SELSqnY+sTA3LcY/m/3+ztY+nJ5zAwl GhRc1gW2sxyXjibSWFUE1EyFPRPJykpJ7Sthmx0voa4uziyBXEW0kC+n4vBuMZX/ISozpHE+CURk8W NHaXtq38271OOKIpakunZpl4eRIBMtQJCnnW0WIDzA4rDLgQkjJsPPynyWjM4TDzO41GMu6Z/MEHtl kTWEKnaQj+4ujN+m5ujKCnbPL0OmBBQxLQXJuDlWdf9xB/0elBEub6yOXhkb8DUxKprOO3EMxzyClb A0kmapYZws93drQGasu/9Fl6hRnjcXAjE0F4PCrVFQXx9N7+JqvT66zKw7TQ==
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
list is unlocked. For such local kptrs with PTR_UNTRUSTED set but an
active ref_obj_id, it is still permitted to read them as long as the
lock is held. Writing to them is not allowed.

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
index a009df64ffab..c3b202559b87 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -229,6 +229,11 @@ struct bpf_reference_state {
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
index 5b87ef859046..1900af72df94 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5659,7 +5659,9 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 			cur->active_lock.ptr = btf;
 		cur->active_lock.id = reg->id;
 	} else {
+		struct bpf_func_state *fstate = cur_func(env);
 		void *ptr;
+		int i;
 
 		if (map)
 			ptr = map;
@@ -5677,6 +5679,16 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 		}
 		cur->active_lock.ptr = NULL;
 		cur->active_lock.id = 0;
+
+		for (i = 0; i < fstate->acquired_refs; i++) {
+			/* WARN because this reference state cannot be freed
+			 * before this point, as bpf_spin_lock CS does not
+			 * allow functions that release the local kptr
+			 * immediately.
+			 */
+			if (fstate->refs[i].release_on_unlock)
+				WARN_ON_ONCE(release_reference(env, fstate->refs[i].id));
+		}
 	}
 	return 0;
 }
@@ -8269,6 +8281,39 @@ static int process_kf_arg_ptr_to_kptr_strong(struct bpf_verifier_env *env,
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
@@ -8454,7 +8499,8 @@ static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
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

