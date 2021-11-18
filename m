Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247924551BE
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 01:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241968AbhKRAhe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 17 Nov 2021 19:37:34 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:29038 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241986AbhKRAha (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Nov 2021 19:37:30 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHLdvtE007601
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 16:34:30 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3ccuvh733e-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 16:34:30 -0800
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 17 Nov 2021 16:34:29 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 6D7F799613CA; Wed, 17 Nov 2021 16:34:27 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/4] libbpf: unify low-level map creation APIs w/ new bpf_map_create()
Date:   Wed, 17 Nov 2021 16:34:20 -0800
Message-ID: <20211118003423.1885869-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211118003423.1885869-1-andrii@kernel.org>
References: <20211118003423.1885869-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: k1goTnJKYmur2IUMKGbx3Gi4W0sFwvIG
X-Proofpoint-GUID: k1goTnJKYmur2IUMKGbx3Gi4W0sFwvIG
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_09,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1034 mlxscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111180001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Mark the entire zoo of low-level map creation APIs for deprecation in
libbpf 0.7 ([0]) and introduce a new bpf_map_create() API that is
OPTS-based (and thus future-proof) and matches the BPF_MAP_CREATE
command name.

While at it, ensure that gen_loader sends map_extra field. Also remove
now unneeded btf_key_type_id/btf_value_type_id logic that libbpf is
doing anyways.

  [0] Closes: https://github.com/libbpf/libbpf/issues/282

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c              | 140 +++++++++++++------------------
 tools/lib/bpf/bpf.h              |  33 +++++++-
 tools/lib/bpf/bpf_gen_internal.h |   5 +-
 tools/lib/bpf/gen_loader.c       |  46 ++++------
 tools/lib/bpf/libbpf.c           |  33 ++++----
 tools/lib/bpf/libbpf.map         |   1 +
 tools/lib/bpf/libbpf_internal.h  |  21 -----
 7 files changed, 126 insertions(+), 153 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 94560ba31724..053c86e3d20f 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -88,146 +88,122 @@ static inline int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size, int
 	return fd;
 }
 
