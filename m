Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C5257E697
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 20:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbiGVSfE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 14:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbiGVSfD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 14:35:03 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924409FE28
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:35:02 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MC5lv5009346
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:35:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=El6VgYnyfGvGeh+dXySVuzhUz+VLV/enjODNirwpF9o=;
 b=S0S//wXvt3CDLh/8usnfVlm0gr4kyTDyvhv/MejExuljYQmMK7oq2dXROQiTAWdwFL61
 M9/z2Wk0qbkKybqB5kSDpWHrTI1SMDvD6eAwK1SCN6sXOUfzPQCluT2G3Rps9a3w2loI
 azg3gEfnsExYcELsWrQyPWDyxpDWfHf5Stw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hej1w09cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:35:01 -0700
Received: from twshared10560.18.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 22 Jul 2022 11:35:00 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 2F95BAB6F1A3; Fri, 22 Jul 2022 11:34:50 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [RFC PATCH bpf-next 07/11] bpf: Enforce spinlock hold for bpf_rbtree_{add,remove,find}
Date:   Fri, 22 Jul 2022 11:34:34 -0700
Message-ID: <20220722183438.3319790-8-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220722183438.3319790-1-davemarchevsky@fb.com>
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: jODMBEAaQGOE6mjf3Np9aqlP5c5WjPym
X-Proofpoint-ORIG-GUID: jODMBEAaQGOE6mjf3Np9aqlP5c5WjPym
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
index bf2e30af82ec..5b1ab73e164f 100644
--- a/kernel/bpf/rbtree.c
+++ b/kernel/bpf/rbtree.c
@@ -14,6 +14,11 @@ struct bpf_rbtree {
=20
 BTF_ID_LIST_SINGLE(bpf_rbtree_btf_ids, struct, rb_node);
=20
+static bool __rbtree_lock_held(struct bpf_rbtree *tree)
+{
+	return spin_is_locked((spinlock_t *)tree->lock);
+}
+
 static int rbtree_map_alloc_check(union bpf_attr *attr)
 {
 	if (attr->max_entries || !attr->btf_value_type_id)
@@ -93,6 +98,9 @@ BPF_CALL_3(bpf_rbtree_add, struct bpf_map *, map, void =
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

