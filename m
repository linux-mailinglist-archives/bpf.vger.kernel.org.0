Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF46D62EB71
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 02:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240053AbiKRB5P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 20:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbiKRB5O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 20:57:14 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4D562047
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:57:12 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so3286346pjb.0
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nflw3bpr6pYcxk1VweqVHXwqhJWeqg/hVkW+E+K5Tzg=;
        b=mBA7QdLaDYcUsjzHKRL8nnP/hjzlRBgDeO8wfpVCm0HuUHjwTBYYdUHA5JNaDvMNhe
         cGy8566sKivsmsEqbadSYbdhxMHBqqF16+fB4kqXCKVfDHG0JZA1IVfIq8pxGkCTDpDX
         RyBZRJeUuI4AZikn2xdw7bpKRwRBpGHW2kZNC+nuj/2GgNSc3i4/JNm3315SygalswJ9
         Jwt1OUKMEcsoSiUvu47l/D9jv0loVdMuSRozI8wHNg5lkdmSuK8+Ug2wbALmAmN56y3H
         JWYGyU1QOc/lhXziiN0lEdds9OfXmkUcRBZpZEdzveRrvcMjmTN/4Pz313EbrSxKGuwV
         1aPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nflw3bpr6pYcxk1VweqVHXwqhJWeqg/hVkW+E+K5Tzg=;
        b=hv2l6V3ItCkMSame0upEuTUQzKd5tti7s7HYklRDC48D+XCUSNyLiuj5HNpnP9vO7+
         Noh4EeMqMEcdrY+SVIfgS7jUwmsts9UPmfw+6VItjWwB70wEJqT260vBO4KVa6Y6Ticc
         ziagJdFxci5xGT6wZMQmuaMkN+nS+bjqI+kOZ/UiZUbOLMvzCx/PIrUqs7byvS67unE7
         PGXxZTJfXKYvnoNi2ifVbqcR/dRg7FdIQHgs+5+h32t5pEuI1lG8w3qx6W5lbXs7OeUj
         KrYsbntYhlrRmn+ObwJyaLAytJr8ze85uCztMDRAvb/gwfjciz34a9Ml7O9zIC9pZPlI
         JovQ==
X-Gm-Message-State: ANoB5pl3m7K2DA2qYF96J0MkViRbsK0i46KtVDjIdr+ADbPUKhj07iSK
        HNgRiPRFEQuIrUkOdeDiHZvWT+4DtMg=
X-Google-Smtp-Source: AA0mqf7CyCCZ89bMOz1HD7veGD9vq9qCSfdX66NajmcYf35oc1Jx34olFAe+qqxbXjKaAXErdR6hbg==
X-Received: by 2002:a17:90b:2316:b0:20a:74b8:ea2a with SMTP id mt22-20020a17090b231600b0020a74b8ea2amr11779571pjb.73.1668736631958;
        Thu, 17 Nov 2022 17:57:11 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090341c700b0017f74cab9eesm2140491ple.128.2022.11.17.17.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:57:11 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v10 16/24] bpf: Introduce single ownership BPF linked list API
Date:   Fri, 18 Nov 2022 07:26:06 +0530
Message-Id: <20221118015614.2013203-17-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118015614.2013203-1-memxor@gmail.com>
References: <20221118015614.2013203-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=20198; i=memxor@gmail.com; h=from:subject; bh=WZAu5s3YoNLjjKKFbcdTHpHqxuRJ/DbqM0O7q1mev0I=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjduXPKqomapLoRMfvlj8bK7w/jHdinTaChhok+Tsn EAOELcmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3blzwAKCRBM4MiGSL8RytJoEA CwdMrdcXUWQs7LP4S/tIosMpiZBZ2bw8Rnubbx5LTQd5SIhpI5NCnxDd3CYW8iDDEcrtsVdwy0KPmD uD5KIgJ+8wZyUuFiR93R0UgeruqeqvqW3Ci+g8CH+bB3xo2mt9oSgT8tsn8cKkLZXP3OPQ7fpJLhWt wLgly8ZZ+kMifdSBIRgz6PRVNzfSrllSjas8nMXincAxm+oeFDWLEmRyPz/OloiF7uWO7ISVWM1j5a xvgNVBkIhyyu8vi8yETq4LsHi/yhq6UYj+6xNaiemh8fKOK8RkbiODRIshIUfAUnCOymCFb9uc0TNr caXBVy/HTjEgxDYEq7KW2CO3ugBtyOk3GeRkj1YPe0qvh5vi80qQFuYTqY+TPJwnPtJgQaGobaq28H Lo8YBblwfyAKIex8agEhH849b7JOGIvyvNbioOuB2hdknm/m9lK6/uiK/FYSAklbtMNjUUPoabjKbQ n7r+HdEF7t3+iwOCgdZTql3rcIr02Gd1ZKbCPYhbScUxWLBCf1Lc2dIKSlcbl/ZqG/KQ+FHOHoNUpm Gtx0kSjh0fzcYJThzz6qjI/ne+3i4eE4MGz5RAJKljFLMRs8DylAq+MY000WGSArY7NpyjBIWYWJI5 7/qZHP11beJI8WNo+ifJcrOZqnQ4fqK3vJ5Wua0xIQnJ8Oar1GURe1pOSQyw==
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

