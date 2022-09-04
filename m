Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C995AC67B
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 22:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbiIDUmZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 16:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbiIDUmS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 16:42:18 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7985C2CDFE
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 13:42:14 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id y3so13514269ejc.1
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 13:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=jJLA4lVsXRpkgrF8b9lyev2C4IDNGoXHMhKUcSVVFYQ=;
        b=WM/u9h0f/IlUgm77Bb52e6DXazynpctq0U2I2XVKP3MJ59AVexxOyOQR5hgInMlx90
         5FJPmuuVoiiXyRf1GYe3PPj8cT6wgY5ewWkeB9/Tt4u3Xfwbkh4fMiZ6P2U8VF65RL3Z
         djj9R6sH3DG8iJuVXFpweZS4IIB8zXs/o7Kp7uJxnBcPqLAkvwNeBAOINVii3tYikD10
         C66pdlY0x/po8iv5eNhFJAbQvN7LrDGdqeTZrhTP+pH2zXfR0FoCfegjOPK9r0g/ghz1
         T1G0qdnSxXZU4cCufqi+j5M1MV4/wMq5nulk5oxHQZOQwlZK4yUF8pv3NLIbgeZCN6Wk
         quNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jJLA4lVsXRpkgrF8b9lyev2C4IDNGoXHMhKUcSVVFYQ=;
        b=q1KQPOW60B2pW8WO9ABd36gS6/XHDalmwlvO8pfLJk3APgW0gNX/WZ/Oak5BpyGPp6
         RIH1y7Uz+2i76+fpGVDD8eh4yhHvDvwnaKa2UVHyj629Es+KAJi/t7B2H/2WaJo/VIQZ
         TdrDKjIsDfS9QBjpIRZisrsYw3OcpjLtwdV631OXRJSJaWsMxatO+xSFbNN5PBgDGOxM
         x5bnyIhqkL5wCah6Ider+dz5YnpU+rmeMH1eSXfZdqI+dWstYNXVPmoTPLhWTiXu3uMM
         Gn9xQGctPRJX3afP6YbK7+yWry1z3h8VYZQuiRcrHwIWWJE0EZFhR3nAUlTRpIxv+FJf
         4GOw==
X-Gm-Message-State: ACgBeo1UbYfP4kMPOE/irGJQHJSzYY1OlRveKOC5UzjU1xxM+1qv8q2c
        e0zAAPaU9LJPbRMA2LtTrRDpxPfNRdbuwg==
X-Google-Smtp-Source: AA6agR613SmdF10ie0IbMut+L+M2S/hsm0dEnqL4x/kQtMwyYWPR+5JhUVhnErwAM9+HmPAeLYekvA==
X-Received: by 2002:a17:906:da86:b0:740:7120:c6e6 with SMTP id xh6-20020a170906da8600b007407120c6e6mr29532279ejb.44.1662324133409;
        Sun, 04 Sep 2022 13:42:13 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id kv8-20020a17090778c800b00741b368a448sm4055999ejc.203.2022.09.04.13.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:42:13 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH RFC bpf-next v1 23/32] bpf: Add single ownership BPF linked list API
Date:   Sun,  4 Sep 2022 22:41:36 +0200
Message-Id: <20220904204145.3089-24-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220904204145.3089-1-memxor@gmail.com>
References: <20220904204145.3089-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=33365; i=memxor@gmail.com; h=from:subject; bh=YE+HXASakoR1KILT5wTjPTw3+xaWQhgtVtjUVvTrBd4=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjFQ1xNW/FaHqIa8umlVggFgJwMEBbdKphHO87ggSP aJnPsdiJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYxUNcQAKCRBM4MiGSL8RypdsEA ChOO2wq0bOMcXHXu9A/DdiG5VLcSDpjhr9aCer/i1MAdeH1jIb+RaOnoT3PfmmM1SjFKx9RqBNSGlD ne1K/ZWwtEyL3qvpeEg7phs5OxsvzmCZ7MMAj2jHA51BnJohohU033pMj0Lt5YrfFIIiW1oYIca5tq yfNi9zzkQeAImYyuZ4R9DqT8d7pX3l44AP0mPuO9BubFeT7XFoUznGV/vwwaaWuU/etIxfn1ekxWbg 3UZVzIziFEtN9Dk6peZCBJPpCJzsULMowqJ88nPy4zryy7kqcMbaxATZcWdEI82wQ4bhIPzH9KnfU7 C4Q4tdvvcvUYVdTsYIx5KHCR9WpleiHUyZbEcMbe+5lxxA01BbVPXkzgoF2X/FSp7eM/355dWFRHgw hEX8L3bzlg4laY/C9isMLJw7w+kGXSXhjaY5h9MvehOCPAVaZIAPfBLAZ5SBGqKDsMbq7/kuj7/o8C 8DQHuaxQ9JNLasZVTZ73WjR7iEAiIeoXpYaAJk4Xtz8E1Tw9JtiDn+IgqvBAhynyuOAnmjo6CKiP3y tewZk4pY1wg+akQzhz0Xi5ab/B2WfOwfn5ApmgY8t0N8gUz047S4abZ7Uy7Xa0EmbNlenKjJhcGXE4 ytfCPF/tM4jRhk6XNKVfUwWi89a9rrWdrvkTJBSUb2sz2WXWkdeoGI5zNShg==
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

