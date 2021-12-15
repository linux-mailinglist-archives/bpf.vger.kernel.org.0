Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DB947619A
	for <lists+bpf@lfdr.de>; Wed, 15 Dec 2021 20:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238768AbhLOTWy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Dec 2021 14:22:54 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49348 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234497AbhLOTWx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Dec 2021 14:22:53 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BFIA0sT007886
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 11:22:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=KrpxOaqHtMfiTB7lDbjujjGAiKhZbFGqNgWzrSGDZKc=;
 b=hySYY50w7AmO+ZzmeLr2QOR8sL5b17zWeZt8Tktr7RTZ5cm5GSw0aYHhQwlvSh8L98h7
 uDrKeD3RPaa+dRJZ86obKdRtYy9uxz7k2AaxFQXK8XSO8uR2Oyw33en6HK2Viw3ha80+
 PO2vIGMFxoPqcK/yBoldrESy2ojUxTBt3gI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3cyeadc01h-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 11:22:52 -0800
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 11:22:51 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id AD4306B96C8; Wed, 15 Dec 2021 11:22:49 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>
CC:     <bpf@vger.kernel.org>, <kernel-team@fb.com>, <christylee@fb.com>,
        <christyc.y.lee@gmail.com>
Subject: [PATCH v2 bpf-next 3/3] Only output backtracking information in log level 2
Date:   Wed, 15 Dec 2021 11:22:25 -0800
Message-ID: <20211215192225.1278237-4-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211215192225.1278237-1-christylee@fb.com>
References: <20211215192225.1278237-1-christylee@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: Z97aEpOmULawsXkhJ2hGJa4P0hMGdNrZ
X-Proofpoint-GUID: Z97aEpOmULawsXkhJ2hGJa4P0hMGdNrZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-15_11,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0
 malwarescore=0 phishscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112150107
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Backtracking information is very verbose, don't print it in log
level 1 to improve readability.

Signed-off-by: Christy Lee <christylee@fb.com>
---
 kernel/bpf/verifier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a8f1426b0367..2cb86972ed35 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2398,7 +2398,7 @@ static int backtrack_insn(struct bpf_verifier_env *=
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
@@ -2656,7 +2656,7 @@ static int __mark_chain_precision(struct bpf_verifi=
er_env *env, int regno,
 		DECLARE_BITMAP(mask, 64);
 		u32 history =3D st->jmp_history_cnt;
=20
-		if (env->log.level & BPF_LOG_LEVEL)
+		if (env->log.level & BPF_LOG_LEVEL2)
 			verbose(env, "last_idx %d first_idx %d\n", last_idx, first_idx);
 		for (i =3D last_idx;;) {
 			if (skip_first) {
@@ -2743,7 +2743,7 @@ static int __mark_chain_precision(struct bpf_verifi=
er_env *env, int regno,
 				new_marks =3D true;
 			reg->precise =3D true;
 		}
-		if (env->log.level & BPF_LOG_LEVEL) {
+		if (env->log.level & BPF_LOG_LEVEL2) {
 			mark_verifier_state_scratched(env);
 			verbose(env, "parent %s regs=3D%x stack=3D%llx marks:",
 				new_marks ? "didn't have" : "already had",
--=20
2.30.2

