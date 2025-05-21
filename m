Return-Path: <bpf+bounces-58634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1225AABEA67
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 05:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 227EE188DAC7
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 03:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0043C22DFAC;
	Wed, 21 May 2025 03:21:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D790222DA1E
	for <bpf@vger.kernel.org>; Wed, 21 May 2025 03:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747797667; cv=none; b=FgXztM+LqpvvPUOB/F0XplmSsx5R03vta1WcMnMC66Gl25vifNKRiIU1Mlcbg5PeN3s7Yi0yyptuL2uJYw4TcwJ1IGvnqJCl/0ELBqhgldd5kGY27t/zeiTXdtlQHanpMTtY2sqzSY6RJPhOuznvUoVxGiOo8YMaHSbs1NJNAEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747797667; c=relaxed/simple;
	bh=3c+DBbpRT/TH70f1uBF8vjtOGZ9FAse41y/pg+OeMjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMR5y15/9NVXTnayi5p5MCXqwOfNDffAaYbGV97au+rBywRx9y/bjo531d6KrZpT0M0Bp3YcrnkQEE8G9vmLu/d+hhFc91X7RAD9Pj7Pk3wQaoujFRKTTFT7N5brjrFCA84tvQNASIku7H3j3w3PNYwMN/z9tOBpmZbGAJluAac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id D1FA87E53F35; Tue, 20 May 2025 20:20:52 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 1/3] bpf: Remove special_kfunc_set from verifier
Date: Tue, 20 May 2025 20:20:52 -0700
Message-ID: <20250521032052.1016178-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250521032047.1015381-1-yonghong.song@linux.dev>
References: <20250521032047.1015381-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently, the verifier has both special_kfunc_set and special_kfunc_list=
.
When adding a new kfunc usage to the verifier, it is often confusing
about whether special_kfunc_set or special_kfunc_list or both should
add that kfunc. For example, some kfuncs, e.g., bpf_dynptr_from_skb,
bpf_dynptr_clone, bpf_wq_set_callback_impl, does not need to be
in special_kfunc_set.

To avoid potential future confusion, special_kfunc_set is deleted
and btf_id_set_contains(&special_kfunc_set, ...) is removed.
The code is refactored with a new func check_special_kfunc(),
which contains all codes covered by original branch
  meta.btf =3D=3D btf_vmlinux && btf_id_set_contains(&special_kfunc_set, =
meta.func_id)

There is no functionality change.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 376 ++++++++++++++++++++----------------------
 1 file changed, 179 insertions(+), 197 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d5807d2efc92..7be97a8419f8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12107,44 +12107,6 @@ enum special_kfunc_type {
 	KF_bpf_res_spin_unlock_irqrestore,
 };
=20
-BTF_SET_START(special_kfunc_set)
-BTF_ID(func, bpf_obj_new_impl)
-BTF_ID(func, bpf_obj_drop_impl)
-BTF_ID(func, bpf_refcount_acquire_impl)
-BTF_ID(func, bpf_list_push_front_impl)
-BTF_ID(func, bpf_list_push_back_impl)
-BTF_ID(func, bpf_list_pop_front)
-BTF_ID(func, bpf_list_pop_back)
-BTF_ID(func, bpf_list_front)
-BTF_ID(func, bpf_list_back)
-BTF_ID(func, bpf_cast_to_kern_ctx)
-BTF_ID(func, bpf_rdonly_cast)
-BTF_ID(func, bpf_rbtree_remove)
-BTF_ID(func, bpf_rbtree_add_impl)
-BTF_ID(func, bpf_rbtree_first)
-BTF_ID(func, bpf_rbtree_root)
-BTF_ID(func, bpf_rbtree_left)
-BTF_ID(func, bpf_rbtree_right)
-#ifdef CONFIG_NET
-BTF_ID(func, bpf_dynptr_from_skb)
-BTF_ID(func, bpf_dynptr_from_xdp)
-#endif
-BTF_ID(func, bpf_dynptr_slice)
-BTF_ID(func, bpf_dynptr_slice_rdwr)
-BTF_ID(func, bpf_dynptr_clone)
-BTF_ID(func, bpf_percpu_obj_new_impl)
-BTF_ID(func, bpf_percpu_obj_drop_impl)
-BTF_ID(func, bpf_throw)
-BTF_ID(func, bpf_wq_set_callback_impl)
-#ifdef CONFIG_CGROUPS
-BTF_ID(func, bpf_iter_css_task_new)
-#endif
-#ifdef CONFIG_BPF_LSM
-BTF_ID(func, bpf_set_dentry_xattr)
-BTF_ID(func, bpf_remove_dentry_xattr)
-#endif
-BTF_SET_END(special_kfunc_set)
-
 BTF_ID_LIST(special_kfunc_list)
 BTF_ID(func, bpf_obj_new_impl)
 BTF_ID(func, bpf_obj_drop_impl)
