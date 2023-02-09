Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C79690F69
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 18:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBIRmV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 12:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjBIRmU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 12:42:20 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CB85C88C
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 09:42:19 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319H671I014344
        for <bpf@vger.kernel.org>; Thu, 9 Feb 2023 09:42:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=AjAUwe7gQC6OovnCABn3IqW7kQv2EygZ4w2Ir6t+bjk=;
 b=SqB8Lv0Tm7y7loQog1QrzQ0FwXjP3oVCj2Qw3kJCeuVKUavNAjtf1t5siG8Jqnq8wa4v
 +RyLiOP68iTMaYT0JpGBtmMhjRNtAfnmlpbpSp/tbY64zKknmUJBC3krSTK1agVI7T3t
 yxc2KiQ68dOopZXYF6g0X6P8DzAl4g9jBN0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nn1bxj71n-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 09 Feb 2023 09:42:18 -0800
Received: from twshared24004.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 9 Feb 2023 09:42:16 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 580EC16906055; Thu,  9 Feb 2023 09:42:10 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v4 bpf-next 09/11] bpf: Add bpf_rbtree_{add,remove,first} decls to bpf_experimental.h
Date:   Thu, 9 Feb 2023 09:41:42 -0800
Message-ID: <20230209174144.3280955-10-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230209174144.3280955-1-davemarchevsky@fb.com>
References: <20230209174144.3280955-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: fNg_Gh_Zgv26vTbxpogPiE3Py6Q7Jfkp
X-Proofpoint-GUID: fNg_Gh_Zgv26vTbxpogPiE3Py6Q7Jfkp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_13,2023-02-09_03,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

These kfuncs will be used by selftests in following patches

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 .../testing/selftests/bpf/bpf_experimental.h  | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testi=
ng/selftests/bpf/bpf_experimental.h
index 424f7bbbfe9b..dbd2c729781a 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -65,4 +65,28 @@ extern struct bpf_list_node *bpf_list_pop_front(struct=
 bpf_list_head *head) __ks
  */
 extern struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *hea=
d) __ksym;
=20
+/* Description
+ *	Remove 'node' from rbtree with root 'root'
+ * Returns
+ * 	Pointer to the removed node, or NULL if 'root' didn't contain 'node'
+ */
+extern struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
+					     struct bpf_rb_node *node) __ksym;
+
+/* Description
+ *	Add 'node' to rbtree with root 'root' using comparator 'less'
+ * Returns
+ *	Nothing
+ */
+extern void bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node =
*node,
+			   bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b)) _=
_ksym;
+
+/* Description
+ *	Return the first (leftmost) node in input tree
+ * Returns
+ *	Pointer to the node, which is _not_ removed from the tree. If the tre=
e
+ *	contains no nodes, returns NULL.
+ */
+extern struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root) __=
ksym;
+
 #endif
--=20
2.30.2

