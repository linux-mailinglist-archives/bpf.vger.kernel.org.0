Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8963B620A7A
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 08:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbiKHHli (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 02:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbiKHHlO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 02:41:14 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6481DE0EB
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 23:41:04 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A80Uv3o007285
        for <bpf@vger.kernel.org>; Mon, 7 Nov 2022 23:41:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=dJC0bmBUZw6PnWO8upcy7UHlzVtLkCojRKl1o780Dsw=;
 b=a70onM8Yof6npVCMrpjdw6hcncSvBhdfAYksLd2bTLqXMD6m3LLZTKk8lohCo9l8WwVD
 EIqXJVHKDKIU2DqQ9s0RDjukjijNNYbRsuGYsJOItEIDOHuB5gfnMjon7pBxSzzk5oyw
 bbCsZcO/R0TldsEfWJ9OMCj+PG4TJfgy9eI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kqcmqt6gh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 23:41:04 -0800
Received: from twshared14438.02.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 23:41:02 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 133BB11D23393; Mon,  7 Nov 2022 23:40:58 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 2/8] bpf: Refactor btf_struct_access callback interface
Date:   Mon, 7 Nov 2022 23:40:58 -0800
Message-ID: <20221108074058.262856-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221108074047.261848-1-yhs@fb.com>
References: <20221108074047.261848-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: m5eEaC6-lERaud2YWFgOVlryJeizDMFR
X-Proofpoint-ORIG-GUID: m5eEaC6-lERaud2YWFgOVlryJeizDMFR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Current bpf_verifier_ops->btf_struct_access() callback function walks thr=
ough
struct member access chain and gathers information like next_btf_id and
bpf_type_flag (for __user and __percpu). In later patches, additional
information like whether the pointer is tagged with __rcu will be gathere=
d
as well. So refactor btf_struct_access() interface to wrap next_btf_id
and bpf_type_flag in a structure, so the new field can be easily added
to the new structure without modifying all callback functions.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h              | 11 ++++++++---
 include/linux/filter.h           |  4 ++--
 kernel/bpf/btf.c                 | 25 ++++++++++++-------------
 kernel/bpf/verifier.c            | 20 ++++++++++----------
 net/bpf/bpf_dummy_struct_ops.c   |  6 ++----
 net/core/filter.c                | 20 ++++++++------------
 net/ipv4/bpf_tcp_ca.c            |  6 ++----
 net/netfilter/nf_conntrack_bpf.c |  3 +--
 8 files changed, 45 insertions(+), 50 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 798aec816970..5011cb50abf1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -758,6 +758,11 @@ struct bpf_prog_ops {
 			union bpf_attr __user *uattr);
 };
=20
+struct btf_struct_access_info {
+	u32 next_btf_id;
+	enum bpf_type_flag flag;
+};
+
 struct bpf_verifier_ops {
 	/* return eBPF function prototype for verification */
 	const struct bpf_func_proto *
@@ -782,7 +787,7 @@ struct bpf_verifier_ops {
 				 const struct btf *btf,
 				 const struct btf_type *t, int off, int size,
 				 enum bpf_access_type atype,
-				 u32 *next_btf_id, enum bpf_type_flag *flag);
+				 struct btf_struct_access_info *info);
 };