@@ -13452,6 +13414,175 @@ static int fetch_kfunc_meta(struct bpf_verifier=
_env *env,
 	return 0;
 }
=20
+static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_=
kfunc_call_arg_meta *meta,
+			       struct bpf_reg_state *regs, struct bpf_insn_aux_data *insn_aux=
,
+			       const struct btf_type *ptr_type, struct btf *desc_btf, bool *d=
one)
+{
+	const struct btf_type *ret_t;
+	int err =3D 0;
+
+	if (meta->btf !=3D btf_vmlinux) {
+		*done =3D false;
+		return 0;
+	}
+
+	if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_obj_new_impl] ||
+	    meta->func_id =3D=3D special_kfunc_list[KF_bpf_percpu_obj_new_impl]=
) {
+		struct btf_struct_meta *struct_meta;
+		struct btf *ret_btf;
+		u32 ret_btf_id;
+
+		if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_obj_new_impl] && !b=
pf_global_ma_set)
+			return -ENOMEM;
+
+		if (((u64)(u32)meta->arg_constant.value) !=3D meta->arg_constant.value=
) {
+			verbose(env, "local type ID argument must be in range [0, U32_MAX]\n"=
);
+			return -EINVAL;
+		}
+
+		ret_btf =3D env->prog->aux->btf;
+		ret_btf_id =3D meta->arg_constant.value;
+
+		/* This may be NULL due to user not supplying a BTF */
+		if (!ret_btf) {
+			verbose(env, "bpf_obj_new/bpf_percpu_obj_new requires prog BTF\n");
+			return -EINVAL;
+		}
+
+		ret_t =3D btf_type_by_id(ret_btf, ret_btf_id);
+		if (!ret_t || !__btf_type_is_struct(ret_t)) {
+			verbose(env, "bpf_obj_new/bpf_percpu_obj_new type ID argument must be=
 of a struct\n");
+			return -EINVAL;
+		}
+
+		if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_percpu_obj_new_impl=
]) {
+			if (ret_t->size > BPF_GLOBAL_PERCPU_MA_MAX_SIZE) {
+				verbose(env, "bpf_percpu_obj_new type size (%d) is greater than %d\n=
",
+					ret_t->size, BPF_GLOBAL_PERCPU_MA_MAX_SIZE);
+				return -EINVAL;
+			}
+
+			if (!bpf_global_percpu_ma_set) {
+				mutex_lock(&bpf_percpu_ma_lock);
+				if (!bpf_global_percpu_ma_set) {
+					/* Charge memory allocated with bpf_global_percpu_ma to
+					 * root memcg. The obj_cgroup for root memcg is NULL.
+					 */
+					err =3D bpf_mem_alloc_percpu_init(&bpf_global_percpu_ma, NULL);
+					if (!err)
+						bpf_global_percpu_ma_set =3D true;
+				}
+				mutex_unlock(&bpf_percpu_ma_lock);
+				if (err)
+					return err;
+			}
+
+			mutex_lock(&bpf_percpu_ma_lock);
+			err =3D bpf_mem_alloc_percpu_unit_init(&bpf_global_percpu_ma, ret_t->=
size);
+			mutex_unlock(&bpf_percpu_ma_lock);
+			if (err)
+				return err;
+		}
+
+		struct_meta =3D btf_find_struct_meta(ret_btf, ret_btf_id);
+		if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_percpu_obj_new_impl=
]) {
+			if (!__btf_type_is_scalar_struct(env, ret_btf, ret_t, 0)) {
+				verbose(env, "bpf_percpu_obj_new type ID argument must be of a struc=
t of scalars\n");
+				return -EINVAL;
+			}
+
+			if (struct_meta) {
+				verbose(env, "bpf_percpu_obj_new type ID argument must not contain s=
pecial fields\n");
+				return -EINVAL;
+			}
+		}
+
+		mark_reg_known_zero(env, regs, BPF_REG_0);
+		regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | MEM_ALLOC;
+		regs[BPF_REG_0].btf =3D ret_btf;
+		regs[BPF_REG_0].btf_id =3D ret_btf_id;
+		if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_percpu_obj_new_impl=
])
+			regs[BPF_REG_0].type |=3D MEM_PERCPU;
+
+		insn_aux->obj_new_size =3D ret_t->size;
+		insn_aux->kptr_struct_meta =3D struct_meta;
+	} else if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_refcount_acqu=
ire_impl]) {
+		mark_reg_known_zero(env, regs, BPF_REG_0);
+		regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | MEM_ALLOC;
+		regs[BPF_REG_0].btf =3D meta->arg_btf;
+		regs[BPF_REG_0].btf_id =3D meta->arg_btf_id;
+
+		insn_aux->kptr_struct_meta =3D
+			btf_find_struct_meta(meta->arg_btf,
+					     meta->arg_btf_id);
+	} else if (is_list_node_type(ptr_type)) {
+		struct btf_field *field =3D meta->arg_list_head.field;
+
+		mark_reg_graph_node(regs, BPF_REG_0, &field->graph_root);
+	} else if (is_rbtree_node_type(ptr_type)) {
+		struct btf_field *field =3D meta->arg_rbtree_root.field;
+
+		mark_reg_graph_node(regs, BPF_REG_0, &field->graph_root);
+	} else if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_cast_to_kern_=
ctx]) {
+		mark_reg_known_zero(env, regs, BPF_REG_0);
+		regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | PTR_TRUSTED;
+		regs[BPF_REG_0].btf =3D desc_btf;
+		regs[BPF_REG_0].btf_id =3D meta->ret_btf_id;
+	} else if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_rdonly_cast])=
 {
+		ret_t =3D btf_type_by_id(desc_btf, meta->arg_constant.value);
+		if (!ret_t || !btf_type_is_struct(ret_t)) {
+			verbose(env,
+				"kfunc bpf_rdonly_cast type ID argument must be of a struct\n");
+			return -EINVAL;
+		}
+
+		mark_reg_known_zero(env, regs, BPF_REG_0);
+		regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | PTR_UNTRUSTED;
+		regs[BPF_REG_0].btf =3D desc_btf;
+		regs[BPF_REG_0].btf_id =3D meta->arg_constant.value;
+	} else if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_dynptr_slice]=
 ||
