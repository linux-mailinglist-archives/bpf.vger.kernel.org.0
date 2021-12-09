Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF7D46F22B
	for <lists+bpf@lfdr.de>; Thu,  9 Dec 2021 18:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243107AbhLIRjd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Dec 2021 12:39:33 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21084 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237485AbhLIRjd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 9 Dec 2021 12:39:33 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B9HIfP5016988
        for <bpf@vger.kernel.org>; Thu, 9 Dec 2021 09:36:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=a7zigzvhhKOmaIta3gSs6jGdxF84cj8hVVb3sFx9sDQ=;
 b=IWzS3j0ebSfMPApiW9Tbs9sSqAhH5tjKsiH+BT8txFBrIpxQmJSKJP8BZlKfnfGfOZWT
 vgbRYN9Ux1diQbach1E3KTo+lGtgi+wo3rr3UlUTGnngIG9V1E2uDrxXQVbc1jrrAsyN
 IyFUAjM90nWi0duvOYnOB1t7gPJPu5wIsnY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cubmjv8bs-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 09 Dec 2021 09:35:59 -0800
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 09:35:57 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id B72ED38B9D43; Thu,  9 Dec 2021 09:35:48 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>, Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH bpf-next 2/5] bpf: reject program if a __user tagged memory accessed in kernel way
Date:   Thu, 9 Dec 2021 09:35:48 -0800
Message-ID: <20211209173548.1527870-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211209173537.1525283-1-yhs@fb.com>
References: <20211209173537.1525283-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 3JncjgMoQtMSEs6Anh4pszcUrHIFTl2I
X-Proofpoint-ORIG-GUID: 3JncjgMoQtMSEs6Anh4pszcUrHIFTl2I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-09_07,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112090091
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

Currently, an enum type is used to define __user address space:
  enum btf_addr_space {
       BTF_ADDRSPACE_UNSPEC    =3D 0,
       BTF_ADDRSPACE_USER      =3D 1,
  }
In the future, we can easily extend btf_add_space for other
address space tagging, for example, rcu.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h            | 12 ++++++++--
 include/linux/bpf_verifier.h   |  1 +
 include/linux/btf.h            |  5 +++++
 kernel/bpf/btf.c               | 40 +++++++++++++++++++++++++++-------
 kernel/bpf/verifier.c          | 35 +++++++++++++++++++++--------
 net/bpf/bpf_dummy_struct_ops.c |  6 +++--
 net/ipv4/bpf_tcp_ca.c          |  6 +++--
 7 files changed, 82 insertions(+), 23 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8bbf08fbab66..3a18b7b980d4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -463,6 +463,12 @@ enum bpf_reg_type {
 	__BPF_REG_TYPE_MAX,
 };
=20
+/* The pointee address space encoded in BTF. */
+enum btf_addr_space {
+	BTF_ADDRSPACE_UNSPEC	=3D 0,
+	BTF_ADDRSPACE_USER	=3D 1,
+};
+
 /* The information passed from prog-specific *_is_valid_access
  * back to the verifier.
  */
@@ -473,6 +479,7 @@ struct bpf_insn_access_aux {
 		struct {
 			struct btf *btf;
 			u32 btf_id;
+			enum btf_addr_space addr_space;
 		};
 	};
 	struct bpf_verifier_log *log; /* for verbose logs */
@@ -519,7 +526,8 @@ struct bpf_verifier_ops {
 				 const struct btf *btf,
 				 const struct btf_type *t, int off, int size,
 				 enum bpf_access_type atype,
-				 u32 *next_btf_id);
+				 u32 *next_btf_id,
+				 enum btf_addr_space *addr_space);
 	bool (*check_kfunc_call)(u32 kfunc_btf_id, struct module *owner);
 };
