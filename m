Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6C2618856
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 20:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiKCTLu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 15:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiKCTLt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 15:11:49 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3001DA48
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 12:11:47 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id b5so2496323pgb.6
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 12:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNamiXD3t34nWv9OlqLM3poY7u5Mo73l/AuThXxskyo=;
        b=OOl84UN7LNzuHcQQmGS1ad69U9qLgB5GPctRrlBg6tqQrDelWt0cJxaxrAOjWn9fmM
         5TgPvbJ0ylekwVZCsPv9E8z1SXHfdXlBvNe2aph6U4SHRRjo5B5Zg2usvv/RmR78TPfB
         MxQr6qeTGyBvxuYtRhQ2S/Omh/+rDxX+PY1J6YamiLhoXJ8QIy+I71SthUMYehLu7g+x
         T+ovNKdEJpBILJRdsU1LAWDKu9OikoVmeuY3av0xgUpac7kMDZvTdCHAwup6mOUHSfd1
         islinTnBH/ShQOiHJSUUHb85IELbCZxfBwHpFoCx5xR+5YvpblgyQv5IAeMJd9lgtRZD
         TR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNamiXD3t34nWv9OlqLM3poY7u5Mo73l/AuThXxskyo=;
        b=7ja1PX+Tft0sKaFFZAOtsmHNxUciIrHq6xV2tfWsDO5PjH8MlMVBzAqiiWHuK8O5A+
         IopLi/afax71XCVGL9pvAWF67AkWLVCpTddZbroSnTBB7w1IIyDkZdcox3Kqe1do0J/J
         /hxrg2LUFmtk/+nm8aRIx2pmECFgVZR6d8pipmJcQZvL/lXbEZD1TN4h/8BtSOsp9zFD
         4UzG2bUk4pDzcuinaevhu9+UcS0TasI/4/4SWwwDaIDk4ykjNlZqbrLd8OFVe/CM4O2K
         oOaLuD4NbNAyAeUE4NleFMlCx9GNaKDOyVj5LU9I5zdetueu7DlDqtZh/Gwh4MG0O8OU
         xblA==
X-Gm-Message-State: ACrzQf1QMvZ703lSbbtA+zi4GSdH9BV1QbhOxhIN/YDxFUnTxgK7IivB
        AIKX+GO3htEkf5po5fo1XfE5sDIwatyjNg==
X-Google-Smtp-Source: AMsMyM5DeqrrvM4vUZi5vkMecGxnogCAGAS85s80KLFp1vWEIpSS7n1TNw/SGOS6uwW0YjHRYYpDWA==
X-Received: by 2002:a63:c14:0:b0:456:d887:c83 with SMTP id b20-20020a630c14000000b00456d8870c83mr27963878pgl.53.1667502706671;
        Thu, 03 Nov 2022 12:11:46 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902e74400b001869b988d93sm1013542plf.187.2022.11.03.12.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:11:46 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v4 22/24] bpf: Introduce single ownership BPF linked list API
Date:   Fri,  4 Nov 2022 00:40:11 +0530
Message-Id: <20221103191013.1236066-23-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103191013.1236066-1-memxor@gmail.com>
References: <20221103191013.1236066-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=24583; i=memxor@gmail.com; h=from:subject; bh=QH183cddsozIWY4gOKTShP4X6ltOnKvSXDlvjSpPqac=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjZBIBnVGbYvmhbvsG/yL7Z/auE14x3nA8ohvqWu96 cJRBVD6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2QSAQAKCRBM4MiGSL8RynU8D/ wL4toCvLJ3i+K0GBF01ZW0o9zacLi2Xwd8kIc6tuXQaKl6xwnLlukz/58J05rhV6u5Z/12f0bOjEup A3SN7EIHt5WQU5k5D1PLCsAuH1I+FrSLi7EaMnTCZF4g4837p1YMlWWVjCH1sNFysjxxhAZt7VlLQz pofGgsWSJQHKGz2urQftBbFIA6yWDSBgkbmxitWN553+nfg180kslUm9A8HC+N6DZ04CqhHmPN8R8V 22YTIdJ1Kl1+03FUQ06CDIzv84pksV2iDF5lvK67GfJIDf7mFh9ZJs0m0Og3jfSjLnxtG2iErW2xsE uUoHUHMgmWZYrJcwIyIJYgaFAK08sgpj4mZNErUsRp4jqtmrh2ymKzpqAGx1z0lmHrpt0OhyopPnQb kVkILtJPCrHQvywX93nJi2i3LbNHylQEO0mFdIsN5jfdpezJ/HYZ2rAE19FsIqeRXF7et4TJA1G5nY BaaHG4xQ0pFEjuwCtpcdAGkS51bfi4HNUKMZ+8l4OJ77I1kslEAzC6HKRhIJbly5DGKn0VMyCk55gS d6ZRen/oXtGn7xXocaDs3fglQ8nYto6d1/xRQu0FB7ptehekevzC5tZzSiRnbZOQI3fU6S7+Ev02Xu OjA2H9NqtUv1jKYd9HtU/bauF0H4oo2AXOxVr93jhYc9Qv7lXiFTXhonLwQQ==
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

