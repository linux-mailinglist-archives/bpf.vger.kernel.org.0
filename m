Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5029862036E
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 00:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbiKGXLT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 18:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiKGXLJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 18:11:09 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F35F2018E
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 15:11:08 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id y13so12198002pfp.7
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 15:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ITQNdhUhnSfBbvMIXpsOt/p8d9papIohbLxaNonPtE=;
        b=DO0Xu7kOd4RHfOgOV8V5pyRSIjDydtKmy0b5c0bMYmblYN7EOWNVH4F5LcsIzfdIv3
         Tc9mVh97CE4uVFzGybCi080qGdtzPso/C41tHo39w8tFeRHwOddv5KSH88ilaTbgLEIb
         Fm5+4eG6yXb4RwHm1sEN7NiGqKOkkGIyfwDx7df3+g3YPX1txr27TXz+hHUFN6y3dZ01
         poryoWnK3y2E0/gLTr7MND7YAskIeYHvF5OG2hlM6TfQgFOO7RoPmKe3BCklk+9gEowm
         0aGn8MGWAdDtlU/G60Q8cDPIbIKecnLYHSCKPgiu9khXk9d/inHKyXPEaLYfmk18IiOD
         E9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ITQNdhUhnSfBbvMIXpsOt/p8d9papIohbLxaNonPtE=;
        b=RdjhIN1yicrDCRjw7ZTeCQiQk5RiA6Wn1UJSg71fKlGJfbZNN5CWjcN5wl+U5QQbiZ
         sfblveX2snM8YBtdJLoyBLcspyu+8a47F3aMtDZjhoGvM4hu4ymKvg+mxQ3bzxUbEGA2
         zfWzo/7CuANSfuun8usG54GMr5moQsudQ3NZnkLvS2VxmuCXiIgGQm5HMWs1CmHAcR+M
         KlUg6AB+D0YSKPm5M2oxKfqN3BDcdVHmncMtLB8l/EWEGS7NiFLDnw9/YQVQJH6D9EVH
         v/C2p03c3XH3SGEhJh+pkoOQQzyNcGXEUKbiDKq01+qcouovqrXQY33DuHcEdSWn/li0
         rNdw==
X-Gm-Message-State: ACrzQf2Er3KsOB7PoqidFLKscRDZ+tcot+TViLJVvEg5dj0zVk/Djf3K
        umD/vZ3kxHFZK1QjgJhvCTFVfKUuiB6bNg==
X-Google-Smtp-Source: AMsMyM4bIxwWSskPZlC3Sfc+QACbI1NUVpMzScSo4qkYj0JS3vENgwL9h95hQi+8exjM0Ub7N/0RlA==
X-Received: by 2002:a05:6a00:190a:b0:56c:123e:3e61 with SMTP id y10-20020a056a00190a00b0056c123e3e61mr52718785pfi.47.1667862667477;
        Mon, 07 Nov 2022 15:11:07 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id d67-20020a621d46000000b00562a237179esm5023408pfd.131.2022.11.07.15.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:11:07 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v5 19/25] bpf: Introduce single ownership BPF linked list API
