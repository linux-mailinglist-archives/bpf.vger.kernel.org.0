Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253942CAFA7
	for <lists+bpf@lfdr.de>; Tue,  1 Dec 2020 23:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392257AbgLAWCn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Dec 2020 17:02:43 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33208 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730361AbgLAV7w (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 1 Dec 2020 16:59:52 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B1Lo0KY027479
        for <bpf@vger.kernel.org>; Tue, 1 Dec 2020 13:59:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=OsW+YgsUMKIkwiLI58nQIqOmhb5BolGzaeK0LwveQiU=;
 b=E+u36fC33PUG7iamCK81UHGY4ph/VQecgtOYQvj9AuL6e/WZji0ikXJ/eg8qtog3Ye6o
 0spUq4draCeJORiA+rExrWAQ5LcLg9VGt+oOFcUqkF8ObJRLTHP850f4A3Wzy2z4cQD0
 Cfu0ODK3JWFGDGoBJM8bo+tpstp+2zZ/ELg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 355agsq2yt-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 01 Dec 2020 13:59:11 -0800
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 1 Dec 2020 13:59:09 -0800
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 6C96D19702B2; Tue,  1 Dec 2020 13:59:06 -0800 (PST)
From:   Roman Gushchin <guro@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <andrii@kernel.org>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next v9 10/34] bpf: memcg-based memory accounting for cgroup storage maps
Date:   Tue, 1 Dec 2020 13:58:36 -0800
Message-ID: <20201201215900.3569844-11-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201201215900.3569844-1-guro@fb.com>
References: <20201201215900.3569844-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_11:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 malwarescore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 suspectscore=13 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010131
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Account memory used by cgroup storage maps including metadata
structures.

Account the percpu memory for the percpu flavor of cgroup storage.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 kernel/bpf/local_storage.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 571bb351ed3b..74dcee8926e5 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -164,10 +164,10 @@ static int cgroup_storage_update_elem(struct bpf_ma=
p *map, void *key,
 		return 0;
 	}
=20
-	new =3D kmalloc_node(sizeof(struct bpf_storage_buffer) +
-			   map->value_size,
-			   __GFP_ZERO | GFP_ATOMIC | __GFP_NOWARN,
-			   map->numa_node);
+	new =3D bpf_map_kmalloc_node(map, sizeof(struct bpf_storage_buffer) +
+				   map->value_size,
+				   __GFP_ZERO | GFP_ATOMIC | __GFP_NOWARN,
+				   map->numa_node);
 	if (!new)
 		return -ENOMEM;
=20
@@ -313,7 +313,7 @@ static struct bpf_map *cgroup_storage_map_alloc(union=
 bpf_attr *attr)
 		return ERR_PTR(ret);
=20
 	map =3D kmalloc_node(sizeof(struct bpf_cgroup_storage_map),
-			   __GFP_ZERO | GFP_USER, numa_node);
+			   __GFP_ZERO | GFP_USER | __GFP_ACCOUNT, numa_node);
 	if (!map) {
 		bpf_map_charge_finish(&mem);
 		return ERR_PTR(-ENOMEM);
@@ -496,9 +496,9 @@ static size_t bpf_cgroup_storage_calculate_size(struc=
t bpf_map *map, u32 *pages)
 struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *pro=
g,
 					enum bpf_cgroup_storage_type stype)
 {
+	const gfp_t gfp =3D __GFP_ZERO | GFP_USER;
 	struct bpf_cgroup_storage *storage;
 	struct bpf_map *map;
-	gfp_t flags;
 	size_t size;
 	u32 pages;
=20
@@ -511,20 +511,19 @@ struct bpf_cgroup_storage *bpf_cgroup_storage_alloc=
(struct bpf_prog *prog,
 	if (bpf_map_charge_memlock(map, pages))
 		return ERR_PTR(-EPERM);
=20
-	storage =3D kmalloc_node(sizeof(struct bpf_cgroup_storage),
-			       __GFP_ZERO | GFP_USER, map->numa_node);
+	storage =3D bpf_map_kmalloc_node(map, sizeof(struct bpf_cgroup_storage)=
,
+				       gfp, map->numa_node);
 	if (!storage)
 		goto enomem;
=20
-	flags =3D __GFP_ZERO | GFP_USER;
-
 	if (stype =3D=3D BPF_CGROUP_STORAGE_SHARED) {
-		storage->buf =3D kmalloc_node(size, flags, map->numa_node);
+		storage->buf =3D bpf_map_kmalloc_node(map, size, gfp,
+						    map->numa_node);
 		if (!storage->buf)
 			goto enomem;
 		check_and_init_map_lock(map, storage->buf->data);
 	} else {
-		storage->percpu_buf =3D __alloc_percpu_gfp(size, 8, flags);
+		storage->percpu_buf =3D bpf_map_alloc_percpu(map, size, 8, gfp);
 		if (!storage->percpu_buf)
 			goto enomem;
 	}
--=20
2.26.2