+		   meta->func_id =3D=3D special_kfunc_list[KF_bpf_dynptr_slice_rdwr]) =
{
+		enum bpf_type_flag type_flag =3D get_dynptr_type_flag(meta->initialize=
d_dynptr.type);
+
+		mark_reg_known_zero(env, regs, BPF_REG_0);
+
+		if (!meta->arg_constant.found) {
+			verbose(env, "verifier internal error: bpf_dynptr_slice(_rdwr) no con=
stant size\n");
+			return -EFAULT;
+		}
+
+		regs[BPF_REG_0].mem_size =3D meta->arg_constant.value;
+
+		/* PTR_MAYBE_NULL will be added when is_kfunc_ret_null is checked */
+		regs[BPF_REG_0].type =3D PTR_TO_MEM | type_flag;
+
+		if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_dynptr_slice]) {
+			regs[BPF_REG_0].type |=3D MEM_RDONLY;
+		} else {
+			/* this will set env->seen_direct_write to true */
+			if (!may_access_direct_pkt_data(env, NULL, BPF_WRITE)) {
+				verbose(env, "the prog does not allow writes to packet data\n");
+				return -EINVAL;
+			}
+		}
+
+		if (!meta->initialized_dynptr.id) {
+			verbose(env, "verifier internal error: no dynptr id\n");
+			return -EFAULT;
+		}
+		regs[BPF_REG_0].dynptr_id =3D meta->initialized_dynptr.id;
+
+		/* we don't need to set BPF_REG_0's ref obj id
+		 * because packet slices are not refcounted (see
+		 * dynptr_type_refcounted)
+		 */
+	} else {
+		*done =3D false;
+	}
+
+	return 0;
+}
+
 static int check_return_code(struct bpf_verifier_env *env, int regno, co=
nst char *reg_name);
=20
 static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_ins=
n *insn,
@@ -13466,7 +13597,6 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 	struct bpf_insn_aux_data *insn_aux;
 	int err, insn_idx =3D *insn_idx_p;
 	const struct btf_param *args;
-	const struct btf_type *ret_t;
 	struct btf *desc_btf;
=20
 	/* skip for now, but return error when we find this in fixup_kfunc_call=
 */
