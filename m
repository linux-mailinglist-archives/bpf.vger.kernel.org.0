Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18482B11EB
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 23:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgKLWlc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 17:41:32 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5680 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725973AbgKLWlc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Nov 2020 17:41:32 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ACMdr4R031339
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 14:41:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=qdqw2vIRlP2yIbod8BHIh3XnNn0ZSs325Y5RG0+0/sU=;
 b=ZDxS4PiCSqwJP1HC8hlAILqAfzFNUFaN5QGFuHHNkdP+ZRLrUWfaHka0w8VgP4SjW9yn
 Z4NNzWrt5cFapTCpiV0LcdJ75fAdax/bbiiJCTmgUba9vubqRSDZE5NSeZKAiWTfWauw
 4fk1xMyv+L/hyXZWa4RjBIMNFc8pe54euwo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34s7crjr29-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 14:41:31 -0800
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 12 Nov 2020 14:41:28 -0800
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 52C76A7D234; Thu, 12 Nov 2020 14:16:01 -0800 (PST)
From:   Roman Gushchin <guro@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        <netdev@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>, Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH bpf-next v5 27/34] bpf: eliminate rlimit-based memory accounting for bpf ringbuffer
Date:   Thu, 12 Nov 2020 14:15:36 -0800
Message-ID: <20201112221543.3621014-28-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201112221543.3621014-1-guro@fb.com>
References: <20201112221543.3621014-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-12_14:2020-11-12,2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 mlxlogscore=717 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 suspectscore=38 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011120128
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Do not use rlimit-based memory accounting for bpf ringbuffer.
It has been replaced with the memcg-based memory accounting.

bpf_ringbuf_alloc() can't return anything except ERR_PTR(-ENOMEM)
and a valid pointer, so to simplify the code make it return NULL
in the first case. This allows to drop a couple of lines in
ringbuf_map_alloc() and also makes it look similar to other memory
allocating function like kmalloc().

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 kernel/bpf/ringbuf.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index ee5f55d9276e..c8892b58501e 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -48,7 +48,6 @@ struct bpf_ringbuf {
=20
 struct bpf_ringbuf_map {
 	struct bpf_map map;
-	struct bpf_map_memory memory;
 	struct bpf_ringbuf *rb;
 };
=20
@@ -135,7 +134,7 @@ static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t d=
ata_sz, int numa_node)
=20
 	rb =3D bpf_ringbuf_area_alloc(data_sz, numa_node);
 	if (!rb)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
=20
 	spin_lock_init(&rb->spinlock);
 	init_waitqueue_head(&rb->waitq);
@@ -151,8 +150,6 @@ static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t d=
ata_sz, int numa_node)
 static struct bpf_map *ringbuf_map_alloc(union bpf_attr *attr)
 {
 	struct bpf_ringbuf_map *rb_map;
-	u64 cost;
-	int err;
=20
 	if (attr->map_flags & ~RINGBUF_CREATE_FLAG_MASK)
 		return ERR_PTR(-EINVAL);
@@ -174,26 +171,13 @@ static struct bpf_map *ringbuf_map_alloc(union bpf_=
attr *attr)
=20
 	bpf_map_init_from_attr(&rb_map->map, attr);
=20
-	cost =3D sizeof(struct bpf_ringbuf_map) +
-	       sizeof(struct bpf_ringbuf) +
-	       attr->max_entries;
-	err =3D bpf_map_charge_init(&rb_map->map.memory, cost);
-	if (err)
-		goto err_free_map;
-
 	rb_map->rb =3D bpf_ringbuf_alloc(attr->max_entries, rb_map->map.numa_no=
de);
-	if (IS_ERR(rb_map->rb)) {
-		err =3D PTR_ERR(rb_map->rb);
-		goto err_uncharge;
+	if (!rb_map->rb) {
+		kfree(rb_map);
+		return ERR_PTR(-ENOMEM);
 	}
=20
 	return &rb_map->map;
-
-err_uncharge:
-	bpf_map_charge_finish(&rb_map->map.memory);
-err_free_map:
-	kfree(rb_map);
-	return ERR_PTR(err);
 }
=20
 static void bpf_ringbuf_free(struct bpf_ringbuf *rb)
--=20
2.26.2