Add a linked list API for use in BPF programs, where it expects
protection from the bpf_spin_lock in the same allocation as the
bpf_list_head. Future patches will extend the same infrastructure to
have different flavors with varying protection domains and visibility
(e.g. percpu variant with local_t protection, usable in NMI progs).

The following functions are added to kick things off:

bpf_list_add
bpf_list_add_tail
bpf_list_del
bpf_list_pop_front
bpf_list_pop_back

The lock protecting the bpf_list_head needs to be taken for all
operations.

Once a node has been added to the list, it's pointer changes to
PTR_UNTRUSTED. However, it is only released once the lock protecting the
list is unlocked. For such local kptrs with PTR_UNTRUSTED set but an
active ref_obj_id, it is still permitted to read and write to them as
long as the lock is held. However, they cannot be deleted using
bpf_list_del after addition directly. bpf_list_del will only be
permitted inside for_each helpers for lists which will be added in later
patches. This is unlikely to be a problem as deleting right after
addition in the same lock section is quite uncommon.

For now, bpf_list_del is hence unusable, unless a for_each helper is
added, but it is still necessary to ensure it works correctly in
presence of the rest of the API, and has thus been included with this
change.

bpf_list_pop_front and bpf_list_pop_back delete the first or last item
of the list respectively, and return pointer to the element at the
list_node offset. The user can then use container_of style macro to get
the actual entry type. The verifier however statically knows the actual
type, so the safety properties are still preserved.

