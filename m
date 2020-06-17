Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799B81FD63F
	for <lists+bpf@lfdr.de>; Wed, 17 Jun 2020 22:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgFQUo2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Jun 2020 16:44:28 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9596 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726763AbgFQUo2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Jun 2020 16:44:28 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05HKZp7o029015
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 13:44:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=UuegmeYnPyIAUqVySVk0nt3UiqWExtRqu/yyNlliVeE=;
 b=owN0JGkHBlQRglLAsOjadiXIYJKokqVbFv9HMWDCacjazlhd0o0XTuPJ/C/60r3MMNUr
 gsa9BdkMVeARU77+/UEM0mfn0tKkp/3T+kIWz8f2vfgOKlr4GRcdZ3DzF/WEDRHVkarL
 DmQpl9qs6BUFa2nVeGdPYjRBZwpcNbB1lI8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31q656ftuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 13:44:25 -0700
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 17 Jun 2020 13:44:24 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 65FD53700B15; Wed, 17 Jun 2020 13:44:21 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kafai@fb.com>, <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 5/6] bpf: Set map_btf_name for all map types
Date:   Wed, 17 Jun 2020 13:43:46 -0700
Message-ID: <4953d1e2a24832757038e99cb12db767cdbca35b.1592426215.git.rdna@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1592426215.git.rdna@fb.com>
References: <cover.1592426215.git.rdna@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-17_11:2020-06-17,2020-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=13
 bulkscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 cotscore=-2147483648 malwarescore=0
 spamscore=0 mlxscore=0 adultscore=0 impostorscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006170154
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Set map_btf_name for all map types so that map type specific fields
(those beyond `struct bpf_map`) can be accessed by bpf programs.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 kernel/bpf/arraymap.c         | 5 +++++
 kernel/bpf/bpf_struct_ops.c   | 1 +
 kernel/bpf/cpumap.c           | 1 +
 kernel/bpf/devmap.c           | 2 ++
 kernel/bpf/hashtab.c          | 4 ++++
 kernel/bpf/local_storage.c    | 1 +
 kernel/bpf/lpm_trie.c         | 1 +
 kernel/bpf/queue_stack_maps.c | 2 ++
 kernel/bpf/reuseport_array.c  | 1 +
 kernel/bpf/ringbuf.c          | 1 +
 kernel/bpf/stackmap.c         | 1 +
 net/core/bpf_sk_storage.c     | 1 +
 net/core/sock_map.c           | 2 ++
 net/xdp/xskmap.c              | 1 +
 14 files changed, 24 insertions(+)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index bff478799a83..9b5e7589643b 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -523,6 +523,7 @@ const struct bpf_map_ops percpu_array_map_ops =3D {
 	.map_delete_elem =3D array_map_delete_elem,
 	.map_seq_show_elem =3D percpu_array_map_seq_show_elem,
 	.map_check_btf =3D array_map_check_btf,
+	.map_btf_name =3D "bpf_array",
 };
=20
 static int fd_array_map_alloc_check(union bpf_attr *attr)
@@ -884,6 +885,7 @@ const struct bpf_map_ops prog_array_map_ops =3D {
 	.map_fd_sys_lookup_elem =3D prog_fd_array_sys_lookup_elem,
 	.map_release_uref =3D prog_array_map_clear,
 	.map_seq_show_elem =3D prog_array_map_seq_show_elem,
+	.map_btf_name =3D "bpf_array",
 };
