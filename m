Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557964551C9
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 01:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241994AbhKRAk3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 17 Nov 2021 19:40:29 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34176 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232441AbhKRAk1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Nov 2021 19:40:27 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHLeHsr007037
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 16:37:27 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3ccyjw5u6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 16:37:27 -0800
Received: from intmgw001.27.prn2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 17 Nov 2021 16:37:27 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 75CD7996140D; Wed, 17 Nov 2021 16:34:29 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/4] libbpf: use bpf_map_create() consistently internally
Date:   Wed, 17 Nov 2021 16:34:21 -0800
Message-ID: <20211118003423.1885869-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211118003423.1885869-1-andrii@kernel.org>
References: <20211118003423.1885869-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 5vgoIdaq3YZA37xg2nExIEbDj61cVp2h
X-Proofpoint-GUID: 5vgoIdaq3YZA37xg2nExIEbDj61cVp2h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_09,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 mlxlogscore=907 mlxscore=0
 clxscore=1034 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove all the remaining uses of to-be-deprecated bpf_create_map*() APIs.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c        | 30 ++++++------------------------
 tools/lib/bpf/libbpf_probes.c | 30 +++++++++++++++---------------
 tools/lib/bpf/skel_internal.h |  3 +--
 tools/lib/bpf/xsk.c           | 13 +++----------
 4 files changed, 25 insertions(+), 51 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b62a05429c64..17bde230bd7e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4342,7 +4342,6 @@ static int probe_kern_prog_name(void)
 
 static int probe_kern_global_data(void)
 {
-	struct bpf_create_map_attr map_attr;
 	char *cp, errmsg[STRERR_BUFSIZE];
 	struct bpf_insn insns[] = {
 		BPF_LD_MAP_VALUE(BPF_REG_1, 0, 16),
@@ -4352,13 +4351,7 @@ static int probe_kern_global_data(void)
 	};
 	int ret, map, insn_cnt = ARRAY_SIZE(insns);
 
-	memset(&map_attr, 0, sizeof(map_attr));
-	map_attr.map_type = BPF_MAP_TYPE_ARRAY;
-	map_attr.key_size = sizeof(int);
-	map_attr.value_size = 32;
-	map_attr.max_entries = 1;
-
-	map = bpf_create_map_xattr(&map_attr);
+	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, sizeof(int), 32, 1, NULL);
 	if (map < 0) {
 		ret = -errno;
 		cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
@@ -4488,15 +4481,11 @@ static int probe_kern_btf_type_tag(void)
 
 static int probe_kern_array_mmap(void)
 {
-	struct bpf_create_map_attr attr = {
-		.map_type = BPF_MAP_TYPE_ARRAY,
-		.map_flags = BPF_F_MMAPABLE,
-		.key_size = sizeof(int),
-		.value_size = sizeof(int),
-		.max_entries = 1,
-	};
+	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_MMAPABLE);
+	int fd;
 
-	return probe_fd(bpf_create_map_xattr(&attr));
+	fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, sizeof(int), sizeof(int), 1, &opts);
+	return probe_fd(fd);
 }
 
 static int probe_kern_exp_attach_type(void)
