Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4F54659DB
	for <lists+bpf@lfdr.de>; Thu,  2 Dec 2021 00:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353785AbhLAXcc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 1 Dec 2021 18:32:32 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1894 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353790AbhLAXc3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 1 Dec 2021 18:32:29 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1LcgQG026312
        for <bpf@vger.kernel.org>; Wed, 1 Dec 2021 15:29:07 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cpd6atnwc-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 15:29:07 -0800
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 15:28:46 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 55577B7A0B0F; Wed,  1 Dec 2021 15:28:41 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>
Subject: [PATCH bpf-next 8/9] samples/bpf: get rid of deprecated libbpf API uses
Date:   Wed, 1 Dec 2021 15:28:23 -0800
Message-ID: <20211201232824.3166325-9-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211201232824.3166325-1-andrii@kernel.org>
References: <20211201232824.3166325-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: JR46j9_jdIsvab8z8Plc3KjEtG7lGrGL
X-Proofpoint-GUID: JR46j9_jdIsvab8z8Plc3KjEtG7lGrGL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-12-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Replace deprecated APIs with new ones. Also mute source code using
deprecated AF_XDP (xsk.h). Figuring out what to do with all the AF_XDP
stuff is a separate problem that should be solved with its own set of
changes.

Cc: Toke Høiland-Jørgensen <toke@redhat.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 samples/bpf/cookie_uid_helper_example.c | 14 +++++++++-----
 samples/bpf/fds_example.c               | 24 +++++++++++++++---------
 samples/bpf/map_perf_test_user.c        | 15 +++++++++------
 samples/bpf/sock_example.c              | 12 ++++++++----
 samples/bpf/sockex1_user.c              | 15 ++++++++++++---
 samples/bpf/sockex2_user.c              | 14 +++++++++++---
 samples/bpf/test_cgrp2_array_pin.c      |  4 ++--
 samples/bpf/test_cgrp2_attach.c         | 13 ++++++++-----
 samples/bpf/test_cgrp2_sock.c           |  8 ++++++--
 samples/bpf/test_lru_dist.c             | 11 +++++++----
 samples/bpf/trace_output_user.c         |  4 +---
 samples/bpf/xdp_sample_pkts_user.c      | 22 +++++++++++-----------
 samples/bpf/xdpsock_ctrl_proc.c         |  3 +++
 samples/bpf/xdpsock_user.c              |  3 +++
 samples/bpf/xsk_fwd.c                   |  3 +++
 15 files changed, 108 insertions(+), 57 deletions(-)

diff --git a/samples/bpf/cookie_uid_helper_example.c b/samples/bpf/cookie_uid_helper_example.c
index 54958802c032..f0df3dda4b1f 100644
--- a/samples/bpf/cookie_uid_helper_example.c
+++ b/samples/bpf/cookie_uid_helper_example.c
@@ -67,8 +67,8 @@ static bool test_finish;
 
 static void maps_create(void)
 {
-	map_fd = bpf_create_map(BPF_MAP_TYPE_HASH, sizeof(uint32_t),
-				sizeof(struct stats), 100, 0);
+	map_fd = bpf_map_create(BPF_MAP_TYPE_HASH, NULL, sizeof(uint32_t),
+				sizeof(struct stats), 100, NULL);
 	if (map_fd < 0)
 		error(1, errno, "map create failed!\n");
 }
@@ -157,9 +157,13 @@ static void prog_load(void)
 				offsetof(struct __sk_buff, len)),
 		BPF_EXIT_INSN(),
 	};
-	prog_fd = bpf_load_program(BPF_PROG_TYPE_SOCKET_FILTER, prog,
-					ARRAY_SIZE(prog), "GPL", 0,
-					log_buf, sizeof(log_buf));
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		.log_buf = log_buf,
+		.log_size = sizeof(log_buf),
+	);
+
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL",
+				prog, ARRAY_SIZE(prog), &opts);
 	if (prog_fd < 0)
 		error(1, errno, "failed to load prog\n%s\n", log_buf);
 }
diff --git a/samples/bpf/fds_example.c b/samples/bpf/fds_example.c
index 9a7c1fd7a4a8..16dbf49e0f19 100644
--- a/samples/bpf/fds_example.c
+++ b/samples/bpf/fds_example.c
@@ -54,16 +54,22 @@ static int bpf_prog_create(const char *object)
 	};
 	size_t insns_cnt = sizeof(insns) / sizeof(struct bpf_insn);
 	struct bpf_object *obj;
