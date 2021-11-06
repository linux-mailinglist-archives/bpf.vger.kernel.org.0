Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC97B446BEE
	for <lists+bpf@lfdr.de>; Sat,  6 Nov 2021 02:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhKFBnA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 21:43:00 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40744 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229816AbhKFBm7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Nov 2021 21:42:59 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A5MExhk013498
        for <bpf@vger.kernel.org>; Fri, 5 Nov 2021 18:40:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=MxgnZ/8O4D6BBIOfTkHU8P3gfPvcnpnCpF0NdllozvA=;
 b=G8rVVYO9mPz/4Pa7DtodeJjfp5b4nCzTIhqTIzNh4YJBcuSgWjSSvNWjtps3jzQ/4VzD
 uav4OzQAJd7iQSYCvqESSqtH8oKg3e692t//tgzfz6v+vnTFgtPfLcOdV/e7CUpr6lHN
 NCM4mGAwhANK3ez6NEF6fOGTlanjfXMCAiw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c5cj5s87n-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 05 Nov 2021 18:40:18 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 5 Nov 2021 18:40:18 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 1DB8D1F57C38; Fri,  5 Nov 2021 18:40:14 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf 1/2] bpf: Stop caching subprog index in the bpf_pseudo_func insn
Date:   Fri, 5 Nov 2021 18:40:14 -0700
Message-ID: <20211106014014.651018-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211106014007.650366-1-kafai@fb.com>
References: <20211106014007.650366-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: lnOJ5lTBRXVgtFOcsW9uksExlBj6-GDc
X-Proofpoint-ORIG-GUID: lnOJ5lTBRXVgtFOcsW9uksExlBj6-GDc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-05_03,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=10
 lowpriorityscore=10 adultscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=893 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111060006
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch is to fix an out-of-bound access issue when jit-ing the
bpf_pseudo_func insn (i.e. ld_imm64 with src_reg =3D=3D BPF_PSEUDO_FUNC)

In jit_subprog(), it currently reuses the subprog index cached in
insn[1].imm.  This subprog index is an index into a few array related
to subprogs.  For example, in jit_subprog(), it is an index to the newly
allocated 'struct bpf_prog **func' array.

The subprog index was cached in insn[1].imm after add_subprog().  However=
,
this could become outdated (and too big in this case) if some subprogs
are completely removed during dead code elimination (in
adjust_subprog_starts_after_remove).  The cached index in insn[1].imm
is not updated accordingly and causing out-of-bound issue in the later
jit_subprog().

Unlike bpf_pseudo_'func' insn, the current bpf_pseudo_'call' insn
is handling the DCE properly by calling find_subprog(insn->imm) to
figure out the index instead of caching the subprog index.
The existing bpf_adj_branches() will adjust the insn->imm
whenever insn is added or removed.

Instead of having two ways handling subprog index,
this patch is to make bpf_pseudo_func works more like
bpf_pseudo_call.

First change is to stop caching the subprog index result
in insn[1].imm after add_subprog().  The verification
process will use find_subprog(insn->imm) to figure
out the subprog index.

Second change is in bpf_adj_branches() and have it to
adjust the insn->imm for the bpf_pseudo_func insn also
whenever insn is added or removed.

Third change is in jit_subprog().  Like the bpf_pseudo_call handling,
bpf_pseudo_func temporarily stores the find_subprog() result
in insn->off.  It is fine because the prog's insn has been finalized
at this point.  insn->off will be reset back to 0 later to avoid
confusing the userspace prog dump tool.

Fixes: 69c087ba6225 ("bpf: Add bpf_for_each_map_elem() helper")
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf.h   |  6 ++++++
 kernel/bpf/core.c     |  7 +++++++
 kernel/bpf/verifier.c | 37 ++++++++++++++-----------------------
 3 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2be6dfd68df9..f715e8863f4d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -484,6 +484,12 @@ bpf_ctx_record_field_size(struct bpf_insn_access_aux=
 *aux, u32 size)
 	aux->ctx_field_size =3D size;
 }
