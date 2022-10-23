Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644BB60954C
	for <lists+bpf@lfdr.de>; Sun, 23 Oct 2022 20:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiJWSFj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Oct 2022 14:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiJWSFh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Oct 2022 14:05:37 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8623F4CA31
        for <bpf@vger.kernel.org>; Sun, 23 Oct 2022 11:05:32 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29NCWobU021798
        for <bpf@vger.kernel.org>; Sun, 23 Oct 2022 11:05:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=XgWlrxGwDBHF1qS9agPh713SLcOfeSYgUjOnLboi3UY=;
 b=GotQN/2P/GUxGbOvNNQ8IHLa4db3R5Xio2IhF1iShXbXhnk0OfIttEuj8Pxjwp+ns53V
 2Zjrtz5/0FFRIhf9HYgpOSnCQ4W7Eq4Jm0txEU7YoTHdvP13l+MqKUMqJ632gAegyesx
 mbwbDSdPWRCiIFs6zPwPgw1lthuOfKuerk8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kcebx2835-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 23 Oct 2022 11:05:31 -0700
Received: from twshared16963.27.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 23 Oct 2022 11:05:30 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 005F41115971F; Sun, 23 Oct 2022 11:05:24 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v4 2/7] bpf: Refactor inode/task/sk storage map_{alloc,free}() for reuse
Date:   Sun, 23 Oct 2022 11:05:24 -0700
Message-ID: <20221023180524.2859994-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221023180514.2857498-1-yhs@fb.com>
References: <20221023180514.2857498-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: gtknxCf3DHbYORPvfFXkFU83H4AvJyln
X-Proofpoint-ORIG-GUID: gtknxCf3DHbYORPvfFXkFU83H4AvJyln
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Refactor codes so that inode/task/sk storage map_{alloc,free}
can maximally share the same code. There is no functionality change.

Acked-by: David Vernet <void@manifault.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf_local_storage.h | 11 ++++-----
 kernel/bpf/bpf_inode_storage.c    | 15 ++----------
 kernel/bpf/bpf_local_storage.c    | 39 +++++++++++++++++++++++++------
 kernel/bpf/bpf_task_storage.c     | 15 ++----------
 net/core/bpf_sk_storage.c         | 15 ++----------
 5 files changed, 43 insertions(+), 52 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_=
storage.h
index 7ea18d4da84b..fdf753125778 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -116,21 +116,20 @@ static struct bpf_local_storage_cache name =3D {			=
\
 	.idx_lock =3D __SPIN_LOCK_UNLOCKED(name.idx_lock),	\
 }
=20
-u16 bpf_local_storage_cache_idx_get(struct bpf_local_storage_cache *cach=
e);
-void bpf_local_storage_cache_idx_free(struct bpf_local_storage_cache *ca=
che,
-				      u16 idx);
-
 /* Helper functions for bpf_local_storage */
 int bpf_local_storage_map_alloc_check(union bpf_attr *attr);
=20
-struct bpf_local_storage_map *bpf_local_storage_map_alloc(union bpf_attr=
 *attr);
+struct bpf_map *
+bpf_local_storage_map_alloc(union bpf_attr *attr,
+			    struct bpf_local_storage_cache *cache);
=20
 struct bpf_local_storage_data *
 bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
 			 struct bpf_local_storage_map *smap,
 			 bool cacheit_lockit);