-	int prog_fd;
+	int err;
 
 	if (object) {
-		assert(!bpf_prog_load(object, BPF_PROG_TYPE_UNSPEC,
-				      &obj, &prog_fd));
-		return prog_fd;
+		obj = bpf_object__open_file(object, NULL);
+		assert(!libbpf_get_error(obj));
+		err = bpf_object__load(obj);
+		assert(!err);
+		return bpf_program__fd(bpf_object__next_program(obj, NULL));
 	} else {
-		return bpf_load_program(BPF_PROG_TYPE_SOCKET_FILTER,
-					insns, insns_cnt, "GPL", 0,
-					bpf_log_buf, BPF_LOG_BUF_SIZE);
+		LIBBPF_OPTS(bpf_prog_load_opts, opts,
+			.log_buf = bpf_log_buf,
+			.log_size = BPF_LOG_BUF_SIZE,
+		);
+
+		return bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL",
+				     insns, insns_cnt, &opts);
 	}
 }
 
@@ -73,8 +79,8 @@ static int bpf_do_map(const char *file, uint32_t flags, uint32_t key,
 	int fd, ret;
 
 	if (flags & BPF_F_PIN) {
-		fd = bpf_create_map(BPF_MAP_TYPE_ARRAY, sizeof(uint32_t),
-				    sizeof(uint32_t), 1024, 0);
+		fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, sizeof(uint32_t),
+				    sizeof(uint32_t), 1024, NULL);
 		printf("bpf: map fd:%d (%s)\n", fd, strerror(errno));
 		assert(fd > 0);
 
diff --git a/samples/bpf/map_perf_test_user.c b/samples/bpf/map_perf_test_user.c
index 9db949290a78..319fd31522f3 100644
--- a/samples/bpf/map_perf_test_user.c
+++ b/samples/bpf/map_perf_test_user.c
@@ -134,19 +134,22 @@ static void do_test_lru(enum test_type test, int cpu)
 		 */
 		int outer_fd = map_fd[array_of_lru_hashs_idx];
 		unsigned int mycpu, mynode;
+		LIBBPF_OPTS(bpf_map_create_opts, opts,
+			.map_flags = BPF_F_NUMA_NODE,
+		);
 
 		assert(cpu < MAX_NR_CPUS);
 
 		ret = syscall(__NR_getcpu, &mycpu, &mynode, NULL);
 		assert(!ret);
 
+		opts.numa_node = mynode;
 		inner_lru_map_fds[cpu] =
-			bpf_create_map_node(BPF_MAP_TYPE_LRU_HASH,
-					    test_map_names[INNER_LRU_HASH_PREALLOC],
-					    sizeof(uint32_t),
-					    sizeof(long),
-					    inner_lru_hash_size, 0,
-					    mynode);
+			bpf_map_create(BPF_MAP_TYPE_LRU_HASH,
+				       test_map_names[INNER_LRU_HASH_PREALLOC],
+				       sizeof(uint32_t),
+				       sizeof(long),
+				       inner_lru_hash_size, &opts);
 		if (inner_lru_map_fds[cpu] == -1) {
 			printf("cannot create BPF_MAP_TYPE_LRU_HASH %s(%d)\n",
 			       strerror(errno), errno);
diff --git a/samples/bpf/sock_example.c b/samples/bpf/sock_example.c
index 23d1930e1927..a88f69504c08 100644
--- a/samples/bpf/sock_example.c
+++ b/samples/bpf/sock_example.c
@@ -37,8 +37,8 @@ static int test_sock(void)
 	int sock = -1, map_fd, prog_fd, i, key;
 	long long value = 0, tcp_cnt, udp_cnt, icmp_cnt;
 
-	map_fd = bpf_create_map(BPF_MAP_TYPE_ARRAY, sizeof(key), sizeof(value),
-				256, 0);
+	map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, sizeof(key), sizeof(value),
+				256, NULL);
 	if (map_fd < 0) {
 		printf("failed to create map '%s'\n", strerror(errno));
 		goto cleanup;
@@ -59,9 +59,13 @@ static int test_sock(void)
 		BPF_EXIT_INSN(),
 	};
 	size_t insns_cnt = sizeof(prog) / sizeof(struct bpf_insn);
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		.log_buf = bpf_log_buf,
+		.log_size = BPF_LOG_BUF_SIZE,
+	);
 
