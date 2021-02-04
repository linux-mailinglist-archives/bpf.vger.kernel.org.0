Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB8C3100FE
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 00:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhBDXtR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 18:49:17 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46338 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231204AbhBDXtQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 4 Feb 2021 18:49:16 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 114NkZBc005766
        for <bpf@vger.kernel.org>; Thu, 4 Feb 2021 15:48:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=y0yronlihcQovmqr2iJaIlL+FEu6qYdJfsHSuZzcJ4M=;
 b=lVoTmdGNngVvacgQMkApOcfVassnQZyqJC/C6j8rzUT2ES/9SpMVpPAFKSjnQ+2HLPxh
 Ef3qJXIMgwcHDrdBPkLf0acAv3ZIiByYv0ViDHFNINExYTB5U2hCEQaOsMNwGWDnZ0/2
 TygNiDg20K/Haf/geflcn6aQvRYrR8MdN1g= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 36g18bqyjj-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 04 Feb 2021 15:48:35 -0800
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 4 Feb 2021 15:48:33 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id EF7EB3704E76; Thu,  4 Feb 2021 15:48:27 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/8] bpf: refactor BPF_PSEUDO_CALL checking as a helper function
Date:   Thu, 4 Feb 2021 15:48:27 -0800
Message-ID: <20210204234827.1628953-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210204234827.1628857-1-yhs@fb.com>
References: <20210204234827.1628857-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_13:2021-02-04,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040144
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There is no functionality change. This refactoring intends
to facilitate next patch change with BPF_PSEUDO_FUNC.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5e09632efddb..db294b75d03b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -228,6 +228,12 @@ static void bpf_map_key_store(struct bpf_insn_aux_da=
ta *aux, u64 state)
 			     (poisoned ? BPF_MAP_KEY_POISON : 0ULL);
 }
=20
+static bool bpf_pseudo_call(const struct bpf_insn *insn)
+{
+	return insn->code =3D=3D (BPF_JMP | BPF_CALL) &&
+	       insn->src_reg =3D=3D BPF_PSEUDO_CALL;
+}
+
 struct bpf_call_arg_meta {
 	struct bpf_map *map_ptr;
 	bool raw_mode;
@@ -1486,9 +1492,7 @@ static int check_subprogs(struct bpf_verifier_env *=
env)
=20
 	/* determine subprog starts. The end is one before the next starts */
 	for (i =3D 0; i < insn_cnt; i++) {
-		if (insn[i].code !=3D (BPF_JMP | BPF_CALL))
-			continue;
-		if (insn[i].src_reg !=3D BPF_PSEUDO_CALL)
+		if (!bpf_pseudo_call(insn + i))
 			continue;
 		if (!env->bpf_capable) {
 			verbose(env,
@@ -3074,9 +3078,7 @@ static int check_max_stack_depth(struct bpf_verifie=
r_env *env)
 continue_func:
 	subprog_end =3D subprog[idx + 1].start;
 	for (; i < subprog_end; i++) {
-		if (insn[i].code !=3D (BPF_JMP | BPF_CALL))
-			continue;
-		if (insn[i].src_reg !=3D BPF_PSEUDO_CALL)
+		if (!bpf_pseudo_call(insn + i))
 			continue;
 		/* remember insn and function to return to */
 		ret_insn[frame] =3D i + 1;
@@ -10844,8 +10846,7 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
 		return 0;
=20
 	for (i =3D 0, insn =3D prog->insnsi; i < prog->len; i++, insn++) {
-		if (insn->code !=3D (BPF_JMP | BPF_CALL) ||
-		    insn->src_reg !=3D BPF_PSEUDO_CALL)
+		if (!bpf_pseudo_call(insn))
 			continue;
 		/* Upon error here we cannot fall back to interpreter but
 		 * need a hard reject of the program. Thus -EFAULT is
@@ -10974,8 +10975,7 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
 	for (i =3D 0; i < env->subprog_cnt; i++) {
 		insn =3D func[i]->insnsi;
 		for (j =3D 0; j < func[i]->len; j++, insn++) {
-			if (insn->code !=3D (BPF_JMP | BPF_CALL) ||
-			    insn->src_reg !=3D BPF_PSEUDO_CALL)
+			if (!bpf_pseudo_call(insn))
 				continue;
 			subprog =3D insn->off;
 			insn->imm =3D BPF_CAST_CALL(func[subprog]->bpf_func) -
@@ -11020,8 +11020,7 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
 	 * later look the same as if they were interpreted only.
 	 */
 	for (i =3D 0, insn =3D prog->insnsi; i < prog->len; i++, insn++) {
-		if (insn->code !=3D (BPF_JMP | BPF_CALL) ||
-		    insn->src_reg !=3D BPF_PSEUDO_CALL)
+		if (!bpf_pseudo_call(insn))
 			continue;
 		insn->off =3D env->insn_aux_data[i].call_imm;
 		subprog =3D find_subprog(env, i + insn->off + 1);
@@ -11050,8 +11049,7 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
 	/* cleanup main prog to be interpreted */
 	prog->jit_requested =3D 0;
 	for (i =3D 0, insn =3D prog->insnsi; i < prog->len; i++, insn++) {
-		if (insn->code !=3D (BPF_JMP | BPF_CALL) ||
-		    insn->src_reg !=3D BPF_PSEUDO_CALL)
+		if (!bpf_pseudo_call(insn))
 			continue;
 		insn->off =3D 0;
 		insn->imm =3D env->insn_aux_data[i].call_imm;
@@ -11086,8 +11084,7 @@ static int fixup_call_args(struct bpf_verifier_en=
v *env)
 		return -EINVAL;
 	}
 	for (i =3D 0; i < prog->len; i++, insn++) {
-		if (insn->code !=3D (BPF_JMP | BPF_CALL) ||
-		    insn->src_reg !=3D BPF_PSEUDO_CALL)
+		if (!bpf_pseudo_call(insn))
 			continue;
 		depth =3D get_callee_stack_depth(env, insn, i);
 		if (depth < 0)
--=20
2.24.1