-int libbpf__bpf_create_map_xattr(const struct bpf_create_map_params *create_attr)
+int bpf_map_create(enum bpf_map_type map_type,
+		   const char *map_name,
+		   __u32 key_size,
+		   __u32 value_size,
+		   __u32 max_entries,
+		   const struct bpf_map_create_opts *opts)
 {
+	const size_t attr_sz = offsetofend(union bpf_attr, map_extra);
 	union bpf_attr attr;
 	int fd;
 
-	memset(&attr, '\0', sizeof(attr));
-
-	attr.map_type = create_attr->map_type;
-	attr.key_size = create_attr->key_size;
-	attr.value_size = create_attr->value_size;
-	attr.max_entries = create_attr->max_entries;
-	attr.map_flags = create_attr->map_flags;
-	if (create_attr->name)
-		memcpy(attr.map_name, create_attr->name,
-		       min(strlen(create_attr->name), BPF_OBJ_NAME_LEN - 1));
-	attr.numa_node = create_attr->numa_node;
-	attr.btf_fd = create_attr->btf_fd;
-	attr.btf_key_type_id = create_attr->btf_key_type_id;
-	attr.btf_value_type_id = create_attr->btf_value_type_id;
-	attr.map_ifindex = create_attr->map_ifindex;
-	if (attr.map_type == BPF_MAP_TYPE_STRUCT_OPS)
-		attr.btf_vmlinux_value_type_id =
-			create_attr->btf_vmlinux_value_type_id;
-	else
-		attr.inner_map_fd = create_attr->inner_map_fd;
-	attr.map_extra = create_attr->map_extra;
+	memset(&attr, 0, attr_sz);
+
+	if (!OPTS_VALID(opts, bpf_map_create_opts))
+		return libbpf_err(-EINVAL);
 
-	fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, sizeof(attr));
+	attr.map_type = map_type;
+	if (map_name)
+		strncat(attr.map_name, map_name, sizeof(attr.map_name) - 1);
+	attr.key_size = key_size;
+	attr.value_size = value_size;
+	attr.max_entries = max_entries;
+
+	attr.btf_fd = OPTS_GET(opts, btf_fd, 0);
+	attr.btf_key_type_id = OPTS_GET(opts, btf_key_type_id, 0);
+	attr.btf_value_type_id = OPTS_GET(opts, btf_value_type_id, 0);
+	attr.btf_vmlinux_value_type_id = OPTS_GET(opts, btf_vmlinux_value_type_id, 0);
+
+	attr.inner_map_fd = OPTS_GET(opts, inner_map_fd, 0);
+	attr.map_flags = OPTS_GET(opts, map_flags, 0);
+	attr.map_extra = OPTS_GET(opts, map_extra, 0);
+	attr.numa_node = OPTS_GET(opts, numa_node, 0);
+	attr.map_ifindex = OPTS_GET(opts, map_ifindex, 0);
+
+	fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
 	return libbpf_err_errno(fd);
 }
 
 int bpf_create_map_xattr(const struct bpf_create_map_attr *create_attr)
 {
-	struct bpf_create_map_params p = {};
+	LIBBPF_OPTS(bpf_map_create_opts, p);
 
-	p.map_type = create_attr->map_type;
-	p.key_size = create_attr->key_size;
-	p.value_size = create_attr->value_size;
-	p.max_entries = create_attr->max_entries;
 	p.map_flags = create_attr->map_flags;
-	p.name = create_attr->name;
 	p.numa_node = create_attr->numa_node;
 	p.btf_fd = create_attr->btf_fd;
 	p.btf_key_type_id = create_attr->btf_key_type_id;
 	p.btf_value_type_id = create_attr->btf_value_type_id;
 	p.map_ifindex = create_attr->map_ifindex;
-	if (p.map_type == BPF_MAP_TYPE_STRUCT_OPS)
-		p.btf_vmlinux_value_type_id =
-			create_attr->btf_vmlinux_value_type_id;
+	if (create_attr->map_type == BPF_MAP_TYPE_STRUCT_OPS)
+		p.btf_vmlinux_value_type_id = create_attr->btf_vmlinux_value_type_id;
 	else
 		p.inner_map_fd = create_attr->inner_map_fd;
 
-	return libbpf__bpf_create_map_xattr(&p);
+	return bpf_map_create(create_attr->map_type, create_attr->name,
+			      create_attr->key_size, create_attr->value_size,
+			      create_attr->max_entries, &p);
 }
 
 int bpf_create_map_node(enum bpf_map_type map_type, const char *name,
 			int key_size, int value_size, int max_entries,
 			__u32 map_flags, int node)
 {
-	struct bpf_create_map_attr map_attr = {};
-
-	map_attr.name = name;
-	map_attr.map_type = map_type;
-	map_attr.map_flags = map_flags;
-	map_attr.key_size = key_size;
-	map_attr.value_size = value_size;
-	map_attr.max_entries = max_entries;
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+
+	opts.map_flags = map_flags;
 	if (node >= 0) {
-		map_attr.numa_node = node;
-		map_attr.map_flags |= BPF_F_NUMA_NODE;
+		opts.numa_node = node;
+		opts.map_flags |= BPF_F_NUMA_NODE;
 	}
 
-	return bpf_create_map_xattr(&map_attr);
+	return bpf_map_create(map_type, name, key_size, value_size, max_entries, &opts);
 }
 
 int bpf_create_map(enum bpf_map_type map_type, int key_size,
 		   int value_size, int max_entries, __u32 map_flags)
 {
-	struct bpf_create_map_attr map_attr = {};
-
-	map_attr.map_type = map_type;
-	map_attr.map_flags = map_flags;
-	map_attr.key_size = key_size;
-	map_attr.value_size = value_size;
-	map_attr.max_entries = max_entries;
+	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = map_flags);
 
-	return bpf_create_map_xattr(&map_attr);
+	return bpf_map_create(map_type, NULL, key_size, value_size, max_entries, &opts);
 }
 
 int bpf_create_map_name(enum bpf_map_type map_type, const char *name,
 			int key_size, int value_size, int max_entries,
 			__u32 map_flags)
 {
-	struct bpf_create_map_attr map_attr = {};
+	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = map_flags);
 
