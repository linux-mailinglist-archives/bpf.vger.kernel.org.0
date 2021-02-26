Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A42325CED
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 06:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhBZFOA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 00:14:00 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47874 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229537AbhBZFN6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 00:13:58 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11Q55t3w014984
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 21:13:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=GJN3wRiS5XU6NmiY2E8NjlZlAwQYN3rQlh9SqxZ1lrY=;
 b=dg4qgOA9sNSqVYESfIcu5l/jRhEGFOMpCLaiXxoKU+4q1nRhZi6PwEvTVkgsyMYgpG5R
 IPbCeJ7VVO+L2EOMUxuFscAyZJjYWtXjGV/9rbYVySfqhmopdH/fmQImzOz9PvWCs7Je
 ifsi2cpkFg74ZKn431STy3UYrc/VS3lvCH8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36xd17mqu3-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 21:13:16 -0800
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 25 Feb 2021 21:13:13 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 1A0B03705B54; Thu, 25 Feb 2021 21:13:10 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v4 05/12] bpf: add bpf_for_each_map_elem() helper
Date:   Thu, 25 Feb 2021 21:13:10 -0800
Message-ID: <20210226051310.3428705-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210226051305.3428235-1-yhs@fb.com>
References: <20210226051305.3428235-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_01:2021-02-24,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 clxscore=1015 priorityscore=1501 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260038
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

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h            |  13 +++
 include/linux/bpf_verifier.h   |   3 +
 include/uapi/linux/bpf.h       |  39 ++++++-
 kernel/bpf/bpf_iter.c          |  16 +++
 kernel/bpf/helpers.c           |   2 +
 kernel/bpf/verifier.c          | 208 ++++++++++++++++++++++++++++++---
 kernel/trace/bpf_trace.c       |   2 +
 tools/include/uapi/linux/bpf.h |  39 ++++++-
 8 files changed, 307 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cccaef1088ea..40f41a9b40f9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -39,6 +39,7 @@ struct bpf_local_storage;
 struct bpf_local_storage_map;
 struct kobject;
 struct mem_cgroup;
+struct bpf_func_state;
=20
 extern struct idr btf_idr;
 extern spinlock_t btf_idr_lock;
