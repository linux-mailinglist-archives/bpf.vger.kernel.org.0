Return-Path: <bpf+bounces-1694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC2F720524
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 17:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276A028183D
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 15:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10FA19E43;
	Fri,  2 Jun 2023 15:00:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710C91992C
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 15:00:41 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00A1E58
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 08:00:34 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352Bt7c6019701
	for <bpf@vger.kernel.org>; Fri, 2 Jun 2023 08:00:34 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qxt1sarxf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 08:00:33 -0700
Received: from twshared68078.02.prn6.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 08:00:30 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 6148131E0489D; Fri,  2 Jun 2023 08:00:24 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>
CC: <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>, <cyphar@cyphar.com>,
        <luto@kernel.org>
Subject: [PATCH RESEND bpf-next 06/18] bpf: centralize permissions checks for all BPF map types
Date: Fri, 2 Jun 2023 07:59:59 -0700
Message-ID: <20230602150011.1657856-7-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602150011.1657856-1-andrii@kernel.org>
References: <20230602150011.1657856-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: IcjtnEtVwr9FbfZwcWQZl1tdslAapMJ_
X-Proofpoint-GUID: IcjtnEtVwr9FbfZwcWQZl1tdslAapMJ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_11,2023-06-02_02,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This allows to do more centralized decisions later on, and generally
makes it very explicit which maps are privileged and which are not
(e.g., LRU_HASH and LRU_PERCPU_HASH, which are privileged HASH variants,
as opposed to unprivileged HASH and HASH_PERCPU; now this is explicit
and easy to verify).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/bloom_filter.c                     |  3 --
 kernel/bpf/bpf_local_storage.c                |  3 --
 kernel/bpf/bpf_struct_ops.c                   |  3 --
 kernel/bpf/cpumap.c                           |  4 --
 kernel/bpf/devmap.c                           |  3 --
 kernel/bpf/hashtab.c                          |  6 ---
 kernel/bpf/lpm_trie.c                         |  3 --
 kernel/bpf/queue_stack_maps.c                 |  4 --
 kernel/bpf/reuseport_array.c                  |  3 --
 kernel/bpf/stackmap.c                         |  3 --
 kernel/bpf/syscall.c                          | 47 +++++++++++++++++++
 net/core/sock_map.c                           |  4 --
 net/xdp/xskmap.c                              |  4 --
 .../bpf/prog_tests/unpriv_bpf_disabled.c      |  6 ++-
 14 files changed, 52 insertions(+), 44 deletions(-)

diff --git a/kernel/bpf/bloom_filter.c b/kernel/bpf/bloom_filter.c
index 540331b610a9..addf3dd57b59 100644
--- a/kernel/bpf/bloom_filter.c
+++ b/kernel/bpf/bloom_filter.c
@@ -86,9 +86,6 @@ static struct bpf_map *bloom_map_alloc(union bpf_attr *=
attr)
 	int numa_node =3D bpf_map_attr_numa_node(attr);
 	struct bpf_bloom_filter *bloom;
=20
-	if (!bpf_capable())
-		return ERR_PTR(-EPERM);
-
 	if (attr->key_size !=3D 0 || attr->value_size =3D=3D 0 ||
 	    attr->max_entries =3D=3D 0 ||
 	    attr->map_flags & ~BLOOM_CREATE_FLAG_MASK ||
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storag=
e.c
index 47d9948d768f..b5149cfce7d4 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -723,9 +723,6 @@ int bpf_local_storage_map_alloc_check(union bpf_attr =
*attr)
 	    !attr->btf_key_type_id || !attr->btf_value_type_id)
 		return -EINVAL;
=20
-	if (!bpf_capable())
-		return -EPERM;
-
 	if (attr->value_size > BPF_LOCAL_STORAGE_MAX_VALUE_SIZE)
 		return -E2BIG;
=20
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index d3f0a4825fa6..116a0ce378ec 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -655,9 +655,6 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union=
 bpf_attr *attr)
 	const struct btf_type *t, *vt;
 	struct bpf_map *map;
=20
-	if (!bpf_capable())
-		return ERR_PTR(-EPERM);
-
 	st_ops =3D bpf_struct_ops_find_value(attr->btf_vmlinux_value_type_id);
 	if (!st_ops)
 		return ERR_PTR(-ENOTSUPP);
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 8ec18faa74ac..8a33e8747a0e 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -28,7 +28,6 @@
 #include <linux/sched.h>
 #include <linux/workqueue.h>
 #include <linux/kthread.h>
-#include <linux/capability.h>
 #include <trace/events/xdp.h>
 #include <linux/btf_ids.h>
=20
@@ -89,9 +88,6 @@ static struct bpf_map *cpu_map_alloc(union bpf_attr *at=
tr)
 	u32 value_size =3D attr->value_size;
 	struct bpf_cpu_map *cmap;
