Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBA85A6B7B
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 19:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiH3R67 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 13:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbiH3R6m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 13:58:42 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FD213F23
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:57:39 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UG282E009482
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:31:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=YdWUK1qM5R14Nw6HCmmY+/qSJX79IZx3jRfdpH798jU=;
 b=gzpVcEBBPNErZgbWCqWc+3GVtPXfInhsTZJLYnLpTZd1ou4EMN6JqWJxUWKTJvUiC4v5
 gWirXzBRJXIxSipxpMHhZHeYMFtpU0k9IEmeeknRFmeQIDPti1Jix8Op8BRlQfvYYtOe
 c+z9PN+dyYmVtlo5qIY8xD8xbtH3wfJeH2M= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j94gye2d7-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:31:25 -0700
Received: from twshared10711.09.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 10:31:19 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 34646CAD077A; Tue, 30 Aug 2022 10:28:09 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [RFCv2 PATCH bpf-next 08/18] bpf: Enforce spinlock hold for bpf_rbtree_{add,remove,find}
Date:   Tue, 30 Aug 2022 10:27:49 -0700
Message-ID: <20220830172759.4069786-9-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220830172759.4069786-1-davemarchevsky@fb.com>
References: <20220830172759.4069786-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: CNSOtJr5Dv2JQ9OeBpisxVUNAyb9MAxs
X-Proofpoint-GUID: CNSOtJr5Dv2JQ9OeBpisxVUNAyb9MAxs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_10,2022-08-30_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpf program calling these helpers must hold the spinlock associated
with the rbtree map when doing so. Otherwise, a concurrent add/remove
operation could corrupt the tree while {add,remove,find} are walking it
with callback or pivoting after update.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/rbtree.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/bpf/rbtree.c b/kernel/bpf/rbtree.c
index 641821ee1a7f..85a1d35818d0 100644
--- a/kernel/bpf/rbtree.c
+++ b/kernel/bpf/rbtree.c
@@ -13,6 +13,11 @@ struct bpf_rbtree {
 	struct bpf_spin_lock *lock;
 };
=20
+static bool __rbtree_lock_held(struct bpf_rbtree *tree)
+{
+	return spin_is_locked((spinlock_t *)tree->lock);
+}
+
 static int rbtree_map_alloc_check(union bpf_attr *attr)
 {
 	if (attr->max_entries || !attr->btf_value_type_id)
@@ -92,6 +97,9 @@ BPF_CALL_3(bpf_rbtree_add, struct bpf_map *, map, void =
*, value, void *, cb)
 	struct bpf_rbtree *tree =3D container_of(map, struct bpf_rbtree, map);
 	struct rb_node *node =3D (struct rb_node *)value;
=20
+	if (!__rbtree_lock_held(tree))
+		return (u64)NULL;
+
 	if (WARN_ON_ONCE(!RB_EMPTY_NODE(node)))
 		return (u64)NULL;
=20
@@ -114,6 +122,9 @@ BPF_CALL_3(bpf_rbtree_find, struct bpf_map *, map, vo=
id *, key, void *, cb)
 {
 	struct bpf_rbtree *tree =3D container_of(map, struct bpf_rbtree, map);
=20
+	if (!__rbtree_lock_held(tree))
+		return (u64)NULL;
+
 	return (u64)rb_find(key, &tree->root.rb_root,
 			    (int (*)(const void *key,
 				     const struct rb_node *))cb);
@@ -206,6 +217,9 @@ BPF_CALL_2(bpf_rbtree_remove, struct bpf_map *, map, =
void *, value)
 	struct bpf_rbtree *tree =3D container_of(map, struct bpf_rbtree, map);
 	struct rb_node *node =3D (struct rb_node *)value;
=20
+	if (!__rbtree_lock_held(tree))
+		return (u64)NULL;
+
 	if (WARN_ON_ONCE(RB_EMPTY_NODE(node)))
 		return (u64)NULL;
=20
--=20
2.30.2

