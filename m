Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB023644F5C
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 00:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiLFXKa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 18:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiLFXK3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 18:10:29 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117964298E
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 15:10:28 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6LhAsq005414
        for <bpf@vger.kernel.org>; Tue, 6 Dec 2022 15:10:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=g35IKAD7zoDcJF+8Rx0XRLig7wldqLGrf2a4lIVFJpc=;
 b=i8aWQDzLIxgNh4TqdeHakNJfmDyZHa4L390GzjIXOMnpT7R/jz5Hkco082CXWAbGnyMg
 eN1V4tuneGwdgCZELMXjmxMP328WeXFoFuCirt6MbSiRQg8g+v9X2sPm0vWp08Xc7CW9
 2FvGqntlb1UWaMOCAIeKRzyMZ4gfzjfiT1A= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ma9dxtxf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 15:10:27 -0800
Received: from twshared8047.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 6 Dec 2022 15:10:26 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id F1A54120B3782; Tue,  6 Dec 2022 15:10:05 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next 07/13] bpf: Add support for bpf_rb_root and bpf_rb_node in kfunc args
Date:   Tue, 6 Dec 2022 15:09:54 -0800
Message-ID: <20221206231000.3180914-8-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221206231000.3180914-1-davemarchevsky@fb.com>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Lmdu4Vev81XOT7XThlCcvmRcxwVeLtCq
X-Proofpoint-ORIG-GUID: Lmdu4Vev81XOT7XThlCcvmRcxwVeLtCq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_12,2022-12-06_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that we find bpf_rb_root and bpf_rb_node in structs, let's give args
that contain those types special classification and properly handle
these types when checking kfunc args.

"Properly handling" these types largely requires generalizing similar
handling for bpf_list_{head,node}, with little new logic added in this
patch.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/verifier.c | 237 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 203 insertions(+), 34 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e36dbde8736c..652112007b2c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8018,6 +8018,9 @@ struct bpf_kfunc_call_arg_meta {
 	struct {
 		struct btf_field *field;
 	} arg_list_head;
+	struct {
+		struct btf_field *field;
+	} arg_rbtree_root;
 };
=20
 static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta)
@@ -8129,6 +8132,8 @@ enum {
 	KF_ARG_DYNPTR_ID,
 	KF_ARG_LIST_HEAD_ID,
 	KF_ARG_LIST_NODE_ID,
+	KF_ARG_RB_ROOT_ID,
+	KF_ARG_RB_NODE_ID,
 };
=20
 BTF_ID_LIST(kf_arg_btf_ids)
@@ -8170,6 +8175,16 @@ static bool is_kfunc_arg_list_node(const struct bt=
f *btf, const struct btf_param
 	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_LIST_NODE_ID);
 }
=20
+static bool is_kfunc_arg_rbtree_root(const struct btf *btf, const struct=
 btf_param *arg)
+{
+	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_RB_ROOT_ID);
+}
+
+static bool is_kfunc_arg_rbtree_node(const struct btf *btf, const struct=
 btf_param *arg)
+{
+	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_RB_NODE_ID);
+}
+
 /* Returns true if struct is composed of scalars, 4 levels of nesting al=
lowed */
 static bool __btf_type_is_scalar_struct(struct bpf_verifier_env *env,
 					const struct btf *btf,
@@ -8229,6 +8244,8 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_BTF_ID,	     /* Also covers reg2btf_ids conversions */
 	KF_ARG_PTR_TO_MEM,
 	KF_ARG_PTR_TO_MEM_SIZE,	     /* Size derived from next argument, skip i=
t */
+	KF_ARG_PTR_TO_RB_ROOT,
+	KF_ARG_PTR_TO_RB_NODE,
 };
