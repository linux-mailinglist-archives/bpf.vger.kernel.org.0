Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9C024401C
	for <lists+bpf@lfdr.de>; Thu, 13 Aug 2020 22:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgHMUul (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Aug 2020 16:50:41 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39268 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726669AbgHMUuk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 Aug 2020 16:50:40 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07DKmoId003286
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2020 13:50:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=L1/KeXujsHkqioj6VLgkViGteh/lMwdZqTKnC0KlOKc=;
 b=AFxcyUG8YLS7AtqTlHxauqF5OHrFV5Ik1qTaGa38ezCyTEZ0sI+8BMo/j7Z0lj35yHCP
 3XAYFwM2env4itIVue78BxoRkhrw3tew+axWOzJlWMK+7VDA0rMFHJ1BetN6TUZmUdvB
 B5new0zcg4RMVROoIfXraQf86yrijPlQdo0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32v0kfm2e2-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2020 13:50:38 -0700
Received: from intmgw001.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 13 Aug 2020 13:50:06 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 97C1A2EC597F; Thu, 13 Aug 2020 13:49:57 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 bpf 3/9] libbpf: fix BTF-defined map-in-map initialization on 32-bit host arches
Date:   Thu, 13 Aug 2020 13:49:39 -0700
Message-ID: <20200813204945.1020225-4-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200813204945.1020225-1-andriin@fb.com>
References: <20200813204945.1020225-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-13_17:2020-08-13,2020-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 adultscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 suspectscore=8 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008130148
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Libbpf built in 32-bit mode should be careful about not conflating 64-bit=
 BPF
pointers in BPF ELF file and host architecture pointers. This patch fixes
issue of incorrect initializating of map-in-map inner map slots due to su=
ch
difference.

Fixes: 646f02ffdd49 ("libbpf: Add BTF-defined map-in-map support")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0a06124f7999..4a8524b2dda1 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5194,7 +5194,8 @@ static int bpf_object__collect_st_ops_relos(struct =
bpf_object *obj,
 static int bpf_object__collect_map_relos(struct bpf_object *obj,
 					 GElf_Shdr *shdr, Elf_Data *data)
 {
-	int i, j, nrels, new_sz, ptr_sz =3D sizeof(void *);
+	const int bpf_ptr_sz =3D 8, host_ptr_sz =3D sizeof(void *);
+	int i, j, nrels, new_sz;
 	const struct btf_var_secinfo *vi =3D NULL;
 	const struct btf_type *sec, *var, *def;
 	const struct btf_member *member;
@@ -5243,7 +5244,7 @@ static int bpf_object__collect_map_relos(struct bpf=
_object *obj,
=20
 			vi =3D btf_var_secinfos(sec) + map->btf_var_idx;
 			if (vi->offset <=3D rel.r_offset &&
-			    rel.r_offset + sizeof(void *) <=3D vi->offset + vi->size)
+			    rel.r_offset + bpf_ptr_sz <=3D vi->offset + vi->size)
 				break;
 		}
 		if (j =3D=3D obj->nr_maps) {
@@ -5279,17 +5280,20 @@ static int bpf_object__collect_map_relos(struct b=
pf_object *obj,
 			return -EINVAL;
=20
 		moff =3D rel.r_offset - vi->offset - moff;
-		if (moff % ptr_sz)
+		/* here we use BPF pointer size, which is always 64 bit, as we
+		 * are parsing ELF that was built for BPF target
+		 */
+		if (moff % bpf_ptr_sz)
 			return -EINVAL;
-		moff /=3D ptr_sz;
+		moff /=3D bpf_ptr_sz;
 		if (moff >=3D map->init_slots_sz) {
 			new_sz =3D moff + 1;
-			tmp =3D realloc(map->init_slots, new_sz * ptr_sz);
+			tmp =3D realloc(map->init_slots, new_sz * host_ptr_sz);
 			if (!tmp)
 				return -ENOMEM;
 			map->init_slots =3D tmp;
 			memset(map->init_slots + map->init_slots_sz, 0,
-			       (new_sz - map->init_slots_sz) * ptr_sz);
+			       (new_sz - map->init_slots_sz) * host_ptr_sz);
 			map->init_slots_sz =3D new_sz;
 		}
 		map->init_slots[moff] =3D targ_map;
--=20
2.24.1