@@ -129,6 +130,13 @@ struct bpf_map_ops {
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
@@ -295,6 +303,8 @@ enum bpf_arg_type {
 	ARG_CONST_ALLOC_SIZE_OR_ZERO,	/* number of allocated bytes requested */
 	ARG_PTR_TO_BTF_ID_SOCK_COMMON,	/* pointer to in-kernel sock_common or bpf=
-mirrored bpf_sock */
 	ARG_PTR_TO_PERCPU_BTF_ID,	/* pointer to in-kernel percpu type */
+	ARG_PTR_TO_FUNC,	/* pointer to a bpf program function */
+	ARG_PTR_TO_STACK_OR_NULL,	/* pointer to stack or NULL */
 	__BPF_ARG_TYPE_MAX,
 };
=20
@@ -411,6 +421,8 @@ enum bpf_reg_type {
 	PTR_TO_RDWR_BUF,	 /* reg points to a read/write buffer */
 	PTR_TO_RDWR_BUF_OR_NULL, /* reg points to a read/write buffer or NULL */
 	PTR_TO_PERCPU_BTF_ID,	 /* reg points to a percpu kernel variable */
+	PTR_TO_FUNC,		 /* reg points to a bpf program function */
+	PTR_TO_MAP_KEY,		 /* reg points to a map element key */
 };
=20
 /* The information passed from prog-specific *_is_valid_access
@@ -1886,6 +1898,7 @@ extern const struct bpf_func_proto bpf_this_cpu_ptr_p=
roto;
 extern const struct bpf_func_proto bpf_ktime_get_coarse_ns_proto;
 extern const struct bpf_func_proto bpf_sock_from_file_proto;
 extern const struct bpf_func_proto bpf_get_socket_ptr_cookie_proto;
+extern const struct bpf_func_proto bpf_for_each_map_elem_proto;
=20
 const struct bpf_func_proto *bpf_tracing_func_proto(
 	enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 971b33aca13d..51c2ffa3d901 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -68,6 +68,8 @@ struct bpf_reg_state {
 			unsigned long raw1;
 			unsigned long raw2;
 		} raw;
+
+		u32 subprogno; /* for PTR_TO_FUNC */
 	};
 	/* For PTR_TO_PACKET, used to find other pointers with the same variable
 	 * offset, so they can share range knowledge.
@@ -204,6 +206,7 @@ struct bpf_func_state {
 	int acquired_refs;
 	struct bpf_reference_state *refs;
 	int allocated_stack;
+	bool in_callback_fn;
 	struct bpf_stack_state *stack;
 };
=20
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 4c24daa43bac..354aaaee8bd9 100644
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
@@ -3850,7 +3859,6 @@ union bpf_attr {
  *
  * long bpf_check_mtu(void *ctx, u32 ifindex, u32 *mtu_len, s32 len_diff, =
u64 flags)
  *	Description
-
  *		Check ctx packet size against exceeding MTU of net device (based
  *		on *ifindex*).  This helper will likely be used in combination
  *		with helpers that adjust/change the packet size.
@@ -3910,6 +3918,34 @@ union bpf_attr {
  *		* **BPF_MTU_CHK_RET_FRAG_NEEDED**
  *		* **BPF_MTU_CHK_RET_SEGS_TOOBIG**
  *
+ * long bpf_for_each_map_elem(struct bpf_map *map, void *callback_fn, void=
 *callback_ctx, u64 flags)
+ *	Description
+ *		For each element in **map**, call **callback_fn** function with
+ *		**map**, **callback_ctx** and other map-specific parameters.
+ *		The **callback_fn** should be a static function and
+ *		the **callback_ctx** should be a pointer to the stack.
+ *		The **flags** is used to control certain aspects of the helper.
+ *		Currently, the **flags** must be 0.
+ *
+ *		The following are a list of supported map types and their
+ *		respective expected callback signatures:
+ *
+ *		BPF_MAP_TYPE_HASH, BPF_MAP_TYPE_PERCPU_HASH,
+ *		BPF_MAP_TYPE_LRU_HASH, BPF_MAP_TYPE_LRU_PERCPU_HASH,
+ *		BPF_MAP_TYPE_ARRAY, BPF_MAP_TYPE_PERCPU_ARRAY:
+ *		    long (*callback_fn)(struct bpf_map *map, const void *key,
+ *		    			void *value, void *ctx);
+ *
+ *		For per_cpu maps, the map_value is the value on the cpu where the
+ *		bpf_prog is running.
+ *
+ *		If **callback_fn** return 0, the helper will continue to the next
+ *		element. If return value is 1, the helper will skip the rest of
+ *		elements and return. Other return values are not used now.
+ *
+ *	Return
+ *		The number of traversed map elements for success, **-EINVAL** for
+ *		invalid **flags**.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -4076,6 +4112,7 @@ union bpf_attr {
 	FN(ima_inode_hash),		\
 	FN(sock_from_file),		\
 	FN(check_mtu),			\
+	FN(for_each_map_elem),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which help=
er
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index a0d9eade9c80..931870f9cf56 100644
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
index dd860ce1f591..a395346776dc 100644
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
@@ -248,6 +254,7 @@ struct bpf_call_arg_meta {
 	u32 btf_id;
 	struct btf *ret_btf;
 	u32 ret_btf_id;
+	u32 subprogno;
 };
=20
 struct btf *btf_vmlinux;
@@ -427,6 +434,7 @@ static bool reg_type_not_null(enum bpf_reg_type type)
 	return type =3D=3D PTR_TO_SOCKET ||
 		type =3D=3D PTR_TO_TCP_SOCK ||
 		type =3D=3D PTR_TO_MAP_VALUE ||
+		type =3D=3D PTR_TO_MAP_KEY ||
 		type =3D=3D PTR_TO_SOCK_COMMON;
 }
=20
@@ -469,7 +477,8 @@ static bool arg_type_may_be_null(enum bpf_arg_type type)
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
@@ -552,6 +561,8 @@ static const char * const reg_type_str[] =3D {
 	[PTR_TO_RDONLY_BUF_OR_NULL] =3D "rdonly_buf_or_null",
 	[PTR_TO_RDWR_BUF]	=3D "rdwr_buf",
 	[PTR_TO_RDWR_BUF_OR_NULL] =3D "rdwr_buf_or_null",
+	[PTR_TO_FUNC]		=3D "func",
+	[PTR_TO_MAP_KEY]	=3D "map_key",
 };
=20
 static char slot_type_char[] =3D {
@@ -623,6 +634,7 @@ static void print_verifier_state(struct bpf_verifier_en=
v *env,
 			if (type_is_pkt_pointer(t))
 				verbose(env, ",r=3D%d", reg->range);
 			else if (t =3D=3D CONST_PTR_TO_MAP ||
+				 t =3D=3D PTR_TO_MAP_KEY ||
 				 t =3D=3D PTR_TO_MAP_VALUE ||
 				 t =3D=3D PTR_TO_MAP_VALUE_OR_NULL)
 				verbose(env, ",ks=3D%d,vs=3D%d",
@@ -1555,6 +1567,19 @@ static int check_subprogs(struct bpf_verifier_env *e=
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
+			insn[i + 1].imm =3D ret;
+			continue;
+		}
 		if (!bpf_pseudo_call(insn + i))
 			continue;
 		if (!env->bpf_capable) {
@@ -2286,6 +2311,8 @@ static bool is_spillable_regtype(enum bpf_reg_type ty=
pe)
 	case PTR_TO_PERCPU_BTF_ID:
 	case PTR_TO_MEM:
 	case PTR_TO_MEM_OR_NULL:
+	case PTR_TO_FUNC:
+	case PTR_TO_MAP_KEY:
 		return true;
 	default:
 		return false;
@@ -2890,6 +2917,10 @@ static int __check_mem_access(struct bpf_verifier_en=
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
@@ -3295,6 +3326,9 @@ static int check_ptr_alignment(struct bpf_verifier_en=
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
@@ -3396,7 +3430,7 @@ static int check_max_stack_depth(struct bpf_verifier_=
env *env)
 continue_func:
 	subprog_end =3D subprog[idx + 1].start;
 	for (; i < subprog_end; i++) {
-		if (!bpf_pseudo_call(insn + i))
+		if (!bpf_pseudo_call(insn + i) && !bpf_pseudo_func(insn + i))
 			continue;
 		/* remember insn and function to return to */
 		ret_insn[frame] =3D i + 1;
