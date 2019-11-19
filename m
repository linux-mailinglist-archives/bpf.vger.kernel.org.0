Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2BB102D13
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2019 20:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfKST5O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Nov 2019 14:57:14 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37370 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726722AbfKST5O (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 19 Nov 2019 14:57:14 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAJJusbh000499
        for <bpf@vger.kernel.org>; Tue, 19 Nov 2019 11:57:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=0P4TrnQ5rmtpj5v3ue8RxaRIxEp8lpQaFp9/61+p9PA=;
 b=kRK+NYh0UIMD3jnzvovZCbOBU04U2xn0Xs69XxJdVE5ABvI2XGk8aZKaA87L9zZ+Giw1
 9Lj6EDCuk7oWRQYk8BYbF0iW2Zk/9eCXXHRvzsaSVxdcY6SuVfk6obH0KMgVlck6GG2D
 vLqYGS2EyruFeOmbHGhivSFLlRnNgEP9/0o= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wcnrv0dvu-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 19 Nov 2019 11:57:14 -0800
Received: from 2401:db00:30:600c:face:0:1f:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 19 Nov 2019 11:57:12 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id B0878370243D; Tue, 19 Nov 2019 11:57:11 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v2 1/3] bpf: add a helper to set preciseness of an unknown register
Date:   Tue, 19 Nov 2019 11:57:11 -0800
Message-ID: <20191119195711.3691868-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191119195711.3691681-1-yhs@fb.com>
References: <20191119195711.3691681-1-yhs@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-19_07:2019-11-15,2019-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 spamscore=0
 mlxlogscore=770 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=13 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911190163
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The patch refactored verifier.c function __mark_reg_unbounded()
to have a helper function __set_unknown_reg_precise() to
set the preciseness of an unknown register. The helper will
be used in the next patch to set the preciseness of
an unknown sub-register.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9f59f7a19dd0..a344b08aef77 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1007,6 +1007,14 @@ static void __reg_bound_offset(struct bpf_reg_state *reg)
 						 reg->umax_value));
 }
 
+/* constant backtracking is enabled for root without bpf2bpf calls */
+static void __set_unknown_reg_precise(struct bpf_verifier_env *env,
+				      struct bpf_reg_state *reg)
+{
+	reg->precise = env->subprog_cnt > 1 || !env->allow_ptr_leaks ?
+			true : false;
+}
+
 /* Reset the min/max bounds of a register */
 static void __mark_reg_unbounded(struct bpf_reg_state *reg)
 {
@@ -1042,9 +1050,7 @@ static void mark_reg_unknown(struct bpf_verifier_env *env,
 	}
 	regs += regno;
 	__mark_reg_unknown(regs);
-	/* constant backtracking is enabled for root without bpf2bpf calls */
-	regs->precise = env->subprog_cnt > 1 || !env->allow_ptr_leaks ?
-			true : false;
+	__set_unknown_reg_precise(env, regs);
 }
 
 static void __mark_reg_not_init(struct bpf_reg_state *reg)
-- 
2.17.1

