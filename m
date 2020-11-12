Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7C42B11CD
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 23:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbgKLWgb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 17:36:31 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21596 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727290AbgKLWga (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Nov 2020 17:36:30 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ACMNnox025159
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 14:36:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=i22VzsfYXFhHUbHUyBRo4SfAiYTea7Ssop+WPV0F4gA=;
 b=ZVJQU506HBdHEyaM65oB6uL5WwD7QoNeGuRpdltQiHr+0mWyEna6l8xoRMaikbCxQ84F
 L9fB4HXdkPnF1v3R+Or+5QRC5vP75/cLPs/x62ZAlfPy3fHTYDj8Fb2G5HaQ2PhW6765
 ekzHgiZwIn0Rx8vOqgPvGXDBKj4MX7DBS+c= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34s7getq7y-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 14:36:29 -0800
Received: from intmgw002.06.prn3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 12 Nov 2020 14:36:28 -0800
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 280F2A7D213; Thu, 12 Nov 2020 14:16:01 -0800 (PST)
From:   Roman Gushchin <guro@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        <netdev@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>, Song Liu <songliubraving@fb.com>
Subject: [PATCH bpf-next v5 18/34] bpf: eliminate rlimit-based memory accounting for arraymap maps
Date:   Thu, 12 Nov 2020 14:15:27 -0800
Message-ID: <20201112221543.3621014-19-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201112221543.3621014-1-guro@fb.com>
References: <20201112221543.3621014-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-12_14:2020-11-12,2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=839 adultscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=38 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011120127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Do not use rlimit-based memory accounting for arraymap maps.
It has been replaced with the memcg-based memory accounting.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 kernel/bpf/arraymap.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 92b650123c22..20f751a1d993 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -81,11 +81,10 @@ int array_map_alloc_check(union bpf_attr *attr)
 static struct bpf_map *array_map_alloc(union bpf_attr *attr)
 {
 	bool percpu =3D attr->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY;
-	int ret, numa_node =3D bpf_map_attr_numa_node(attr);
+	int numa_node =3D bpf_map_attr_numa_node(attr);
 	u32 elem_size, index_mask, max_entries;
 	bool bypass_spec_v1 =3D bpf_bypass_spec_v1();
-	u64 cost, array_size, mask64;
-	struct bpf_map_memory mem;
+	u64 array_size, mask64;
 	struct bpf_array *array;
=20
 	elem_size =3D round_up(attr->value_size, 8);
@@ -126,44 +125,29 @@ static struct bpf_map *array_map_alloc(union bpf_at=
tr *attr)
 		}
 	}
=20
-	/* make sure there is no u32 overflow later in round_up() */
-	cost =3D array_size;
-	if (percpu)
-		cost +=3D (u64)attr->max_entries * elem_size * num_possible_cpus();
-
-	ret =3D bpf_map_charge_init(&mem, cost);
-	if (ret < 0)
-		return ERR_PTR(ret);
-
 	/* allocate all map elements and zero-initialize them */
 	if (attr->map_flags & BPF_F_MMAPABLE) {
 		void *data;
=20
 		/* kmalloc'ed memory can't be mmap'ed, use explicit vmalloc */
 		data =3D bpf_map_area_mmapable_alloc(array_size, numa_node);
-		if (!data) {
-			bpf_map_charge_finish(&mem);
+		if (!data)
 			return ERR_PTR(-ENOMEM);
-		}
 		array =3D data + PAGE_ALIGN(sizeof(struct bpf_array))
 			- offsetof(struct bpf_array, value);
 	} else {
 		array =3D bpf_map_area_alloc(array_size, numa_node);
 	}
-	if (!array) {
-		bpf_map_charge_finish(&mem);
+	if (!array)
 		return ERR_PTR(-ENOMEM);
-	}
 	array->index_mask =3D index_mask;
 	array->map.bypass_spec_v1 =3D bypass_spec_v1;
=20
 	/* copy mandatory map attributes */
 	bpf_map_init_from_attr(&array->map, attr);
-	bpf_map_charge_move(&array->map.memory, &mem);
 	array->elem_size =3D elem_size;
=20
 	if (percpu && bpf_array_alloc_percpu(array)) {
-		bpf_map_charge_finish(&array->map.memory);
 		bpf_map_area_free(array);
 		return ERR_PTR(-ENOMEM);
 	}
--=20
2.26.2

