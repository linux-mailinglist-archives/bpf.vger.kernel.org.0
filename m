Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFF324D818
	for <lists+bpf@lfdr.de>; Fri, 21 Aug 2020 17:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgHUPMS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Aug 2020 11:12:18 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:12324 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727937AbgHUPLu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 21 Aug 2020 11:11:50 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07LFB82m019499
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 08:11:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=yke4uNA5JlzoahJ1Tt+1j89N/7eai5AFxMKQPSnjSmc=;
 b=I2jfwEJFMZRodgY8++tQMYXHoP60TNQsBo59KeC1+OkPFyQa3EYKWjTmgTMFukg3jxPL
 w59OpGK/a+fUgrjgCNQbJBwDd4Ai8usg6HbefwmtgJTIE5CoCN36Pn9nygG9LUPcWeb2
 7iT8E6Ss/vyFxz5YneCjm4wIi5RK/mxacNA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3304p3w5qp-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 08:11:50 -0700
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 21 Aug 2020 08:11:46 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id 5D348344105B; Fri, 21 Aug 2020 08:01:35 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 11/30] bpf: memcg-based memory accounting for socket storage maps
Date:   Fri, 21 Aug 2020 08:01:15 -0700
Message-ID: <20200821150134.2581465-12-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200821150134.2581465-1-guro@fb.com>
References: <20200821150134.2581465-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-21_08:2020-08-21,2020-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=997
 spamscore=0 mlxscore=0 clxscore=1015 suspectscore=13 adultscore=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008210143
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Account memory used by the socket storage.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 net/core/bpf_sk_storage.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index b988f48153a4..806b7a9f836e 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -130,7 +130,8 @@ static struct bpf_sk_storage_elem *selem_alloc(struct=
 bpf_sk_storage_map *smap,
 	if (charge_omem && omem_charge(sk, smap->elem_size))
 		return NULL;
=20
-	selem =3D kzalloc(smap->elem_size, GFP_ATOMIC | __GFP_NOWARN);
+	selem =3D kzalloc(smap->elem_size,
+			GFP_ATOMIC | __GFP_NOWARN | __GFP_ACCOUNT);
 	if (selem) {
 		if (value)
 			memcpy(SDATA(selem)->data, value, smap->map.value_size);
@@ -337,7 +338,8 @@ static int sk_storage_alloc(struct sock *sk,
 	if (err)
 		return err;
=20
-	sk_storage =3D kzalloc(sizeof(*sk_storage), GFP_ATOMIC | __GFP_NOWARN);
+	sk_storage =3D kzalloc(sizeof(*sk_storage),
+			     GFP_ATOMIC | __GFP_NOWARN | __GFP_ACCOUNT);
 	if (!sk_storage) {
 		err =3D -ENOMEM;
 		goto uncharge;
@@ -677,7 +679,7 @@ static struct bpf_map *bpf_sk_storage_map_alloc(union=
 bpf_attr *attr)
 	u64 cost;
 	int ret;
=20
-	smap =3D kzalloc(sizeof(*smap), GFP_USER | __GFP_NOWARN);
+	smap =3D kzalloc(sizeof(*smap), GFP_USER | __GFP_NOWARN | __GFP_ACCOUNT=
);
 	if (!smap)
 		return ERR_PTR(-ENOMEM);
 	bpf_map_init_from_attr(&smap->map, attr);
@@ -695,7 +697,7 @@ static struct bpf_map *bpf_sk_storage_map_alloc(union=
 bpf_attr *attr)
 	}
=20
 	smap->buckets =3D kvcalloc(sizeof(*smap->buckets), nbuckets,
-				 GFP_USER | __GFP_NOWARN);
+				 GFP_USER | __GFP_NOWARN | __GFP_ACCOUNT);
 	if (!smap->buckets) {
 		bpf_map_charge_finish(&smap->map.memory);
 		kfree(smap);
@@ -1034,7 +1036,7 @@ bpf_sk_storage_diag_alloc(const struct nlattr *nla_=
stgs)
 	}
=20
 	diag =3D kzalloc(sizeof(*diag) + sizeof(diag->maps[0]) * nr_maps,
-		       GFP_KERNEL);
+		       GFP_KERNEL | __GFP_ACCOUNT);
 	if (!diag)
 		return ERR_PTR(-ENOMEM);
=20
--=20
2.26.2