Date:   Tue,  8 Nov 2022 04:39:44 +0530
Message-Id: <20221107230950.7117-20-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107230950.7117-1-memxor@gmail.com>
References: <20221107230950.7117-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=20800; i=memxor@gmail.com; h=from:subject; bh=0MYi1Wqh3El18Xn8pz5nK7tHNjmWQ8exAupN4LA1hLI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjaY+3v++S9UlNwNsrlQ0tnE75adm8nfPSpCGU7hWh 3RPp8PWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2mPtwAKCRBM4MiGSL8RykQlEA CCTn8HoQvLceookEKTGpe6BuhEFxE6G71RK1aOhNsrJyhXSa3HToFWrtNwfT25ixq9EF1ZN+w1LRpy SfZwdxLoBKM9FYTJw9vgDOJiIfh0RjqVO9BZbTRj91EEFXgiBZdL0PN9msADpxuaSCSxu4lg5TS74T N+Ysq3v7DfPhqaG53591PCw0TnFQHY38AesoiRcXJzEUYtMEPoo6V6FNzwFuC6iiPLKMimyY+J5R3b QHZ3/FOBE/sstxqPhAhYSMW3jmXjjiXD82D9cwFP7vksU1TBawljVtZGceSRVNpJlIpR6HTCsKCjmm IL8cQ4OpBOodziVdJQoF/aoJXrZbU97EF/5wY3pKXOhcIEfclbf7LvYvL8Poz1QQa9Uj0MEQAZg5NX ABQb6G13foHYDGePj4e7D7+B03Ao57MkEM3kyGC3XiONV7xrplAlcmefj8aTHUedTGnrF7sMHX64NT Rbyrf5KOxi4L6mBP9FzWSzcuCy7YfIdDOjv9HGjRod9DDyfDmx3PlJERYPIBwRUboOb+DfKC65ZPaT V2aEl9vY4oKuZ/AR9EKgk9bQmKmDsQ0d70/qTgXnU6DZIPbBDJo/Cd0HMkTp8M8nCQZZU7EZtAS0N8 d5xIKO0fkiQwLQaWlc0ZtXJwrzqoxcWLO5y9YbWUSo3Qr3j8AaPI0milYlqw==
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
 kernel/bpf/verifier.c                         | 292 +++++++++++++++++-
 .../testing/selftests/bpf/bpf_experimental.h  |  28 ++
 3 files changed, 361 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 02045f6a6ad5..461e0c3174c6 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1780,6 +1780,50 @@ void bpf_obj_drop_impl(void *p__lkptr, void *meta__ign)
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
index abcb23a4c6fc..5b87ef859046 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7886,6 +7886,9 @@ struct bpf_kfunc_call_arg_meta {
 		struct btf *btf;
 		u32 btf_id;
 	} arg_obj_drop;
+	struct {
+		struct btf_field *field;
+	} arg_list_head;
 };
 
 static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta)