-	prog_fd = bpf_load_program(BPF_PROG_TYPE_SOCKET_FILTER, prog, insns_cnt,
-				   "GPL", 0, bpf_log_buf, BPF_LOG_BUF_SIZE);
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL",
+				prog, insns_cnt, &opts);
 	if (prog_fd < 0) {
 		printf("failed to load prog '%s'\n", strerror(errno));
 		goto cleanup;
diff --git a/samples/bpf/sockex1_user.c b/samples/bpf/sockex1_user.c
index 3c83722877dc..9e8d39e245c1 100644
--- a/samples/bpf/sockex1_user.c
+++ b/samples/bpf/sockex1_user.c
@@ -11,17 +11,26 @@
 int main(int ac, char **argv)
 {
 	struct bpf_object *obj;
+	struct bpf_program *prog;
 	int map_fd, prog_fd;
 	char filename[256];
-	int i, sock;
+	int i, sock, err;
 	FILE *f;
 
 	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
 
-	if (bpf_prog_load(filename, BPF_PROG_TYPE_SOCKET_FILTER,
-			  &obj, &prog_fd))
+	obj = bpf_object__open_file(filename, NULL);
+	if (libbpf_get_error(obj))
 		return 1;
 
+	prog = bpf_object__next_program(obj, NULL);
+	bpf_program__set_type(prog, BPF_PROG_TYPE_SOCKET_FILTER);
+
+	err = bpf_object__load(obj);
+	if (err)
+		return 1;
+
+	prog_fd = bpf_program__fd(prog);
 	map_fd = bpf_object__find_map_fd_by_name(obj, "my_map");
 
 	sock = open_raw_sock("lo");
diff --git a/samples/bpf/sockex2_user.c b/samples/bpf/sockex2_user.c
index bafa567b840c..6a3fd369d3fc 100644
--- a/samples/bpf/sockex2_user.c
+++ b/samples/bpf/sockex2_user.c
@@ -16,18 +16,26 @@ struct pair {
 
 int main(int ac, char **argv)
 {
+	struct bpf_program *prog;
 	struct bpf_object *obj;
 	int map_fd, prog_fd;
 	char filename[256];
-	int i, sock;
+	int i, sock, err;
 	FILE *f;
 
 	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
+	obj = bpf_object__open_file(filename, NULL);
+	if (libbpf_get_error(obj))
+		return 1;
+
+	prog = bpf_object__next_program(obj, NULL);
+	bpf_program__set_type(prog, BPF_PROG_TYPE_SOCKET_FILTER);
 
-	if (bpf_prog_load(filename, BPF_PROG_TYPE_SOCKET_FILTER,
-			  &obj, &prog_fd))
+	err = bpf_object__load(obj);
+	if (err)
 		return 1;
 
+	prog_fd = bpf_program__fd(prog);
 	map_fd = bpf_object__find_map_fd_by_name(obj, "hash_map");
 
 	sock = open_raw_sock("lo");
diff --git a/samples/bpf/test_cgrp2_array_pin.c b/samples/bpf/test_cgrp2_array_pin.c
index 6d564aa75447..05e88aa63009 100644
--- a/samples/bpf/test_cgrp2_array_pin.c
+++ b/samples/bpf/test_cgrp2_array_pin.c
@@ -64,9 +64,9 @@ int main(int argc, char **argv)
 	}
 
 	if (create_array) {
-		array_fd = bpf_create_map(BPF_MAP_TYPE_CGROUP_ARRAY,
+		array_fd = bpf_map_create(BPF_MAP_TYPE_CGROUP_ARRAY, NULL,
 					  sizeof(uint32_t), sizeof(uint32_t),
-					  1, 0);
+					  1, NULL);
 		if (array_fd < 0) {
 			fprintf(stderr,
 				"bpf_create_map(BPF_MAP_TYPE_CGROUP_ARRAY,...): %s(%d)\n",
diff --git a/samples/bpf/test_cgrp2_attach.c b/samples/bpf/test_cgrp2_attach.c
index 390ff38d2ac6..6d90874b09c3 100644
--- a/samples/bpf/test_cgrp2_attach.c
+++ b/samples/bpf/test_cgrp2_attach.c
@@ -71,10 +71,13 @@ static int prog_load(int map_fd, int verdict)
 		BPF_EXIT_INSN(),
 	};
 	size_t insns_cnt = sizeof(prog) / sizeof(struct bpf_insn);
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		.log_buf = bpf_log_buf,
+		.log_size = BPF_LOG_BUF_SIZE,
+	);
 
-	return bpf_load_program(BPF_PROG_TYPE_CGROUP_SKB,
-				prog, insns_cnt, "GPL", 0,
-				bpf_log_buf, BPF_LOG_BUF_SIZE);
+	return bpf_prog_load(BPF_PROG_TYPE_CGROUP_SKB, NULL, "GPL",
+			     prog, insns_cnt, &opts);
 }
 
 static int usage(const char *argv0)
@@ -90,9 +93,9 @@ static int attach_filter(int cg_fd, int type, int verdict)
 	int prog_fd, map_fd, ret, key;
 	long long pkt_cnt, byte_cnt;
 
-	map_fd = bpf_create_map(BPF_MAP_TYPE_ARRAY,
+	map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL,
 				sizeof(key), sizeof(byte_cnt),
-				256, 0);
+				256, NULL);
 	if (map_fd < 0) {
 		printf("Failed to create map: '%s'\n", strerror(errno));
 		return EXIT_FAILURE;
diff --git a/samples/bpf/test_cgrp2_sock.c b/samples/bpf/test_cgrp2_sock.c
index b0811da5a00f..a0811df888f4 100644
--- a/samples/bpf/test_cgrp2_sock.c
+++ b/samples/bpf/test_cgrp2_sock.c
@@ -70,6 +70,10 @@ static int prog_load(__u32 idx, __u32 mark, __u32 prio)
 		BPF_MOV64_IMM(BPF_REG_2, offsetof(struct bpf_sock, priority)),
 		BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_3, offsetof(struct bpf_sock, priority)),
 	};
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		.log_buf = bpf_log_buf,
+		.log_size = BPF_LOG_BUF_SIZE,
+	);
 
 	struct bpf_insn *prog;
 	size_t insns_cnt;