Add a linked list API for use in BPF programs, where it expects
protection from the bpf_spin_lock in the same allocation as the
bpf_list_head. For now, only one bpf_spin_lock can be present hence that
is assumed to be the one protecting the bpf_list_head.

The following functions are added to kick things off:

// Add node to beginning of list
void bpf_list_push_front(struct bpf_list_head *head, struct bpf_list_node *node);

// Add node to end of list
void bpf_list_push_back(struct bpf_list_head *head, struct bpf_list_node *node);

// Remove node at beginning of list and return it
struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head);

// Remove node at end of list and return it
struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head);

The lock protecting the bpf_list_head needs to be taken for all
operations. The verifier ensures that the lock that needs to be taken is
always held, and only the correct lock is taken for these operations.
These checks are made statically by relying on the reg->id preserved for
registers pointing into regions having both bpf_spin_lock and the
objects protected by it. The comment over check_reg_allocation_locked in
this change describes the logic in detail.

Note that bpf_list_push_front and bpf_list_push_back are meant to
consume the object containing the node in the 1st argument, however that
specific mechanism is intended to not release the ref_obj_id directly
until the bpf_spin_unlock is called. In this commit, nothing is done,
but the next commit will be introducing logic to handle this case, so it
has been left as is for now.

bpf_list_pop_front and bpf_list_pop_back delete the first or last item
of the list respectively, and return pointer to the element at the
list_node offset. The user can then use container_of style macro to get
the actual entry type. The verifier however statically knows the actual
type, so the safety properties are still preserved.

With these additions, programs can now manage their own linked lists and
store their objects in them.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c                          |  55 +++-
 kernel/bpf/verifier.c                         | 275 +++++++++++++++++-
 .../testing/selftests/bpf/bpf_experimental.h  |  28 ++
 3 files changed, 349 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 71d803ca0c1d..212e791d7452 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1780,6 +1780,50 @@ void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
 	bpf_mem_free(&bpf_global_ma, p);
 }
 
+static void __bpf_list_add(struct bpf_list_node *node, struct bpf_list_head *head, bool tail)
+{
+	struct list_head *n = (void *)node, *h = (void *)head;
+
+	if (unlikely(!h->next))
+		INIT_LIST_HEAD(h);
+	if (unlikely(!n->next))
+		INIT_LIST_HEAD(n);
+	tail ? list_add_tail(n, h) : list_add(n, h);
+}
+
+void bpf_list_push_front(struct bpf_list_head *head, struct bpf_list_node *node)
+{
+	return __bpf_list_add(node, head, false);
+}
+
+void bpf_list_push_back(struct bpf_list_head *head, struct bpf_list_node *node)
+{
+	return __bpf_list_add(node, head, true);
+}
+
+static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head, bool tail)
+{
+	struct list_head *n, *h = (void *)head;
+
+	if (unlikely(!h->next))
+		INIT_LIST_HEAD(h);
+	if (list_empty(h))
+		return NULL;
+	n = tail ? h->prev : h->next;
+	list_del_init(n);
+	return (struct bpf_list_node *)n;
+}
+
+struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head)
+{
+	return __bpf_list_del(head, false);
+}
+
+struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
+{
+	return __bpf_list_del(head, true);
+}
+
 __diag_pop();
 
 BTF_SET8_START(generic_btf_ids)
@@ -1788,6 +1832,10 @@ BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
 #endif
 BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_obj_drop_impl, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_list_push_front)
