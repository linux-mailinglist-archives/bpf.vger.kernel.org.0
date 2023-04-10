Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4452E6DCB49
	for <lists+bpf@lfdr.de>; Mon, 10 Apr 2023 21:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjDJTIz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Apr 2023 15:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDJTIy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Apr 2023 15:08:54 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC5C1718
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 12:08:51 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33AHwPfQ016330
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 12:08:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=kPX2X+RkhnQaiGJ+fBUHNvMf0XBslfJbsTGoGPpRcy0=;
 b=W9Ta2jQW8n1kS0S4QKLy+TIXHBEhdtnqiJmqT1bIlPd7NsdGpZsRx352sAh6+KuZctvo
 pLSMuNVTl4p7bkcyp44puvLTf0Js1Danx6ut02R2HSVZzRdRn0uTveKAhDbSqAZUWBQX
 a+DdiEBePNnXdgx55DZCTx5iZ1yDncXgFhg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pu5t22ggv-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 12:08:50 -0700
Received: from twshared7147.05.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 10 Apr 2023 12:08:48 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 739901BB3FCE1; Mon, 10 Apr 2023 12:08:42 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 4/9] bpf: Add bpf_refcount_acquire kfunc
Date:   Mon, 10 Apr 2023 12:07:48 -0700
Message-ID: <20230410190753.2012798-5-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230410190753.2012798-1-davemarchevsky@fb.com>
References: <20230410190753.2012798-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Au9XRjDYsRa3BXxLoVT0qI78WQuZ362T
X-Proofpoint-GUID: Au9XRjDYsRa3BXxLoVT0qI78WQuZ362T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_14,2023-04-06_03,2023-02-09_01
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, BPF programs can interact with the lifetime of refcounted
local kptrs in the following ways:

  bpf_obj_new  - Initialize refcount to 1 as part of new object creation
  bpf_obj_drop - Decrement refcount and free object if it's 0
  collection add - Pass ownership to the collection. No change to
                   refcount but collection is responsible for
		   bpf_obj_dropping it

In order to be able to add a refcounted local kptr to multiple
collections we need to be able to increment the refcount and acquire a
new owning reference. This patch adds a kfunc, bpf_refcount_acquire,
implementing such an operation.

bpf_refcount_acquire takes a refcounted local kptr and returns a new
owning reference to the same underlying memory as the input. The input
can be either owning or non-owning. To reinforce why this is safe,
consider the following code snippets:

  struct node *n =3D bpf_obj_new(typeof(*n)); // A
  struct node *m =3D bpf_refcount_acquire(m); // B

In the above snippet, n will be alive with refcount=3D1 after (A), and
since nothing changes that state before (B), it's obviously safe. If
n is instead added to some rbtree, we can still safely refcount_acquire
it:

  struct node *n =3D bpf_obj_new(typeof(*n));
  struct node *m;

  bpf_spin_lock(&glock);
  bpf_rbtree_add(&groot, &n->node, less);   // A
  m =3D bpf_refcount_acquire(n);              // B
  bpf_spin_unlock(&glock);

In the above snippet, after (A) n is a non-owning reference, and after
(B) m is an owning reference pointing to the same memory as n. Although
n has no ownership of that memory's lifetime, it's guaranteed to be
alive until the end of the critical section, and n would be clobbered if
we were past the end of the critical section, so it's safe to bump
refcount.

Implementation details:

* From verifier's perspective, bpf_refcount_acquire handling is similar
  to bpf_obj_new and bpf_obj_drop. Like the former, it returns a new
  owning reference matching input type, although like the latter, type
  can be inferred from concrete kptr input. Verifier changes in
  {check,fixup}_kfunc_call and check_kfunc_args are largely copied from
  aforementioned functions' verifier changes.

* An exception to the above is the new KF_ARG_PTR_TO_REFCOUNTED_KPTR
  arg, indicated by new "__refcounted_kptr" kfunc arg suffix. This is
  necessary in order to handle both owning and non-owning input without
  adding special-casing to "__alloc" arg handling. Also a convenient
  place to confirm that input type has bpf_refcount field.

