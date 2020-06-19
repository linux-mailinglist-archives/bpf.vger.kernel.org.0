Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81D6201CF1
	for <lists+bpf@lfdr.de>; Fri, 19 Jun 2020 23:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392261AbgFSVM1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Jun 2020 17:12:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50566 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392091AbgFSVM0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Jun 2020 17:12:26 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05JKwSWM024895
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 14:12:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=kvZat2UPCvYSA+GL9yfxbZQOmjsTsk10+Ga2OHjpAHU=;
 b=iCC85sHmGVs3JVaQPNHxqsxGmWUzDK7JPK6ONspWFiI2A3pv+oPpwFEziO7vVAhe431h
 M+geujqUWl7P5AvtnCoRTvuPliqBgklv/ttBK12BvPqiF5TD1eC6/2hMV7DVNy0WHSyT
 qBz3Y9nLtA9ztbE3hcawJ0IMtJ1iZ3DZOVQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31rg9k09f7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 14:12:22 -0700
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 19 Jun 2020 14:12:21 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 4F0343700BAE; Fri, 19 Jun 2020 14:12:18 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kafai@fb.com>, <andriin@fb.com>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 bpf-next 4/5] bpf: Set map_btf_{name,id} for all map types
Date:   Fri, 19 Jun 2020 14:11:44 -0700
Message-ID: <a825f808f22af52b018dbe82f1c7d29dab5fc978.1592600985.git.rdna@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1592600985.git.rdna@fb.com>
References: <cover.1592600985.git.rdna@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_22:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 cotscore=-2147483648
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=38 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190150
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Set map_btf_name and map_btf_id for all map types so that map fields can
be accessed by bpf programs.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 kernel/bpf/arraymap.c         | 15 +++++++++++++++
 kernel/bpf/bpf_struct_ops.c   |  3 +++
 kernel/bpf/cpumap.c           |  3 +++
 kernel/bpf/devmap.c           |  6 ++++++
 kernel/bpf/hashtab.c          | 12 ++++++++++++
 kernel/bpf/local_storage.c    |  3 +++
 kernel/bpf/lpm_trie.c         |  3 +++
 kernel/bpf/queue_stack_maps.c |  6 ++++++
 kernel/bpf/reuseport_array.c  |  3 +++
 kernel/bpf/ringbuf.c          |  3 +++
 kernel/bpf/stackmap.c         |  3 +++
 net/core/bpf_sk_storage.c     |  3 +++
 net/core/sock_map.c           |  6 ++++++
 net/xdp/xskmap.c              |  3 +++
 14 files changed, 72 insertions(+)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index e7caa48812fb..ec5cd11032aa 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -515,6 +515,7 @@ const struct bpf_map_ops array_map_ops =3D {
 	.map_btf_id =3D &array_map_btf_id,
 };
=20
+static int percpu_array_map_btf_id;
 const struct bpf_map_ops percpu_array_map_ops =3D {
 	.map_alloc_check =3D array_map_alloc_check,
 	.map_alloc =3D array_map_alloc,
@@ -525,6 +526,8 @@ const struct bpf_map_ops percpu_array_map_ops =3D {
 	.map_delete_elem =3D array_map_delete_elem,
 	.map_seq_show_elem =3D percpu_array_map_seq_show_elem,
 	.map_check_btf =3D array_map_check_btf,
+	.map_btf_name =3D "bpf_array",
+	.map_btf_id =3D &percpu_array_map_btf_id,
 };
=20
 static int fd_array_map_alloc_check(union bpf_attr *attr)
@@ -871,6 +874,7 @@ static void prog_array_map_free(struct bpf_map *map)
 	fd_array_map_free(map);
 }
