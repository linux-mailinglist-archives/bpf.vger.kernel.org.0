Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F09D2CAF8C
	for <lists+bpf@lfdr.de>; Tue,  1 Dec 2020 23:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391809AbgLAWBq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Dec 2020 17:01:46 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:14160 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389838AbgLAV74 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 1 Dec 2020 16:59:56 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0B1Lngkn006687
        for <bpf@vger.kernel.org>; Tue, 1 Dec 2020 13:59:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=h6PXB4ExcT3GP3qFAXy2gqJvs6xVABY40pGBrkACiCE=;
 b=FjD3dcqVkmhjP4QcEjEpCKOZB9124VJ995HIXfn0j3NgqcFU3fL0NFYK4ufCvFOaOsgI
 MbZAL/DX9KKu0H2mgkVAXB2CKXB8F7eC+4GvqLiR3l096HELJyuidz0WTBIW0ebQ+NxB
 8ntBGgbdsoWDeEjylaxmQljVglW4xdrXLE4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 355pr6kf7b-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 01 Dec 2020 13:59:15 -0800
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 1 Dec 2020 13:59:10 -0800
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id CE3FC19702DA; Tue,  1 Dec 2020 13:59:06 -0800 (PST)
From:   Roman Gushchin <guro@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <andrii@kernel.org>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next v9 30/34] bpf: eliminate rlimit-based memory accounting for xskmap maps
Date:   Tue, 1 Dec 2020 13:58:56 -0800
Message-ID: <20201201215900.3569844-31-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201201215900.3569844-1-guro@fb.com>
References: <20201201215900.3569844-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_11:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 priorityscore=1501 suspectscore=13 spamscore=0 adultscore=0 clxscore=1015
 mlxlogscore=838 lowpriorityscore=0 mlxscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010131
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Do not use rlimit-based memory accounting for xskmap maps.
It has been replaced with the memcg-based memory accounting.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 net/xdp/xskmap.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/net/xdp/xskmap.c b/net/xdp/xskmap.c
index 9fff1e6dc9cd..113fd9017203 100644
--- a/net/xdp/xskmap.c
+++ b/net/xdp/xskmap.c
@@ -58,9 +58,8 @@ static void xsk_map_sock_delete(struct xdp_sock *xs,
=20
 static struct bpf_map *xsk_map_alloc(union bpf_attr *attr)
 {
-	struct bpf_map_memory mem;
-	int err, numa_node;
 	struct xsk_map *m;
+	int numa_node;
 	u64 size;
=20
 	if (!capable(CAP_NET_ADMIN))
@@ -74,18 +73,11 @@ static struct bpf_map *xsk_map_alloc(union bpf_attr *=
attr)
 	numa_node =3D bpf_map_attr_numa_node(attr);
 	size =3D struct_size(m, xsk_map, attr->max_entries);
=20
-	err =3D bpf_map_charge_init(&mem, size);
-	if (err < 0)
-		return ERR_PTR(err);
-
 	m =3D bpf_map_area_alloc(size, numa_node);
-	if (!m) {
-		bpf_map_charge_finish(&mem);
+	if (!m)
 		return ERR_PTR(-ENOMEM);
-	}
=20
 	bpf_map_init_from_attr(&m->map, attr);
-	bpf_map_charge_move(&m->map.memory, &mem);
 	spin_lock_init(&m->lock);
=20
 	return &m->map;
--=20
2.26.2

