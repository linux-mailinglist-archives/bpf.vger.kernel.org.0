Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D0324D88D
	for <lists+bpf@lfdr.de>; Fri, 21 Aug 2020 17:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgHUP2s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Aug 2020 11:28:48 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59134 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727782AbgHUP2q (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 21 Aug 2020 11:28:46 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07LFQl4w025666
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 08:28:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=QJ4UraS5Q3q15PU57x30nEIbg+862MWUX7q91oaWF44=;
 b=b8vgBKhggGIHrAJeS1F19MuULvjGeGvvtDU2+ERQiDUthA5PZXm3DVmUdjinDlPKh6Et
 H4FG5plJQ4iKO5aOHI6djxq6eFDA1uknNWSHwKAUb8qUCiMH7W9lm5wjCzZvS4G3ydB6
 g+tIM2tz0I0PQzYc+AieOMFBYf/luLq2eCM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 331cueabbu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 08:28:44 -0700
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 21 Aug 2020 08:28:43 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id AABF2344107B; Fri, 21 Aug 2020 08:01:35 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1096.prn0.facebook.com
To:     <bpf@vger.kernel.org>
CC:     <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        Roman Gushchin <guro@fb.com>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: prn0c01
Subject: [PATCH bpf-next v4 26/30] bpf: eliminate rlimit-based memory accounting for socket storage maps
Date:   Fri, 21 Aug 2020 08:01:30 -0700
Message-ID: <20200821150134.2581465-27-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200821150134.2581465-1-guro@fb.com>
References: <20200821150134.2581465-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-21_08:2020-08-21,2020-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 priorityscore=1501 suspectscore=13 spamscore=0 impostorscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 mlxlogscore=882
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008210144
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Do not use rlimit-based memory accounting for socket storage maps.
It has been replaced with the memcg-based memory accounting.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 net/core/bpf_sk_storage.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 806b7a9f836e..bc378ce499f4 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -676,8 +676,6 @@ static struct bpf_map *bpf_sk_storage_map_alloc(union=
 bpf_attr *attr)
 	struct bpf_sk_storage_map *smap;
 	unsigned int i;
 	u32 nbuckets;
-	u64 cost;
-	int ret;
=20
 	smap =3D kzalloc(sizeof(*smap), GFP_USER | __GFP_NOWARN | __GFP_ACCOUNT=
);
 	if (!smap)
@@ -688,18 +686,9 @@ static struct bpf_map *bpf_sk_storage_map_alloc(unio=
n bpf_attr *attr)
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

