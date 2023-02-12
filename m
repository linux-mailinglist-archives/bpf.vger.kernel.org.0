Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE066936B5
	for <lists+bpf@lfdr.de>; Sun, 12 Feb 2023 10:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjBLJ1v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Feb 2023 04:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBLJ1u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Feb 2023 04:27:50 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FAB10A8E
        for <bpf@vger.kernel.org>; Sun, 12 Feb 2023 01:27:49 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 31C799Ks012203
        for <bpf@vger.kernel.org>; Sun, 12 Feb 2023 01:27:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=AjAUwe7gQC6OovnCABn3IqW7kQv2EygZ4w2Ir6t+bjk=;
 b=Kgxt2CFUdjS+flkA6ewiGttnPa0Exbu8+Ttl7bScgIwCqas7KIAt1T0QzCcTLplWtJW+
 3z7rH2cR/Wd24wwQ1uObtCHiJfuU4amjmKcPXPjgLpub/gWbRr+gswLeVcrEuW36QqIH
 4jE+iKkMpmLsP4CEPlP5WHVewVwhRmp7NsI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3np7ddw3eg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 12 Feb 2023 01:27:49 -0800
Received: from twshared19883.07.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Sun, 12 Feb 2023 01:27:48 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 2D63116CA5593; Sun, 12 Feb 2023 01:27:24 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v5 bpf-next 7/9] bpf: Add bpf_rbtree_{add,remove,first} decls to bpf_experimental.h
Date:   Sun, 12 Feb 2023 01:27:13 -0800
Message-ID: <20230212092715.1422619-8-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230212092715.1422619-1-davemarchevsky@fb.com>
References: <20230212092715.1422619-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: RXAg6ypVBJeAurDDp-j9dgDrVojNMDgG
X-Proofpoint-ORIG-GUID: RXAg6ypVBJeAurDDp-j9dgDrVojNMDgG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-11_15,2023-02-09_03,2023-02-09_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

