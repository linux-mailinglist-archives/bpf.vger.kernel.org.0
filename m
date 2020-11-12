Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75172B11D3
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 23:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgKLWhg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 17:37:36 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56818 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727683AbgKLWgc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Nov 2020 17:36:32 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0ACMOArE007594
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 14:36:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ar3zhSQ7FL0n3uAoDgrGU596OIP5AB4Ydgi74H1c8dM=;
 b=HhS2ywCNDGA/QidTxeO/9R18B+49+5saq9+BSunEJWSl18/Zh8mUXBpA9u8+JXTJpRCW
 tB84LmXE4XEmFyGtarI0+75ojXk+b1KsDiMjeEbWGZ6GDwrzYc0vfm8v24o80+42itTW
 FQdIcYuSMNXY/FZOOAeBI7ILQmJZk3MqkHk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 34rva9drhy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 14:36:31 -0800
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 12 Nov 2020 14:36:30 -0800
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 08C1AA7D1FB; Thu, 12 Nov 2020 14:16:01 -0800 (PST)
From:   Roman Gushchin <guro@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        <netdev@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>, Song Liu <songliubraving@fb.com>
Subject: [PATCH bpf-next v5 12/34] bpf: refine memcg-based memory accounting for hashtab maps
Date:   Thu, 12 Nov 2020 14:15:21 -0800
Message-ID: <20201112221543.3621014-13-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201112221543.3621014-1-guro@fb.com>
References: <20201112221543.3621014-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-12_14:2020-11-12,2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=993
 malwarescore=0 clxscore=1015 spamscore=0 priorityscore=1501
 suspectscore=38 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011120127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Include percpu objects and the size of map metadata into the
accounting.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 kernel/bpf/hashtab.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 7bf18d92af41..a647263b87fa 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -289,10 +289,11 @@ static int prealloc_init(struct bpf_htab *htab)
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
@@ -347,7 +348,7 @@ static int alloc_extra_elems(struct bpf_htab *htab)
 	int cpu;
=20
 	pptr =3D __alloc_percpu_gfp(sizeof(struct htab_elem *), 8,
-				  GFP_USER | __GFP_NOWARN);
+				  GFP_USER | __GFP_NOWARN | __GFP_ACCOUNT);
 	if (!pptr)
 		return -ENOMEM;
=20
@@ -444,7 +445,7 @@ static struct bpf_map *htab_map_alloc(union bpf_attr =
*attr)
 	int err, i;
 	u64 cost;
=20
-	htab =3D kzalloc(sizeof(*htab), GFP_USER);
+	htab =3D kzalloc(sizeof(*htab), GFP_USER | __GFP_ACCOUNT);
 	if (!htab)
 		return ERR_PTR(-ENOMEM);
=20
@@ -866,6 +867,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_h=
tab *htab, void *key,
 					 bool percpu, bool onallcpus,
 					 struct htab_elem *old_elem)
 {
+	const gfp_t gfp =3D GFP_ATOMIC | __GFP_NOWARN | __GFP_ACCOUNT;
 	u32 size =3D htab->map.value_size;
 	bool prealloc =3D htab_is_prealloc(htab);
 	struct htab_elem *l_new, **pl_new;
@@ -899,8 +901,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_h=
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
@@ -916,8 +917,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_h=
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

