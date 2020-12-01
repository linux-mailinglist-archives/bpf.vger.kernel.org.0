Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEC22CAF67
	for <lists+bpf@lfdr.de>; Tue,  1 Dec 2020 23:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390748AbgLAWAf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Dec 2020 17:00:35 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56572 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390838AbgLAWAA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 1 Dec 2020 17:00:00 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B1Lnqxw027031
        for <bpf@vger.kernel.org>; Tue, 1 Dec 2020 13:59:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=M6nI7BN0unMH8lLVYY0WWTngfpCmQVxP1GeXrD6hnIE=;
 b=RnPrFSc+Gqtxq6zJyVTtNjbwTpFsTgniADjRL0NKsGtaVLhssCW/dI1sZB4bcX/3ntak
 0VCH+C2ZuONNiJBQh51Omm5mtj0R+yXs9Ro3G15krIKLGof4//caH56T5NaIyJTgI8ec
 ezEp/ksHSkeu2fDxnD7pmymGyE2/G2CZGPw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 355vfk0t9y-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 01 Dec 2020 13:59:19 -0800
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 1 Dec 2020 13:59:16 -0800
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id C986519702D8; Tue,  1 Dec 2020 13:59:06 -0800 (PST)
From:   Roman Gushchin <guro@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <andrii@kernel.org>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next v9 29/34] bpf: eliminate rlimit-based memory accounting for stackmap maps
Date:   Tue, 1 Dec 2020 13:58:55 -0800
Message-ID: <20201201215900.3569844-30-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201201215900.3569844-1-guro@fb.com>
References: <20201201215900.3569844-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_11:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=748 malwarescore=0 spamscore=0 suspectscore=38 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012010131
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Do not use rlimit-based memory accounting for stackmap maps.
It has been replaced with the memcg-based memory accounting.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 kernel/bpf/stackmap.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 06065fa27124..3325add8e629 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -90,7 +90,6 @@ static struct bpf_map *stack_map_alloc(union bpf_attr *=
attr)
 {
 	u32 value_size =3D attr->value_size;
 	struct bpf_stack_map *smap;
-	struct bpf_map_memory mem;
 	u64 cost, n_buckets;
 	int err;
=20
@@ -119,15 +118,9 @@ static struct bpf_map *stack_map_alloc(union bpf_att=
r *attr)
=20
 	cost =3D n_buckets * sizeof(struct stack_map_bucket *) + sizeof(*smap);
 	cost +=3D n_buckets * (value_size + sizeof(struct stack_map_bucket));
-	err =3D bpf_map_charge_init(&mem, cost);
-	if (err)
-		return ERR_PTR(err);
-
 	smap =3D bpf_map_area_alloc(cost, bpf_map_attr_numa_node(attr));
-	if (!smap) {
-		bpf_map_charge_finish(&mem);
+	if (!smap)
 		return ERR_PTR(-ENOMEM);
-	}
=20
 	bpf_map_init_from_attr(&smap->map, attr);
 	smap->map.value_size =3D value_size;
@@ -135,20 +128,17 @@ static struct bpf_map *stack_map_alloc(union bpf_at=
tr *attr)
=20
 	err =3D get_callchain_buffers(sysctl_perf_event_max_stack);
 	if (err)
-		goto free_charge;
+		goto free_smap;
=20
 	err =3D prealloc_elems_and_freelist(smap);
 	if (err)
 		goto put_buffers;
=20
-	bpf_map_charge_move(&smap->map.memory, &mem);
-
 	return &smap->map;
=20
 put_buffers:
 	put_callchain_buffers();
-free_charge:
-	bpf_map_charge_finish(&mem);
+free_smap:
 	bpf_map_area_free(smap);
 	return ERR_PTR(err);
 }
--=20
2.26.2

