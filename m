Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84AEB201CED
	for <lists+bpf@lfdr.de>; Fri, 19 Jun 2020 23:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392236AbgFSVMT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Jun 2020 17:12:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:3886 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392356AbgFSVMR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Jun 2020 17:12:17 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05JL0CnX025888
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 14:12:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=n6Hw8nx44dKDhyCd/IhMe7TlCZEPdSojk7hBQFHV5WA=;
 b=AuyH/hpwOej9syLGoTODqJs1/k/PBBMamln7BtvIPW+JMTMynEkpusnWE47JQBejCklU
 SnT3Uhd6u0ZkgJ3O+z65FiTLpZ/QQcfyrUzeO4zBPDJyV1mYQRFvNeetnlRUCKHYypVL
 e/vH5asw97mh1gghPqqDgCX8Ha8dQH9Xgyw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31rwgsbhkr-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 14:12:15 -0700
Received: from intmgw002.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 19 Jun 2020 14:12:14 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id DB2363700BAE; Fri, 19 Jun 2020 14:12:11 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kafai@fb.com>, <andriin@fb.com>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 bpf-next 2/5] bpf: Rename bpf_htab to bpf_shtab in sock_map
Date:   Fri, 19 Jun 2020 14:11:42 -0700
Message-ID: <c006a639e03c64ca50fc87c4bb627e0bfba90f4e.1592600985.git.rdna@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1592600985.git.rdna@fb.com>
References: <cover.1592600985.git.rdna@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_22:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 cotscore=-2147483648 spamscore=0 suspectscore=38 clxscore=1015 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 adultscore=0 mlxlogscore=726 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190150
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There are two different `struct bpf_htab` in bpf code in the following
files:
- kernel/bpf/hashtab.c
- net/core/sock_map.c

It makes it impossible to find proper btf_id by name =3D "bpf_htab" and
kind =3D BTF_KIND_STRUCT what is needed to support access to map ptr so
that bpf program can access `struct bpf_htab` fields.

To make it possible one of the struct-s should be renamed, sock_map.c
looks like a better candidate for rename since it's specialized version
of hashtab.

Rename it to bpf_shtab ("sh" stands for Sock Hash).

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 net/core/sock_map.c | 82 ++++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 4059f94e9bb5..2b884f2d562a 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -655,7 +655,7 @@ const struct bpf_map_ops sock_map_ops =3D {
 	.map_check_btf		=3D map_check_no_btf,
 };