+BTF_ID_FLAGS(func, bpf_list_push_back)
+BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
 BTF_SET8_END(generic_btf_ids)
 
 static const struct btf_kfunc_id_set generic_kfunc_set = {
@@ -1797,7 +1845,12 @@ static const struct btf_kfunc_id_set generic_kfunc_set = {
 
 static int __init kfunc_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &generic_kfunc_set);
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &generic_kfunc_set);
+	if (ret)
+		return ret;
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &generic_kfunc_set);
 }
 
 late_initcall(kfunc_init);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 84798773b592..00d3122086c2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7883,6 +7883,9 @@ struct bpf_kfunc_call_arg_meta {
 		struct btf *btf;
 		u32 btf_id;
 	} arg_obj_drop;
+	struct {
+		struct btf_field *field;
+	} arg_list_head;
 };
 
 static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta)
@@ -7987,13 +7990,17 @@ static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
 
 enum {
 	KF_ARG_DYNPTR_ID,
+	KF_ARG_LIST_HEAD_ID,
+	KF_ARG_LIST_NODE_ID,
 };
 
 BTF_ID_LIST(kf_arg_btf_ids)
 BTF_ID(struct, bpf_dynptr_kern)
+BTF_ID(struct, bpf_list_head)
+BTF_ID(struct, bpf_list_node)
 
-static bool is_kfunc_arg_dynptr(const struct btf *btf,
-				const struct btf_param *arg)
+static bool __is_kfunc_ptr_arg_type(const struct btf *btf,
+				    const struct btf_param *arg, int type)
 {
 	const struct btf_type *t;
 	u32 res_id;
@@ -8006,7 +8013,22 @@ static bool is_kfunc_arg_dynptr(const struct btf *btf,
 	t = btf_type_skip_modifiers(btf, t->type, &res_id);
 	if (!t)
 		return false;
-	return btf_types_are_same(btf, res_id, btf_vmlinux, kf_arg_btf_ids[KF_ARG_DYNPTR_ID]);
+	return btf_types_are_same(btf, res_id, btf_vmlinux, kf_arg_btf_ids[type]);
+}
+
+static bool is_kfunc_arg_dynptr(const struct btf *btf, const struct btf_param *arg)
+{
+	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_DYNPTR_ID);
+}
+
+static bool is_kfunc_arg_list_head(const struct btf *btf, const struct btf_param *arg)
+{
+	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_LIST_HEAD_ID);
+}
+
+static bool is_kfunc_arg_list_node(const struct btf *btf, const struct btf_param *arg)
+{
+	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_LIST_NODE_ID);
 }
 
 /* Returns true if struct is composed of scalars, 4 levels of nesting allowed */
@@ -8063,6 +8085,8 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_ALLOC_BTF_ID,  /* Allocated object */
 	KF_ARG_PTR_TO_KPTR,	     /* PTR_TO_KPTR but type specific */
 	KF_ARG_PTR_TO_DYNPTR,
+	KF_ARG_PTR_TO_LIST_HEAD,
+	KF_ARG_PTR_TO_LIST_NODE,
 	KF_ARG_PTR_TO_BTF_ID,	     /* Also covers reg2btf_ids conversions */
 	KF_ARG_PTR_TO_MEM,
 	KF_ARG_PTR_TO_MEM_SIZE,	     /* Size derived from next argument, skip it */
