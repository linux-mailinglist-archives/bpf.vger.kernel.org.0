Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4395164F83B
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 09:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiLQIZm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Dec 2022 03:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiLQIZk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Dec 2022 03:25:40 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C934D2F67C
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 00:25:36 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2BH8JhZ0030208
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 00:25:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=xiPlQHTzQvfS41lPSPcu2SA7TK63gxM8ZFl++EXAX4A=;
 b=geleU77eXo3Fd4UV7YxnaBOx86amA2wvHLSZNG2AFeEzI+EQKQZ0bx5X+CMhv0mzChdR
 FrS8GCCFi6IWe855xv+YGrJ8gKLAA+gfAMJH77KfBFxkBhC/vc5YW0faVezeIYR4Kv0E
 NyjvNPeZ3sicOEHfB83/FVx1soJdV3g4dJw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3mha5br0pb-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 00:25:35 -0800
Received: from twshared2003.08.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 17 Dec 2022 00:25:34 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 47DBE12A9E021; Sat, 17 Dec 2022 00:25:17 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 07/13] bpf: Add support for bpf_rb_root and bpf_rb_node in kfunc args
Date:   Sat, 17 Dec 2022 00:25:00 -0800
Message-ID: <20221217082506.1570898-8-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221217082506.1570898-1-davemarchevsky@fb.com>
References: <20221217082506.1570898-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 3m54jiGFYGOOoMBIrcebiRLjheZi6Rtr
X-Proofpoint-ORIG-GUID: 3m54jiGFYGOOoMBIrcebiRLjheZi6Rtr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-17_03,2022-12-15_02,2022-06-22_01
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
 kernel/bpf/verifier.c | 238 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 203 insertions(+), 35 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e90cf0b74571..06ab0eb6ee7f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8284,6 +8284,9 @@ struct bpf_kfunc_call_arg_meta {
 	struct {
 		struct btf_field *field;
 	} arg_list_head;
+	struct {
+		struct btf_field *field;
+	} arg_rbtree_root;
 };
=20
 static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta)
@@ -8400,6 +8403,8 @@ enum {
 	KF_ARG_DYNPTR_ID,
 	KF_ARG_LIST_HEAD_ID,
 	KF_ARG_LIST_NODE_ID,
+	KF_ARG_RB_ROOT_ID,
+	KF_ARG_RB_NODE_ID,
 };
=20
 BTF_ID_LIST(kf_arg_btf_ids)
@@ -8441,6 +8446,16 @@ static bool is_kfunc_arg_list_node(const struct bt=
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
@@ -8500,6 +8515,8 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_BTF_ID,	     /* Also covers reg2btf_ids conversions */
 	KF_ARG_PTR_TO_MEM,
 	KF_ARG_PTR_TO_MEM_SIZE,	     /* Size derived from next argument, skip i=
t */
+	KF_ARG_PTR_TO_RB_ROOT,
+	KF_ARG_PTR_TO_RB_NODE,
 };
=20
 enum special_kfunc_type {
@@ -8607,6 +8624,12 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *en=
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
@@ -8836,95 +8859,193 @@ static bool is_bpf_list_api_kfunc(u32 btf_id)
 	       btf_id =3D=3D special_kfunc_list[KF_bpf_list_pop_back];
 }
