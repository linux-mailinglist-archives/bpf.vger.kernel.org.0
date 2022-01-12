Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C297D48CCF5
	for <lists+bpf@lfdr.de>; Wed, 12 Jan 2022 21:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiALUPO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jan 2022 15:15:14 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40056 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357587AbiALUPJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 12 Jan 2022 15:15:09 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20CI3jWT001267
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 12:15:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=U5mnbrkllu1xL/zLJLDszn+iWTNAlDHRykR2fV6Pa2Y=;
 b=pGCEKsq3/3bHAUh3I51l2glGDLjr+oURRCt8SYOXs0KWSSmYCxvJXcqMnncBspddTun+
 E+gopzDglAAN8LF0C7hb+Po1xfs0uNIOiR5Tt6c3miRnYGggAupMjvc3JpjTnogLAwa7
 2jBCpl2K55ocxCPz1D/EmBRNMUeRRnw31ko= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dhnkqw0kc-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 12:15:09 -0800
Received: from twshared29821.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 12 Jan 2022 12:15:05 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id EA9DD4FCA1A6; Wed, 12 Jan 2022 12:15:00 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>, Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH bpf-next v2 2/5] bpf: reject program if a __user tagged memory accessed in kernel way
Date:   Wed, 12 Jan 2022 12:15:00 -0800
Message-ID: <20220112201500.1623985-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220112201449.1620763-1-yhs@fb.com>
References: <20220112201449.1620763-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: N3vOUNb07BpoRRLdx5KtjcKqDSORETRR
X-Proofpoint-GUID: N3vOUNb07BpoRRLdx5KtjcKqDSORETRR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-12_05,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201120119
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF verifier supports direct memory access for BPF_PROG_TYPE_TRACING type
of bpf programs, e.g., a->b. If "a" is a pointer
pointing to kernel memory, bpf verifier will allow user to write
code in C like a->b and the verifier will translate it to a kernel
load properly. If "a" is a pointer to user memory, it is expected
that bpf developer should be bpf_probe_read_user() helper to
get the value a->b. Without utilizing BTF __user tagging information,
current verifier will assume that a->b is a kernel memory access
and this may generate incorrect result.

Now BTF contains __user information, it can check whether the
pointer points to a user memory or not. If it is, the verifier
can reject the program and force users to use bpf_probe_read_user()
helper explicitly.

In the future, we can easily extend btf_add_space for other
address space tagging, for example, rcu/percpu etc.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h            | 11 ++++++++---
 include/linux/btf.h            |  5 +++++
 kernel/bpf/btf.c               | 34 ++++++++++++++++++++++++++++------
 kernel/bpf/verifier.c          | 30 ++++++++++++++++++++++--------
 net/bpf/bpf_dummy_struct_ops.c |  6 ++++--
 net/ipv4/bpf_tcp_ca.c          |  6 ++++--
 6 files changed, 71 insertions(+), 21 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6e947cd91152..c97ec30f2f12 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -308,6 +308,8 @@ extern const struct bpf_map_ops bpf_map_offload_ops;
 #define BPF_BASE_TYPE_BITS	8
=20
 enum bpf_type_flag {
+	FLAG_DONTCARE		=3D 0,
+
 	/* PTR may be NULL. */
 	PTR_MAYBE_NULL		=3D BIT(0 + BPF_BASE_TYPE_BITS),
=20
@@ -316,7 +318,10 @@ enum bpf_type_flag {
 	 */
 	MEM_RDONLY		=3D BIT(1 + BPF_BASE_TYPE_BITS),
=20
-	__BPF_TYPE_LAST_FLAG	=3D MEM_RDONLY,
+	/* MEM is in user address space. */
+	MEM_USER		=3D BIT(2 + BPF_BASE_TYPE_BITS),
+
+	__BPF_TYPE_LAST_FLAG	=3D MEM_USER,
 };
=20
 /* Max number of base types. */
@@ -572,7 +577,7 @@ struct bpf_verifier_ops {
 				 const struct btf *btf,
 				 const struct btf_type *t, int off, int size,
 				 enum bpf_access_type atype,
-				 u32 *next_btf_id);
+				 u32 *next_btf_id, enum bpf_type_flag *flag);
 	bool (*check_kfunc_call)(u32 kfunc_btf_id, struct module *owner);
 };
