Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1385625C07
	for <lists+bpf@lfdr.de>; Wed, 22 May 2019 05:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfEVDO1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 21 May 2019 23:14:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33530 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728343AbfEVDO1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 May 2019 23:14:27 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4M36dVH018661
        for <bpf@vger.kernel.org>; Tue, 21 May 2019 20:14:25 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0b-00082601.pphosted.com with ESMTP id 2smrb112fs-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 21 May 2019 20:14:25 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 21 May 2019 20:14:24 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id DA6F6760CB3; Tue, 21 May 2019 20:14:23 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 1/3] bpf: bump jmp sequence limit
Date:   Tue, 21 May 2019 20:14:19 -0700
Message-ID: <20190522031421.2825174-2-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190522031421.2825174-1-ast@kernel.org>
References: <20190522031421.2825174-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-22_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=932 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905220020
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The limit of 1024 subsequent jumps was causing otherwise valid
programs to be rejected. Bump it to 8192 and make the error more verbose.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 kernel/bpf/verifier.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 082f6eefb1c4..4113e829616d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -176,7 +176,7 @@ struct bpf_verifier_stack_elem {
 	struct bpf_verifier_stack_elem *next;
 };
 
-#define BPF_COMPLEXITY_LIMIT_STACK	1024
+#define BPF_COMPLEXITY_LIMIT_JMP_SEQ	8192
 #define BPF_COMPLEXITY_LIMIT_STATES	64
 
 #define BPF_MAP_PTR_UNPRIV	1UL
@@ -782,8 +782,9 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 	if (err)
 		goto err;
 	elem->st.speculative |= speculative;
-	if (env->stack_size > BPF_COMPLEXITY_LIMIT_STACK) {
-		verbose(env, "BPF program is too complex\n");
+	if (env->stack_size > BPF_COMPLEXITY_LIMIT_JMP_SEQ) {
+		verbose(env, "The sequence of %d jumps is too complex.\n",
+			env->stack_size);
 		goto err;
 	}
 	return &elem->st;
-- 
2.20.0

