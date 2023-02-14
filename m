Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2940869708E
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 23:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbjBNWRh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 17:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjBNWRg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 17:17:36 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C932ED77
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 14:17:35 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 31EGtgCq004649
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 14:17:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=sj9f+SXWzAXLllu1GWIjrfI0jdCLL9D3rbE1IjKNFRY=;
 b=MunMM5GVxezzKzrHAIzejbbLqyRdFqXFS1yg1TqkmRhWHb2WnipRoh7GXMRjjQTJzdeU
 frIVRxRgcAiVXEeI0FWly4vuW2vFL2d3Uy9qt0ijuHTIEXHP+6eWFhISvmQap2PjI1/K
 tELxgoTU/g6QLe6hsa+lnPc0zF7ofWFBeqzB3PWcxMbbPPOMezI1oGPmk8RMPGUTQ+CF
 j8Yn7He9syIYXrmpyjPdT0i60xAcyqCyjo1e0ixgxZ3W9XRGO73A+1N1sS+fCOshVn41
 5zN/o6pz8qtZ2jK+IzMVbZ2+qLe4x0s/OcvZ0j08AuOxS0uJKYGh2J/gAqx5UZpmKQAC +A== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3nr5ahnsq8-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 14:17:34 -0800
Received: from twshared26225.38.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 14 Feb 2023 14:17:32 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id E51265143085; Tue, 14 Feb 2023 14:17:20 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>, <andrii@kernel.org>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next 3/7] bpf: Register and unregister a struct_ops by their bpf_links.
Date:   Tue, 14 Feb 2023 14:17:14 -0800
Message-ID: <20230214221718.503964-4-kuifeng@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230214221718.503964-1-kuifeng@meta.com>
References: <20230214221718.503964-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: E2t57iRES2MLbTeZUdg--PAMOORMCTP2
X-Proofpoint-GUID: E2t57iRES2MLbTeZUdg--PAMOORMCTP2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_15,2023-02-14_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Registration via bpf_links ensures a uniform behavior, just like other
BPF programs.  BPF struct_ops were registered/unregistered when
updating/deleting their values.  Only the maps of struct_ops having
the BPF_F_LINK flag are allowed to back a bpf_link.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 include/uapi/linux/bpf.h       |  3 ++
 kernel/bpf/bpf_struct_ops.c    | 59 +++++++++++++++++++++++++++++++---
 tools/include/uapi/linux/bpf.h |  3 ++
 3 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 1e6cdd0f355d..48d8b3058aa1 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1267,6 +1267,9 @@ enum {
=20
 /* Create a map that is suitable to be an inner map with dynamic max ent=
ries */
 	BPF_F_INNER_MAP		=3D (1U << 12),
+
+/* Create a map that will be registered/unregesitered by the backed bpf_=
link */
+	BPF_F_LINK		=3D (1U << 13),
 };
=20
 /* Flags for BPF_PROG_QUERY. */
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 621c8e24481a..d16ca06cf09a 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -390,7 +390,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_=
map *map, void *key,
=20
 	mutex_lock(&st_map->lock);
=20
-	if (kvalue->state !=3D BPF_STRUCT_OPS_STATE_INIT) {
+	if (kvalue->state !=3D BPF_STRUCT_OPS_STATE_INIT || refcount_read(&kval=
ue->refcnt)) {
 		err =3D -EBUSY;
 		goto unlock;
 	}
@@ -491,6 +491,12 @@ static int bpf_struct_ops_map_update_elem(struct bpf=
_map *map, void *key,
 		*(unsigned long *)(udata + moff) =3D prog->aux->id;
 	}
=20
+	if (st_map->map.map_flags & BPF_F_LINK) {
+		/* Let bpf_link handle registration & unregistration. */
+		smp_store_release(&kvalue->state, BPF_STRUCT_OPS_STATE_INUSE);
+		goto unlock;
+	}
+
 	refcount_set(&kvalue->refcnt, 1);
 	bpf_map_inc(map);
=20
@@ -522,6 +528,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_=
map *map, void *key,
 	kfree(tlinks);
 	mutex_unlock(&st_map->lock);
 	return err;
+
 }