@@ -4535,7 +4524,6 @@ static int probe_kern_probe_read_kernel(void)
 
 static int probe_prog_bind_map(void)
 {
-	struct bpf_create_map_attr map_attr;
 	char *cp, errmsg[STRERR_BUFSIZE];
 	struct bpf_insn insns[] = {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -4543,13 +4531,7 @@ static int probe_prog_bind_map(void)
 	};
 	int ret, map, prog, insn_cnt = ARRAY_SIZE(insns);
 
-	memset(&map_attr, 0, sizeof(map_attr));
-	map_attr.map_type = BPF_MAP_TYPE_ARRAY;
-	map_attr.key_size = sizeof(int);
-	map_attr.value_size = 32;
-	map_attr.max_entries = 1;
-
-	map = bpf_create_map_xattr(&map_attr);
+	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, sizeof(int), 32, 1, NULL);
 	if (map < 0) {
 		ret = -errno;
 		cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 02c401e314c7..41f2be47c2ea 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -201,7 +201,6 @@ bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex)
 {
 	int key_size, value_size, max_entries, map_flags;
 	__u32 btf_key_type_id = 0, btf_value_type_id = 0;
-	struct bpf_create_map_attr attr = {};
 	int fd = -1, btf_fd = -1, fd_inner;
 
 	key_size	= sizeof(__u32);
@@ -271,34 +270,35 @@ bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex)
 
 	if (map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS ||
 	    map_type == BPF_MAP_TYPE_HASH_OF_MAPS) {
+		LIBBPF_OPTS(bpf_map_create_opts, opts);
+
 		/* TODO: probe for device, once libbpf has a function to create
 		 * map-in-map for offload
 		 */
 		if (ifindex)
 			return false;
 
-		fd_inner = bpf_create_map(BPF_MAP_TYPE_HASH,
-					  sizeof(__u32), sizeof(__u32), 1, 0);
+		fd_inner = bpf_map_create(BPF_MAP_TYPE_HASH, NULL,
+					  sizeof(__u32), sizeof(__u32), 1, NULL);
 		if (fd_inner < 0)
 			return false;
-		fd = bpf_create_map_in_map(map_type, NULL, sizeof(__u32),
-					   fd_inner, 1, 0);
+
+		opts.inner_map_fd = fd_inner;
+		fd = bpf_map_create(map_type, NULL, sizeof(__u32), sizeof(__u32), 1, &opts);
 		close(fd_inner);
 	} else {
+		LIBBPF_OPTS(bpf_map_create_opts, opts);
+
 		/* Note: No other restriction on map type probes for offload */
-		attr.map_type = map_type;
-		attr.key_size = key_size;
-		attr.value_size = value_size;
-		attr.max_entries = max_entries;
-		attr.map_flags = map_flags;
-		attr.map_ifindex = ifindex;
+		opts.map_flags = map_flags;
+		opts.map_ifindex = ifindex;
 		if (btf_fd >= 0) {
-			attr.btf_fd = btf_fd;
-			attr.btf_key_type_id = btf_key_type_id;
-			attr.btf_value_type_id = btf_value_type_id;
+			opts.btf_fd = btf_fd;
+			opts.btf_key_type_id = btf_key_type_id;
+			opts.btf_value_type_id = btf_value_type_id;
 		}
 
-		fd = bpf_create_map_xattr(&attr);
+		fd = bpf_map_create(map_type, NULL, key_size, value_size, max_entries, &opts);
 	}
 	if (fd >= 0)
 		close(fd);
diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
index 9cf66702fa8d..b206532704ce 100644
--- a/tools/lib/bpf/skel_internal.h
+++ b/tools/lib/bpf/skel_internal.h
@@ -65,8 +65,7 @@ static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
 	int map_fd = -1, prog_fd = -1, key = 0, err;
 	union bpf_attr attr;
 
-	map_fd = bpf_create_map_name(BPF_MAP_TYPE_ARRAY, "__loader.map", 4,
-				     opts->data_sz, 1, 0);
+	map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "__loader.map", 4, opts->data_sz, 1, NULL);
 	if (map_fd < 0) {
 		opts->errstr = "failed to create loader map";
 		err = -errno;
diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
index fdb22f5405c9..f1c29074d527 100644
--- a/tools/lib/bpf/xsk.c
+++ b/tools/lib/bpf/xsk.c
@@ -364,7 +364,6 @@ int xsk_umem__create_v0_0_2(struct xsk_umem **umem_ptr, void *umem_area,
 static enum xsk_prog get_xsk_prog(void)
 {
 	enum xsk_prog detected = XSK_PROG_FALLBACK;
-	struct bpf_create_map_attr map_attr;
 	__u32 size_out, retval, duration;
 	char data_in = 0, data_out;
 	struct bpf_insn insns[] = {
@@ -376,13 +375,7 @@ static enum xsk_prog get_xsk_prog(void)
 	};
 	int prog_fd, map_fd, ret, insn_cnt = ARRAY_SIZE(insns);
 
-	memset(&map_attr, 0, sizeof(map_attr));
-	map_attr.map_type = BPF_MAP_TYPE_XSKMAP;
-	map_attr.key_size = sizeof(int);
-	map_attr.value_size = sizeof(int);
-	map_attr.max_entries = 1;
-
-	map_fd = bpf_create_map_xattr(&map_attr);
+	map_fd = bpf_map_create(BPF_MAP_TYPE_XSKMAP, NULL, sizeof(int), sizeof(int), 1, NULL);
 	if (map_fd < 0)
 		return detected;
 
@@ -586,8 +579,8 @@ static int xsk_create_bpf_maps(struct xsk_socket *xsk)
 	if (max_queues < 0)
 		return max_queues;
 
-	fd = bpf_create_map_name(BPF_MAP_TYPE_XSKMAP, "xsks_map",
-				 sizeof(int), sizeof(int), max_queues, 0);
+	fd = bpf_map_create(BPF_MAP_TYPE_XSKMAP, "xsks_map",
+			    sizeof(int), sizeof(int), max_queues, NULL);
 	if (fd < 0)
 		return fd;
 
-- 
2.30.2