=20
-void bpf_local_storage_map_free(struct bpf_local_storage_map *smap,
+void bpf_local_storage_map_free(struct bpf_map *map,
+				struct bpf_local_storage_cache *cache,
 				int __percpu *busy_counter);
=20
 int bpf_local_storage_map_check_btf(const struct bpf_map *map,
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storag=
e.c
index 5f7683b19199..34c315746d61 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -226,23 +226,12 @@ static int notsupp_get_next_key(struct bpf_map *map=
, void *key,
=20
 static struct bpf_map *inode_storage_map_alloc(union bpf_attr *attr)
 {
-	struct bpf_local_storage_map *smap;
-
-	smap =3D bpf_local_storage_map_alloc(attr);
-	if (IS_ERR(smap))
-		return ERR_CAST(smap);
-
-	smap->cache_idx =3D bpf_local_storage_cache_idx_get(&inode_cache);
-	return &smap->map;
+	return bpf_local_storage_map_alloc(attr, &inode_cache);
 }
=20
 static void inode_storage_map_free(struct bpf_map *map)
 {
-	struct bpf_local_storage_map *smap;
-
-	smap =3D (struct bpf_local_storage_map *)map;
-	bpf_local_storage_cache_idx_free(&inode_cache, smap->cache_idx);
-	bpf_local_storage_map_free(smap, NULL);
+	bpf_local_storage_map_free(map, &inode_cache, NULL);
 }
=20
 BTF_ID_LIST_SINGLE(inode_storage_map_btf_ids, struct,
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storag=
e.c
index 9dc6de1cf185..f89b6d080e1f 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -346,7 +346,7 @@ int bpf_local_storage_alloc(void *owner,
 		/* Note that even first_selem was linked to smap's
 		 * bucket->list, first_selem can be freed immediately
 		 * (instead of kfree_rcu) because
-		 * bpf_local_storage_map_free() does a
+		 * __bpf_local_storage_map_free() does a
 		 * synchronize_rcu_mult (waiting for both sleepable and
 		 * normal programs) before walking the bucket->list.
 		 * Hence, no one is accessing selem from the
@@ -500,7 +500,7 @@ bpf_local_storage_update(void *owner, struct bpf_loca=
l_storage_map *smap,
 	return ERR_PTR(err);
 }
=20
-u16 bpf_local_storage_cache_idx_get(struct bpf_local_storage_cache *cach=
e)
+static u16 bpf_local_storage_cache_idx_get(struct bpf_local_storage_cach=
e *cache)
 {
 	u64 min_usage =3D U64_MAX;
 	u16 i, res =3D 0;
@@ -524,16 +524,16 @@ u16 bpf_local_storage_cache_idx_get(struct bpf_loca=
l_storage_cache *cache)
 	return res;
 }
=20
-void bpf_local_storage_cache_idx_free(struct bpf_local_storage_cache *ca=
che,
-				      u16 idx)
+static void bpf_local_storage_cache_idx_free(struct bpf_local_storage_ca=
che *cache,
+					     u16 idx)
 {
 	spin_lock(&cache->idx_lock);
 	cache->idx_usage_counts[idx]--;
 	spin_unlock(&cache->idx_lock);
 }
=20
-void bpf_local_storage_map_free(struct bpf_local_storage_map *smap,
-				int __percpu *busy_counter)
+static void __bpf_local_storage_map_free(struct bpf_local_storage_map *s=
map,
+					 int __percpu *busy_counter)
 {
 	struct bpf_local_storage_elem *selem;
 	struct bpf_local_storage_map_bucket *b;
@@ -613,7 +613,7 @@ int bpf_local_storage_map_alloc_check(union bpf_attr =
*attr)
 	return 0;
 }
=20
-struct bpf_local_storage_map *bpf_local_storage_map_alloc(union bpf_attr=
 *attr)
+static struct bpf_local_storage_map *__bpf_local_storage_map_alloc(union=
 bpf_attr *attr)
 {
 	struct bpf_local_storage_map *smap;
 	unsigned int i;
@@ -663,3 +663,28 @@ int bpf_local_storage_map_check_btf(const struct bpf=
_map *map,
=20
 	return 0;
 }
+
+struct bpf_map *
+bpf_local_storage_map_alloc(union bpf_attr *attr,
+			    struct bpf_local_storage_cache *cache)
+{
+	struct bpf_local_storage_map *smap;
+
+	smap =3D __bpf_local_storage_map_alloc(attr);
+	if (IS_ERR(smap))
+		return ERR_CAST(smap);
+
+	smap->cache_idx =3D bpf_local_storage_cache_idx_get(cache);
+	return &smap->map;
+}
+
+void bpf_local_storage_map_free(struct bpf_map *map,
+				struct bpf_local_storage_cache *cache,
+				int __percpu *busy_counter)
+{
+	struct bpf_local_storage_map *smap;
+
+	smap =3D (struct bpf_local_storage_map *)map;
+	bpf_local_storage_cache_idx_free(cache, smap->cache_idx);
+	__bpf_local_storage_map_free(smap, busy_counter);
+}
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.=
c
index 6f290623347e..020153902ef8 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -288,23 +288,12 @@ static int notsupp_get_next_key(struct bpf_map *map=
, void *key, void *next_key)
=20
 static struct bpf_map *task_storage_map_alloc(union bpf_attr *attr)
 {
-	struct bpf_local_storage_map *smap;
-
-	smap =3D bpf_local_storage_map_alloc(attr);
-	if (IS_ERR(smap))
-		return ERR_CAST(smap);
-
-	smap->cache_idx =3D bpf_local_storage_cache_idx_get(&task_cache);
-	return &smap->map;
+	return bpf_local_storage_map_alloc(attr, &task_cache);
 }
=20
 static void task_storage_map_free(struct bpf_map *map)
 {
-	struct bpf_local_storage_map *smap;
-
-	smap =3D (struct bpf_local_storage_map *)map;
-	bpf_local_storage_cache_idx_free(&task_cache, smap->cache_idx);
-	bpf_local_storage_map_free(smap, &bpf_task_storage_busy);
+	bpf_local_storage_map_free(map, &task_cache, &bpf_task_storage_busy);
 }
=20
 BTF_ID_LIST_SINGLE(task_storage_map_btf_ids, struct, bpf_local_storage_m=
ap)
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 94374d529ea4..3bfdc8834a5b 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -87,23 +87,12 @@ void bpf_sk_storage_free(struct sock *sk)
=20
 static void bpf_sk_storage_map_free(struct bpf_map *map)
 {
-	struct bpf_local_storage_map *smap;
-
-	smap =3D (struct bpf_local_storage_map *)map;
-	bpf_local_storage_cache_idx_free(&sk_cache, smap->cache_idx);
-	bpf_local_storage_map_free(smap, NULL);
+	bpf_local_storage_map_free(map, &sk_cache, NULL);
 }
=20
 static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
 {
-	struct bpf_local_storage_map *smap;
-
-	smap =3D bpf_local_storage_map_alloc(attr);
-	if (IS_ERR(smap))
-		return ERR_CAST(smap);
-
-	smap->cache_idx =3D bpf_local_storage_cache_idx_get(&sk_cache);
-	return &smap->map;
+	return bpf_local_storage_map_alloc(attr, &sk_cache);
 }
=20
 static int notsupp_get_next_key(struct bpf_map *map, void *key,
--=20
2.30.2

