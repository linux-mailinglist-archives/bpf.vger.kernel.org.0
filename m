Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411374733E6
	for <lists+bpf@lfdr.de>; Mon, 13 Dec 2021 19:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241854AbhLMSVv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Dec 2021 13:21:51 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1542 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235476AbhLMSVu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Dec 2021 13:21:50 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BDHAFwu017054
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 10:21:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=0mhf+ELpsguQmVFw7yGH7OPAq89LMDBOQQlTz+JobGQ=;
 b=Evu/MYqbtjVVWI0fflqSGl35DqgouyqUNQQ/7w6CcOXDSZSn13n+NGbeTO1WJGpy+faR
 NpMlGhdT4S3JHDEQuaHqNxf2zNF1dMXjdv03omDBOZ2auS6obVN2MxaBViyOwlLiSPia
 UcOmsPqVKRgXybMsjHr7UnELtAIJJzN0pFI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3cx9rp0ws5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 10:21:48 -0800
Received: from intmgw001.27.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 13 Dec 2021 10:21:45 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id B2D19537A4B; Mon, 13 Dec 2021 10:21:44 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>
CC:     <christylee@fb.com>, <bpf@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 3/3] Only output backtracking information in log level 2
Date:   Mon, 13 Dec 2021 10:21:17 -0800
Message-ID: <20211213182117.682461-4-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211213182117.682461-1-christylee@fb.com>
References: <20211213182117.682461-1-christylee@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: eJHCyKxwXEsvaH7bzLVbVJhEX4obo-IE
X-Proofpoint-GUID: eJHCyKxwXEsvaH7bzLVbVJhEX4obo-IE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-13_08,2021-12-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112130114
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Backtracking information is very verbose, don't print it in log
level 1 to improve readability.

Signed-off-by: Christy Lee <christylee@fb.com>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6d6934fd91e6..d41b7db0d296 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2396,7 +2396,7 @@ static int backtrack_insn(struct bpf_verifier_env *=
env, int idx,
=20
 	if (insn->code =3D=3D 0)
 		return 0;
-	if (env->log.level & BPF_LOG_LEVEL) {
+	if (env->log.level & BPF_LOG_LEVEL2) {
 		verbose(env, "regs=3D%x stack=3D%llx before ", *reg_mask, *stack_mask)=
;
 		verbose(env, "%d: ", idx);
 		print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
@@ -2741,7 +2741,7 @@ static int __mark_chain_precision(struct bpf_verifi=
er_env *env, int regno,
 				new_marks =3D true;
 			reg->precise =3D true;
 		}
-		if (env->log.level & BPF_LOG_LEVEL) {
+		if (env->log.level & BPF_LOG_LEVEL2) {
 			print_verifier_state(env, func);
 			verbose(env, "parent %s regs=3D%x stack=3D%llx marks\n",
 				new_marks ? "didn't have" : "already had",
--=20
2.30.2

