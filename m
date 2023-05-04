Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9BF6F6466
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 07:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjEDFd7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 May 2023 01:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEDFd7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 May 2023 01:33:59 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9951B1BEB
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 22:33:57 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3440qRFG023172
        for <bpf@vger.kernel.org>; Wed, 3 May 2023 22:33:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=TabE7jwAh6oZYRmGnSUkJ6+20VLHXm/JpOuJLqf7+wE=;
 b=K3gPGid3pgkzome5qKSQt7q7v0yCWQxVnLT34+D9IA22gBe+INobWTAuaPjqcUtlmidH
 Lnw+DkgGpTSdoE0FwpWAR/1tfFjCZn8qJLFtwxAa1+/Gr24dPz5XVZl8K+ACW9Qn++91
 Kyctwn0krDsS6Nt0tbOtp0gq66dBxq3ttQc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qbhx28a31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 22:33:56 -0700
Received: from twshared4902.04.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 3 May 2023 22:33:55 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 6CBA91D7BFC5B; Wed,  3 May 2023 22:33:47 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 3/9] bpf: Fix __bpf_{list,rbtree}_add's beginning-of-node calculation
Date:   Wed, 3 May 2023 22:33:32 -0700
Message-ID: <20230504053338.1778690-4-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230504053338.1778690-1-davemarchevsky@fb.com>
References: <20230504053338.1778690-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: FDJri5Z8EkUiWEqeRkred-cgVCMbiU-7
X-Proofpoint-GUID: FDJri5Z8EkUiWEqeRkred-cgVCMbiU-7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_02,2023-05-03_01,2023-02-09_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Given the pointer to struct bpf_{rb,list}_node within a local kptr and
the byte offset of that field within the kptr struct, the calculation cha=
nged
by this patch is meant to find the beginning of the kptr so that it can
be passed to bpf_obj_drop.

Unfortunately instead of doing

  ptr_to_kptr =3D ptr_to_node_field - offset_bytes

the calculation is erroneously doing

  ptr_to_ktpr =3D ptr_to_node_field - (offset_bytes * sizeof(struct bpf_r=
b_node))

or the bpf_list_node equivalent.

This patch fixes the calculation.

Fixes: d2dcc67df910 ("bpf: Migrate bpf_rbtree_add and bpf_list_push_{fron=
t,back} to possibly fail")
Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index bb6b4637ebf2..7a8968839e91 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1950,7 +1950,7 @@ static int __bpf_list_add(struct bpf_list_node *nod=
e, struct bpf_list_head *head
 		INIT_LIST_HEAD(h);
 	if (!list_empty(n)) {
 		/* Only called from BPF prog, no need to migrate_disable */
-		__bpf_obj_drop_impl(n - off, rec);
+		__bpf_obj_drop_impl((void *)n - off, rec);
 		return -EINVAL;
 	}
=20
@@ -2032,7 +2032,7 @@ static int __bpf_rbtree_add(struct bpf_rb_root *roo=
t, struct bpf_rb_node *node,
=20
 	if (!RB_EMPTY_NODE(n)) {
 		/* Only called from BPF prog, no need to migrate_disable */
-		__bpf_obj_drop_impl(n - off, rec);
+		__bpf_obj_drop_impl((void *)n - off, rec);
 		return -EINVAL;
 	}
=20
--=20
2.34.1