@@ -3833,7 +3867,19 @@ static int check_mem_access(struct bpf_verifier_env =
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
@@ -4249,6 +4295,9 @@ static int check_helper_mem_access(struct bpf_verifie=
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
@@ -4465,6 +4514,7 @@ static const struct bpf_reg_types map_key_value_types=
 =3D {
 		PTR_TO_STACK,
 		PTR_TO_PACKET,
 		PTR_TO_PACKET_META,
+		PTR_TO_MAP_KEY,
 		PTR_TO_MAP_VALUE,
 	},
 };
@@ -4496,6 +4546,7 @@ static const struct bpf_reg_types mem_types =3D {
 		PTR_TO_STACK,
 		PTR_TO_PACKET,
 		PTR_TO_PACKET_META,
+		PTR_TO_MAP_KEY,
 		PTR_TO_MAP_VALUE,
 		PTR_TO_MEM,
 		PTR_TO_RDONLY_BUF,
@@ -4508,6 +4559,7 @@ static const struct bpf_reg_types int_ptr_types =3D {
 		PTR_TO_STACK,
 		PTR_TO_PACKET,
 		PTR_TO_PACKET_META,
+		PTR_TO_MAP_KEY,
 		PTR_TO_MAP_VALUE,
 	},
 };
@@ -4520,6 +4572,8 @@ static const struct bpf_reg_types const_map_ptr_types=
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
@@ -4548,6 +4602,8 @@ static const struct bpf_reg_types *compatible_reg_typ=
es[__BPF_ARG_TYPE_MAX] =3D {
 	[ARG_PTR_TO_INT]		=3D &int_ptr_types,
 	[ARG_PTR_TO_LONG]		=3D &int_ptr_types,
 	[ARG_PTR_TO_PERCPU_BTF_ID]	=3D &percpu_btf_ptr_types,
+	[ARG_PTR_TO_FUNC]		=3D &func_ptr_types,
+	[ARG_PTR_TO_STACK_OR_NULL]	=3D &stack_ptr_types,
 };
=20
 static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
@@ -4729,6 +4785,8 @@ static int check_func_arg(struct bpf_verifier_env *en=
v, u32 arg,
 			verbose(env, "verifier internal error\n");
 			return -EFAULT;
 		}
+	} else if (arg_type =3D=3D ARG_PTR_TO_FUNC) {
+		meta->subprogno =3D reg->subprogno;
 	} else if (arg_type_is_mem_ptr(arg_type)) {
 		/* The access to this pointer is only checked when we hit the
 		 * next is_mem_size argument below.
@@ -5375,6 +5433,35 @@ static int check_func_call(struct bpf_verifier_env *=
env, struct bpf_insn *insn,
 	return __check_func_call(env, insn, insn_idx, subprog, set_callee_state);
 }
=20
+static int set_map_elem_callback_state(struct bpf_verifier_env *env,
+				       struct bpf_func_state *caller,
+				       struct bpf_func_state *callee,
+				       int insn_idx)
+{
+	struct bpf_insn_aux_data *insn_aux =3D &env->insn_aux_data[insn_idx];
+	struct bpf_map *map;
+	int err;
+
+	if (bpf_map_ptr_poisoned(insn_aux)) {
+		verbose(env, "tail_call abusing map_ptr\n");
+		return -EINVAL;
+	}
+
+	map =3D BPF_MAP_PTR(insn_aux->map_ptr_state);
+	if (!map->ops->map_set_for_each_callback_args ||
+	    !map->ops->map_for_each_callback) {
+		verbose(env, "callback function not allowed for map\n");
+		return -ENOTSUPP;
+	}
+
+	err =3D map->ops->map_set_for_each_callback_args(env, caller, callee);
+	if (err)
+		return err;
+
+	callee->in_callback_fn =3D true;
+	return 0;
+}
+
 static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 {
 	struct bpf_verifier_state *state =3D env->cur_state;
@@ -5397,8 +5484,22 @@ static int prepare_func_exit(struct bpf_verifier_env=
 *env, int *insn_idx)
=20
 	state->curframe--;
 	caller =3D state->frame[state->curframe];
-	/* return to the caller whatever r0 had in the callee */
-	caller->regs[BPF_REG_0] =3D *r0;
+	if (callee->in_callback_fn) {
+		/* enforce R0 return value range [0, 1]. */
+		struct tnum range =3D tnum_range(0, 1);
+
+		if (r0->type !=3D SCALAR_VALUE) {
+			verbose(env, "R0 not a scalar value\n");
+			return -EACCES;
+		}
+		if (!tnum_in(range, r0->var_off)) {
+			verbose_invalid_scalar(env, r0, &range, "callback return", "R0");
+			return -EINVAL;
+		}
+	} else {
+		/* return to the caller whatever r0 had in the callee */
+		caller->regs[BPF_REG_0] =3D *r0;
+	}
=20
 	/* Transfer references to the caller */
 	err =3D transfer_reference_state(caller, callee);
@@ -5453,7 +5554,8 @@ record_func_map(struct bpf_verifier_env *env, struct =
bpf_call_arg_meta *meta,
 	    func_id !=3D BPF_FUNC_map_delete_elem &&
 	    func_id !=3D BPF_FUNC_map_push_elem &&
 	    func_id !=3D BPF_FUNC_map_pop_elem &&
-	    func_id !=3D BPF_FUNC_map_peek_elem)
+	    func_id !=3D BPF_FUNC_map_peek_elem &&
+	    func_id !=3D BPF_FUNC_for_each_map_elem)
 		return 0;