=20
-struct bpf_htab_elem {
+struct bpf_shtab_elem {
 	struct rcu_head rcu;
 	u32 hash;
 	struct sock *sk;
@@ -663,14 +663,14 @@ struct bpf_htab_elem {
 	u8 key[];
 };
=20
-struct bpf_htab_bucket {
+struct bpf_shtab_bucket {
 	struct hlist_head head;
 	raw_spinlock_t lock;
 };
=20
-struct bpf_htab {
+struct bpf_shtab {
 	struct bpf_map map;
-	struct bpf_htab_bucket *buckets;
+	struct bpf_shtab_bucket *buckets;
 	u32 buckets_num;
 	u32 elem_size;
 	struct sk_psock_progs progs;
@@ -682,17 +682,17 @@ static inline u32 sock_hash_bucket_hash(const void =
*key, u32 len)
 	return jhash(key, len, 0);
 }
=20
-static struct bpf_htab_bucket *sock_hash_select_bucket(struct bpf_htab *=
htab,
-						       u32 hash)
+static struct bpf_shtab_bucket *sock_hash_select_bucket(struct bpf_shtab=
 *htab,
+							u32 hash)
 {
 	return &htab->buckets[hash & (htab->buckets_num - 1)];
 }
=20
-static struct bpf_htab_elem *
+static struct bpf_shtab_elem *
 sock_hash_lookup_elem_raw(struct hlist_head *head, u32 hash, void *key,
 			  u32 key_size)
 {
-	struct bpf_htab_elem *elem;
+	struct bpf_shtab_elem *elem;
=20
 	hlist_for_each_entry_rcu(elem, head, node) {
 		if (elem->hash =3D=3D hash &&
@@ -705,10 +705,10 @@ sock_hash_lookup_elem_raw(struct hlist_head *head, =
u32 hash, void *key,
=20
 static struct sock *__sock_hash_lookup_elem(struct bpf_map *map, void *k=
ey)
 {
-	struct bpf_htab *htab =3D container_of(map, struct bpf_htab, map);
+	struct bpf_shtab *htab =3D container_of(map, struct bpf_shtab, map);
 	u32 key_size =3D map->key_size, hash;
-	struct bpf_htab_bucket *bucket;
-	struct bpf_htab_elem *elem;
+	struct bpf_shtab_bucket *bucket;
+	struct bpf_shtab_elem *elem;
=20
 	WARN_ON_ONCE(!rcu_read_lock_held());
=20
@@ -719,8 +719,8 @@ static struct sock *__sock_hash_lookup_elem(struct bp=
f_map *map, void *key)
 	return elem ? elem->sk : NULL;
 }
=20
-static void sock_hash_free_elem(struct bpf_htab *htab,
-				struct bpf_htab_elem *elem)
+static void sock_hash_free_elem(struct bpf_shtab *htab,
+				struct bpf_shtab_elem *elem)
 {
 	atomic_dec(&htab->count);
 	kfree_rcu(elem, rcu);
@@ -729,9 +729,9 @@ static void sock_hash_free_elem(struct bpf_htab *htab=
,
 static void sock_hash_delete_from_link(struct bpf_map *map, struct sock =
*sk,
 				       void *link_raw)
 {
-	struct bpf_htab *htab =3D container_of(map, struct bpf_htab, map);
-	struct bpf_htab_elem *elem_probe, *elem =3D link_raw;
-	struct bpf_htab_bucket *bucket;
+	struct bpf_shtab *htab =3D container_of(map, struct bpf_shtab, map);
+	struct bpf_shtab_elem *elem_probe, *elem =3D link_raw;
+	struct bpf_shtab_bucket *bucket;
=20
 	WARN_ON_ONCE(!rcu_read_lock_held());
 	bucket =3D sock_hash_select_bucket(htab, elem->hash);
@@ -753,10 +753,10 @@ static void sock_hash_delete_from_link(struct bpf_m=
ap *map, struct sock *sk,
=20
 static int sock_hash_delete_elem(struct bpf_map *map, void *key)
 {
-	struct bpf_htab *htab =3D container_of(map, struct bpf_htab, map);
+	struct bpf_shtab *htab =3D container_of(map, struct bpf_shtab, map);
 	u32 hash, key_size =3D map->key_size;
-	struct bpf_htab_bucket *bucket;
-	struct bpf_htab_elem *elem;
+	struct bpf_shtab_bucket *bucket;
+	struct bpf_shtab_elem *elem;
 	int ret =3D -ENOENT;
=20
 	hash =3D sock_hash_bucket_hash(key, key_size);
@@ -774,12 +774,12 @@ static int sock_hash_delete_elem(struct bpf_map *ma=
p, void *key)
 	return ret;
 }
=20
-static struct bpf_htab_elem *sock_hash_alloc_elem(struct bpf_htab *htab,
-						  void *key, u32 key_size,
-						  u32 hash, struct sock *sk,
-						  struct bpf_htab_elem *old)
+static struct bpf_shtab_elem *sock_hash_alloc_elem(struct bpf_shtab *hta=
b,
+						   void *key, u32 key_size,
+						   u32 hash, struct sock *sk,
+						   struct bpf_shtab_elem *old)
 {
-	struct bpf_htab_elem *new;
+	struct bpf_shtab_elem *new;
=20
 	if (atomic_inc_return(&htab->count) > htab->map.max_entries) {
 		if (!old) {
@@ -803,10 +803,10 @@ static struct bpf_htab_elem *sock_hash_alloc_elem(s=
truct bpf_htab *htab,
 static int sock_hash_update_common(struct bpf_map *map, void *key,
 				   struct sock *sk, u64 flags)
 {
-	struct bpf_htab *htab =3D container_of(map, struct bpf_htab, map);
+	struct bpf_shtab *htab =3D container_of(map, struct bpf_shtab, map);
 	u32 key_size =3D map->key_size, hash;
-	struct bpf_htab_elem *elem, *elem_new;
-	struct bpf_htab_bucket *bucket;
+	struct bpf_shtab_elem *elem, *elem_new;
+	struct bpf_shtab_bucket *bucket;
 	struct sk_psock_link *link;
 	struct sk_psock *psock;
 	int ret;
@@ -916,8 +916,8 @@ static int sock_hash_update_elem(struct bpf_map *map,=
 void *key,
 static int sock_hash_get_next_key(struct bpf_map *map, void *key,
 				  void *key_next)
 {
-	struct bpf_htab *htab =3D container_of(map, struct bpf_htab, map);
-	struct bpf_htab_elem *elem, *elem_next;
+	struct bpf_shtab *htab =3D container_of(map, struct bpf_shtab, map);
+	struct bpf_shtab_elem *elem, *elem_next;
 	u32 hash, key_size =3D map->key_size;
 	struct hlist_head *head;
 	int i =3D 0;
@@ -931,7 +931,7 @@ static int sock_hash_get_next_key(struct bpf_map *map=
, void *key,
 		goto find_first_elem;
=20
 	elem_next =3D hlist_entry_safe(rcu_dereference_raw(hlist_next_rcu(&elem=
->node)),
-				     struct bpf_htab_elem, node);
+				     struct bpf_shtab_elem, node);
 	if (elem_next) {
 		memcpy(key_next, elem_next->key, key_size);
 		return 0;
@@ -943,7 +943,7 @@ static int sock_hash_get_next_key(struct bpf_map *map=
, void *key,
 	for (; i < htab->buckets_num; i++) {
 		head =3D &sock_hash_select_bucket(htab, i)->head;
 		elem_next =3D hlist_entry_safe(rcu_dereference_raw(hlist_first_rcu(hea=
d)),
-					     struct bpf_htab_elem, node);
+					     struct bpf_shtab_elem, node);
 		if (elem_next) {
 			memcpy(key_next, elem_next->key, key_size);
 			return 0;
@@ -955,7 +955,7 @@ static int sock_hash_get_next_key(struct bpf_map *map=
, void *key,
=20
 static struct bpf_map *sock_hash_alloc(union bpf_attr *attr)
 {
-	struct bpf_htab *htab;
+	struct bpf_shtab *htab;
 	int i, err;
 	u64 cost;
=20
@@ -977,15 +977,15 @@ static struct bpf_map *sock_hash_alloc(union bpf_at=
tr *attr)
 	bpf_map_init_from_attr(&htab->map, attr);
=20
 	htab->buckets_num =3D roundup_pow_of_two(htab->map.max_entries);
-	htab->elem_size =3D sizeof(struct bpf_htab_elem) +
+	htab->elem_size =3D sizeof(struct bpf_shtab_elem) +
 			  round_up(htab->map.key_size, 8);
 	if (htab->buckets_num =3D=3D 0 ||
-	    htab->buckets_num > U32_MAX / sizeof(struct bpf_htab_bucket)) {
+	    htab->buckets_num > U32_MAX / sizeof(struct bpf_shtab_bucket)) {
 		err =3D -EINVAL;
 		goto free_htab;
 	}
=20
-	cost =3D (u64) htab->buckets_num * sizeof(struct bpf_htab_bucket) +
+	cost =3D (u64) htab->buckets_num * sizeof(struct bpf_shtab_bucket) +
 	       (u64) htab->elem_size * htab->map.max_entries;
 	if (cost >=3D U32_MAX - PAGE_SIZE) {
 		err =3D -EINVAL;
@@ -996,7 +996,7 @@ static struct bpf_map *sock_hash_alloc(union bpf_attr=
 *attr)
 		goto free_htab;
=20
 	htab->buckets =3D bpf_map_area_alloc(htab->buckets_num *
-					   sizeof(struct bpf_htab_bucket),
+					   sizeof(struct bpf_shtab_bucket),
 					   htab->map.numa_node);
 	if (!htab->buckets) {
 		bpf_map_charge_finish(&htab->map.memory);
@@ -1017,10 +1017,10 @@ static struct bpf_map *sock_hash_alloc(union bpf_=
attr *attr)
=20
 static void sock_hash_free(struct bpf_map *map)
 {
-	struct bpf_htab *htab =3D container_of(map, struct bpf_htab, map);
-	struct bpf_htab_bucket *bucket;
+	struct bpf_shtab *htab =3D container_of(map, struct bpf_shtab, map);
+	struct bpf_shtab_bucket *bucket;
 	struct hlist_head unlink_list;
-	struct bpf_htab_elem *elem;
+	struct bpf_shtab_elem *elem;
 	struct hlist_node *node;
 	int i;
=20
@@ -1096,7 +1096,7 @@ static void *sock_hash_lookup(struct bpf_map *map, =
void *key)
=20
 static void sock_hash_release_progs(struct bpf_map *map)
 {
-	psock_progs_drop(&container_of(map, struct bpf_htab, map)->progs);
+	psock_progs_drop(&container_of(map, struct bpf_shtab, map)->progs);
 }
=20
 BPF_CALL_4(bpf_sock_hash_update, struct bpf_sock_ops_kern *, sops,
@@ -1194,7 +1194,7 @@ static struct sk_psock_progs *sock_map_progs(struct=
 bpf_map *map)
 	case BPF_MAP_TYPE_SOCKMAP:
 		return &container_of(map, struct bpf_stab, map)->progs;
 	case BPF_MAP_TYPE_SOCKHASH:
-		return &container_of(map, struct bpf_htab, map)->progs;
+		return &container_of(map, struct bpf_shtab, map)->progs;
 	default:
 		break;
 	}
--=20
2.24.1

