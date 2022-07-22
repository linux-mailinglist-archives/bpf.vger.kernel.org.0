Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F32457E695
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 20:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbiGVSfA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 14:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbiGVSe6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 14:34:58 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6866E9F046
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:34:57 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26MHojlG021276
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:34:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=M6+bsJAOH/HHolRF0OT3Ro2hADTYCMnHs8b1X75Oi/I=;
 b=RT0RypMVK5u7EcFBWJdwD9g/wDj6h5J5GST1RQUIBDZdtgy90dbcVfvh3rWgFF9xpDlL
 BBRbbrVePKWTtV1Ea3ZdGirOzrRBgpiVp9nRPDokz8XYwM1nIk1Omn7NeJhmC6GNj3zN
 P+R98fpo/Hy1h33WY/luX1AGAjyVGHiyS+Q= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3hg0n708ym-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:34:56 -0700
Received: from twshared6324.05.ash7.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 22 Jul 2022 11:34:53 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 00C5DAB6F19E; Fri, 22 Jul 2022 11:34:48 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [RFC PATCH bpf-next 05/11] bpf: Add bpf_spin_lock member to rbtree
Date:   Fri, 22 Jul 2022 11:34:32 -0700
Message-ID: <20220722183438.3319790-6-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220722183438.3319790-1-davemarchevsky@fb.com>
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ZJTQRiz7jNL5l7jbM8XuwWKOhNqOArMd
X-Proofpoint-GUID: ZJTQRiz7jNL5l7jbM8XuwWKOhNqOArMd
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

This patch adds a struct bpf_spin_lock *lock member to bpf_rbtree, as
well as a bpf_rbtree_get_lock helper which allows bpf programs to access
the lock.

Ideally the bpf_spin_lock would be created independently oustide of the
tree and associated with it before the tree is used, either as part of
map definition or via some call like rbtree_init(&rbtree, &lock). Doing
this in an ergonomic way is proving harder than expected, so for now use
this workaround.

Why is creating the bpf_spin_lock independently and associating it with
the tree preferable? Because we want to be able to transfer nodes
between trees atomically, and for this to work need same lock associated
with 2 trees.

Further locking-related patches will make it possible for the lock to be
used in BPF programs and add code which enforces that the lock is held
when doing any operation on the tree.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/uapi/linux/bpf.h       |  7 +++++++
 kernel/bpf/helpers.c           |  3 +++
 kernel/bpf/rbtree.c            | 24 ++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  7 +++++++
 4 files changed, 41 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 4688ce88caf4..c677d92de3bc 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5385,6 +5385,12 @@ union bpf_attr {
  *	Return
  *		0
  *
+ * void *bpf_rbtree_get_lock(struct bpf_map *map)
+ *	Description
+ *		Return the bpf_spin_lock associated with the rbtree
+ *
+ *	Return
+ *		Ptr to lock
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5600,6 +5606,7 @@ union bpf_attr {
 	FN(rbtree_find),		\
 	FN(rbtree_remove),		\
 	FN(rbtree_free_node),		\
+	FN(rbtree_get_lock),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 35eb66d11bf6..257a808bb767 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1587,6 +1587,7 @@ const struct bpf_func_proto bpf_rbtree_add_proto __=
weak;
 const struct bpf_func_proto bpf_rbtree_find_proto __weak;
 const struct bpf_func_proto bpf_rbtree_remove_proto __weak;
 const struct bpf_func_proto bpf_rbtree_free_node_proto __weak;
+const struct bpf_func_proto bpf_rbtree_get_lock_proto __weak;
=20
 const struct bpf_func_proto *
 bpf_base_func_proto(enum bpf_func_id func_id)
@@ -1686,6 +1687,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_rbtree_remove_proto;
 	case BPF_FUNC_rbtree_free_node:
 		return &bpf_rbtree_free_node_proto;
+	case BPF_FUNC_rbtree_get_lock:
+		return &bpf_rbtree_get_lock_proto;
 	default:
 		break;
 	}
diff --git a/kernel/bpf/rbtree.c b/kernel/bpf/rbtree.c
index 250d62210804..c6f0a2a083f6 100644
--- a/kernel/bpf/rbtree.c
+++ b/kernel/bpf/rbtree.c
@@ -9,6 +9,7 @@
 struct bpf_rbtree {
 	struct bpf_map map;
 	struct rb_root_cached root;
+	struct bpf_spin_lock *lock;
 };
=20
 BTF_ID_LIST_SINGLE(bpf_rbtree_btf_ids, struct, rb_node);
@@ -39,6 +40,14 @@ static struct bpf_map *rbtree_map_alloc(union bpf_attr=
 *attr)
=20
 	tree->root =3D RB_ROOT_CACHED;
 	bpf_map_init_from_attr(&tree->map, attr);
+
+	tree->lock =3D bpf_map_kzalloc(&tree->map, sizeof(struct bpf_spin_lock)=
,
+				     GFP_KERNEL | __GFP_NOWARN);
+	if (!tree->lock) {
+		bpf_map_area_free(tree);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	return &tree->map;
 }
=20
@@ -139,6 +148,7 @@ static void rbtree_map_free(struct bpf_map *map)
=20
 	bpf_rbtree_postorder_for_each_entry_safe(pos, n, &tree->root.rb_root)
 		kfree(pos);
+	kfree(tree->lock);
 	bpf_map_area_free(tree);
 }
=20
@@ -238,6 +248,20 @@ static int rbtree_map_get_next_key(struct bpf_map *m=
ap, void *key,
 	return -ENOTSUPP;
 }
=20
+BPF_CALL_1(bpf_rbtree_get_lock, struct bpf_map *, map)
+{
+	struct bpf_rbtree *tree =3D container_of(map, struct bpf_rbtree, map);
+
+	return (u64)tree->lock;
+}
+
+const struct bpf_func_proto bpf_rbtree_get_lock_proto =3D {
+	.func =3D bpf_rbtree_get_lock,
+	.gpl_only =3D true,
+	.ret_type =3D RET_PTR_TO_MAP_VALUE,
+	.arg1_type =3D ARG_CONST_MAP_PTR,
+};
+
 BTF_ID_LIST_SINGLE(bpf_rbtree_map_btf_ids, struct, bpf_rbtree)
 const struct bpf_map_ops rbtree_map_ops =3D {
 	.map_meta_equal =3D bpf_map_meta_equal,
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 4688ce88caf4..c677d92de3bc 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5385,6 +5385,12 @@ union bpf_attr {
  *	Return
  *		0
  *
+ * void *bpf_rbtree_get_lock(struct bpf_map *map)
+ *	Description
+ *		Return the bpf_spin_lock associated with the rbtree
+ *
+ *	Return
+ *		Ptr to lock
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5600,6 +5606,7 @@ union bpf_attr {
 	FN(rbtree_find),		\
 	FN(rbtree_remove),		\
 	FN(rbtree_free_node),		\
+	FN(rbtree_get_lock),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
--=20
2.30.2

