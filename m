Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D86C2B5763
	for <lists+bpf@lfdr.de>; Tue, 17 Nov 2020 03:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgKQC5D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Nov 2020 21:57:03 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48002 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727134AbgKQCzq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 16 Nov 2020 21:55:46 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AH2ksRX014930
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 18:55:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=60beXYawD2xmTF+UIJDKaQb+/JMtP6jveiuhsmWF1Tg=;
 b=HWBY6xgE//KRx14J6IHvk+/NGQ4xSU7WgsZZ0RgMjsj2v77mM+AikNVh4gF/VNn7l3Co
 RfdbHRIgu4PIzrzJCzWLhYnTAnasXhG1aGrqXIbP5/vpVo8b4Q1igMyapncpY7MJYq21
 11jAkee0knWumvAcmSGn0/qAfU6YOzti37U= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34tykx8pf2-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 18:55:45 -0800
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 16 Nov 2020 18:55:36 -0800
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 1B9D8C5F7EA; Mon, 16 Nov 2020 18:55:34 -0800 (PST)
From:   Roman Gushchin <guro@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <andrii@kernel.org>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: [PATCH v6 21/34] bpf: eliminate rlimit-based memory accounting for cgroup storage maps
Date:   Mon, 16 Nov 2020 18:55:16 -0800
Message-ID: <20201117025529.1034387-22-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201117025529.1034387-1-guro@fb.com>
References: <20201117025529.1034387-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-16_13:2020-11-13,2020-11-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=38 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170022
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Do not use rlimit-based memory accounting for cgroup storage maps.
It has been replaced with the memcg-based memory accounting.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 kernel/bpf/local_storage.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 212d6dbbc39a..c28a47d5177a 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -288,8 +288,6 @@ static struct bpf_map *cgroup_storage_map_alloc(union=
 bpf_attr *attr)
 {
 	int numa_node =3D bpf_map_attr_numa_node(attr);
 	struct bpf_cgroup_storage_map *map;
-	struct bpf_map_memory mem;
-	int ret;
=20
 	if (attr->key_size !=3D sizeof(struct bpf_cgroup_storage_key) &&
 	    attr->key_size !=3D sizeof(__u64))
@@ -309,18 +307,10 @@ static struct bpf_map *cgroup_storage_map_alloc(uni=
on bpf_attr *attr)
 		/* max_entries is not used and enforced to be 0 */
 		return ERR_PTR(-EINVAL);
=20
-	ret =3D bpf_map_charge_init(&mem, sizeof(struct bpf_cgroup_storage_map)=
);
-	if (ret < 0)
-		return ERR_PTR(ret);
-
 	map =3D kmalloc_node(sizeof(struct bpf_cgroup_storage_map),
 			   __GFP_ZERO | GFP_USER | __GFP_ACCOUNT, numa_node);
-	if (!map) {
-		bpf_map_charge_finish(&mem);
+	if (!map)
 		return ERR_PTR(-ENOMEM);
-	}
-
-	bpf_map_charge_move(&map->map.memory, &mem);
=20
 	/* copy mandatory map attributes */
 	bpf_map_init_from_attr(&map->map, attr);
@@ -509,9 +499,6 @@ struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(s=
truct bpf_prog *prog,
=20
 	size =3D bpf_cgroup_storage_calculate_size(map, &pages);
=20
-	if (bpf_map_charge_memlock(map, pages))
-		return ERR_PTR(-EPERM);
-
 	storage =3D kmalloc_node(sizeof(struct bpf_cgroup_storage), gfp,
 			       map->numa_node);
 	if (!storage)
@@ -533,7 +520,6 @@ struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(s=
truct bpf_prog *prog,
 	return storage;
=20
 enomem:
-	bpf_map_uncharge_memlock(map, pages);
 	kfree(storage);
 	return ERR_PTR(-ENOMEM);
 }
@@ -560,16 +546,11 @@ void bpf_cgroup_storage_free(struct bpf_cgroup_stor=
age *storage)
 {
 	enum bpf_cgroup_storage_type stype;
 	struct bpf_map *map;
-	u32 pages;
=20
 	if (!storage)
 		return;
=20
 	map =3D &storage->map->map;
-
-	bpf_cgroup_storage_calculate_size(map, &pages);
-	bpf_map_uncharge_memlock(map, pages);
-
 	stype =3D cgroup_storage_type(map);
 	if (stype =3D=3D BPF_CGROUP_STORAGE_SHARED)
 		call_rcu(&storage->rcu, free_shared_cgroup_storage_rcu);
--=20
2.26.2

