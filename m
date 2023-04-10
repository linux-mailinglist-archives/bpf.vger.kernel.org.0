Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974EE6DCB4F
	for <lists+bpf@lfdr.de>; Mon, 10 Apr 2023 21:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjDJTJE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Apr 2023 15:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjDJTJC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Apr 2023 15:09:02 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E501987
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 12:09:00 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33AFxjYu015775
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 12:08:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Csri1Ys8IS7DU1SDnWVtmf1cNwadM7BYj8fhxg76WUU=;
 b=LjwDi/rTINIxGNLvpJIjid0N98LHX5ujPTWw+GSdGbfPO8B/kWGubGSGCvWXoMgo5n5m
 oza3CBAgxMk1+A8zuXk4pd0XK+x0aL/NFQYgu8ISZaGs0jquSU+II+myupzMdxBVIDM7
 IVtv+3pkYTRWVEAIA8xDslttK+IEEpagC1Y= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pu4an31hx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 12:08:59 -0700
Received: from twshared21709.17.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 10 Apr 2023 12:08:58 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 2652A1BB3FCFF; Mon, 10 Apr 2023 12:08:45 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 8/9] bpf: Centralize btf_field-specific initialization logic
Date:   Mon, 10 Apr 2023 12:07:52 -0700
Message-ID: <20230410190753.2012798-9-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230410190753.2012798-1-davemarchevsky@fb.com>
References: <20230410190753.2012798-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ot3aBJLUFI34oF8_GIlq9tR-AwZzPokw
X-Proofpoint-GUID: ot3aBJLUFI34oF8_GIlq9tR-AwZzPokw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_14,2023-04-06_03,2023-02-09_01
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

All btf_fields in an object are 0-initialized by memset in
bpf_obj_init. This might not be a valid initial state for some field
types, in which case kfuncs that use the type will properly initialize
their input if it's been 0-initialized. Some BPF graph collection types
and kfuncs do this: bpf_list_{head,node} and bpf_rb_node.

An earlier patch in this series added the bpf_refcount field, for which
the 0 state indicates that the refcounted object should be free'd.
bpf_obj_init treats this field specially, setting refcount to 1 instead
of relying on scattered "refcount is 0? Must have just been initialized,
let's set to 1" logic in kfuncs.

This patch extends this treatment to list and rbtree field types,
allowing most scattered initialization logic in kfuncs to be removed.

Note that bpf_{list_head,rb_root} may be inside a BPF map, in which case
they'll be 0-initialized without passing through the newly-added logic,
so scattered initialization logic must remain for these collection root
types.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/bpf.h  | 38 ++++++++++++++++++++++++++++++++++----
 kernel/bpf/helpers.c | 17 +++++++----------
 2 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4fc29f9aeaac..8e69948c4adb 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -355,6 +355,39 @@ static inline u32 btf_field_type_align(enum btf_fiel=
d_type type)
 	}
 }
=20
+static inline void __bpf_obj_init_field(enum btf_field_type type, u32 si=
ze, void *addr)
+{
+	memset(addr, 0, size);
+
+	switch (type) {
+	case BPF_REFCOUNT:
+		refcount_set((refcount_t *)addr, 1);
+		break;
+	case BPF_RB_NODE:
+		RB_CLEAR_NODE((struct rb_node *)addr);
+		break;
+	case BPF_LIST_HEAD:
+	case BPF_LIST_NODE:
+		INIT_LIST_HEAD((struct list_head *)addr);
+		break;
+	case BPF_RB_ROOT:
+		/* RB_ROOT_CACHED 0-inits, no need to do anything after memset */
+	case BPF_SPIN_LOCK:
+	case BPF_TIMER:
+	case BPF_KPTR_UNREF:
+	case BPF_KPTR_REF:
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return;
+	}
+}
+
+static inline void bpf_obj_init_field(const struct btf_field *field, voi=
d *addr)
+{
+	__bpf_obj_init_field(field->type, field->size, addr);
+}
+
 static inline bool btf_record_has_field(const struct btf_record *rec, en=
um btf_field_type type)
 {
 	if (IS_ERR_OR_NULL(rec))
@@ -369,10 +402,7 @@ static inline void bpf_obj_init(const struct btf_rec=
ord *rec, void *obj)
 	if (IS_ERR_OR_NULL(rec))
 		return;
 	for (i =3D 0; i < rec->cnt; i++)
-		memset(obj + rec->fields[i].offset, 0, rec->fields[i].size);
-
-	if (rec->refcount_off >=3D 0)
-		refcount_set((refcount_t *)(obj + rec->refcount_off), 1);
+		bpf_obj_init_field(&rec->fields[i], obj + rec->fields[i].offset);
 }
=20
 /* 'dst' must be a temporary buffer and should not point to memory that =
is being
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6adbf99dc27f..1208fd8584c9 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1931,15 +1931,16 @@ __bpf_kfunc void *bpf_refcount_acquire_impl(void =
*p__refcounted_kptr, void *meta
 	return (void *)p__refcounted_kptr;
 }
=20
+#define __init_field_infer_size(field_type, addr)\
+	__bpf_obj_init_field(field_type, btf_field_type_size(field_type), addr)
+
 static int __bpf_list_add(struct bpf_list_node *node, struct bpf_list_he=
ad *head,
 			  bool tail, struct btf_record *rec, u64 off)
 {
 	struct list_head *n =3D (void *)node, *h =3D (void *)head;
=20
 	if (unlikely(!h->next))
-		INIT_LIST_HEAD(h);
-	if (unlikely(!n->next))
-		INIT_LIST_HEAD(n);
+		__init_field_infer_size(BPF_LIST_HEAD, h);
 	if (!list_empty(n)) {
 		/* Only called from BPF prog, no need to migrate_disable */
 		__bpf_obj_drop_impl(n - off, rec);
@@ -1976,7 +1977,7 @@ static struct bpf_list_node *__bpf_list_del(struct =
bpf_list_head *head, bool tai
 	struct list_head *n, *h =3D (void *)head;
=20
 	if (unlikely(!h->next))
-		INIT_LIST_HEAD(h);
+		__init_field_infer_size(BPF_LIST_HEAD, h);
 	if (list_empty(h))
 		return NULL;
 	n =3D tail ? h->prev : h->next;
@@ -1984,6 +1985,8 @@ static struct bpf_list_node *__bpf_list_del(struct =
bpf_list_head *head, bool tai
 	return (struct bpf_list_node *)n;
 }
=20
+#undef __init_field_infer_size
+
 __bpf_kfunc struct bpf_list_node *bpf_list_pop_front(struct bpf_list_hea=
d *head)
 {
 	return __bpf_list_del(head, false);
@@ -2000,9 +2003,6 @@ __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(s=
truct bpf_rb_root *root,
 	struct rb_root_cached *r =3D (struct rb_root_cached *)root;
 	struct rb_node *n =3D (struct rb_node *)node;
=20
-	if (!n->__rb_parent_color)
-		RB_CLEAR_NODE(n);
-
 	if (RB_EMPTY_NODE(n))
 		return NULL;
=20
@@ -2022,9 +2022,6 @@ static int __bpf_rbtree_add(struct bpf_rb_root *roo=
t, struct bpf_rb_node *node,
 	bpf_callback_t cb =3D (bpf_callback_t)less;
 	bool leftmost =3D true;
=20
-	if (!n->__rb_parent_color)
-		RB_CLEAR_NODE(n);
-
 	if (!RB_EMPTY_NODE(n)) {
 		/* Only called from BPF prog, no need to migrate_disable */
 		__bpf_obj_drop_impl(n - off, rec);
--=20
2.34.1