=20
@@ -1749,7 +1754,7 @@ static inline bool bpf_tracing_btf_ctx_access(int o=
ff, int size,
 int btf_struct_access(struct bpf_verifier_log *log, const struct btf *bt=
f,
 		      const struct btf_type *t, int off, int size,
 		      enum bpf_access_type atype,
-		      u32 *next_btf_id);
+		      u32 *next_btf_id, enum bpf_type_flag *flag);
 bool btf_struct_ids_match(struct bpf_verifier_log *log,
 			  const struct btf *btf, u32 id, int off,
 			  const struct btf *need_btf, u32 need_type_id);
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 0c74348cbc9d..e4e2f7124fe6 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -216,6 +216,11 @@ static inline bool btf_type_is_var(const struct btf_=
type *t)
 	return BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_VAR;
 }
=20
+static inline bool btf_type_is_type_tag(const struct btf_type *t)
+{
+	return BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_TYPE_TAG;
+}
+
 /* union is only a special case of struct:
  * all its offsetof(member) =3D=3D 0
  */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 33bb8ae4a804..54bf483d01f3 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4848,6 +4848,7 @@ bool btf_ctx_access(int off, int size, enum bpf_acc=
ess_type type,
 	const char *tname =3D prog->aux->attach_func_name;
 	struct bpf_verifier_log *log =3D info->log;
 	const struct btf_param *args;
+	const char *tag_value;
 	u32 nr_args, arg;
 	int i, ret;
=20
@@ -5000,6 +5001,13 @@ bool btf_ctx_access(int off, int size, enum bpf_ac=
cess_type type,
 	info->btf =3D btf;
 	info->btf_id =3D t->type;
 	t =3D btf_type_by_id(btf, t->type);
+
+	if (btf_type_is_type_tag(t)) {
+		tag_value =3D __btf_name_by_offset(btf, t->name_off);
+		if (strcmp(tag_value, "user") =3D=3D 0)
+			info->reg_type |=3D MEM_USER;
+	}
+
 	/* skip modifiers */
 	while (btf_type_is_modifier(t)) {
 		info->btf_id =3D t->type;
@@ -5026,12 +5034,12 @@ enum bpf_struct_walk_result {
=20
 static int btf_struct_walk(struct bpf_verifier_log *log, const struct bt=
f *btf,
 			   const struct btf_type *t, int off, int size,
-			   u32 *next_btf_id)
+			   u32 *next_btf_id, enum bpf_type_flag *flag)
 {
 	u32 i, moff, mtrue_end, msize =3D 0, total_nelems =3D 0;
 	const struct btf_type *mtype, *elem_type =3D NULL;
 	const struct btf_member *member;
-	const char *tname, *mname;
+	const char *tname, *mname, *tag_value;
 	u32 vlen, elem_id, mid;
=20
 again:
@@ -5215,7 +5223,8 @@ static int btf_struct_walk(struct bpf_verifier_log =
*log, const struct btf *btf,
 		}
=20
 		if (btf_type_is_ptr(mtype)) {
-			const struct btf_type *stype;
+			enum bpf_type_flag tmp_flag =3D FLAG_DONTCARE;
+			const struct btf_type *stype, *t;
 			u32 id;
=20
 			if (msize !=3D size || off !=3D moff) {
@@ -5224,9 +5233,19 @@ static int btf_struct_walk(struct bpf_verifier_log=
 *log, const struct btf *btf,
 					mname, moff, tname, off, size);
 				return -EACCES;
 			}
+
+			/* check __user tag */
+			t =3D btf_type_by_id(btf, mtype->type);
+			if (btf_type_is_type_tag(t)) {
+				tag_value =3D __btf_name_by_offset(btf, t->name_off);
+				if (strcmp(tag_value, "user") =3D=3D 0)
+					tmp_flag =3D MEM_USER;
+			}
+
 			stype =3D btf_type_skip_modifiers(btf, mtype->type, &id);
 			if (btf_type_is_struct(stype)) {
 				*next_btf_id =3D id;
+				*flag =3D tmp_flag;
 				return WALK_PTR;
 			}
 		}
@@ -5253,13 +5272,14 @@ static int btf_struct_walk(struct bpf_verifier_lo=
g *log, const struct btf *btf,
 int btf_struct_access(struct bpf_verifier_log *log, const struct btf *bt=
f,
 		      const struct btf_type *t, int off, int size,
 		      enum bpf_access_type atype __maybe_unused,
-		      u32 *next_btf_id)
+		      u32 *next_btf_id, enum bpf_type_flag *flag)
 {
+	enum bpf_type_flag tmp_flag =3D FLAG_DONTCARE;
 	int err;
 	u32 id;
=20
 	do {
-		err =3D btf_struct_walk(log, btf, t, off, size, &id);
+		err =3D btf_struct_walk(log, btf, t, off, size, &id, &tmp_flag);
=20
 		switch (err) {
 		case WALK_PTR:
@@ -5267,6 +5287,7 @@ int btf_struct_access(struct bpf_verifier_log *log,=
 const struct btf *btf,
 			 * we're done.
 			 */
 			*next_btf_id =3D id;
+			*flag =3D tmp_flag;
 			return PTR_TO_BTF_ID;
 		case WALK_SCALAR:
 			return SCALAR_VALUE;
@@ -5311,6 +5332,7 @@ bool btf_struct_ids_match(struct bpf_verifier_log *=
log,
 			  const struct btf *need_btf, u32 need_type_id)
 {
 	const struct btf_type *type;
+	enum bpf_type_flag flag;
 	int err;
=20
 	/* Are we already done? */
@@ -5321,7 +5343,7 @@ bool btf_struct_ids_match(struct bpf_verifier_log *=
log,
 	type =3D btf_type_by_id(btf, id);
 	if (!type)
 		return false;
-	err =3D btf_struct_walk(log, btf, type, off, 1, &id);
+	err =3D btf_struct_walk(log, btf, type, off, 1, &id, &flag);
 	if (err !=3D WALK_STRUCT)
 		return false;
=20
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bfb45381fb3f..6b78642ea437 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -568,6 +568,9 @@ static const char *reg_type_str(struct bpf_verifier_e=
nv *env,
 			strncpy(postfix, "_or_null", 16);
 	}
=20
+	if (type & MEM_USER)
+		strncpy(prefix, "user_", 16);
+
 	if (type & MEM_RDONLY)
 		strncpy(prefix, "rdonly_", 16);
=20
@@ -1544,14 +1547,15 @@ static void mark_reg_not_init(struct bpf_verifier=
_env *env,
 static void mark_btf_ld_reg(struct bpf_verifier_env *env,
 			    struct bpf_reg_state *regs, u32 regno,
 			    enum bpf_reg_type reg_type,
-			    struct btf *btf, u32 btf_id)
+			    struct btf *btf, u32 btf_id,
+			    enum bpf_type_flag flag)
 {
 	if (reg_type =3D=3D SCALAR_VALUE) {
 		mark_reg_unknown(env, regs, regno);
 		return;
 	}
 	mark_reg_known_zero(env, regs, regno);
-	regs[regno].type =3D PTR_TO_BTF_ID;
+	regs[regno].type =3D PTR_TO_BTF_ID | flag;
 	regs[regno].btf =3D btf;
 	regs[regno].btf_id =3D btf_id;
 }
@@ -4149,6 +4153,7 @@ static int check_ptr_to_btf_access(struct bpf_verif=
ier_env *env,
 	struct bpf_reg_state *reg =3D regs + regno;
 	const struct btf_type *t =3D btf_type_by_id(reg->btf, reg->btf_id);
 	const char *tname =3D btf_name_by_offset(reg->btf, t->name_off);
+	enum bpf_type_flag flag =3D FLAG_DONTCARE;
 	u32 btf_id;
 	int ret;
=20
@@ -4168,9 +4173,16 @@ static int check_ptr_to_btf_access(struct bpf_veri=
fier_env *env,
 		return -EACCES;
 	}
=20
+	if (reg->type & MEM_USER) {
+		verbose(env,
+			"R%d is ptr_%s access user memory: off=3D%d\n",
+			regno, tname, off);
+		return -EACCES;
+	}
+
 	if (env->ops->btf_struct_access) {
 		ret =3D env->ops->btf_struct_access(&env->log, reg->btf, t,
-						  off, size, atype, &btf_id);
+						  off, size, atype, &btf_id, &flag);
 	} else {
 		if (atype !=3D BPF_READ) {
 			verbose(env, "only read is supported\n");
@@ -4178,14 +4190,14 @@ static int check_ptr_to_btf_access(struct bpf_ver=
ifier_env *env,
 		}
=20
 		ret =3D btf_struct_access(&env->log, reg->btf, t, off, size,
-					atype, &btf_id);
+					atype, &btf_id, &flag);
 	}
=20
 	if (ret < 0)
 		return ret;
=20
 	if (atype =3D=3D BPF_READ && value_regno >=3D 0)
-		mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id);
+		mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
=20
 	return 0;
 }
@@ -4198,6 +4210,7 @@ static int check_ptr_to_map_access(struct bpf_verif=
ier_env *env,
 {
 	struct bpf_reg_state *reg =3D regs + regno;
 	struct bpf_map *map =3D reg->map_ptr;
+	enum bpf_type_flag flag =3D FLAG_DONTCARE;
 	const struct btf_type *t;
 	const char *tname;
 	u32 btf_id;
@@ -4235,12 +4248,12 @@ static int check_ptr_to_map_access(struct bpf_ver=
ifier_env *env,
 		return -EACCES;
 	}
=20
-	ret =3D btf_struct_access(&env->log, btf_vmlinux, t, off, size, atype, =
&btf_id);
+	ret =3D btf_struct_access(&env->log, btf_vmlinux, t, off, size, atype, =
&btf_id, &flag);
 	if (ret < 0)
 		return ret;
=20
 	if (value_regno >=3D 0)
-		mark_btf_ld_reg(env, regs, value_regno, ret, btf_vmlinux, btf_id);
+		mark_btf_ld_reg(env, regs, value_regno, ret, btf_vmlinux, btf_id, flag=
);
=20
 	return 0;
 }
@@ -4441,7 +4454,8 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
 		if (err < 0)
 			return err;
=20
-		err =3D check_ctx_access(env, insn_idx, off, size, t, &reg_type, &btf,=
 &btf_id);
+		err =3D check_ctx_access(env, insn_idx, off, size, t, &reg_type, &btf,
+				       &btf_id);
 		if (err)
 			verbose_linfo(env, insn_idx, "; ");
 		if (!err && t =3D=3D BPF_READ && value_regno >=3D 0) {
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_op=
s.c
index fbc896323bec..d0e54e30658a 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -145,7 +145,8 @@ static int bpf_dummy_ops_btf_struct_access(struct bpf=
_verifier_log *log,
 					   const struct btf *btf,
 					   const struct btf_type *t, int off,
 					   int size, enum bpf_access_type atype,
-					   u32 *next_btf_id)
+					   u32 *next_btf_id,
+					   enum bpf_type_flag *flag)
 {
 	const struct btf_type *state;
 	s32 type_id;
@@ -162,7 +163,8 @@ static int bpf_dummy_ops_btf_struct_access(struct bpf=
_verifier_log *log,
 		return -EACCES;
 	}
=20
-	err =3D btf_struct_access(log, btf, t, off, size, atype, next_btf_id);
+	err =3D btf_struct_access(log, btf, t, off, size, atype, next_btf_id,
+				flag);
 	if (err < 0)
 		return err;
=20
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index de610cb83694..6b781eead784 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -95,12 +95,14 @@ static int bpf_tcp_ca_btf_struct_access(struct bpf_ve=
rifier_log *log,
 					const struct btf *btf,
 					const struct btf_type *t, int off,
 					int size, enum bpf_access_type atype,
-					u32 *next_btf_id)
+					u32 *next_btf_id,
+					enum bpf_type_flag *flag)
 {
 	size_t end;
=20
 	if (atype =3D=3D BPF_READ)
-		return btf_struct_access(log, btf, t, off, size, atype, next_btf_id);
+		return btf_struct_access(log, btf, t, off, size, atype, next_btf_id,
+					 flag);
=20
 	if (t !=3D tcp_sock_type) {
 		bpf_log(log, "only read is supported\n");
--=20
2.30.2

