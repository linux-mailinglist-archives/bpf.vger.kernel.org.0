Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF9F22D2A8
	for <lists+bpf@lfdr.de>; Sat, 25 Jul 2020 02:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgGYAEt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jul 2020 20:04:49 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47634 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727922AbgGYAEr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 Jul 2020 20:04:47 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06ONkkuP031620
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2020 17:04:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=FZ1DOw1vo++OQPipKOASN/39lL70IFORFCBolHWaCPQ=;
 b=BDVYwQm5UHXunptHfJrM7FWE14d8FMh/zWWxS0M0tSEBpu7NsH0Qgzhvs71QUbSdwIYu
 uL3o4fcs6ccbULKDEJjxqOrvCot8Vn/wq+JEqio2kHBxU53eYyNNVzLU1m4U+ytJIIzA
 oqYvzJZ8lyKE0AMYhzJw3s+mFKae9okXo8U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32etmwm9f4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2020 17:04:47 -0700
Received: from intmgw001.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 24 Jul 2020 17:04:39 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id 212B71B35A98; Fri, 24 Jul 2020 17:04:27 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1096.prn0.facebook.com
To:     <bpf@vger.kernel.org>
CC:     <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn0c01
Subject: [PATCH bpf-next 22/35] bpf: eliminate rlimit-based memory accounting for bpf ringbuffer
Date:   Fri, 24 Jul 2020 17:03:57 -0700
Message-ID: <20200725000410.3566700-23-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200725000410.3566700-1-guro@fb.com>
References: <20200725000410.3566700-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-24_10:2020-07-24,2020-07-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=38 bulkscore=0 spamscore=0 clxscore=1015 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=887 priorityscore=1501
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007240164
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
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
---
 kernel/bpf/ringbuf.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index e8e2c39cbdc9..e687b798d097 100644
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

