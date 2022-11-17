Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D626B62E1B0
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 17:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240213AbiKQQ1b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 11:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240573AbiKQQ0a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 11:26:30 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8D37A37F
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 08:25:50 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id u6-20020a17090a5e4600b0021881a8d264so122465pji.4
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 08:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCe9djUw60eHZstRoq1NUvEoHYm1TTPCbRO78TsBTdw=;
        b=S+YQt7AFtEhF6sQu+mViEWfCkYXvxMPPXlLvqAYP1g5dBBHmoO4bvupTsjE3LjJJl0
         dEj1GZyKvqQsn2JBKer5g8cz1B29hV3W2ArXFJ1B948EfsBxzkO5o4utOTsJyeonyykL
         eYfKnuR8qJQsYEn4lVtZAMSNWrMfTbkA/d3y9FTS5nOuJiK98GjfPM2QE5hh0H4UXZjw
         OwwmHUmXukcri9XbWU8mhaYNiSjSw9wbbrOXMSIj1dBSBIlpQxdpFFiLGfwECXgkRkNa
         s+nqmDtsV98w2oA8xjEQhS5sD9mlbGB1LqrErp/nVi0dzq7B01D/fdVE/aDP/43x0cSJ
         XA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCe9djUw60eHZstRoq1NUvEoHYm1TTPCbRO78TsBTdw=;
        b=qyzaphY5LDIgmAtGYPYaaksjc2ocGHnRckq8TgG5d0OvhXY1h8coR6hBQMnRHZj1wA
         hR0RRQ9g3M9oYnjreQrHk15PD615Sdq90bGjXhXQGGIFGf3UH+8pCVM7NdvtDR6j1O9v
         t8FuuJdMRuyiuvLTmPaRHzBZCfH3tWvUBxC3UPlDcCBqSmoYALrw2ou5AsXeapw+21Uv
         BqoPw8BWcUsKDWR9jF43n9Pec5ivEM/K35jUXNqqdjrBndZBkLvhZr7DsaoSt1/pbrIu
         ATe3Ymef3ZB+K9zvZCkVZyPms5JqCoottemI69Xze0LMtGQH85f3F6XOn9MfYfUDEBwo
         DiNw==
X-Gm-Message-State: ANoB5pnw4o4WyasdU5QWPInxzE++tbLAP8icbNYx7jxPvTBVJqgyVP+B
        Mbe5UQnCQPw8O6m1TrPp2PFInBora9Y=
X-Google-Smtp-Source: AA0mqf5iaxG0HgsYnMMjW8T4rK01uJ4rhwDP4ajr1dPwrh2xhkC1iaKznXeapar+2Ro2433sC9Jylg==
X-Received: by 2002:a17:902:e94c:b0:186:a636:b135 with SMTP id b12-20020a170902e94c00b00186a636b135mr3386981pll.93.1668702349396;
        Thu, 17 Nov 2022 08:25:49 -0800 (PST)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id g11-20020a17090a67cb00b0021282014066sm3758078pjm.9.2022.11.17.08.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 08:25:49 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Dave Marchevsky <davemarchevsky@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v8 17/22] bpf: Add 'release on unlock' logic for bpf_list_push_{front,back}
Date:   Thu, 17 Nov 2022 21:54:25 +0530
Message-Id: <20221117162430.1213770-18-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117162430.1213770-1-memxor@gmail.com>
References: <20221117162430.1213770-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5501; i=memxor@gmail.com; h=from:subject; bh=YeqY7VpClPfaIo+bGh7Dtptyk2S4lBG8jMP3+XG0/gg=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjdl8ABExM59l0RgwVIa2AJIWmY3el4dZsFU8h6/l0 +GtH9gmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3ZfAAAKCRBM4MiGSL8RyvC7EA CEZe6E/S9INQA9K5FEzpGc+oxP/xrJiYBMNJDxkFDjcq+yZQoBibqXA/CjvYMC6lNhm+ahuwGtZZyP 8SyOw8051hxUpGmr5xbYv3V9diWRKKimEzwNEIUhaoKmkS39mcnpfRgTirb0b00U7nA2jZx9+p5k5O 1aaMhs6GC8Pe97/Yqi1D4LNCLDbdqa1JEU6y69M9qTqQl5qx+Vugk0NcRtcD+3awgw3Ko8Dmj93x4R x7Pl3ftHfnYq9vBztZaWs2V+PrHR+ZRIUE+T54XOqi255IrA4eopSK9QsI/hwopt3WNDNNqbKQwP8I T1S6tti2JS9/LyfwSMJHqHW/vMWjC29nqUu8khgBymPTILZgaV25twJRyoN4W4jok3PBjz1TqqX3gE J1OYx12YFHumwUOZBWZWG8vOsjG0qAzHlrOwWdbaAWLnumUxrZpx0Upe2sHjdtkOOZc+lIByN9P2As /tMRKeQFVDmoeAr0Mu8lrs6vPR7ObPOi5xvWDUgW7SLwy0uyHjpMCL7WxdouQMTIhB14uxRD6lTa8l cN46ThlTKiQqTLhe/QUCERh3LD/zYxcVMVYT4JksGCdvcMiPtPhe4RJqquue8yCcYu3farmc0SJ5hU /YeEPKtowhI91CdpCmNOp2DQ/JWuJSVzb0k7j/qbb1hj+n6SW0jrAjPPDoNw==
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

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  5 ++++
 kernel/bpf/verifier.c        | 58 +++++++++++++++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index a159a8ffa716..af2b14a43c1c 100644
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
index 32e0fde49324..fd663b5ff6e0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5651,7 +5651,9 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 			cur->active_lock.ptr = btf;
 		cur->active_lock.id = reg->id;
 	} else {
+		struct bpf_func_state *fstate = cur_func(env);
 		void *ptr;
+		int i;
 
 		if (map)
 			ptr = map;
@@ -5669,6 +5671,23 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 		}
 		cur->active_lock.ptr = NULL;
 		cur->active_lock.id = 0;
+
+		for (i = 0; i < fstate->acquired_refs; i++) {
+			int err;
+
+			/* Complain on error because this reference state cannot
+			 * be freed before this point, as bpf_spin_lock critical
+			 * section does not allow functions that release the
+			 * allocated object immediately.
+			 */
+			if (!fstate->refs[i].release_on_unlock)
+				continue;
+			err = release_reference(env, fstate->refs[i].id);
+			if (err) {
+				verbose(env, "failed to release release_on_unlock reference");
+				return err;
+			}
+		}
 	}
 	return 0;
 }
@@ -8259,6 +8278,42 @@ static int process_kf_arg_ptr_to_kptr_strong(struct bpf_verifier_env *env,
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
+			if (state->refs[i].release_on_unlock) {
+				verbose(env, "verifier internal error: expected false release_on_unlock");
+				return -EFAULT;
+			}
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
@@ -8451,7 +8506,8 @@ static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
 			btf_name_by_offset(field->list_head.btf, et->name_off));
 		return -EINVAL;
 	}
-	return 0;
+	/* Set arg#1 for expiration after unlock */
+	return ref_set_release_on_unlock(env, reg->ref_obj_id);
 }
 
 static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta)
-- 
2.38.1

