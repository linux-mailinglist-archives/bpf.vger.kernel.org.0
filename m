Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6923100FF
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 00:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhBDXtR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 18:49:17 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52266 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231171AbhBDXtQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 4 Feb 2021 18:49:16 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 114NkZ6s032306
        for <bpf@vger.kernel.org>; Thu, 4 Feb 2021 15:48:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=WENYW/zgiBQLhD7u8xvWxMj8B1BvhmHDYSxyFR+dtRg=;
 b=Z30tGfFABoyMF7dlpZ4Sr8uNAdDGtWnaopq2StS4KM5mCSJI7Y7x80bA2AXvXZIg8RNH
 pINV9qVEYu+Y2Ksg+TVS5jwrcErO3TVyglnuP6lxtBxHIEqRugxzdf3WA4W7JLgK+62e
 oSKdHx//sPHad3DlIrqO/w3N5zcKJSDHxi0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36fy55rxtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 04 Feb 2021 15:48:34 -0800
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 4 Feb 2021 15:48:33 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 354C33704E75; Thu,  4 Feb 2021 15:48:29 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/8] bpf: add bpf_for_each_map_elem() helper
Date:   Thu, 4 Feb 2021 15:48:29 -0800
Message-ID: <20210204234829.1629159-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210204234827.1628857-1-yhs@fb.com>
References: <20210204234827.1628857-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_13:2021-02-04,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102040144
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpf_for_each_map_elem() helper is introduced which
iterates all map elements with a callback function. The
helper signature looks like
  long bpf_for_each_map_elem(map, callback_fn, callback_ctx, flags)
and for each map element, the callback_fn will be called. For example,
like hashmap, the callback signature may look like
  long callback_fn(map, key, val, callback_ctx)

There are two known use cases for this. One is from upstream ([1]) where
a for_each_map_elem helper may help implement a timeout mechanism
in a more generic way. Another is from our internal discussion
for a firewall use case where a map contains all the rules. The packet
data can be compared to all these rules to decide allow or deny
the packet.

For array maps, users can already use a bounded loop to traverse
elements. Using this helper can avoid using bounded loop. For other
type of maps (e.g., hash maps) where bounded loop is hard or
impossible to use, this helper provides a convenient way to
operate on all elements.

For callback_fn, besides map and map element, a callback_ctx,
allocated on caller stack, is also passed to the callback
function. This callback_ctx argument can provide additional
input and allow to write to caller stack for output.

If the callback_fn returns 0, the helper will iterate through next
element if available. If the callback_fn returns 1, the helper
will stop iterating and returns to the bpf program. Other return
values are not used for now.

Currently, this helper is only available with jit. It is possible
to make it work with interpreter with so effort but I leave it
as the future work.

[1]: https://lore.kernel.org/bpf/20210122205415.113822-1-xiyou.wangcong@gma=
il.com/

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h            |  14 ++
 include/linux/bpf_verifier.h   |   3 +
 include/uapi/linux/bpf.h       |  28 ++++
 kernel/bpf/bpf_iter.c          |  16 +++
 kernel/bpf/helpers.c           |   2 +
 kernel/bpf/verifier.c          | 251 ++++++++++++++++++++++++++++++---
 kernel/trace/bpf_trace.c       |   2 +
 tools/include/uapi/linux/bpf.h |  28 ++++
 8 files changed, 328 insertions(+), 16 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 321966fc35db..c8b72ae16cc5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -40,6 +40,7 @@ struct bpf_local_storage;
 struct bpf_local_storage_map;
 struct kobject;
 struct mem_cgroup;
+struct bpf_func_state;
=20
 extern struct idr btf_idr;
 extern spinlock_t btf_idr_lock;