@@ -7996,13 +7999,17 @@ static bool is_kfunc_arg_ret_buf_size(const struct btf *btf,
 
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
@@ -8015,7 +8022,22 @@ static bool is_kfunc_arg_dynptr(const struct btf *btf,
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
@@ -8072,6 +8094,8 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_LOCAL_BTF_ID,  /* Local kptr */
 	KF_ARG_PTR_TO_KPTR_STRONG,   /* PTR_TO_KPTR but type specific */
 	KF_ARG_PTR_TO_DYNPTR,
+	KF_ARG_PTR_TO_LIST_HEAD,
+	KF_ARG_PTR_TO_LIST_NODE,
 	KF_ARG_PTR_TO_BTF_ID,	     /* Also covers reg2btf_ids conversions */
 	KF_ARG_PTR_TO_MEM,
 	KF_ARG_PTR_TO_MEM_SIZE,	     /* Size derived from next argument, skip it */
@@ -8080,16 +8104,28 @@ enum kfunc_ptr_arg_type {
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
@@ -8132,6 +8168,12 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
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
@@ -8227,6 +8269,194 @@ static int process_kf_arg_ptr_to_kptr_strong(struct bpf_verifier_env *env,
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
+ * local kptrs is the reg->btf pointer.
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
+ * In case of local kptrs, active_lock.ptr is the reg->btf, and the reg->id is a
+ * unique ID preserved after the NULL pointer check on the local kptr after its
+ * allocation using bpf_obj_new. Each allocation receives a new reg->id.
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
+	struct btf_record *rec = NULL;
+	struct btf_field *field;
+	u32 list_head_off;
+
+	if (meta->btf != btf_vmlinux || !is_bpf_list_api_kfunc(meta->func_id)) {
+		verbose(env, "verifier internal error: bpf_list_head argument for unknown kfunc\n");
+		return -EFAULT;
+	}
+
+	if (reg->type == PTR_TO_MAP_VALUE) {
+		rec = reg->map_ptr->record;
+	} else /* PTR_TO_BTF_ID | MEM_ALLOC */ {
+		struct btf_struct_meta *meta;
+
+		meta = btf_find_struct_meta(reg->btf, reg->btf_id);
+		if (!meta) {
+			verbose(env, "bpf_list_head not found for local kptr\n");
+			return -EINVAL;
+		}
+		rec = meta->record;
+	}
+
+	if (!tnum_is_const(reg->var_off)) {
+		verbose(env,
+			"R%d doesn't have constant offset. bpf_list_head has to be at the constant offset\n",
+			regno);
+		return -EINVAL;
+	}
+
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
+	struct btf_struct_meta *struct_meta;
+	struct btf_field *field;
+	struct btf_record *rec;
+	u32 list_node_off;
+
+	if (meta->btf != btf_vmlinux ||
+	    (meta->func_id != special_kfunc_list[KF_bpf_list_push_front] &&
+	     meta->func_id != special_kfunc_list[KF_bpf_list_push_back])) {
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
+	struct_meta = btf_find_struct_meta(reg->btf, reg->btf_id);
+	if (!struct_meta) {
+		verbose(env, "bpf_list_node not found for local kptr\n");
+		return -EINVAL;
+	}
+	rec = struct_meta->record;
+
+	list_node_off = reg->off + reg->var_off.value;
+	field = btf_record_find(rec, list_node_off, BPF_LIST_NODE);
+	if (!field || field->offset != list_node_off) {
+		verbose(env, "bpf_list_node not found at offset=%u\n", list_node_off);
+		return -EINVAL;
+	}
+
+	field = meta->arg_list_head.field;
+
+	if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, 0, field->list_head.btf,
+				  field->list_head.value_btf_id, true)) {
+		verbose(env, "bpf_list_head value type does not match arg#1\n");
+		return -EINVAL;
+	}
+
+	if (list_node_off != field->list_head.node_offset) {
+		verbose(env, "arg#1 offset must be for bpf_list_node at off=%d\n",
+			field->list_head.node_offset);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta)
 {
 	const char *func_name = meta->func_name, *ref_tname;
@@ -8347,6 +8577,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			break;
 		case KF_ARG_PTR_TO_KPTR_STRONG:
 		case KF_ARG_PTR_TO_DYNPTR:
+		case KF_ARG_PTR_TO_LIST_HEAD:
+		case KF_ARG_PTR_TO_LIST_NODE:
 		case KF_ARG_PTR_TO_MEM:
 		case KF_ARG_PTR_TO_MEM_SIZE:
 			/* Trusted by default */
@@ -8411,6 +8643,33 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				return -EINVAL;
 			}
 			break;
+		case KF_ARG_PTR_TO_LIST_HEAD:
+			if (reg->type != PTR_TO_MAP_VALUE &&
+			    reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
+				verbose(env, "arg#%d expected pointer to map value or local kptr\n", i);
+				return -EINVAL;
+			}
+			if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC) && !reg->ref_obj_id) {
+				verbose(env, "local kptr must be referenced\n");
+				return -EINVAL;
+			}
+			ret = process_kf_arg_ptr_to_list_head(env, reg, regno, meta);
+			if (ret < 0)
+				return ret;
+			break;
+		case KF_ARG_PTR_TO_LIST_NODE:
+			if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
+				verbose(env, "arg#%d expected pointer to local kptr\n", i);
+				return -EINVAL;
+			}
+			if (!reg->ref_obj_id) {
+				verbose(env, "local kptr must be referenced\n");
+				return -EINVAL;
+			}
+			ret = process_kf_arg_ptr_to_list_node(env, reg, regno, meta);
+			if (ret < 0)
+				return ret;
+			break;
 		case KF_ARG_PTR_TO_BTF_ID:
 			/* Only base_type is checked, further checks are done here */
 			if (reg->type != PTR_TO_BTF_ID &&
@@ -8542,11 +8801,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		ptr_type = btf_type_skip_modifiers(desc_btf, t->type, &ptr_type_id);
 
 		if (meta.btf == btf_vmlinux && btf_id_set_contains(&special_kfunc_set, meta.func_id)) {
-			if (!btf_type_is_void(ptr_type)) {
-				verbose(env, "kernel function %s must have void * return type\n",
-					meta.func_name);
-				return -EINVAL;
-			}
 			if (meta.func_id == special_kfunc_list[KF_bpf_obj_new_impl]) {
 				const struct btf_type *ret_t;
 				struct btf *ret_btf;
@@ -8584,6 +8838,15 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -13262,11 +13525,14 @@ static int do_check(struct bpf_verifier_env *env)
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
index d145c93ea663..828dd868b658 100644
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

