Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E34A62E8D6
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 23:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbiKQW4X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 17:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbiKQW4U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 17:56:20 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E487C12620
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 14:56:19 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so6700511pjs.4
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 14:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCe9djUw60eHZstRoq1NUvEoHYm1TTPCbRO78TsBTdw=;
        b=fmZFaBy/g7Vtj6rz5NgKnt66rdV5cuUr9gvbNJMnLgUo5SkCBOqawFi6BcEWlDNEdT
         wBmHoWJy98R6BU66k0KmpnyI+CQJ6W9ejcnF+X9vfvk09EQ6Wd2FL42N3H6sfNqindUU
         iGK5BkMpLFCkyyeIwD4CIacbjzFBA4BOaua4YrPPJj+wJxQbglxhb2yC7SNgrmC/n1wB
         mmjJT/CB+w/abaS0LPK5Rd4jL6YZVnI8YYaqR/uBq/cbMWZpgYlA2exOUgoyCHZz59/G
         7uKymbtcAUV6MPW5n6CZmB6VSb4KZOHdfuwl0naUp6EOUES7B1S0PCqnRGzQT8wGYxEM
         vMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCe9djUw60eHZstRoq1NUvEoHYm1TTPCbRO78TsBTdw=;
        b=NDps77jp65kf5K/zBaBnD0C5IeycOC7NOeK3zJnhW1D9flla+W5vjT03JLvNu2dcic
         6EhDJuMWDkiKf4KCuy7+hioAO12KSkv6OH7yKw4yMUvtqmAL2mWgfkDExA1pRE9JO/iM
         nTKA3HEvELj3UjKve9l3IR9yjNB08p/GRbgwpypA1jOEoTVKWTc/JHZ2J7PIAftzVxUS
         6/1A5r69U6IZ+lobw/fNKDd6eGyPgArKeRJKG1Tdw0n+cImMbCM0cic5YqUdMaovVG+a
         ER/Dp5a7K2hphThkYII133QnOT7pQg/TsiV3VKyy3xSES106GArr2O8cgbRRg84YqxVP
         b20A==
X-Gm-Message-State: ANoB5pkkJsa7fp8QLhvv31WQiFQTCbvU7DWFX6M0ce7/I2paWWJQ5bkL
        Ds0MViJi+9gxvk3K7Sc2dY/yWYLUuXk=
X-Google-Smtp-Source: AA0mqf46buFN56RImZyqBzkafWRF+u82P7vLc9poemQkplEAeWlKmMAyZW1FZ+3qQuFf0l2oSev30Q==
X-Received: by 2002:a17:902:cccf:b0:176:a9d6:ed53 with SMTP id z15-20020a170902cccf00b00176a9d6ed53mr4710227ple.5.1668725779154;
        Thu, 17 Nov 2022 14:56:19 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id s184-20020a625ec1000000b0056ba7ce4d5asm1701172pfb.52.2022.11.17.14.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:56:18 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Dave Marchevsky <davemarchevsky@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v9 17/23] bpf: Add 'release on unlock' logic for bpf_list_push_{front,back}
Date:   Fri, 18 Nov 2022 04:25:04 +0530
Message-Id: <20221117225510.1676785-18-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117225510.1676785-1-memxor@gmail.com>
References: <20221117225510.1676785-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5501; i=memxor@gmail.com; h=from:subject; bh=YeqY7VpClPfaIo+bGh7Dtptyk2S4lBG8jMP3+XG0/gg=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjdrkcBExM59l0RgwVIa2AJIWmY3el4dZsFU8h6/l0 +GtH9gmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3a5HAAKCRBM4MiGSL8RyjteD/ 9Mxhg4i5fjKsnh21o/mU/fYNH8INbp07gfKJMrsadUezMjCrn292Xp8u1swsyMdDF4zLtrUi7G/ulw tTis9uMwWUWFdr+7K375P3IgzTH9vy8Qr919lvXJVs2Dhftwg78u5nV9B9v3+eypPSBvYh0qLIHMqU 80Lr6GlcLQFDfggP32dsDvnruahyWhl7lEICduOcoWAmBAjPGOQ4dfKWW1UQqCwPcZK6yDwj9TBXNT cnlqOVNHh8xfkqDGOhAXfHM+hy/wS7tzO3GKijHS2S0OTVQ7e9q8WSH+7r8cy0cyU11f1v+cbyVvZ9 qfx23UNzJ6tm+LMj7sGQHCUl+5jaRpxJr2BuwGlMBy+nHz7rWNly++mjy0EoOaAAfZJL/ozFA1ETxY JupnESHasnuQ8WZRRzd/XETZzYIljRE7Bf/R47JjR7xcxsLIVbPvOoSDlDBjcR0TmpUDhW5KhSO+DD cF27N7keyyyyoTQpRO2kOJy7G+hGYujkKihbBDm5Halu7xXoLstuCOerau9nWHpHZLkZE+tJnxUtKj HfUc4Wt4Xw/Y35yErb/milvjLnfsa8RAa09THs9l8nyoN/NOd8YuXJrhHSH8B5m1FyqBvPzH/VNuC9 /RkyNul2KOmF8dE+8Zzd7XRvn4buQdaVmFvzloMI4NgANM52D2c3Qx5E7YxQ==
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