* The implemented kfunc is actually bpf_refcount_acquire_impl, with
  'hidden' second arg that the verifier sets to the type's struct_meta
  in fixup_kfunc_call.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/helpers.c                          | 15 ++++
 kernel/bpf/verifier.c                         | 74 ++++++++++++++++---
 .../testing/selftests/bpf/bpf_experimental.h  | 13 ++++
 3 files changed, 91 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 67acbb9c4b3d..b752068cead5 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1917,6 +1917,20 @@ __bpf_kfunc void bpf_obj_drop_impl(void *p__alloc,=
 void *meta__ign)
 	__bpf_obj_drop_impl(p, meta ? meta->record : NULL);
 }
=20
+__bpf_kfunc void *bpf_refcount_acquire_impl(void *p__refcounted_kptr, vo=
id *meta__ign)
+{
+	struct btf_struct_meta *meta =3D meta__ign;
+	struct bpf_refcount *ref;
+
+	/* Could just cast directly to refcount_t *, but need some code using
+	 * bpf_refcount type so that it is emitted in vmlinux BTF
+	 */
+	ref =3D (struct bpf_refcount *)p__refcounted_kptr + meta->record->refco=
unt_off;
+
+	refcount_inc((refcount_t *)ref);
+	return (void *)p__refcounted_kptr;
+}
+
 static void __bpf_list_add(struct bpf_list_node *node, struct bpf_list_h=
ead *head, bool tail)
 {
 	struct list_head *n =3D (void *)node, *h =3D (void *)head;
@@ -2308,6 +2322,7 @@ BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
 #endif
 BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_obj_drop_impl, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_refcount_acquire_impl, KF_ACQUIRE)
 BTF_ID_FLAGS(func, bpf_list_push_front)
 BTF_ID_FLAGS(func, bpf_list_push_back)
 BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3660b573048a..eae94c14db36 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -271,6 +271,11 @@ struct bpf_call_arg_meta {
 	struct btf_field *kptr_field;
 };
=20
+struct btf_and_id {
+	struct btf *btf;
+	u32 btf_id;
+};
+
 struct bpf_kfunc_call_arg_meta {
 	/* In parameters */
 	struct btf *btf;
@@ -289,10 +294,10 @@ struct bpf_kfunc_call_arg_meta {
 		u64 value;
 		bool found;
 	} arg_constant;
-	struct {
-		struct btf *btf;
-		u32 btf_id;
-	} arg_obj_drop;
+	union {
+		struct btf_and_id arg_obj_drop;
+		struct btf_and_id arg_refcount_acquire;
+	};
 	struct {
 		struct btf_field *field;
 	} arg_list_head;
@@ -9444,6 +9449,11 @@ static bool is_kfunc_arg_uninit(const struct btf *=
btf, const struct btf_param *a
 	return __kfunc_param_match_suffix(btf, arg, "__uninit");
 }
=20
+static bool is_kfunc_arg_refcounted_kptr(const struct btf *btf, const st=
ruct btf_param *arg)
+{
+	return __kfunc_param_match_suffix(btf, arg, "__refcounted_kptr");
+}
+
 static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
 					  const struct btf_param *arg,
 					  const char *name)