=20
@@ -1701,7 +1709,7 @@ static inline bool bpf_tracing_btf_ctx_access(int o=
ff, int size,
 int btf_struct_access(struct bpf_verifier_log *log, const struct btf *bt=
f,
 		      const struct btf_type *t, int off, int size,
 		      enum bpf_access_type atype,
-		      u32 *next_btf_id);
+		      u32 *next_btf_id, enum btf_addr_space *addr_space);
 bool btf_struct_ids_match(struct bpf_verifier_log *log,
 			  const struct btf *btf, u32 id, int off,
 			  const struct btf *need_btf, u32 need_type_id);
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 182b16a91084..698b9837334d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -66,6 +66,7 @@ struct bpf_reg_state {
 		struct {
 			struct btf *btf;
 			u32 btf_id;
+			enum btf_addr_space addr_space;
 		};
=20
 		u32 mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
diff --git a/include/linux/btf.h b/include/linux/btf.h
index acef6ef28768..56a1074155d9 100644
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
index 27b7de538697..831445b3d97c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4849,6 +4849,7 @@ bool btf_ctx_access(int off, int size, enum bpf_acc=
ess_type type,
 	const char *tname =3D prog->aux->attach_func_name;
 	struct bpf_verifier_log *log =3D info->log;
 	const struct btf_param *args;
+	const char *tag_value;
 	u32 nr_args, arg;
 	int i, ret;
=20
@@ -4998,7 +4999,15 @@ bool btf_ctx_access(int off, int size, enum bpf_ac=
cess_type type,
=20
 	info->btf =3D btf;
 	info->btf_id =3D t->type;
+	info->addr_space =3D BTF_ADDRSPACE_UNSPEC;
 	t =3D btf_type_by_id(btf, t->type);
+
+	if (btf_type_is_type_tag(t)) {
+		tag_value =3D __btf_name_by_offset(btf, t->name_off);
+		if (strcmp(tag_value, "user") =3D=3D 0)
+			info->addr_space =3D BTF_ADDRSPACE_USER;
+	}
+
 	/* skip modifiers */
 	while (btf_type_is_modifier(t)) {
 		info->btf_id =3D t->type;
@@ -5010,8 +5019,9 @@ bool btf_ctx_access(int off, int size, enum bpf_acc=
ess_type type,
 			tname, arg, btf_kind_str[BTF_INFO_KIND(t->info)]);
 		return false;
 	}
-	bpf_log(log, "func '%s' arg%d has btf_id %d type %s '%s'\n",
-		tname, arg, info->btf_id, btf_kind_str[BTF_INFO_KIND(t->info)],
+	bpf_log(log, "func '%s' arg%d has btf_id %d addr_space %d type %s '%s'\=
n",
+		tname, arg, info->btf_id, info->addr_space,
+		btf_kind_str[BTF_INFO_KIND(t->info)],
 		__btf_name_by_offset(btf, t->name_off));
 	return true;
 }
@@ -5025,12 +5035,12 @@ enum bpf_struct_walk_result {
=20
 static int btf_struct_walk(struct bpf_verifier_log *log, const struct bt=
f *btf,
 			   const struct btf_type *t, int off, int size,
-			   u32 *next_btf_id)
+			   u32 *next_btf_id, enum btf_addr_space *addr_space)
 {
 	u32 i, moff, mtrue_end, msize =3D 0, total_nelems =3D 0;
 	const struct btf_type *mtype, *elem_type =3D NULL;
 	const struct btf_member *member;
-	const char *tname, *mname;
+	const char *tname, *mname, *tag_value;
 	u32 vlen, elem_id, mid;
=20
 again:
@@ -5214,7 +5224,8 @@ static int btf_struct_walk(struct bpf_verifier_log =
*log, const struct btf *btf,
 		}
=20
 		if (btf_type_is_ptr(mtype)) {
-			const struct btf_type *stype;
+			enum btf_addr_space tmp_addr_space =3D BTF_ADDRSPACE_UNSPEC;
+			const struct btf_type *stype, *t;
 			u32 id;
=20
 			if (msize !=3D size || off !=3D moff) {
@@ -5223,9 +5234,19 @@ static int btf_struct_walk(struct bpf_verifier_log=
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
+					tmp_addr_space =3D BTF_ADDRSPACE_USER;
+			}
+
 			stype =3D btf_type_skip_modifiers(btf, mtype->type, &id);
 			if (btf_type_is_struct(stype)) {
 				*next_btf_id =3D id;
+				*addr_space =3D tmp_addr_space;
 				return WALK_PTR;
 			}
 		}
@@ -5252,13 +5273,14 @@ static int btf_struct_walk(struct bpf_verifier_lo=
g *log, const struct btf *btf,
 int btf_struct_access(struct bpf_verifier_log *log, const struct btf *bt=
f,
 		      const struct btf_type *t, int off, int size,
 		      enum bpf_access_type atype __maybe_unused,
-		      u32 *next_btf_id)
+		      u32 *next_btf_id, enum btf_addr_space *addr_space)
 {
+	enum btf_addr_space tmp_addr_space;
 	int err;
 	u32 id;
=20
 	do {
-		err =3D btf_struct_walk(log, btf, t, off, size, &id);
+		err =3D btf_struct_walk(log, btf, t, off, size, &id, &tmp_addr_space);
=20
 		switch (err) {
 		case WALK_PTR:
@@ -5266,6 +5288,7 @@ int btf_struct_access(struct bpf_verifier_log *log,=
 const struct btf *btf,
 			 * we're done.
 			 */
 			*next_btf_id =3D id;
+			*addr_space =3D tmp_addr_space;
 			return PTR_TO_BTF_ID;
 		case WALK_SCALAR:
 			return SCALAR_VALUE;
@@ -5309,6 +5332,7 @@ bool btf_struct_ids_match(struct bpf_verifier_log *=
log,
 			  const struct btf *btf, u32 id, int off,
 			  const struct btf *need_btf, u32 need_type_id)
 {
+	enum btf_addr_space addr_space;
 	const struct btf_type *type;
 	int err;
=20
@@ -5320,7 +5344,7 @@ bool btf_struct_ids_match(struct bpf_verifier_log *=
log,
 	type =3D btf_type_by_id(btf, id);
 	if (!type)
 		return false;
-	err =3D btf_struct_walk(log, btf, type, off, 1, &id);
+	err =3D btf_struct_walk(log, btf, type, off, 1, &id, &addr_space);
 	if (err !=3D WALK_STRUCT)
 		return false;
=20
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1126b75fe650..b4968dcaf80f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -649,7 +649,9 @@ static void print_verifier_state(struct bpf_verifier_=
env *env,
 			if (t =3D=3D PTR_TO_BTF_ID ||
 			    t =3D=3D PTR_TO_BTF_ID_OR_NULL ||
 			    t =3D=3D PTR_TO_PERCPU_BTF_ID)
-				verbose(env, "%s", kernel_type_name(reg->btf, reg->btf_id));
+				verbose(env, "%s,addr_space=3D%d",
+					kernel_type_name(reg->btf, reg->btf_id),
+					reg->addr_space);
 			verbose(env, "(id=3D%d", reg->id);
 			if (reg_type_may_be_refcounted_or_null(t))
 				verbose(env, ",ref_obj_id=3D%d", reg->ref_obj_id);
@@ -1498,7 +1500,8 @@ static void mark_reg_not_init(struct bpf_verifier_e=
nv *env,
 static void mark_btf_ld_reg(struct bpf_verifier_env *env,
 			    struct bpf_reg_state *regs, u32 regno,
 			    enum bpf_reg_type reg_type,
-			    struct btf *btf, u32 btf_id)
+			    struct btf *btf, u32 btf_id,
+			    enum btf_addr_space addr_space)
 {
 	if (reg_type =3D=3D SCALAR_VALUE) {
 		mark_reg_unknown(env, regs, regno);
@@ -1508,6 +1511,7 @@ static void mark_btf_ld_reg(struct bpf_verifier_env=
 *env,
 	regs[regno].type =3D PTR_TO_BTF_ID;
 	regs[regno].btf =3D btf;
 	regs[regno].btf_id =3D btf_id;
+	regs[regno].addr_space =3D addr_space;
 }
=20
 #define DEF_NOT_SUBREG	(0)
@@ -3553,7 +3557,7 @@ static int check_packet_access(struct bpf_verifier_=
env *env, u32 regno, int off,
 /* check access to 'struct bpf_context' fields.  Supports fixed offsets =
only */
 static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, =
int off, int size,
 			    enum bpf_access_type t, enum bpf_reg_type *reg_type,
-			    struct btf **btf, u32 *btf_id)
+			    struct btf **btf, u32 *btf_id, enum btf_addr_space *addr_space)
 {
 	struct bpf_insn_access_aux info =3D {
 		.reg_type =3D *reg_type,
@@ -3574,6 +3578,7 @@ static int check_ctx_access(struct bpf_verifier_env=
 *env, int insn_idx, int off,
 		if (*reg_type =3D=3D PTR_TO_BTF_ID || *reg_type =3D=3D PTR_TO_BTF_ID_O=
R_NULL) {
 			*btf =3D info.btf;
 			*btf_id =3D info.btf_id;
+			*addr_space =3D info.addr_space;
 		} else {
 			env->insn_aux_data[insn_idx].ctx_field_size =3D info.ctx_field_size;
 		}
@@ -4099,6 +4104,7 @@ static int check_ptr_to_btf_access(struct bpf_verif=
ier_env *env,
 	struct bpf_reg_state *reg =3D regs + regno;
 	const struct btf_type *t =3D btf_type_by_id(reg->btf, reg->btf_id);
 	const char *tname =3D btf_name_by_offset(reg->btf, t->name_off);
+	enum btf_addr_space addr_space;
 	u32 btf_id;
 	int ret;
=20
@@ -4118,9 +4124,16 @@ static int check_ptr_to_btf_access(struct bpf_veri=
fier_env *env,
 		return -EACCES;
 	}
=20
+	if (reg->addr_space =3D=3D BTF_ADDRSPACE_USER) {
+		verbose(env,
+			"R%d is ptr_%s access user memory: off=3D%d\n",
+			regno, tname, off);
+		return -EACCES;
+	}
+
 	if (env->ops->btf_struct_access) {
 		ret =3D env->ops->btf_struct_access(&env->log, reg->btf, t,
-						  off, size, atype, &btf_id);
+						  off, size, atype, &btf_id, &addr_space);
 	} else {
 		if (atype !=3D BPF_READ) {
 			verbose(env, "only read is supported\n");
@@ -4128,14 +4141,14 @@ static int check_ptr_to_btf_access(struct bpf_ver=
ifier_env *env,
 		}
=20
 		ret =3D btf_struct_access(&env->log, reg->btf, t, off, size,
-					atype, &btf_id);
+					atype, &btf_id, &addr_space);
 	}
=20
 	if (ret < 0)
 		return ret;
=20
 	if (atype =3D=3D BPF_READ && value_regno >=3D 0)
-		mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id);
+		mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, addr_sp=
ace);
=20
 	return 0;
 }
@@ -4148,6 +4161,7 @@ static int check_ptr_to_map_access(struct bpf_verif=
ier_env *env,
 {
 	struct bpf_reg_state *reg =3D regs + regno;
 	struct bpf_map *map =3D reg->map_ptr;
+	enum btf_addr_space addr_space;
 	const struct btf_type *t;
 	const char *tname;
 	u32 btf_id;
@@ -4185,12 +4199,12 @@ static int check_ptr_to_map_access(struct bpf_ver=
ifier_env *env,
 		return -EACCES;
 	}
=20
-	ret =3D btf_struct_access(&env->log, btf_vmlinux, t, off, size, atype, =
&btf_id);
+	ret =3D btf_struct_access(&env->log, btf_vmlinux, t, off, size, atype, =
&btf_id, &addr_space);
 	if (ret < 0)
 		return ret;
=20
 	if (value_regno >=3D 0)
-		mark_btf_ld_reg(env, regs, value_regno, ret, btf_vmlinux, btf_id);
+		mark_btf_ld_reg(env, regs, value_regno, ret, btf_vmlinux, btf_id, addr=
_space);
=20
 	return 0;
 }
@@ -4362,6 +4376,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
 		if (!err && t =3D=3D BPF_READ && value_regno >=3D 0)
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (reg->type =3D=3D PTR_TO_CTX) {
+		enum btf_addr_space addr_space =3D BTF_ADDRSPACE_UNSPEC;
 		enum bpf_reg_type reg_type =3D SCALAR_VALUE;
 		struct btf *btf =3D NULL;
 		u32 btf_id =3D 0;
@@ -4376,7 +4391,8 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
 		if (err < 0)
 			return err;
=20
-		err =3D check_ctx_access(env, insn_idx, off, size, t, &reg_type, &btf,=
 &btf_id);
+		err =3D check_ctx_access(env, insn_idx, off, size, t, &reg_type, &btf,
+				       &btf_id, &addr_space);
 		if (err)
 			verbose_linfo(env, insn_idx, "; ");
 		if (!err && t =3D=3D BPF_READ && value_regno >=3D 0) {
@@ -4401,6 +4417,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
 				    reg_type =3D=3D PTR_TO_BTF_ID_OR_NULL) {
 					regs[value_regno].btf =3D btf;
 					regs[value_regno].btf_id =3D btf_id;
+					regs[value_regno].addr_space =3D addr_space;
 				}
 			}
 			regs[value_regno].type =3D reg_type;
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_op=
s.c
index fbc896323bec..57db75427a88 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -145,7 +145,8 @@ static int bpf_dummy_ops_btf_struct_access(struct bpf=
_verifier_log *log,
 					   const struct btf *btf,
 					   const struct btf_type *t, int off,
 					   int size, enum bpf_access_type atype,
-					   u32 *next_btf_id)
+					   u32 *next_btf_id,
+					   enum btf_addr_space *addr_space)
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
+				addr_space);
 	if (err < 0)
 		return err;
=20
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 67466dbff152..dba60f85369b 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -95,12 +95,14 @@ static int bpf_tcp_ca_btf_struct_access(struct bpf_ve=
rifier_log *log,
 					const struct btf *btf,
 					const struct btf_type *t, int off,
 					int size, enum bpf_access_type atype,
-					u32 *next_btf_id)
+					u32 *next_btf_id,
+					enum btf_addr_space *addr_space)
 {
 	size_t end;
=20
 	if (atype =3D=3D BPF_READ)
-		return btf_struct_access(log, btf, t, off, size, atype, next_btf_id);
+		return btf_struct_access(log, btf, t, off, size, atype, next_btf_id,
+					 addr_space);
=20
 	if (t !=3D tcp_sock_type) {
 		bpf_log(log, "only read is supported\n");
--=20
2.30.2

