Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DAB233AD9
	for <lists+bpf@lfdr.de>; Thu, 30 Jul 2020 23:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbgG3V0c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jul 2020 17:26:32 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:15208 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730627AbgG3VXQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 30 Jul 2020 17:23:16 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06ULGPh6004912
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2020 14:23:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=jvMhr6xjLlXo5Mo32W9tvDfiPRfeAVJSR18fyxbz+Gw=;
 b=igYouFMyjkzAwV7UstGP+H7Y2alihUFzHQmXv5TKA72PkW4Vo7cmQt97IJPDxv0Wq8+/
 OdOIRHsxuX0LKgluDhXBIwyVjuQ0iUOKGxOgUu+nJNIEVOpf8ZzPoCETWlqPA0zmfpz3
 39zVNq1oSlhlTHgymdOcFujoPlb4ZgYmC6E= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32m4kxrfu5-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2020 14:23:15 -0700
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 30 Jul 2020 14:23:15 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id B209520B00A8; Thu, 30 Jul 2020 14:23:12 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1096.prn0.facebook.com
To:     <bpf@vger.kernel.org>
CC:     <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: prn0c01
Subject: [PATCH bpf-next v3 07/29] bpf: refine memcg-based memory accounting for hashtab maps
Date:   Thu, 30 Jul 2020 14:22:48 -0700
Message-ID: <20200730212310.2609108-8-guro@fb.com>
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
 priorityscore=1501 lowpriorityscore=0 suspectscore=38 mlxlogscore=876
 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0 bulkscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007300150
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
index 024276787055..9d0432170812 100644
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
@@ -827,6 +828,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_h=
tab *htab, void *key,
 					 bool percpu, bool onallcpus,
 					 struct htab_elem *old_elem)
 {
+	const gfp_t gfp =3D GFP_ATOMIC | __GFP_NOWARN | __GFP_ACCOUNT;
 	u32 size =3D htab->map.value_size;
 	bool prealloc =3D htab_is_prealloc(htab);
 	struct htab_elem *l_new, **pl_new;
@@ -859,8 +861,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_h=
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
@@ -876,8 +877,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_h=
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

