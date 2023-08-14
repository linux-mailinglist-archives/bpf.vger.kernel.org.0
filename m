Return-Path: <bpf+bounces-7746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D8F77BEE8
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 19:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7278E1C20AF6
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 17:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C20EC8FD;
	Mon, 14 Aug 2023 17:28:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE010C2FF
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 17:28:40 +0000 (UTC)
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C6610D5
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 10:28:38 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 520A424C21F81; Mon, 14 Aug 2023 10:28:25 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 03/15] bpf: Add alloc/xchg/direct_access support for local percpu kptr
Date: Mon, 14 Aug 2023 10:28:25 -0700
Message-Id: <20230814172825.1363378-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230814172809.1361446-1-yonghong.song@linux.dev>
References: <20230814172809.1361446-1-yonghong.song@linux.dev>
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
    struct val_t __percpu *v =3D map_val->percpu_data;
    ...
    bpf_rcu_read_unlock()

For a percpu data map_val like above 'v', the reg->type
is set as
	PTR_TO_BTF_ID | MEM_PERCPU | MEM_RCU
if inside rcu critical section.

MEM_RCU marking here is similar to NON_OWN_REF as 'v'
is not a owning referenace. But NON_OWN_REF is
trusted and typically inside the spinlock while
MEM_RCU is under rcu read lock. RCU is preferred here
since percpu data structures mean potential concurrent
access into its contents.

Also, bpf_percpu_obj_new_impl() is restricted to only accept
scalar struct which means nested kptr's are not allowed
but some other special field, e.g., bpf_list_head, bpf_spin_lock, etc.
could be nested (nested 'struct'). Later patch will improve verifier to
handle such nested special fields.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h   |  3 +-
 kernel/bpf/helpers.c  | 49 +++++++++++++++++++++++
 kernel/bpf/syscall.c  | 21 +++++++---
 kernel/bpf/verifier.c | 90 ++++++++++++++++++++++++++++++++++---------
 4 files changed, 137 insertions(+), 26 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e6348fd0a785..a2cb380c43c7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -197,7 +197,8 @@ struct btf_field_kptr {
 	struct btf *btf;
 	struct module *module;
 	/* dtor used if btf_is_kernel(btf), otherwise the type is
-	 * program-allocated, dtor is NULL,  and __bpf_obj_drop_impl is used
+	 * program-allocated, dtor is NULL,  and __bpf_obj_drop_impl
+	 * or __bpf_percpu_drop_impl is used
 	 */
 	btf_dtor_kfunc_t dtor;
 	u32 btf_id;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index eb91cae0612a..dd14cb7da4af 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1900,6 +1900,29 @@ __bpf_kfunc void *bpf_obj_new_impl(u64 local_type_=
id__k, void *meta__ign)
 	return p;
 }
=20
+__bpf_kfunc void *bpf_percpu_obj_new_impl(u64 local_type_id__k, void *me=
ta__ign)
+{
+	struct btf_struct_meta *meta =3D meta__ign;
+	const struct btf_record *rec;
+	u64 size =3D local_type_id__k;
+	void __percpu *pptr;
+	void *p;
+	int cpu;
+
+	p =3D bpf_mem_alloc(&bpf_global_percpu_ma, size);
+	if (!p)
+		return NULL;
+	if (meta) {
+		pptr =3D *((void __percpu **)p);
+		rec =3D meta->record;
+		for_each_possible_cpu(cpu) {
+			bpf_obj_init(rec, per_cpu_ptr(pptr, cpu));
+		}
+	}
+
+	return p;
+}
+
 /* Must be called under migrate_disable(), as required by bpf_mem_free *=
/
 void __bpf_obj_drop_impl(void *p, const struct btf_record *rec)
 {
@@ -1924,6 +1947,30 @@ __bpf_kfunc void bpf_obj_drop_impl(void *p__alloc,=
 void *meta__ign)
 	__bpf_obj_drop_impl(p, meta ? meta->record : NULL);
 }
=20
+/* Must be called under migrate_disable(), as required by bpf_mem_free_r=
cu */
+void __bpf_percpu_obj_drop_impl(void *p, const struct btf_record *rec)
+{
+	void __percpu *pptr;
+	int cpu;
+
+	if (rec) {
+		pptr =3D *((void __percpu **)p);
+		for_each_possible_cpu(cpu) {
+			bpf_obj_free_fields(rec, per_cpu_ptr(pptr, cpu));
+		}
+	}
+
+	bpf_mem_free_rcu(&bpf_global_percpu_ma, p);
+}
+
+__bpf_kfunc void bpf_percpu_obj_drop_impl(void *p__alloc, void *meta__ig=
n)
+{
+	struct btf_struct_meta *meta =3D meta__ign;
+	void *p =3D p__alloc;
+
+	__bpf_percpu_obj_drop_impl(p, meta ? meta->record : NULL);
+}
+
 __bpf_kfunc void *bpf_refcount_acquire_impl(void *p__refcounted_kptr, vo=
id *meta__ign)
 {
 	struct btf_struct_meta *meta =3D meta__ign;
@@ -2436,7 +2483,9 @@ BTF_SET8_START(generic_btf_ids)
 BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
 #endif
 BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_percpu_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_obj_drop_impl, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_percpu_obj_drop_impl, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_refcount_acquire_impl, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_push_front_impl)
 BTF_ID_FLAGS(func, bpf_list_push_back_impl)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 1c30b6ee84d4..9ceb6fd9a0e2 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -627,6 +627,7 @@ void bpf_obj_free_timer(const struct btf_record *rec,=
 void *obj)
 }
