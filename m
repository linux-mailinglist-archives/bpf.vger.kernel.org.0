Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0669D2028EF
	for <lists+bpf@lfdr.de>; Sun, 21 Jun 2020 07:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbgFUFzN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Jun 2020 01:55:13 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22698 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729287AbgFUFzM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 21 Jun 2020 01:55:12 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05L5pAbi004168
        for <bpf@vger.kernel.org>; Sat, 20 Jun 2020 22:55:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=X3WAyi41OM+prABfvvnlP1ZeSHwxg/59J6e+VZgmFC4=;
 b=q0tzmysK9A8vpSnWNrEp0AvYB4dGk2DVm3KPHpW7YB5spKsPkVbjGAev2t8OywLenkDU
 pc5fq4pV6SUW9fYbhlaV+re2aqus0+2cvLTUKvjDGJT5CMx5XdVvnHdtzy8BWhgWXSSr
 7CxEK3Z20SViqt2WJr9ZkNnjqWmdios+++Y= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31segatsue-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 20 Jun 2020 22:55:10 -0700
Received: from intmgw005.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 20 Jun 2020 22:55:09 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 3BCD337052DE; Sat, 20 Jun 2020 22:55:05 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v2 05/15] bpf: add bpf_skc_to_tcp6_sock() helper
Date:   Sat, 20 Jun 2020 22:55:05 -0700
Message-ID: <20200621055505.2629793-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200621055459.2629116-1-yhs@fb.com>
References: <20200621055459.2629116-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-20_16:2020-06-19,2020-06-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 cotscore=-2147483648
 adultscore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 spamscore=0 suspectscore=43 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006210047
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The helper is used in tracing programs to cast a socket
pointer to a tcp6_sock pointer.
The return value could be NULL if the casting is illegal.

A new helper return type RET_PTR_TO_BTF_ID_OR_NULL is added
so the verifier is able to deduce proper return types for the helper.

Different from the previous BTF_ID based helpers,
the bpf_skc_to_tcp6_sock() argument can be several possible
btf_ids. More specifically, all possible socket data structures
with sock_common appearing in the first in the memory layout.
This patch only added socket types related to tcp and udp.

All possible argument btf_id and return value btf_id
for helper bpf_skc_to_tcp6_sock() are pre-calculcated and
cached. In the future, it is even possible to precompute
these btf_id's at kernel build time.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h            | 12 +++++
 include/uapi/linux/bpf.h       |  9 +++-
 kernel/bpf/btf.c               |  1 +
 kernel/bpf/verifier.c          | 43 +++++++++++++-----
 kernel/trace/bpf_trace.c       |  2 +
 net/core/filter.c              | 80 ++++++++++++++++++++++++++++++++++
 scripts/bpf_helpers_doc.py     |  2 +
 tools/include/uapi/linux/bpf.h |  9 +++-
 8 files changed, 145 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 07052d44bca1..0c658f78e939 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -261,6 +261,7 @@ enum bpf_return_type {
 	RET_PTR_TO_TCP_SOCK_OR_NULL,	/* returns a pointer to a tcp_sock or NULL=
 */
 	RET_PTR_TO_SOCK_COMMON_OR_NULL,	/* returns a pointer to a sock_common o=
r NULL */
 	RET_PTR_TO_ALLOC_MEM_OR_NULL,	/* returns a pointer to dynamically alloc=
ated memory or NULL */
+	RET_PTR_TO_BTF_ID_OR_NULL,	/* returns a pointer to a btf_id or NULL */
 };
=20
 /* eBPF function prototype used by verifier to allow BPF_CALLs from eBPF=
 programs
@@ -283,6 +284,12 @@ struct bpf_func_proto {
 		enum bpf_arg_type arg_type[5];
 	};
 	int *btf_id; /* BTF ids of arguments */
+	bool (*check_btf_id)(u32 btf_id, u32 arg); /* if the argument btf_id is
+						    * valid. Often used if more
+						    * than one btf id is permitted
+						    * for this argument.
+						    */
+	int *ret_btf_id; /* return value btf_id */
 };
