Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01060324B47
	for <lists+bpf@lfdr.de>; Thu, 25 Feb 2021 08:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbhBYHeB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 02:34:01 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:20700 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233498AbhBYHeA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Feb 2021 02:34:00 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11P7UDf4017482
        for <bpf@vger.kernel.org>; Wed, 24 Feb 2021 23:33:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=IgobzbXTJNNLjU5y6hPozxnmgaqVwD+e6/7CBkhWA+U=;
 b=LETrWd3CQEX0N+J763zzqudtp1CkJucyqCCLnMIWvBPs1S1DXL/8ETcpfj9qAcI/usxb
 lG/t+/g3ncJewFLnHk8vX8UAEYGwwYnUdjlCAAD4ufzOPyZ08KLDrDHD9A1Hj087J4xj
 9hkUusY9aY7UHhTDMd/WED0SMS1+JUutLi8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36wkf2pe3j-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 24 Feb 2021 23:33:19 -0800
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 24 Feb 2021 23:33:16 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 0DEEE3705D0E; Wed, 24 Feb 2021 23:33:12 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 03/11] bpf: refactor check_func_call() to allow callback function
Date:   Wed, 24 Feb 2021 23:33:12 -0800
Message-ID: <20210225073312.4120415-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210225073309.4119708-1-yhs@fb.com>
References: <20210225073309.4119708-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-25_04:2021-02-24,2021-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 suspectscore=0 bulkscore=0 mlxlogscore=657 mlxscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250062
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Later proposed bpf_for_each_map_elem() helper has callback
function as one of its arguments. This patch refactored
check_func_call() to permit callback function which sets
callee state. Different callback functions may have
different callee states.

There is no functionality change for this patch except
it added a case to handle where subprog number is known
and there is no need to do find_subprog(). This case
is used later by implementing bpf_for_each_map() helper.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c | 54 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a657860ecba5..092d2c734dd8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5250,13 +5250,19 @@ static void clear_caller_saved_regs(struct bpf_ve=
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
+			     set_callee_state_fn set_callee_st)
 {
 	struct bpf_verifier_state *state =3D env->cur_state;
 	struct bpf_func_info_aux *func_info_aux;
 	struct bpf_func_state *caller, *callee;
-	int i, err, subprog, target_insn;
+	int err, target_insn;
 	bool is_global =3D false;
=20
 	if (state->curframe + 1 >=3D MAX_CALL_FRAMES) {
@@ -5265,12 +5271,16 @@ static int check_func_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn,
 		return -E2BIG;
 	}
=20
-	target_insn =3D *insn_idx + insn->imm;
-	subprog =3D find_subprog(env, target_insn + 1);
 	if (subprog < 0) {
-		verbose(env, "verifier bug. No program starts at insn %d\n",
-			target_insn + 1);
-		return -EFAULT;
+		target_insn =3D *insn_idx + insn->imm;
+		subprog =3D find_subprog(env, target_insn + 1);
+		if (subprog < 0) {
+			verbose(env, "verifier bug. No program starts at insn %d\n",
+				target_insn + 1);
+			return -EFAULT;
+		}
+	} else {
+		target_insn =3D env->subprog_info[subprog].start - 1;
 	}
=20
 	caller =3D state->frame[state->curframe];
@@ -5327,11 +5337,9 @@ static int check_func_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
 	if (err)
 		return err;
=20
-	/* copy r1 - r5 args that callee can access.  The copy includes parent
-	 * pointers, which connects us up to the liveness chain
-	 */
-	for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++)
-		callee->regs[i] =3D caller->regs[i];
+	err =3D set_callee_st(env, caller, callee, *insn_idx);
+	if (err)
+		return err;
=20
 	clear_caller_saved_regs(env, caller->regs);
=20
@@ -5350,6 +5358,26 @@ static int check_func_call(struct bpf_verifier_env=
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
+	return __check_func_call(env, insn, insn_idx, -1, set_callee_state);
+}
+
 static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx=
)
 {
 	struct bpf_verifier_state *state =3D env->cur_state;
--=20
2.24.1