@@ -115,8 +119,8 @@ static int prog_load(__u32 idx, __u32 mark, __u32 prio)
 
 	insns_cnt /= sizeof(struct bpf_insn);
 
-	ret = bpf_load_program(BPF_PROG_TYPE_CGROUP_SOCK, prog, insns_cnt,
-				"GPL", 0, bpf_log_buf, BPF_LOG_BUF_SIZE);
+	ret = bpf_prog_load(BPF_PROG_TYPE_CGROUP_SOCK, NULL, "GPL",
+			    prog, insns_cnt, &opts);
 
 	free(prog);
 
diff --git a/samples/bpf/test_lru_dist.c b/samples/bpf/test_lru_dist.c
index c92c5c06b965..75e877853596 100644
--- a/samples/bpf/test_lru_dist.c
+++ b/samples/bpf/test_lru_dist.c
@@ -105,10 +105,10 @@ struct pfect_lru {
 static void pfect_lru_init(struct pfect_lru *lru, unsigned int lru_size,
 			   unsigned int nr_possible_elems)
 {
-	lru->map_fd = bpf_create_map(BPF_MAP_TYPE_HASH,
+	lru->map_fd = bpf_map_create(BPF_MAP_TYPE_HASH, NULL,
 				     sizeof(unsigned long long),
 				     sizeof(struct pfect_lru_node *),
-				     nr_possible_elems, 0);
+				     nr_possible_elems, NULL);
 	assert(lru->map_fd != -1);
 
 	lru->free_nodes = malloc(lru_size * sizeof(struct pfect_lru_node));
@@ -207,10 +207,13 @@ static unsigned int read_keys(const char *dist_file,
 
 static int create_map(int map_type, int map_flags, unsigned int size)
 {
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		.map_flags = map_flags,
+	);
 	int map_fd;
 
-	map_fd = bpf_create_map(map_type, sizeof(unsigned long long),
-				sizeof(unsigned long long), size, map_flags);
+	map_fd = bpf_map_create(map_type, NULL, sizeof(unsigned long long),
+				sizeof(unsigned long long), size, &opts);
 
 	if (map_fd == -1)
 		perror("bpf_create_map");
diff --git a/samples/bpf/trace_output_user.c b/samples/bpf/trace_output_user.c
index 364b98764d54..371732f9cf8e 100644
--- a/samples/bpf/trace_output_user.c
+++ b/samples/bpf/trace_output_user.c
@@ -43,7 +43,6 @@ static void print_bpf_output(void *ctx, int cpu, void *data, __u32 size)
 
 int main(int argc, char **argv)
 {
-	struct perf_buffer_opts pb_opts = {};
 	struct bpf_link *link = NULL;
 	struct bpf_program *prog;
 	struct perf_buffer *pb;
@@ -84,8 +83,7 @@ int main(int argc, char **argv)
 		goto cleanup;
 	}
 
-	pb_opts.sample_cb = print_bpf_output;
-	pb = perf_buffer__new(map_fd, 8, &pb_opts);
+	pb = perf_buffer__new(map_fd, 8, print_bpf_output, NULL, NULL, NULL);
 	ret = libbpf_get_error(pb);
 	if (ret) {
 		printf("failed to setup perf_buffer: %d\n", ret);
diff --git a/samples/bpf/xdp_sample_pkts_user.c b/samples/bpf/xdp_sample_pkts_user.c
index f4382ccdcbb1..587eacb49103 100644
--- a/samples/bpf/xdp_sample_pkts_user.c
+++ b/samples/bpf/xdp_sample_pkts_user.c
@@ -110,12 +110,9 @@ static void usage(const char *prog)
 
 int main(int argc, char **argv)
 {
-	struct bpf_prog_load_attr prog_load_attr = {
-		.prog_type	= BPF_PROG_TYPE_XDP,
-	};
-	struct perf_buffer_opts pb_opts = {};
 	const char *optstr = "FS";
 	int prog_fd, map_fd, opt;
+	struct bpf_program *prog;
 	struct bpf_object *obj;
 	struct bpf_map *map;
 	char filename[256];
@@ -144,15 +141,19 @@ int main(int argc, char **argv)
 	}
 
 	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
-	prog_load_attr.file = filename;
 
-	if (bpf_prog_load_xattr(&prog_load_attr, &obj, &prog_fd))
+	obj = bpf_object__open_file(filename, NULL);
+	if (libbpf_get_error(obj))
 		return 1;
 
-	if (!prog_fd) {
-		printf("bpf_prog_load_xattr: %s\n", strerror(errno));
+	prog = bpf_object__next_program(obj, NULL);
+	bpf_program__set_type(prog, BPF_PROG_TYPE_XDP);
+
+	err = bpf_object__load(obj);
+	if (err)
 		return 1;
-	}
+
+	prog_fd = bpf_program__fd(prog);
 
 	map = bpf_object__next_map(obj, NULL);
 	if (!map) {
@@ -181,8 +182,7 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
-	pb_opts.sample_cb = print_bpf_output;
-	pb = perf_buffer__new(map_fd, 8, &pb_opts);
+	pb = perf_buffer__new(map_fd, 8, print_bpf_output, NULL, NULL, NULL);
 	err = libbpf_get_error(pb);
 	if (err) {
 		perror("perf_buffer setup failed");
diff --git a/samples/bpf/xdpsock_ctrl_proc.c b/samples/bpf/xdpsock_ctrl_proc.c
index 384e62e3c6d6..cc4408797ab7 100644
--- a/samples/bpf/xdpsock_ctrl_proc.c
+++ b/samples/bpf/xdpsock_ctrl_proc.c
@@ -15,6 +15,9 @@
 #include <bpf/xsk.h>
 #include "xdpsock.h"
 
+/* libbpf APIs for AF_XDP are deprecated starting from v0.7 */
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
+
 static const char *opt_if = "";
 
 static struct option long_options[] = {
diff --git a/samples/bpf/xdpsock_user.c b/samples/bpf/xdpsock_user.c
index 49d7a6ad7e39..616d663d55aa 100644
--- a/samples/bpf/xdpsock_user.c
+++ b/samples/bpf/xdpsock_user.c
@@ -36,6 +36,9 @@
 #include <bpf/bpf.h>
 #include "xdpsock.h"
 
+/* libbpf APIs for AF_XDP are deprecated starting from v0.7 */
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
+
 #ifndef SOL_XDP
 #define SOL_XDP 283
 #endif
diff --git a/samples/bpf/xsk_fwd.c b/samples/bpf/xsk_fwd.c
index 1cd97c84c337..52e7c4ffd228 100644
--- a/samples/bpf/xsk_fwd.c
+++ b/samples/bpf/xsk_fwd.c
@@ -27,6 +27,9 @@
 #include <bpf/xsk.h>
 #include <bpf/bpf.h>
 
+/* libbpf APIs for AF_XDP are deprecated starting from v0.7 */
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
+
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
 typedef __u64 u64;
-- 
2.30.2

