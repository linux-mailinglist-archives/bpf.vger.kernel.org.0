Return-Path: <bpf+bounces-8796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA785789FED
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 17:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195141C20909
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 15:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EE511187;
	Sun, 27 Aug 2023 15:27:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FECE7EE
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 15:27:59 +0000 (UTC)
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E12EC
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 08:27:56 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id B0133257ECE66; Sun, 27 Aug 2023 08:27:44 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 03/13] bpf: Add alloc/xchg/direct_access support for local percpu kptr
Date: Sun, 27 Aug 2023 08:27:44 -0700
Message-Id: <20230827152744.1996739-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230827152729.1995219-1-yonghong.song@linux.dev>
References: <20230827152729.1995219-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_SOFTFAIL,
	TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add two new kfunc's, bpf_percpu_obj_new_impl() and
bpf_percpu_obj_drop_impl(), to allocate a percpu obj.
Two functions are very similar to bpf_obj_new_impl()
and bpf_obj_drop_impl(). The major difference is related
to percpu handling.

    bpf_rcu_read_lock()
    struct val_t __percpu_kptr *v =3D map_val->percpu_data;
    ...
    bpf_rcu_read_unlock()

For a percpu data map_val like above 'v', the reg->type
is set as
	PTR_TO_BTF_ID | MEM_PERCPU | MEM_RCU
if inside rcu critical section.

MEM_RCU marking here is similar to NON_OWN_REF as 'v'
is not a owning reference. But NON_OWN_REF is
trusted and typically inside the spinlock while
MEM_RCU is under rcu read lock. RCU is preferred here
since percpu data structures mean potential concurrent
access into its contents.

Also, bpf_percpu_obj_new_impl() is restricted such that
no pointers or special fields are allowed. Therefore,
the bpf_list_head and bpf_rb_root will not be supported
in this patch set to avoid potential memory leak issue
due to racing between bpf_obj_free_fields() and another
bpf_kptr_xchg() moving an allocated object to
bpf_list_head and bpf_rb_root.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/helpers.c  |  16 ++++++
 kernel/bpf/verifier.c | 112 +++++++++++++++++++++++++++++++++---------
 2 files changed, 106 insertions(+), 22 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8bd3812fb8df..b0a9834f1051 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1902,6 +1902,14 @@ __bpf_kfunc void *bpf_obj_new_impl(u64 local_type_=
id__k, void *meta__ign)
 	return p;
 }
=20
+__bpf_kfunc void *bpf_percpu_obj_new_impl(u64 local_type_id__k, void *me=
ta__ign)
+{
+	u64 size =3D local_type_id__k;
+
+	/* The verifier has ensured that meta__ign must be NULL */
+	return bpf_mem_alloc(&bpf_global_percpu_ma, size);
+}
+
 /* Must be called under migrate_disable(), as required by bpf_mem_free *=
/
 void __bpf_obj_drop_impl(void *p, const struct btf_record *rec)
 {
@@ -1930,6 +1938,12 @@ __bpf_kfunc void bpf_obj_drop_impl(void *p__alloc,=
 void *meta__ign)
 	__bpf_obj_drop_impl(p, meta ? meta->record : NULL);
 }
=20
+__bpf_kfunc void bpf_percpu_obj_drop_impl(void *p__alloc, void *meta__ig=
n)
+{
+	/* The verifier has ensured that meta__ign must be NULL */
+	bpf_mem_free_rcu(&bpf_global_percpu_ma, p__alloc);
+}
+
 __bpf_kfunc void *bpf_refcount_acquire_impl(void *p__refcounted_kptr, vo=
id *meta__ign)
 {
 	struct btf_struct_meta *meta =3D meta__ign;
@@ -2442,7 +2456,9 @@ BTF_SET8_START(generic_btf_ids)
 BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
 #endif
 BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_percpu_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_obj_drop_impl, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_percpu_obj_drop_impl, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_refcount_acquire_impl, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_push_front_impl)
 BTF_ID_FLAGS(func, bpf_list_push_back_impl)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb78212fa5b2..6c886ead18f6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -304,7 +304,7 @@ struct bpf_kfunc_call_arg_meta {
 	/* arg_{btf,btf_id,owning_ref} are used by kfunc-specific handling,
 	 * generally to pass info about user-defined local kptr types to later
 	 * verification logic
-	 *   bpf_obj_drop
+	 *   bpf_obj_drop/bpf_percpu_obj_drop
 	 *     Record the local kptr type to be drop'd
 	 *   bpf_refcount_acquire (via KF_ARG_PTR_TO_REFCOUNTED_KPTR arg type)
 	 *     Record the local kptr type to be refcount_incr'd and use
@@ -5001,6 +5001,8 @@ static int map_kptr_match_type(struct bpf_verifier_=
env *env,
 			perm_flags |=3D PTR_UNTRUSTED;
 	} else {
 		perm_flags =3D PTR_MAYBE_NULL | MEM_ALLOC;
+		if (kptr_field->type =3D=3D BPF_KPTR_PERCPU)
+			perm_flags |=3D MEM_PERCPU;
 	}
=20
 	if (base_type(reg->type) !=3D PTR_TO_BTF_ID || (type_flag(reg->type) & =
~perm_flags))
@@ -5044,7 +5046,7 @@ static int map_kptr_match_type(struct bpf_verifier_=
env *env,
 	 */
 	if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
 				  kptr_field->kptr.btf, kptr_field->kptr.btf_id,
-				  kptr_field->type =3D=3D BPF_KPTR_REF))
+				  kptr_field->type !=3D BPF_KPTR_UNREF))
 		goto bad_type;
 	return 0;
 bad_type:
@@ -5088,7 +5090,18 @@ static bool rcu_safe_kptr(const struct btf_field *=
field)
 {
 	const struct btf_field_kptr *kptr =3D &field->kptr;
=20
-	return field->type =3D=3D BPF_KPTR_REF && rcu_protected_object(kptr->bt=
f, kptr->btf_id);
+	return field->type =3D=3D BPF_KPTR_PERCPU ||
+	       (field->type =3D=3D BPF_KPTR_REF && rcu_protected_object(kptr->b=
tf, kptr->btf_id));
+}
+
+static u32 btf_ld_kptr_type(struct bpf_verifier_env *env, struct btf_fie=
ld *kptr_field)
+{
+	if (rcu_safe_kptr(kptr_field) && in_rcu_cs(env)) {
+		if (kptr_field->type !=3D BPF_KPTR_PERCPU)
+			return PTR_MAYBE_NULL | MEM_RCU;
+		return PTR_MAYBE_NULL | MEM_RCU | MEM_PERCPU;
+	}
+	return PTR_MAYBE_NULL | PTR_UNTRUSTED;
 }
=20
 static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno=
,
@@ -5114,7 +5127,8 @@ static int check_map_kptr_access(struct bpf_verifie=
r_env *env, u32 regno,
 	/* We only allow loading referenced kptr, since it will be marked as
 	 * untrusted, similar to unreferenced kptr.
 	 */
-	if (class !=3D BPF_LDX && kptr_field->type =3D=3D BPF_KPTR_REF) {
+	if (class !=3D BPF_LDX &&
+	    (kptr_field->type =3D=3D BPF_KPTR_REF || kptr_field->type =3D=3D BP=
F_KPTR_PERCPU)) {
 		verbose(env, "store to referenced kptr disallowed\n");
 		return -EACCES;
 	}
@@ -5125,10 +5139,7 @@ static int check_map_kptr_access(struct bpf_verifi=
er_env *env, u32 regno,
 		 * value from map as PTR_TO_BTF_ID, with the correct type.
 		 */
 		mark_btf_ld_reg(env, cur_regs(env), value_regno, PTR_TO_BTF_ID, kptr_f=
ield->kptr.btf,
-				kptr_field->kptr.btf_id,
-				rcu_safe_kptr(kptr_field) && in_rcu_cs(env) ?
-				PTR_MAYBE_NULL | MEM_RCU :
-				PTR_MAYBE_NULL | PTR_UNTRUSTED);
+				kptr_field->kptr.btf_id, btf_ld_kptr_type(env, kptr_field));
 		/* For mark_ptr_or_null_reg */
 		val_reg->id =3D ++env->id_gen;
 	} else if (class =3D=3D BPF_STX) {
@@ -5182,6 +5193,7 @@ static int check_map_access(struct bpf_verifier_env=
 *env, u32 regno,
 			switch (field->type) {
 			case BPF_KPTR_UNREF:
 			case BPF_KPTR_REF:
+			case BPF_KPTR_PERCPU:
 				if (src !=3D ACCESS_DIRECT) {
 					verbose(env, "kptr cannot be accessed indirectly by helper\n");
 					return -EACCES;
@@ -7320,7 +7332,7 @@ static int process_kptr_func(struct bpf_verifier_en=
v *env, int regno,
 		verbose(env, "off=3D%d doesn't point to kptr\n", kptr_off);
 		return -EACCES;
 	}
-	if (kptr_field->type !=3D BPF_KPTR_REF) {
+	if (kptr_field->type !=3D BPF_KPTR_REF && kptr_field->type !=3D BPF_KPT=
R_PERCPU) {
 		verbose(env, "off=3D%d kptr isn't referenced kptr\n", kptr_off);
 		return -EACCES;
 	}
@@ -7831,8 +7843,10 @@ static int check_reg_type(struct bpf_verifier_env =
*env, u32 regno,
 	if (base_type(arg_type) =3D=3D ARG_PTR_TO_MEM)
 		type &=3D ~DYNPTR_TYPE_FLAG_MASK;
=20
-	if (meta->func_id =3D=3D BPF_FUNC_kptr_xchg && type_is_alloc(type))
+	if (meta->func_id =3D=3D BPF_FUNC_kptr_xchg && type_is_alloc(type)) {
 		type &=3D ~MEM_ALLOC;
+		type &=3D ~MEM_PERCPU;
+	}
=20
 	for (i =3D 0; i < ARRAY_SIZE(compatible->types); i++) {
 		expected =3D compatible->types[i];
@@ -7915,6 +7929,7 @@ static int check_reg_type(struct bpf_verifier_env *=
env, u32 regno,
 		break;
 	}
 	case PTR_TO_BTF_ID | MEM_ALLOC:
+	case PTR_TO_BTF_ID | MEM_PERCPU | MEM_ALLOC:
 		if (meta->func_id !=3D BPF_FUNC_spin_lock && meta->func_id !=3D BPF_FU=
NC_spin_unlock &&
 		    meta->func_id !=3D BPF_FUNC_kptr_xchg) {
 			verbose(env, "verifier internal error: unimplemented handling of MEM_=
ALLOC\n");
@@ -9882,8 +9897,11 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 		if (func_id =3D=3D BPF_FUNC_kptr_xchg) {
 			ret_btf =3D meta.kptr_field->kptr.btf;
 			ret_btf_id =3D meta.kptr_field->kptr.btf_id;
-			if (!btf_is_kernel(ret_btf))
+			if (!btf_is_kernel(ret_btf)) {
 				regs[BPF_REG_0].type |=3D MEM_ALLOC;
+				if (meta.kptr_field->type =3D=3D BPF_KPTR_PERCPU)
+					regs[BPF_REG_0].type |=3D MEM_PERCPU;
+			}
 		} else {
 			if (fn->ret_btf_id =3D=3D BPF_PTR_POISON) {
 				verbose(env, "verifier internal error:");
@@ -10268,6 +10286,8 @@ enum special_kfunc_type {
 	KF_bpf_dynptr_slice,
 	KF_bpf_dynptr_slice_rdwr,
 	KF_bpf_dynptr_clone,
+	KF_bpf_percpu_obj_new_impl,
+	KF_bpf_percpu_obj_drop_impl,
 };
=20
 BTF_SET_START(special_kfunc_set)
@@ -10288,6 +10308,8 @@ BTF_ID(func, bpf_dynptr_from_xdp)
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
 BTF_ID(func, bpf_dynptr_clone)
+BTF_ID(func, bpf_percpu_obj_new_impl)
+BTF_ID(func, bpf_percpu_obj_drop_impl)
 BTF_SET_END(special_kfunc_set)
=20
 BTF_ID_LIST(special_kfunc_list)
@@ -10310,6 +10332,8 @@ BTF_ID(func, bpf_dynptr_from_xdp)
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
 BTF_ID(func, bpf_dynptr_clone)
+BTF_ID(func, bpf_percpu_obj_new_impl)
+BTF_ID(func, bpf_percpu_obj_drop_impl)
=20
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -11004,7 +11028,17 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
 			}
 			break;
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
-			if (reg->type !=3D (PTR_TO_BTF_ID | MEM_ALLOC)) {
+			if (reg->type =3D=3D (PTR_TO_BTF_ID | MEM_ALLOC)) {
+				if (meta->func_id !=3D special_kfunc_list[KF_bpf_obj_drop_impl]) {
+					verbose(env, "arg#%d expected for bpf_obj_drop_impl()\n", i);
+					return -EINVAL;
+				}
+			} else if (reg->type =3D=3D (PTR_TO_BTF_ID | MEM_ALLOC | MEM_PERCPU))=
 {
+				if (meta->func_id !=3D special_kfunc_list[KF_bpf_percpu_obj_drop_imp=
l]) {
+					verbose(env, "arg#%d expected for bpf_percpu_obj_drop_impl()\n", i)=
;
+					return -EINVAL;
+				}
+			} else {
 				verbose(env, "arg#%d expected pointer to allocated object\n", i);
 				return -EINVAL;
 			}
@@ -11012,8 +11046,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 				verbose(env, "allocated object must be referenced\n");
 				return -EINVAL;
 			}
-			if (meta->btf =3D=3D btf_vmlinux &&
-			    meta->func_id =3D=3D special_kfunc_list[KF_bpf_obj_drop_impl]) {
+			if (meta->btf =3D=3D btf_vmlinux) {
 				meta->arg_btf =3D reg->btf;
 				meta->arg_btf_id =3D reg->btf_id;
 			}
@@ -11413,6 +11446,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 		/* Only exception is bpf_obj_new_impl */
 		if (meta.btf !=3D btf_vmlinux ||
 		    (meta.func_id !=3D special_kfunc_list[KF_bpf_obj_new_impl] &&
+		     meta.func_id !=3D special_kfunc_list[KF_bpf_percpu_obj_new_impl] =
&&
 		     meta.func_id !=3D special_kfunc_list[KF_bpf_refcount_acquire_impl=
])) {
 			verbose(env, "acquire kernel function does not return PTR_TO_BTF_ID\n=
");
 			return -EINVAL;
@@ -11426,11 +11460,16 @@ static int check_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
 		ptr_type =3D btf_type_skip_modifiers(desc_btf, t->type, &ptr_type_id);
=20
 		if (meta.btf =3D=3D btf_vmlinux && btf_id_set_contains(&special_kfunc_=
set, meta.func_id)) {
-			if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_obj_new_impl]) {
+			if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_obj_new_impl] ||
+			    meta.func_id =3D=3D special_kfunc_list[KF_bpf_percpu_obj_new_impl=
]) {
+				struct btf_struct_meta *struct_meta;
 				struct btf *ret_btf;
 				u32 ret_btf_id;
=20
-				if (unlikely(!bpf_global_ma_set))
+				if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_obj_new_impl] && !=
bpf_global_ma_set)
+					return -ENOMEM;
+
+				if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_percpu_obj_new_imp=
l] && !bpf_global_percpu_ma_set)
 					return -ENOMEM;
=20
 				if (((u64)(u32)meta.arg_constant.value) !=3D meta.arg_constant.value=
) {
@@ -11443,24 +11482,38 @@ static int check_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
=20
 				/* This may be NULL due to user not supplying a BTF */
 				if (!ret_btf) {
-					verbose(env, "bpf_obj_new requires prog BTF\n");
+					verbose(env, "bpf_obj_new/bpf_percpu_obj_new requires prog BTF\n");
 					return -EINVAL;
 				}
=20
 				ret_t =3D btf_type_by_id(ret_btf, ret_btf_id);
 				if (!ret_t || !__btf_type_is_struct(ret_t)) {
-					verbose(env, "bpf_obj_new type ID argument must be of a struct\n");
+					verbose(env, "bpf_obj_new/bpf_percpu_obj_new type ID argument must =
be of a struct\n");
 					return -EINVAL;
 				}
=20
+				struct_meta =3D btf_find_struct_meta(ret_btf, ret_btf_id);
+				if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_percpu_obj_new_imp=
l]) {
+					if (!__btf_type_is_scalar_struct(env, ret_btf, ret_t, 0)) {
+						verbose(env, "bpf_percpu_obj_new type ID argument must be of a str=
uct of scalars\n");
+						return -EINVAL;
+					}
+
+					if (struct_meta) {
+						verbose(env, "bpf_percpu_obj_new type ID argument must not contain=
 special fields\n");
+						return -EINVAL;
+					}
+				}
+
 				mark_reg_known_zero(env, regs, BPF_REG_0);
 				regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | MEM_ALLOC;
 				regs[BPF_REG_0].btf =3D ret_btf;
 				regs[BPF_REG_0].btf_id =3D ret_btf_id;
+				if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_percpu_obj_new_imp=
l])
+					regs[BPF_REG_0].type |=3D MEM_PERCPU;
=20
 				insn_aux->obj_new_size =3D ret_t->size;
-				insn_aux->kptr_struct_meta =3D
-					btf_find_struct_meta(ret_btf, ret_btf_id);
+				insn_aux->kptr_struct_meta =3D struct_meta;
 			} else if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_refcount_acq=
uire_impl]) {
 				mark_reg_known_zero(env, regs, BPF_REG_0);
 				regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | MEM_ALLOC;
@@ -11597,7 +11650,8 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 			regs[BPF_REG_0].id =3D ++env->id_gen;
 	} else if (btf_type_is_void(t)) {
 		if (meta.btf =3D=3D btf_vmlinux && btf_id_set_contains(&special_kfunc_=
set, meta.func_id)) {
-			if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_obj_drop_impl]) {
+			if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_obj_drop_impl] ||
+			    meta.func_id =3D=3D special_kfunc_list[KF_bpf_percpu_obj_drop_imp=
l]) {
 				insn_aux->kptr_struct_meta =3D
 					btf_find_struct_meta(meta.arg_btf,
 							     meta.arg_btf_id);
@@ -18266,21 +18320,35 @@ static int fixup_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
 		insn->imm =3D BPF_CALL_IMM(desc->addr);
 	if (insn->off)
 		return 0;
-	if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_obj_new_impl]) {
+	if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_obj_new_impl] ||
+	    desc->func_id =3D=3D special_kfunc_list[KF_bpf_percpu_obj_new_impl]=
) {
 		struct btf_struct_meta *kptr_struct_meta =3D env->insn_aux_data[insn_i=
dx].kptr_struct_meta;
 		struct bpf_insn addr[2] =3D { BPF_LD_IMM64(BPF_REG_2, (long)kptr_struc=
t_meta) };
 		u64 obj_new_size =3D env->insn_aux_data[insn_idx].obj_new_size;
=20
+		if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_percpu_obj_new_impl=
] && kptr_struct_meta) {
+			verbose(env, "verifier internal error: NULL kptr_struct_meta expected=
 at insn_idx %d\n",
+				insn_idx);
+			return -EFAULT;
+		}
+
 		insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_1, obj_new_size);
 		insn_buf[1] =3D addr[0];
 		insn_buf[2] =3D addr[1];
 		insn_buf[3] =3D *insn;
 		*cnt =3D 4;
 	} else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_obj_drop_impl=
] ||
+		   desc->func_id =3D=3D special_kfunc_list[KF_bpf_percpu_obj_drop_impl=
] ||
 		   desc->func_id =3D=3D special_kfunc_list[KF_bpf_refcount_acquire_imp=
l]) {
 		struct btf_struct_meta *kptr_struct_meta =3D env->insn_aux_data[insn_i=
dx].kptr_struct_meta;
 		struct bpf_insn addr[2] =3D { BPF_LD_IMM64(BPF_REG_2, (long)kptr_struc=
t_meta) };
=20
+		if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_percpu_obj_drop_imp=
l] && kptr_struct_meta) {
+			verbose(env, "verifier internal error: NULL kptr_struct_meta expected=
 at insn_idx %d\n",
+				insn_idx);
+			return -EFAULT;
+		}
+
 		if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_refcount_acquire_im=
pl] &&
 		    !kptr_struct_meta) {
 			verbose(env, "verifier internal error: kptr_struct_meta expected at i=
nsn_idx %d\n",
--=20
2.34.1