bpf_list_push_front
bpf_list_push_back
bpf_list_pop_front
bpf_list_pop_back

The lock protecting the bpf_list_head needs to be taken for all
operations.

Once a node has been added to the list, it's pointer changes to
PTR_UNTRUSTED. However, it is only released once the lock protecting the
list is unlocked. For such local kptrs with PTR_UNTRUSTED set but an
active ref_obj_id, it is still permitted to read and write to them as
long as the lock is held.

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
 kernel/bpf/helpers.c                          |  50 ++-
 kernel/bpf/verifier.c                         | 377 ++++++++++++++++--
 .../testing/selftests/bpf/bpf_experimental.h  |  28 ++
 4 files changed, 425 insertions(+), 35 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1e9c782e0974..bde8f9e11132 100644
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
index a30f6573e805..0acd87ed22fc 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1774,6 +1774,50 @@ void bpf_obj_drop_impl(void *p__lkptr, void *meta__ign)
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
@@ -1781,7 +1825,11 @@ BTF_SET8_START(generic_btf_ids)
 BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
 #endif
 BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_kptr_drop_impl, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_obj_drop_impl, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_list_push_front)
+BTF_ID_FLAGS(func, bpf_list_push_back)
+BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
 BTF_SET8_END(generic_btf_ids)
 
 static const struct btf_kfunc_id_set generic_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 58e58678382a..c3675f858707 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5495,7 +5495,9 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 			cur->active_spin_lock_ptr = btf;
 		cur->active_spin_lock_id = reg->id;
 	} else {
+		struct bpf_func_state *fstate = cur_func(env);
 		void *ptr;
+		int i;
 
 		if (map)
 			ptr = map;
@@ -5513,6 +5515,16 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
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
@@ -7708,6 +7720,9 @@ struct bpf_kfunc_call_arg_meta {
 		struct btf *btf;
 		u32 btf_id;
 	} arg_obj_drop;
+	struct {
+		struct btf_field *field;
+	} arg_list_head;
 };
 
 static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta)
