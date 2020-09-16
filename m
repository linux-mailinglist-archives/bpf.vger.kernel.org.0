Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10F926BC71
	for <lists+bpf@lfdr.de>; Wed, 16 Sep 2020 08:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgIPGRC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Sep 2020 02:17:02 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:16644 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726068AbgIPGRC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 16 Sep 2020 02:17:02 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08G6Ftlu005580
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2020 23:17:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=JY0NNgdDRlKwmkar2R9QZMbHFK6LkFXvQiizy9IRnpE=;
 b=Ff7lvtg5CgqWjAnIO6Gl5Ro2h0Th182W4NROdnBnZ9tWreVBeziMACZnSilDN34GkONR
 bDBLiAgtefmKcFmOKKah4FBy/4+s1NwRivRZhOOEueBXj0XEvsilBaPRexUZwktPG4Lb
 /NB19H/rBDKdIjomSroWmOkSbYReQl67czI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33k5pehw17-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2020 23:17:01 -0700
Received: from intmgw003.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 15 Sep 2020 23:16:54 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id AD48A3704CB8; Tue, 15 Sep 2020 23:16:49 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH bpf-next v3] bpf: using rcu_read_lock for bpf_sk_storage_map iterator
Date:   Tue, 15 Sep 2020 23:16:49 -0700
Message-ID: <20200916061649.1437414-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-16_02:2020-09-15,2020-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=846 suspectscore=9 impostorscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009160046
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If a bucket contains a lot of sockets, during bpf_iter traversing
a bucket, concurrent userspace bpf_map_update_elem() and
bpf program bpf_sk_storage_{get,delete}() may experience
some undesirable delays as they will compete with bpf_iter
for bucket lock.

Note that the number of buckets for bpf_sk_storage_map
is roughly the same as the number of cpus. So if there
are lots of sockets in the system, each bucket could
contain lots of sockets.

Different actual use cases may experience different delays.
Here, using selftest bpf_iter subtest bpf_sk_storage_map,
I hacked the kernel with ktime_get_mono_fast_ns()
to collect the time when a bucket was locked
during bpf_iter prog traversing that bucket. This way,
the maximum incurred delay was measured w.r.t. the
number of elements in a bucket.
    # elems in each bucket          delay(ns)
      64                            17000
      256                           72512
      2048                          875246

The potential delays will be further increased if
we have even more elemnts in a bucket. Using rcu_read_lock()
is a reasonable compromise here. It may lose some precision, e.g.,
access stale sockets, but it will not hurt performance of
bpf program or user space application which also tries
to get/delete or update map elements.

Cc: Martin KaFai Lau <kafai@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 net/core/bpf_sk_storage.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

Changelog:
  v2 -> v3:
     - fix a bug hlist_for_each_entry() =3D> hlist_for_each_entry_rcu(). =
(Martin)
     - use rcu_dereference() instead of rcu_dereference_raw() for lockdep=
 checking. (Martin)
  v1 -> v2:
    - added some performance number. (Song)
    - tried to silence some sparse complains. but still has some left lik=
e
        context imbalance in "..." - different lock contexts for basic bl=
ock
      which the code is too hard for sparse to analyze. (Jakub)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 4a86ea34f29e..d43c3d6d0693 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -678,6 +678,7 @@ struct bpf_iter_seq_sk_storage_map_info {
 static struct bpf_local_storage_elem *
 bpf_sk_storage_map_seq_find_next(struct bpf_iter_seq_sk_storage_map_info=
 *info,
 				 struct bpf_local_storage_elem *prev_selem)
+	__acquires(RCU) __releases(RCU)
 {
 	struct bpf_local_storage *sk_storage;
 	struct bpf_local_storage_elem *selem;
@@ -701,11 +702,11 @@ bpf_sk_storage_map_seq_find_next(struct bpf_iter_se=
q_sk_storage_map_info *info,
 		if (!selem) {
 			/* not found, unlock and go to the next bucket */
 			b =3D &smap->buckets[bucket_id++];
-			raw_spin_unlock_bh(&b->lock);
+			rcu_read_unlock();
 			skip_elems =3D 0;
 			break;
 		}
-		sk_storage =3D rcu_dereference_raw(selem->local_storage);
+		sk_storage =3D rcu_dereference(selem->local_storage);
 		if (sk_storage) {
 			info->skip_elems =3D skip_elems + count;
 			return selem;
@@ -715,10 +716,10 @@ bpf_sk_storage_map_seq_find_next(struct bpf_iter_se=
q_sk_storage_map_info *info,
=20
 	for (i =3D bucket_id; i < (1U << smap->bucket_log); i++) {
 		b =3D &smap->buckets[i];
-		raw_spin_lock_bh(&b->lock);
+		rcu_read_lock();
 		count =3D 0;
-		hlist_for_each_entry(selem, &b->list, map_node) {
-			sk_storage =3D rcu_dereference_raw(selem->local_storage);
+		hlist_for_each_entry_rcu(selem, &b->list, map_node) {
+			sk_storage =3D rcu_dereference(selem->local_storage);
 			if (sk_storage && count >=3D skip_elems) {
 				info->bucket_id =3D i;
 				info->skip_elems =3D count;
@@ -726,7 +727,7 @@ bpf_sk_storage_map_seq_find_next(struct bpf_iter_seq_=
sk_storage_map_info *info,
 			}
 			count++;
 		}
-		raw_spin_unlock_bh(&b->lock);
+		rcu_read_unlock();
 		skip_elems =3D 0;
 	}
=20
@@ -785,7 +786,7 @@ static int __bpf_sk_storage_map_seq_show(struct seq_f=
ile *seq,
 		ctx.meta =3D &meta;
 		ctx.map =3D info->map;
 		if (selem) {
-			sk_storage =3D rcu_dereference_raw(selem->local_storage);
+			sk_storage =3D rcu_dereference(selem->local_storage);
 			ctx.sk =3D sk_storage->owner;
 			ctx.value =3D SDATA(selem)->data;
 		}
@@ -801,18 +802,12 @@ static int bpf_sk_storage_map_seq_show(struct seq_f=
ile *seq, void *v)
 }
=20
 static void bpf_sk_storage_map_seq_stop(struct seq_file *seq, void *v)
+	__releases(RCU)
 {
-	struct bpf_iter_seq_sk_storage_map_info *info =3D seq->private;
-	struct bpf_local_storage_map *smap;
-	struct bpf_local_storage_map_bucket *b;
-
-	if (!v) {
+	if (!v)
 		(void)__bpf_sk_storage_map_seq_show(seq, v);
-	} else {
-		smap =3D (struct bpf_local_storage_map *)info->map;
-		b =3D &smap->buckets[info->bucket_id];
-		raw_spin_unlock_bh(&b->lock);
-	}
+	else
+		rcu_read_unlock();
 }
=20
 static int bpf_iter_init_sk_storage_map(void *priv_data,
--=20
2.24.1

