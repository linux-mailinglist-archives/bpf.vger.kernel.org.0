Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1CF4659DC
	for <lists+bpf@lfdr.de>; Thu,  2 Dec 2021 00:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353788AbhLAXcm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 1 Dec 2021 18:32:42 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5276 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353780AbhLAXcl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 1 Dec 2021 18:32:41 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1LdGLh021041
        for <bpf@vger.kernel.org>; Wed, 1 Dec 2021 15:29:20 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cp3ms6r2k-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 15:29:20 -0800
Received: from intmgw001.46.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 15:28:39 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 388D1B7A0B01; Wed,  1 Dec 2021 15:28:37 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 6/9] selftests/bpf: remove all the uses of deprecated bpf_prog_load_xattr()
Date:   Wed, 1 Dec 2021 15:28:21 -0800
Message-ID: <20211201232824.3166325-7-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211201232824.3166325-1-andrii@kernel.org>
References: <20211201232824.3166325-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: krFyP4hVJZ92REXx-lweks5H9Qq6CJOI
X-Proofpoint-GUID: krFyP4hVJZ92REXx-lweks5H9Qq6CJOI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-12-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Migrate all the selftests that were still using bpf_prog_load_xattr().
Few are converted to skeleton, others will use bpf_object__open_file()
API.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/prog_tests/bpf_verif_scale.c          | 30 +++++++---
 .../bpf/prog_tests/connect_force_port.c       | 17 +++---
 .../selftests/bpf/prog_tests/kfree_skb.c      | 58 ++++++-------------
 .../bpf/prog_tests/sockopt_inherit.c          | 12 ++--
 .../selftests/bpf/prog_tests/sockopt_multi.c  | 12 ++--
 .../selftests/bpf/prog_tests/tcp_rtt.c        | 21 +++----
 .../bpf/prog_tests/test_global_funcs.c        | 28 ++++++---
 tools/testing/selftests/bpf/test_sock_addr.c  | 33 +++++++----
 .../selftests/bpf/xdp_redirect_multi.c        | 15 ++---
 9 files changed, 119 insertions(+), 107 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