@@ -13685,165 +13815,16 @@ static int check_kfunc_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn,
 			__mark_reg_const_zero(env, &regs[BPF_REG_0]);
 		mark_btf_func_reg_size(env, BPF_REG_0, t->size);
 	} else if (btf_type_is_ptr(t)) {
-		ptr_type =3D btf_type_skip_modifiers(desc_btf, t->type, &ptr_type_id);
-
-		if (meta.btf =3D=3D btf_vmlinux && btf_id_set_contains(&special_kfunc_=
set, meta.func_id)) {
-			if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_obj_new_impl] ||
-			    meta.func_id =3D=3D special_kfunc_list[KF_bpf_percpu_obj_new_impl=
]) {
-				struct btf_struct_meta *struct_meta;
-				struct btf *ret_btf;
-				u32 ret_btf_id;
-
-				if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_obj_new_impl] && !=
bpf_global_ma_set)
-					return -ENOMEM;
-
-				if (((u64)(u32)meta.arg_constant.value) !=3D meta.arg_constant.value=
) {
-					verbose(env, "local type ID argument must be in range [0, U32_MAX]\=
n");
-					return -EINVAL;
-				}
-
-				ret_btf =3D env->prog->aux->btf;
-				ret_btf_id =3D meta.arg_constant.value;
+		bool done =3D true;
=20
-				/* This may be NULL due to user not supplying a BTF */
-				if (!ret_btf) {
-					verbose(env, "bpf_obj_new/bpf_percpu_obj_new requires prog BTF\n");
-					return -EINVAL;
-				}
-
-				ret_t =3D btf_type_by_id(ret_btf, ret_btf_id);
-				if (!ret_t || !__btf_type_is_struct(ret_t)) {
-					verbose(env, "bpf_obj_new/bpf_percpu_obj_new type ID argument must =
be of a struct\n");
-					return -EINVAL;
-				}
-
-				if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_percpu_obj_new_imp=
l]) {
-					if (ret_t->size > BPF_GLOBAL_PERCPU_MA_MAX_SIZE) {
-						verbose(env, "bpf_percpu_obj_new type size (%d) is greater than %d=
\n",
-							ret_t->size, BPF_GLOBAL_PERCPU_MA_MAX_SIZE);
-						return -EINVAL;
-					}
-
-					if (!bpf_global_percpu_ma_set) {
-						mutex_lock(&bpf_percpu_ma_lock);
-						if (!bpf_global_percpu_ma_set) {
-							/* Charge memory allocated with bpf_global_percpu_ma to
-							 * root memcg. The obj_cgroup for root memcg is NULL.
-							 */
-							err =3D bpf_mem_alloc_percpu_init(&bpf_global_percpu_ma, NULL);
-							if (!err)
-								bpf_global_percpu_ma_set =3D true;
-						}
-						mutex_unlock(&bpf_percpu_ma_lock);
-						if (err)
-							return err;
-					}
-
-					mutex_lock(&bpf_percpu_ma_lock);
-					err =3D bpf_mem_alloc_percpu_unit_init(&bpf_global_percpu_ma, ret_t=
->size);
-					mutex_unlock(&bpf_percpu_ma_lock);
-					if (err)
-						return err;
-				}
-
-				struct_meta =3D btf_find_struct_meta(ret_btf, ret_btf_id);
-				if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_percpu_obj_new_imp=
l]) {
-					if (!__btf_type_is_scalar_struct(env, ret_btf, ret_t, 0)) {
-						verbose(env, "bpf_percpu_obj_new type ID argument must be of a str=
uct of scalars\n");
-						return -EINVAL;
-					}
-
-					if (struct_meta) {
-						verbose(env, "bpf_percpu_obj_new type ID argument must not contain=
 special fields\n");
-						return -EINVAL;
-					}
-				}
-
-				mark_reg_known_zero(env, regs, BPF_REG_0);
-				regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | MEM_ALLOC;
-				regs[BPF_REG_0].btf =3D ret_btf;
-				regs[BPF_REG_0].btf_id =3D ret_btf_id;
-				if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_percpu_obj_new_imp=
l])
-					regs[BPF_REG_0].type |=3D MEM_PERCPU;
-
-				insn_aux->obj_new_size =3D ret_t->size;
-				insn_aux->kptr_struct_meta =3D struct_meta;
-			} else if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_refcount_acq=
uire_impl]) {
-				mark_reg_known_zero(env, regs, BPF_REG_0);
-				regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | MEM_ALLOC;
-				regs[BPF_REG_0].btf =3D meta.arg_btf;
-				regs[BPF_REG_0].btf_id =3D meta.arg_btf_id;
-
-				insn_aux->kptr_struct_meta =3D
-					btf_find_struct_meta(meta.arg_btf,
-							     meta.arg_btf_id);
-			} else if (is_list_node_type(ptr_type)) {
-				struct btf_field *field =3D meta.arg_list_head.field;
-
-				mark_reg_graph_node(regs, BPF_REG_0, &field->graph_root);
-			} else if (is_rbtree_node_type(ptr_type)) {
-				struct btf_field *field =3D meta.arg_rbtree_root.field;
-
-				mark_reg_graph_node(regs, BPF_REG_0, &field->graph_root);
-			} else if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_cast_to_kern=
_ctx]) {
-				mark_reg_known_zero(env, regs, BPF_REG_0);
-				regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | PTR_TRUSTED;
-				regs[BPF_REG_0].btf =3D desc_btf;
-				regs[BPF_REG_0].btf_id =3D meta.ret_btf_id;
-			} else if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_rdonly_cast]=
) {
-				ret_t =3D btf_type_by_id(desc_btf, meta.arg_constant.value);
-				if (!ret_t || !btf_type_is_struct(ret_t)) {
-					verbose(env,
-						"kfunc bpf_rdonly_cast type ID argument must be of a struct\n");
-					return -EINVAL;
-				}
-
-				mark_reg_known_zero(env, regs, BPF_REG_0);
-				regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | PTR_UNTRUSTED;
-				regs[BPF_REG_0].btf =3D desc_btf;
-				regs[BPF_REG_0].btf_id =3D meta.arg_constant.value;
-			} else if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_dynptr_slice=
] ||
-				   meta.func_id =3D=3D special_kfunc_list[KF_bpf_dynptr_slice_rdwr])=
 {
-				enum bpf_type_flag type_flag =3D get_dynptr_type_flag(meta.initializ=
ed_dynptr.type);
-
-				mark_reg_known_zero(env, regs, BPF_REG_0);
-
-				if (!meta.arg_constant.found) {
-					verbose(env, "verifier internal error: bpf_dynptr_slice(_rdwr) no c=
onstant size\n");
-					return -EFAULT;
-				}
-
-				regs[BPF_REG_0].mem_size =3D meta.arg_constant.value;
-
-				/* PTR_MAYBE_NULL will be added when is_kfunc_ret_null is checked */
-				regs[BPF_REG_0].type =3D PTR_TO_MEM | type_flag;
-
-				if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_dynptr_slice]) {
-					regs[BPF_REG_0].type |=3D MEM_RDONLY;
-				} else {
-					/* this will set env->seen_direct_write to true */
-					if (!may_access_direct_pkt_data(env, NULL, BPF_WRITE)) {
-						verbose(env, "the prog does not allow writes to packet data\n");
-						return -EINVAL;
-					}
-				}
-
-				if (!meta.initialized_dynptr.id) {
-					verbose(env, "verifier internal error: no dynptr id\n");
-					return -EFAULT;
-				}
-				regs[BPF_REG_0].dynptr_id =3D meta.initialized_dynptr.id;
+		ptr_type =3D btf_type_skip_modifiers(desc_btf, t->type, &ptr_type_id);
+		err =3D check_special_kfunc(env, &meta, regs, insn_aux, ptr_type, desc=
_btf, &done);
+		if (err)
+			return err;
+		if (done)
+			goto check_kfunc_ret;
=20
-				/* we don't need to set BPF_REG_0's ref obj id
-				 * because packet slices are not refcounted (see
-				 * dynptr_type_refcounted)
-				 */
-			} else {
-				verbose(env, "kernel function %s unhandled dynamic return type\n",
-					meta.func_name);
-				return -EFAULT;
-			}
-		} else if (btf_type_is_void(ptr_type)) {
+		if (btf_type_is_void(ptr_type)) {
 			/* kfunc returning 'void *' is equivalent to returning scalar */
 			mark_reg_unknown(env, regs, BPF_REG_0);
 		} else if (!__btf_type_is_struct(ptr_type)) {
@@ -13897,6 +13878,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 			}
 		}
=20
+check_kfunc_ret:
 		if (is_kfunc_ret_null(&meta)) {
 			regs[BPF_REG_0].type |=3D PTR_MAYBE_NULL;
 			/* For mark_ptr_or_null_reg, see 93c230e3f5bd6 */
@@ -13918,7 +13900,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 		if (reg_may_point_to_spin_lock(&regs[BPF_REG_0]) && !regs[BPF_REG_0].i=
d)
 			regs[BPF_REG_0].id =3D ++env->id_gen;
 	} else if (btf_type_is_void(t)) {
-		if (meta.btf =3D=3D btf_vmlinux && btf_id_set_contains(&special_kfunc_=
set, meta.func_id)) {
+		if (meta.btf =3D=3D btf_vmlinux) {
 			if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_obj_drop_impl] ||
 			    meta.func_id =3D=3D special_kfunc_list[KF_bpf_percpu_obj_drop_imp=
l]) {
 				insn_aux->kptr_struct_meta =3D
--=20
2.47.1