-	map_attr.name = name;
-	map_attr.map_type = map_type;
-	map_attr.map_flags = map_flags;
-	map_attr.key_size = key_size;
-	map_attr.value_size = value_size;
-	map_attr.max_entries = max_entries;
-
-	return bpf_create_map_xattr(&map_attr);
+	return bpf_map_create(map_type, name, key_size, value_size, max_entries, &opts);
 }
 
 int bpf_create_map_in_map_node(enum bpf_map_type map_type, const char *name,
 			       int key_size, int inner_map_fd, int max_entries,
 			       __u32 map_flags, int node)
 {
-	union bpf_attr attr;
-	int fd;
-
-	memset(&attr, '\0', sizeof(attr));
-
-	attr.map_type = map_type;
-	attr.key_size = key_size;
-	attr.value_size = 4;
-	attr.inner_map_fd = inner_map_fd;
-	attr.max_entries = max_entries;
-	attr.map_flags = map_flags;
-	if (name)
-		memcpy(attr.map_name, name,
-		       min(strlen(name), BPF_OBJ_NAME_LEN - 1));
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
 
+	opts.inner_map_fd = inner_map_fd;
+	opts.map_flags = map_flags;
 	if (node >= 0) {
-		attr.map_flags |= BPF_F_NUMA_NODE;
-		attr.numa_node = node;
+		opts.map_flags |= BPF_F_NUMA_NODE;
+		opts.numa_node = node;
 	}
 
-	fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, sizeof(attr));
-	return libbpf_err_errno(fd);
+	return bpf_map_create(map_type, name, key_size, 4, max_entries, &opts);
 }
 
 int bpf_create_map_in_map(enum bpf_map_type map_type, const char *name,
 			  int key_size, int inner_map_fd, int max_entries,
 			  __u32 map_flags)
 {
-	return bpf_create_map_in_map_node(map_type, name, key_size,
-					  inner_map_fd, max_entries, map_flags,
-					  -1);
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		.inner_map_fd = inner_map_fd,
+		.map_flags = map_flags,
+	);
+
+	return bpf_map_create(map_type, name, key_size, 4, max_entries, &opts);
 }
 
 static void *
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 079cc81ac51e..70b6f44fc8b0 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -35,6 +35,30 @@
 extern "C" {
 #endif
 
+struct bpf_map_create_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+
+	__u32 btf_fd;
+	__u32 btf_key_type_id;
+	__u32 btf_value_type_id;
+	__u32 btf_vmlinux_value_type_id;
+
+	int inner_map_fd;
+	int map_flags;
+	__u64 map_extra;
+
+	int numa_node;
+	int map_ifindex;
+};
+#define bpf_map_create_opts__last_field map_ifindex
+
+LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
+			      const char *map_name,
+			      __u32 key_size,
+			      __u32 value_size,
+			      __u32 max_entries,
+			      const struct bpf_map_create_opts *opts);
+
 struct bpf_create_map_attr {
 	const char *name;
 	enum bpf_map_type map_type;
@@ -53,20 +77,25 @@ struct bpf_create_map_attr {
 	};
 };
 
-LIBBPF_API int
-bpf_create_map_xattr(const struct bpf_create_map_attr *create_attr);
+LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_map_create() instead")
+LIBBPF_API int bpf_create_map_xattr(const struct bpf_create_map_attr *create_attr);
+LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_map_create() instead")
 LIBBPF_API int bpf_create_map_node(enum bpf_map_type map_type, const char *name,
 				   int key_size, int value_size,
 				   int max_entries, __u32 map_flags, int node);
+LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_map_create() instead")
 LIBBPF_API int bpf_create_map_name(enum bpf_map_type map_type, const char *name,
 				   int key_size, int value_size,
 				   int max_entries, __u32 map_flags);
+LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_map_create() instead")
 LIBBPF_API int bpf_create_map(enum bpf_map_type map_type, int key_size,
 			      int value_size, int max_entries, __u32 map_flags);
+LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_map_create() instead")
 LIBBPF_API int bpf_create_map_in_map_node(enum bpf_map_type map_type,
 					  const char *name, int key_size,
 					  int inner_map_fd, int max_entries,
 					  __u32 map_flags, int node);
+LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_map_create() instead")
 LIBBPF_API int bpf_create_map_in_map(enum bpf_map_type map_type,
 				     const char *name, int key_size,
 				     int inner_map_fd, int max_entries,
diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
index 75ca9fb857b2..ae7704deba30 100644
--- a/tools/lib/bpf/bpf_gen_internal.h
+++ b/tools/lib/bpf/bpf_gen_internal.h
@@ -51,7 +51,10 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level);
 int bpf_gen__finish(struct bpf_gen *gen);
 void bpf_gen__free(struct bpf_gen *gen);
 void bpf_gen__load_btf(struct bpf_gen *gen, const void *raw_data, __u32 raw_size);
