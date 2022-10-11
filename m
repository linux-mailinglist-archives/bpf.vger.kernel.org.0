Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA39F5FAA17
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 03:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiJKB2B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 21:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiJKB16 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 21:27:58 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B3B11831
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:27:56 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id l1so11806774pld.13
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHX4f9tK/fxnCQEoiMkA9HYMPYFYWkaE/1/IKvZc+TI=;
        b=AY0p5kTKImevdC2PeIGTPfZO66FJRA7wd6gU5SgnIhVPY+7r+YYY9mBY6lXQ3D/8I3
         UhQQkLW4I6WiH3HM9cS7E34S+zPl+Uboj8bw+QLIvyPZw1khcEpImNajTXiQB9FI2opY
         Dwql6TJTom6sB+oV+0Zd5eeIAHwkV0pgcAswUA2DzcaK7wzJmatXFZSoQ1CJRv/T4lgp
         JFZbv7Rjotc09xF2xl3PzlgTckoIMTAPXZHL5E8EEhntaWTy2LsWeZDLJaLbhWiqQ2Z4
         l8xMGxnr78+r3chZtf8LnNsaY6BRhqFM/gbDCeMWT9VLUuJQsPnCVO5or+Tix2EjWYz5
         oS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHX4f9tK/fxnCQEoiMkA9HYMPYFYWkaE/1/IKvZc+TI=;
        b=mkZjuQ2ytwUbfIoE65MOm+HcrHZq5hnrN4LUsrkk+8/F1ybXMbPQf2MVAFOefp3kws
         LttIlk7piph1xp+Ju5F98wE1O1HHbxj/EGZjdPdtjhtkNmA8Huv2lLBXHgWu6gloCXuh
         jrPfoDic605rmecF17oz9dr7RW6JZBbGIlj1gEAC44Xqs/7O5sHQlCi/7p3Ug3k+myqe
         YLaTNiH33KdMyb9V2pjdznlZaAXIa/M3PE9vM50t42CZQC8kjjfa9bIyEibQeCru/n8d
         j7QC+/0fBZXhHWbe/hOtT41zdZC2fff+TN5toJ0waVo0eEy8RYfmcxS9GOSZgbKn+N7G
         btkw==
X-Gm-Message-State: ACrzQf2UlQr2aX7v6mSaOqhklzWuNmBnAsTzVgfoB6J3LiWHbSxMsoJW
        JrTdN2iZKItvXOWSqHw+J7bC08oGOc4y9A==
X-Google-Smtp-Source: AMsMyM6xqgw+45uw2e1ZdnuBdq9FXp8cD7Mu7vf1jVQBPscLVTsa0v7YcvhBZFg9qlig4SyPqqGZUQ==
X-Received: by 2002:a17:903:2311:b0:183:a88a:7d1 with SMTP id d17-20020a170903231100b00183a88a07d1mr935438plh.10.1665451675534;
        Mon, 10 Oct 2022 18:27:55 -0700 (PDT)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id p23-20020a170902a41700b00178a8f4d4f2sm7257109plq.74.2022.10.10.18.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 18:27:55 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH bpf-next v1 22/25] bpf: Introduce single ownership BPF linked list API
Date:   Tue, 11 Oct 2022 06:52:37 +0530
Message-Id: <20221011012240.3149-23-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011012240.3149-1-memxor@gmail.com>
References: <20221011012240.3149-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=22836; i=memxor@gmail.com; h=from:subject; bh=SvpZ3/2hZ9oDkebIHSafewyt2xpODO1cIqh5Yb2QRYY=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjRMUb3IuV0W7yuGQ8gSU4dCLVUEHi7ZU4uoa8Xkdb yjE69IiJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0TFGwAKCRBM4MiGSL8Rys7iEA Ck+y2SfzZneK9AgAq212kYrA9jeODaQH0FIqr6OXVO8XM0j9nXPKp/XIOHZOsNTEZuu9SpKKEtA1MN 2uhwkRYe0BJHQMouTB54Yf0b3Fh9mhi4Pxo4QF3SorFLXvbWcGCGtEiUQnddpBr/kY0lyrtq2XmBOG G6rX31FZNfFX92tjjeAYXgEO1kcG4mHrUuldSz35QgyOfKOBL9NepGK+vlMk4KEX1arTGpRflOoffs VsHidopyH9nf5BmSbYcABdiPHOfvLxbBIPhTBhLaSWkQHxUQCPUAxwfk4KFw5kHurZKOpQVBuVzxxs SwxKXF3hrEebx54PPNqRiNBWpZdWNTzjHsuy333PcoG68ixIq2Jyrx+FZQrkAmbUf6Yu4DaGx1XySW 8HOPAcAnk715sHSekkw0eigC/JpCdj/QzH7EgiHfUd3UUtfgnbpp2Ow40k8AR3Zm87ooi1Lr7O+bLc bchIZWUrdnvInDH6fRDY0ValeS1ZzwHLpRsZK8OOGmnEEPlekWtVsUe3aoilwt+bqwGJT/3Q82GH6h B13/mdkqE3/KDR2PGNs6OKDPmZvuwjlCY8R5CHcttcoSFLe+Psz7M4OHtzUvHdV9Y/lIOuGJlY4ymR BGf1Z68N/U9Gyjv12vmcgOjRRjCal7k2aq3jCv7IYXYDp08MN6kVWfQn8sxg==
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
bpf_list_head. Future patches will extend the same infrastructure to
have different flavors with varying protection domains and visibility
(e.g. percpu variant with local_t protection, usable in NMI progs).

