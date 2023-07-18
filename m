Return-Path: <bpf+bounces-5160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5A27576C6
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 10:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B1928154E
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 08:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA08C2E2;
	Tue, 18 Jul 2023 08:38:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49699C2C2
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 08:38:33 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA8D115
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 01:38:31 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36I1BTVL009464
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 01:38:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=xd8IW+qBYGIBX1RzaqssYpZL+Tr2KbVc0nDA7Yk0Eak=;
 b=A4RVs/L69D3wMopYzgHKIaJwkJ5v1mMUGPRPh/QY2hTOWjMBzs7paaGFMFY5S0ZD6wCx
 xfCiIN0kf88446H2USYi6TkM/6ldFVrYJvcW6K9CQ8Ov7gr5NlUR58lMrTOpHFd9p4ub
 cTUQjvacckOvuvu2SbsTgbNHcuit4FoY1kg= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rwgumtdbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 01:38:31 -0700
Received: from twshared24695.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 01:38:30 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id B16F4214366B2; Tue, 18 Jul 2023 01:38:20 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky
	<davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 2/6] bpf: Introduce internal definitions for UAPI-opaque bpf_{rb,list}_node
Date: Tue, 18 Jul 2023 01:38:09 -0700
Message-ID: <20230718083813.3416104-3-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230718083813.3416104-1-davemarchevsky@fb.com>
References: <20230718083813.3416104-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 6pVlYmKxOfcS5hxl83lvLEYTZrZ3DHnN
X-Proofpoint-ORIG-GUID: 6pVlYmKxOfcS5hxl83lvLEYTZrZ3DHnN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Structs bpf_rb_node and bpf_list_node are opaquely defined in
uapi/linux/bpf.h, as BPF program writers are not expected to touch their
fields - nor does the verifier allow them to do so.

Currently these structs are simple wrappers around structs rb_node and
list_head and linked_list / rbtree implementation just casts and passes
to library functions for those data structures. Later patches in this
series, though, will add an "owner" field to bpf_{rb,list}_node, such
that they're not just wrapping an underlying node type. Moreover, the
bpf linked_list and rbtree implementations will deal with these owner
pointers directly in a few different places.

To avoid having to do

  void *owner =3D (void*)bpf_list_node + sizeof(struct list_head)

with opaque UAPI node types, add bpf_{list,rb}_node_kern struct
definitions to internal headers and modify linked_list and rbtree to use
the internal types where appropriate.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/bpf.h  | 10 ++++++++++
 kernel/bpf/helpers.c | 23 +++++++++++++----------
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 360433f14496..511ed49c3fe9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -228,6 +228,16 @@ struct btf_record {
 	struct btf_field fields[];
 };
=20
+/* Non-opaque version of bpf_rb_node in uapi/linux/bpf.h */
+struct bpf_rb_node_kern {
+	struct rb_node rb_node;
+} __attribute__((aligned(8)));
+
+/* Non-opaque version of bpf_list_node in uapi/linux/bpf.h */
+struct bpf_list_node_kern {
+	struct list_head list_head;
+} __attribute__((aligned(8)));
+
 struct bpf_map {
 	/* The first two cachelines with read-mostly members of which some
 	 * are also accessed in fast-path (e.g. ops, max_entries).
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9e80efa59a5d..d564ff97de0b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1942,10 +1942,11 @@ __bpf_kfunc void *bpf_refcount_acquire_impl(void =
*p__refcounted_kptr, void *meta
 	return (void *)p__refcounted_kptr;
 }
=20
-static int __bpf_list_add(struct bpf_list_node *node, struct bpf_list_he=
ad *head,
+static int __bpf_list_add(struct bpf_list_node_kern *node,
+			  struct bpf_list_head *head,
 			  bool tail, struct btf_record *rec, u64 off)
 {
-	struct list_head *n =3D (void *)node, *h =3D (void *)head;
+	struct list_head *n =3D &node->list_head, *h =3D (void *)head;
=20
 	/* If list_head was 0-initialized by map, bpf_obj_init_field wasn't
 	 * called on its fields, so init here
@@ -1967,20 +1968,20 @@ __bpf_kfunc int bpf_list_push_front_impl(struct b=
pf_list_head *head,
 					 struct bpf_list_node *node,
 					 void *meta__ign, u64 off)
 {
+	struct bpf_list_node_kern *n =3D (void *)node;
 	struct btf_struct_meta *meta =3D meta__ign;
=20
-	return __bpf_list_add(node, head, false,
-			      meta ? meta->record : NULL, off);
+	return __bpf_list_add(n, head, false, meta ? meta->record : NULL, off);
 }
=20
 __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
 					struct bpf_list_node *node,
 					void *meta__ign, u64 off)
 {
+	struct bpf_list_node_kern *n =3D (void *)node;
 	struct btf_struct_meta *meta =3D meta__ign;
=20
-	return __bpf_list_add(node, head, true,
-			      meta ? meta->record : NULL, off);
+	return __bpf_list_add(n, head, true, meta ? meta->record : NULL, off);
 }
=20
 static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head, =
bool tail)
@@ -2013,7 +2014,7 @@ __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(s=
truct bpf_rb_root *root,
 						  struct bpf_rb_node *node)
 {
 	struct rb_root_cached *r =3D (struct rb_root_cached *)root;
-	struct rb_node *n =3D (struct rb_node *)node;
+	struct rb_node *n =3D &((struct bpf_rb_node_kern *)node)->rb_node;
=20
 	if (RB_EMPTY_NODE(n))
 		return NULL;
@@ -2026,11 +2027,12 @@ __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove=
(struct bpf_rb_root *root,
 /* Need to copy rbtree_add_cached's logic here because our 'less' is a B=
PF
  * program
  */
-static int __bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node=
 *node,
+static int __bpf_rbtree_add(struct bpf_rb_root *root,
+			    struct bpf_rb_node_kern *node,
 			    void *less, struct btf_record *rec, u64 off)
 {
 	struct rb_node **link =3D &((struct rb_root_cached *)root)->rb_root.rb_=
node;
-	struct rb_node *parent =3D NULL, *n =3D (struct rb_node *)node;
+	struct rb_node *parent =3D NULL, *n =3D &node->rb_node;
 	bpf_callback_t cb =3D (bpf_callback_t)less;
 	bool leftmost =3D true;
=20
@@ -2060,8 +2062,9 @@ __bpf_kfunc int bpf_rbtree_add_impl(struct bpf_rb_r=
oot *root, struct bpf_rb_node
 				    void *meta__ign, u64 off)
 {
 	struct btf_struct_meta *meta =3D meta__ign;
+	struct bpf_rb_node_kern *n =3D (void *)node;
=20
-	return __bpf_rbtree_add(root, node, (void *)less, meta ? meta->record :=
 NULL, off);
+	return __bpf_rbtree_add(root, n, (void *)less, meta ? meta->record : NU=
LL, off);
 }
=20
 __bpf_kfunc struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *roo=
t)
--=20
2.34.1