-void bpf_gen__map_create(struct bpf_gen *gen, struct bpf_create_map_params *map_attr, int map_idx);
+void bpf_gen__map_create(struct bpf_gen *gen,
+			 enum bpf_map_type map_type, const char *map_name,
+			 __u32 key_size, __u32 value_size, __u32 max_entries,
+			 struct bpf_map_create_opts *map_attr, int map_idx);
 void bpf_gen__prog_load(struct bpf_gen *gen,
 			enum bpf_prog_type prog_type, const char *prog_name,
 			const char *license, struct bpf_insn *insns, size_t insn_cnt,
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 7b73f97b1fa1..c7bc77f4e752 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -432,47 +432,33 @@ void bpf_gen__load_btf(struct bpf_gen *gen, const void *btf_raw_data,
 }
 
 void bpf_gen__map_create(struct bpf_gen *gen,
-			 struct bpf_create_map_params *map_attr, int map_idx)
+			 enum bpf_map_type map_type,
+			 const char *map_name,
+			 __u32 key_size, __u32 value_size, __u32 max_entries,
+			 struct bpf_map_create_opts *map_attr, int map_idx)
 {
-	int attr_size = offsetofend(union bpf_attr, btf_vmlinux_value_type_id);
+	int attr_size = offsetofend(union bpf_attr, map_extra);
 	bool close_inner_map_fd = false;
 	int map_create_attr, idx;
 	union bpf_attr attr;
 
 	memset(&attr, 0, attr_size);
-	attr.map_type = map_attr->map_type;
-	attr.key_size = map_attr->key_size;
-	attr.value_size = map_attr->value_size;
+	attr.map_type = map_type;
+	attr.key_size = key_size;
+	attr.value_size = value_size;
 	attr.map_flags = map_attr->map_flags;
 	attr.map_extra = map_attr->map_extra;
-	memcpy(attr.map_name, map_attr->name,
-	       min((unsigned)strlen(map_attr->name), BPF_OBJ_NAME_LEN - 1));
+	if (map_name)
+		memcpy(attr.map_name, map_name,
+		       min((unsigned)strlen(map_name), BPF_OBJ_NAME_LEN - 1));
 	attr.numa_node = map_attr->numa_node;
 	attr.map_ifindex = map_attr->map_ifindex;
-	attr.max_entries = map_attr->max_entries;
-	switch (attr.map_type) {
-	case BPF_MAP_TYPE_PERF_EVENT_ARRAY:
-	case BPF_MAP_TYPE_CGROUP_ARRAY:
-	case BPF_MAP_TYPE_STACK_TRACE:
-	case BPF_MAP_TYPE_ARRAY_OF_MAPS:
-	case BPF_MAP_TYPE_HASH_OF_MAPS:
-	case BPF_MAP_TYPE_DEVMAP:
-	case BPF_MAP_TYPE_DEVMAP_HASH:
-	case BPF_MAP_TYPE_CPUMAP:
-	case BPF_MAP_TYPE_XSKMAP:
-	case BPF_MAP_TYPE_SOCKMAP:
-	case BPF_MAP_TYPE_SOCKHASH:
-	case BPF_MAP_TYPE_QUEUE:
-	case BPF_MAP_TYPE_STACK:
-	case BPF_MAP_TYPE_RINGBUF:
-		break;
-	default:
-		attr.btf_key_type_id = map_attr->btf_key_type_id;
-		attr.btf_value_type_id = map_attr->btf_value_type_id;
-	}
+	attr.max_entries = max_entries;
+	attr.btf_key_type_id = map_attr->btf_key_type_id;
+	attr.btf_value_type_id = map_attr->btf_value_type_id;
 
 	pr_debug("gen: map_create: %s idx %d type %d value_type_id %d\n",
-		 attr.map_name, map_idx, map_attr->map_type, attr.btf_value_type_id);
+		 attr.map_name, map_idx, map_type, attr.btf_value_type_id);
 
 	map_create_attr = add_data(gen, &attr, attr_size);
 	if (attr.btf_value_type_id)
@@ -499,7 +485,7 @@ void bpf_gen__map_create(struct bpf_gen *gen,
 	/* emit MAP_CREATE command */
 	emit_sys_bpf(gen, BPF_MAP_CREATE, map_create_attr, attr_size);
 	debug_ret(gen, "map_create %s idx %d type %d value_size %d value_btf_id %d",
-		  attr.map_name, map_idx, map_attr->map_type, attr.value_size,
+		  attr.map_name, map_idx, map_type, value_size,
 		  attr.btf_value_type_id);
 	emit_check_err(gen);
 	/* remember map_fd in the stack, if successful */
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index de7e09a6b5ec..b62a05429c64 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4820,19 +4820,16 @@ static void bpf_map__destroy(struct bpf_map *map);
 
 static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, bool is_inner)
 {
-	struct bpf_create_map_params create_attr;
+	LIBBPF_OPTS(bpf_map_create_opts, create_attr);
 	struct bpf_map_def *def = &map->def;
+	const char *map_name = NULL;
+	__u32 max_entries;
 	int err = 0;
 
-	memset(&create_attr, 0, sizeof(create_attr));
-
 	if (kernel_supports(obj, FEAT_PROG_NAME))
-		create_attr.name = map->name;
+		map_name = map->name;
 	create_attr.map_ifindex = map->map_ifindex;
-	create_attr.map_type = def->type;
 	create_attr.map_flags = def->map_flags;
-	create_attr.key_size = def->key_size;
-	create_attr.value_size = def->value_size;
 	create_attr.numa_node = map->numa_node;
 	create_attr.map_extra = map->map_extra;
 
@@ -4846,18 +4843,14 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 			return nr_cpus;
 		}
 		pr_debug("map '%s': setting size to %d\n", map->name, nr_cpus);
