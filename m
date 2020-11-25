Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8F22C3728
	for <lists+bpf@lfdr.de>; Wed, 25 Nov 2020 04:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgKYDBj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Nov 2020 22:01:39 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21968 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727818AbgKYDBi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 24 Nov 2020 22:01:38 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AP31Ubg018043
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2020 19:01:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=FTQq/5NXbfrVFGS1vrBKXa2fxufaWSoHB98RAMt+6e0=;
 b=qJK2JpaaT1LELyMxr6aQbPw3I53hWI9Eg/GZ4YJpY1r4y8NSRgMEPvrL5kEBHqYV6j+K
 4QoQzFgITuMYZf/Pj7ITSHPuOLbqTMIjV9hEHzdM3FVE5xAD0FjlPPZgirniSFoY7EYv
 B8GhBaCmU/idysuTgB3QQR0r5AxVrGB5IBw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 350qy4wcy4-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2020 19:01:38 -0800
Received: from intmgw001.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 24 Nov 2020 19:01:32 -0800
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 12E7216A1893; Tue, 24 Nov 2020 19:01:22 -0800 (PST)
From:   Roman Gushchin <guro@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <andrii@kernel.org>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next v8 09/34] bpf: refine memcg-based memory accounting for cpumap maps
Date:   Tue, 24 Nov 2020 19:00:54 -0800
Message-ID: <20201125030119.2864302-10-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201125030119.2864302-1-guro@fb.com>
References: <20201125030119.2864302-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_11:2020-11-24,2020-11-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 impostorscore=0 suspectscore=38
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=977
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011250019
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Include metadata and percpu data into the memcg-based memory
accounting. Switch allocations made from an update path to
new bpf_map_* allocation helpers to make the accounting work
properly from an interrupt context.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 kernel/bpf/cpumap.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index c61a23b564aa..e6b234d5e3a8 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -97,7 +97,7 @@ static struct bpf_map *cpu_map_alloc(union bpf_attr *at=
tr)
 	    attr->map_flags & ~BPF_F_NUMA_NODE)
 		return ERR_PTR(-EINVAL);
=20
-	cmap =3D kzalloc(sizeof(*cmap), GFP_USER);
+	cmap =3D kzalloc(sizeof(*cmap), GFP_USER | __GFP_ACCOUNT);
 	if (!cmap)
 		return ERR_PTR(-ENOMEM);
=20
@@ -412,23 +412,24 @@ static int __cpu_map_load_bpf_program(struct bpf_cp=
u_map_entry *rcpu, int fd)
 }
=20
 static struct bpf_cpu_map_entry *
-__cpu_map_entry_alloc(struct bpf_cpumap_val *value, u32 cpu, int map_id)
+__cpu_map_entry_alloc(struct bpf_map *map, struct bpf_cpumap_val *value,
+		      u32 cpu)
 {
 	int numa, err, i, fd =3D value->bpf_prog.fd;
-	gfp_t gfp =3D GFP_KERNEL | __GFP_NOWARN;
+	gfp_t gfp =3D __GFP_ZERO | GFP_KERNEL_ACCOUNT | __GFP_NOWARN;
 	struct bpf_cpu_map_entry *rcpu;
 	struct xdp_bulk_queue *bq;
=20
 	/* Have map->numa_node, but choose node of redirect target CPU */
 	numa =3D cpu_to_node(cpu);
=20
-	rcpu =3D kzalloc_node(sizeof(*rcpu), gfp, numa);
+	rcpu =3D bpf_map_kmalloc_node(map, sizeof(*rcpu), gfp, numa);
 	if (!rcpu)
 		return NULL;
=20
 	/* Alloc percpu bulkq */
-	rcpu->bulkq =3D __alloc_percpu_gfp(sizeof(*rcpu->bulkq),
-					 sizeof(void *), gfp);
+	rcpu->bulkq =3D bpf_map_alloc_percpu(map, sizeof(*rcpu->bulkq),
+					   sizeof(void *), gfp);
 	if (!rcpu->bulkq)
 		goto free_rcu;
=20
@@ -438,7 +439,8 @@ __cpu_map_entry_alloc(struct bpf_cpumap_val *value, u=
32 cpu, int map_id)
 	}
=20
 	/* Alloc queue */
-	rcpu->queue =3D kzalloc_node(sizeof(*rcpu->queue), gfp, numa);
+	rcpu->queue =3D bpf_map_kmalloc_node(map, sizeof(*rcpu->queue), gfp,
+					   numa);
 	if (!rcpu->queue)
 		goto free_bulkq;
=20
@@ -447,7 +449,7 @@ __cpu_map_entry_alloc(struct bpf_cpumap_val *value, u=
32 cpu, int map_id)
 		goto free_queue;
=20
 	rcpu->cpu    =3D cpu;
-	rcpu->map_id =3D map_id;
+	rcpu->map_id =3D map->id;
 	rcpu->value.qsize  =3D value->qsize;
=20
 	if (fd > 0 && __cpu_map_load_bpf_program(rcpu, fd))
@@ -455,7 +457,8 @@ __cpu_map_entry_alloc(struct bpf_cpumap_val *value, u=
32 cpu, int map_id)
=20
 	/* Setup kthread */
 	rcpu->kthread =3D kthread_create_on_node(cpu_map_kthread_run, rcpu, num=
a,
-					       "cpumap/%d/map:%d", cpu, map_id);
+					       "cpumap/%d/map:%d", cpu,
+					       map->id);
 	if (IS_ERR(rcpu->kthread))
 		goto free_prog;
=20
@@ -571,7 +574,7 @@ static int cpu_map_update_elem(struct bpf_map *map, v=
oid *key, void *value,
 		rcpu =3D NULL; /* Same as deleting */
 	} else {
 		/* Updating qsize cause re-allocation of bpf_cpu_map_entry */
-		rcpu =3D __cpu_map_entry_alloc(&cpumap_value, key_cpu, map->id);
+		rcpu =3D __cpu_map_entry_alloc(map, &cpumap_value, key_cpu);
 		if (!rcpu)
 			return -ENOMEM;
 		rcpu->cmap =3D cmap;
--=20
2.26.2

