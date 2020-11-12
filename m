Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9BF2B11A6
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 23:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgKLWgb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 17:36:31 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:26882 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727530AbgKLWga (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Nov 2020 17:36:30 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ACMNnp2025159
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 14:36:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ASU5eX9Fzb/xsl6VZmhE+3qV6oQDGd2P3b7uVl5v5h4=;
 b=GC0uVOGuV21eygz2EmnfkxkBXDO8I/wLPrB6A9AKfmX0FSM2VIGwVkvNCcIkr6cBXNVj
 5rJ41/n1n/fc+mvOY1OIvxHIQEtul7An7foCqOE443YTNtPe8AY1mJVqcYC5DsAqbVzT
 RXOPvumPiSidIG7SWt5dSUpMZNlHTbTgLi4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34s7getq7y-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 14:36:30 -0800
Received: from intmgw002.06.prn3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 12 Nov 2020 14:36:28 -0800
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 31DA2A7D21B; Thu, 12 Nov 2020 14:16:01 -0800 (PST)
From:   Roman Gushchin <guro@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        <netdev@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>, Song Liu <songliubraving@fb.com>
Subject: [PATCH bpf-next v5 20/34] bpf: eliminate rlimit-based memory accounting for cpumap maps
Date:   Thu, 12 Nov 2020 14:15:29 -0800
Message-ID: <20201112221543.3621014-21-guro@fb.com>
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
 mlxlogscore=908 adultscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=38 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011120127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Do not use rlimit-based memory accounting for cpumap maps.
It has been replaced with the memcg-based memory accounting.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 kernel/bpf/cpumap.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 563f96cc8a9d..7103d89a7d41 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -84,8 +84,6 @@ static struct bpf_map *cpu_map_alloc(union bpf_attr *at=
tr)
 	u32 value_size =3D attr->value_size;
 	struct bpf_cpu_map *cmap;
 	int err =3D -ENOMEM;
-	u64 cost;
-	int ret;
=20
 	if (!bpf_capable())
 		return ERR_PTR(-EPERM);
@@ -109,26 +107,14 @@ static struct bpf_map *cpu_map_alloc(union bpf_attr=
 *attr)
 		goto free_cmap;
 	}
=20
-	/* make sure page count doesn't overflow */
-	cost =3D (u64) cmap->map.max_entries * sizeof(struct bpf_cpu_map_entry =
*);
-
-	/* Notice returns -EPERM on if map size is larger than memlock limit */
-	ret =3D bpf_map_charge_init(&cmap->map.memory, cost);
-	if (ret) {
-		err =3D ret;
-		goto free_cmap;
-	}
-
 	/* Alloc array for possible remote "destination" CPUs */
 	cmap->cpu_map =3D bpf_map_area_alloc(cmap->map.max_entries *
 					   sizeof(struct bpf_cpu_map_entry *),
 					   cmap->map.numa_node);
 	if (!cmap->cpu_map)
-		goto free_charge;
+		goto free_cmap;
=20
 	return &cmap->map;
-free_charge:
-	bpf_map_charge_finish(&cmap->map.memory);
 free_cmap:
 	kfree(cmap);
 	return ERR_PTR(err);
--=20
2.26.2