=20
-	if (!bpf_capable())
-		return ERR_PTR(-EPERM);
-
 	/* check sanity of attributes */
 	if (attr->max_entries =3D=3D 0 || attr->key_size !=3D 4 ||
 	    (value_size !=3D offsetofend(struct bpf_cpumap_val, qsize) &&
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 802692fa3905..49cc0b5671c6 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -160,9 +160,6 @@ static struct bpf_map *dev_map_alloc(union bpf_attr *=
attr)
 	struct bpf_dtab *dtab;
 	int err;
=20
-	if (!capable(CAP_NET_ADMIN))
-		return ERR_PTR(-EPERM);
-
 	dtab =3D bpf_map_area_alloc(sizeof(*dtab), NUMA_NO_NODE);
 	if (!dtab)
 		return ERR_PTR(-ENOMEM);
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 9901efee4339..56d3da7d0bc6 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -422,12 +422,6 @@ static int htab_map_alloc_check(union bpf_attr *attr=
)
 	BUILD_BUG_ON(offsetof(struct htab_elem, fnode.next) !=3D
 		     offsetof(struct htab_elem, hash_node.pprev));
=20
-	if (lru && !bpf_capable())
-		/* LRU implementation is much complicated than other
-		 * maps.  Hence, limit to CAP_BPF.
-		 */
-		return -EPERM;
-
 	if (zero_seed && !capable(CAP_SYS_ADMIN))
 		/* Guard against local DoS, and discourage production use. */
 		return -EPERM;
diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index e0d3ddf2037a..17c7e7782a1f 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -544,9 +544,6 @@ static struct bpf_map *trie_alloc(union bpf_attr *att=
r)
 {
 	struct lpm_trie *trie;
=20
-	if (!bpf_capable())
-		return ERR_PTR(-EPERM);
-
 	/* check sanity of attributes */
 	if (attr->max_entries =3D=3D 0 ||
 	    !(attr->map_flags & BPF_F_NO_PREALLOC) ||
diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.=
c
index 601609164ef3..8d2ddcb7566b 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -7,7 +7,6 @@
 #include <linux/bpf.h>
 #include <linux/list.h>
 #include <linux/slab.h>
-#include <linux/capability.h>
 #include <linux/btf_ids.h>
 #include "percpu_freelist.h"
=20
@@ -46,9 +45,6 @@ static bool queue_stack_map_is_full(struct bpf_queue_st=
ack *qs)
 /* Called from syscall */
 static int queue_stack_map_alloc_check(union bpf_attr *attr)
 {
-	if (!bpf_capable())
-		return -EPERM;
-
 	/* check sanity of attributes */
 	if (attr->max_entries =3D=3D 0 || attr->key_size !=3D 0 ||
 	    attr->value_size =3D=3D 0 ||
diff --git a/kernel/bpf/reuseport_array.c b/kernel/bpf/reuseport_array.c
index cbf2d8d784b8..4b4f9670f1a9 100644
--- a/kernel/bpf/reuseport_array.c
+++ b/kernel/bpf/reuseport_array.c
@@ -151,9 +151,6 @@ static struct bpf_map *reuseport_array_alloc(union bp=
f_attr *attr)
 	int numa_node =3D bpf_map_attr_numa_node(attr);
 	struct reuseport_array *array;
=20
-	if (!bpf_capable())
-		return ERR_PTR(-EPERM);
-
 	/* allocate all map elements and zero-initialize them */
 	array =3D bpf_map_area_alloc(struct_size(array, ptrs, attr->max_entries=
), numa_node);
 	if (!array)
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index b25fce425b2c..458bb80b14d5 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -74,9 +74,6 @@ static struct bpf_map *stack_map_alloc(union bpf_attr *=
attr)
 	u64 cost, n_buckets;
 	int err;
=20
-	if (!bpf_capable())
-		return ERR_PTR(-EPERM);
-
 	if (attr->map_flags & ~STACK_CREATE_FLAG_MASK)
 		return ERR_PTR(-EINVAL);
=20
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index cd68c57c0689..6e7ccbd54524 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1156,6 +1156,53 @@ static int map_create(union bpf_attr *attr)
 	if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
 		return -EPERM;
=20
+	/* check privileged map type permissions */
+	switch (map_type) {
+	case BPF_MAP_TYPE_ARRAY:
+	case BPF_MAP_TYPE_PERCPU_ARRAY:
+	case BPF_MAP_TYPE_PROG_ARRAY:
+	case BPF_MAP_TYPE_PERF_EVENT_ARRAY:
+	case BPF_MAP_TYPE_CGROUP_ARRAY:
+	case BPF_MAP_TYPE_ARRAY_OF_MAPS:
+	case BPF_MAP_TYPE_HASH:
+	case BPF_MAP_TYPE_PERCPU_HASH:
+	case BPF_MAP_TYPE_HASH_OF_MAPS:
+	case BPF_MAP_TYPE_RINGBUF:
+	case BPF_MAP_TYPE_USER_RINGBUF:
+	case BPF_MAP_TYPE_CGROUP_STORAGE:
+	case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE:
+		/* unprivileged */
+		break;
+	case BPF_MAP_TYPE_SK_STORAGE:
+	case BPF_MAP_TYPE_INODE_STORAGE:
+	case BPF_MAP_TYPE_TASK_STORAGE:
+	case BPF_MAP_TYPE_CGRP_STORAGE:
+	case BPF_MAP_TYPE_BLOOM_FILTER:
+	case BPF_MAP_TYPE_LPM_TRIE:
+	case BPF_MAP_TYPE_REUSEPORT_SOCKARRAY:
+	case BPF_MAP_TYPE_STACK_TRACE:
+	case BPF_MAP_TYPE_QUEUE:
+	case BPF_MAP_TYPE_STACK:
+	case BPF_MAP_TYPE_LRU_HASH:
+	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
+	case BPF_MAP_TYPE_STRUCT_OPS:
+	case BPF_MAP_TYPE_CPUMAP:
+		if (!bpf_capable())
+			return -EPERM;
+		break;
+	case BPF_MAP_TYPE_SOCKMAP:
+	case BPF_MAP_TYPE_SOCKHASH:
+	case BPF_MAP_TYPE_DEVMAP:
+	case BPF_MAP_TYPE_DEVMAP_HASH:
+	case BPF_MAP_TYPE_XSKMAP:
+		if (!capable(CAP_NET_ADMIN))
+			return -EPERM;
+		break;
+	default:
+		WARN(1, "unsupported map type %d", map_type);
+		return -EPERM;
+	}
+
 	map =3D ops->map_alloc(attr);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 00afb66cd095..19538d628714 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -32,8 +32,6 @@ static struct bpf_map *sock_map_alloc(union bpf_attr *a=
ttr)
 {
 	struct bpf_stab *stab;
=20
-	if (!capable(CAP_NET_ADMIN))
-		return ERR_PTR(-EPERM);
 	if (attr->max_entries =3D=3D 0 ||
 	    attr->key_size    !=3D 4 ||
 	    (attr->value_size !=3D sizeof(u32) &&
@@ -1085,8 +1083,6 @@ static struct bpf_map *sock_hash_alloc(union bpf_at=
tr *attr)
 	struct bpf_shtab *htab;
 	int i, err;
=20
-	if (!capable(CAP_NET_ADMIN))
-		return ERR_PTR(-EPERM);
 	if (attr->max_entries =3D=3D 0 ||
 	    attr->key_size    =3D=3D 0 ||
 	    (attr->value_size !=3D sizeof(u32) &&
diff --git a/net/xdp/xskmap.c b/net/xdp/xskmap.c
index 2c1427074a3b..e1c526f97ce3 100644
--- a/net/xdp/xskmap.c
+++ b/net/xdp/xskmap.c
@@ -5,7 +5,6 @@
=20
 #include <linux/bpf.h>
 #include <linux/filter.h>
-#include <linux/capability.h>
 #include <net/xdp_sock.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
@@ -68,9 +67,6 @@ static struct bpf_map *xsk_map_alloc(union bpf_attr *at=
tr)
 	int numa_node;
 	u64 size;
=20
-	if (!capable(CAP_NET_ADMIN))
-		return ERR_PTR(-EPERM);
-
 	if (attr->max_entries =3D=3D 0 || attr->key_size !=3D 4 ||
 	    attr->value_size !=3D 4 ||
 	    attr->map_flags & ~(BPF_F_NUMA_NODE | BPF_F_RDONLY | BPF_F_WRONLY))
diff --git a/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c=
 b/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
index 8383a99f610f..0adf8d9475cb 100644
--- a/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
+++ b/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
@@ -171,7 +171,11 @@ static void test_unpriv_bpf_disabled_negative(struct=
 test_unpriv_bpf_disabled *s
 				prog_insns, prog_insn_cnt, &load_opts),
 		  -EPERM, "prog_load_fails");
=20
-	for (i =3D BPF_MAP_TYPE_HASH; i <=3D BPF_MAP_TYPE_BLOOM_FILTER; i++)
+	/* some map types require particular correct parameters which could be
+	 * sanity-checked before enforcing -EPERM, so only validate that
+	 * the simple ARRAY and HASH maps are failing with -EPERM
+	 */
+	for (i =3D BPF_MAP_TYPE_HASH; i <=3D BPF_MAP_TYPE_ARRAY; i++)
 		ASSERT_EQ(bpf_map_create(i, NULL, sizeof(int), sizeof(int), 1, NULL),
 			  -EPERM, "map_create_fails");
=20
--=20
2.34.1


