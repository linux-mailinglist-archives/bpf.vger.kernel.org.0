Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339C9233ACE
	for <lists+bpf@lfdr.de>; Thu, 30 Jul 2020 23:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731009AbgG3VZ4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jul 2020 17:25:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16862 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730683AbgG3VXU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 30 Jul 2020 17:23:20 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06ULGPn6004926
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2020 14:23:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=KUr+zN6Iu5IkBhu3TNr9+BwiVzX59F9gtcIDICCR294=;
 b=gaqpgGE+AnyO0dTESAdGzWDWW8teJiHxBlEEcc3rYHCntX+SzwkXs29ubWWOC6DXvN9h
 qmXaRRxdmO7VB4VPMULfjuKEY45H3xtXG0BQQpyyUbCAhHfwbEtZhyXOW91pAAG34ppL
 sGlK9Yni6HgtHSQ3dhIBBOn/z6uajikk6u8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32m4kxrfuf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2020 14:23:20 -0700
Received: from intmgw001.06.prn3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 30 Jul 2020 14:23:19 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id A909420B00A4; Thu, 30 Jul 2020 14:23:12 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1096.prn0.facebook.com
To:     <bpf@vger.kernel.org>
CC:     <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: prn0c01
Subject: [PATCH bpf-next v3 05/29] bpf: memcg-based memory accounting for cgroup storage maps
Date:   Thu, 30 Jul 2020 14:22:46 -0700
Message-ID: <20200730212310.2609108-6-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200730212310.2609108-1-guro@fb.com>
References: <20200730212310.2609108-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-30_15:2020-07-30,2020-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 suspectscore=13 mlxlogscore=999
 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0 bulkscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007300150
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Account memory used by cgroup storage maps including the percpu memory
for the percpu flavor of cgroup storage and map metadata.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 kernel/bpf/local_storage.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 571bb351ed3b..212d6dbbc39a 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -166,7 +166,8 @@ static int cgroup_storage_update_elem(struct bpf_map =
*map, void *key,
=20
 	new =3D kmalloc_node(sizeof(struct bpf_storage_buffer) +
 			   map->value_size,
-			   __GFP_ZERO | GFP_ATOMIC | __GFP_NOWARN,
+			   __GFP_ZERO | GFP_ATOMIC | __GFP_NOWARN |
+			   __GFP_ACCOUNT,
 			   map->numa_node);
 	if (!new)
 		return -ENOMEM;
@@ -313,7 +314,7 @@ static struct bpf_map *cgroup_storage_map_alloc(union=
 bpf_attr *attr)
 		return ERR_PTR(ret);
=20
 	map =3D kmalloc_node(sizeof(struct bpf_cgroup_storage_map),
-			   __GFP_ZERO | GFP_USER, numa_node);
+			   __GFP_ZERO | GFP_USER | __GFP_ACCOUNT, numa_node);
 	if (!map) {
 		bpf_map_charge_finish(&mem);
 		return ERR_PTR(-ENOMEM);
@@ -496,9 +497,9 @@ static size_t bpf_cgroup_storage_calculate_size(struc=
t bpf_map *map, u32 *pages)
 struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *pro=
g,
 					enum bpf_cgroup_storage_type stype)
 {
+	const gfp_t gfp =3D __GFP_ZERO | GFP_USER | __GFP_ACCOUNT;
 	struct bpf_cgroup_storage *storage;
 	struct bpf_map *map;
-	gfp_t flags;
 	size_t size;
 	u32 pages;
=20
@@ -511,20 +512,18 @@ struct bpf_cgroup_storage *bpf_cgroup_storage_alloc=
(struct bpf_prog *prog,
 	if (bpf_map_charge_memlock(map, pages))
 		return ERR_PTR(-EPERM);
=20
-	storage =3D kmalloc_node(sizeof(struct bpf_cgroup_storage),
-			       __GFP_ZERO | GFP_USER, map->numa_node);
+	storage =3D kmalloc_node(sizeof(struct bpf_cgroup_storage), gfp,
+			       map->numa_node);
 	if (!storage)
 		goto enomem;
=20
-	flags =3D __GFP_ZERO | GFP_USER;
-
 	if (stype =3D=3D BPF_CGROUP_STORAGE_SHARED) {
-		storage->buf =3D kmalloc_node(size, flags, map->numa_node);
+		storage->buf =3D kmalloc_node(size, gfp, map->numa_node);
 		if (!storage->buf)
 			goto enomem;
 		check_and_init_map_lock(map, storage->buf->data);
 	} else {
-		storage->percpu_buf =3D __alloc_percpu_gfp(size, 8, flags);
+		storage->percpu_buf =3D __alloc_percpu_gfp(size, 8, gfp);
 		if (!storage->percpu_buf)
 			goto enomem;
 	}
--=20
2.26.2