=20
 struct bpf_prog_offload_ops {
@@ -2070,7 +2075,7 @@ static inline bool bpf_tracing_btf_ctx_access(int o=
ff, int size,
 int btf_struct_access(struct bpf_verifier_log *log, const struct btf *bt=
f,
 		      const struct btf_type *t, int off, int size,
 		      enum bpf_access_type atype,
-		      u32 *next_btf_id, enum bpf_type_flag *flag);
+		      struct btf_struct_access_info *info);
 bool btf_struct_ids_match(struct bpf_verifier_log *log,
 			  const struct btf *btf, u32 id, int off,
 			  const struct btf *need_btf, u32 need_type_id,
@@ -2323,7 +2328,7 @@ static inline int btf_struct_access(struct bpf_veri=
fier_log *log,
 				    const struct btf *btf,
 				    const struct btf_type *t, int off, int size,
 				    enum bpf_access_type atype,
-				    u32 *next_btf_id, enum bpf_type_flag *flag)
+				    struct btf_struct_access_info *info)
 {
 	return -EACCES;
 }
diff --git a/include/linux/filter.h b/include/linux/filter.h
index efc42a6e3aed..75340a5b83d3 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -570,8 +570,8 @@ DECLARE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
 extern struct mutex nf_conn_btf_access_lock;
 extern int (*nfct_btf_struct_access)(struct bpf_verifier_log *log, const=
 struct btf *btf,
 				     const struct btf_type *t, int off, int size,
-				     enum bpf_access_type atype, u32 *next_btf_id,
-				     enum bpf_type_flag *flag);
+				     enum bpf_access_type atype,
+				     struct btf_struct_access_info *info);
=20
 typedef unsigned int (*bpf_dispatcher_fn)(const void *ctx,
 					  const struct bpf_insn *insnsi,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 5579ff3a5b54..cf16c0ead9f4 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5639,7 +5639,7 @@ enum bpf_struct_walk_result {
=20
 static int btf_struct_walk(struct bpf_verifier_log *log, const struct bt=
f *btf,
 			   const struct btf_type *t, int off, int size,
-			   u32 *next_btf_id, enum bpf_type_flag *flag)
+			   struct btf_struct_access_info *info)
 {
 	u32 i, moff, mtrue_end, msize =3D 0, total_nelems =3D 0;
 	const struct btf_type *mtype, *elem_type =3D NULL;
@@ -5818,7 +5818,7 @@ static int btf_struct_walk(struct bpf_verifier_log =
*log, const struct btf *btf,
=20
 			/* return if the offset matches the member offset */
 			if (off =3D=3D moff) {
-				*next_btf_id =3D mid;
+				info->next_btf_id =3D mid;
 				return WALK_STRUCT;
 			}
=20
@@ -5853,8 +5853,8 @@ static int btf_struct_walk(struct bpf_verifier_log =
*log, const struct btf *btf,
=20
 			stype =3D btf_type_skip_modifiers(btf, mtype->type, &id);
 			if (btf_type_is_struct(stype)) {
-				*next_btf_id =3D id;
-				*flag =3D tmp_flag;
+				info->next_btf_id =3D id;
+				info->flag =3D tmp_flag;
 				return WALK_PTR;
 			}
 		}
@@ -5881,22 +5881,20 @@ static int btf_struct_walk(struct bpf_verifier_lo=
g *log, const struct btf *btf,
 int btf_struct_access(struct bpf_verifier_log *log, const struct btf *bt=
f,
 		      const struct btf_type *t, int off, int size,
 		      enum bpf_access_type atype __maybe_unused,
-		      u32 *next_btf_id, enum bpf_type_flag *flag)
+		      struct btf_struct_access_info *info)
 {
-	enum bpf_type_flag tmp_flag =3D 0;
+	struct btf_struct_access_info tmp_info =3D {};
 	int err;
-	u32 id;
=20
 	do {
-		err =3D btf_struct_walk(log, btf, t, off, size, &id, &tmp_flag);
+		err =3D btf_struct_walk(log, btf, t, off, size, &tmp_info);
=20
 		switch (err) {
 		case WALK_PTR:
 			/* If we found the pointer or scalar on t+off,
 			 * we're done.
 			 */
-			*next_btf_id =3D id;
-			*flag =3D tmp_flag;
+			*info =3D tmp_info;
 			return PTR_TO_BTF_ID;
 		case WALK_SCALAR:
 			return SCALAR_VALUE;
@@ -5905,7 +5903,7 @@ int btf_struct_access(struct bpf_verifier_log *log,=
 const struct btf *btf,
 			 * by diving in it. At this point the offset is
 			 * aligned with the new type, so set it to 0.
 			 */
-			t =3D btf_type_by_id(btf, id);
+			t =3D btf_type_by_id(btf, tmp_info.next_btf_id);
 			off =3D 0;
 			break;
 		default:
@@ -5942,7 +5940,7 @@ bool btf_struct_ids_match(struct bpf_verifier_log *=
log,
 			  bool strict)
 {
 	const struct btf_type *type;
-	enum bpf_type_flag flag;
+	struct btf_struct_access_info info =3D {};
 	int err;
=20
 	/* Are we already done? */
@@ -5958,7 +5956,7 @@ bool btf_struct_ids_match(struct bpf_verifier_log *=
log,
 	type =3D btf_type_by_id(btf, id);
 	if (!type)
 		return false;
-	err =3D btf_struct_walk(log, btf, type, off, 1, &id, &flag);
+	err =3D btf_struct_walk(log, btf, type, off, 1, &info);
 	if (err !=3D WALK_STRUCT)
 		return false;
=20
@@ -5967,6 +5965,7 @@ bool btf_struct_ids_match(struct bpf_verifier_log *=
log,
 	 * continue the search with offset 0 in the new
 	 * type.
 	 */
+	id =3D info.next_btf_id;
 	if (!btf_types_are_same(btf, id, need_btf, need_type_id)) {
 		off =3D 0;
 		goto again;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d3b75aa0c54d..4d50f9568245 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4648,8 +4648,7 @@ static int check_ptr_to_btf_access(struct bpf_verif=
ier_env *env,
 	struct bpf_reg_state *reg =3D regs + regno;
 	const struct btf_type *t =3D btf_type_by_id(reg->btf, reg->btf_id);
 	const char *tname =3D btf_name_by_offset(reg->btf, t->name_off);
-	enum bpf_type_flag flag =3D 0;
-	u32 btf_id;
+	struct btf_struct_access_info info =3D {};
 	int ret;
=20
 	if (off < 0) {
@@ -4684,7 +4683,7 @@ static int check_ptr_to_btf_access(struct bpf_verif=
ier_env *env,
=20
 	if (env->ops->btf_struct_access) {
 		ret =3D env->ops->btf_struct_access(&env->log, reg->btf, t,
-						  off, size, atype, &btf_id, &flag);
+						  off, size, atype, &info);
 	} else {
 		if (atype !=3D BPF_READ) {
 			verbose(env, "only read is supported\n");
@@ -4692,7 +4691,7 @@ static int check_ptr_to_btf_access(struct bpf_verif=
ier_env *env,
 		}
=20
 		ret =3D btf_struct_access(&env->log, reg->btf, t, off, size,
-					atype, &btf_id, &flag);
+					atype, &info);
 	}
=20
 	if (ret < 0)
@@ -4702,10 +4701,11 @@ static int check_ptr_to_btf_access(struct bpf_ver=
ifier_env *env,
 	 * also inherit the untrusted flag.
 	 */
 	if (type_flag(reg->type) & PTR_UNTRUSTED)
-		flag |=3D PTR_UNTRUSTED;
+		info.flag |=3D PTR_UNTRUSTED;
=20
 	if (atype =3D=3D BPF_READ && value_regno >=3D 0)
-		mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
+		mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, info.next_btf_i=
d,
+				info.flag);
=20
 	return 0;
 }
@@ -4717,11 +4717,10 @@ static int check_ptr_to_map_access(struct bpf_ver=
ifier_env *env,
 				   int value_regno)
 {
 	struct bpf_reg_state *reg =3D regs + regno;
+	struct btf_struct_access_info info =3D {};
 	struct bpf_map *map =3D reg->map_ptr;
-	enum bpf_type_flag flag =3D 0;
 	const struct btf_type *t;
 	const char *tname;
-	u32 btf_id;
 	int ret;
=20
 	if (!btf_vmlinux) {
@@ -4756,12 +4755,13 @@ static int check_ptr_to_map_access(struct bpf_ver=
ifier_env *env,
 		return -EACCES;
 	}
=20
-	ret =3D btf_struct_access(&env->log, btf_vmlinux, t, off, size, atype, =
&btf_id, &flag);
+	ret =3D btf_struct_access(&env->log, btf_vmlinux, t, off, size, atype, =
&info);
 	if (ret < 0)
 		return ret;
=20
 	if (value_regno >=3D 0)
-		mark_btf_ld_reg(env, regs, value_regno, ret, btf_vmlinux, btf_id, flag=
);
+		mark_btf_ld_reg(env, regs, value_regno, ret, btf_vmlinux, info.next_bt=
f_id,
+				info.flag);
=20
 	return 0;
 }
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_op=
s.c
index e78dadfc5829..dd72028ac5b1 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -159,8 +159,7 @@ static int bpf_dummy_ops_btf_struct_access(struct bpf=
_verifier_log *log,
 					   const struct btf *btf,
 					   const struct btf_type *t, int off,
 					   int size, enum bpf_access_type atype,
-					   u32 *next_btf_id,
-					   enum bpf_type_flag *flag)
+					   struct btf_struct_access_info *info)
 {
 	const struct btf_type *state;
 	s32 type_id;
@@ -177,8 +176,7 @@ static int bpf_dummy_ops_btf_struct_access(struct bpf=
_verifier_log *log,
 		return -EACCES;
 	}
=20
-	err =3D btf_struct_access(log, btf, t, off, size, atype, next_btf_id,
-				flag);
+	err =3D btf_struct_access(log, btf, t, off, size, atype, info);
 	if (err < 0)
 		return err;
=20
diff --git a/net/core/filter.c b/net/core/filter.c
index cb3b635e35be..98f10147c677 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8653,26 +8653,24 @@ EXPORT_SYMBOL_GPL(nf_conn_btf_access_lock);
=20
 int (*nfct_btf_struct_access)(struct bpf_verifier_log *log, const struct=
 btf *btf,
 			      const struct btf_type *t, int off, int size,
-			      enum bpf_access_type atype, u32 *next_btf_id,
-			      enum bpf_type_flag *flag);
+			      enum bpf_access_type atype,
+			      struct btf_struct_access_info *info);
 EXPORT_SYMBOL_GPL(nfct_btf_struct_access);
=20
 static int tc_cls_act_btf_struct_access(struct bpf_verifier_log *log,
 					const struct btf *btf,
 					const struct btf_type *t, int off,
 					int size, enum bpf_access_type atype,
-					u32 *next_btf_id,
-					enum bpf_type_flag *flag)
+					struct btf_struct_access_info *info)
 {
 	int ret =3D -EACCES;
=20
 	if (atype =3D=3D BPF_READ)
-		return btf_struct_access(log, btf, t, off, size, atype, next_btf_id,
-					 flag);
+		return btf_struct_access(log, btf, t, off, size, atype, info);
=20
 	mutex_lock(&nf_conn_btf_access_lock);
 	if (nfct_btf_struct_access)
-		ret =3D nfct_btf_struct_access(log, btf, t, off, size, atype, next_btf=
_id, flag);
+		ret =3D nfct_btf_struct_access(log, btf, t, off, size, atype, info);
 	mutex_unlock(&nf_conn_btf_access_lock);
=20
 	return ret;
@@ -8741,18 +8739,16 @@ static int xdp_btf_struct_access(struct bpf_verif=
ier_log *log,
 				 const struct btf *btf,
 				 const struct btf_type *t, int off,
 				 int size, enum bpf_access_type atype,
-				 u32 *next_btf_id,
-				 enum bpf_type_flag *flag)
+				 struct btf_struct_access_info *info)
 {
 	int ret =3D -EACCES;
=20
 	if (atype =3D=3D BPF_READ)
-		return btf_struct_access(log, btf, t, off, size, atype, next_btf_id,
-					 flag);
+		return btf_struct_access(log, btf, t, off, size, atype, info);
=20
 	mutex_lock(&nf_conn_btf_access_lock);
 	if (nfct_btf_struct_access)
-		ret =3D nfct_btf_struct_access(log, btf, t, off, size, atype, next_btf=
_id, flag);
+		ret =3D nfct_btf_struct_access(log, btf, t, off, size, atype, info);
 	mutex_unlock(&nf_conn_btf_access_lock);
=20
 	return ret;
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 6da16ae6a962..dde4ac3f44fd 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -72,14 +72,12 @@ static int bpf_tcp_ca_btf_struct_access(struct bpf_ve=
rifier_log *log,
 					const struct btf *btf,
 					const struct btf_type *t, int off,
 					int size, enum bpf_access_type atype,
-					u32 *next_btf_id,
-					enum bpf_type_flag *flag)
+					struct btf_struct_access_info *info)
 {
 	size_t end;
=20
 	if (atype =3D=3D BPF_READ)
-		return btf_struct_access(log, btf, t, off, size, atype, next_btf_id,
-					 flag);
+		return btf_struct_access(log, btf, t, off, size, atype, info);
=20
 	if (t !=3D tcp_sock_type) {
 		bpf_log(log, "only read is supported\n");
diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrac=
k_bpf.c
index 8639e7efd0e2..e09b0dfd8115 100644
--- a/net/netfilter/nf_conntrack_bpf.c
+++ b/net/netfilter/nf_conntrack_bpf.c
@@ -194,8 +194,7 @@ static int _nf_conntrack_btf_struct_access(struct bpf=
_verifier_log *log,
 					   const struct btf *btf,
 					   const struct btf_type *t, int off,
 					   int size, enum bpf_access_type atype,
-					   u32 *next_btf_id,
-					   enum bpf_type_flag *flag)
+					   struct btf_struct_access_info *info)
 {
 	const struct btf_type *ncit;
 	const struct btf_type *nct;
--=20
2.30.2