@@ -8071,16 +8095,28 @@ enum kfunc_ptr_arg_type {
 enum special_kfunc_type {
 	KF_bpf_obj_new_impl,
 	KF_bpf_obj_drop_impl,
+	KF_bpf_list_push_front,
+	KF_bpf_list_push_back,
+	KF_bpf_list_pop_front,
+	KF_bpf_list_pop_back,
 };
 
 BTF_SET_START(special_kfunc_set)
 BTF_ID(func, bpf_obj_new_impl)
 BTF_ID(func, bpf_obj_drop_impl)
+BTF_ID(func, bpf_list_push_front)
+BTF_ID(func, bpf_list_push_back)
+BTF_ID(func, bpf_list_pop_front)
+BTF_ID(func, bpf_list_pop_back)
 BTF_SET_END(special_kfunc_set)
 
 BTF_ID_LIST(special_kfunc_list)
 BTF_ID(func, bpf_obj_new_impl)
 BTF_ID(func, bpf_obj_drop_impl)
+BTF_ID(func, bpf_list_push_front)
+BTF_ID(func, bpf_list_push_back)
+BTF_ID(func, bpf_list_pop_front)
+BTF_ID(func, bpf_list_pop_back)
 
 static enum kfunc_ptr_arg_type
 get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
@@ -8123,6 +8159,12 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (is_kfunc_arg_dynptr(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_DYNPTR;
 
+	if (is_kfunc_arg_list_head(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_LIST_HEAD;
+
+	if (is_kfunc_arg_list_node(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_LIST_NODE;
+
 	if ((base_type(reg->type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
 		if (!btf_type_is_struct(ref_t)) {
 			verbose(env, "kernel function %s args#%d pointer type %s %s is not supported\n",
@@ -8218,6 +8260,182 @@ static int process_kf_arg_ptr_to_kptr_strong(struct bpf_verifier_env *env,
 	return 0;
 }
 
+/* Implementation details:
+ *
+ * Each register points to some region of memory, which we define as an
+ * allocation. Each allocation may embed a bpf_spin_lock which protects any
+ * special BPF objects (bpf_list_head, bpf_rb_root, etc.) part of the same
+ * allocation. The lock and the data it protects are colocated in the same
+ * memory region.
+ *
+ * Hence, everytime a register holds a pointer value pointing to such
+ * allocation, the verifier preserves a unique reg->id for it.
+ *
+ * The verifier remembers the lock 'ptr' and the lock 'id' whenever
+ * bpf_spin_lock is called.
+ *
+ * To enable this, lock state in the verifier captures two values:
+ *	active_lock.ptr = Register's type specific pointer
+ *	active_lock.id  = A unique ID for each register pointer value
+ *
+ * Currently, PTR_TO_MAP_VALUE and PTR_TO_BTF_ID | MEM_ALLOC are the two
+ * supported register types.
+ *
+ * The active_lock.ptr in case of map values is the reg->map_ptr, and in case of
+ * allocated objects is the reg->btf pointer.
+ *
+ * The active_lock.id is non-unique for maps supporting direct_value_addr, as we
+ * can establish the provenance of the map value statically for each distinct
+ * lookup into such maps. They always contain a single map value hence unique
+ * IDs for each pseudo load pessimizes the algorithm and rejects valid programs.
+ *
+ * So, in case of global variables, they use array maps with max_entries = 1,
+ * hence their active_lock.ptr becomes map_ptr and id = 0 (since they all point
+ * into the same map value as max_entries is 1, as described above).
+ *
+ * In case of inner map lookups, the inner map pointer has same map_ptr as the
+ * outer map pointer (in verifier context), but each lookup into an inner map
+ * assigns a fresh reg->id to the lookup, so while lookups into distinct inner
+ * maps from the same outer map share the same map_ptr as active_lock.ptr, they
+ * will get different reg->id assigned to each lookup, hence different
+ * active_lock.id.
+ *
+ * In case of allocated objects, active_lock.ptr is the reg->btf, and the
+ * reg->id is a unique ID preserved after the NULL pointer check on the pointer
+ * returned from bpf_obj_new. Each allocation receives a new reg->id.
+ */
+static int check_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+{
+	void *ptr;
+	u32 id;
+
+	switch ((int)reg->type) {
+	case PTR_TO_MAP_VALUE:
+		ptr = reg->map_ptr;
+		break;
+	case PTR_TO_BTF_ID | MEM_ALLOC:
+		ptr = reg->btf;
+		break;
+	default:
+		verbose(env, "verifier internal error: unknown reg type for lock check\n");
+		return -EFAULT;
+	}
+	id = reg->id;
+
+	if (!env->cur_state->active_lock.ptr)
+		return -EINVAL;
+	if (env->cur_state->active_lock.ptr != ptr ||
+	    env->cur_state->active_lock.id != id) {
+		verbose(env, "held lock and object are not in the same allocation\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static bool is_bpf_list_api_kfunc(u32 btf_id)
+{
+	return btf_id == special_kfunc_list[KF_bpf_list_push_front] ||
+	       btf_id == special_kfunc_list[KF_bpf_list_push_back] ||
+	       btf_id == special_kfunc_list[KF_bpf_list_pop_front] ||
+	       btf_id == special_kfunc_list[KF_bpf_list_pop_back];
+}
+
+static int process_kf_arg_ptr_to_list_head(struct bpf_verifier_env *env,
+					   struct bpf_reg_state *reg, u32 regno,
+					   struct bpf_kfunc_call_arg_meta *meta)
+{
+	struct btf_field *field;
+	struct btf_record *rec;
+	u32 list_head_off;
+
+	if (meta->btf != btf_vmlinux || !is_bpf_list_api_kfunc(meta->func_id)) {
+		verbose(env, "verifier internal error: bpf_list_head argument for unknown kfunc\n");
+		return -EFAULT;
+	}
+
+	if (!tnum_is_const(reg->var_off)) {
+		verbose(env,
+			"R%d doesn't have constant offset. bpf_list_head has to be at the constant offset\n",
+			regno);
+		return -EINVAL;
+	}
+
+	rec = reg_btf_record(reg);
+	list_head_off = reg->off + reg->var_off.value;
+	field = btf_record_find(rec, list_head_off, BPF_LIST_HEAD);
+	if (!field) {
+		verbose(env, "bpf_list_head not found at offset=%u\n", list_head_off);
+		return -EINVAL;
+	}
+
+	/* All functions require bpf_list_head to be protected using a bpf_spin_lock */
+	if (check_reg_allocation_locked(env, reg)) {
+		verbose(env, "bpf_spin_lock at off=%d must be held for bpf_list_head\n",
+			rec->spin_lock_off);
+		return -EINVAL;
+	}
+
+	if (meta->arg_list_head.field) {
+		verbose(env, "verifier internal error: repeating bpf_list_head arg\n");
+		return -EFAULT;
+	}
+	meta->arg_list_head.field = field;
+	return 0;
+}
+
+static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
+					   struct bpf_reg_state *reg, u32 regno,
+					   struct bpf_kfunc_call_arg_meta *meta)
+{
+	const struct btf_type *et, *t;
+	struct btf_field *field;
+	struct btf_record *rec;
+	u32 list_node_off;
+
+	if (meta->btf != btf_vmlinux ||
+	    (meta->func_id != special_kfunc_list[KF_bpf_list_push_front] &&
+	     meta->func_id != special_kfunc_list[KF_bpf_list_push_back])) {
+		verbose(env, "verifier internal error: bpf_list_node argument for unknown kfunc\n");
+		return -EFAULT;
+	}
+
+	if (!tnum_is_const(reg->var_off)) {
+		verbose(env,
+			"R%d doesn't have constant offset. bpf_list_node has to be at the constant offset\n",
+			regno);
+		return -EINVAL;
+	}
+
+	rec = reg_btf_record(reg);
+	list_node_off = reg->off + reg->var_off.value;
+	field = btf_record_find(rec, list_node_off, BPF_LIST_NODE);
+	if (!field || field->offset != list_node_off) {
+		verbose(env, "bpf_list_node not found at offset=%u\n", list_node_off);
+		return -EINVAL;
+	}
+
+	field = meta->arg_list_head.field;
+
+	et = btf_type_by_id(field->list_head.btf, field->list_head.value_btf_id);
+	t = btf_type_by_id(reg->btf, reg->btf_id);
+	if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, 0, field->list_head.btf,
+				  field->list_head.value_btf_id, true)) {
+		verbose(env, "operation on bpf_list_head expects arg#1 bpf_list_node at offset=%d "
+			"in struct %s, but arg is at offset=%d in struct %s\n",
+			field->list_head.node_offset, btf_name_by_offset(field->list_head.btf, et->name_off),
+			list_node_off, btf_name_by_offset(reg->btf, t->name_off));
+		return -EINVAL;
+	}
+
+	if (list_node_off != field->list_head.node_offset) {
+		verbose(env, "arg#1 offset=%d, but expected bpf_list_node at offset=%d in struct %s\n",
+			list_node_off, field->list_head.node_offset,
+			btf_name_by_offset(field->list_head.btf, et->name_off));
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta)
 {
 	const char *func_name = meta->func_name, *ref_tname;
@@ -8336,6 +8554,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			break;
 		case KF_ARG_PTR_TO_KPTR:
 		case KF_ARG_PTR_TO_DYNPTR:
+		case KF_ARG_PTR_TO_LIST_HEAD:
+		case KF_ARG_PTR_TO_LIST_NODE:
 		case KF_ARG_PTR_TO_MEM:
 		case KF_ARG_PTR_TO_MEM_SIZE:
 			/* Trusted by default */
@@ -8400,6 +8620,33 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				return -EINVAL;
 			}
 			break;
+		case KF_ARG_PTR_TO_LIST_HEAD:
+			if (reg->type != PTR_TO_MAP_VALUE &&
+			    reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
+				verbose(env, "arg#%d expected pointer to map value or allocated object\n", i);
+				return -EINVAL;
+			}
+			if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC) && !reg->ref_obj_id) {
+				verbose(env, "allocated object must be referenced\n");
+				return -EINVAL;
+			}
+			ret = process_kf_arg_ptr_to_list_head(env, reg, regno, meta);
+			if (ret < 0)
+				return ret;
+			break;
+		case KF_ARG_PTR_TO_LIST_NODE:
+			if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
+				verbose(env, "arg#%d expected pointer to allocated object\n", i);
+				return -EINVAL;
+			}
+			if (!reg->ref_obj_id) {
+				verbose(env, "allocated object must be referenced\n");
+				return -EINVAL;
+			}
+			ret = process_kf_arg_ptr_to_list_node(env, reg, regno, meta);
+			if (ret < 0)
+				return ret;
+			break;
 		case KF_ARG_PTR_TO_BTF_ID:
 			/* Only base_type is checked, further checks are done here */
 			if (reg->type != PTR_TO_BTF_ID &&
@@ -8568,6 +8815,15 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 				env->insn_aux_data[insn_idx].kptr_struct_meta =
 					btf_find_struct_meta(meta.arg_obj_drop.btf,
 							     meta.arg_obj_drop.btf_id);
+			} else if (meta.func_id == special_kfunc_list[KF_bpf_list_pop_front] ||
+				   meta.func_id == special_kfunc_list[KF_bpf_list_pop_back]) {
+				struct btf_field *field = meta.arg_list_head.field;
+
+				mark_reg_known_zero(env, regs, BPF_REG_0);
+				regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ALLOC;
+				regs[BPF_REG_0].btf = field->list_head.btf;
+				regs[BPF_REG_0].btf_id = field->list_head.value_btf_id;
+				regs[BPF_REG_0].off = field->list_head.node_offset;
 			} else {
 				verbose(env, "kernel function %s unhandled dynamic return type\n",
 					meta.func_name);
@@ -13264,11 +13520,14 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
-				if (env->cur_state->active_lock.ptr &&
-				    (insn->src_reg == BPF_PSEUDO_CALL ||
-				     insn->imm != BPF_FUNC_spin_unlock)) {
-					verbose(env, "function calls are not allowed while holding a lock\n");
-					return -EINVAL;
+				if (env->cur_state->active_lock.ptr) {
+					if ((insn->src_reg == BPF_REG_0 && insn->imm != BPF_FUNC_spin_unlock) ||
+					    (insn->src_reg == BPF_PSEUDO_CALL) ||
+					    (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
+					     (insn->off != 0 || !is_bpf_list_api_kfunc(insn->imm)))) {
+						verbose(env, "function calls are not allowed while holding a lock\n");
+						return -EINVAL;
+					}
 				}
 				if (insn->src_reg == BPF_PSEUDO_CALL)
 					err = check_func_call(env, insn, &env->insn_idx);
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 8473395a11af..d6b143275e82 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -35,4 +35,32 @@ extern void bpf_obj_drop_impl(void *kptr, void *meta) __ksym;
 /* Convenience macro to wrap over bpf_obj_drop_impl */
 #define bpf_obj_drop(kptr) bpf_obj_drop_impl(kptr, NULL)
 
+/* Description
+ *	Add a new entry to the beginning of the BPF linked list.
+ * Returns
+ *	Void.
+ */
+extern void bpf_list_push_front(struct bpf_list_head *head, struct bpf_list_node *node) __ksym;
+
+/* Description
+ *	Add a new entry to the end of the BPF linked list.
+ * Returns
+ *	Void.
+ */
+extern void bpf_list_push_back(struct bpf_list_head *head, struct bpf_list_node *node) __ksym;
+
+/* Description
+ *	Remove the entry at the beginning of the BPF linked list.
+ * Returns
+ *	Pointer to bpf_list_node of deleted entry, or NULL if list is empty.
+ */
+extern struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head) __ksym;
+
+/* Description
+ *	Remove the entry at the end of the BPF linked list.
+ * Returns
+ *	Pointer to bpf_list_node of deleted entry, or NULL if list is empty.
+ */
+extern struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head) __ksym;
+
 #endif
-- 
2.38.1

