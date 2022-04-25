Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DF150E874
	for <lists+bpf@lfdr.de>; Mon, 25 Apr 2022 20:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239134AbiDYSpC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Apr 2022 14:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235960AbiDYSpC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Apr 2022 14:45:02 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477BE4B417
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 11:41:57 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 23PHP562021833
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 11:41:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=bMrMsJtEPdS4/JSZXEwtntugbBKhPn22dzna5/ixqd0=;
 b=PRMujctFBfbpwqL4ZAOK7ziATxzt/7hzK1sD593obi9w6OOvLr1nEqnuadr5VMJec6xJ
 tWUPR6RKCg0TIPfiOCFXDjrT7IZkloYrIoCuWWsNSXWp2YfIfd4+Q78tgzDkQJdu5DoC
 NlCuyl1Q1HzpSm3MCEZPy/haUuBBLpuVmaw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3fmd4rmewu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 11:41:56 -0700
Received: from twshared10896.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 11:41:55 -0700
Received: by devvm4403.frc0.facebook.com (Postfix, from userid 153359)
        id 722E5628480B; Mon, 25 Apr 2022 11:41:52 -0700 (PDT)
From:   Takshak Chahande <ctakshak@fb.com>
To:     <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <ctakshak@fb.com>,
        <ndixit@fb.com>, <kafai@fb.com>, <andriin@fb.com>,
        <daniel@iogearbox.net>
Subject: [PATCH v3 bpf-next 1/2] bpf: Extend batch operations for map-in-map bpf-maps
Date:   Mon, 25 Apr 2022 11:41:48 -0700
Message-ID: <20220425184149.1173545-1-ctakshak@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: A1jOPuHhV4GJtpDxuNTB6rUmTgN1WeSu
X-Proofpoint-GUID: A1jOPuHhV4GJtpDxuNTB6rUmTgN1WeSu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_10,2022-04-25_03,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch extends batch operations support for map-in-map map-types:
BPF_MAP_TYPE_HASH_OF_MAPS and BPF_MAP_TYPE_ARRAY_OF_MAPS

A usecase where outer HASH map holds hundred of VIP entries and its
associated reuse-ports per VIP stored in REUSEPORT_SOCKARRAY type
inner map, needs to do batch operation for performance gain.

This patch leverages the exiting generic functions for most of the batch
operations. As map-in-map's value contains the actual reference of the in=
ner map,
for BPF_MAP_TYPE_HASH_OF_MAPS type, it needed an extra step to fetch the
map_id from the reference value.

selftests are added in next patch that has v1->v3 changes

Signed-off-by: Takshak Chahande <ctakshak@fb.com>
---
 kernel/bpf/arraymap.c |  2 ++
 kernel/bpf/hashtab.c  | 12 ++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 7f145aefbff8..f0852b6617cc 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -1344,6 +1344,8 @@ const struct bpf_map_ops array_of_maps_map_ops =3D =
{
 	.map_fd_put_ptr =3D bpf_map_fd_put_ptr,
 	.map_fd_sys_lookup_elem =3D bpf_map_fd_sys_lookup_elem,
 	.map_gen_lookup =3D array_of_map_gen_lookup,
+	.map_lookup_batch =3D generic_map_lookup_batch,
+	.map_update_batch =3D generic_map_update_batch,
 	.map_check_btf =3D map_check_no_btf,
 	.map_btf_name =3D "bpf_array",
 	.map_btf_id =3D &array_of_maps_map_btf_id,
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index c68fbebc8c00..fd537bfba84c 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -139,7 +139,7 @@ static inline bool htab_use_raw_lock(const struct bpf=
_htab *htab)
=20
 static void htab_init_buckets(struct bpf_htab *htab)
 {
-	unsigned i;
+	unsigned int i;
=20
 	for (i =3D 0; i < htab->n_buckets; i++) {
 		INIT_HLIST_NULLS_HEAD(&htab->buckets[i].head, i);
@@ -1594,7 +1594,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *=
map,
 	void __user *uvalues =3D u64_to_user_ptr(attr->batch.values);
 	void __user *ukeys =3D u64_to_user_ptr(attr->batch.keys);
 	void __user *ubatch =3D u64_to_user_ptr(attr->batch.in_batch);
-	u32 batch, max_count, size, bucket_size;
+	u32 batch, max_count, size, bucket_size, map_id;
 	struct htab_elem *node_to_free =3D NULL;
 	u64 elem_map_flags, map_flags;
 	struct hlist_nulls_head *head;
@@ -1719,6 +1719,13 @@ __htab_map_lookup_and_delete_batch(struct bpf_map =
*map,
 			}
 		} else {
 			value =3D l->key + roundup_key_size;
+			if (map->map_type =3D=3D BPF_MAP_TYPE_HASH_OF_MAPS) {
+				struct bpf_map **inner_map =3D value;
+				 /* Actual value is the id of the inner map */
+				map_id =3D map->ops->map_fd_sys_lookup_elem(*inner_map);
+				value =3D &map_id;
+			}
+
 			if (elem_map_flags & BPF_F_LOCK)
 				copy_map_value_locked(map, dst_val, value,
 						      true);
@@ -2425,6 +2432,7 @@ const struct bpf_map_ops htab_of_maps_map_ops =3D {
 	.map_fd_sys_lookup_elem =3D bpf_map_fd_sys_lookup_elem,
 	.map_gen_lookup =3D htab_of_map_gen_lookup,
 	.map_check_btf =3D map_check_no_btf,
+	BATCH_OPS(htab),
 	.map_btf_name =3D "bpf_htab",
 	.map_btf_id =3D &htab_of_maps_map_btf_id,
 };
--=20
2.30.2

