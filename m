Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652166E337B
	for <lists+bpf@lfdr.de>; Sat, 15 Apr 2023 22:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjDOUSi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 Apr 2023 16:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjDOUSh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Apr 2023 16:18:37 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D2235AA
        for <bpf@vger.kernel.org>; Sat, 15 Apr 2023 13:18:35 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33F9bojp020336
        for <bpf@vger.kernel.org>; Sat, 15 Apr 2023 13:18:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=A1HKyixk8f50A9hjo6cJgBr35R27g0txZFcSj+7UOaY=;
 b=B5hA5ucPoniR2lMyeyJFHMVzMXyz6E3JYzsnkiHIipoVSNTHn62qfABRi0Cr0MC3CoKO
 lEDpg9/vvheF/43i7/pujphQs0zQTwQ1FiTjSa4VB0pivA5URm8+CT/EC2DbUz/ZF1DU
 rMeVS+/bNuKZhS+Q+yFfTgicfESqIDaxrPE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pysf21rur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 15 Apr 2023 13:18:34 -0700
Received: from twshared17808.08.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Sat, 15 Apr 2023 13:18:33 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id D509F1C2702F6; Sat, 15 Apr 2023 13:18:19 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 8/9] bpf: Centralize btf_field-specific initialization logic
Date:   Sat, 15 Apr 2023 13:18:10 -0700
Message-ID: <20230415201811.343116-9-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230415201811.343116-1-davemarchevsky@fb.com>
References: <20230415201811.343116-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: kzXJ1nWMK74MwT5G7rg7ehwtpfAcG1sV
X-Proofpoint-GUID: kzXJ1nWMK74MwT5G7rg7ehwtpfAcG1sV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-15_10,2023-04-14_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 include/linux/bpf.h  | 33 +++++++++++++++++++++++++++++----
 kernel/bpf/helpers.c | 14 ++++++--------
 2 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b065de2cfcea..18b592fde896 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -355,6 +355,34 @@ static inline u32 btf_field_type_align(enum btf_fiel=
d_type type)
 	}
 }
=20
+static inline void bpf_obj_init_field(const struct btf_field *field, voi=
d *addr)
+{
+	memset(addr, 0, field->size);
+
+	switch (field->type) {
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
 static inline bool btf_record_has_field(const struct btf_record *rec, en=
um btf_field_type type)
 {
 	if (IS_ERR_OR_NULL(rec))
@@ -369,10 +397,7 @@ static inline void bpf_obj_init(const struct btf_rec=
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
index 1835df333287..00e5fb0682ac 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1936,10 +1936,11 @@ static int __bpf_list_add(struct bpf_list_node *n=
ode, struct bpf_list_head *head
 {
 	struct list_head *n =3D (void *)node, *h =3D (void *)head;
=20
+	/* If list_head was 0-initialized by map, bpf_obj_init_field wasn't
+	 * called on its fields, so init here
+	 */
 	if (unlikely(!h->next))
 		INIT_LIST_HEAD(h);
-	if (unlikely(!n->next))
-		INIT_LIST_HEAD(n);
 	if (!list_empty(n)) {
 		/* Only called from BPF prog, no need to migrate_disable */
 		__bpf_obj_drop_impl(n - off, rec);
@@ -1975,6 +1976,9 @@ static struct bpf_list_node *__bpf_list_del(struct =
bpf_list_head *head, bool tai
 {
 	struct list_head *n, *h =3D (void *)head;
=20
+	/* If list_head was 0-initialized by map, bpf_obj_init_field wasn't
+	 * called on its fields, so init here
+	 */
 	if (unlikely(!h->next))
 		INIT_LIST_HEAD(h);
 	if (list_empty(h))
@@ -2000,9 +2004,6 @@ __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(s=
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
@@ -2022,9 +2023,6 @@ static int __bpf_rbtree_add(struct bpf_rb_root *roo=
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