With these additions, programs can now manage their own linked lists and
store their objects in them.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h                  |   5 +
 include/linux/btf.h                           |  11 +
 kernel/bpf/btf.c                              |  47 +-
 kernel/bpf/helpers.c                          |  55 ++
 kernel/bpf/verifier.c                         | 489 ++++++++++++++++--
 .../testing/selftests/bpf/bpf_experimental.h  |  35 ++
 6 files changed, 599 insertions(+), 43 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 00c21ad6f61c..3cce796c4d76 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -249,6 +249,11 @@ struct bpf_reference_state {
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
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 42c7f0283887..bd57a9cae12c 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -437,6 +437,9 @@ int btf_local_type_has_bpf_list_node(const struct btf *btf,
 				     const struct btf_type *t, u32 *offsetp);
 int btf_local_type_has_bpf_spin_lock(const struct btf *btf,
 				     const struct btf_type *t, u32 *offsetp);
+int __btf_local_type_has_bpf_list_head(const struct btf *btf,
+				       const struct btf_type *t, u32 *offsetp,
+				       u32 *value_type_idp, u32 *list_node_offp);
 int btf_local_type_has_bpf_list_head(const struct btf *btf,
 				     const struct btf_type *t, u32 *offsetp);
 bool btf_local_type_has_special_fields(const struct btf *btf,
@@ -491,6 +494,14 @@ static inline int btf_local_type_has_bpf_spin_lock(const struct btf *btf,
 {
 	return -ENOENT;
 }
+static inline int __btf_local_type_has_bpf_list_head(const struct btf *btf,
+						     const struct btf_type *t,
+						     u32 *offsetp,
+						     u32 *value_type_idp,
+						     u32 *list_node_offp)
+{
+	return -ENOENT;
+}
 static inline int btf_local_type_has_bpf_list_head(const struct btf *btf,
 					           const struct btf_type *t,
 					           u32 *offsetp)
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 439c980419b9..e2ac088cb64f 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5981,7 +5981,8 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 static int btf_find_local_type_field(const struct btf *btf,
 				     const struct btf_type *t,
 				     enum btf_field_type type,
-				     u32 *offsetp)
+				     u32 *offsetp, u32 *value_type_idp,
+				     u32 *list_node_offp)
 {
 	struct btf_field_info info;
 	int ret;
@@ -5996,9 +5997,40 @@ static int btf_find_local_type_field(const struct btf *btf,
 	/* A validation step needs to be done for bpf_list_head in local kptrs */
 	if (type == BTF_FIELD_LIST_HEAD_KPTR) {
 		const struct btf_type *vt = btf_type_by_id(btf, info.list_head.value_type_id);
+		const struct btf_type *n = NULL;
+		const struct btf_member *member;
+		u32 offset;
+		int i;
 
 		if (!list_head_value_ok(btf, t, vt, type))
 			return -EINVAL;
+		for_each_member(i, vt, member) {
+			if (strcmp(info.list_head.node_name, __btf_name_by_offset(btf, member->name_off)))
+				continue;
+			/* Invalid BTF, two members with same name */
+			if (n)
+				return -EINVAL;
+			n = btf_type_by_id(btf, member->type);
+			if (!__btf_type_is_struct(n))
+				return -EINVAL;
+			if (strcmp("bpf_list_node", __btf_name_by_offset(btf, n->name_off)))
+				return -EINVAL;
+			offset = __btf_member_bit_offset(n, member);
+			if (offset % 8)
+				return -EINVAL;
+			offset /= 8;
+			if (offset % __alignof__(struct bpf_list_node))
+				return -EINVAL;
+			if (value_type_idp)
+				*value_type_idp = info.list_head.value_type_id;
+			if (list_node_offp)
+				*list_node_offp = offset;
+		}
+		/* Could not find bpf_list_node */
+		if (!n)
+			return -ENOENT;
+	} else if (value_type_idp || list_node_offp) {
+		return -EFAULT;
 	}
 	if (offsetp)
 		*offsetp = info.off;
@@ -6008,19 +6040,26 @@ static int btf_find_local_type_field(const struct btf *btf,
 int btf_local_type_has_bpf_list_node(const struct btf *btf,
 				     const struct btf_type *t, u32 *offsetp)
 {
-	return btf_find_local_type_field(btf, t, BTF_FIELD_LIST_NODE, offsetp);
+	return btf_find_local_type_field(btf, t, BTF_FIELD_LIST_NODE, offsetp, NULL, NULL);
 }
 
 int btf_local_type_has_bpf_spin_lock(const struct btf *btf,
 				     const struct btf_type *t, u32 *offsetp)
 {
-	return btf_find_local_type_field(btf, t, BTF_FIELD_SPIN_LOCK, offsetp);
+	return btf_find_local_type_field(btf, t, BTF_FIELD_SPIN_LOCK, offsetp, NULL, NULL);
+}
+
+int __btf_local_type_has_bpf_list_head(const struct btf *btf,
+				       const struct btf_type *t, u32 *offsetp,
+				       u32 *value_type_idp, u32 *list_node_offp)
+{
+	return btf_find_local_type_field(btf, t, BTF_FIELD_LIST_HEAD_KPTR, offsetp, value_type_idp, list_node_offp);
 }
 
 int btf_local_type_has_bpf_list_head(const struct btf *btf,
 				     const struct btf_type *t, u32 *offsetp)
 {
-	return btf_find_local_type_field(btf, t, BTF_FIELD_LIST_HEAD_KPTR, offsetp);
+	return __btf_local_type_has_bpf_list_head(btf, t, offsetp, NULL, NULL);
 }
 
 bool btf_local_type_has_special_fields(const struct btf *btf, const struct btf_type *t)
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 4a6fffe401ae..9d5709441800 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1736,6 +1736,56 @@ void bpf_kptr_free(void *p__dlkptr)
 	kfree(p__dlkptr);
 }
 
+static bool __always_inline __bpf_list_head_init_zeroed(struct bpf_list_head *h)
+{
+	struct list_head *head = (struct list_head *)h;
+
+	if (unlikely(!head->next)) {
+		INIT_LIST_HEAD(head);
+		return true;
+	}
+	return false;
+}
+
+void bpf_list_add(struct bpf_list_node *node, struct bpf_list_head *head)
+{
+	__bpf_list_head_init_zeroed(head);
+	list_add((struct list_head *)node, (struct list_head *)head);
+}
+
+void bpf_list_add_tail(struct bpf_list_node *node, struct bpf_list_head *head)
+{
+	__bpf_list_head_init_zeroed(head);
+	list_add_tail((struct list_head *)node, (struct list_head *)head);
+}
+
+void bpf_list_del(struct bpf_list_node *node)
+{
+	list_del_init((struct list_head *)node);
+}
+
+struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head)
+{
+	struct list_head *node, *list = (struct list_head *)head;
+
+	if (__bpf_list_head_init_zeroed(head) || list_empty(list))
+		return NULL;
+	node = list->next;
+	list_del_init(node);
+	return (struct bpf_list_node *)node;
+}
+
+struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
+{
+	struct list_head *node, *list = (struct list_head *)head;
+
+	if (__bpf_list_head_init_zeroed(head) || list_empty(list))
+		return NULL;
+	node = list->prev;
+	list_del_init(node);
+	return (struct bpf_list_node *)node;
+}
+
 __diag_pop();
 
 BTF_SET8_START(tracing_btf_ids)
@@ -1747,6 +1797,11 @@ BTF_ID_FLAGS(func, bpf_list_node_init)
 BTF_ID_FLAGS(func, bpf_spin_lock_init)
 BTF_ID_FLAGS(func, bpf_list_head_init)
 BTF_ID_FLAGS(func, bpf_kptr_free, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_list_add)
+BTF_ID_FLAGS(func, bpf_list_add_tail)
+BTF_ID_FLAGS(func, bpf_list_del)
+BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL | __KF_RET_DYN_BTF)
+BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL | __KF_RET_DYN_BTF)
 BTF_SET8_END(tracing_btf_ids)
 
 static const struct btf_kfunc_id_set tracing_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ed19e4036b0a..dcbeb503c25c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4584,9 +4584,19 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 						  false);
 	} else {
 		/* It is allowed to write to pointer to a local type */
-		if (atype != BPF_READ && !type_is_local(reg->type)) {
-			verbose(env, "only read is supported\n");
-			return -EACCES;
+		if (atype != BPF_READ) {
+			/* When a local kptr is marked untrusted, but has an
+			 * active ref_obj_id, it means that it is untrusted only
+			 * for passing to helpers, but not for reads and writes.
+			 *
+			 * For local kptr loaded from maps, PTR_UNTRUSTED would
+			 * be set but without an active ref_obj_id, which means
+			 * writing won't be permitted.
+			 */
+			if (!type_is_local(reg->type) || !reg->ref_obj_id) {
+				verbose(env, "only read is supported\n");
+				return -EACCES;
+			}
 		}
 
 		ret = btf_struct_access(&env->log, reg->btf, t, off, size,
@@ -5516,7 +5526,9 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 			cur->active_spin_lock_ptr = btf;
 		cur->active_spin_lock_id = reg->id;
 	} else {
+		struct bpf_func_state *fstate = cur_func(env);
 		void *ptr;
+		int i;
 
 		if (map)
 			ptr = map;
@@ -5534,6 +5546,17 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 		}
 		cur->active_spin_lock_ptr = NULL;
 		cur->active_spin_lock_id = 0;
+
+		/* Now, which ever registers are waiting to expire after the
+		 * critical section ends, kill them.
+		 */
+		for (i = 0; i < fstate->acquired_refs; i++) {
+			/* WARN because this reference state cannot be freed
+			 * before this point.
+			 */
+			if (fstate->refs[i].release_on_unlock)
+				WARN_ON_ONCE(release_reference(env, fstate->refs[i].id));
+		}
 	}
 	return 0;
 }