=20
+static inline bool bpf_pseudo_func(const struct bpf_insn *insn)
+{
+	return insn->code =3D=3D (BPF_LD | BPF_IMM | BPF_DW) &&
+	       insn->src_reg =3D=3D BPF_PSEUDO_FUNC;
+}
+
 struct bpf_prog_ops {
 	int (*test_run)(struct bpf_prog *prog, const union bpf_attr *kattr,
 			union bpf_attr __user *uattr);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 327e3996eadb..2405e39d800f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -390,6 +390,13 @@ static int bpf_adj_branches(struct bpf_prog *prog, u=
32 pos, s32 end_old,
 			i =3D end_new;
 			insn =3D prog->insnsi + end_old;
 		}
+		if (bpf_pseudo_func(insn)) {
+			ret =3D bpf_adj_delta_to_imm(insn, pos, end_old,
+						   end_new, i, probe_pass);
+			if (ret)
+				return ret;
+			continue;
+		}
 		code =3D insn->code;
 		if ((BPF_CLASS(code) !=3D BPF_JMP &&
 		     BPF_CLASS(code) !=3D BPF_JMP32) ||
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5f8d9128860a..890b3ec375a3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -240,12 +240,6 @@ static bool bpf_pseudo_kfunc_call(const struct bpf_i=
nsn *insn)
 	       insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL;
 }
=20
-static bool bpf_pseudo_func(const struct bpf_insn *insn)
-{
-	return insn->code =3D=3D (BPF_LD | BPF_IMM | BPF_DW) &&
-	       insn->src_reg =3D=3D BPF_PSEUDO_FUNC;
-}
-
 struct bpf_call_arg_meta {
 	struct bpf_map *map_ptr;
 	bool raw_mode;
@@ -1960,16 +1954,10 @@ static int add_subprog_and_kfunc(struct bpf_verif=
ier_env *env)
 			return -EPERM;
 		}
=20
-		if (bpf_pseudo_func(insn)) {
+		if (bpf_pseudo_func(insn) || bpf_pseudo_call(insn))
 			ret =3D add_subprog(env, i + insn->imm + 1);
-			if (ret >=3D 0)
-				/* remember subprog */
-				insn[1].imm =3D ret;
-		} else if (bpf_pseudo_call(insn)) {
-			ret =3D add_subprog(env, i + insn->imm + 1);
-		} else {
+		else
 			ret =3D add_kfunc_call(env, insn->imm, insn->off);
-		}
=20
 		if (ret < 0)
 			return ret;
@@ -9387,7 +9375,8 @@ static int check_ld_imm(struct bpf_verifier_env *en=
v, struct bpf_insn *insn)
=20
 	if (insn->src_reg =3D=3D BPF_PSEUDO_FUNC) {
 		struct bpf_prog_aux *aux =3D env->prog->aux;
-		u32 subprogno =3D insn[1].imm;
+		u32 subprogno =3D find_subprog(env,
+					     env->insn_idx + insn->imm + 1);
=20
 		if (!aux->func_info) {
 			verbose(env, "missing btf func_info\n");
@@ -12557,14 +12546,9 @@ static int jit_subprogs(struct bpf_verifier_env =
*env)
 		return 0;
=20
 	for (i =3D 0, insn =3D prog->insnsi; i < prog->len; i++, insn++) {
-		if (bpf_pseudo_func(insn)) {
-			env->insn_aux_data[i].call_imm =3D insn->imm;
-			/* subprog is encoded in insn[1].imm */
+		if (!bpf_pseudo_func(insn) && !bpf_pseudo_call(insn))
 			continue;
-		}
=20
-		if (!bpf_pseudo_call(insn))
-			continue;
 		/* Upon error here we cannot fall back to interpreter but
 		 * need a hard reject of the program. Thus -EFAULT is
 		 * propagated in any case.
@@ -12585,6 +12569,12 @@ static int jit_subprogs(struct bpf_verifier_env =
*env)
 		env->insn_aux_data[i].call_imm =3D insn->imm;
 		/* point imm to __bpf_call_base+1 from JITs point of view */
 		insn->imm =3D 1;
+		if (bpf_pseudo_func(insn))
+			/* jit (e.g. x86_64) may emit fewer instructions
+			 * if it learns a u32 imm is the same as a u64 imm.
+			 * Force a non zero here.
+			 */
+			insn[1].imm =3D 1;
 	}
=20
 	err =3D bpf_prog_alloc_jited_linfo(prog);
@@ -12669,7 +12659,7 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
 		insn =3D func[i]->insnsi;
 		for (j =3D 0; j < func[i]->len; j++, insn++) {
 			if (bpf_pseudo_func(insn)) {
-				subprog =3D insn[1].imm;
+				subprog =3D insn->off;
 				insn[0].imm =3D (u32)(long)func[subprog]->bpf_func;
 				insn[1].imm =3D ((u64)(long)func[subprog]->bpf_func) >> 32;
 				continue;
@@ -12720,7 +12710,8 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
 	for (i =3D 0, insn =3D prog->insnsi; i < prog->len; i++, insn++) {
 		if (bpf_pseudo_func(insn)) {
 			insn[0].imm =3D env->insn_aux_data[i].call_imm;
-			insn[1].imm =3D find_subprog(env, i + insn[0].imm + 1);
+			insn[1].imm =3D insn->off;
+			insn->off =3D 0;
 			continue;
 		}
 		if (!bpf_pseudo_call(insn))
--=20
2.30.2