=20
 static int bpf_struct_ops_map_delete_elem(struct bpf_map *map, void *key=
)
@@ -535,6 +542,8 @@ static int bpf_struct_ops_map_delete_elem(struct bpf_=
map *map, void *key)
 			     BPF_STRUCT_OPS_STATE_TOBEFREE);
 	switch (prev_state) {
 	case BPF_STRUCT_OPS_STATE_INUSE:
+		if (st_map->map.map_flags & BPF_F_LINK)
+			return 0;
 		st_map->st_ops->unreg(&st_map->kvalue.data);
 		if (refcount_dec_and_test(&st_map->kvalue.refcnt))
 			bpf_map_put(map);
@@ -585,7 +594,7 @@ static void bpf_struct_ops_map_free(struct bpf_map *m=
ap)
 static int bpf_struct_ops_map_alloc_check(union bpf_attr *attr)
 {
 	if (attr->key_size !=3D sizeof(unsigned int) || attr->max_entries !=3D =
1 ||
-	    attr->map_flags || !attr->btf_vmlinux_value_type_id)
+	    (attr->map_flags & ~BPF_F_LINK) || !attr->btf_vmlinux_value_type_id=
)
 		return -EINVAL;
 	return 0;
 }
@@ -638,6 +647,8 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union=
 bpf_attr *attr)
 	set_vm_flush_reset_perms(st_map->image);
 	bpf_map_init_from_attr(map, attr);
=20
+	map->map_flags |=3D attr->map_flags & BPF_F_LINK;
+
 	return map;
 }
=20
@@ -699,10 +710,25 @@ void bpf_struct_ops_put(const void *kdata)
 	}
 }
=20
+static void bpf_struct_ops_kvalue_put(struct bpf_struct_ops_value *kvalu=
e)
+{
+	struct bpf_struct_ops_map *st_map;
+
+	if (refcount_dec_and_test(&kvalue->refcnt)) {
+		st_map =3D container_of(kvalue, struct bpf_struct_ops_map,
+				      kvalue);
+		bpf_map_put(&st_map->map);
+	}
+}
+
 static void bpf_struct_ops_map_link_release(struct bpf_link *link)
 {
+	struct bpf_struct_ops_map *st_map;
+
 	if (link->map) {
-		bpf_map_put(link->map);
+		st_map =3D (struct bpf_struct_ops_map *)link->map;
+		st_map->st_ops->unreg(&st_map->kvalue.data);
+		bpf_struct_ops_kvalue_put(&st_map->kvalue);
 		link->map =3D NULL;
 	}
 }
@@ -735,13 +761,15 @@ static const struct bpf_link_ops bpf_struct_ops_map=
_lops =3D {
=20
 int link_create_struct_ops_map(union bpf_attr *attr, bpfptr_t uattr)
 {
+	struct bpf_struct_ops_map *st_map;
 	struct bpf_link_primer link_primer;
+	struct bpf_struct_ops_value *kvalue;
 	struct bpf_map *map;
 	struct bpf_link *link =3D NULL;
 	int err;
=20
 	map =3D bpf_map_get(attr->link_create.prog_fd);
-	if (map->map_type !=3D BPF_MAP_TYPE_STRUCT_OPS)
+	if (map->map_type !=3D BPF_MAP_TYPE_STRUCT_OPS || !(map->map_flags & BP=
F_F_LINK))
 		return -EINVAL;
=20
 	link =3D kzalloc(sizeof(*link), GFP_USER);
@@ -752,6 +780,29 @@ int link_create_struct_ops_map(union bpf_attr *attr,=
 bpfptr_t uattr)
 	bpf_link_init(link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_map_lops,=
 NULL);
 	link->map =3D map;
=20
+	if (map->map_flags & BPF_F_LINK) {
+		st_map =3D (struct bpf_struct_ops_map *)map;
+		kvalue =3D (struct bpf_struct_ops_value *)&st_map->kvalue;
+
+		if (kvalue->state !=3D BPF_STRUCT_OPS_STATE_INUSE ||
+		    refcount_read(&kvalue->refcnt) !=3D 0) {
+			err =3D -EINVAL;
+			goto err_out;
+		}
+
+		refcount_set(&kvalue->refcnt, 1);
+
+		set_memory_rox((long)st_map->image, 1);
+		err =3D st_map->st_ops->reg(kvalue->data);
+		if (err) {
+			refcount_set(&kvalue->refcnt, 0);
+
+			set_memory_nx((long)st_map->image, 1);
+			set_memory_rw((long)st_map->image, 1);
+			goto err_out;
+		}
+	}
+
 	err =3D bpf_link_prime(link, &link_primer);
 	if (err)
 		goto err_out;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 1e6cdd0f355d..48d8b3058aa1 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1267,6 +1267,9 @@ enum {
=20
 /* Create a map that is suitable to be an inner map with dynamic max ent=
ries */
 	BPF_F_INNER_MAP		=3D (1U << 12),
+
+/* Create a map that will be registered/unregesitered by the backed bpf_=
link */
+	BPF_F_LINK		=3D (1U << 13),
 };
=20
 /* Flags for BPF_PROG_QUERY. */
--=20
2.30.2