@@ -130,6 +131,13 @@ struct bpf_map_ops {
 	bool (*map_meta_equal)(const struct bpf_map *meta0,
 			       const struct bpf_map *meta1);
=20
+
+	int (*map_set_for_each_callback_args)(struct bpf_verifier_env *env,
+					      struct bpf_func_state *caller,
+					      struct bpf_func_state *callee);
+	int (*map_for_each_callback)(struct bpf_map *map, void *callback_fn,
+				     void *callback_ctx, u64 flags);
+
 	/* BTF name and id of struct allocated by map_alloc */
 	const char * const map_btf_name;
 	int *map_btf_id;
@@ -296,6 +304,8 @@ enum bpf_arg_type {
 	ARG_CONST_ALLOC_SIZE_OR_ZERO,	/* number of allocated bytes requested */
 	ARG_PTR_TO_BTF_ID_SOCK_COMMON,	/* pointer to in-kernel sock_common or bpf=
-mirrored bpf_sock */
 	ARG_PTR_TO_PERCPU_BTF_ID,	/* pointer to in-kernel percpu type */
+	ARG_PTR_TO_FUNC,	/* pointer to a bpf program function */
+	ARG_PTR_TO_STACK_OR_NULL,	/* pointer to stack or NULL */
 	__BPF_ARG_TYPE_MAX,
 };
=20
@@ -412,6 +422,8 @@ enum bpf_reg_type {
 	PTR_TO_RDWR_BUF,	 /* reg points to a read/write buffer */
 	PTR_TO_RDWR_BUF_OR_NULL, /* reg points to a read/write buffer or NULL */
 	PTR_TO_PERCPU_BTF_ID,	 /* reg points to a percpu kernel variable */
+	PTR_TO_FUNC,		 /* reg points to a bpf program function */
+	PTR_TO_MAP_KEY,		 /* reg points to map element key */
 };
=20
 /* The information passed from prog-specific *_is_valid_access
@@ -794,6 +806,7 @@ struct bpf_prog_aux {
 	bool func_proto_unreliable;
 	bool sleepable;
 	bool tail_call_reachable;
+	bool with_callback_fn;
 	enum bpf_tramp_prog_type trampoline_prog_type;
 	struct hlist_node tramp_hlist;
 	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
@@ -1888,6 +1901,7 @@ extern const struct bpf_func_proto bpf_per_cpu_ptr_pr=
oto;
 extern const struct bpf_func_proto bpf_this_cpu_ptr_proto;
 extern const struct bpf_func_proto bpf_ktime_get_coarse_ns_proto;
 extern const struct bpf_func_proto bpf_sock_from_file_proto;
+extern const struct bpf_func_proto bpf_for_each_map_elem_proto;
=20
 const struct bpf_func_proto *bpf_tracing_func_proto(
 	enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index dfe6f85d97dd..c4366b3da342 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -68,6 +68,8 @@ struct bpf_reg_state {
 			unsigned long raw1;
 			unsigned long raw2;
 		} raw;
+
+		u32 subprog; /* for PTR_TO_FUNC */
 	};
 	/* For PTR_TO_PACKET, used to find other pointers with the same variable
 	 * offset, so they can share range knowledge.
@@ -204,6 +206,7 @@ struct bpf_func_state {
 	int acquired_refs;
 	struct bpf_reference_state *refs;
 	int allocated_stack;
+	bool with_callback_fn;
 	struct bpf_stack_state *stack;
 };
=20
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c001766adcbc..d55bd4557376 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -393,6 +393,15 @@ enum bpf_link_type {
  *                   is struct/union.
  */
 #define BPF_PSEUDO_BTF_ID	3
+/* insn[0].src_reg:  BPF_PSEUDO_FUNC
+ * insn[0].imm:      insn offset to the func
+ * insn[1].imm:      0
+ * insn[0].off:      0
+ * insn[1].off:      0
+ * ldimm64 rewrite:  address of the function
+ * verifier type:    PTR_TO_FUNC.
+ */
+#define BPF_PSEUDO_FUNC		4
=20
 /* when bpf_call->src_reg =3D=3D BPF_PSEUDO_CALL, bpf_call->imm =3D=3D pc-=
relative
  * offset to another bpf function
@@ -3836,6 +3845,24 @@ union bpf_attr {
  *	Return
  *		A pointer to a struct socket on success or NULL if the file is
  *		not a socket.
+ *
+ * long bpf_for_each_map_elem(struct bpf_map *map, void *callback_fn, void=
 *callback_ctx, u64 flags)
+ *	Description
+ *		For each element in **map**, call **callback_fn** function with
+ *		**map**, **callback_ctx** and other map-specific parameters.
+ *		For example, for hash and array maps, the callback signature can
+ *		be `u64 callback_fn(map, map_key, map_value, callback_ctx)`.
+ *		The **callback_fn** should be a static function and
+ *		the **callback_ctx** should be a pointer to the stack.
+ *		The **flags** is used to control certain aspects of the helper.
+ *		Currently, the **flags** must be 0.
+ *
+ *		If **callback_fn** return 0, the helper will continue to the next
+ *		element. If return value is 1, the helper will skip the rest of
+ *		elements and return. Other return values are not used now.
+ *	Return
+ *		0 for success, **-EINVAL** for invalid **flags** or unsupported
+ *		**callback_fn** return value.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -4001,6 +4028,7 @@ union bpf_attr {
 	FN(ktime_get_coarse_ns),	\
 	FN(ima_inode_hash),		\
 	FN(sock_from_file),		\
+	FN(for_each_map_elem),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which help=
er
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 5454161407f1..5187f49d3216 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -675,3 +675,19 @@ int bpf_iter_run_prog(struct bpf_prog *prog, void *ctx)
 	 */
 	return ret =3D=3D 0 ? 0 : -EAGAIN;
 }