The following functions are added to kick things off:

bpf_list_add
bpf_list_add_tail
bpf_list_del
bpf_list_del_tail

The lock protecting the bpf_list_head needs to be taken for all
operations.

Once a node has been added to the list, it's pointer changes to
PTR_UNTRUSTED. However, it is only released once the lock protecting the
list is unlocked. For such local kptrs with PTR_UNTRUSTED set but an
active ref_obj_id, it is still permitted to read and write to them as
long as the lock is held.

bpf_list_del and bpf_list_del_tail delete the first or last item of the
list respectively, and return pointer to the element at the list_node
offset. The user can then use container_of style macro to get the actual
entry type. The verifier however statically knows the actual type, so
the safety properties are still preserved.

With these additions, programs can now manage their own linked lists and
store their objects in them.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h                  |   5 +
 kernel/bpf/helpers.c                          |  48 +++
 kernel/bpf/verifier.c                         | 344 ++++++++++++++++--
 .../testing/selftests/bpf/bpf_experimental.h  |  28 ++
 4 files changed, 391 insertions(+), 34 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 0cc4679f3f42..01d3dd76b224 100644
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
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 90e3000d1c3a..5cbd5a02a460 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1765,6 +1765,50 @@ void bpf_kptr_drop_impl(void *p__lkptr, void *meta__ign)
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
+void bpf_list_add(struct bpf_list_node *node, struct bpf_list_head *head)
+{
+	return __bpf_list_add(node, head, false);
+}
+
+void bpf_list_add_tail(struct bpf_list_node *node, struct bpf_list_head *head)
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
+struct bpf_list_node *bpf_list_del(struct bpf_list_head *head)
+{
+	return __bpf_list_del(head, false);
+}
+
+struct bpf_list_node *bpf_list_del_tail(struct bpf_list_head *head)
+{
+	return __bpf_list_del(head, true);
+}
+
 __diag_pop();
 
 BTF_SET8_START(generic_btf_ids)
@@ -1773,6 +1817,10 @@ BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
 #endif
 BTF_ID_FLAGS(func, bpf_kptr_new_impl, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_kptr_drop_impl, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_list_add)
+BTF_ID_FLAGS(func, bpf_list_add_tail)
+BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_list_del_tail, KF_ACQUIRE | KF_RET_NULL)
 BTF_SET8_END(generic_btf_ids)
 
 static const struct btf_kfunc_id_set generic_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ee3b5b1be622..7c2bb3f6301d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5485,7 +5485,9 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 			cur->active_spin_lock_ptr = btf;
 		cur->active_spin_lock_id = reg->id;
 	} else {
+		struct bpf_func_state *fstate = cur_func(env);
 		void *ptr;
+		int i;
 
 		if (map)
 			ptr = map;
@@ -5503,6 +5505,16 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 		}
 		cur->active_spin_lock_ptr = NULL;
 		cur->active_spin_lock_id = 0;
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
@@ -7697,6 +7709,16 @@ struct bpf_kfunc_call_arg_meta {
 		struct btf *btf;
 		u32 btf_id;
 	} arg_kptr_drop;
