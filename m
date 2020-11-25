Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9192C3759
	for <lists+bpf@lfdr.de>; Wed, 25 Nov 2020 04:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgKYDDG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Nov 2020 22:03:06 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45148 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727413AbgKYDBb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 24 Nov 2020 22:01:31 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AP31RYr027593
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2020 19:01:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=A3eOrPgM2BTtMwxnn1eP2x4TypeBJg3XDUUsavLG0go=;
 b=ceXO0pZiHV+p1BD81+q7KGUIoMlur5dj/aabq/6r6OcO7oEpzdRaGyyRqLNyer6V8d9T
 IxtsYH0fGsbVh/w+yo3Hc6iMtY2ubyZDOL9TQZo0IycQDyjObqbv2bVHh795k7oKRXT/
 lYQ0W3pSkUTylO1cX1snkT3DHZTVqWZTx4I= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34yk9gcp3f-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2020 19:01:31 -0800
Received: from intmgw001.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 24 Nov 2020 19:01:27 -0800
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 5046B16A18AD; Tue, 24 Nov 2020 19:01:22 -0800 (PST)
From:   Roman Gushchin <guro@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <andrii@kernel.org>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next v8 22/34] bpf: eliminate rlimit-based memory accounting for devmap maps
Date:   Tue, 24 Nov 2020 19:01:07 -0800
Message-ID: <20201125030119.2864302-23-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201125030119.2864302-1-guro@fb.com>
References: <20201125030119.2864302-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_11:2020-11-24,2020-11-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 suspectscore=38 malwarescore=0 adultscore=0 priorityscore=1501
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=858
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011250019
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Do not use rlimit-based memory accounting for devmap maps.
It has been replaced with the memcg-based memory accounting.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 kernel/bpf/devmap.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index a4dfe544946f..1fdeb7225111 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -109,8 +109,6 @@ static inline struct hlist_head *dev_map_index_hash(s=
truct bpf_dtab *dtab,
 static int dev_map_init_map(struct bpf_dtab *dtab, union bpf_attr *attr)
 {
 	u32 valsize =3D attr->value_size;
-	u64 cost =3D 0;
-	int err;
=20
 	/* check sanity of attributes. 2 value sizes supported:
 	 * 4 bytes: ifindex
@@ -135,21 +133,13 @@ static int dev_map_init_map(struct bpf_dtab *dtab, =
union bpf_attr *attr)
=20
 		if (!dtab->n_buckets) /* Overflow check */
 			return -EINVAL;
-		cost +=3D (u64) sizeof(struct hlist_head) * dtab->n_buckets;
-	} else {
-		cost +=3D (u64) dtab->map.max_entries * sizeof(struct bpf_dtab_netdev =
*);
 	}
=20
-	/* if map size is larger than memlock limit, reject it */
-	err =3D bpf_map_charge_init(&dtab->map.memory, cost);
-	if (err)
-		return -EINVAL;
-
 	if (attr->map_type =3D=3D BPF_MAP_TYPE_DEVMAP_HASH) {
 		dtab->dev_index_head =3D dev_map_create_hash(dtab->n_buckets,
 							   dtab->map.numa_node);
 		if (!dtab->dev_index_head)
-			goto free_charge;
+			return -ENOMEM;
=20
 		spin_lock_init(&dtab->index_lock);
 	} else {
@@ -157,14 +147,10 @@ static int dev_map_init_map(struct bpf_dtab *dtab, =
union bpf_attr *attr)
 						      sizeof(struct bpf_dtab_netdev *),
 						      dtab->map.numa_node);
 		if (!dtab->netdev_map)
-			goto free_charge;
+			return -ENOMEM;
 	}
=20
 	return 0;
-
-free_charge:
-	bpf_map_charge_finish(&dtab->map.memory);
-	return -ENOMEM;
 }
=20
 static struct bpf_map *dev_map_alloc(union bpf_attr *attr)
--=20
2.26.2

