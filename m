Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975DA325CE8
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 06:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhBZFN6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 00:13:58 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:18384 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229526AbhBZFN5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 00:13:57 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11Q5A0B1009881
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 21:13:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=tg9LfpYbMxjm52ajiOrSHV93nydkxQ8us6p8+Pwgjgg=;
 b=IsBQRQmuHo/duTPs8xEr6aNiBB67nxUIzc7zjVMYlAhlIqp4IoM+PKwkb1vEZnH1NEHS
 W+o0Z12IAPQ8zfNhhd+/lHQv3X8IG4RJmcvQslETW3yK02FjY/mr5cR4bVACU0PtdU82
 xrQGVit1Y59uQ7RmeTDLk+DfKQRT/MMTTWk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36x9cawr7m-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 21:13:16 -0800
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 25 Feb 2021 21:13:08 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id E17E73705FFD; Thu, 25 Feb 2021 21:13:05 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v4 01/12] bpf: factor out visit_func_call_insn() in check_cfg()
Date:   Thu, 25 Feb 2021 21:13:05 -0800
Message-ID: <20210226051305.3428292-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210226051305.3428235-1-yhs@fb.com>
References: <20210226051305.3428235-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_01:2021-02-24,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=896
 malwarescore=0 mlxscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 adultscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260038
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

During verifier check_cfg(), all instructions are
visited to ensure verifier can handle program control flows.
This patch factored out function visit_func_call_insn()
so it can be reused in later patch to visit callback function
calls. There is no functionality change for this patch.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1dda9d81f12c..9cb182e91162 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8592,6 +8592,27 @@ static int push_insn(int t, int w, int e, struct b=
pf_verifier_env *env,
 	return DONE_EXPLORING;
 }
=20
+static int visit_func_call_insn(int t, int insn_cnt,
+				struct bpf_insn *insns,
+				struct bpf_verifier_env *env,
+				bool visit_callee)
+{
+	int ret;
+
+	ret =3D push_insn(t, t + 1, FALLTHROUGH, env, false);
+	if (ret)
+		return ret;
+
+	if (t + 1 < insn_cnt)
+		init_explored_state(env, t + 1);
+	if (visit_callee) {
+		init_explored_state(env, t);
+		ret =3D push_insn(t, t + insns[t].imm + 1, BRANCH,
+				env, false);
+	}
+	return ret;
+}
+
 /* Visits the instruction at index t and returns one of the following:
  *  < 0 - an error occurred
  *  DONE_EXPLORING - the instruction was fully explored
@@ -8612,18 +8633,8 @@ static int visit_insn(int t, int insn_cnt, struct =
bpf_verifier_env *env)
 		return DONE_EXPLORING;
=20
 	case BPF_CALL:
-		ret =3D push_insn(t, t + 1, FALLTHROUGH, env, false);
-		if (ret)
-			return ret;
-
-		if (t + 1 < insn_cnt)
-			init_explored_state(env, t + 1);
-		if (insns[t].src_reg =3D=3D BPF_PSEUDO_CALL) {
-			init_explored_state(env, t);
-			ret =3D push_insn(t, t + insns[t].imm + 1, BRANCH,
-					env, false);
-		}
-		return ret;
+		return visit_func_call_insn(t, insn_cnt, insns, env,
+					    insns[t].src_reg =3D=3D BPF_PSEUDO_CALL);
=20
 	case BPF_JA:
 		if (BPF_SRC(insns[t].code) !=3D BPF_K)
--=20
2.24.1