-		create_attr.max_entries = nr_cpus;
+		max_entries = nr_cpus;
 	} else {
-		create_attr.max_entries = def->max_entries;
+		max_entries = def->max_entries;
 	}
 
 	if (bpf_map__is_struct_ops(map))
-		create_attr.btf_vmlinux_value_type_id =
-			map->btf_vmlinux_value_type_id;
+		create_attr.btf_vmlinux_value_type_id = map->btf_vmlinux_value_type_id;
 
-	create_attr.btf_fd = 0;
-	create_attr.btf_key_type_id = 0;
-	create_attr.btf_value_type_id = 0;
 	if (obj->btf && btf__fd(obj->btf) >= 0 && !bpf_map_find_btf_info(obj, map)) {
 		create_attr.btf_fd = btf__fd(obj->btf);
 		create_attr.btf_key_type_id = map->btf_key_type_id;
@@ -4903,13 +4896,17 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 	}
 
 	if (obj->gen_loader) {
-		bpf_gen__map_create(obj->gen_loader, &create_attr, is_inner ? -1 : map - obj->maps);
+		bpf_gen__map_create(obj->gen_loader, def->type, map_name,
+				    def->key_size, def->value_size, max_entries,
+				    &create_attr, is_inner ? -1 : map - obj->maps);
 		/* Pretend to have valid FD to pass various fd >= 0 checks.
 		 * This fd == 0 will not be used with any syscall and will be reset to -1 eventually.
 		 */
 		map->fd = 0;
 	} else {
-		map->fd = libbpf__bpf_create_map_xattr(&create_attr);
+		map->fd = bpf_map_create(def->type, map_name,
+					 def->key_size, def->value_size,
+					 max_entries, &create_attr);
 	}
 	if (map->fd < 0 && (create_attr.btf_key_type_id ||
 			    create_attr.btf_value_type_id)) {
@@ -4924,7 +4921,9 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 		create_attr.btf_value_type_id = 0;
 		map->btf_key_type_id = 0;
 		map->btf_value_type_id = 0;
-		map->fd = libbpf__bpf_create_map_xattr(&create_attr);
+		map->fd = bpf_map_create(def->type, map_name,
+					 def->key_size, def->value_size,
+					 max_entries, &create_attr);
 	}
 
 	err = map->fd < 0 ? -errno : 0;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 6a59514a48cf..c420f629b26c 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -391,6 +391,7 @@ LIBBPF_0.6.0 {
 	global:
 		bpf_map__map_extra;
 		bpf_map__set_map_extra;
+		bpf_map_create;
 		bpf_object__next_map;
 		bpf_object__next_program;
 		bpf_object__prev_map;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index f7ac349650a1..311905d8ca70 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -278,27 +278,6 @@ int parse_cpu_mask_file(const char *fcpu, bool **mask, int *mask_sz);
 int libbpf__load_raw_btf(const char *raw_types, size_t types_len,
 			 const char *str_sec, size_t str_len);
 
-struct bpf_create_map_params {
-	const char *name;
-	enum bpf_map_type map_type;
-	__u32 map_flags;
-	__u32 key_size;
-	__u32 value_size;
-	__u32 max_entries;
-	__u32 numa_node;
-	__u32 btf_fd;
-	__u32 btf_key_type_id;
-	__u32 btf_value_type_id;
-	__u32 map_ifindex;
-	union {
-		__u32 inner_map_fd;
-		__u32 btf_vmlinux_value_type_id;
-	};
-	__u64 map_extra;
-};
-
-int libbpf__bpf_create_map_xattr(const struct bpf_create_map_params *create_attr);
-
 struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf);
 void btf_get_kernel_prefix_kind(enum bpf_attach_type attach_type,
 				const char **prefix, int *kind);
-- 
2.30.2