=20
+static int prog_array_map_btf_id;
 const struct bpf_map_ops prog_array_map_ops =3D {
 	.map_alloc_check =3D fd_array_map_alloc_check,
 	.map_alloc =3D prog_array_map_alloc,
@@ -886,6 +890,8 @@ const struct bpf_map_ops prog_array_map_ops =3D {
 	.map_fd_sys_lookup_elem =3D prog_fd_array_sys_lookup_elem,
 	.map_release_uref =3D prog_array_map_clear,
 	.map_seq_show_elem =3D prog_array_map_seq_show_elem,
+	.map_btf_name =3D "bpf_array",
+	.map_btf_id =3D &prog_array_map_btf_id,
 };
=20
 static struct bpf_event_entry *bpf_event_entry_gen(struct file *perf_fil=
e,
@@ -964,6 +970,7 @@ static void perf_event_fd_array_release(struct bpf_ma=
p *map,
 	rcu_read_unlock();
 }
=20
+static int perf_event_array_map_btf_id;
 const struct bpf_map_ops perf_event_array_map_ops =3D {
 	.map_alloc_check =3D fd_array_map_alloc_check,
 	.map_alloc =3D array_map_alloc,
@@ -975,6 +982,8 @@ const struct bpf_map_ops perf_event_array_map_ops =3D=
 {
 	.map_fd_put_ptr =3D perf_event_fd_array_put_ptr,
 	.map_release =3D perf_event_fd_array_release,
 	.map_check_btf =3D map_check_no_btf,
+	.map_btf_name =3D "bpf_array",
+	.map_btf_id =3D &perf_event_array_map_btf_id,
 };
=20
 #ifdef CONFIG_CGROUPS
@@ -997,6 +1006,7 @@ static void cgroup_fd_array_free(struct bpf_map *map=
)
 	fd_array_map_free(map);
 }
=20
+static int cgroup_array_map_btf_id;
 const struct bpf_map_ops cgroup_array_map_ops =3D {
 	.map_alloc_check =3D fd_array_map_alloc_check,
 	.map_alloc =3D array_map_alloc,
@@ -1007,6 +1017,8 @@ const struct bpf_map_ops cgroup_array_map_ops =3D {
 	.map_fd_get_ptr =3D cgroup_fd_array_get_ptr,
 	.map_fd_put_ptr =3D cgroup_fd_array_put_ptr,
 	.map_check_btf =3D map_check_no_btf,
+	.map_btf_name =3D "bpf_array",
+	.map_btf_id =3D &cgroup_array_map_btf_id,
 };
 #endif
=20
@@ -1080,6 +1092,7 @@ static u32 array_of_map_gen_lookup(struct bpf_map *=
map,
 	return insn - insn_buf;
 }
=20
+static int array_of_maps_map_btf_id;
 const struct bpf_map_ops array_of_maps_map_ops =3D {
 	.map_alloc_check =3D fd_array_map_alloc_check,
 	.map_alloc =3D array_of_map_alloc,
@@ -1092,4 +1105,6 @@ const struct bpf_map_ops array_of_maps_map_ops =3D =
{
 	.map_fd_sys_lookup_elem =3D bpf_map_fd_sys_lookup_elem,
 	.map_gen_lookup =3D array_of_map_gen_lookup,
 	.map_check_btf =3D map_check_no_btf,
+	.map_btf_name =3D "bpf_array",
+	.map_btf_id =3D &array_of_maps_map_btf_id,
 };
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index c6b0decaa46a..969c5d47f81f 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -611,6 +611,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union=
 bpf_attr *attr)
 	return map;
 }
=20
+static int bpf_struct_ops_map_btf_id;
 const struct bpf_map_ops bpf_struct_ops_map_ops =3D {
 	.map_alloc_check =3D bpf_struct_ops_map_alloc_check,
 	.map_alloc =3D bpf_struct_ops_map_alloc,
@@ -620,6 +621,8 @@ const struct bpf_map_ops bpf_struct_ops_map_ops =3D {
 	.map_delete_elem =3D bpf_struct_ops_map_delete_elem,
 	.map_update_elem =3D bpf_struct_ops_map_update_elem,
 	.map_seq_show_elem =3D bpf_struct_ops_map_seq_show_elem,
+	.map_btf_name =3D "bpf_struct_ops_map",
+	.map_btf_id =3D &bpf_struct_ops_map_btf_id,
 };
=20
 /* "const void *" because some subsystem is
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 27595fc6da56..bd8658055c16 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -543,6 +543,7 @@ static int cpu_map_get_next_key(struct bpf_map *map, =
void *key, void *next_key)
 	return 0;
 }
=20
+static int cpu_map_btf_id;
 const struct bpf_map_ops cpu_map_ops =3D {
 	.map_alloc		=3D cpu_map_alloc,
 	.map_free		=3D cpu_map_free,
@@ -551,6 +552,8 @@ const struct bpf_map_ops cpu_map_ops =3D {
 	.map_lookup_elem	=3D cpu_map_lookup_elem,
 	.map_get_next_key	=3D cpu_map_get_next_key,
 	.map_check_btf		=3D map_check_no_btf,
+	.map_btf_name		=3D "bpf_cpu_map",
+	.map_btf_id		=3D &cpu_map_btf_id,
 };
=20
 static int bq_flush_to_queue(struct xdp_bulk_queue *bq)
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 0cbb72cdaf63..58acc46861ef 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -747,6 +747,7 @@ static int dev_map_hash_update_elem(struct bpf_map *m=
ap, void *key, void *value,
 					 map, key, value, map_flags);
 }
=20
+static int dev_map_btf_id;
 const struct bpf_map_ops dev_map_ops =3D {
 	.map_alloc =3D dev_map_alloc,
 	.map_free =3D dev_map_free,
@@ -755,8 +756,11 @@ const struct bpf_map_ops dev_map_ops =3D {
 	.map_update_elem =3D dev_map_update_elem,
 	.map_delete_elem =3D dev_map_delete_elem,
 	.map_check_btf =3D map_check_no_btf,
+	.map_btf_name =3D "bpf_dtab",
+	.map_btf_id =3D &dev_map_btf_id,
 };
=20
+static int dev_map_hash_map_btf_id;
 const struct bpf_map_ops dev_map_hash_ops =3D {
 	.map_alloc =3D dev_map_alloc,
 	.map_free =3D dev_map_free,
@@ -765,6 +769,8 @@ const struct bpf_map_ops dev_map_hash_ops =3D {
 	.map_update_elem =3D dev_map_hash_update_elem,
 	.map_delete_elem =3D dev_map_hash_delete_elem,
 	.map_check_btf =3D map_check_no_btf,
+	.map_btf_name =3D "bpf_dtab",
+	.map_btf_id =3D &dev_map_hash_map_btf_id,
 };
=20
 static void dev_map_hash_remove_netdev(struct bpf_dtab *dtab,
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 2c5999e02060..acd06081d81d 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1630,6 +1630,7 @@ const struct bpf_map_ops htab_map_ops =3D {
 	.map_btf_id =3D &htab_map_btf_id,
 };
=20
+static int htab_lru_map_btf_id;
 const struct bpf_map_ops htab_lru_map_ops =3D {
 	.map_alloc_check =3D htab_map_alloc_check,
 	.map_alloc =3D htab_map_alloc,
@@ -1642,6 +1643,8 @@ const struct bpf_map_ops htab_lru_map_ops =3D {
 	.map_gen_lookup =3D htab_lru_map_gen_lookup,
 	.map_seq_show_elem =3D htab_map_seq_show_elem,
 	BATCH_OPS(htab_lru),
+	.map_btf_name =3D "bpf_htab",
+	.map_btf_id =3D &htab_lru_map_btf_id,
 };
=20
 /* Called from eBPF program */
@@ -1746,6 +1749,7 @@ static void htab_percpu_map_seq_show_elem(struct bp=
f_map *map, void *key,
 	rcu_read_unlock();
 }
=20
+static int htab_percpu_map_btf_id;
 const struct bpf_map_ops htab_percpu_map_ops =3D {
 	.map_alloc_check =3D htab_map_alloc_check,
 	.map_alloc =3D htab_map_alloc,
@@ -1756,8 +1760,11 @@ const struct bpf_map_ops htab_percpu_map_ops =3D {
 	.map_delete_elem =3D htab_map_delete_elem,
 	.map_seq_show_elem =3D htab_percpu_map_seq_show_elem,
 	BATCH_OPS(htab_percpu),
+	.map_btf_name =3D "bpf_htab",
+	.map_btf_id =3D &htab_percpu_map_btf_id,
 };
=20
+static int htab_lru_percpu_map_btf_id;
 const struct bpf_map_ops htab_lru_percpu_map_ops =3D {
 	.map_alloc_check =3D htab_map_alloc_check,
 	.map_alloc =3D htab_map_alloc,
@@ -1768,6 +1775,8 @@ const struct bpf_map_ops htab_lru_percpu_map_ops =3D=
 {
 	.map_delete_elem =3D htab_lru_map_delete_elem,
 	.map_seq_show_elem =3D htab_percpu_map_seq_show_elem,
 	BATCH_OPS(htab_lru_percpu),
+	.map_btf_name =3D "bpf_htab",
+	.map_btf_id =3D &htab_lru_percpu_map_btf_id,
 };
=20
 static int fd_htab_map_alloc_check(union bpf_attr *attr)
@@ -1890,6 +1899,7 @@ static void htab_of_map_free(struct bpf_map *map)
 	fd_htab_map_free(map);
 }
=20
+static int htab_of_maps_map_btf_id;
 const struct bpf_map_ops htab_of_maps_map_ops =3D {
 	.map_alloc_check =3D fd_htab_map_alloc_check,
 	.map_alloc =3D htab_of_map_alloc,
@@ -1902,4 +1912,6 @@ const struct bpf_map_ops htab_of_maps_map_ops =3D {
 	.map_fd_sys_lookup_elem =3D bpf_map_fd_sys_lookup_elem,
 	.map_gen_lookup =3D htab_of_map_gen_lookup,
 	.map_check_btf =3D map_check_no_btf,
+	.map_btf_name =3D "bpf_htab",
+	.map_btf_id =3D &htab_of_maps_map_btf_id,
 };
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 33d01866bcc2..51bd5a8cb01b 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -409,6 +409,7 @@ static void cgroup_storage_seq_show_elem(struct bpf_m=
ap *map, void *_key,
 	rcu_read_unlock();
 }
=20
+static int cgroup_storage_map_btf_id;
 const struct bpf_map_ops cgroup_storage_map_ops =3D {
 	.map_alloc =3D cgroup_storage_map_alloc,
 	.map_free =3D cgroup_storage_map_free,
@@ -418,6 +419,8 @@ const struct bpf_map_ops cgroup_storage_map_ops =3D {
 	.map_delete_elem =3D cgroup_storage_delete_elem,
 	.map_check_btf =3D cgroup_storage_check_btf,
 	.map_seq_show_elem =3D cgroup_storage_seq_show_elem,
+	.map_btf_name =3D "bpf_cgroup_storage_map",
+	.map_btf_id =3D &cgroup_storage_map_btf_id,
 };
=20
 int bpf_cgroup_storage_assign(struct bpf_prog_aux *aux, struct bpf_map *=
_map)
diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index c8cc4e4cf98d..1abd4e3f906d 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -735,6 +735,7 @@ static int trie_check_btf(const struct bpf_map *map,
 	       -EINVAL : 0;
 }
=20
+static int trie_map_btf_id;
 const struct bpf_map_ops trie_map_ops =3D {
 	.map_alloc =3D trie_alloc,
 	.map_free =3D trie_free,
@@ -743,4 +744,6 @@ const struct bpf_map_ops trie_map_ops =3D {
 	.map_update_elem =3D trie_update_elem,
 	.map_delete_elem =3D trie_delete_elem,
 	.map_check_btf =3D trie_check_btf,
+	.map_btf_name =3D "lpm_trie",
+	.map_btf_id =3D &trie_map_btf_id,
 };
diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.=
c
index 05c8e043b9d2..80c66a6d7c54 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -262,6 +262,7 @@ static int queue_stack_map_get_next_key(struct bpf_ma=
p *map, void *key,
 	return -EINVAL;
 }
=20
+static int queue_map_btf_id;
 const struct bpf_map_ops queue_map_ops =3D {
 	.map_alloc_check =3D queue_stack_map_alloc_check,
 	.map_alloc =3D queue_stack_map_alloc,
@@ -273,8 +274,11 @@ const struct bpf_map_ops queue_map_ops =3D {
 	.map_pop_elem =3D queue_map_pop_elem,
 	.map_peek_elem =3D queue_map_peek_elem,
 	.map_get_next_key =3D queue_stack_map_get_next_key,
+	.map_btf_name =3D "bpf_queue_stack",
+	.map_btf_id =3D &queue_map_btf_id,
 };
=20
+static int stack_map_btf_id;
 const struct bpf_map_ops stack_map_ops =3D {
 	.map_alloc_check =3D queue_stack_map_alloc_check,
 	.map_alloc =3D queue_stack_map_alloc,
@@ -286,4 +290,6 @@ const struct bpf_map_ops stack_map_ops =3D {
 	.map_pop_elem =3D stack_map_pop_elem,
 	.map_peek_elem =3D stack_map_peek_elem,
 	.map_get_next_key =3D queue_stack_map_get_next_key,
+	.map_btf_name =3D "bpf_queue_stack",
+	.map_btf_id =3D &stack_map_btf_id,
 };
diff --git a/kernel/bpf/reuseport_array.c b/kernel/bpf/reuseport_array.c
index 21cde24386db..a09922f656e4 100644
--- a/kernel/bpf/reuseport_array.c
+++ b/kernel/bpf/reuseport_array.c
@@ -345,6 +345,7 @@ static int reuseport_array_get_next_key(struct bpf_ma=
p *map, void *key,
 	return 0;
 }
=20
+static int reuseport_array_map_btf_id;
 const struct bpf_map_ops reuseport_array_ops =3D {
 	.map_alloc_check =3D reuseport_array_alloc_check,
 	.map_alloc =3D reuseport_array_alloc,
@@ -352,4 +353,6 @@ const struct bpf_map_ops reuseport_array_ops =3D {
 	.map_lookup_elem =3D reuseport_array_lookup_elem,
 	.map_get_next_key =3D reuseport_array_get_next_key,
 	.map_delete_elem =3D reuseport_array_delete_elem,
+	.map_btf_name =3D "reuseport_array",
+	.map_btf_id =3D &reuseport_array_map_btf_id,
 };
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 180414bb0d3e..dbf37aff4827 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -294,6 +294,7 @@ static __poll_t ringbuf_map_poll(struct bpf_map *map,=
 struct file *filp,
 	return 0;
 }
=20
+static int ringbuf_map_btf_id;
 const struct bpf_map_ops ringbuf_map_ops =3D {
 	.map_alloc =3D ringbuf_map_alloc,
 	.map_free =3D ringbuf_map_free,
@@ -303,6 +304,8 @@ const struct bpf_map_ops ringbuf_map_ops =3D {
 	.map_update_elem =3D ringbuf_map_update_elem,
 	.map_delete_elem =3D ringbuf_map_delete_elem,
 	.map_get_next_key =3D ringbuf_map_get_next_key,
+	.map_btf_name =3D "bpf_ringbuf_map",
+	.map_btf_id =3D &ringbuf_map_btf_id,
 };
=20
 /* Given pointer to ring buffer record metadata and struct bpf_ringbuf i=
tself,
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 599488f25e40..27dc9b1b08a5 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -613,6 +613,7 @@ static void stack_map_free(struct bpf_map *map)
 	put_callchain_buffers();
 }
=20
+static int stack_trace_map_btf_id;
 const struct bpf_map_ops stack_trace_map_ops =3D {
 	.map_alloc =3D stack_map_alloc,
 	.map_free =3D stack_map_free,
@@ -621,6 +622,8 @@ const struct bpf_map_ops stack_trace_map_ops =3D {
 	.map_update_elem =3D stack_map_update_elem,
 	.map_delete_elem =3D stack_map_delete_elem,
 	.map_check_btf =3D map_check_no_btf,
+	.map_btf_name =3D "bpf_stack_map",
+	.map_btf_id =3D &stack_trace_map_btf_id,
 };
=20
 static int __init stack_map_init(void)
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 1dae4b543243..6f921c4ddc2c 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -919,6 +919,7 @@ BPF_CALL_2(bpf_sk_storage_delete, struct bpf_map *, m=
ap, struct sock *, sk)
 	return -ENOENT;
 }
=20
+static int sk_storage_map_btf_id;
 const struct bpf_map_ops sk_storage_map_ops =3D {
 	.map_alloc_check =3D bpf_sk_storage_map_alloc_check,
 	.map_alloc =3D bpf_sk_storage_map_alloc,
@@ -928,6 +929,8 @@ const struct bpf_map_ops sk_storage_map_ops =3D {
 	.map_update_elem =3D bpf_fd_sk_storage_update_elem,
 	.map_delete_elem =3D bpf_fd_sk_storage_delete_elem,
 	.map_check_btf =3D bpf_sk_storage_map_check_btf,
+	.map_btf_name =3D "bpf_sk_storage_map",
+	.map_btf_id =3D &sk_storage_map_btf_id,
 };
=20
 const struct bpf_func_proto bpf_sk_storage_get_proto =3D {
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 2b884f2d562a..4c1123c749bb 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -643,6 +643,7 @@ const struct bpf_func_proto bpf_msg_redirect_map_prot=
o =3D {
 	.arg4_type      =3D ARG_ANYTHING,
 };
=20
+static int sock_map_btf_id;
 const struct bpf_map_ops sock_map_ops =3D {
 	.map_alloc		=3D sock_map_alloc,
 	.map_free		=3D sock_map_free,
@@ -653,6 +654,8 @@ const struct bpf_map_ops sock_map_ops =3D {
 	.map_lookup_elem	=3D sock_map_lookup,
 	.map_release_uref	=3D sock_map_release_progs,
 	.map_check_btf		=3D map_check_no_btf,
+	.map_btf_name		=3D "bpf_stab",
+	.map_btf_id		=3D &sock_map_btf_id,
 };
=20
 struct bpf_shtab_elem {
@@ -1176,6 +1179,7 @@ const struct bpf_func_proto bpf_msg_redirect_hash_p=
roto =3D {
 	.arg4_type      =3D ARG_ANYTHING,
 };
=20
+static int sock_hash_map_btf_id;
 const struct bpf_map_ops sock_hash_ops =3D {
 	.map_alloc		=3D sock_hash_alloc,
 	.map_free		=3D sock_hash_free,
@@ -1186,6 +1190,8 @@ const struct bpf_map_ops sock_hash_ops =3D {
 	.map_lookup_elem_sys_only =3D sock_hash_lookup_sys,
 	.map_release_uref	=3D sock_hash_release_progs,
 	.map_check_btf		=3D map_check_no_btf,
+	.map_btf_name		=3D "bpf_shtab",
+	.map_btf_id		=3D &sock_hash_map_btf_id,
 };
=20
 static struct sk_psock_progs *sock_map_progs(struct bpf_map *map)
diff --git a/net/xdp/xskmap.c b/net/xdp/xskmap.c
index 1dc7208c71ba..8367adbbe9df 100644
--- a/net/xdp/xskmap.c
+++ b/net/xdp/xskmap.c
@@ -254,6 +254,7 @@ void xsk_map_try_sock_delete(struct xsk_map *map, str=
uct xdp_sock *xs,
 	spin_unlock_bh(&map->lock);
 }
=20
+static int xsk_map_btf_id;
 const struct bpf_map_ops xsk_map_ops =3D {
 	.map_alloc =3D xsk_map_alloc,
 	.map_free =3D xsk_map_free,
@@ -264,4 +265,6 @@ const struct bpf_map_ops xsk_map_ops =3D {
 	.map_update_elem =3D xsk_map_update_elem,
 	.map_delete_elem =3D xsk_map_delete_elem,
 	.map_check_btf =3D map_check_no_btf,
+	.map_btf_name =3D "xsk_map",
+	.map_btf_id =3D &xsk_map_btf_id,
 };
--=20
2.24.1