index 1fb16f8dad56..ff6cce9fef06 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
@@ -19,16 +19,28 @@ extern int extra_prog_load_log_flags;
 
 static int check_load(const char *file, enum bpf_prog_type type)
 {
-	struct bpf_prog_load_attr attr;
 	struct bpf_object *obj = NULL;
-	int err, prog_fd;
-
-	memset(&attr, 0, sizeof(struct bpf_prog_load_attr));
-	attr.file = file;
-	attr.prog_type = type;
-	attr.log_level = 4 | extra_prog_load_log_flags;
-	attr.prog_flags = BPF_F_TEST_RND_HI32;
-	err = bpf_prog_load_xattr(&attr, &obj, &prog_fd);
+	struct bpf_program *prog;
+	int err;
+
+	obj = bpf_object__open_file(file, NULL);
+	err = libbpf_get_error(obj);
+	if (err)
+		return err;
+
+	prog = bpf_object__next_program(obj, NULL);
+	if (!prog) {
+		err = -ENOENT;
+		goto err_out;
+	}
+
+	bpf_program__set_type(prog, type);
+	bpf_program__set_flags(prog, BPF_F_TEST_RND_HI32);
+	bpf_program__set_log_level(prog, 4 | extra_prog_load_log_flags);
+
+	err = bpf_object__load(obj);
+
+err_out:
 	bpf_object__close(obj);
 	return err;
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/connect_force_port.c b/tools/testing/selftests/bpf/prog_tests/connect_force_port.c
index 9229db2f5ca5..ca574e1e30e6 100644
--- a/tools/testing/selftests/bpf/prog_tests/connect_force_port.c
+++ b/tools/testing/selftests/bpf/prog_tests/connect_force_port.c
@@ -51,19 +51,20 @@ static int run_test(int cgroup_fd, int server_fd, int family, int type)
 	bool v4 = family == AF_INET;
 	__u16 expected_local_port = v4 ? 22222 : 22223;
 	__u16 expected_peer_port = 60000;
-	struct bpf_prog_load_attr attr = {
-		.file = v4 ? "./connect_force_port4.o" :
-			     "./connect_force_port6.o",
-	};
 	struct bpf_program *prog;
 	struct bpf_object *obj;
-	int xlate_fd, fd, err;
+	const char *obj_file = v4 ? "connect_force_port4.o" : "connect_force_port6.o";
+	int fd, err;
 	__u32 duration = 0;
 
-	err = bpf_prog_load_xattr(&attr, &obj, &xlate_fd);
-	if (err) {
-		log_err("Failed to load BPF object");
+	obj = bpf_object__open_file(obj_file, NULL);
+	if (!ASSERT_OK_PTR(obj, "bpf_obj_open"))
 		return -1;
+
+	err = bpf_object__load(obj);
+	if (!ASSERT_OK(err, "bpf_obj_load")) {
+		err = -EIO;
+		goto close_bpf_object;
 	}
 
 	prog = bpf_object__find_program_by_title(obj, v4 ?
diff --git a/tools/testing/selftests/bpf/prog_tests/kfree_skb.c b/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
index 2a49f8fcde06..ce10d2fc3a6c 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
 #include <network_helpers.h>
+#include "kfree_skb.skel.h"
 
 struct meta {
 	int ifindex;
@@ -58,16 +59,11 @@ void serial_test_kfree_skb(void)
 		.ctx_in = &skb,
 		.ctx_size_in = sizeof(skb),
 	};
-	struct bpf_prog_load_attr attr = {
-		.file = "./kfree_skb.o",
-	};
-
-	struct bpf_link *link = NULL, *link_fentry = NULL, *link_fexit = NULL;
-	struct bpf_map *perf_buf_map, *global_data;
-	struct bpf_program *prog, *fentry, *fexit;
-	struct bpf_object *obj, *obj2 = NULL;
+	struct kfree_skb *skel = NULL;
+	struct bpf_link *link;
+	struct bpf_object *obj;
 	struct perf_buffer *pb = NULL;
-	int err, kfree_skb_fd;
+	int err;
 	bool passed = false;
 	__u32 duration = 0;
 	const int zero = 0;
@@ -78,40 +74,27 @@ void serial_test_kfree_skb(void)
 	if (CHECK(err, "prog_load sched cls", "err %d errno %d\n", err, errno))
 		return;
 
-	err = bpf_prog_load_xattr(&attr, &obj2, &kfree_skb_fd);
-	if (CHECK(err, "prog_load raw tp", "err %d errno %d\n", err, errno))
-		goto close_prog;
-
-	prog = bpf_object__find_program_by_title(obj2, "tp_btf/kfree_skb");
-	if (CHECK(!prog, "find_prog", "prog kfree_skb not found\n"))
-		goto close_prog;
-	fentry = bpf_object__find_program_by_title(obj2, "fentry/eth_type_trans");
-	if (CHECK(!fentry, "find_prog", "prog eth_type_trans not found\n"))
-		goto close_prog;
-	fexit = bpf_object__find_program_by_title(obj2, "fexit/eth_type_trans");
-	if (CHECK(!fexit, "find_prog", "prog eth_type_trans not found\n"))
-		goto close_prog;
-
-	global_data = bpf_object__find_map_by_name(obj2, ".bss");
-	if (CHECK(!global_data, "find global data", "not found\n"))
+	skel = kfree_skb__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "kfree_skb_skel"))
 		goto close_prog;
 
-	link = bpf_program__attach_raw_tracepoint(prog, NULL);
+	link = bpf_program__attach_raw_tracepoint(skel->progs.trace_kfree_skb, NULL);
 	if (!ASSERT_OK_PTR(link, "attach_raw_tp"))
 		goto close_prog;
-	link_fentry = bpf_program__attach_trace(fentry);
-	if (!ASSERT_OK_PTR(link_fentry, "attach fentry"))
-		goto close_prog;
-	link_fexit = bpf_program__attach_trace(fexit);
-	if (!ASSERT_OK_PTR(link_fexit, "attach fexit"))
+	skel->links.trace_kfree_skb = link;
+
+	link = bpf_program__attach_trace(skel->progs.fentry_eth_type_trans);
+	if (!ASSERT_OK_PTR(link, "attach fentry"))
 		goto close_prog;
+	skel->links.fentry_eth_type_trans = link;
 
-	perf_buf_map = bpf_object__find_map_by_name(obj2, "perf_buf_map");
-	if (CHECK(!perf_buf_map, "find_perf_buf_map", "not found\n"))
+	link = bpf_program__attach_trace(skel->progs.fexit_eth_type_trans);
+	if (!ASSERT_OK_PTR(link, "attach fexit"))
 		goto close_prog;
+	skel->links.fexit_eth_type_trans = link;
 
 	/* set up perf buffer */
-	pb = perf_buffer__new(bpf_map__fd(perf_buf_map), 1,
+	pb = perf_buffer__new(bpf_map__fd(skel->maps.perf_buf_map), 1,
 			      on_sample, NULL, &passed, NULL);
 	if (!ASSERT_OK_PTR(pb, "perf_buf__new"))
 		goto close_prog;
@@ -133,7 +116,7 @@ void serial_test_kfree_skb(void)
 	 */
 	ASSERT_TRUE(passed, "passed");
 
-	err = bpf_map_lookup_elem(bpf_map__fd(global_data), &zero, test_ok);
+	err = bpf_map_lookup_elem(bpf_map__fd(skel->maps.bss), &zero, test_ok);
 	if (CHECK(err, "get_result",
 		  "failed to get output data: %d\n", err))
 		goto close_prog;
@@ -141,9 +124,6 @@ void serial_test_kfree_skb(void)
 	CHECK_FAIL(!test_ok[0] || !test_ok[1]);
 close_prog:
 	perf_buffer__free(pb);
-	bpf_link__destroy(link);
-	bpf_link__destroy(link_fentry);
-	bpf_link__destroy(link_fexit);
 	bpf_object__close(obj);
-	bpf_object__close(obj2);
+	kfree_skb__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
index 86f97681ad89..6a953f4adfdc 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
@@ -167,20 +167,20 @@ static int prog_attach(struct bpf_object *obj, int cgroup_fd, const char *title)
 
 static void run_test(int cgroup_fd)
 {
-	struct bpf_prog_load_attr attr = {
-		.file = "./sockopt_inherit.o",
-	};
 	int server_fd = -1, client_fd;
 	struct bpf_object *obj;
 	void *server_err;
 	pthread_t tid;
-	int ignored;
 	int err;
 
-	err = bpf_prog_load_xattr(&attr, &obj, &ignored);
-	if (CHECK_FAIL(err))
+	obj = bpf_object__open_file("sockopt_inherit.o", NULL);
+	if (!ASSERT_OK_PTR(obj, "obj_open"))
 		return;
 
+	err = bpf_object__load(obj);
+	if (!ASSERT_OK(err, "obj_load"))
+		goto close_bpf_object;
+
 	err = prog_attach(obj, cgroup_fd, "cgroup/getsockopt");
 	if (CHECK_FAIL(err))
 		goto close_bpf_object;
diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_multi.c b/tools/testing/selftests/bpf/prog_tests/sockopt_multi.c
index bc34f7773444..abce12ddcc37 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_multi.c
@@ -297,14 +297,10 @@ static int run_setsockopt_test(struct bpf_object *obj, int cg_parent,
 
 void test_sockopt_multi(void)
 {
-	struct bpf_prog_load_attr attr = {
-		.file = "./sockopt_multi.o",
-	};
 	int cg_parent = -1, cg_child = -1;
 	struct bpf_object *obj = NULL;
 	int sock_fd = -1;
 	int err = -1;
-	int ignored;
 
 	cg_parent = test__join_cgroup("/parent");
 	if (CHECK_FAIL(cg_parent < 0))
@@ -314,8 +310,12 @@ void test_sockopt_multi(void)
 	if (CHECK_FAIL(cg_child < 0))
 		goto out;
 
-	err = bpf_prog_load_xattr(&attr, &obj, &ignored);
-	if (CHECK_FAIL(err))
+	obj = bpf_object__open_file("sockopt_multi.o", NULL);
+	if (!ASSERT_OK_PTR(obj, "obj_load"))
+		goto out;
+
+	err = bpf_object__load(obj);
+	if (!ASSERT_OK(err, "obj_load"))
 		goto out;
 
 	sock_fd = socket(AF_INET, SOCK_STREAM, 0);
diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c b/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
index 265b4fe33ec3..96ff2c20af81 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
@@ -2,6 +2,7 @@
 #include <test_progs.h>
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
+#include "tcp_rtt.skel.h"
 
 struct tcp_rtt_storage {
 	__u32 invoked;
@@ -91,26 +92,18 @@ static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 invoked,
 
 static int run_test(int cgroup_fd, int server_fd)
 {
-	struct bpf_prog_load_attr attr = {
-		.prog_type = BPF_PROG_TYPE_SOCK_OPS,
-		.file = "./tcp_rtt.o",
-		.expected_attach_type = BPF_CGROUP_SOCK_OPS,
-	};
-	struct bpf_object *obj;
-	struct bpf_map *map;
+	struct tcp_rtt *skel;
 	int client_fd;
 	int prog_fd;
 	int map_fd;
 	int err;
 
-	err = bpf_prog_load_xattr(&attr, &obj, &prog_fd);
-	if (err) {
-		log_err("Failed to load BPF object");
+	skel = tcp_rtt__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_load"))
 		return -1;
-	}
 
-	map = bpf_object__next_map(obj, NULL);
-	map_fd = bpf_map__fd(map);
+	map_fd = bpf_map__fd(skel->maps.socket_storage_map);
+	prog_fd = bpf_program__fd(skel->progs._sockops);
 
 	err = bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SOCK_OPS, 0);
 	if (err) {
@@ -149,7 +142,7 @@ static int run_test(int cgroup_fd, int server_fd)
 	close(client_fd);
 
 close_bpf_object:
-	bpf_object__close(obj);
+	tcp_rtt__destroy(skel);
 	return err;
 }
 
diff --git a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
index 7e13129f593a..509e21d5cb9d 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
@@ -30,17 +30,29 @@ extern int extra_prog_load_log_flags;
 
 static int check_load(const char *file)
 {
-	struct bpf_prog_load_attr attr;
 	struct bpf_object *obj = NULL;
-	int err, prog_fd;
+	struct bpf_program *prog;
+	int err;
 
-	memset(&attr, 0, sizeof(struct bpf_prog_load_attr));
-	attr.file = file;
-	attr.prog_type = BPF_PROG_TYPE_UNSPEC;
-	attr.log_level = extra_prog_load_log_flags;
-	attr.prog_flags = BPF_F_TEST_RND_HI32;
 	found = false;
-	err = bpf_prog_load_xattr(&attr, &obj, &prog_fd);
+
+	obj = bpf_object__open_file(file, NULL);
+	err = libbpf_get_error(obj);
+	if (err)
+		return err;
+
+	prog = bpf_object__next_program(obj, NULL);
+	if (!prog) {
+		err = -ENOENT;
+		goto err_out;
+	}
+
+	bpf_program__set_flags(prog, BPF_F_TEST_RND_HI32);
+	bpf_program__set_log_level(prog, extra_prog_load_log_flags);
+
+	err = bpf_object__load(obj);
+
+err_out:
 	bpf_object__close(obj);
 	return err;
 }
diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/selftests/bpf/test_sock_addr.c
index 05c9e4944c01..f0c8d05ba6d1 100644
--- a/tools/testing/selftests/bpf/test_sock_addr.c
+++ b/tools/testing/selftests/bpf/test_sock_addr.c
@@ -663,23 +663,36 @@ static int load_insns(const struct sock_addr_test *test,
 
 static int load_path(const struct sock_addr_test *test, const char *path)
 {
-	struct bpf_prog_load_attr attr;
 	struct bpf_object *obj;
-	int prog_fd;
+	struct bpf_program *prog;
+	int err;
 
-	memset(&attr, 0, sizeof(struct bpf_prog_load_attr));
-	attr.file = path;
-	attr.prog_type = BPF_PROG_TYPE_CGROUP_SOCK_ADDR;
-	attr.expected_attach_type = test->expected_attach_type;
-	attr.prog_flags = BPF_F_TEST_RND_HI32;
+	obj = bpf_object__open_file(path, NULL);
+	err = libbpf_get_error(obj);
+	if (err) {
+		log_err(">>> Opening BPF object (%s) error.\n", path);
+		return -1;
+	}
+
+	prog = bpf_object__next_program(obj, NULL);
+	if (!prog)
+		goto err_out;
 
-	if (bpf_prog_load_xattr(&attr, &obj, &prog_fd)) {
+	bpf_program__set_type(prog, BPF_PROG_TYPE_CGROUP_SOCK_ADDR);
+	bpf_program__set_expected_attach_type(prog, test->expected_attach_type);
+	bpf_program__set_flags(prog, BPF_F_TEST_RND_HI32);
+
+	err = bpf_object__load(obj);
+	if (err) {
 		if (test->expected_result != LOAD_REJECT)
 			log_err(">>> Loading program (%s) error.\n", path);
-		return -1;
+		goto err_out;
 	}
 
-	return prog_fd;
+	return bpf_program__fd(prog);
+err_out:
+	bpf_object__close(obj);
+	return -1;
 }
 
 static int bind4_prog_load(const struct sock_addr_test *test)
diff --git a/tools/testing/selftests/bpf/xdp_redirect_multi.c b/tools/testing/selftests/bpf/xdp_redirect_multi.c
index f5ffba341c17..51c8224b4ccc 100644
--- a/tools/testing/selftests/bpf/xdp_redirect_multi.c
+++ b/tools/testing/selftests/bpf/xdp_redirect_multi.c
@@ -85,10 +85,7 @@ int main(int argc, char **argv)
 {
 	int prog_fd, group_all, mac_map;
 	struct bpf_program *ingress_prog, *egress_prog;
-	struct bpf_prog_load_attr prog_load_attr = {
-		.prog_type = BPF_PROG_TYPE_UNSPEC,
-	};
-	int i, ret, opt, egress_prog_fd = 0;
+	int i, err, ret, opt, egress_prog_fd = 0;
 	struct bpf_devmap_val devmap_val;
 	bool attach_egress_prog = false;
 	unsigned char mac_addr[6];
@@ -147,10 +144,14 @@ int main(int argc, char **argv)
 	printf("\n");
 
 	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
-	prog_load_attr.file = filename;
-
-	if (bpf_prog_load_xattr(&prog_load_attr, &obj, &prog_fd))
+	obj = bpf_object__open_file(filename, NULL);
+	err = libbpf_get_error(obj);
+	if (err)
+		goto err_out;
+	err = bpf_object__load(obj);
+	if (err)
 		goto err_out;
+	prog_fd = bpf_program__fd(bpf_object__next_program(obj, NULL));
 
 	if (attach_egress_prog)
 		group_all = bpf_object__find_map_fd_by_name(obj, "map_egress");
-- 
2.30.2