+
+BPF_CALL_4(bpf_for_each_map_elem, struct bpf_map *, map, void *, callback_=
fn,
+	   void *, callback_ctx, u64, flags)
+{
+	return map->ops->map_for_each_callback(map, callback_fn, callback_ctx, fl=
ags);
+}
+
+const struct bpf_func_proto bpf_for_each_map_elem_proto =3D {
+	.func		=3D bpf_for_each_map_elem,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_CONST_MAP_PTR,
+	.arg2_type	=3D ARG_PTR_TO_FUNC,
+	.arg3_type	=3D ARG_PTR_TO_STACK_OR_NULL,
+	.arg4_type	=3D ARG_ANYTHING,
+};
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 308427fe03a3..074800226327 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -708,6 +708,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_ringbuf_discard_proto;
 	case BPF_FUNC_ringbuf_query:
 		return &bpf_ringbuf_query_proto;
+	case BPF_FUNC_for_each_map_elem:
+		return &bpf_for_each_map_elem_proto;
 	default:
 		break;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index db294b75d03b..050b067a0be6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -234,6 +234,12 @@ static bool bpf_pseudo_call(const struct bpf_insn *ins=
n)
 	       insn->src_reg =3D=3D BPF_PSEUDO_CALL;
 }
=20
+static bool bpf_pseudo_func(const struct bpf_insn *insn)
+{
+	return insn->code =3D=3D (BPF_LD | BPF_IMM | BPF_DW) &&
+	       insn->src_reg =3D=3D BPF_PSEUDO_FUNC;
+}
+
 struct bpf_call_arg_meta {
 	struct bpf_map *map_ptr;
 	bool raw_mode;
@@ -409,6 +415,7 @@ static bool reg_type_not_null(enum bpf_reg_type type)
 	return type =3D=3D PTR_TO_SOCKET ||
 		type =3D=3D PTR_TO_TCP_SOCK ||
 		type =3D=3D PTR_TO_MAP_VALUE ||
+		type =3D=3D PTR_TO_MAP_KEY ||
 		type =3D=3D PTR_TO_SOCK_COMMON;
 }
=20
@@ -451,7 +458,8 @@ static bool arg_type_may_be_null(enum bpf_arg_type type)
 	       type =3D=3D ARG_PTR_TO_MEM_OR_NULL ||
 	       type =3D=3D ARG_PTR_TO_CTX_OR_NULL ||
 	       type =3D=3D ARG_PTR_TO_SOCKET_OR_NULL ||
-	       type =3D=3D ARG_PTR_TO_ALLOC_MEM_OR_NULL;
+	       type =3D=3D ARG_PTR_TO_ALLOC_MEM_OR_NULL ||
+	       type =3D=3D ARG_PTR_TO_STACK_OR_NULL;
 }