@@ -9583,15 +9593,16 @@ static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] =3D {
=20
 enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_CTX,
-	KF_ARG_PTR_TO_ALLOC_BTF_ID,  /* Allocated object */
-	KF_ARG_PTR_TO_KPTR,	     /* PTR_TO_KPTR but type specific */
+	KF_ARG_PTR_TO_ALLOC_BTF_ID,    /* Allocated object */
+	KF_ARG_PTR_TO_REFCOUNTED_KPTR, /* Refcounted local kptr */
+	KF_ARG_PTR_TO_KPTR,	       /* PTR_TO_KPTR but type specific */
 	KF_ARG_PTR_TO_DYNPTR,
 	KF_ARG_PTR_TO_ITER,
 	KF_ARG_PTR_TO_LIST_HEAD,
 	KF_ARG_PTR_TO_LIST_NODE,
-	KF_ARG_PTR_TO_BTF_ID,	     /* Also covers reg2btf_ids conversions */
+	KF_ARG_PTR_TO_BTF_ID,	       /* Also covers reg2btf_ids conversions */
 	KF_ARG_PTR_TO_MEM,
-	KF_ARG_PTR_TO_MEM_SIZE,	     /* Size derived from next argument, skip i=
t */
+	KF_ARG_PTR_TO_MEM_SIZE,	       /* Size derived from next argument, skip=
 it */
 	KF_ARG_PTR_TO_CALLBACK,
 	KF_ARG_PTR_TO_RB_ROOT,
 	KF_ARG_PTR_TO_RB_NODE,
@@ -9600,6 +9611,7 @@ enum kfunc_ptr_arg_type {
 enum special_kfunc_type {
 	KF_bpf_obj_new_impl,
 	KF_bpf_obj_drop_impl,
+	KF_bpf_refcount_acquire_impl,
 	KF_bpf_list_push_front,
 	KF_bpf_list_push_back,
 	KF_bpf_list_pop_front,
@@ -9620,6 +9632,7 @@ enum special_kfunc_type {
 BTF_SET_START(special_kfunc_set)
 BTF_ID(func, bpf_obj_new_impl)
 BTF_ID(func, bpf_obj_drop_impl)
+BTF_ID(func, bpf_refcount_acquire_impl)
 BTF_ID(func, bpf_list_push_front)
 BTF_ID(func, bpf_list_push_back)
 BTF_ID(func, bpf_list_pop_front)
@@ -9638,6 +9651,7 @@ BTF_SET_END(special_kfunc_set)
 BTF_ID_LIST(special_kfunc_list)
 BTF_ID(func, bpf_obj_new_impl)
 BTF_ID(func, bpf_obj_drop_impl)
+BTF_ID(func, bpf_refcount_acquire_impl)
 BTF_ID(func, bpf_list_push_front)
 BTF_ID(func, bpf_list_push_back)
 BTF_ID(func, bpf_list_pop_front)
@@ -9690,6 +9704,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env=
,
 	if (is_kfunc_arg_alloc_obj(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_ALLOC_BTF_ID;
=20
+	if (is_kfunc_arg_refcounted_kptr(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_REFCOUNTED_KPTR;
+
 	if (is_kfunc_arg_kptr_get(meta, argno)) {
 		if (!btf_type_is_ptr(ref_t)) {
 			verbose(env, "arg#0 BTF type must be a double pointer for kptr_get kf=
unc\n");
@@ -9993,7 +10010,8 @@ static bool is_bpf_rbtree_api_kfunc(u32 btf_id)
=20
 static bool is_bpf_graph_api_kfunc(u32 btf_id)
 {
-	return is_bpf_list_api_kfunc(btf_id) || is_bpf_rbtree_api_kfunc(btf_id)=
;
+	return is_bpf_list_api_kfunc(btf_id) || is_bpf_rbtree_api_kfunc(btf_id)=
 ||
+	       btf_id =3D=3D special_kfunc_list[KF_bpf_refcount_acquire_impl];
 }
=20
 static bool is_callback_calling_kfunc(u32 btf_id)
@@ -10212,6 +10230,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 	const char *func_name =3D meta->func_name, *ref_tname;
 	const struct btf *btf =3D meta->btf;
 	const struct btf_param *args;
+	struct btf_record *rec;
 	u32 i, nargs;
 	int ret;
=20
@@ -10347,6 +10366,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_MEM:
 		case KF_ARG_PTR_TO_MEM_SIZE:
 		case KF_ARG_PTR_TO_CALLBACK:
+		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
 			/* Trusted by default */
 			break;
 		default:
@@ -10564,6 +10584,26 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_CALLBACK:
 			meta->subprogno =3D reg->subprogno;
 			break;
+		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
+			if (!type_is_ptr_alloc_obj(reg->type) && !type_is_non_owning_ref(reg-=
>type)) {
+				verbose(env, "arg#%d is neither owning or non-owning ref\n", i);
+				return -EINVAL;
+			}
+
+			rec =3D reg_btf_record(reg);
+			if (!rec) {
+				verbose(env, "verifier internal error: Couldn't find btf_record\n");
+				return -EFAULT;
+			}
+
+			if (rec->refcount_off < 0) {
+				verbose(env, "arg#%d doesn't point to a type with bpf_refcount field=
\n", i);
+				return -EINVAL;
+			}
+
+			meta->arg_refcount_acquire.btf =3D reg->btf;
+			meta->arg_refcount_acquire.btf_id =3D reg->btf_id;
+			break;
 		}
 	}
=20
@@ -10740,7 +10780,9 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
=20
 	if (is_kfunc_acquire(&meta) && !btf_type_is_struct_ptr(meta.btf, t)) {
 		/* Only exception is bpf_obj_new_impl */
-		if (meta.btf !=3D btf_vmlinux || meta.func_id !=3D special_kfunc_list[=
KF_bpf_obj_new_impl]) {
+		if (meta.btf !=3D btf_vmlinux ||
+		    (meta.func_id !=3D special_kfunc_list[KF_bpf_obj_new_impl] &&
+		     meta.func_id !=3D special_kfunc_list[KF_bpf_refcount_acquire_impl=
])) {
 			verbose(env, "acquire kernel function does not return PTR_TO_BTF_ID\n=
");
 			return -EINVAL;
 		}
@@ -10788,6 +10830,15 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
 				insn_aux->obj_new_size =3D ret_t->size;
 				insn_aux->kptr_struct_meta =3D
 					btf_find_struct_meta(ret_btf, ret_btf_id);
+			} else if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_refcount_acq=
uire_impl]) {
+				mark_reg_known_zero(env, regs, BPF_REG_0);
+				regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | MEM_ALLOC;
+				regs[BPF_REG_0].btf =3D meta.arg_refcount_acquire.btf;
+				regs[BPF_REG_0].btf_id =3D meta.arg_refcount_acquire.btf_id;
+
+				insn_aux->kptr_struct_meta =3D
+					btf_find_struct_meta(meta.arg_refcount_acquire.btf,
+							     meta.arg_refcount_acquire.btf_id);
 			} else if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_list_pop_fro=
nt] ||
 				   meta.func_id =3D=3D special_kfunc_list[KF_bpf_list_pop_back]) {
 				struct btf_field *field =3D meta.arg_list_head.field;
@@ -17408,7 +17459,8 @@ static int fixup_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 		insn_buf[2] =3D addr[1];
 		insn_buf[3] =3D *insn;
 		*cnt =3D 4;
-	} else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_obj_drop_impl=
]) {
+	} else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_obj_drop_impl=
] ||
+		   desc->func_id =3D=3D special_kfunc_list[KF_bpf_refcount_acquire_imp=
l]) {
 		struct btf_struct_meta *kptr_struct_meta =3D env->insn_aux_data[insn_i=
dx].kptr_struct_meta;
 		struct bpf_insn addr[2] =3D { BPF_LD_IMM64(BPF_REG_2, (long)kptr_struc=
t_meta) };
=20
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testi=
ng/selftests/bpf/bpf_experimental.h
index dbd2c729781a..619afcab2ab0 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -37,6 +37,19 @@ extern void bpf_obj_drop_impl(void *kptr, void *meta) =
__ksym;
 /* Convenience macro to wrap over bpf_obj_drop_impl */
 #define bpf_obj_drop(kptr) bpf_obj_drop_impl(kptr, NULL)
=20
+/* Description
+ *	Increment the refcount on a refcounted local kptr, turning the
+ *	non-owning reference input into an owning reference in the process.
+ *
+ *	The 'meta' parameter is a hidden argument that is ignored.
+ * Returns
+ *	An owning reference to the object pointed to by 'kptr'
+ */
+extern void *bpf_refcount_acquire_impl(void *kptr, void *meta) __ksym;
+
+/* Convenience macro to wrap over bpf_refcount_acquire_impl */
+#define bpf_refcount_acquire(kptr) bpf_refcount_acquire_impl(kptr, NULL)
+
 /* Description
  *	Add a new entry to the beginning of the BPF linked list.
  * Returns
--=20
2.34.1

