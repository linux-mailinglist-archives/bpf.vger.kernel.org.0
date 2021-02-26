Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D4A3268E0
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 21:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhBZUuI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 15:50:08 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1842 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229698AbhBZUuH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 15:50:07 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11QKhnu2004004
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 12:49:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=YARBWkmalLhpidatjrTdCpE16SfRZNXGBsbwf9oer4A=;
 b=O8ILVI+tI7hhbIeRZZ87clnmkGQ3m9dot/ZbvnEJA9pFbzK/AljwVlH1Ym5VKzEGZNCl
 dZdtnGUc06dR/fInYMqVNdrxsx4/dEpeYY7tb8aJpyfGPkgynkullD2uY2itjkBzTJkQ
 YXL2rFqYMY/AJ2PxaVMHQcheR0Q0MLbQyA0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36x96c20vt-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 12:49:26 -0800
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 26 Feb 2021 12:49:24 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 5CA0D3705324; Fri, 26 Feb 2021 12:49:23 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v5 03/12] bpf: refactor check_func_call() to allow callback function
Date:   Fri, 26 Feb 2021 12:49:23 -0800
Message-ID: <20210226204923.3884627-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210226204920.3884074-1-yhs@fb.com>
References: <20210226204920.3884074-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_09:2021-02-26,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=689 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102260155
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Later proposed bpf_for_each_map_elem() helper has callback
function as one of its arguments. This patch refactored
check_func_call() to permit callback function which sets
callee state. Different callback functions may have
different callee states.
There is no functionality change for this patch.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c | 60 +++++++++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7194980c3ca4..97e772f44cd7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5249,13 +5249,19 @@ static void clear_caller_saved_regs(struct bpf_ve=
rifier_env *env,
 	}
 }
=20
-static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn=
 *insn,
-			   int *insn_idx)
+typedef int (*set_callee_state_fn)(struct bpf_verifier_env *env,
+				   struct bpf_func_state *caller,
+				   struct bpf_func_state *callee,
+				   int insn_idx);
+
+static int __check_func_call(struct bpf_verifier_env *env, struct bpf_in=
sn *insn,
+			     int *insn_idx, int subprog,
+			     set_callee_state_fn set_callee_state_cb)
 {
 	struct bpf_verifier_state *state =3D env->cur_state;
 	struct bpf_func_info_aux *func_info_aux;
 	struct bpf_func_state *caller, *callee;
-	int i, err, subprog, target_insn;
+	int err;
 	bool is_global =3D false;
=20
 	if (state->curframe + 1 >=3D MAX_CALL_FRAMES) {
@@ -5264,14 +5270,6 @@ static int check_func_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
 		return -E2BIG;
 	}
=20
-	target_insn =3D *insn_idx + insn->imm;
-	subprog =3D find_subprog(env, target_insn + 1);
-	if (subprog < 0) {
-		verbose(env, "verifier bug. No program starts at insn %d\n",
-			target_insn + 1);
-		return -EFAULT;
-	}
-
 	caller =3D state->frame[state->curframe];
 	if (state->frame[state->curframe + 1]) {
 		verbose(env, "verifier bug. Frame %d already allocated\n",
@@ -5326,11 +5324,9 @@ static int check_func_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
 	if (err)
 		return err;
=20
-	/* copy r1 - r5 args that callee can access.  The copy includes parent
-	 * pointers, which connects us up to the liveness chain
-	 */
-	for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++)
-		callee->regs[i] =3D caller->regs[i];
+	err =3D set_callee_state_cb(env, caller, callee, *insn_idx);
+	if (err)
+		return err;
=20
 	clear_caller_saved_regs(env, caller->regs);
=20
@@ -5338,7 +5334,7 @@ static int check_func_call(struct bpf_verifier_env =
*env, struct bpf_insn *insn,
 	state->curframe++;
=20
 	/* and go analyze first insn of the callee */
-	*insn_idx =3D target_insn;
+	*insn_idx =3D env->subprog_info[subprog].start - 1;
=20
 	if (env->log.level & BPF_LOG_LEVEL) {
 		verbose(env, "caller:\n");
@@ -5349,6 +5345,36 @@ static int check_func_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
 	return 0;
 }
=20
+static int set_callee_state(struct bpf_verifier_env *env,
+			    struct bpf_func_state *caller,
+			    struct bpf_func_state *callee, int insn_idx)
+{
+	int i;
+
+	/* copy r1 - r5 args that callee can access.  The copy includes parent
+	 * pointers, which connects us up to the liveness chain
+	 */
+	for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++)
+		callee->regs[i] =3D caller->regs[i];
+	return 0;
+}
+
+static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn=
 *insn,
+			   int *insn_idx)
+{
+	int subprog, target_insn;
+
+	target_insn =3D *insn_idx + insn->imm + 1;
+	subprog =3D find_subprog(env, target_insn);
+	if (subprog < 0) {
+		verbose(env, "verifier bug. No program starts at insn %d\n",
+			target_insn);
+		return -EFAULT;
+	}
+
+	return __check_func_call(env, insn, insn_idx, subprog, set_callee_state=
);
+}
+
 static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx=
)
 {
 	struct bpf_verifier_state *state =3D env->cur_state;
--=20
2.24.1