=20
 static struct bpf_event_entry *bpf_event_entry_gen(struct file *perf_fil=
e,
@@ -973,6 +975,7 @@ const struct bpf_map_ops perf_event_array_map_ops =3D=
 {
 	.map_fd_put_ptr =3D perf_event_fd_array_put_ptr,
 	.map_release =3D perf_event_fd_array_release,
 	.map_check_btf =3D map_check_no_btf,
+	.map_btf_name =3D "bpf_array",
 };
=20
 #ifdef CONFIG_CGROUPS
@@ -1005,6 +1008,7 @@ const struct bpf_map_ops cgroup_array_map_ops =3D {
 	.map_fd_get_ptr =3D cgroup_fd_array_get_ptr,
 	.map_fd_put_ptr =3D cgroup_fd_array_put_ptr,
 	.map_check_btf =3D map_check_no_btf,
+	.map_btf_name =3D "bpf_array",
 };
 #endif
=20
@@ -1090,4 +1094,5 @@ const struct bpf_map_ops array_of_maps_map_ops =3D =
{
 	.map_fd_sys_lookup_elem =3D bpf_map_fd_sys_lookup_elem,
 	.map_gen_lookup =3D array_of_map_gen_lookup,
 	.map_check_btf =3D map_check_no_btf,
+	.map_btf_name =3D "bpf_array",
 };
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index c6b0decaa46a..06ee20c92603 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -620,6 +620,7 @@ const struct bpf_map_ops bpf_struct_ops_map_ops =3D {
 	.map_delete_elem =3D bpf_struct_ops_map_delete_elem,
 	.map_update_elem =3D bpf_struct_ops_map_update_elem,
 	.map_seq_show_elem =3D bpf_struct_ops_map_seq_show_elem,
+	.map_btf_name =3D "bpf_struct_ops_map",
 };
=20
 /* "const void *" because some subsystem is
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 27595fc6da56..588ce57d0be1 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -551,6 +551,7 @@ const struct bpf_map_ops cpu_map_ops =3D {
 	.map_lookup_elem	=3D cpu_map_lookup_elem,
 	.map_get_next_key	=3D cpu_map_get_next_key,
 	.map_check_btf		=3D map_check_no_btf,
+	.map_btf_name		=3D "bpf_cpu_map",
 };
=20
 static int bq_flush_to_queue(struct xdp_bulk_queue *bq)
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 0cbb72cdaf63..45c2bb94961d 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -755,6 +755,7 @@ const struct bpf_map_ops dev_map_ops =3D {
 	.map_update_elem =3D dev_map_update_elem,
 	.map_delete_elem =3D dev_map_delete_elem,
 	.map_check_btf =3D map_check_no_btf,
+	.map_btf_name =3D "bpf_dtab",
 };
=20
 const struct bpf_map_ops dev_map_hash_ops =3D {
@@ -765,6 +766,7 @@ const struct bpf_map_ops dev_map_hash_ops =3D {
 	.map_update_elem =3D dev_map_hash_update_elem,
 	.map_delete_elem =3D dev_map_hash_delete_elem,
 	.map_check_btf =3D map_check_no_btf,
+	.map_btf_name =3D "bpf_dtab",
 };
=20
 static void dev_map_hash_remove_netdev(struct bpf_dtab *dtab,
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 5c6344fd1eee..2c805733c8a1 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1640,6 +1640,7 @@ const struct bpf_map_ops htab_lru_map_ops =3D {
 	.map_gen_lookup =3D htab_lru_map_gen_lookup,
 	.map_seq_show_elem =3D htab_map_seq_show_elem,
 	BATCH_OPS(htab_lru),
+	.map_btf_name =3D "bpf_htab",
 };
=20
 /* Called from eBPF program */
@@ -1754,6 +1755,7 @@ const struct bpf_map_ops htab_percpu_map_ops =3D {
 	.map_delete_elem =3D htab_map_delete_elem,
 	.map_seq_show_elem =3D htab_percpu_map_seq_show_elem,
 	BATCH_OPS(htab_percpu),
+	.map_btf_name =3D "bpf_htab",
 };
=20
 const struct bpf_map_ops htab_lru_percpu_map_ops =3D {
@@ -1766,6 +1768,7 @@ const struct bpf_map_ops htab_lru_percpu_map_ops =3D=
 {
 	.map_delete_elem =3D htab_lru_map_delete_elem,
 	.map_seq_show_elem =3D htab_percpu_map_seq_show_elem,
 	BATCH_OPS(htab_lru_percpu),
+	.map_btf_name =3D "bpf_htab",
 };
=20
 static int fd_htab_map_alloc_check(union bpf_attr *attr)
@@ -1900,4 +1903,5 @@ const struct bpf_map_ops htab_of_maps_map_ops =3D {
 	.map_fd_sys_lookup_elem =3D bpf_map_fd_sys_lookup_elem,
 	.map_gen_lookup =3D htab_of_map_gen_lookup,
 	.map_check_btf =3D map_check_no_btf,
+	.map_btf_name =3D "bpf_htab",
 };
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 33d01866bcc2..3c7be0124e4c 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -418,6 +418,7 @@ const struct bpf_map_ops cgroup_storage_map_ops =3D {
 	.map_delete_elem =3D cgroup_storage_delete_elem,
 	.map_check_btf =3D cgroup_storage_check_btf,
 	.map_seq_show_elem =3D cgroup_storage_seq_show_elem,
+	.map_btf_name =3D "bpf_cgroup_storage_map",
 };
=20
 int bpf_cgroup_storage_assign(struct bpf_prog_aux *aux, struct bpf_map *=
_map)
diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index c8cc4e4cf98d..1cadcad07456 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -743,4 +743,5 @@ const struct bpf_map_ops trie_map_ops =3D {
 	.map_update_elem =3D trie_update_elem,
 	.map_delete_elem =3D trie_delete_elem,
 	.map_check_btf =3D trie_check_btf,
+	.map_btf_name =3D "lpm_trie",
 };
diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.=
c
index 05c8e043b9d2..d1a5705d83e9 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -273,6 +273,7 @@ const struct bpf_map_ops queue_map_ops =3D {
 	.map_pop_elem =3D queue_map_pop_elem,
 	.map_peek_elem =3D queue_map_peek_elem,
 	.map_get_next_key =3D queue_stack_map_get_next_key,
+	.map_btf_name =3D "bpf_queue_stack",
 };
=20
 const struct bpf_map_ops stack_map_ops =3D {
@@ -286,4 +287,5 @@ const struct bpf_map_ops stack_map_ops =3D {
 	.map_pop_elem =3D stack_map_pop_elem,
 	.map_peek_elem =3D stack_map_peek_elem,
 	.map_get_next_key =3D queue_stack_map_get_next_key,
+	.map_btf_name =3D "bpf_queue_stack",
 };
diff --git a/kernel/bpf/reuseport_array.c b/kernel/bpf/reuseport_array.c
index 21cde24386db..ca1c934f3052 100644
--- a/kernel/bpf/reuseport_array.c
+++ b/kernel/bpf/reuseport_array.c
@@ -352,4 +352,5 @@ const struct bpf_map_ops reuseport_array_ops =3D {
 	.map_lookup_elem =3D reuseport_array_lookup_elem,
 	.map_get_next_key =3D reuseport_array_get_next_key,
 	.map_delete_elem =3D reuseport_array_delete_elem,
+	.map_btf_name =3D "reuseport_array",
 };
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 180414bb0d3e..814faad74567 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -303,6 +303,7 @@ const struct bpf_map_ops ringbuf_map_ops =3D {
 	.map_update_elem =3D ringbuf_map_update_elem,
 	.map_delete_elem =3D ringbuf_map_delete_elem,
 	.map_get_next_key =3D ringbuf_map_get_next_key,
+	.map_btf_name =3D "bpf_ringbuf_map",
 };
=20
 /* Given pointer to ring buffer record metadata and struct bpf_ringbuf i=
tself,
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 599488f25e40..832599f7098b 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -621,6 +621,7 @@ const struct bpf_map_ops stack_trace_map_ops =3D {
 	.map_update_elem =3D stack_map_update_elem,
 	.map_delete_elem =3D stack_map_delete_elem,
 	.map_check_btf =3D map_check_no_btf,
+	.map_btf_name =3D "bpf_stack_map",
 };
=20
 static int __init stack_map_init(void)
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index d2c4d16dadba..111e14d02afd 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -895,6 +895,7 @@ const struct bpf_map_ops sk_storage_map_ops =3D {
 	.map_update_elem =3D bpf_fd_sk_storage_update_elem,
 	.map_delete_elem =3D bpf_fd_sk_storage_delete_elem,
 	.map_check_btf =3D bpf_sk_storage_map_check_btf,
+	.map_btf_name =3D "bpf_sk_storage_map",
 };
=20
 const struct bpf_func_proto bpf_sk_storage_get_proto =3D {
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 2b884f2d562a..55b09dc76445 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -653,6 +653,7 @@ const struct bpf_map_ops sock_map_ops =3D {
 	.map_lookup_elem	=3D sock_map_lookup,
 	.map_release_uref	=3D sock_map_release_progs,
 	.map_check_btf		=3D map_check_no_btf,
+	.map_btf_name		=3D "bpf_stab",
 };
=20
 struct bpf_shtab_elem {
@@ -1186,6 +1187,7 @@ const struct bpf_map_ops sock_hash_ops =3D {
 	.map_lookup_elem_sys_only =3D sock_hash_lookup_sys,
 	.map_release_uref	=3D sock_hash_release_progs,
 	.map_check_btf		=3D map_check_no_btf,
+	.map_btf_name		=3D "bpf_shtab",
 };
=20
 static struct sk_psock_progs *sock_map_progs(struct bpf_map *map)
diff --git a/net/xdp/xskmap.c b/net/xdp/xskmap.c
index 1dc7208c71ba..787f6b393221 100644
--- a/net/xdp/xskmap.c
+++ b/net/xdp/xskmap.c
@@ -264,4 +264,5 @@ const struct bpf_map_ops xsk_map_ops =3D {
 	.map_update_elem =3D xsk_map_update_elem,
 	.map_delete_elem =3D xsk_map_delete_elem,
 	.map_check_btf =3D map_check_no_btf,
+	.map_btf_name =3D "xsk_map",
 };
--=20
2.24.1