=20
 enum special_kfunc_type {
@@ -8336,6 +8353,12 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *en=
v,
 	if (is_kfunc_arg_list_node(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_LIST_NODE;
=20
+	if (is_kfunc_arg_rbtree_root(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_RB_ROOT;
+
+	if (is_kfunc_arg_rbtree_node(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_RB_NODE;
+
 	if ((base_type(reg->type) =3D=3D PTR_TO_BTF_ID || reg2btf_ids[base_type=
(reg->type)])) {
 		if (!btf_type_is_struct(ref_t)) {
 			verbose(env, "kernel function %s args#%d pointer type %s %s is not su=
pported\n",
@@ -8550,97 +8573,196 @@ static bool is_bpf_list_api_kfunc(u32 btf_id)
 	       btf_id =3D=3D special_kfunc_list[KF_bpf_list_pop_back];
 }
=20
-static int process_kf_arg_ptr_to_list_head(struct bpf_verifier_env *env,
+static bool is_bpf_rbtree_api_kfunc(u32 btf_id)
+{
+	return btf_id =3D=3D special_kfunc_list[KF_bpf_rbtree_add] ||
+	       btf_id =3D=3D special_kfunc_list[KF_bpf_rbtree_remove] ||
+	       btf_id =3D=3D special_kfunc_list[KF_bpf_rbtree_first];
+}
+
+static bool is_bpf_datastructure_api_kfunc(u32 btf_id)
+{
+	return is_bpf_list_api_kfunc(btf_id) || is_bpf_rbtree_api_kfunc(btf_id)=
;
+}
+
+static bool check_kfunc_is_datastructure_head_api(struct bpf_verifier_en=
v *env,
+						  enum btf_field_type head_field_type,
+						  u32 kfunc_btf_id)
+{
+	bool ret;
+
+	switch (head_field_type) {
+	case BPF_LIST_HEAD:
+		ret =3D is_bpf_list_api_kfunc(kfunc_btf_id);
+		break;
+	case BPF_RB_ROOT:
+		ret =3D is_bpf_rbtree_api_kfunc(kfunc_btf_id);
+		break;
+	default:
+		verbose(env, "verifier internal error: unexpected datastructure head a=
rgument type %s\n",
+			btf_field_type_name(head_field_type));
+		return false;
+	}
+
+	if (!ret)
+		verbose(env, "verifier internal error: %s head arg for unknown kfunc\n=
",
+			btf_field_type_name(head_field_type));
+	return ret;
+}
+
+static bool check_kfunc_is_datastructure_node_api(struct bpf_verifier_en=
v *env,
+						  enum btf_field_type node_field_type,
+						  u32 kfunc_btf_id)
+{
+	bool ret;
+
+	switch (node_field_type) {
+	case BPF_LIST_NODE:
+		ret =3D (kfunc_btf_id =3D=3D special_kfunc_list[KF_bpf_list_push_front=
] ||
+		       kfunc_btf_id =3D=3D special_kfunc_list[KF_bpf_list_push_back]);
+		break;
+	case BPF_RB_NODE:
+		ret =3D (kfunc_btf_id =3D=3D special_kfunc_list[KF_bpf_rbtree_remove] =
||
+		       kfunc_btf_id =3D=3D special_kfunc_list[KF_bpf_rbtree_add]);
+		break;
+	default:
+		verbose(env, "verifier internal error: unexpected datastructure node a=
rgument type %s\n",
+			btf_field_type_name(node_field_type));
+		return false;
+	}
+
+	if (!ret)
+		verbose(env, "verifier internal error: %s node arg for unknown kfunc\n=
",
+			btf_field_type_name(node_field_type));
+	return ret;
+}
+
+static int
+__process_kf_arg_ptr_to_datastructure_head(struct bpf_verifier_env *env,
 					   struct bpf_reg_state *reg, u32 regno,
-					   struct bpf_kfunc_call_arg_meta *meta)
+					   struct bpf_kfunc_call_arg_meta *meta,
+					   enum btf_field_type head_field_type,
+					   struct btf_field **head_field)
 {
+	const char *head_type_name;
 	struct btf_field *field;
 	struct btf_record *rec;
-	u32 list_head_off;
+	u32 head_off;
=20
-	if (meta->btf !=3D btf_vmlinux || !is_bpf_list_api_kfunc(meta->func_id)=
) {
-		verbose(env, "verifier internal error: bpf_list_head argument for unkn=
own kfunc\n");
+	if (meta->btf !=3D btf_vmlinux) {
+		verbose(env, "verifier internal error: unexpected btf mismatch in kfun=
c call\n");
 		return -EFAULT;
 	}
=20
+	if (!check_kfunc_is_datastructure_head_api(env, head_field_type, meta->=
func_id))
+		return -EFAULT;
+
+	head_type_name =3D btf_field_type_name(head_field_type);
 	if (!tnum_is_const(reg->var_off)) {
 		verbose(env,
-			"R%d doesn't have constant offset. bpf_list_head has to be at the con=
stant offset\n",
-			regno);
+			"R%d doesn't have constant offset. %s has to be at the constant offse=
t\n",
+			regno, head_type_name);
 		return -EINVAL;
 	}
=20
 	rec =3D reg_btf_record(reg);
-	list_head_off =3D reg->off + reg->var_off.value;
-	field =3D btf_record_find(rec, list_head_off, BPF_LIST_HEAD);
+	head_off =3D reg->off + reg->var_off.value;
+	field =3D btf_record_find(rec, head_off, head_field_type);
 	if (!field) {
-		verbose(env, "bpf_list_head not found at offset=3D%u\n", list_head_off=
);
+		verbose(env, "%s not found at offset=3D%u\n", head_type_name, head_off=
);
 		return -EINVAL;
 	}
=20
 	/* All functions require bpf_list_head to be protected using a bpf_spin=
_lock */
 	if (check_reg_allocation_locked(env, reg)) {
-		verbose(env, "bpf_spin_lock at off=3D%d must be held for bpf_list_head=
\n",
-			rec->spin_lock_off);
+		verbose(env, "bpf_spin_lock at off=3D%d must be held for %s\n",
+			rec->spin_lock_off, head_type_name);
 		return -EINVAL;
 	}
=20
-	if (meta->arg_list_head.field) {
-		verbose(env, "verifier internal error: repeating bpf_list_head arg\n")=
;
+	if (*head_field) {
+		verbose(env, "verifier internal error: repeating %s arg\n", head_type_=
name);
 		return -EFAULT;
 	}
-	meta->arg_list_head.field =3D field;
+	*head_field =3D field;
 	return 0;
 }
=20
-static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
+
+static int process_kf_arg_ptr_to_list_head(struct bpf_verifier_env *env,
 					   struct bpf_reg_state *reg, u32 regno,
 					   struct bpf_kfunc_call_arg_meta *meta)
 {
+	return __process_kf_arg_ptr_to_datastructure_head(env, reg, regno, meta=
, BPF_LIST_HEAD,
+							  &meta->arg_list_head.field);
+}
+
+static int process_kf_arg_ptr_to_rbtree_root(struct bpf_verifier_env *en=
v,
+					     struct bpf_reg_state *reg, u32 regno,
+					     struct bpf_kfunc_call_arg_meta *meta)
+{
+	return __process_kf_arg_ptr_to_datastructure_head(env, reg, regno, meta=
, BPF_RB_ROOT,
+							  &meta->arg_rbtree_root.field);
+}
+
+static int
+__process_kf_arg_ptr_to_datastructure_node(struct bpf_verifier_env *env,
+					   struct bpf_reg_state *reg, u32 regno,
+					   struct bpf_kfunc_call_arg_meta *meta,
+					   enum btf_field_type head_field_type,
+					   enum btf_field_type node_field_type,
+					   struct btf_field **node_field)
+{
+	const char *node_type_name;
 	const struct btf_type *et, *t;
 	struct btf_field *field;
 	struct btf_record *rec;
-	u32 list_node_off;
+	u32 node_off;
=20
-	if (meta->btf !=3D btf_vmlinux ||
-	    (meta->func_id !=3D special_kfunc_list[KF_bpf_list_push_front] &&
-	     meta->func_id !=3D special_kfunc_list[KF_bpf_list_push_back])) {
-		verbose(env, "verifier internal error: bpf_list_node argument for unkn=
own kfunc\n");
+	if (meta->btf !=3D btf_vmlinux) {
+		verbose(env, "verifier internal error: unexpected btf mismatch in kfun=
c call\n");
 		return -EFAULT;
 	}
=20
+	if (!check_kfunc_is_datastructure_node_api(env, node_field_type, meta->=
func_id))
+		return -EFAULT;
+
+	node_type_name =3D btf_field_type_name(node_field_type);
 	if (!tnum_is_const(reg->var_off)) {
 		verbose(env,
-			"R%d doesn't have constant offset. bpf_list_node has to be at the con=
stant offset\n",
-			regno);
+			"R%d doesn't have constant offset. %s has to be at the constant offse=
t\n",
+			regno, node_type_name);
 		return -EINVAL;
 	}
=20
 	rec =3D reg_btf_record(reg);
-	list_node_off =3D reg->off + reg->var_off.value;
-	field =3D btf_record_find(rec, list_node_off, BPF_LIST_NODE);
-	if (!field || field->offset !=3D list_node_off) {
-		verbose(env, "bpf_list_node not found at offset=3D%u\n", list_node_off=
);
+	node_off =3D reg->off + reg->var_off.value;
+	field =3D btf_record_find(rec, node_off, node_field_type);
+	if (!field || field->offset !=3D node_off) {
+		verbose(env, "%s not found at offset=3D%u\n", node_type_name, node_off=
);
 		return -EINVAL;
 	}
=20
-	field =3D meta->arg_list_head.field;
+	field =3D *node_field;
=20
 	et =3D btf_type_by_id(field->datastructure_head.btf, field->datastructu=
re_head.value_btf_id);
 	t =3D btf_type_by_id(reg->btf, reg->btf_id);
 	if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, 0, field->d=
atastructure_head.btf,
 				  field->datastructure_head.value_btf_id, true)) {
-		verbose(env, "operation on bpf_list_head expects arg#1 bpf_list_node a=
t offset=3D%d "
+		verbose(env, "operation on %s expects arg#1 %s at offset=3D%d "
 			"in struct %s, but arg is at offset=3D%d in struct %s\n",
+			btf_field_type_name(head_field_type),
+			btf_field_type_name(node_field_type),
 			field->datastructure_head.node_offset,
 			btf_name_by_offset(field->datastructure_head.btf, et->name_off),
-			list_node_off, btf_name_by_offset(reg->btf, t->name_off));
+			node_off, btf_name_by_offset(reg->btf, t->name_off));
 		return -EINVAL;
 	}
=20
-	if (list_node_off !=3D field->datastructure_head.node_offset) {
-		verbose(env, "arg#1 offset=3D%d, but expected bpf_list_node at offset=3D=
%d in struct %s\n",
-			list_node_off, field->datastructure_head.node_offset,
+	if (node_off !=3D field->datastructure_head.node_offset) {
+		verbose(env, "arg#1 offset=3D%d, but expected %s at offset=3D%d in str=
uct %s\n",
+			node_off, btf_field_type_name(node_field_type),
+			field->datastructure_head.node_offset,
 			btf_name_by_offset(field->datastructure_head.btf, et->name_off));
 		return -EINVAL;
 	}
@@ -8648,6 +8770,24 @@ static int process_kf_arg_ptr_to_list_node(struct =
bpf_verifier_env *env,
 	return ref_set_release_on_unlock(env, reg->ref_obj_id);
 }
=20
+static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
+					   struct bpf_reg_state *reg, u32 regno,
+					   struct bpf_kfunc_call_arg_meta *meta)
+{
+	return __process_kf_arg_ptr_to_datastructure_node(env, reg, regno, meta=
,
+							  BPF_LIST_HEAD, BPF_LIST_NODE,
+							  &meta->arg_list_head.field);
+}
+
+static int process_kf_arg_ptr_to_rbtree_node(struct bpf_verifier_env *en=
v,
+					     struct bpf_reg_state *reg, u32 regno,
+					     struct bpf_kfunc_call_arg_meta *meta)
+{
+	return __process_kf_arg_ptr_to_datastructure_node(env, reg, regno, meta=
,
+							  BPF_RB_ROOT, BPF_RB_NODE,
+							  &meta->arg_rbtree_root.field);
+}
+
 static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfu=
nc_call_arg_meta *meta)
 {
 	const char *func_name =3D meta->func_name, *ref_tname;
@@ -8776,6 +8916,8 @@ static int check_kfunc_args(struct bpf_verifier_env=
 *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_DYNPTR:
 		case KF_ARG_PTR_TO_LIST_HEAD:
 		case KF_ARG_PTR_TO_LIST_NODE:
+		case KF_ARG_PTR_TO_RB_ROOT:
+		case KF_ARG_PTR_TO_RB_NODE:
 		case KF_ARG_PTR_TO_MEM:
 		case KF_ARG_PTR_TO_MEM_SIZE:
 			/* Trusted by default */
@@ -8861,6 +9003,20 @@ static int check_kfunc_args(struct bpf_verifier_en=
v *env, struct bpf_kfunc_call_
 			if (ret < 0)
 				return ret;
 			break;
+		case KF_ARG_PTR_TO_RB_ROOT:
+			if (reg->type !=3D PTR_TO_MAP_VALUE &&
+			    reg->type !=3D (PTR_TO_BTF_ID | MEM_ALLOC)) {
+				verbose(env, "arg#%d expected pointer to map value or allocated obje=
ct\n", i);
+				return -EINVAL;
+			}
+			if (reg->type =3D=3D (PTR_TO_BTF_ID | MEM_ALLOC) && !reg->ref_obj_id)=
 {
+				verbose(env, "allocated object must be referenced\n");
+				return -EINVAL;
+			}
+			ret =3D process_kf_arg_ptr_to_rbtree_root(env, reg, regno, meta);
+			if (ret < 0)
+				return ret;
+			break;
 		case KF_ARG_PTR_TO_LIST_NODE:
 			if (reg->type !=3D (PTR_TO_BTF_ID | MEM_ALLOC)) {
 				verbose(env, "arg#%d expected pointer to allocated object\n", i);
@@ -8874,6 +9030,19 @@ static int check_kfunc_args(struct bpf_verifier_en=
v *env, struct bpf_kfunc_call_
 			if (ret < 0)
 				return ret;
 			break;
+		case KF_ARG_PTR_TO_RB_NODE:
+			if (reg->type !=3D (PTR_TO_BTF_ID | MEM_ALLOC)) {
+				verbose(env, "arg#%d expected pointer to allocated object\n", i);
+				return -EINVAL;
+			}
+			if (!reg->ref_obj_id) {
+				verbose(env, "allocated object must be referenced\n");
+				return -EINVAL;
+			}
+			ret =3D process_kf_arg_ptr_to_rbtree_node(env, reg, regno, meta);
+			if (ret < 0)
+				return ret;
+			break;
 		case KF_ARG_PTR_TO_BTF_ID:
 			/* Only base_type is checked, further checks are done here */
 			if ((base_type(reg->type) !=3D PTR_TO_BTF_ID ||
@@ -13818,7 +13987,7 @@ static int do_check(struct bpf_verifier_env *env)
 					if ((insn->src_reg =3D=3D BPF_REG_0 && insn->imm !=3D BPF_FUNC_spin=
_unlock) ||
 					    (insn->src_reg =3D=3D BPF_PSEUDO_CALL) ||
 					    (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL &&
-					     (insn->off !=3D 0 || !is_bpf_list_api_kfunc(insn->imm)))) {
+					     (insn->off !=3D 0 || !is_bpf_datastructure_api_kfunc(insn->imm=
)))) {
 						verbose(env, "function calls are not allowed while holding a lock\=
n");
 						return -EINVAL;
 					}
--=20
2.30.2

