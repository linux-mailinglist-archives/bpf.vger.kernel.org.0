Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FE45FD4C2
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 08:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiJMGYp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 02:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiJMGYn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 02:24:43 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03845627E
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:24:40 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k9so528570pll.11
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wqwZ/ijwrKPLH13FqWW7SaNMXbpYtFtAtHI871LcFw=;
        b=pQx6UCfs9hRuB9/8Uh3xmikEHWtuFwi7HW5b+W9BeO4zWFI9jrS0wzIT4CpCnpMZyN
         +q0yASLL4yBp93NTwXK4kw68qGm4PAD3wxvp7st05TyLJbqis5/Qm7VHFBNIbOCAJGqV
         oVjW9sQBAtrL81TXPYqCTs8LRrBob8ZPDzvTWvIY9hSdD7Ls3m6mCabtKCzeUR9e/MSA
         V+BLg3iVPMvx2388Ow03ipnS4SqmxvrW8QXcw/HheSBtB9ZX2sSkVuigwtokclh9zKYI
         V2VrfFEM/q1ESba5hznCgKB6OmcdaanFeevkjbMfM29LQp/TWvaTT145t6rvFZeRhfl/
         tsdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wqwZ/ijwrKPLH13FqWW7SaNMXbpYtFtAtHI871LcFw=;
        b=xwjuC9bAFKbS2KWJrdZL9YjpRZ7gIjXOFqQTKDNVO32RHOCdsVWFg+WuvEmSksxhXM
         DYlnNmGgnzhGk7cCplCVOutSLKxOxC5ME2G1LMKo8pU6vs5lURZ/ThlHOmJzxSI5nYC3
         LnpNzB0nu46gq5zoZD4PEiLG0rAuZTaOoyknCqvCZ9w/84nR2DQOljHtFB+IwrCIPeEn
         AHVuri4MvG7fjVPvtNmgDkjHqIhrkDngp/TeKtEj21mdfO4MAuJ8xpbpqalL78DUIhON
         5slSjOG3ymiA8B4vziDi/zEW4RlQKC685iMEd+raW4h8Ynz4x0K7wjrr+0t9C1ql3dhN
         8Hyg==
X-Gm-Message-State: ACrzQf3raE3Ump949ScLZ5muoQ9bDh210YhGgLISFi+w/hjdtDMQ0POZ
        7dk135Bi94f9DoIkecZVFII1dy/9ieo=
X-Google-Smtp-Source: AMsMyM42QoC1tesJxtFdFExUycTZh6498Pe8ne+FfBrBRTRu0D+ZZi9h6iCGGLzMaYEJXaQEw1zAvw==
X-Received: by 2002:a17:903:284:b0:178:2a94:9b6a with SMTP id j4-20020a170903028400b001782a949b6amr34397498plr.135.1665642280065;
        Wed, 12 Oct 2022 23:24:40 -0700 (PDT)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id e25-20020a635019000000b004468cb97c01sm10564608pgb.56.2022.10.12.23.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 23:24:39 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v2 22/25] bpf: Introduce single ownership BPF linked list API
Date:   Thu, 13 Oct 2022 11:53:00 +0530
Message-Id: <20221013062303.896469-23-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013062303.896469-1-memxor@gmail.com>
References: <20221013062303.896469-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=22836; i=memxor@gmail.com; h=from:subject; bh=7nJnapkokkjaw2prhUYz+G2voQSLXsxTm78uP+kFwhU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjR67Ez9kQZ0BXkOwxAZElw4YggksRHUwFUrewWFiY Bx+1fFiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0euxAAKCRBM4MiGSL8RymJlD/ 97S8jMlK3sC3R4jR9qiFslU+GcJYPF7+bkuAspMxDb3lp1QvvEXyXTNihxQfidJw4/wuOLz+0Tm7nt wzVrykMV6nCfzZy3BU7cyJUGozasDvUkiACsQbjNUV2vIki4bH5o15ZAnRRWgkXoplspjB4qafsN/6 LWLp415MA07+LRgOcTDRCjRyDLMrGJGI3Azuwa5X4uLQOEy0d/ifiSlZBccs65VWWL8jsK7v6McpE5 Z1PW/ps8pslVf59PX5ImakzMEI6PM1NUj+DGzQugSdwTeA27C/Y1SWMNX7roj8MWpbmCrrHQPvmPxl saGXRqkOdO1nHKHApwoniKnwya+0KcPVnfHM5iWwJz9PScWuVhFjkOuuvvdK9CrMkU7TwOGh6nw/ZB K72Tj+x5dINvkUTha0gYr25oExz4U9oRhdFfIUF/i8Ke3k52+9ZBEp0zfNp5iZF8gSoePEx7luZMwl j9JZY/4ucnSj46Jqdc4lwGD/ZSDwz65xI9fex5h3XTcW/u1Q6Ta4iwuGPCMzf7O6EVOdl0TVejCIza wvgybUBe8jmriRTtdu9lGVRh+mT4ooQjtS75CN+bbEyrhuqn6lnZiccMDL8iIq+XLzG0IOtN4ua48J pb3EeJQ7GZJXFjf4S7tI6vT5YerBtQfDoNwsV6Q0q15ziR7dMJd9HjpP28Lw==
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
index 43a7c9999e94..71e0f19f738a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1768,6 +1768,50 @@ void bpf_kptr_drop_impl(void *p__lkptr, void *meta__ign)
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
@@ -1776,6 +1820,10 @@ BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
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
index a8cd04c18ac5..96cf576784c6 100644
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
2.38.0