=20
 /* Determine whether the function releases some resources allocated by ano=
ther
@@ -534,6 +542,8 @@ static const char * const reg_type_str[] =3D {
 	[PTR_TO_RDONLY_BUF_OR_NULL] =3D "rdonly_buf_or_null",
 	[PTR_TO_RDWR_BUF]	=3D "rdwr_buf",
 	[PTR_TO_RDWR_BUF_OR_NULL] =3D "rdwr_buf_or_null",
+	[PTR_TO_FUNC]		=3D "func",
+	[PTR_TO_MAP_KEY]	=3D "map_key",
 };
=20
 static char slot_type_char[] =3D {
@@ -605,6 +615,7 @@ static void print_verifier_state(struct bpf_verifier_en=
v *env,
 			if (type_is_pkt_pointer(t))
 				verbose(env, ",r=3D%d", reg->range);
 			else if (t =3D=3D CONST_PTR_TO_MAP ||
+				 t =3D=3D PTR_TO_MAP_KEY ||
 				 t =3D=3D PTR_TO_MAP_VALUE ||
 				 t =3D=3D PTR_TO_MAP_VALUE_OR_NULL)
 				verbose(env, ",ks=3D%d,vs=3D%d",
@@ -1492,6 +1503,19 @@ static int check_subprogs(struct bpf_verifier_env *e=
nv)
=20
 	/* determine subprog starts. The end is one before the next starts */
 	for (i =3D 0; i < insn_cnt; i++) {
+		if (bpf_pseudo_func(insn + i)) {
+			if (!env->bpf_capable) {
+				verbose(env,
+					"function pointers are allowed for CAP_BPF and CAP_SYS_ADMIN\n");
+				return -EPERM;
+			}
+			ret =3D add_subprog(env, i + insn[i].imm + 1);
+			if (ret < 0)
+				return ret;
+			/* remember subprog */
+			insn[i + 1].imm =3D find_subprog(env, i + insn[i].imm + 1);
+			continue;
+		}
 		if (!bpf_pseudo_call(insn + i))
 			continue;
 		if (!env->bpf_capable) {
@@ -2223,6 +2247,8 @@ static bool is_spillable_regtype(enum bpf_reg_type ty=
pe)
 	case PTR_TO_PERCPU_BTF_ID:
 	case PTR_TO_MEM:
 	case PTR_TO_MEM_OR_NULL:
+	case PTR_TO_FUNC:
+	case PTR_TO_MAP_KEY:
 		return true;
 	default:
 		return false;
@@ -2567,6 +2593,10 @@ static int __check_mem_access(struct bpf_verifier_en=
v *env, int regno,
=20
 	reg =3D &cur_regs(env)[regno];
 	switch (reg->type) {
+	case PTR_TO_MAP_KEY:
+		verbose(env, "invalid access to map key, key_size=3D%d off=3D%d size=3D%=
d\n",
+			mem_size, off, size);
+		break;
 	case PTR_TO_MAP_VALUE:
 		verbose(env, "invalid access to map value, value_size=3D%d off=3D%d size=
=3D%d\n",
 			mem_size, off, size);
@@ -2977,6 +3007,9 @@ static int check_ptr_alignment(struct bpf_verifier_en=
v *env,
 	case PTR_TO_FLOW_KEYS:
 		pointer_desc =3D "flow keys ";
 		break;
+	case PTR_TO_MAP_KEY:
+		pointer_desc =3D "key ";
+		break;
 	case PTR_TO_MAP_VALUE:
 		pointer_desc =3D "value ";
 		break;
@@ -3078,7 +3111,7 @@ static int check_max_stack_depth(struct bpf_verifier_=
env *env)
 continue_func:
 	subprog_end =3D subprog[idx + 1].start;
 	for (; i < subprog_end; i++) {
-		if (!bpf_pseudo_call(insn + i))
+		if (!bpf_pseudo_call(insn + i) && !bpf_pseudo_func(insn + i))
 			continue;
 		/* remember insn and function to return to */
 		ret_insn[frame] =3D i + 1;
@@ -3430,7 +3463,19 @@ static int check_mem_access(struct bpf_verifier_env =
*env, int insn_idx, u32 regn
 	/* for access checks, reg->off is just part of off */
 	off +=3D reg->off;
=20
-	if (reg->type =3D=3D PTR_TO_MAP_VALUE) {
+	if (reg->type =3D=3D PTR_TO_MAP_KEY) {
+		if (t =3D=3D BPF_WRITE) {
+			verbose(env, "write to change key R%d not allowed\n", regno);
+			return -EACCES;
+		}
+
+		err =3D check_mem_region_access(env, regno, off, size,
+					      reg->map_ptr->key_size, false);
+		if (err)
+			return err;
+		if (value_regno >=3D 0)
+			mark_reg_unknown(env, regs, value_regno);
+	} else if (reg->type =3D=3D PTR_TO_MAP_VALUE) {
 		if (t =3D=3D BPF_WRITE && value_regno >=3D 0 &&
 		    is_pointer_value(env, value_regno)) {
 			verbose(env, "R%d leaks addr into map\n", value_regno);
@@ -3858,6 +3903,9 @@ static int check_helper_mem_access(struct bpf_verifie=
r_env *env, int regno,
 	case PTR_TO_PACKET_META:
 		return check_packet_access(env, regno, reg->off, access_size,
 					   zero_size_allowed);
+	case PTR_TO_MAP_KEY:
+		return check_mem_region_access(env, regno, reg->off, access_size,
+					       reg->map_ptr->key_size, false);
 	case PTR_TO_MAP_VALUE:
 		if (check_map_access_type(env, regno, reg->off, access_size,
 					  meta && meta->raw_mode ? BPF_WRITE :
@@ -4049,6 +4097,7 @@ static const struct bpf_reg_types map_key_value_types=
 =3D {
 		PTR_TO_STACK,
 		PTR_TO_PACKET,
 		PTR_TO_PACKET_META,
+		PTR_TO_MAP_KEY,
 		PTR_TO_MAP_VALUE,
 	},
 };
@@ -4080,6 +4129,7 @@ static const struct bpf_reg_types mem_types =3D {
 		PTR_TO_STACK,
 		PTR_TO_PACKET,
 		PTR_TO_PACKET_META,
+		PTR_TO_MAP_KEY,
 		PTR_TO_MAP_VALUE,
 		PTR_TO_MEM,
 		PTR_TO_RDONLY_BUF,
@@ -4092,6 +4142,7 @@ static const struct bpf_reg_types int_ptr_types =3D {
 		PTR_TO_STACK,
 		PTR_TO_PACKET,
 		PTR_TO_PACKET_META,
+		PTR_TO_MAP_KEY,
 		PTR_TO_MAP_VALUE,
 	},
 };
@@ -4104,6 +4155,8 @@ static const struct bpf_reg_types const_map_ptr_types=
 =3D { .types =3D { CONST_PTR_T
 static const struct bpf_reg_types btf_ptr_types =3D { .types =3D { PTR_TO_=
BTF_ID } };
 static const struct bpf_reg_types spin_lock_types =3D { .types =3D { PTR_T=
O_MAP_VALUE } };
 static const struct bpf_reg_types percpu_btf_ptr_types =3D { .types =3D { =
PTR_TO_PERCPU_BTF_ID } };
+static const struct bpf_reg_types func_ptr_types =3D { .types =3D { PTR_TO=
_FUNC } };
+static const struct bpf_reg_types stack_ptr_types =3D { .types =3D { PTR_T=
O_STACK } };
=20
 static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX=
] =3D {
 	[ARG_PTR_TO_MAP_KEY]		=3D &map_key_value_types,
@@ -4132,6 +4185,8 @@ static const struct bpf_reg_types *compatible_reg_typ=
es[__BPF_ARG_TYPE_MAX] =3D {
 	[ARG_PTR_TO_INT]		=3D &int_ptr_types,
 	[ARG_PTR_TO_LONG]		=3D &int_ptr_types,
 	[ARG_PTR_TO_PERCPU_BTF_ID]	=3D &percpu_btf_ptr_types,
+	[ARG_PTR_TO_FUNC]		=3D &func_ptr_types,
+	[ARG_PTR_TO_STACK_OR_NULL]	=3D &stack_ptr_types,
 };
=20
 static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
@@ -4932,12 +4987,92 @@ static int check_func_call(struct bpf_verifier_env =
*env, struct bpf_insn *insn,
 	return 0;
 }
=20
+static int check_map_elem_callback(struct bpf_verifier_env *env, int *insn=
_idx)
+{
+	struct bpf_verifier_state *state =3D env->cur_state;
+	struct bpf_prog_aux *aux =3D env->prog->aux;
+	struct bpf_func_state *caller, *callee;
+	struct bpf_map *map;
+	int err, subprog;
+
+	if (state->curframe + 1 >=3D MAX_CALL_FRAMES) {
+		verbose(env, "the call stack of %d frames is too deep\n",
+			state->curframe + 2);
+		return -E2BIG;
+	}
+
+	caller =3D state->frame[state->curframe];
+	if (state->frame[state->curframe + 1]) {
+		verbose(env, "verifier bug. Frame %d already allocated\n",
+			state->curframe + 1);
+		return -EFAULT;
+	}
+
+	caller->with_callback_fn =3D true;
+
+	callee =3D kzalloc(sizeof(*callee), GFP_KERNEL);
+	if (!callee)
+		return -ENOMEM;
+	state->frame[state->curframe + 1] =3D callee;
+
+	/* callee cannot access r0, r6 - r9 for reading and has to write
+	 * into its own stack before reading from it.
+	 * callee can read/write into caller's stack
+	 */
+	init_func_state(env, callee,
+			/* remember the callsite, it will be used by bpf_exit */
+			*insn_idx /* callsite */,
+			state->curframe + 1 /* frameno within this callchain */,
+			subprog /* subprog number within this prog */);
+
+	/* Transfer references to the callee */
+	err =3D transfer_reference_state(callee, caller);
+	if (err)
+		return err;
+
+	subprog =3D caller->regs[BPF_REG_2].subprog;
+	if (aux->func_info && aux->func_info_aux[subprog].linkage !=3D BTF_FUNC_S=
TATIC) {
+		verbose(env, "callback function R2 not static\n");
+		return -EINVAL;
+	}
+
+	map =3D caller->regs[BPF_REG_1].map_ptr;
+	if (!map->ops->map_set_for_each_callback_args ||
+	    !map->ops->map_for_each_callback) {
+		verbose(env, "callback function not allowed for map R1\n");
+		return -ENOTSUPP;
+	}
+
+	/* the following is only for hashmap, different maps
+	 * can have different callback signatures.
+	 */
+	err =3D map->ops->map_set_for_each_callback_args(env, caller, callee);
+	if (err)
+		return err;
+
+	clear_caller_saved_regs(env, caller->regs);
+
+	/* only increment it after check_reg_arg() finished */
+	state->curframe++;
+
+	/* and go analyze first insn of the callee */
+	*insn_idx =3D env->subprog_info[subprog].start - 1;
+
+	if (env->log.level & BPF_LOG_LEVEL) {
+		verbose(env, "caller:\n");
+		print_verifier_state(env, caller);
+		verbose(env, "callee:\n");
+		print_verifier_state(env, callee);
+	}
+	return 0;
+}
+
 static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 {
 	struct bpf_verifier_state *state =3D env->cur_state;
 	struct bpf_func_state *caller, *callee;
 	struct bpf_reg_state *r0;
-	int err;
+	int i, err;
=20
 	callee =3D state->frame[state->curframe];
 	r0 =3D &callee->regs[BPF_REG_0];
@@ -4955,7 +5090,17 @@ static int prepare_func_exit(struct bpf_verifier_env=
 *env, int *insn_idx)
 	state->curframe--;
 	caller =3D state->frame[state->curframe];
 	/* return to the caller whatever r0 had in the callee */
-	caller->regs[BPF_REG_0] =3D *r0;
+	if (caller->with_callback_fn) {
+		/* reset caller saved regs, the helper calling callback_fn
+		 * has RET_INTEGER return types.
+		 */
+		for (i =3D 0; i < CALLER_SAVED_REGS; i++)
+			mark_reg_not_init(env, caller->regs, caller_saved[i]);
+		caller->regs[BPF_REG_0].subreg_def =3D DEF_NOT_SUBREG;
+		mark_reg_unknown(env, caller->regs, BPF_REG_0);
+	} else {
+		caller->regs[BPF_REG_0] =3D *r0;
+	}
=20
 	/* Transfer references to the caller */
 	err =3D transfer_reference_state(caller, callee);
@@ -5091,7 +5236,8 @@ static int check_reference_leak(struct bpf_verifier_e=
nv *env)
 	return state->acquired_refs ? -EINVAL : 0;
 }
=20
-static int check_helper_call(struct bpf_verifier_env *env, int func_id, in=
t insn_idx)
+static int check_helper_call(struct bpf_verifier_env *env, int func_id, in=
t *insn_idx,
+			     bool map_elem_callback)
 {
 	const struct bpf_func_proto *fn =3D NULL;
 	struct bpf_reg_state *regs;
@@ -5151,11 +5297,11 @@ static int check_helper_call(struct bpf_verifier_en=
v *env, int func_id, int insn
 			return err;
 	}
=20
-	err =3D record_func_map(env, &meta, func_id, insn_idx);
+	err =3D record_func_map(env, &meta, func_id, *insn_idx);
 	if (err)
 		return err;
=20
-	err =3D record_func_key(env, &meta, func_id, insn_idx);
+	err =3D record_func_key(env, &meta, func_id, *insn_idx);
 	if (err)
 		return err;
=20
@@ -5163,7 +5309,7 @@ static int check_helper_call(struct bpf_verifier_env =
*env, int func_id, int insn
 	 * is inferred from register state.
 	 */
 	for (i =3D 0; i < meta.access_size; i++) {
-		err =3D check_mem_access(env, insn_idx, meta.regno, i, BPF_B,
+		err =3D check_mem_access(env, *insn_idx, meta.regno, i, BPF_B,
 				       BPF_WRITE, -1, false);
 		if (err)
 			return err;
@@ -5195,6 +5341,11 @@ static int check_helper_call(struct bpf_verifier_env=
 *env, int func_id, int insn
 		return -EINVAL;
 	}
=20
+	if (map_elem_callback) {
+		env->prog->aux->with_callback_fn =3D true;
+		return check_map_elem_callback(env, insn_idx);
+	}
+
 	/* reset caller saved regs */
 	for (i =3D 0; i < CALLER_SAVED_REGS; i++) {
 		mark_reg_not_init(env, regs, caller_saved[i]);
@@ -5306,7 +5457,7 @@ static int check_helper_call(struct bpf_verifier_env =
*env, int func_id, int insn
 		/* For release_reference() */
 		regs[BPF_REG_0].ref_obj_id =3D meta.ref_obj_id;
 	} else if (is_acquire_function(func_id, meta.map_ptr)) {
-		int id =3D acquire_reference_state(env, insn_idx);
+		int id =3D acquire_reference_state(env, *insn_idx);
=20
 		if (id < 0)
 			return id;
@@ -5448,6 +5599,14 @@ static int retrieve_ptr_limit(const struct bpf_reg_s=
tate *ptr_reg,
 		else
 			*ptr_limit =3D -off;
 		return 0;
+	case PTR_TO_MAP_KEY:
+		if (mask_to_left) {
+			*ptr_limit =3D ptr_reg->umax_value + ptr_reg->off;
+		} else {
+			off =3D ptr_reg->smin_value + ptr_reg->off;
+			*ptr_limit =3D ptr_reg->map_ptr->key_size - off;
+		}
+		return 0;
 	case PTR_TO_MAP_VALUE:
 		if (mask_to_left) {
 			*ptr_limit =3D ptr_reg->umax_value + ptr_reg->off;
@@ -5614,6 +5773,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifie=
r_env *env,
 		verbose(env, "R%d pointer arithmetic on %s prohibited\n",
 			dst, reg_type_str[ptr_reg->type]);
 		return -EACCES;
+	case PTR_TO_MAP_KEY:
 	case PTR_TO_MAP_VALUE:
 		if (!env->allow_ptr_leaks && !known && (smin_val < 0) !=3D (smax_val < 0=
)) {
 			verbose(env, "R%d has unknown scalar with mixed signed bounds, pointer =
arithmetic with it prohibited for !root\n",
@@ -7818,6 +7978,12 @@ static int check_ld_imm(struct bpf_verifier_env *env=
, struct bpf_insn *insn)
 		return 0;
 	}
=20
+	if (insn->src_reg =3D=3D BPF_PSEUDO_FUNC) {
+		dst_reg->type =3D PTR_TO_FUNC;
+		dst_reg->subprog =3D insn[1].imm;
+		return 0;
+	}
+
 	map =3D env->used_maps[aux->map_index];
 	mark_reg_known_zero(env, regs, insn->dst_reg);
 	dst_reg->map_ptr =3D map;
@@ -8195,9 +8361,23 @@ static int visit_insn(int t, int insn_cnt, struct bp=
f_verifier_env *env)
=20
 	/* All non-branch instructions have a single fall-through edge. */
 	if (BPF_CLASS(insns[t].code) !=3D BPF_JMP &&
-	    BPF_CLASS(insns[t].code) !=3D BPF_JMP32)
+	    BPF_CLASS(insns[t].code) !=3D BPF_JMP32 &&
+	    !bpf_pseudo_func(insns + t))
 		return push_insn(t, t + 1, FALLTHROUGH, env, false);
=20
+	if (bpf_pseudo_func(insns + t)) {
+		ret =3D push_insn(t, t + 1, FALLTHROUGH, env, false);
+		if (ret)
+			return ret;
+
+		if (t + 1 < insn_cnt)
+			init_explored_state(env, t + 1);
+		init_explored_state(env, t);
+		ret =3D push_insn(t, t + insns[t].imm + 1, BRANCH,
+				env, false);
+		return ret;
+	}
+
 	switch (BPF_OP(insns[t].code)) {
 	case BPF_EXIT:
 		return DONE_EXPLORING;
@@ -8819,6 +8999,7 @@ static bool regsafe(struct bpf_reg_state *rold, struc=
t bpf_reg_state *rcur,
 			 */
 			return false;
 		}
+	case PTR_TO_MAP_KEY:
 	case PTR_TO_MAP_VALUE:
 		/* If the new min/max/var_off satisfy the old ones and
 		 * everything else matches, we are OK.
@@ -9646,6 +9827,8 @@ static int do_check(struct bpf_verifier_env *env)
=20
 			env->jmps_processed++;
 			if (opcode =3D=3D BPF_CALL) {
+				bool map_elem_callback;
+
 				if (BPF_SRC(insn->code) !=3D BPF_K ||
 				    insn->off !=3D 0 ||
 				    (insn->src_reg !=3D BPF_REG_0 &&
@@ -9662,13 +9845,15 @@ static int do_check(struct bpf_verifier_env *env)
 					verbose(env, "function calls are not allowed while holding a lock\n");
 					return -EINVAL;
 				}
+				map_elem_callback =3D insn->src_reg !=3D BPF_PSEUDO_CALL &&
+						   insn->imm =3D=3D BPF_FUNC_for_each_map_elem;
 				if (insn->src_reg =3D=3D BPF_PSEUDO_CALL)
 					err =3D check_func_call(env, insn, &env->insn_idx);
 				else
-					err =3D check_helper_call(env, insn->imm, env->insn_idx);
+					err =3D check_helper_call(env, insn->imm, &env->insn_idx,
+								map_elem_callback);
 				if (err)
 					return err;
-
 			} else if (opcode =3D=3D BPF_JA) {
 				if (BPF_SRC(insn->code) !=3D BPF_K ||
 				    insn->imm !=3D 0 ||
@@ -10090,6 +10275,12 @@ static int resolve_pseudo_ldimm64(struct bpf_verif=
ier_env *env)
 				goto next_insn;
 			}
=20
+			if (insn[0].src_reg =3D=3D BPF_PSEUDO_FUNC) {
+				aux =3D &env->insn_aux_data[i];
+				aux->ptr_type =3D PTR_TO_FUNC;
+				goto next_insn;
+			}
+
 			/* In final convert_pseudo_ld_imm64() step, this is
 			 * converted into regular 64-bit imm load insn.
 			 */
@@ -10222,9 +10413,13 @@ static void convert_pseudo_ld_imm64(struct bpf_ver=
ifier_env *env)
 	int insn_cnt =3D env->prog->len;
 	int i;
=20
-	for (i =3D 0; i < insn_cnt; i++, insn++)
-		if (insn->code =3D=3D (BPF_LD | BPF_IMM | BPF_DW))
-			insn->src_reg =3D 0;
+	for (i =3D 0; i < insn_cnt; i++, insn++) {
+		if (insn->code !=3D (BPF_LD | BPF_IMM | BPF_DW))
+			continue;
+		if (insn->src_reg =3D=3D BPF_PSEUDO_FUNC)
+			continue;
+		insn->src_reg =3D 0;
+	}
 }
=20
 /* single env->prog->insni[off] instruction was replaced with the range
@@ -10846,6 +11041,12 @@ static int jit_subprogs(struct bpf_verifier_env *e=
nv)
 		return 0;
=20
 	for (i =3D 0, insn =3D prog->insnsi; i < prog->len; i++, insn++) {
+		if (bpf_pseudo_func(insn)) {
+			env->insn_aux_data[i].call_imm =3D insn->imm;
+			/* subprog is encoded in insn[1].imm */
+			continue;
+		}
+
 		if (!bpf_pseudo_call(insn))
 			continue;
 		/* Upon error here we cannot fall back to interpreter but
@@ -10975,6 +11176,12 @@ static int jit_subprogs(struct bpf_verifier_env *e=
nv)
 	for (i =3D 0; i < env->subprog_cnt; i++) {
 		insn =3D func[i]->insnsi;
 		for (j =3D 0; j < func[i]->len; j++, insn++) {
+			if (bpf_pseudo_func(insn)) {
+				subprog =3D insn[1].imm;
+				insn[0].imm =3D (u32)(long)func[subprog]->bpf_func;
+				insn[1].imm =3D ((u64)(long)func[subprog]->bpf_func) >> 32;
+				continue;
+			}
 			if (!bpf_pseudo_call(insn))
 				continue;
 			subprog =3D insn->off;
@@ -11020,6 +11227,11 @@ static int jit_subprogs(struct bpf_verifier_env *e=
nv)
 	 * later look the same as if they were interpreted only.
 	 */
 	for (i =3D 0, insn =3D prog->insnsi; i < prog->len; i++, insn++) {
+		if (bpf_pseudo_func(insn)) {
+			insn[0].imm =3D env->insn_aux_data[i].call_imm;
+			insn[1].imm =3D find_subprog(env, i + insn[0].imm + 1);
+			continue;
+		}
 		if (!bpf_pseudo_call(insn))
 			continue;
 		insn->off =3D env->insn_aux_data[i].call_imm;
@@ -11083,6 +11295,13 @@ static int fixup_call_args(struct bpf_verifier_env=
 *env)
 		verbose(env, "tail_calls are not allowed in non-JITed programs with bpf-=
to-bpf calls\n");
 		return -EINVAL;
 	}
+	if (env->subprog_cnt > 1 && env->prog->aux->with_callback_fn) {
+		/* When JIT fails the progs with callback calls
+		 * have to be rejected, since interpreter doesn't support them yet.
+		 */
+		verbose(env, "callbacks are not allowed in non-JITed programs\n");
+		return -EINVAL;
+	}
 	for (i =3D 0; i < prog->len; i++, insn++) {
 		if (!bpf_pseudo_call(insn))
 			continue;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 6c0018abe68a..8338333bfeb0 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1366,6 +1366,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, cons=
t struct bpf_prog *prog)
 		return &bpf_per_cpu_ptr_proto;
 	case BPF_FUNC_this_cpu_ptr:
 		return &bpf_this_cpu_ptr_proto;
+	case BPF_FUNC_for_each_map_elem:
+		return &bpf_for_each_map_elem_proto;
 	default:
 		return NULL;
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index c001766adcbc..d55bd4557376 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -393,6 +393,15 @@ enum bpf_link_type {
  *                   is struct/union.
  */
 #define BPF_PSEUDO_BTF_ID	3
+/* insn[0].src_reg:  BPF_PSEUDO_FUNC
+ * insn[0].imm:      insn offset to the func
+ * insn[1].imm:      0
+ * insn[0].off:      0
+ * insn[1].off:      0
+ * ldimm64 rewrite:  address of the function
+ * verifier type:    PTR_TO_FUNC.
+ */
+#define BPF_PSEUDO_FUNC		4
=20
 /* when bpf_call->src_reg =3D=3D BPF_PSEUDO_CALL, bpf_call->imm =3D=3D pc-=
relative
  * offset to another bpf function
@@ -3836,6 +3845,24 @@ union bpf_attr {
  *	Return
  *		A pointer to a struct socket on success or NULL if the file is
  *		not a socket.
+ *
+ * long bpf_for_each_map_elem(struct bpf_map *map, void *callback_fn, void=
 *callback_ctx, u64 flags)
+ *	Description
+ *		For each element in **map**, call **callback_fn** function with
+ *		**map**, **callback_ctx** and other map-specific parameters.
+ *		For example, for hash and array maps, the callback signature can
+ *		be `u64 callback_fn(map, map_key, map_value, callback_ctx)`.
+ *		The **callback_fn** should be a static function and
+ *		the **callback_ctx** should be a pointer to the stack.
+ *		The **flags** is used to control certain aspects of the helper.
+ *		Currently, the **flags** must be 0.
+ *
+ *		If **callback_fn** return 0, the helper will continue to the next
+ *		element. If return value is 1, the helper will skip the rest of
+ *		elements and return. Other return values are not used now.
+ *	Return
+ *		0 for success, **-EINVAL** for invalid **flags** or unsupported
+ *		**callback_fn** return value.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -4001,6 +4028,7 @@ union bpf_attr {
 	FN(ktime_get_coarse_ns),	\
 	FN(ima_inode_hash),		\
 	FN(sock_from_file),		\
+	FN(for_each_map_elem),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which help=
er
--=20
2.24.1

