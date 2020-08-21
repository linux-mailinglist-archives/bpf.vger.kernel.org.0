Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF1024D871
	for <lists+bpf@lfdr.de>; Fri, 21 Aug 2020 17:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgHUPXr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Aug 2020 11:23:47 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:4768 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726610AbgHUPXm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 21 Aug 2020 11:23:42 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07LFBWmS020193
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 08:23:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=bZ3gFhifFPKh0v44UnCu57b0VOq/AyyH71v7Qo3on+A=;
 b=AdSil3531sqPjBSPeDYtC9OdSsF1xpufQkg66UYYSAuqr/BjYlkvs82oQtYP5RbkCd16
 PXEe6KOHOCiMRql7W1sPGpVx/1QTgbl6hsrMD3aYjpJcsCdIWfVJqQHy5ckW3529lgft
 e94rPT7B+9ShZ+YwwCU18W0zg/e4rL8N/R4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3304p3w81e-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 08:23:41 -0700
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 21 Aug 2020 08:23:41 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id 4DBB03441055; Fri, 21 Aug 2020 08:01:35 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 08/30] bpf: refine memcg-based memory accounting for hashtab maps
Date:   Fri, 21 Aug 2020 08:01:12 -0700
Message-ID: <20200821150134.2581465-9-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200821150134.2581465-1-guro@fb.com>
References: <20200821150134.2581465-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-21_08:2020-08-21,2020-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=846
 spamscore=0 mlxscore=0 clxscore=1015 suspectscore=38 adultscore=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008210143
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Include percpu objects and the size of map metadata into the
accounting.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 kernel/bpf/hashtab.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 78dfff6a501b..c2651cbce516 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -263,10 +263,11 @@ static int prealloc_init(struct bpf_htab *htab)
 		goto skip_percpu_elems;
=20
 	for (i =3D 0; i < num_entries; i++) {
+		const gfp_t gfp =3D GFP_USER | __GFP_NOWARN | __GFP_ACCOUNT;
 		u32 size =3D round_up(htab->map.value_size, 8);
 		void __percpu *pptr;
=20
-		pptr =3D __alloc_percpu_gfp(size, 8, GFP_USER | __GFP_NOWARN);
+		pptr =3D __alloc_percpu_gfp(size, 8, gfp);
 		if (!pptr)
 			goto free_elems;
 		htab_elem_set_ptr(get_htab_elem(htab, i), htab->map.key_size,
@@ -321,7 +322,7 @@ static int alloc_extra_elems(struct bpf_htab *htab)
 	int cpu;
=20
 	pptr =3D __alloc_percpu_gfp(sizeof(struct htab_elem *), 8,
-				  GFP_USER | __GFP_NOWARN);
+				  GFP_USER | __GFP_NOWARN | __GFP_ACCOUNT);
 	if (!pptr)
 		return -ENOMEM;
=20
@@ -424,7 +425,7 @@ static struct bpf_map *htab_map_alloc(union bpf_attr =
*attr)
 	u64 cost;
 	int err;
=20
-	htab =3D kzalloc(sizeof(*htab), GFP_USER);
+	htab =3D kzalloc(sizeof(*htab), GFP_USER | __GFP_ACCOUNT);
 	if (!htab)
 		return ERR_PTR(-ENOMEM);
=20
@@ -832,6 +833,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_h=
tab *htab, void *key,
 					 bool percpu, bool onallcpus,
 					 struct htab_elem *old_elem)
 {
+	const gfp_t gfp =3D GFP_ATOMIC | __GFP_NOWARN | __GFP_ACCOUNT;
 	u32 size =3D htab->map.value_size;
 	bool prealloc =3D htab_is_prealloc(htab);
 	struct htab_elem *l_new, **pl_new;
@@ -865,8 +867,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_h=
tab *htab, void *key,
 				l_new =3D ERR_PTR(-E2BIG);
 				goto dec_count;
 			}
-		l_new =3D kmalloc_node(htab->elem_size, GFP_ATOMIC | __GFP_NOWARN,
-				     htab->map.numa_node);
+		l_new =3D kmalloc_node(htab->elem_size, gfp, htab->map.numa_node);
 		if (!l_new) {
 			l_new =3D ERR_PTR(-ENOMEM);
 			goto dec_count;
@@ -882,8 +883,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_h=
tab *htab, void *key,
 			pptr =3D htab_elem_get_ptr(l_new, key_size);
 		} else {
 			/* alloc_percpu zero-fills */
-			pptr =3D __alloc_percpu_gfp(size, 8,
-						  GFP_ATOMIC | __GFP_NOWARN);
+			pptr =3D __alloc_percpu_gfp(size, 8, gfp);
 			if (!pptr) {
 				kfree(l_new);
 				l_new =3D ERR_PTR(-ENOMEM);
--=20
2.26.2

