Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8129464F838
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 09:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiLQIZi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Dec 2022 03:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiLQIZe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Dec 2022 03:25:34 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01832F664
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 00:25:33 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2BH8K8Wh000988
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 00:25:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=AjAUwe7gQC6OovnCABn3IqW7kQv2EygZ4w2Ir6t+bjk=;
 b=DMG+NFBYrZ7gpve8KSL54uOkHC2D7lx9X+1zy/VK3AHr0NtLCR8Rso+W0ELdUvfbpclz
 xjiGvLxrVSKbD+aM5AYXHxslwfG9k1XfSD/EIRmipf+mYaHWf4CS8qAKTbTb7kAWcc4b
 4CZujT4HKizzg/hqL+U7mXgY7kd4HdJjRos= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3mha5br0p5-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 00:25:32 -0800
Received: from twshared19053.17.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 17 Dec 2022 00:25:30 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 2D6BB12A9E02B; Sat, 17 Dec 2022 00:25:19 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 10/13] bpf: Add bpf_rbtree_{add,remove,first} decls to bpf_experimental.h
Date:   Sat, 17 Dec 2022 00:25:03 -0800
Message-ID: <20221217082506.1570898-11-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221217082506.1570898-1-davemarchevsky@fb.com>
References: <20221217082506.1570898-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: -yAuCqZSaMzkGvN4vvYK95saDnUPStiY
X-Proofpoint-ORIG-GUID: -yAuCqZSaMzkGvN4vvYK95saDnUPStiY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-17_03,2022-12-15_02,2022-06-22_01
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