@@ -7681,6 +7704,11 @@ struct bpf_kfunc_arg_meta {
 		u64 value;
 		bool found;
 	} arg_constant;
+	struct {
+		struct btf *btf;
+		u32 type_id;
+		u32 off;
+	} list_node;
 };
 
 static bool is_kfunc_acquire(struct bpf_kfunc_arg_meta *meta)
@@ -7772,6 +7800,30 @@ static bool is_kfunc_arg_sfx_destructing_local_kptr(const struct btf *btf,
 	return __kfunc_param_match_suffix(btf, arg, "__dlkptr");
 }
 
+BTF_ID_LIST(list_struct_ids)
+BTF_ID(struct, bpf_list_head)
+BTF_ID(struct, bpf_list_node)
+
+static bool __is_kfunc_arg_list_struct(const struct btf *btf, const struct btf_param *arg, u32 btf_id)
+{
+	const struct btf_type *t;
+
+	t = btf_type_by_id(btf, arg->type);
+	if (!t || !btf_type_is_ptr(t))
+		return false;
+	return t->type == btf_id;
+}
+
+static bool is_kfunc_arg_list_head(const struct btf *btf, const struct btf_param *arg)
+{
+	return __is_kfunc_arg_list_struct(btf, arg, list_struct_ids[0]);
+}
+
+static bool is_kfunc_arg_list_node(const struct btf *btf, const struct btf_param *arg)
+{
+	return __is_kfunc_arg_list_struct(btf, arg, list_struct_ids[1]);
+}
+
 /* Returns true if struct is composed of scalars, 4 levels of nesting allowed */
 static bool __btf_type_is_scalar_struct(struct bpf_verifier_env *env,
 					const struct btf *btf,
@@ -7827,6 +7879,11 @@ BTF_ID(func, bpf_list_node_init)
 BTF_ID(func, bpf_spin_lock_init)
 BTF_ID(func, bpf_list_head_init)
 BTF_ID(func, bpf_kptr_free)
+BTF_ID(func, bpf_list_add)
+BTF_ID(func, bpf_list_add_tail)
+BTF_ID(func, bpf_list_del)
+BTF_ID(func, bpf_list_pop_front)
+BTF_ID(func, bpf_list_pop_back)
 BTF_ID(struct, btf) /* empty entry */
 
 enum bpf_special_kfuncs {
@@ -7835,6 +7892,11 @@ enum bpf_special_kfuncs {
 	KF_SPECIAL_bpf_spin_lock_init,
 	KF_SPECIAL_bpf_list_head_init,
 	KF_SPECIAL_bpf_kptr_free,
+	KF_SPECIAL_bpf_list_add,
+	KF_SPECIAL_bpf_list_add_tail,
+	KF_SPECIAL_bpf_list_del,
+	KF_SPECIAL_bpf_list_pop_front,
+	KF_SPECIAL_bpf_list_pop_back,
 	KF_SPECIAL_bpf_empty,
 	KF_SPECIAL_MAX = KF_SPECIAL_bpf_empty,
 };
@@ -7846,8 +7908,18 @@ static bool __is_kfunc_special(const struct btf *btf, u32 func_id, unsigned int
 	return func_id == special_kfuncs[kf_sp];
 }
 
+static bool __is_kfunc_insn_special(struct bpf_insn *insn, unsigned int kf_sp)
+{
+	/* insn->off == 0 means btf_vmlinux */
+	if (insn->off || kf_sp >= KF_SPECIAL_MAX)
+		return false;
+	return insn->imm == special_kfuncs[kf_sp];
+}
+
 #define is_kfunc_special(btf, func_id, func_name) \
 	__is_kfunc_special(btf, func_id, KF_SPECIAL_##func_name)
+#define is_kfunc_insn_special(insn, func_name) \
+	__is_kfunc_insn_special(insn, KF_SPECIAL_##func_name)
 
 enum kfunc_ptr_arg_types {
 	KF_ARG_PTR_TO_CTX,
@@ -7855,6 +7927,8 @@ enum kfunc_ptr_arg_types {
 	KF_ARG_PTR_TO_KPTR_STRONG,   /* PTR_TO_KPTR but type specific */
 	KF_ARG_CONSTRUCTING_LOCAL_KPTR,
 	KF_ARG_DESTRUCTING_LOCAL_KPTR,
+	KF_ARG_PTR_TO_LIST_HEAD,
+	KF_ARG_PTR_TO_LIST_NODE,
 	KF_ARG_PTR_TO_MEM,
 	KF_ARG_PTR_TO_MEM_SIZE,	     /* Size derived from next argument, skip it */
 };
@@ -7902,6 +7976,12 @@ enum kfunc_ptr_arg_types get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (btf_get_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env->prog), argno))
 		return KF_ARG_PTR_TO_CTX;
 
+	if (is_kfunc_arg_list_head(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_LIST_HEAD;
+
+	if (is_kfunc_arg_list_node(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_LIST_NODE;
+
 	if ((base_type(reg->type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
 		if (!btf_type_is_struct(ref_t)) {
 			verbose(env, "kernel function %s args#%d pointer type %s %s is not supported\n",
@@ -8049,7 +8129,7 @@ static int find_local_type_fields(const struct btf *btf, u32 btf_id, struct loca
 
 	FILL_LOCAL_TYPE_FIELD(bpf_list_node, bpf_list_node_init, bpf_empty, false);
 	FILL_LOCAL_TYPE_FIELD(bpf_spin_lock, bpf_spin_lock_init, bpf_empty, false);
-	FILL_LOCAL_TYPE_FIELD(bpf_list_head, bpf_list_head_init, bpf_empty, false);
+	FILL_LOCAL_TYPE_FIELD(bpf_list_head, bpf_list_head_init, bpf_empty, true);
 
 #undef FILL_LOCAL_TYPE_FIELD
 
@@ -8290,6 +8370,298 @@ process_kf_arg_destructing_local_kptr(struct bpf_verifier_env *env,
 	return -EINVAL;
 }
 
+static int __reg_release_on_unlock(struct bpf_verifier_env *env, struct bpf_reg_state *reg, bool set)
+{
+	struct bpf_func_state *state = cur_func(env);
+	u32 ref_obj_id = reg->ref_obj_id;
+	int i;
+
+	/* bpf_spin_lock only allows calling list_add and list_del, no BPF
+	 * subprogs, no global functions, so this acquired refs state is the
+	 * same one we will use to find registers to kill on bpf_spin_unlock.
+	 */
+	WARN_ON_ONCE(!ref_obj_id);
+	for (i = 0; i < state->acquired_refs; i++) {
+		if (state->refs[i].id == ref_obj_id) {
+			if (!set)
+				return state->refs[i].release_on_unlock;
+			WARN_ON_ONCE(state->refs[i].release_on_unlock);
+			state->refs[i].release_on_unlock = true;
+			/* Now mark everyone sharing same ref_obj_id as untrusted */
+			bpf_expr_for_each_reg_in_vstate(env->cur_state, state, reg, ({
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
+static bool reg_get_release_on_unlock(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+{
+	return __reg_release_on_unlock(env, reg, false);
+}
+
+static bool reg_mark_release_on_unlock(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+{
+	return __reg_release_on_unlock(env, reg, true);
+}
+
+static int __process_list_kfunc_head(struct bpf_verifier_env *env,
+				     struct bpf_reg_state *reg, int argno,
+				     const struct btf **btfp, u32 *val_type_id,
+				     u32 *node_off)
+{
+	int ret;
+
+	if (reg->type == PTR_TO_MAP_VALUE) {
+		struct bpf_map_value_off_desc *off_desc;
+		struct bpf_map *map_ptr = reg->map_ptr;
+		u32 list_head_off;
+
+		if (!tnum_is_const(reg->var_off)) {
+			verbose(env,
+				"R%d doesn't have constant offset. bpf_list_head has to be at the constant offset\n",
+				argno + 1);
+			return -EINVAL;
+		}
+		if (!map_ptr->btf) {
+			verbose(env, "map '%s' has to have BTF in order to use bpf_list_add{,_tail}\n",
+				map_ptr->name);
+			return -EINVAL;
+		}
+		if (!map_value_has_list_heads(map_ptr)) {
+			ret = PTR_ERR_OR_ZERO(map_ptr->list_head_off_tab);
+			if (ret == -E2BIG)
+				verbose(env, "map '%s' has more than %d bpf_list_head\n", map_ptr->name,
+					BPF_MAP_VALUE_OFF_MAX);
+			else if (ret == -EEXIST)
+				verbose(env, "map '%s' has repeating BTF tags\n", map_ptr->name);
+			else
+				verbose(env, "map '%s' has no valid bpf_list_head\n", map_ptr->name);
+			return -EINVAL;
+		}
+
+		list_head_off = reg->off + reg->var_off.value;
+		off_desc = bpf_map_list_head_off_contains(map_ptr, list_head_off);
+		if (!off_desc) {
+			verbose(env, "off=%d doesn't point to bpf_list_head\n", list_head_off);
+			return -EACCES;
+		}
+
+		/* Now, we found the bpf_list_head, verify locking and element type */
+		*btfp = off_desc->list_head.btf;
+		*val_type_id = off_desc->list_head.value_type_id;
+		*node_off = off_desc->list_head.list_node_off;
+	} else /* PTR_TO_BTF_ID | MEM_TYPE_LOCAL */ {
+		u32 value_type_id, list_node_off;
+		const struct btf_type *t;
+		u32 offset;
+
+		t = btf_type_by_id(reg->btf, reg->btf_id);
+		if (!t)
+			return -EFAULT;
+		ret = __btf_local_type_has_bpf_list_head(reg->btf, t, &offset, &value_type_id, &list_node_off);
+		/* Already guaranteed by check_func_arg_ref_off that var_off is not set */
+		if (ret <= 0 || reg->off != offset) {
+			verbose(env, "no bpf_list_head field found at offset=%d\n", reg->off);
+			return ret ?: -EINVAL;
+		}
+
+		/* Now, we found the bpf_list_head, verify locking and element type */
+		*btfp = reg->btf;
+		*val_type_id = value_type_id;
+		*node_off = list_node_off;
+	}
+
+	return 0;
+}
+
+static int process_list_add_kfunc(struct bpf_verifier_env *env,
+				  struct bpf_reg_state *reg,
+				  struct bpf_kfunc_arg_meta *meta,
+				  int argno)
+{
+	u32 list_head_value_type_id, list_head_node_off;
+	const struct btf *list_head_btf;
+	bool is_list_head = !!argno;
+	void *ptr;
+	int ret;
+
+	if (is_list_head) {
+		ret = __process_list_kfunc_head(env, reg, argno, &list_head_btf,
+						&list_head_value_type_id, &list_head_node_off);
+		if (ret < 0)
+			return ret;
+	} else {
+		const struct btf_type *t;
+		u32 offset;
+
+		t = btf_type_by_id(reg->btf, reg->btf_id);
+		if (!t)
+			return -EFAULT;
+		ret = btf_local_type_has_bpf_list_node(reg->btf, t, &offset);
+		/* Already guaranteed by check_func_arg_ref_off that var_off is not set */
+		if (ret <= 0 || reg->off != offset) {
+			verbose(env, "no %s field found at offset=%d\n",
+				is_list_head ? "bpf_list_head" : "bpf_list_node", reg->off);
+			return ret ?: -EINVAL;
+		}
+
+		/* Save info for use in verification of next argument bpf_list_head */
+		if (WARN_ON_ONCE(reg_get_release_on_unlock(env, reg))) {
+			verbose(env, "bpf_list_node has already been added to a list\n");
+			return -EINVAL;
+		}
+		meta->list_node.btf = reg->btf;
+		meta->list_node.type_id = reg->btf_id;
+		meta->list_node.off = reg->off;
+		/* The node will be released once we unlock bpf_list_head, until
+		 * then we have the option of accessing it, but cannot pass it
+		 * further to any other helpers or kfuncs.
+		 */
+		reg_mark_release_on_unlock(env, reg);
+		return 0;
+	}
+
+	/* Locking safety */
+	if (!env->cur_state->active_spin_lock_ptr) {
+		verbose(env, "cannot add node to bpf_list_head without holding its lock\n");
+		return -EINVAL;
+	}
+
+	if (reg->type == PTR_TO_MAP_VALUE)
+		ptr = reg->map_ptr;
+	else
+		ptr = reg->btf;
+	if (env->cur_state->active_spin_lock_ptr != ptr ||
+	    env->cur_state->active_spin_lock_id != reg->id) {
+		verbose(env, "incorrect bpf_spin_lock held for bpf_list_head\n");
+		return -EINVAL;
+	}
+
+	/* Type match */
+	if (meta->list_node.off != list_head_node_off) {
+		verbose(env, "arg list_node off=%d does not match bpf_list_head value's list_node off=%d\n",
+			meta->list_node.off, list_head_node_off);
+		return -EINVAL;
+	}
+	if (!btf_struct_ids_match(&env->log, meta->list_node.btf, meta->list_node.type_id,
+				  0, list_head_btf, list_head_value_type_id, true)) {
+		verbose(env, "bpf_list_node type does not match bpf_list_head value type\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int process_list_del_kfunc(struct bpf_verifier_env *env,
+				  struct bpf_reg_state *reg,
+				  struct bpf_kfunc_arg_meta *meta)
+{
+	const struct btf_type *t;
+	int ret, offset;
+
+	t = btf_type_by_id(reg->btf, reg->btf_id);
+	if (!t)
+		return -EFAULT;
+	ret = btf_local_type_has_bpf_list_node(reg->btf, t, &offset);
+	/* Already guaranteed by check_func_arg_ref_off that var_off is not set */
+	if (ret <= 0 || reg->off != offset) {
+		verbose(env, "no bpf_list_node field found at offset=%d\n", reg->off);
+		return ret ?: -EINVAL;
+	}
+	if (!reg_get_release_on_unlock(env, reg)) {
+		verbose(env, "cannot remove bpf_list_node which is not part of a list\n");
+		return -EINVAL;
+	}
+	/* ... and inserted ones are marked as PTR_UNTRUSTED, so they won't be
+	 * seen by us.
+	 *
+	 * It won't be safe to allow bpf_list_del since we can also do
+	 * bpf_list_pop_front or bpf_list_pop_back, so that node can potentially
+	 * be deleted twice.
+	 *
+	 * Regardless, just deleting again after adding is useless, so we're
+	 * fine! You have much better pop_front/pop_back available anyway.
+	 *
+	 * One of the safe contexts would be allowing it in list_for_each
+	 * helper, but that is still unimplemented so far, hence leave out
+	 * handling that case for now.
+	 *
+	 * For for_each case, the reg->off should equal list_node_off of the
+	 * list we are iterating, which we know statically.
+	 *
+	 * XXX: Allow when invoking inside for_each helper.
+	 */
+	return 0;
+}
+
+static int process_list_pop_kfunc(struct bpf_verifier_env *env,
+				  struct bpf_reg_state *reg,
+				  struct bpf_kfunc_arg_meta *meta,
+				  int argno)
+{
+	u32 value_type_id, list_node_off;
+	const struct btf *btf;
+	void *ptr;
+	int ret;
+
+	ret = __process_list_kfunc_head(env, reg, argno, &btf, &value_type_id, &list_node_off);
+	if (ret < 0)
+		return ret;
+	meta->list_node.btf = (struct btf *)btf;
+	meta->list_node.type_id = value_type_id;
+	meta->list_node.off = list_node_off;
+
+	/* Locking safety */
+	if (!env->cur_state->active_spin_lock_ptr) {
+		verbose(env, "cannot add node to bpf_list_head without holding its lock\n");
+		return -EINVAL;
+	}
+
+	if (reg->type == PTR_TO_MAP_VALUE)
+		ptr = reg->map_ptr;
+	else
+		ptr = reg->btf;
+	if (env->cur_state->active_spin_lock_ptr != ptr ||
+	    env->cur_state->active_spin_lock_id != reg->id) {
+		verbose(env, "incorrect bpf_spin_lock held for bpf_list_head\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int process_kf_arg_ptr_to_list_head(struct bpf_verifier_env *env,
+					   struct bpf_reg_state *reg,
+					   struct bpf_kfunc_arg_meta *meta,
+					   int argno)
+{
+	if ((is_kfunc_special(meta->btf, meta->func_id, bpf_list_add) ||
+	     is_kfunc_special(meta->btf, meta->func_id, bpf_list_add_tail)) && argno == 1)
+		return process_list_add_kfunc(env, reg, meta, argno);
+	if ((is_kfunc_special(meta->btf, meta->func_id, bpf_list_pop_front) ||
+	     is_kfunc_special(meta->btf, meta->func_id, bpf_list_pop_back)) && argno == 0)
+		return process_list_pop_kfunc(env, reg, meta, argno);
+	verbose(env, "verifier internal error: incorrect bpf_list_head argument\n");
+	return -EFAULT;
+}
+
+static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
+					   struct bpf_reg_state *reg,
+					   struct bpf_kfunc_arg_meta *meta,
+					   int argno)
+{
+	if ((is_kfunc_special(meta->btf, meta->func_id, bpf_list_add) ||
+	     is_kfunc_special(meta->btf, meta->func_id, bpf_list_add_tail)) && argno == 0)
+		return process_list_add_kfunc(env, reg, meta, argno);
+	else if (is_kfunc_special(meta->btf, meta->func_id, bpf_list_del) && argno == 0)
+		return process_list_del_kfunc(env, reg, meta);
+	verbose(env, "verifier internal error: incorrect bpf_list_node argument\n");
+	return -EFAULT;
+}
+
 static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_arg_meta *meta)
 {
 	const char *func_name = meta->func_name, *ref_tname;
@@ -8428,6 +8800,25 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_arg_m
 			if (ret < 0)
 				return ret;
 			break;
+		case KF_ARG_PTR_TO_LIST_HEAD:
+			if (reg->type != PTR_TO_MAP_VALUE &&
+			    reg->type != (PTR_TO_BTF_ID | MEM_TYPE_LOCAL)) {
+				verbose(env, "arg#%d expected pointer to map value or local kptr\n", i);
+				return -EINVAL;
+			}
+			ret = process_kf_arg_ptr_to_list_head(env, reg, meta, i);
+			if (ret < 0)
+				return ret;
+			break;
+		case KF_ARG_PTR_TO_LIST_NODE:
+			if (reg->type != (PTR_TO_BTF_ID | MEM_TYPE_LOCAL)) {
+				verbose(env, "arg#%d expected pointer to local kptr\n", i);
+				return -EINVAL;
+			}
+			ret = process_kf_arg_ptr_to_list_node(env, reg, meta, i);
+			if (ret < 0)
+				return ret;
+			break;
 		case KF_ARG_PTR_TO_MEM:
 			resolve_ret = btf_resolve_size(btf, ref_t, &type_size);
 			if (IS_ERR(resolve_ret)) {
@@ -8545,41 +8936,50 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		regs[BPF_REG_0].type = PTR_TO_BTF_ID;
 
 		if (__is_kfunc_ret_dyn_btf(&meta)) {
-			const struct btf_type *ret_t;
+			if (is_kfunc_special(meta.btf, meta.func_id, bpf_kptr_alloc)) {
+				const struct btf_type *ret_t;
 
-			/* Currently, only bpf_kptr_alloc needs special handling */
-			if (!is_kfunc_special(meta.btf, meta.func_id, bpf_kptr_alloc) ||
-			    !meta.arg_constant.found || !btf_type_is_void(ptr_type)) {
-				verbose(env, "verifier internal error: misconfigured kfunc\n");
-				return -EFAULT;
-			}
+				if (!meta.arg_constant.found || !btf_type_is_void(ptr_type)) {
+					verbose(env, "verifier internal error: misconfigured kfunc\n");
+					return -EFAULT;
+				}
 
-			if (((u64)(u32)meta.arg_constant.value) != meta.arg_constant.value) {
-				verbose(env, "local type ID argument must be in range [0, U32_MAX]\n");
-				return -EINVAL;
-			}
+				if (((u64)(u32)meta.arg_constant.value) != meta.arg_constant.value) {
+					verbose(env, "local type ID argument must be in range [0, U32_MAX]\n");
+					return -EINVAL;
+				}
 
-			ret_btf = env->prog->aux->btf;
-			ret_btf_id = meta.arg_constant.value;
+				ret_btf = env->prog->aux->btf;
+				ret_btf_id = meta.arg_constant.value;
 
-			ret_t = btf_type_by_id(ret_btf, ret_btf_id);
-			if (!ret_t || !__btf_type_is_struct(ret_t)) {
-				verbose(env, "local type ID %d passed to bpf_kptr_alloc does not refer to struct\n",
-					ret_btf_id);
-				return -EINVAL;
+				ret_t = btf_type_by_id(ret_btf, ret_btf_id);
+				if (!ret_t || !__btf_type_is_struct(ret_t)) {
+					verbose(env, "local type ID %d passed to bpf_kptr_alloc does not refer to struct\n",
+						ret_btf_id);
+					return -EINVAL;
+				}
+				/* Remember this so that we can rewrite R1 as size in fixup_kfunc_call */
+				env->insn_aux_data[insn_idx].kptr_alloc_size = ret_t->size;
+				/* For now, since we hardcode prog->btf, also hardcode
+				 * setting of this flag.
+				 */
+				regs[BPF_REG_0].type |= MEM_TYPE_LOCAL;
+				/* Recognize special fields in local type and force
+				 * their construction before pointer escapes by setting
+				 * OBJ_CONSTRUCTING.
+				 */
+				if (btf_local_type_has_special_fields(ret_btf, ret_t))
+					regs[BPF_REG_0].type |= OBJ_CONSTRUCTING;
+			} else if (is_kfunc_special(meta.btf, meta.func_id, bpf_list_pop_front) ||
+				   is_kfunc_special(meta.btf, meta.func_id, bpf_list_pop_back)) {
+				ret_btf = meta.list_node.btf;
+				ret_btf_id = meta.list_node.type_id;
+				regs[BPF_REG_0].off = meta.list_node.off;
+				regs[BPF_REG_0].type |= MEM_TYPE_LOCAL;
+			} else {
+				verbose(env, "verifier internal error: missing __KF_RET_DYN_BTF handling\n");
+				return -EFAULT;
 			}
-			/* Remember this so that we can rewrite R1 as size in fixup_kfunc_call */
-			env->insn_aux_data[insn_idx].kptr_alloc_size = ret_t->size;
-			/* For now, since we hardcode prog->btf, also hardcode
-			 * setting of this flag.
-			 */
-			regs[BPF_REG_0].type |= MEM_TYPE_LOCAL;
-			/* Recognize special fields in local type and force
-			 * their construction before pointer escapes by setting
-			 * OBJ_CONSTRUCTING.
-			 */
-			if (btf_local_type_has_special_fields(ret_btf, ret_t))
-				regs[BPF_REG_0].type |= OBJ_CONSTRUCTING;
 		} else {
 			if (!btf_type_is_struct(ptr_type)) {
 				ptr_type_name = btf_name_by_offset(desc_btf, ptr_type->name_off);
@@ -13228,11 +13628,22 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
-				if (env->cur_state->active_spin_lock_ptr &&
-				    (insn->src_reg == BPF_PSEUDO_CALL ||
-				     insn->imm != BPF_FUNC_spin_unlock)) {
-					verbose(env, "function calls are not allowed while holding a lock\n");
-					return -EINVAL;
+				if (env->cur_state->active_spin_lock_ptr) {
+					/* Only three functions can be called,
+					 * stable bpf_spin_unlock helper, and
+					 * unstable bpf_list_* kfuncs.
+					 */
+					if ((insn->src_reg == BPF_REG_0 && insn->imm != BPF_FUNC_spin_unlock) ||
+					    (insn->src_reg == BPF_PSEUDO_CALL) ||
+					    (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
+					     !is_kfunc_insn_special(insn, bpf_list_add) &&
+					     !is_kfunc_insn_special(insn, bpf_list_add_tail) &&
+					     !is_kfunc_insn_special(insn, bpf_list_del) &&
+					     !is_kfunc_insn_special(insn, bpf_list_pop_front) &&
+					     !is_kfunc_insn_special(insn, bpf_list_pop_back))) {
+						verbose(env, "function calls are not allowed while holding a lock\n");
+						return -EINVAL;
+					}
 				}
 				if (insn->src_reg == BPF_PSEUDO_CALL)
 					err = check_func_call(env, insn, &env->insn_idx);
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 595e99d5cbc2..a8f7a5af8ee3 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -67,4 +67,39 @@ void bpf_list_head_init(struct bpf_list_head *node) __ksym;
  */
 void bpf_kptr_free(void *kptr) __ksym;
 
+/* Description
+ *	Add a new entry to the head of a BPF linked list.
+ * Returns
+ *	Void.
+ */
+void bpf_list_add(struct bpf_list_node *node, struct bpf_list_head *head) __ksym;
+
+/* Description
+ *	Add a new entry to the tail of a BPF linked list.
+ * Returns
+ *	Void.
+ */
+void bpf_list_add_tail(struct bpf_list_node *node, struct bpf_list_head *head) __ksym;
+
+/* Description
+ *	Remove an entry already part of a BPF linked list.
+ * Returns
+ *	Void.
+ */
+void bpf_list_del(struct bpf_list_node *node) __ksym;
+
+/* Description
+ *	Remove the first entry of a BPF linked list.
+ * Returns
+ *	Pointer to bpf_list_node of deleted entry, or NULL if list is empty.
+ */
+struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head) __ksym;
+
+/* Description
+ *	Remove the last entry of a BPF linked list.
+ * Returns
+ *	Pointer to bpf_list_node of deleted entry, or NULL if list is empty.
+ */
+struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head) __ksym;
+
 #endif
-- 
2.34.1

