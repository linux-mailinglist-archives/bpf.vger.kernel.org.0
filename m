Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E8B62620D
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 20:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbiKKTeb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 14:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbiKKTe1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 14:34:27 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5615E79D09
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:34:26 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id 130so5130313pgc.5
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4dsQ02V0zwu/uhCRg/SWqmuk5Rn6ce3adp8M1rfL/M=;
        b=oB2ATCRyjmYEfKui05qok7f9ngsrGsCz8dQ8ZdgCKUkxLgm2uhS+LSBiDP6B5WKEWl
         JHgCevmDTBpJHelapbtsuWgDfXamXXfoNYVollSE034JsVLCV2tT7jJH7gp7Iv+Fx8FA
         7wBmhnsFR9kY8YSljqxYKWlbXHxQEBploSDF7Yw46On2YlFmuPDlDTFFyieycW080puO
         RYtfwkGdPwCjv+fFYg4RLFH2/C9Y4qc3S5aEMdyNjlkILqBrU7qhSy15WFSBy0rKilMc
         XPtw4CskB45pqzgI/GsvMr7jHtwtdxpABiNwPtLVmfZIPo75mKPnzxmB6kjFCVO1cspk
         2QBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4dsQ02V0zwu/uhCRg/SWqmuk5Rn6ce3adp8M1rfL/M=;
        b=Y6U/m7I48MBC48OcJPbY9ro1pstYSZxqNmI+e3+GA20A+iCrvORuNhvcpGB6juqlXb
         eA+QHhIjwUFCZw0SXFrQbQLBn9UWaRV3muq5t0lXoz+kHGcfIHO8ZOSGl2FZ+rYOeuo2
         Y10pWJZ5Xj7ZZp6y3E1Kn5uTrhk3TRFfFcRJ4nncKCkae8Dj9fWXU+HFsKIxw7f0mbAN
         w/4fR/4o+MQxegzUjAPJScbJw3U2VkJQ8AqNH9j5VZjWmLVj+c8EbEhoPg5JhJlXMZYl
         DrjoESfPXb7gf1H+IIJC6pNmyq7yEcHt5IHwMDgoWPH9OleXLw8sR+JKAS4O5n6GwnS9
         AWTA==
X-Gm-Message-State: ANoB5pmO1PClyWIX641P9pwNsVNvEZjauO/L39vZcLrqvTWliplePOTF
        Ij6nxYJoUWOdx9Wj1NUY86pGw4UJhwLT3w==
X-Google-Smtp-Source: AA0mqf49JSGR3OUpO6IaMQeCMsl6MR3CagF+m4Ww5HYyHL7p7mvvt2Y4/plaqF33RKvQyLZrOE3Spw==
X-Received: by 2002:a63:5465:0:b0:46f:f2f6:b06 with SMTP id e37-20020a635465000000b0046ff2f60b06mr2948214pgm.376.1668195265690;
        Fri, 11 Nov 2022 11:34:25 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id y9-20020aa793c9000000b0056c349f5c70sm1947572pff.79.2022.11.11.11.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:34:25 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v6 21/26] bpf: Add 'release on unlock' logic for bpf_list_push_{front,back}
Date:   Sat, 12 Nov 2022 01:02:19 +0530
Message-Id: <20221111193224.876706-22-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111193224.876706-1-memxor@gmail.com>
References: <20221111193224.876706-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5174; i=memxor@gmail.com; h=from:subject; bh=98NlxO9AjvvSWvC60uBCkXv9bNqgJ0s+pR+qr5k/Qtg=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjbqIp3VVR2rhKDAIsXd8qqP/8zFn4ivY2JZwM8X0S KHP2zm+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY26iKQAKCRBM4MiGSL8RylCaD/ wJg76QdcxxTImPSBouF2SBeSnYTxiuCUdhzV4CPiuHYbrHlmmmcZW5JY9Mt/+SqOR8X4HXh/GPbX27 +KaA7EZf76YYuE76oEN1gvmQWi0QZG2VSsPmRfMwfdiKanGrnllQ8ZppgHh8ANJV510vj4p5o7fq1+ Q+Qq4L9rquJ69pugvC5Gj27Xcy+BNwZo9FiUI3cF3acNP9mLqidfElry4HLzaC32jGhKX8hylw0zxP lVmK/6Ew6NRAj2N5wgSHl/TjqdAJ3e475bB2SX+UgeJY8OtEa2tYlmhnKLOX25ETnzBz6jAWmRIw/w 7t4NWHDr1Em6Mbg0Z7ibin4zY9SRwzwOJZMMjwh4NmFEMZiJMwP72e3e23yQSG7nTS4w273s1uwl9c KscmN5Yqm3wIx0AKrcTWHLWuTXqhsXHoYTGp3Oab1LIHoafPVuhyQCOytH3tchr/hU+wqf2L3+aDD1 d7Aj7kw5h42iNy5UF5+E1+oqahtlUraORKeQLPTF4BInr92GAZIk0FmJWr8sHNAfKdXMeayK0FSMh8 JMwt9Yq51qQCGCPtQtSSURQKUVPI7wSdZfEjZ0n+Eh/KrCyot+0u4WQl48pEp4slV5LyZkXQOBR856 gED24FMTole+W/cT+Esp2vlfXSt+ur0JFNVc7Znad8BZMUHCZAq7WYNk8X8Q==
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
index 7ad077d85e3b..161b66689fdc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5643,7 +5643,9 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 			cur->active_lock.ptr = btf;
 		cur->active_lock.id = reg->id;
 	} else {
+		struct bpf_func_state *fstate = cur_func(env);
 		void *ptr;
+		int i;
 
 		if (map)
 			ptr = map;
@@ -5661,6 +5663,16 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
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
@@ -8253,6 +8265,39 @@ static int process_kf_arg_ptr_to_kptr_strong(struct bpf_verifier_env *env,
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
@@ -8438,7 +8483,8 @@ static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
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