@@ -7818,13 +7833,17 @@ static bool is_kfunc_arg_ret_buf_size(const struct btf *btf,
 
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
@@ -7837,7 +7856,22 @@ static bool is_kfunc_arg_dynptr(const struct btf *btf,
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
@@ -7892,9 +7926,11 @@ static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
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
@@ -7902,16 +7938,28 @@ enum kfunc_ptr_arg_type {
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
@@ -7936,15 +7984,6 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
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
@@ -7963,6 +8002,21 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
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
 
@@ -8049,6 +8103,225 @@ static int process_kf_arg_ptr_to_kptr_strong(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static int ref_set_release_on_unlock(struct bpf_verifier_env *env, u32 ref_obj_id)
+{
+	struct bpf_func_state *state = cur_func(env);
+	struct bpf_reg_state *reg;
+	int i;
+
+	/* bpf_spin_lock only allows calling list_push and list_pop, no BPF
+	 * subprogs, no global functions, so this acquired refs state will
+	 * remain unchanged till we find registers to kill on bpf_spin_unlock.
+	 *
+	 * The acquired refs state is therefore not modified inside the
+	 * bpf_spin_lock critical section by any means, nor is it copied into
+	 * another frame as subprog calls are disallowed.
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
+/* Implementation details:
+ *
+ * Each register points to some region of memory, which we define as an
+ * allocation. Each allocation may embed a bpf_spin_lock which protects any
+ * special BPF objects (bpf_list_head, bpf_rb_root, etc.) part of the same
+ * allocation. The lock and the data it protects are co-located in the same
+ * memory region.
+ *
+ * Hence, everytime a register holds a pointer value pointing to such
+ * allocation, the verifier preserves a unique reg->id for it.
+ *
+ * The verifier remembers the lock 'class' and the lock 'id' whenever
+ * bpf_spin_lock is called.
+ *
+ * To enable this, lock state in the verifier captures two values:
+ *	active_spin_lock_ptr = A value identifying the register's class
+ *	active_spin_lock_id  = A unique ID for each register pointer value
+ *
+ * Currently, PTR_TO_MAP_VALUE and PTR_TO_BTF_ID | MEM_TYPE_LOCAL are the two
+ * supported register types.
+ *
+ * The active_spin_lock_ptr in case of map values is the reg->map_ptr, and in
+ * case of local kptrs is the reg->btf pointer.
+ *
+ * The active_spin_lock_id is non-unique for maps supporting direct_value_addr,
+ * as we can establish the provenance of the map value statically for each
+ * distinct lookup into such maps.
+ *
+ * In case of global variables, they use array maps with max_entries = 1, hence
+ * their active_spin_lock_ptr becomes map_ptr and id = 0 (since they all point
+ * into the same map value as max_entries is 1).
+ *
+ * In case of inner map lookups, the inner map pointer has same map_ptr as the
+ * outer map pointer (in verifier context), but each lookup into an inner map
+ * assigns a fresh reg->id to the lookup, so while lookups into distinct inner
+ * maps from the same outer map share the same map_ptr as active_spin_lock_ptr,
+ * they will get different reg->id assigned to each lookup.
+ *
+ * In case of local kptrs, active_spin_lock_ptr is the reg->btf, and the reg->id
+ * is a unique ID preserved after the NULL pointer check on the local kptr after
+ * its allocation using bpf_obj_new.
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
+	case PTR_TO_BTF_ID | MEM_TYPE_LOCAL:
+		ptr = reg->btf;
+		break;
+	default:
+		verbose(env, "verifier internal error: unknown reg type for lock check\n");
+		return -EFAULT;
+	}
+	id = reg->id;
+
+	if (env->cur_state->active_spin_lock_ptr != ptr ||
+	    env->cur_state->active_spin_lock_id != id) {
+		verbose(env, "mismatch between held lock and object allocation provenance\n");
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
+	} else /* PTR_TO_BTF_ID | MEM_TYPE_LOCAL */ {
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
+		verbose(env, "bpf_spin_lock at off=%d must be held for manipulating bpf_list_head\n",
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
+	/* Set arg#1 for expiration after unlock */
+	return ref_set_release_on_unlock(env, reg->ref_obj_id);
+}
+
 static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta)
 {
 	const char *func_name = meta->func_name, *ref_tname;
@@ -8167,6 +8440,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			break;
 		case KF_ARG_PTR_TO_KPTR_STRONG:
 		case KF_ARG_PTR_TO_DYNPTR:
+		case KF_ARG_PTR_TO_LIST_HEAD:
+		case KF_ARG_PTR_TO_LIST_NODE:
 		case KF_ARG_PTR_TO_MEM:
 		case KF_ARG_PTR_TO_MEM_SIZE:
 			/* Trusted by default */
@@ -8204,17 +8479,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				meta->arg_obj_drop.btf_id = reg->btf_id;
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
@@ -8242,6 +8506,44 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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
@@ -8362,11 +8664,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -8404,6 +8701,15 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 				env->insn_aux_data[insn_idx].kptr_struct_meta =
 					btf_find_struct_meta(meta.arg_obj_drop.btf,
 							     meta.arg_obj_drop.btf_id);
+			} else if (meta.func_id == special_kfunc_list[KF_bpf_list_pop_front] ||
+				   meta.func_id == special_kfunc_list[KF_bpf_list_pop_back]) {
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
@@ -13072,11 +13378,14 @@ static int do_check(struct bpf_verifier_env *env)
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
+					     (insn->off != 0 || !is_bpf_list_api_kfunc(insn->imm)))) {
+						verbose(env, "function calls are not allowed while holding a lock\n");
+						return -EINVAL;
+					}
 				}
 				if (insn->src_reg == BPF_PSEUDO_CALL)
 					err = check_func_call(env, insn, &env->insn_idx);
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 29a5520a4250..4a76c64e50ad 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -31,3 +31,31 @@ extern void bpf_obj_drop_impl(void *kptr, void *meta) __ksym;
 
 /* Convenience macro to wrap over bpf_obj_drop_impl */
 #define bpf_obj_drop(kptr) bpf_obj_drop_impl(kptr, NULL)
+
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
-- 
2.38.1