+	struct {
+		struct btf_field *field;
+	} arg_list_head;
+	struct {
+		struct btf_field *field;
+		struct btf *reg_btf;
+		u32 reg_btf_id;
+		u32 reg_offset;
+		u32 reg_ref_obj_id;
+	} arg_list_node;
 };
 
 static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta)
@@ -7807,13 +7829,17 @@ static bool is_kfunc_arg_ret_buf_size(const struct btf *btf,
 
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
@@ -7826,7 +7852,22 @@ static bool is_kfunc_arg_dynptr(const struct btf *btf,
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
@@ -7881,9 +7922,11 @@ static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
 enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_CTX,
 	KF_ARG_PTR_TO_LOCAL_BTF_ID,  /* Local kptr */
-	KF_ARG_PTR_TO_BTF_ID,	     /* Also covers reg2btf_ids conversions */
 	KF_ARG_PTR_TO_KPTR_STRONG,   /* PTR_TO_KPTR but type specific */
 	KF_ARG_PTR_TO_DYNPTR,
+	KF_ARG_PTR_TO_LIST_HEAD,
+	KF_ARG_PTR_TO_LIST_NODE,
+	KF_ARG_PTR_TO_BTF_ID,	     /* Also covers reg2btf_ids conversions */
 	KF_ARG_PTR_TO_MEM,
 	KF_ARG_PTR_TO_MEM_SIZE,	     /* Size derived from next argument, skip it */
 };
@@ -7891,16 +7934,28 @@ enum kfunc_ptr_arg_type {
 enum special_kfunc_type {
 	KF_bpf_kptr_new_impl,
 	KF_bpf_kptr_drop_impl,
+	KF_bpf_list_add,
+	KF_bpf_list_add_tail,
+	KF_bpf_list_del,
+	KF_bpf_list_del_tail,
 };
 
 BTF_SET_START(special_kfunc_set)
 BTF_ID(func, bpf_kptr_new_impl)
 BTF_ID(func, bpf_kptr_drop_impl)
+BTF_ID(func, bpf_list_add)
+BTF_ID(func, bpf_list_add_tail)
+BTF_ID(func, bpf_list_del)
+BTF_ID(func, bpf_list_del_tail)
 BTF_SET_END(special_kfunc_set)
 
 BTF_ID_LIST(special_kfunc_list)
 BTF_ID(func, bpf_kptr_new_impl)
 BTF_ID(func, bpf_kptr_drop_impl)
+BTF_ID(func, bpf_list_add)
+BTF_ID(func, bpf_list_add_tail)
+BTF_ID(func, bpf_list_del)
+BTF_ID(func, bpf_list_del_tail)
 
 enum kfunc_ptr_arg_type get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 						struct bpf_kfunc_call_arg_meta *meta,
@@ -7926,15 +7981,6 @@ enum kfunc_ptr_arg_type get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (is_kfunc_arg_local_kptr(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_LOCAL_BTF_ID;
 
-	if ((base_type(reg->type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
-		if (!btf_type_is_struct(ref_t)) {
-			verbose(env, "kernel function %s args#%d pointer type %s %s is not supported\n",
-				meta->func_name, argno, btf_type_str(ref_t), ref_tname);
-			return -EINVAL;
-		}
-		return KF_ARG_PTR_TO_BTF_ID;
-	}
-
 	if (is_kfunc_arg_kptr_get(meta, argno)) {
 		if (!btf_type_is_ptr(ref_t)) {
 			verbose(env, "arg#0 BTF type must be a double pointer for kptr_get kfunc\n");
@@ -7953,6 +7999,21 @@ enum kfunc_ptr_arg_type get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (is_kfunc_arg_dynptr(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_DYNPTR;
 
+	if (is_kfunc_arg_list_head(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_LIST_HEAD;
+
+	if (is_kfunc_arg_list_node(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_LIST_NODE;
+
+	if ((base_type(reg->type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
+		if (!btf_type_is_struct(ref_t)) {
+			verbose(env, "kernel function %s args#%d pointer type %s %s is not supported\n",
+				meta->func_name, argno, btf_type_str(ref_t), ref_tname);
+			return -EINVAL;
+		}
+		return KF_ARG_PTR_TO_BTF_ID;
+	}
+
 	if (argno + 1 < nargs && is_kfunc_arg_mem_size(meta->btf, &args[argno + 1], &regs[regno + 1]))
 		arg_mem_size = true;
 
@@ -8039,6 +8100,181 @@ static int process_kf_arg_ptr_to_kptr_strong(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static bool ref_obj_id_set_release_on_unlock(struct bpf_verifier_env *env, u32 ref_obj_id)
+{
+	struct bpf_func_state *state = cur_func(env);
+	struct bpf_reg_state *reg;
+	int i;
+
+	/* bpf_spin_lock only allows calling list_add and list_del, no BPF
+	 * subprogs, no global functions, so this acquired refs state is the
+	 * same one we will use to find registers to kill on bpf_spin_unlock.
+	 */
+	WARN_ON_ONCE(!ref_obj_id);
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
+static bool is_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+{
+	void *ptr;
+	u32 id;
+
+	switch ((int)reg->type) {
+	case PTR_TO_MAP_VALUE:
+		ptr = reg->map_ptr;
+		break;
+	case PTR_TO_BTF_ID | MEM_TYPE_LOCAL:
+		ptr = reg->btf;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return false;
+	}
+	id = reg->id;
+
+	return env->cur_state->active_spin_lock_ptr == ptr &&
+	       env->cur_state->active_spin_lock_id == id;
+}
+
+static int process_kf_arg_ptr_to_list_head(struct bpf_verifier_env *env,
+					   struct bpf_reg_state *reg,
+					   u32 regno,
+					   struct bpf_kfunc_call_arg_meta *meta)
+{
+	struct btf_type_fields *tab = NULL;
+	struct btf_field *field;
+	u32 list_head_off;
+
+	if (meta->btf != btf_vmlinux ||
+	    (meta->func_id != special_kfunc_list[KF_bpf_list_add] &&
+	     meta->func_id != special_kfunc_list[KF_bpf_list_add_tail] &&
+	     meta->func_id != special_kfunc_list[KF_bpf_list_del] &&
+	     meta->func_id != special_kfunc_list[KF_bpf_list_del_tail])) {
+		verbose(env, "verifier internal error: bpf_list_head argument for unknown kfunc\n");
+		return -EFAULT;
+	}
+
+	if (reg->type == PTR_TO_MAP_VALUE) {
+		tab = reg->map_ptr->fields_tab;
+	} else /* PTR_TO_BTF_ID | MEM_TYPE_LOCAL */ {
+		struct btf_struct_meta *meta;
+
+		meta = btf_find_struct_meta(reg->btf, reg->btf_id);
+		if (!meta) {
+			verbose(env, "bpf_list_head not found for local kptr\n");
+			return -EINVAL;
+		}
+		tab = meta->fields_tab;
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
+	field = btf_type_fields_find(tab, list_head_off, BPF_LIST_HEAD);
+	if (!field) {
+		verbose(env, "bpf_list_head not found at offset=%u\n", list_head_off);
+		return -EINVAL;
+	}
+
+	/* All functions require bpf_list_head to be protected using a bpf_spin_lock */
+	if (!is_reg_allocation_locked(env, reg)) {
+		verbose(env, "bpf_spin_lock at off=%d must be held for manipulating bpf_list_head\n",
+			tab->spin_lock_off);
+		return -EINVAL;
+	}
+
+	if (meta->func_id == special_kfunc_list[KF_bpf_list_add] ||
+	    meta->func_id == special_kfunc_list[KF_bpf_list_add_tail]) {
+		if (!btf_struct_ids_match(&env->log, meta->arg_list_node.reg_btf,
+					  meta->arg_list_node.reg_btf_id, 0,
+					  field->list_head.btf, field->list_head.value_btf_id, true)) {
+			verbose(env, "bpf_list_head value type does not match arg#0\n");
+			return -EINVAL;
+		}
+		if (meta->arg_list_node.reg_offset != field->list_head.node_offset) {
+			verbose(env, "arg#0 offset must be for bpf_list_node at off=%d\n",
+				field->list_head.node_offset);
+			return -EINVAL;
+		}
+		/* Set arg#0 for expiration after unlock */
+		ref_obj_id_set_release_on_unlock(env, meta->arg_list_node.reg_ref_obj_id);
+	} else {
+		if (meta->arg_list_head.field) {
+			verbose(env, "verifier internal error: repeating bpf_list_head arg\n");
+			return -EFAULT;
+		}
+		meta->arg_list_head.field = field;
+	}
+	return 0;
+}
+
+static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
+					   struct bpf_reg_state *reg,
+					   u32 regno,
+					   struct bpf_kfunc_call_arg_meta *meta)
+{
+	struct btf_struct_meta *struct_meta;
+	struct btf_type_fields *tab;
+	struct btf_field *field;
+	u32 list_node_off;
+
+	if (meta->btf != btf_vmlinux ||
+	    (meta->func_id != special_kfunc_list[KF_bpf_list_add] &&
+	     meta->func_id != special_kfunc_list[KF_bpf_list_add_tail])) {
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
+	tab = struct_meta->fields_tab;
+
+	list_node_off = reg->off + reg->var_off.value;
+	field = btf_type_fields_find(tab, list_node_off, BPF_LIST_NODE);
+	if (!field || field->offset != list_node_off) {
+		verbose(env, "bpf_list_node not found at offset=%u\n", list_node_off);
+		return -EINVAL;
+	}
+	if (meta->arg_list_node.field) {
+		verbose(env, "verifier internal error: repeating bpf_list_node arg\n");
+		return -EFAULT;
+	}
+	meta->arg_list_node.field = field;
+	meta->arg_list_node.reg_btf = reg->btf;
+	meta->arg_list_node.reg_btf_id = reg->btf_id;
+	meta->arg_list_node.reg_offset = list_node_off;
+	meta->arg_list_node.reg_ref_obj_id = reg->ref_obj_id;
+	return 0;
+}
+
 static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta)
 {
 	const char *func_name = meta->func_name, *ref_tname;
@@ -8157,6 +8393,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			break;
 		case KF_ARG_PTR_TO_KPTR_STRONG:
 		case KF_ARG_PTR_TO_DYNPTR:
+		case KF_ARG_PTR_TO_LIST_HEAD:
+		case KF_ARG_PTR_TO_LIST_NODE:
 		case KF_ARG_PTR_TO_MEM:
 		case KF_ARG_PTR_TO_MEM_SIZE:
 			/* Trusted by default */
@@ -8194,17 +8432,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				meta->arg_kptr_drop.btf_id = reg->btf_id;
 			}
 			break;
-		case KF_ARG_PTR_TO_BTF_ID:
-			/* Only base_type is checked, further checks are done here */
-			if (reg->type != PTR_TO_BTF_ID &&
-			    (!reg2btf_ids[base_type(reg->type)] || type_flag(reg->type))) {
-				verbose(env, "arg#%d expected pointer to btf or socket\n", i);
-				return -EINVAL;
-			}
-			ret = process_kf_arg_ptr_to_btf_id(env, reg, ref_t, ref_tname, ref_id, meta, i);
-			if (ret < 0)
-				return ret;
-			break;
 		case KF_ARG_PTR_TO_KPTR_STRONG:
 			if (reg->type != PTR_TO_MAP_VALUE) {
 				verbose(env, "arg#0 expected pointer to map value\n");
@@ -8232,6 +8459,44 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				return -EINVAL;
 			}
 			break;
+		case KF_ARG_PTR_TO_LIST_HEAD:
+			if (reg->type != PTR_TO_MAP_VALUE &&
+			    reg->type != (PTR_TO_BTF_ID | MEM_TYPE_LOCAL)) {
+				verbose(env, "arg#%d expected pointer to map value or local kptr\n", i);
+				return -EINVAL;
+			}
+			if (reg->type == (PTR_TO_BTF_ID | MEM_TYPE_LOCAL) && !reg->ref_obj_id) {
+				verbose(env, "local kptr must be referenced\n");
+				return -EINVAL;
+			}
+			ret = process_kf_arg_ptr_to_list_head(env, reg, regno, meta);
+			if (ret < 0)
+				return ret;
+			break;
+		case KF_ARG_PTR_TO_LIST_NODE:
+			if (reg->type != (PTR_TO_BTF_ID | MEM_TYPE_LOCAL)) {
+				verbose(env, "arg#%d expected point to local kptr\n", i);
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
+		case KF_ARG_PTR_TO_BTF_ID:
+			/* Only base_type is checked, further checks are done here */
+			if (reg->type != PTR_TO_BTF_ID &&
+			    (!reg2btf_ids[base_type(reg->type)] || type_flag(reg->type))) {
+				verbose(env, "arg#%d expected pointer to btf or socket\n", i);
+				return -EINVAL;
+			}
+			ret = process_kf_arg_ptr_to_btf_id(env, reg, ref_t, ref_tname, ref_id, meta, i);
+			if (ret < 0)
+				return ret;
+			break;
 		case KF_ARG_PTR_TO_MEM:
 			resolve_ret = btf_resolve_size(btf, ref_t, &type_size);
 			if (IS_ERR(resolve_ret)) {
@@ -8352,11 +8617,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		ptr_type = btf_type_skip_modifiers(desc_btf, t->type, &ptr_type_id);
 
 		if (meta.btf == btf_vmlinux && btf_id_set_contains(&special_kfunc_set, meta.func_id)) {
-			if (!btf_type_is_void(ptr_type)) {
-				verbose(env, "kernel function %s must have void * return type\n",
-					meta.func_name);
-				return -EINVAL;
-			}
 			if (meta.func_id == special_kfunc_list[KF_bpf_kptr_new_impl]) {
 				const struct btf_type *ret_t;
 				struct btf *ret_btf;
@@ -8394,6 +8654,15 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 				env->insn_aux_data[insn_idx].kptr_struct_meta =
 					btf_find_struct_meta(meta.arg_kptr_drop.btf,
 							     meta.arg_kptr_drop.btf_id);
+			} else if (meta.func_id == special_kfunc_list[KF_bpf_list_del] ||
+				   meta.func_id == special_kfunc_list[KF_bpf_list_del_tail]) {
+				struct btf_field *field = meta.arg_list_head.field;
+
+				mark_reg_known_zero(env, regs, BPF_REG_0);
+				regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_TYPE_LOCAL;
+				regs[BPF_REG_0].btf = field->list_head.btf;
+				regs[BPF_REG_0].btf_id = field->list_head.value_btf_id;
+				regs[BPF_REG_0].off = field->list_head.node_offset;
 			} else {
 				verbose(env, "kernel function %s unhandled dynamic return type\n",
 					meta.func_name);
@@ -13062,11 +13331,18 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
-				if (env->cur_state->active_spin_lock_ptr &&
-				    (insn->src_reg == BPF_PSEUDO_CALL ||
-				     insn->imm != BPF_FUNC_spin_unlock)) {
-					verbose(env, "function calls are not allowed while holding a lock\n");
-					return -EINVAL;
+				if (env->cur_state->active_spin_lock_ptr) {
+					if ((insn->src_reg == BPF_REG_0 && insn->imm != BPF_FUNC_spin_unlock) ||
+					    (insn->src_reg == BPF_PSEUDO_CALL) ||
+					    (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
+					     (insn->off != 0 ||
+					      (insn->imm != special_kfunc_list[KF_bpf_list_add] &&
+					       insn->imm != special_kfunc_list[KF_bpf_list_add_tail] &&
+					       insn->imm != special_kfunc_list[KF_bpf_list_del] &&
+					       insn->imm != special_kfunc_list[KF_bpf_list_del_tail])))) {
+						verbose(env, "function calls are not allowed while holding a lock\n");
+						return -EINVAL;
+					}
 				}
 				if (insn->src_reg == BPF_PSEUDO_CALL)
 					err = check_func_call(env, insn, &env->insn_idx);
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index c47d16f3e817..21b85cd721cb 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -52,4 +52,32 @@ extern void bpf_kptr_drop_impl(void *kptr, void *meta__ign) __ksym;
 /* Convenience macro to wrap over bpf_kptr_drop_impl */
 #define bpf_kptr_drop(kptr) bpf_kptr_drop_impl(kptr, NULL)
 
+/* Description
+ *	Add a new entry to the head of the BPF linked list.
+ * Returns
+ *	Void.
+ */
+extern void bpf_list_add(struct bpf_list_node *node, struct bpf_list_head *head) __ksym;
+
+/* Description
+ *	Add a new entry to the tail of the BPF linked list.
+ * Returns
+ *	Void.
+ */
+extern void bpf_list_add_tail(struct bpf_list_node *node, struct bpf_list_head *head) __ksym;
+
+/* Description
+ *	Remove the entry at head of the BPF linked list.
+ * Returns
+ *	Pointer to bpf_list_node of deleted entry, or NULL if list is empty.
+ */
+extern struct bpf_list_node *bpf_list_del(struct bpf_list_head *head) __ksym;
+
+/* Description
+ *	Remove the entry at tail of the BPF linked list.
+ * Returns
+ *	Pointer to bpf_list_node of deleted entry, or NULL if list is empty.
+ */
+extern struct bpf_list_node *bpf_list_del_tail(struct bpf_list_head *head) __ksym;
+
 #endif
-- 
2.34.1