=20
-static int process_kf_arg_ptr_to_list_head(struct bpf_verifier_env *env,
-					   struct bpf_reg_state *reg, u32 regno,
-					   struct bpf_kfunc_call_arg_meta *meta)
+static bool is_bpf_rbtree_api_kfunc(u32 btf_id)
+{
+	return btf_id =3D=3D special_kfunc_list[KF_bpf_rbtree_add] ||
+	       btf_id =3D=3D special_kfunc_list[KF_bpf_rbtree_remove] ||
+	       btf_id =3D=3D special_kfunc_list[KF_bpf_rbtree_first];
+}
+
+static bool is_bpf_graph_api_kfunc(u32 btf_id)
+{
+	return is_bpf_list_api_kfunc(btf_id) || is_bpf_rbtree_api_kfunc(btf_id)=
;
+}
+
+static bool check_kfunc_is_graph_root_api(struct bpf_verifier_env *env,
+					  enum btf_field_type head_field_type,
+					  u32 kfunc_btf_id)
 {
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
+		verbose(env, "verifier internal error: unexpected graph root argument =
type %s\n",
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
+static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
+					  enum btf_field_type node_field_type,
+					  u32 kfunc_btf_id)
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
+		verbose(env, "verifier internal error: unexpected graph node argument =
type %s\n",
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
+__process_kf_arg_ptr_to_graph_root(struct bpf_verifier_env *env,
+				   struct bpf_reg_state *reg, u32 regno,
+				   struct bpf_kfunc_call_arg_meta *meta,
+				   enum btf_field_type head_field_type,
+				   struct btf_field **head_field)
+{
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
+	if (!check_kfunc_is_graph_root_api(env, head_field_type, meta->func_id)=
)
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
+static int process_kf_arg_ptr_to_list_head(struct bpf_verifier_env *env,
 					   struct bpf_reg_state *reg, u32 regno,
 					   struct bpf_kfunc_call_arg_meta *meta)
 {
+	return __process_kf_arg_ptr_to_graph_root(env, reg, regno, meta, BPF_LI=
ST_HEAD,
+							  &meta->arg_list_head.field);
+}
+
+static int process_kf_arg_ptr_to_rbtree_root(struct bpf_verifier_env *en=
v,
+					     struct bpf_reg_state *reg, u32 regno,
+					     struct bpf_kfunc_call_arg_meta *meta)
+{
+	return __process_kf_arg_ptr_to_graph_root(env, reg, regno, meta, BPF_RB=
_ROOT,
+							  &meta->arg_rbtree_root.field);
+}
+
+static int
+__process_kf_arg_ptr_to_graph_node(struct bpf_verifier_env *env,
+				   struct bpf_reg_state *reg, u32 regno,
+				   struct bpf_kfunc_call_arg_meta *meta,
+				   enum btf_field_type head_field_type,
+				   enum btf_field_type node_field_type,
+				   struct btf_field **node_field)
+{
+	const char *node_type_name;
 	const struct btf_type *et, *t;
 	struct btf_field *field;
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
+	if (!check_kfunc_is_graph_node_api(env, node_field_type, meta->func_id)=
)
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
-	list_node_off =3D reg->off + reg->var_off.value;
-	field =3D reg_find_field_offset(reg, list_node_off, BPF_LIST_NODE);
-	if (!field || field->offset !=3D list_node_off) {
-		verbose(env, "bpf_list_node not found at offset=3D%u\n", list_node_off=
);
+	node_off =3D reg->off + reg->var_off.value;
+	field =3D reg_find_field_offset(reg, node_off, node_field_type);
+	if (!field || field->offset !=3D node_off) {
+		verbose(env, "%s not found at offset=3D%u\n", node_type_name, node_off=
);
 		return -EINVAL;
 	}
=20
-	field =3D meta->arg_list_head.field;
+	field =3D *node_field;
=20
 	et =3D btf_type_by_id(field->graph_root.btf, field->graph_root.value_bt=
f_id);
 	t =3D btf_type_by_id(reg->btf, reg->btf_id);
 	if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, 0, field->g=
raph_root.btf,
 				  field->graph_root.value_btf_id, true)) {
-		verbose(env, "operation on bpf_list_head expects arg#1 bpf_list_node a=
t offset=3D%d "
+		verbose(env, "operation on %s expects arg#1 %s at offset=3D%d "
 			"in struct %s, but arg is at offset=3D%d in struct %s\n",
+			btf_field_type_name(head_field_type),
+			btf_field_type_name(node_field_type),
 			field->graph_root.node_offset,
 			btf_name_by_offset(field->graph_root.btf, et->name_off),
-			list_node_off, btf_name_by_offset(reg->btf, t->name_off));
+			node_off, btf_name_by_offset(reg->btf, t->name_off));
 		return -EINVAL;
 	}
=20
-	if (list_node_off !=3D field->graph_root.node_offset) {
-		verbose(env, "arg#1 offset=3D%d, but expected bpf_list_node at offset=3D=
%d in struct %s\n",
-			list_node_off, field->graph_root.node_offset,
+	if (node_off !=3D field->graph_root.node_offset) {
+		verbose(env, "arg#1 offset=3D%d, but expected %s at offset=3D%d in str=
uct %s\n",
+			node_off, btf_field_type_name(node_field_type),
+			field->graph_root.node_offset,
 			btf_name_by_offset(field->graph_root.btf, et->name_off));
 		return -EINVAL;
 	}
@@ -8932,6 +9053,24 @@ static int process_kf_arg_ptr_to_list_node(struct =
bpf_verifier_env *env,
 	return 0;
 }
=20
+static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
+					   struct bpf_reg_state *reg, u32 regno,
+					   struct bpf_kfunc_call_arg_meta *meta)
+{
+	return __process_kf_arg_ptr_to_graph_node(env, reg, regno, meta,
+						  BPF_LIST_HEAD, BPF_LIST_NODE,
+						  &meta->arg_list_head.field);
+}
+
+static int process_kf_arg_ptr_to_rbtree_node(struct bpf_verifier_env *en=
v,
+					     struct bpf_reg_state *reg, u32 regno,
+					     struct bpf_kfunc_call_arg_meta *meta)
+{
+	return __process_kf_arg_ptr_to_graph_node(env, reg, regno, meta,
+						  BPF_RB_ROOT, BPF_RB_NODE,
+						  &meta->arg_rbtree_root.field);
+}
+
 static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfu=
nc_call_arg_meta *meta)
 {
 	const char *func_name =3D meta->func_name, *ref_tname;
@@ -9063,6 +9202,8 @@ static int check_kfunc_args(struct bpf_verifier_env=
 *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_DYNPTR:
 		case KF_ARG_PTR_TO_LIST_HEAD:
 		case KF_ARG_PTR_TO_LIST_NODE:
+		case KF_ARG_PTR_TO_RB_ROOT:
+		case KF_ARG_PTR_TO_RB_NODE:
 		case KF_ARG_PTR_TO_MEM:
 		case KF_ARG_PTR_TO_MEM_SIZE:
 			/* Trusted by default */
@@ -9141,6 +9282,20 @@ static int check_kfunc_args(struct bpf_verifier_en=
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
@@ -9154,6 +9309,19 @@ static int check_kfunc_args(struct bpf_verifier_en=
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
@@ -14105,7 +14273,7 @@ static int do_check(struct bpf_verifier_env *env)
 					if ((insn->src_reg =3D=3D BPF_REG_0 && insn->imm !=3D BPF_FUNC_spin=
_unlock) ||
 					    (insn->src_reg =3D=3D BPF_PSEUDO_CALL) ||
 					    (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL &&
-					     (insn->off !=3D 0 || !is_bpf_list_api_kfunc(insn->imm)))) {
+					     (insn->off !=3D 0 || !is_bpf_graph_api_kfunc(insn->imm)))) {
 						verbose(env, "function calls are not allowed while holding a lock\=
n");
 						return -EINVAL;
 					}
--=20
2.30.2

