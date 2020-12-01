Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7904A2CAF9D
	for <lists+bpf@lfdr.de>; Tue,  1 Dec 2020 23:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388702AbgLAWCX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Dec 2020 17:02:23 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50766 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388715AbgLAV7y (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 1 Dec 2020 16:59:54 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B1LnWeY024474
        for <bpf@vger.kernel.org>; Tue, 1 Dec 2020 13:59:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=vpDcEf/JJvRZxIrpS63yw45HzaRIsnPZAAMiPKovRvA=;
 b=MXpgIvPNTJJmgzWaLepxLa5XqAjg08WW80ShNl2jyAf8Nfuq2dnsIxE1s76CwX7WFZ0D
 1ERp2LwbSFGAOXGrz20TNYKMpxrpRNmaz8UtLhGH82+Lm2rY0tlbsGJsX+q5Pd1Xsg0L
 sb4DbYYBbwu0jITMIvMLRu9yhGHM0qdBvII= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 353uh50v0a-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 01 Dec 2020 13:59:12 -0800
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 1 Dec 2020 13:59:08 -0800
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 6278019702AE; Tue,  1 Dec 2020 13:59:06 -0800 (PST)
From:   Roman Gushchin <guro@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <andrii@kernel.org>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next v9 08/34] bpf: refine memcg-based memory accounting for arraymap maps
Date:   Tue, 1 Dec 2020 13:58:34 -0800
Message-ID: <20201201215900.3569844-9-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201201215900.3569844-1-guro@fb.com>
References: <20201201215900.3569844-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_11:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=38
 priorityscore=1501 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 mlxlogscore=808 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012010131
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Include percpu arrays and auxiliary data into the memcg-based memory
accounting.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 kernel/bpf/arraymap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index c6c81eceb68f..d837e0603c89 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -34,8 +34,8 @@ static int bpf_array_alloc_percpu(struct bpf_array *arr=
ay)
 	int i;
=20
 	for (i =3D 0; i < array->map.max_entries; i++) {
-		ptr =3D __alloc_percpu_gfp(array->elem_size, 8,
-					 GFP_USER | __GFP_NOWARN);
+		ptr =3D bpf_map_alloc_percpu(&array->map, array->elem_size, 8,
+					   GFP_USER | __GFP_NOWARN);
 		if (!ptr) {
 			bpf_array_free_percpu(array);
 			return -ENOMEM;
@@ -1018,7 +1018,7 @@ static struct bpf_map *prog_array_map_alloc(union b=
pf_attr *attr)
 	struct bpf_array_aux *aux;
 	struct bpf_map *map;
=20
-	aux =3D kzalloc(sizeof(*aux), GFP_KERNEL);
+	aux =3D kzalloc(sizeof(*aux), GFP_KERNEL_ACCOUNT);
 	if (!aux)
 		return ERR_PTR(-ENOMEM);
=20
--=20
2.26.2