=20
 	if (map =3D=3D NULL) {
@@ -5534,15 +5636,18 @@ static int check_reference_leak(struct bpf_verifier=
_env *env)
 	return state->acquired_refs ? -EINVAL : 0;
 }
=20
-static int check_helper_call(struct bpf_verifier_env *env, int func_id, in=
t insn_idx)
+static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn=
 *insn,
+			     int *insn_idx_p)
 {
 	const struct bpf_func_proto *fn =3D NULL;
 	struct bpf_reg_state *regs;
 	struct bpf_call_arg_meta meta;
+	int insn_idx =3D *insn_idx_p;
 	bool changes_data;
-	int i, err;
+	int i, err, func_id;
=20
 	/* find function prototype */
+	func_id =3D insn->imm;
 	if (func_id < 0 || func_id >=3D __BPF_FUNC_MAX_ID) {
 		verbose(env, "invalid func %s#%d\n", func_id_name(func_id),
 			func_id);
@@ -5638,6 +5743,13 @@ static int check_helper_call(struct bpf_verifier_env=
 *env, int func_id, int insn
 		return -EINVAL;
 	}
=20
+	if (func_id =3D=3D BPF_FUNC_for_each_map_elem) {
+		err =3D __check_func_call(env, insn, insn_idx_p, meta.subprogno,
+					set_map_elem_callback_state);
+		if (err < 0)
+			return -EINVAL;
+	}
+
 	/* reset caller saved regs */
 	for (i =3D 0; i < CALLER_SAVED_REGS; i++) {
 		mark_reg_not_init(env, regs, caller_saved[i]);
@@ -5891,6 +6003,19 @@ static int retrieve_ptr_limit(const struct bpf_reg_s=
tate *ptr_reg,
 		else
 			*ptr_limit =3D -off;
 		return 0;
+	case PTR_TO_MAP_KEY:
+		/* Currently, this code is not exercised as the only use
+		 * is bpf_for_each_map_elem() helper which requires
+		 * bpf_capble. The code has been tested manually for
+		 * future use.
+		 */
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
@@ -6092,6 +6217,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifie=
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
@@ -8271,6 +8397,24 @@ static int check_ld_imm(struct bpf_verifier_env *env=
, struct bpf_insn *insn)
 		return 0;
 	}
=20
+	if (insn->src_reg =3D=3D BPF_PSEUDO_FUNC) {
+		struct bpf_prog_aux *aux =3D env->prog->aux;
+		u32 subprogno =3D insn[1].imm;
+
+		if (!aux->func_info) {
+			verbose(env, "missing btf func_info\n");
+			return -EINVAL;
+		}
+		if (aux->func_info_aux[subprogno].linkage !=3D BTF_FUNC_STATIC) {
+			verbose(env, "callback function not static\n");
+			return -EINVAL;
+		}
+
+		dst_reg->type =3D PTR_TO_FUNC;
+		dst_reg->subprogno =3D subprogno;
+		return 0;
+	}
+
 	map =3D env->used_maps[aux->map_index];
 	mark_reg_known_zero(env, regs, insn->dst_reg);
 	dst_reg->map_ptr =3D map;
@@ -8657,6 +8801,9 @@ static int visit_insn(int t, int insn_cnt, struct bpf=
_verifier_env *env)
 	struct bpf_insn *insns =3D env->prog->insnsi;
 	int ret;
=20
+	if (bpf_pseudo_func(insns + t))
+		return visit_func_call_insn(t, insn_cnt, insns, env, true);
+
 	/* All non-branch instructions have a single fall-through edge. */
 	if (BPF_CLASS(insns[t].code) !=3D BPF_JMP &&
 	    BPF_CLASS(insns[t].code) !=3D BPF_JMP32)
@@ -9277,6 +9424,7 @@ static bool regsafe(struct bpf_reg_state *rold, struc=
t bpf_reg_state *rcur,
 			 */
 			return false;
 		}
+	case PTR_TO_MAP_KEY:
 	case PTR_TO_MAP_VALUE:
 		/* If the new min/max/var_off satisfy the old ones and
 		 * everything else matches, we are OK.
@@ -10123,10 +10271,9 @@ static int do_check(struct bpf_verifier_env *env)
 				if (insn->src_reg =3D=3D BPF_PSEUDO_CALL)
 					err =3D check_func_call(env, insn, &env->insn_idx);
 				else
-					err =3D check_helper_call(env, insn->imm, env->insn_idx);
+					err =3D check_helper_call(env, insn, &env->insn_idx);
 				if (err)
 					return err;
-
 			} else if (opcode =3D=3D BPF_JA) {
 				if (BPF_SRC(insn->code) !=3D BPF_K ||
 				    insn->imm !=3D 0 ||
@@ -10555,6 +10702,12 @@ static int resolve_pseudo_ldimm64(struct bpf_verif=
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
@@ -10687,9 +10840,13 @@ static void convert_pseudo_ld_imm64(struct bpf_ver=
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
@@ -11330,6 +11487,12 @@ static int jit_subprogs(struct bpf_verifier_env *e=
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
@@ -11459,6 +11622,12 @@ static int jit_subprogs(struct bpf_verifier_env *e=
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
@@ -11504,6 +11673,11 @@ static int jit_subprogs(struct bpf_verifier_env *e=
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
@@ -11568,6 +11742,14 @@ static int fixup_call_args(struct bpf_verifier_env=
 *env)
 		return -EINVAL;
 	}
 	for (i =3D 0; i < prog->len; i++, insn++) {
+		if (bpf_pseudo_func(insn)) {
+			/* When JIT fails the progs with callback calls
+			 * have to be rejected, since interpreter doesn't support them yet.
+			 */
+			verbose(env, "callbacks are not allowed in non-JITed programs\n");
+			return -EINVAL;
+		}
+
 		if (!bpf_pseudo_call(insn))
 			continue;
 		depth =3D get_callee_stack_depth(env, insn, i);
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index b0c45d923f0f..1979271937fe 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1367,6 +1367,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, cons=
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
index 4c24daa43bac..354aaaee8bd9 100644
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
@@ -3850,7 +3859,6 @@ union bpf_attr {
  *
  * long bpf_check_mtu(void *ctx, u32 ifindex, u32 *mtu_len, s32 len_diff, =
u64 flags)
  *	Description
-
  *		Check ctx packet size against exceeding MTU of net device (based
  *		on *ifindex*).  This helper will likely be used in combination
  *		with helpers that adjust/change the packet size.
@@ -3910,6 +3918,34 @@ union bpf_attr {
  *		* **BPF_MTU_CHK_RET_FRAG_NEEDED**
  *		* **BPF_MTU_CHK_RET_SEGS_TOOBIG**
  *
+ * long bpf_for_each_map_elem(struct bpf_map *map, void *callback_fn, void=
 *callback_ctx, u64 flags)
+ *	Description
+ *		For each element in **map**, call **callback_fn** function with
+ *		**map**, **callback_ctx** and other map-specific parameters.
+ *		The **callback_fn** should be a static function and
+ *		the **callback_ctx** should be a pointer to the stack.
+ *		The **flags** is used to control certain aspects of the helper.
+ *		Currently, the **flags** must be 0.
+ *
+ *		The following are a list of supported map types and their
+ *		respective expected callback signatures:
+ *
+ *		BPF_MAP_TYPE_HASH, BPF_MAP_TYPE_PERCPU_HASH,
+ *		BPF_MAP_TYPE_LRU_HASH, BPF_MAP_TYPE_LRU_PERCPU_HASH,
+ *		BPF_MAP_TYPE_ARRAY, BPF_MAP_TYPE_PERCPU_ARRAY:
+ *		    long (*callback_fn)(struct bpf_map *map, const void *key,
+ *		    			void *value, void *ctx);
+ *
+ *		For per_cpu maps, the map_value is the value on the cpu where the
+ *		bpf_prog is running.
+ *
+ *		If **callback_fn** return 0, the helper will continue to the next
+ *		element. If return value is 1, the helper will skip the rest of
+ *		elements and return. Other return values are not used now.
+ *
+ *	Return
+ *		The number of traversed map elements for success, **-EINVAL** for
+ *		invalid **flags**.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -4076,6 +4112,7 @@ union bpf_attr {
 	FN(ima_inode_hash),		\
 	FN(sock_from_file),		\
 	FN(check_mtu),			\
+	FN(for_each_map_elem),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which help=
er
--=20
2.24.1

