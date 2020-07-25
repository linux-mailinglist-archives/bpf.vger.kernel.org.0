Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FA622D2D3
	for <lists+bpf@lfdr.de>; Sat, 25 Jul 2020 02:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgGYAGI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jul 2020 20:06:08 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63040 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727786AbgGYAEk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 Jul 2020 20:04:40 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06ONmpTp014008
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2020 17:04:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=O7wK7OpoLwEqV4eCalhKTu3CREJohf19fBj1cE/GZUA=;
 b=VqPGc+px0GdbybVwkEkpZTTUQoAsCYENGc+sGLFC4PnxtV9SVp7qSq4bi0w3mYii+Qqg
 QkiWJsMPPLTBHhljQ3cqPACUk/HYNcS+VvODDiWeXfBwahlwkkym6+wM0H+m4fxy6JnC
 5D5sdQkgIvfNpZodWY+5sz3Rnoj0gmbz1qo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32fh7kpdm7-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2020 17:04:40 -0700
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 24 Jul 2020 17:04:32 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id 1C0391B35A96; Fri, 24 Jul 2020 17:04:27 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1096.prn0.facebook.com
To:     <bpf@vger.kernel.org>
CC:     <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn0c01
Subject: [PATCH bpf-next 21/35] bpf: eliminate rlimit-based memory accounting for reuseport_array maps
Date:   Fri, 24 Jul 2020 17:03:56 -0700
Message-ID: <20200725000410.3566700-22-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200725000410.3566700-1-guro@fb.com>
References: <20200725000410.3566700-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-24_10:2020-07-24,2020-07-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 spamscore=0 mlxlogscore=782 adultscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=38 malwarescore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007240164
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Do not use rlimit-based memory accounting for reuseport_array maps.
It has been replaced with the memcg-based memory accounting.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 kernel/bpf/reuseport_array.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/reuseport_array.c b/kernel/bpf/reuseport_array.c
index 90b29c5b1da7..9d0161fdfec7 100644
--- a/kernel/bpf/reuseport_array.c
+++ b/kernel/bpf/reuseport_array.c
@@ -150,9 +150,8 @@ static void reuseport_array_free(struct bpf_map *map)
=20
 static struct bpf_map *reuseport_array_alloc(union bpf_attr *attr)
 {
-	int err, numa_node =3D bpf_map_attr_numa_node(attr);
+	int numa_node =3D bpf_map_attr_numa_node(attr);
 	struct reuseport_array *array;
-	struct bpf_map_memory mem;
 	u64 array_size;
=20
 	if (!bpf_capable())
@@ -161,20 +160,13 @@ static struct bpf_map *reuseport_array_alloc(union =
bpf_attr *attr)
 	array_size =3D sizeof(*array);
 	array_size +=3D (u64)attr->max_entries * sizeof(struct sock *);
=20
-	err =3D bpf_map_charge_init(&mem, array_size);
-	if (err)
-		return ERR_PTR(err);
-
 	/* allocate all map elements and zero-initialize them */
 	array =3D bpf_map_area_alloc(array_size, numa_node);
-	if (!array) {
-		bpf_map_charge_finish(&mem);
+	if (!array)
 		return ERR_PTR(-ENOMEM);
-	}
=20
 	/* copy mandatory map attributes */
 	bpf_map_init_from_attr(&array->map, attr);
-	bpf_map_charge_move(&array->map.memory, &mem);
=20
 	return &array->map;
 }
--=20
2.26.2

