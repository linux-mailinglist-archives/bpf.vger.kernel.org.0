Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA3E2B580D
	for <lists+bpf@lfdr.de>; Tue, 17 Nov 2020 04:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgKQDlX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Nov 2020 22:41:23 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:28416 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727227AbgKQDlW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 16 Nov 2020 22:41:22 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AH3dv97004416
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 19:41:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=M/FrhIwQBgnNYYIqlV0fdwOhfcWnzOZQBNd0dGHSqyA=;
 b=YrckXWLiRDLkoEqb2TdWNyx3q12nmHpklNylJ6nif7PfRU904NR492og1l02b+8qqZtx
 EdcC9l6Gtc7AWr2A3AcCsG55HZ/r1CjF28lG8uGDr7V4xaPPWbHUj2j1GrKEM7+0G5lw
 WIuLtHMd1JKIt0RrUucGu6Xkaj3TN6qLnKs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34tdmruh5x-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 19:41:21 -0800
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 16 Nov 2020 19:41:19 -0800
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 9E2ECC63A95; Mon, 16 Nov 2020 19:41:10 -0800 (PST)
From:   Roman Gushchin <guro@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <andrii@kernel.org>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next v6 31/34] bpf: eliminate rlimit-based memory accounting for bpf local storage maps
Date:   Mon, 16 Nov 2020 19:41:05 -0800
Message-ID: <20201117034108.1186569-32-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201117034108.1186569-1-guro@fb.com>
References: <20201117034108.1186569-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_01:2020-11-13,2020-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 suspectscore=13 adultscore=0 phishscore=0 mlxlogscore=673 spamscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011170027
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Do not use rlimit-based memory accounting for bpf local storage maps.
It has been replaced with the memcg-based memory accounting.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 kernel/bpf/bpf_local_storage.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storag=
e.c
index fd4f9ac1d042..3b0da5a04d55 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -544,8 +544,6 @@ struct bpf_local_storage_map *bpf_local_storage_map_a=
lloc(union bpf_attr *attr)
 	struct bpf_local_storage_map *smap;
 	unsigned int i;
 	u32 nbuckets;
-	u64 cost;
-	int ret;
=20
 	smap =3D kzalloc(sizeof(*smap), GFP_USER | __GFP_NOWARN | __GFP_ACCOUNT=
);
 	if (!smap)
@@ -556,18 +554,9 @@ struct bpf_local_storage_map *bpf_local_storage_map_=
alloc(union bpf_attr *attr)
 	/* Use at least 2 buckets, select_bucket() is undefined behavior with 1=
 bucket */
 	nbuckets =3D max_t(u32, 2, nbuckets);
 	smap->bucket_log =3D ilog2(nbuckets);
-	cost =3D sizeof(*smap->buckets) * nbuckets + sizeof(*smap);
-
-	ret =3D bpf_map_charge_init(&smap->map.memory, cost);
-	if (ret < 0) {
-		kfree(smap);
-		return ERR_PTR(ret);
-	}
-
 	smap->buckets =3D kvcalloc(sizeof(*smap->buckets), nbuckets,
 				 GFP_USER | __GFP_NOWARN | __GFP_ACCOUNT);
 	if (!smap->buckets) {
-		bpf_map_charge_finish(&smap->map.memory);
 		kfree(smap);
 		return ERR_PTR(-ENOMEM);
 	}
--=20
2.26.2