=20
 /* bpf_context is intentionally undefined structure. Pointer to bpf_cont=
ext is
@@ -1629,6 +1636,7 @@ extern const struct bpf_func_proto bpf_ringbuf_rese=
rve_proto;
 extern const struct bpf_func_proto bpf_ringbuf_submit_proto;
 extern const struct bpf_func_proto bpf_ringbuf_discard_proto;
 extern const struct bpf_func_proto bpf_ringbuf_query_proto;
+extern const struct bpf_func_proto bpf_skc_to_tcp6_sock_proto;
=20
 const struct bpf_func_proto *bpf_tracing_func_proto(
 	enum bpf_func_id func_id, const struct bpf_prog *prog);
@@ -1652,6 +1660,7 @@ u32 bpf_sock_convert_ctx_access(enum bpf_access_typ=
e type,
 				struct bpf_insn *insn_buf,
 				struct bpf_prog *prog,
 				u32 *target_size);
+void init_sock_cast_types(struct btf *btf);
 #else
 static inline bool bpf_sock_common_is_valid_access(int off, int size,
 						   enum bpf_access_type type,
@@ -1673,6 +1682,9 @@ static inline u32 bpf_sock_convert_ctx_access(enum =
bpf_access_type type,
 {
 	return 0;
 }
+static inline void init_sock_cast_types(struct btf *btf)
+{
+}
 #endif
=20
 #ifdef CONFIG_INET
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 19684813faae..394fcba27b6a 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3252,6 +3252,12 @@ union bpf_attr {
  * 		case of **BPF_CSUM_LEVEL_QUERY**, the current skb->csum_level
  * 		is returned or the error code -EACCES in case the skb is not
  * 		subject to CHECKSUM_UNNECESSARY.
+ *
+ * struct tcp6_sock *bpf_skc_to_tcp6_sock(void *sk)
+ *	Description
+ *		Dynamically cast a *sk* pointer to a *tcp6_sock* pointer.
+ *	Return
+ *		*sk* if casting is valid, or NULL otherwise.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3389,7 +3395,8 @@ union bpf_attr {
 	FN(ringbuf_submit),		\
 	FN(ringbuf_discard),		\
 	FN(ringbuf_query),		\
-	FN(csum_level),
+	FN(csum_level),			\
+	FN(skc_to_tcp6_sock),
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
  * function eBPF program intends to call
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 58c9af1d4808..a6413cef9c36 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3645,6 +3645,7 @@ struct btf *btf_parse_vmlinux(void)
 	}
=20
 	bpf_struct_ops_init(btf, log);
+	init_sock_cast_types(btf);
=20
 	btf_verifier_env_free(env);
 	refcount_set(&btf->refcnt, 1);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a1857c4ffaaf..633003046e49 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3735,12 +3735,14 @@ static int int_ptr_type_to_size(enum bpf_arg_type=
 type)
 	return -EINVAL;
 }
=20
-static int check_func_arg(struct bpf_verifier_env *env, u32 regno,
-			  enum bpf_arg_type arg_type,
-			  struct bpf_call_arg_meta *meta)
+static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
+			  struct bpf_call_arg_meta *meta,
+			  const struct bpf_func_proto *fn)
 {
+	u32 regno =3D BPF_REG_1 + arg;
 	struct bpf_reg_state *regs =3D cur_regs(env), *reg =3D &regs[regno];
 	enum bpf_reg_type expected_type, type =3D reg->type;
+	enum bpf_arg_type arg_type =3D fn->arg_type[arg];
 	int err =3D 0;
=20
 	if (arg_type =3D=3D ARG_DONTCARE)
@@ -3820,9 +3822,16 @@ static int check_func_arg(struct bpf_verifier_env =
*env, u32 regno,
 		expected_type =3D PTR_TO_BTF_ID;
 		if (type !=3D expected_type)
 			goto err_type;
-		if (reg->btf_id !=3D meta->btf_id) {
-			verbose(env, "Helper has type %s got %s in R%d\n",
-				kernel_type_name(meta->btf_id),
+		if (!fn->check_btf_id) {
+			if (reg->btf_id !=3D meta->btf_id) {
+				verbose(env, "Helper has type %s got %s in R%d\n",
+					kernel_type_name(meta->btf_id),
+					kernel_type_name(reg->btf_id), regno);
+
+				return -EACCES;
+			}
+		} else if (!fn->check_btf_id(reg->btf_id, arg)) {
+			verbose(env, "Helper does not support %s in R%d\n",
 				kernel_type_name(reg->btf_id), regno);
=20
 			return -EACCES;
@@ -4600,7 +4609,7 @@ static int check_helper_call(struct bpf_verifier_en=
v *env, int func_id, int insn
 	struct bpf_reg_state *regs;
 	struct bpf_call_arg_meta meta;
 	bool changes_data;
-	int i, err;
+	int i, err, ret_btf_id;
=20
 	/* find function prototype */
 	if (func_id < 0 || func_id >=3D __BPF_FUNC_MAX_ID) {
@@ -4644,10 +4653,12 @@ static int check_helper_call(struct bpf_verifier_=
env *env, int func_id, int insn
 	meta.func_id =3D func_id;
 	/* check args */
 	for (i =3D 0; i < 5; i++) {
-		err =3D btf_resolve_helper_id(&env->log, fn, i);
-		if (err > 0)
-			meta.btf_id =3D err;
-		err =3D check_func_arg(env, BPF_REG_1 + i, fn->arg_type[i], &meta);
+		if (!fn->check_btf_id) {
+			err =3D btf_resolve_helper_id(&env->log, fn, i);
+			if (err > 0)
+				meta.btf_id =3D err;
+		}
+		err =3D check_func_arg(env, i, &meta, fn);
 		if (err)
 			return err;
 	}
@@ -4750,6 +4761,16 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, int func_id, int insn
 		regs[BPF_REG_0].type =3D PTR_TO_MEM_OR_NULL;
 		regs[BPF_REG_0].id =3D ++env->id_gen;
 		regs[BPF_REG_0].mem_size =3D meta.mem_size;
+	} else if (fn->ret_type =3D=3D RET_PTR_TO_BTF_ID_OR_NULL) {
+		mark_reg_known_zero(env, regs, BPF_REG_0);
+		regs[BPF_REG_0].type =3D PTR_TO_BTF_ID_OR_NULL;
+		ret_btf_id =3D *fn->ret_btf_id;
+		if (ret_btf_id =3D=3D 0) {
+			verbose(env, "invalid return type %d of func %s#%d\n",
+				fn->ret_type, func_id_name(func_id), func_id);
+			return -EINVAL;
+		}
+		regs[BPF_REG_0].btf_id =3D ret_btf_id;
 	} else {
 		verbose(env, "unknown return type %d of func %s#%d\n",
 			fn->ret_type, func_id_name(func_id), func_id);
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index afaec7e082d9..478c10d1ec33 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1515,6 +1515,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id, c=
onst struct bpf_prog *prog)
 		return &bpf_skb_output_proto;
 	case BPF_FUNC_xdp_output:
 		return &bpf_xdp_output_proto;
+	case BPF_FUNC_skc_to_tcp6_sock:
+		return &bpf_skc_to_tcp6_sock_proto;
 #endif
 	case BPF_FUNC_seq_printf:
 		return prog->expected_attach_type =3D=3D BPF_TRACE_ITER ?
diff --git a/net/core/filter.c b/net/core/filter.c
index 73395384afe2..8ca365c5bd10 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -47,6 +47,7 @@
 #include <linux/seccomp.h>
 #include <linux/if_vlan.h>
 #include <linux/bpf.h>
+#include <linux/btf.h>
 #include <net/sch_generic.h>
 #include <net/cls_cgroup.h>
 #include <net/dst_metadata.h>
@@ -9191,3 +9192,82 @@ void bpf_prog_change_xdp(struct bpf_prog *prev_pro=
g, struct bpf_prog *prog)
 {
 	bpf_dispatcher_change_prog(BPF_DISPATCHER_PTR(xdp), prev_prog, prog);
 }
+
+/* Define a list of socket types which can be the argument for
+ * skc_to_*_sock() helpers. All these sockets should have
+ * sock_common as the first argument in its memory layout.
+ */
+#define BPF_SOCK_CAST_TYPES \
+	BPF_SOCK_CAST_TYPE(SOCK_CAST_INET_CONN_SOCK, "inet_connection_sock")	\
+	BPF_SOCK_CAST_TYPE(SOCK_CAST_INET_REQ_SOCK, "inet_request_sock")	\
+	BPF_SOCK_CAST_TYPE(SOCK_CAST_INET_SOCK, "inet_sock")			\
+	BPF_SOCK_CAST_TYPE(SOCK_CAST_INET_TW_SOCK, "inet_timewait_sock")	\
+	BPF_SOCK_CAST_TYPE(SOCK_CAST_REQ_SOCK, "request_sock")			\
+	BPF_SOCK_CAST_TYPE(SOCK_CAST_SOCK, "sock")				\
+	BPF_SOCK_CAST_TYPE(SOCK_CAST_SOCK_COMMON, "sock_common")		\
+	BPF_SOCK_CAST_TYPE(SOCK_CAST_TCP_SOCK, "tcp_sock")			\
+	BPF_SOCK_CAST_TYPE(SOCK_CAST_TCP_REQ_SOCK, "tcp_request_sock")		\
+	BPF_SOCK_CAST_TYPE(SOCK_CAST_TCP_TW_SOCK, "tcp_timewait_sock")		\
+	BPF_SOCK_CAST_TYPE(SOCK_CAST_TCP6_SOCK, "tcp6_sock")			\
+	BPF_SOCK_CAST_TYPE(SOCK_CAST_UDP_SOCK, "udp_sock")			\
+	BPF_SOCK_CAST_TYPE(SOCK_CAST_UDP6_SOCK, "udp6_sock")
+
+enum {
+#define BPF_SOCK_CAST_TYPE(name, str) name,
+BPF_SOCK_CAST_TYPES
+MAX_SOCK_CAST_TYPE,
+#undef BPF_SOCK_CAST_TYPE
+};
+
+static const char *sock_cast_types[] =3D {
+#define BPF_SOCK_CAST_TYPE(name, str) str,
+BPF_SOCK_CAST_TYPES
+#undef BPF_SOCK_CAST_TYPE
+};
+
+static int sock_cast_btf_ids[MAX_SOCK_CAST_TYPE];
+
+void init_sock_cast_types(struct btf *btf)
+{
+	int i, btf_id;
+
+	for (i =3D 0; i < MAX_SOCK_CAST_TYPE; i++) {
+		btf_id =3D btf_find_by_name_kind(btf, sock_cast_types[i],
+					       BTF_KIND_STRUCT);
+		if (btf_id > 0)
+			sock_cast_btf_ids[i] =3D btf_id;
+	}
+}
+
+static bool check_arg_btf_id(u32 btf_id, u32 arg)
+{
+	int i;
+
+	/* only one argument, no need to check arg */
+	for (i =3D 0; i < MAX_SOCK_CAST_TYPE; i++)
+		if (sock_cast_btf_ids[i] =3D=3D btf_id)
+			return true;
+	return false;
+}
+
+BPF_CALL_1(bpf_skc_to_tcp6_sock, struct sock *, sk)
+{
+	/* tcp6_sock type is not generated in dwarf and hence btf,
+	 * trigger an explicit type generation here.
+	 */
+	BTF_TYPE_EMIT(struct tcp6_sock);
+	if (sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP &&
+	    sk->sk_family =3D=3D AF_INET6)
+		return (unsigned long)sk;
+
+	return (unsigned long)NULL;
+}
+
+const struct bpf_func_proto bpf_skc_to_tcp6_sock_proto =3D {
+	.func			=3D bpf_skc_to_tcp6_sock,
+	.gpl_only		=3D true,
+	.ret_type		=3D RET_PTR_TO_BTF_ID_OR_NULL,
+	.arg1_type		=3D ARG_PTR_TO_BTF_ID,
+	.check_btf_id		=3D check_arg_btf_id,
+	.ret_btf_id		=3D &sock_cast_btf_ids[SOCK_CAST_TCP6_SOCK],
+};
diff --git a/scripts/bpf_helpers_doc.py b/scripts/bpf_helpers_doc.py
index 91fa668fa860..6c2f64118651 100755
--- a/scripts/bpf_helpers_doc.py
+++ b/scripts/bpf_helpers_doc.py
@@ -421,6 +421,7 @@ class PrinterHelpers(Printer):
             'struct sockaddr',
             'struct tcphdr',
             'struct seq_file',
+            'struct tcp6_sock',
=20
             'struct __sk_buff',
             'struct sk_msg_md',
@@ -458,6 +459,7 @@ class PrinterHelpers(Printer):
             'struct sockaddr',
             'struct tcphdr',
             'struct seq_file',
+            'struct tcp6_sock',
     }
     mapped_types =3D {
             'u8': '__u8',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 19684813faae..394fcba27b6a 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3252,6 +3252,12 @@ union bpf_attr {
  * 		case of **BPF_CSUM_LEVEL_QUERY**, the current skb->csum_level
  * 		is returned or the error code -EACCES in case the skb is not
  * 		subject to CHECKSUM_UNNECESSARY.
+ *
+ * struct tcp6_sock *bpf_skc_to_tcp6_sock(void *sk)
+ *	Description
+ *		Dynamically cast a *sk* pointer to a *tcp6_sock* pointer.
+ *	Return
+ *		*sk* if casting is valid, or NULL otherwise.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3389,7 +3395,8 @@ union bpf_attr {
 	FN(ringbuf_submit),		\
 	FN(ringbuf_discard),		\
 	FN(ringbuf_query),		\
-	FN(csum_level),
+	FN(csum_level),			\
+	FN(skc_to_tcp6_sock),
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
  * function eBPF program intends to call
--=20
2.24.1