=20
 extern void __bpf_obj_drop_impl(void *p, const struct btf_record *rec);
+extern void __bpf_percpu_obj_drop_impl(void *p, const struct btf_record =
*rec);
=20
 void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 {
@@ -660,13 +661,21 @@ void bpf_obj_free_fields(const struct btf_record *r=
ec, void *obj)
 			if (!btf_is_kernel(field->kptr.btf)) {
 				pointee_struct_meta =3D btf_find_struct_meta(field->kptr.btf,
 									   field->kptr.btf_id);
-				if (field->type !=3D BPF_KPTR_PERCPU_REF)
+
+				if (field->type =3D=3D BPF_KPTR_PERCPU_REF) {
+					migrate_disable();
+					__bpf_percpu_obj_drop_impl(xchgd_field, pointee_struct_meta ?
+										pointee_struct_meta->record :
+										NULL);
+					migrate_enable();
+				} else {
 					WARN_ON_ONCE(!pointee_struct_meta);
-				migrate_disable();
-				__bpf_obj_drop_impl(xchgd_field, pointee_struct_meta ?
-								 pointee_struct_meta->record :
-								 NULL);
-				migrate_enable();
+					migrate_disable();
+					__bpf_obj_drop_impl(xchgd_field, pointee_struct_meta ?
+									 pointee_struct_meta->record :
+									 NULL);
+					migrate_enable();
+				}
 			} else {
 				field->kptr.dtor(xchgd_field);
 			}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4ccca1f6c998..a985fbf18a11 100644
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
@@ -4997,13 +4997,20 @@ static int map_kptr_match_type(struct bpf_verifie=
r_env *env,
 	if (kptr_field->type =3D=3D BPF_KPTR_UNREF)
 		perm_flags |=3D PTR_UNTRUSTED;
=20
+	if (kptr_field->type =3D=3D BPF_KPTR_PERCPU_REF)
+		perm_flags |=3D MEM_PERCPU | MEM_ALLOC;
+
 	if (base_type(reg->type) !=3D PTR_TO_BTF_ID || (type_flag(reg->type) & =
~perm_flags))
 		goto bad_type;
=20
-	if (!btf_is_kernel(reg->btf)) {
+	if (kptr_field->type !=3D BPF_KPTR_PERCPU_REF && !btf_is_kernel(reg->bt=
f)) {
 		verbose(env, "R%d must point to kernel BTF\n", regno);
 		return -EINVAL;
 	}
+	if (kptr_field->type =3D=3D BPF_KPTR_PERCPU_REF && btf_is_kernel(reg->b=
tf)) {
+		verbose(env, "R%d must point to prog BTF\n", regno);
+		return -EINVAL;
+	}
 	/* We need to verify reg->type and reg->btf, before accessing reg->btf =
*/
 	reg_name =3D btf_type_name(reg->btf, reg->btf_id);
=20
@@ -5084,7 +5091,17 @@ static bool rcu_safe_kptr(const struct btf_field *=
field)
 {
 	const struct btf_field_kptr *kptr =3D &field->kptr;
=20
-	return field->type =3D=3D BPF_KPTR_REF && rcu_protected_object(kptr->bt=
f, kptr->btf_id);
+	return field->type =3D=3D BPF_KPTR_PERCPU_REF ||
+	       (field->type =3D=3D BPF_KPTR_REF && rcu_protected_object(kptr->b=
tf, kptr->btf_id));
+}
+
+static u32 btf_ld_kptr_type(struct bpf_verifier_env *env, struct btf_fie=
ld *kptr_field)
+{
+	if (!rcu_safe_kptr(kptr_field) || !in_rcu_cs(env))
+		return PTR_MAYBE_NULL | PTR_UNTRUSTED;
+	if (kptr_field->type !=3D BPF_KPTR_PERCPU_REF)
+		return PTR_MAYBE_NULL | MEM_RCU;
+	return PTR_MAYBE_NULL | MEM_RCU | MEM_PERCPU;
 }
=20
 static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno=
,
@@ -5110,7 +5127,8 @@ static int check_map_kptr_access(struct bpf_verifie=
r_env *env, u32 regno,
 	/* We only allow loading referenced kptr, since it will be marked as
 	 * untrusted, similar to unreferenced kptr.
 	 */
-	if (class !=3D BPF_LDX && kptr_field->type =3D=3D BPF_KPTR_REF) {
+	if (class !=3D BPF_LDX &&
+	    (kptr_field->type =3D=3D BPF_KPTR_REF || kptr_field->type =3D=3D BP=
F_KPTR_PERCPU_REF)) {
 		verbose(env, "store to referenced kptr disallowed\n");
 		return -EACCES;
 	}
@@ -5121,10 +5139,7 @@ static int check_map_kptr_access(struct bpf_verifi=
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
@@ -5178,6 +5193,7 @@ static int check_map_access(struct bpf_verifier_env=
 *env, u32 regno,
 			switch (field->type) {
 			case BPF_KPTR_UNREF:
 			case BPF_KPTR_REF:
+			case BPF_KPTR_PERCPU_REF:
 				if (src !=3D ACCESS_DIRECT) {
 					verbose(env, "kptr cannot be accessed indirectly by helper\n");
 					return -EACCES;
@@ -7316,7 +7332,7 @@ static int process_kptr_func(struct bpf_verifier_en=
v *env, int regno,
 		verbose(env, "off=3D%d doesn't point to kptr\n", kptr_off);
 		return -EACCES;
 	}
-	if (kptr_field->type !=3D BPF_KPTR_REF) {
+	if (kptr_field->type !=3D BPF_KPTR_REF && kptr_field->type !=3D BPF_KPT=
R_PERCPU_REF) {
 		verbose(env, "off=3D%d kptr isn't referenced kptr\n", kptr_off);
 		return -EACCES;
 	}
@@ -7827,8 +7843,10 @@ static int check_reg_type(struct bpf_verifier_env =
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
@@ -7918,6 +7936,14 @@ static int check_reg_type(struct bpf_verifier_env =
*env, u32 regno,
 		}
 		/* Handled by helper specific checks */
 		break;
+	case PTR_TO_BTF_ID | MEM_PERCPU | MEM_ALLOC:
+		if (meta->func_id !=3D BPF_FUNC_kptr_xchg) {
+			verbose(env, "verifier internal error: unimplemented handling of MEM_=
PERCPU | MEM_ALLOC\n");
+			return -EFAULT;
+		}
+		if (map_kptr_match_type(env, meta->kptr_field, reg, regno))
+			return -EACCES;
+		break;
 	case PTR_TO_BTF_ID | MEM_PERCPU:
 	case PTR_TO_BTF_ID | MEM_PERCPU | PTR_TRUSTED:
 		/* Handled by helper specific checks */
@@ -9885,8 +9911,11 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 		if (func_id =3D=3D BPF_FUNC_kptr_xchg) {
 			ret_btf =3D meta.kptr_field->kptr.btf;
 			ret_btf_id =3D meta.kptr_field->kptr.btf_id;
-			if (!btf_is_kernel(ret_btf))
+			if (!btf_is_kernel(ret_btf)) {
 				regs[BPF_REG_0].type |=3D MEM_ALLOC;
+				if (meta.kptr_field->type =3D=3D BPF_KPTR_PERCPU_REF)
+					regs[BPF_REG_0].type |=3D MEM_PERCPU;
+			}
 		} else {
 			if (fn->ret_btf_id =3D=3D BPF_PTR_POISON) {
 				verbose(env, "verifier internal error:");
@@ -10271,6 +10300,8 @@ enum special_kfunc_type {
 	KF_bpf_dynptr_slice,
 	KF_bpf_dynptr_slice_rdwr,
 	KF_bpf_dynptr_clone,
+	KF_bpf_percpu_obj_new_impl,
+	KF_bpf_percpu_obj_drop_impl,
 };
=20
 BTF_SET_START(special_kfunc_set)
@@ -10291,6 +10322,8 @@ BTF_ID(func, bpf_dynptr_from_xdp)
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
 BTF_ID(func, bpf_dynptr_clone)
+BTF_ID(func, bpf_percpu_obj_new_impl)
+BTF_ID(func, bpf_percpu_obj_drop_impl)
 BTF_SET_END(special_kfunc_set)
=20
 BTF_ID_LIST(special_kfunc_list)
@@ -10313,6 +10346,8 @@ BTF_ID(func, bpf_dynptr_from_xdp)
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
 BTF_ID(func, bpf_dynptr_clone)
+BTF_ID(func, bpf_percpu_obj_new_impl)
+BTF_ID(func, bpf_percpu_obj_drop_impl)
=20
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -11003,7 +11038,8 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 			}
 			break;
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
-			if (reg->type !=3D (PTR_TO_BTF_ID | MEM_ALLOC)) {
+			if (reg->type !=3D (PTR_TO_BTF_ID | MEM_ALLOC) &&
+			    reg->type !=3D (PTR_TO_BTF_ID | MEM_PERCPU | MEM_ALLOC)) {
 				verbose(env, "arg#%d expected pointer to allocated object\n", i);
 				return -EINVAL;
 			}
@@ -11012,7 +11048,8 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 				return -EINVAL;
 			}
 			if (meta->btf =3D=3D btf_vmlinux &&
-			    meta->func_id =3D=3D special_kfunc_list[KF_bpf_obj_drop_impl]) {
+			    (meta->func_id =3D=3D special_kfunc_list[KF_bpf_obj_drop_impl] ||
+			     meta->func_id =3D=3D special_kfunc_list[KF_bpf_percpu_obj_drop_i=
mpl])) {
 				meta->arg_btf =3D reg->btf;
 				meta->arg_btf_id =3D reg->btf_id;
 			}
@@ -11410,6 +11447,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
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
@@ -11423,11 +11461,15 @@ static int check_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
 		ptr_type =3D btf_type_skip_modifiers(desc_btf, t->type, &ptr_type_id);
=20
 		if (meta.btf =3D=3D btf_vmlinux && btf_id_set_contains(&special_kfunc_=
set, meta.func_id)) {
-			if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_obj_new_impl]) {
+			if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_obj_new_impl] ||
+			    meta.func_id =3D=3D special_kfunc_list[KF_bpf_percpu_obj_new_impl=
]) {
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
@@ -11440,13 +11482,18 @@ static int check_kfunc_call(struct bpf_verifier=
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
+					return -EINVAL;
+				}
+				if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_percpu_obj_new_imp=
l] &&
+				    !__btf_type_is_scalar_struct(env, ret_btf, ret_t, 0)) {
+					verbose(env, "bpf_percpu_obj_new type ID argument must be of a stru=
ct of scalars\n");
 					return -EINVAL;
 				}
=20
@@ -11454,6 +11501,8 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 				regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | MEM_ALLOC;
 				regs[BPF_REG_0].btf =3D ret_btf;
 				regs[BPF_REG_0].btf_id =3D ret_btf_id;
+				if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_percpu_obj_new_imp=
l])
+					regs[BPF_REG_0].type |=3D MEM_PERCPU;
=20
 				insn_aux->obj_new_size =3D ret_t->size;
 				insn_aux->kptr_struct_meta =3D
@@ -11594,7 +11643,8 @@ static int check_kfunc_call(struct bpf_verifier_e=
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
@@ -18266,7 +18316,8 @@ static int fixup_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
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
@@ -18277,6 +18328,7 @@ static int fixup_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
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
--=20
2.34.1


