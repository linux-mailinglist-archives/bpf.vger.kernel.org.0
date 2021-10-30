Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1652D44078C
	for <lists+bpf@lfdr.de>; Sat, 30 Oct 2021 07:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhJ3FCl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 30 Oct 2021 01:02:41 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51122 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231497AbhJ3FCj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 30 Oct 2021 01:02:39 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19U1Ogla003661
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 22:00:10 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c0vc08p65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 22:00:09 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 29 Oct 2021 22:00:09 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id EC6017830597; Fri, 29 Oct 2021 22:00:05 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH bpf-next 11/14] selftests/bpf: convert legacy prog load APIs to bpf_prog_load()
Date:   Fri, 29 Oct 2021 21:59:38 -0700
Message-ID: <20211030045941.3514948-12-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211030045941.3514948-1-andrii@kernel.org>
References: <20211030045941.3514948-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: gFYitCEp7MwlpJ0IAMWjYz5bSEJjObbP
X-Proofpoint-ORIG-GUID: gFYitCEp7MwlpJ0IAMWjYz5bSEJjObbP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-30_01,2021-10-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2110300025
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Convert all the uses of legacy low-level BPF program loading APIs
(mostly bpf_load_program_xattr(), but also some bpf_verify_program()) to
bpf_prog_load() uses.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/align.c  | 11 ++++--
 .../selftests/bpf/prog_tests/fexit_stress.c   | 33 ++++++++--------
 .../raw_tp_writable_reject_nbd_invalid.c      | 14 +++----
 .../bpf/prog_tests/raw_tp_writable_test_run.c | 29 +++++++-------
 .../selftests/bpf/prog_tests/sockopt.c        | 19 +++++-----
 tools/testing/selftests/bpf/test_lru_map.c    |  9 +----
 tools/testing/selftests/bpf/test_sock.c       | 23 ++++++-----
 tools/testing/selftests/bpf/test_sock_addr.c  | 13 +++----
 tools/testing/selftests/bpf/test_sysctl.c     | 22 ++++-------
 tools/testing/selftests/bpf/test_verifier.c   | 38 +++++++++----------
 10 files changed, 99 insertions(+), 112 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/align.c b/tools/testing/selftests/bpf/prog_tests/align.c
index 5861446d0777..837f67c6bfda 100644
--- a/tools/testing/selftests/bpf/prog_tests/align.c
+++ b/tools/testing/selftests/bpf/prog_tests/align.c
@@ -594,6 +594,12 @@ static int do_test_single(struct bpf_align_test *test)
 	struct bpf_insn *prog = test->insns;
 	int prog_type = test->prog_type;
 	char bpf_vlog_copy[32768];
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		.prog_flags = BPF_F_STRICT_ALIGNMENT,
+		.log_buf = bpf_vlog,
+		.log_size = sizeof(bpf_vlog),
+		.log_level = 2,
+	);
 	const char *line_ptr;
 	int cur_line = -1;
 	int prog_len, i;
@@ -601,9 +607,8 @@ static int do_test_single(struct bpf_align_test *test)
 	int ret;
 
 	prog_len = probe_filter_length(prog);
-	fd_prog = bpf_verify_program(prog_type ? : BPF_PROG_TYPE_SOCKET_FILTER,
-				     prog, prog_len, BPF_F_STRICT_ALIGNMENT,
-				     "GPL", 0, bpf_vlog, sizeof(bpf_vlog), 2);
+	fd_prog = bpf_prog_load(prog_type ? : BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL",
+				prog, prog_len, &opts);
 	if (fd_prog < 0 && test->result != REJECT) {
 		printf("Failed to load program.\n");
 		printf("%s", bpf_vlog);
diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_stress.c b/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
index 7c9b62e971f1..e4cede6b4b2d 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
@@ -20,34 +20,33 @@ void test_fexit_stress(void)
 		BPF_EXIT_INSN(),
 	};
 
-	struct bpf_load_program_attr load_attr = {
-		.prog_type = BPF_PROG_TYPE_TRACING,
-		.license = "GPL",
-		.insns = trace_program,
-		.insns_cnt = sizeof(trace_program) / sizeof(struct bpf_insn),
+	LIBBPF_OPTS(bpf_prog_load_opts, trace_opts,
 		.expected_attach_type = BPF_TRACE_FEXIT,
-	};
+		.log_buf = error,
+		.log_size = sizeof(error),
+	);
 
 	const struct bpf_insn skb_program[] = {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
 	};
 
-	struct bpf_load_program_attr skb_load_attr = {
-		.prog_type = BPF_PROG_TYPE_SOCKET_FILTER,
-		.license = "GPL",
-		.insns = skb_program,
-		.insns_cnt = sizeof(skb_program) / sizeof(struct bpf_insn),
-	};
+	LIBBPF_OPTS(bpf_prog_load_opts, skb_opts,
+		.log_buf = error,
+		.log_size = sizeof(error),
+	);
 
 	err = libbpf_find_vmlinux_btf_id("bpf_fentry_test1",
-					 load_attr.expected_attach_type);
+					 trace_opts.expected_attach_type);
 	if (CHECK(err <= 0, "find_vmlinux_btf_id", "failed: %d\n", err))
 		goto out;
-	load_attr.attach_btf_id = err;
+	trace_opts.attach_btf_id = err;
 
 	for (i = 0; i < CNT; i++) {
-		fexit_fd[i] = bpf_load_program_xattr(&load_attr, error, sizeof(error));
+		fexit_fd[i] = bpf_prog_load(BPF_PROG_TYPE_TRACING, NULL, "GPL",
+					    trace_program,
+					    sizeof(trace_program) / sizeof(struct bpf_insn),
+					    &trace_opts);
 		if (CHECK(fexit_fd[i] < 0, "fexit loaded",
 			  "failed: %d errno %d\n", fexit_fd[i], errno))
 			goto out;
@@ -57,7 +56,9 @@ void test_fexit_stress(void)
 			goto out;
 	}
 
-	filter_fd = bpf_load_program_xattr(&skb_load_attr, error, sizeof(error));
+	filter_fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL",
+				  skb_program, sizeof(skb_program) / sizeof(struct bpf_insn),
+				  &skb_opts);
 	if (CHECK(filter_fd < 0, "test_program_loaded", "failed: %d errno %d\n",
 		  filter_fd, errno))
 		goto out;
diff --git a/tools/testing/selftests/bpf/prog_tests/raw_tp_writable_reject_nbd_invalid.c b/tools/testing/selftests/bpf/prog_tests/raw_tp_writable_reject_nbd_invalid.c
index 9807336a3016..e2f1445b0e10 100644
--- a/tools/testing/selftests/bpf/prog_tests/raw_tp_writable_reject_nbd_invalid.c
+++ b/tools/testing/selftests/bpf/prog_tests/raw_tp_writable_reject_nbd_invalid.c
@@ -18,15 +18,15 @@ void test_raw_tp_writable_reject_nbd_invalid(void)
 		BPF_EXIT_INSN(),
 	};
 
-	struct bpf_load_program_attr load_attr = {
-		.prog_type = BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE,
-		.license = "GPL v2",
-		.insns = program,
-		.insns_cnt = sizeof(program) / sizeof(struct bpf_insn),
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
 		.log_level = 2,
-	};
+		.log_buf = error,
+		.log_size = sizeof(error),
+	);
 
-	bpf_fd = bpf_load_program_xattr(&load_attr, error, sizeof(error));
+	bpf_fd = bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE, NULL, "GPL v2",
+			       program, sizeof(program) / sizeof(struct bpf_insn),
+			       &opts);
 	if (CHECK(bpf_fd < 0, "bpf_raw_tracepoint_writable load",
 		  "failed: %d errno %d\n", bpf_fd, errno))
 		return;
diff --git a/tools/testing/selftests/bpf/prog_tests/raw_tp_writable_test_run.c b/tools/testing/selftests/bpf/prog_tests/raw_tp_writable_test_run.c
index ddefa1192e5d..239baccabccb 100644
--- a/tools/testing/selftests/bpf/prog_tests/raw_tp_writable_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/raw_tp_writable_test_run.c
@@ -17,15 +17,15 @@ void serial_test_raw_tp_writable_test_run(void)
 		BPF_EXIT_INSN(),
 	};
 
-	struct bpf_load_program_attr load_attr = {
-		.prog_type = BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE,
-		.license = "GPL v2",
-		.insns = trace_program,
-		.insns_cnt = sizeof(trace_program) / sizeof(struct bpf_insn),
+	LIBBPF_OPTS(bpf_prog_load_opts, trace_opts,
 		.log_level = 2,
-	};
+		.log_buf = error,
+		.log_size = sizeof(error),
+	);
 
-	int bpf_fd = bpf_load_program_xattr(&load_attr, error, sizeof(error));
+	int bpf_fd = bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE, NULL, "GPL v2",
+				   trace_program, sizeof(trace_program) / sizeof(struct bpf_insn),
+				   &trace_opts);
 	if (CHECK(bpf_fd < 0, "bpf_raw_tracepoint_writable loaded",
 		  "failed: %d errno %d\n", bpf_fd, errno))
 		return;
@@ -35,15 +35,14 @@ void serial_test_raw_tp_writable_test_run(void)
 		BPF_EXIT_INSN(),
 	};
 
-	struct bpf_load_program_attr skb_load_attr = {
-		.prog_type = BPF_PROG_TYPE_SOCKET_FILTER,
-		.license = "GPL v2",
-		.insns = skb_program,
-		.insns_cnt = sizeof(skb_program) / sizeof(struct bpf_insn),
-	};
+	LIBBPF_OPTS(bpf_prog_load_opts, skb_opts,
+		.log_buf = error,
+		.log_size = sizeof(error),
+	);
 
-	int filter_fd =
-		bpf_load_program_xattr(&skb_load_attr, error, sizeof(error));
+	int filter_fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL v2",
+				      skb_program, sizeof(skb_program) / sizeof(struct bpf_insn),
+				      &skb_opts);
 	if (CHECK(filter_fd < 0, "test_program_loaded", "failed: %d errno %d\n",
 		  filter_fd, errno))
 		goto out_bpffd;
diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt.c b/tools/testing/selftests/bpf/prog_tests/sockopt.c
index 3e8517a8395a..cd09f4c7dd92 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt.c
@@ -852,22 +852,21 @@ static struct sockopt_test {
 static int load_prog(const struct bpf_insn *insns,
 		     enum bpf_attach_type expected_attach_type)
 {
-	struct bpf_load_program_attr attr = {
-		.prog_type = BPF_PROG_TYPE_CGROUP_SOCKOPT,
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
 		.expected_attach_type = expected_attach_type,
-		.insns = insns,
-		.license = "GPL",
 		.log_level = 2,
-	};
-	int fd;
+		.log_buf = bpf_log_buf,
+		.log_size = sizeof(bpf_log_buf),
+	);
+	int fd, insns_cnt = 0;
 
 	for (;
-	     insns[attr.insns_cnt].code != (BPF_JMP | BPF_EXIT);
-	     attr.insns_cnt++) {
+	     insns[insns_cnt].code != (BPF_JMP | BPF_EXIT);
+	     insns_cnt++) {
 	}
-	attr.insns_cnt++;
+	insns_cnt++;
 
-	fd = bpf_load_program_xattr(&attr, bpf_log_buf, sizeof(bpf_log_buf));
+	fd = bpf_prog_load(BPF_PROG_TYPE_CGROUP_SOCKOPT, NULL, "GPL", insns, insns_cnt, &opts);
 	if (verbose && fd < 0)
 		fprintf(stderr, "%s\n", bpf_log_buf);
 
diff --git a/tools/testing/selftests/bpf/test_lru_map.c b/tools/testing/selftests/bpf/test_lru_map.c
index 7e9049fa3edf..7f3d1d8460b4 100644
--- a/tools/testing/selftests/bpf/test_lru_map.c
+++ b/tools/testing/selftests/bpf/test_lru_map.c
@@ -42,7 +42,6 @@ static int create_map(int map_type, int map_flags, unsigned int size)
 static int bpf_map_lookup_elem_with_ref_bit(int fd, unsigned long long key,
 					    void *value)
 {
-	struct bpf_load_program_attr prog;
 	struct bpf_create_map_attr map;
 	struct bpf_insn insns[] = {
 		BPF_LD_MAP_VALUE(BPF_REG_9, 0, 0),
@@ -76,13 +75,7 @@ static int bpf_map_lookup_elem_with_ref_bit(int fd, unsigned long long key,
 
 	insns[0].imm = mfd;
 
-	memset(&prog, 0, sizeof(prog));
-	prog.prog_type = BPF_PROG_TYPE_SCHED_CLS;
-	prog.insns = insns;
-	prog.insns_cnt = ARRAY_SIZE(insns);
-	prog.license = "GPL";
-
-	pfd = bpf_load_program_xattr(&prog, NULL, 0);
+	pfd = bpf_prog_load(BPF_PROG_TYPE_SCHED_CLS, NULL, "GPL", insns, ARRAY_SIZE(insns), NULL);
 	if (pfd < 0) {
 		close(mfd);
 		return -1;
diff --git a/tools/testing/selftests/bpf/test_sock.c b/tools/testing/selftests/bpf/test_sock.c
index 9613f7538840..e8edd3dd3ec2 100644
--- a/tools/testing/selftests/bpf/test_sock.c
+++ b/tools/testing/selftests/bpf/test_sock.c
@@ -328,18 +328,17 @@ static size_t probe_prog_length(const struct bpf_insn *fp)
 static int load_sock_prog(const struct bpf_insn *prog,
 			  enum bpf_attach_type attach_type)
 {
-	struct bpf_load_program_attr attr;
-	int ret;
-
-	memset(&attr, 0, sizeof(struct bpf_load_program_attr));
-	attr.prog_type = BPF_PROG_TYPE_CGROUP_SOCK;
-	attr.expected_attach_type = attach_type;
-	attr.insns = prog;
-	attr.insns_cnt = probe_prog_length(attr.insns);
-	attr.license = "GPL";
-	attr.log_level = 2;
-
-	ret = bpf_load_program_xattr(&attr, bpf_log_buf, BPF_LOG_BUF_SIZE);
+	LIBBPF_OPTS(bpf_prog_load_opts, opts);
+	int ret, insn_cnt;
+
+	insn_cnt = probe_prog_length(prog);
+
+	opts.expected_attach_type = attach_type;
+	opts.log_buf = bpf_log_buf;
+	opts.log_size = BPF_LOG_BUF_SIZE;
+	opts.log_level = 2;
+
+	ret = bpf_prog_load(BPF_PROG_TYPE_CGROUP_SOCK, NULL, "GPL", prog, insn_cnt, &opts);
 	if (verbose && ret < 0)
 		fprintf(stderr, "%s\n", bpf_log_buf);
 
diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/selftests/bpf/test_sock_addr.c
index aa3f185fcb89..05c9e4944c01 100644
--- a/tools/testing/selftests/bpf/test_sock_addr.c
+++ b/tools/testing/selftests/bpf/test_sock_addr.c
@@ -645,17 +645,14 @@ static int mk_sockaddr(int domain, const char *ip, unsigned short port,
 static int load_insns(const struct sock_addr_test *test,
 		      const struct bpf_insn *insns, size_t insns_cnt)
 {
-	struct bpf_load_program_attr load_attr;
+	LIBBPF_OPTS(bpf_prog_load_opts, opts);
 	int ret;
 
-	memset(&load_attr, 0, sizeof(struct bpf_load_program_attr));
-	load_attr.prog_type = BPF_PROG_TYPE_CGROUP_SOCK_ADDR;
-	load_attr.expected_attach_type = test->expected_attach_type;
-	load_attr.insns = insns;
-	load_attr.insns_cnt = insns_cnt;
-	load_attr.license = "GPL";
+	opts.expected_attach_type = test->expected_attach_type;
+	opts.log_buf = bpf_log_buf;
+	opts.log_size = BPF_LOG_BUF_SIZE;
 
-	ret = bpf_load_program_xattr(&load_attr, bpf_log_buf, BPF_LOG_BUF_SIZE);
+	ret = bpf_prog_load(BPF_PROG_TYPE_CGROUP_SOCK_ADDR, NULL, "GPL", insns, insns_cnt, &opts);
 	if (ret < 0 && test->expected_result != LOAD_REJECT) {
 		log_err(">>> Loading program error.\n"
 			">>> Verifier output:\n%s\n-------\n", bpf_log_buf);
diff --git a/tools/testing/selftests/bpf/test_sysctl.c b/tools/testing/selftests/bpf/test_sysctl.c
index a3bb6d399daa..4a395d7a8ea9 100644
--- a/tools/testing/selftests/bpf/test_sysctl.c
+++ b/tools/testing/selftests/bpf/test_sysctl.c
@@ -1435,14 +1435,10 @@ static int load_sysctl_prog_insns(struct sysctl_test *test,
 				  const char *sysctl_path)
 {
 	struct bpf_insn *prog = test->insns;
-	struct bpf_load_program_attr attr;
-	int ret;
+	LIBBPF_OPTS(bpf_prog_load_opts, opts);
+	int ret, insn_cnt;
 
-	memset(&attr, 0, sizeof(struct bpf_load_program_attr));
-	attr.prog_type = BPF_PROG_TYPE_CGROUP_SYSCTL;
-	attr.insns = prog;
-	attr.insns_cnt = probe_prog_length(attr.insns);
-	attr.license = "GPL";
+	insn_cnt = probe_prog_length(prog);
 
 	if (test->fixup_value_insn) {
 		char buf[128];
@@ -1465,7 +1461,10 @@ static int load_sysctl_prog_insns(struct sysctl_test *test,
 			return -1;
 	}
 
-	ret = bpf_load_program_xattr(&attr, bpf_log_buf, BPF_LOG_BUF_SIZE);
+	opts.log_buf = bpf_log_buf;
+	opts.log_size = BPF_LOG_BUF_SIZE;
+
+	ret = bpf_prog_load(BPF_PROG_TYPE_CGROUP_SYSCTL, NULL, "GPL", prog, insn_cnt, &opts);
 	if (ret < 0 && test->result != LOAD_REJECT) {
 		log_err(">>> Loading program error.\n"
 			">>> Verifier output:\n%s\n-------\n", bpf_log_buf);
@@ -1476,15 +1475,10 @@ static int load_sysctl_prog_insns(struct sysctl_test *test,
 
 static int load_sysctl_prog_file(struct sysctl_test *test)
 {
-	struct bpf_prog_load_attr attr;
 	struct bpf_object *obj;
 	int prog_fd;
 
-	memset(&attr, 0, sizeof(struct bpf_prog_load_attr));
-	attr.file = test->prog_file;
-	attr.prog_type = BPF_PROG_TYPE_CGROUP_SYSCTL;
-
-	if (bpf_prog_load_xattr(&attr, &obj, &prog_fd)) {
+	if (bpf_prog_test_load(test->prog_file, BPF_PROG_TYPE_CGROUP_SYSCTL, &obj, &prog_fd)) {
 		if (test->result != LOAD_REJECT)
 			log_err(">>> Loading program (%s) error.\n",
 				test->prog_file);
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 25afe423b3f0..e512b715a785 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -498,8 +498,7 @@ static int create_prog_dummy_simple(enum bpf_prog_type prog_type, int ret)
 		BPF_EXIT_INSN(),
 	};
 
-	return bpf_load_program(prog_type, prog,
-				ARRAY_SIZE(prog), "GPL", 0, NULL, 0);
+	return bpf_prog_load(prog_type, NULL, "GPL", prog, ARRAY_SIZE(prog), NULL);
 }
 
 static int create_prog_dummy_loop(enum bpf_prog_type prog_type, int mfd,
@@ -514,8 +513,7 @@ static int create_prog_dummy_loop(enum bpf_prog_type prog_type, int mfd,
 		BPF_EXIT_INSN(),
 	};
 
-	return bpf_load_program(prog_type, prog,
-				ARRAY_SIZE(prog), "GPL", 0, NULL, 0);
+	return bpf_prog_load(prog_type, NULL, "GPL", prog, ARRAY_SIZE(prog), NULL);
 }
 
 static int create_prog_array(enum bpf_prog_type prog_type, uint32_t max_elem,
@@ -1045,7 +1043,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 	int fd_prog, expected_ret, alignment_prevented_execution;
 	int prog_len, prog_type = test->prog_type;
 	struct bpf_insn *prog = test->insns;
-	struct bpf_load_program_attr attr;
+	LIBBPF_OPTS(bpf_prog_load_opts, opts);
 	int run_errs, run_successes;
 	int map_fds[MAX_NR_MAPS];
 	const char *expected_err;
@@ -1085,32 +1083,34 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 		       test->result_unpriv : test->result;
 	expected_err = unpriv && test->errstr_unpriv ?
 		       test->errstr_unpriv : test->errstr;
-	memset(&attr, 0, sizeof(attr));
-	attr.prog_type = prog_type;
-	attr.expected_attach_type = test->expected_attach_type;
-	attr.insns = prog;
-	attr.insns_cnt = prog_len;
-	attr.license = "GPL";
+
+	opts.expected_attach_type = test->expected_attach_type;
 	if (verbose)
-		attr.log_level = 1;
+		opts.log_level = 1;
 	else if (expected_ret == VERBOSE_ACCEPT)
-		attr.log_level = 2;
+		opts.log_level = 2;
 	else
-		attr.log_level = 4;
-	attr.prog_flags = pflags;
+		opts.log_level = 4;
+	opts.prog_flags = pflags;
 
 	if (prog_type == BPF_PROG_TYPE_TRACING && test->kfunc) {
-		attr.attach_btf_id = libbpf_find_vmlinux_btf_id(test->kfunc,
-						attr.expected_attach_type);
-		if (attr.attach_btf_id < 0) {
+		int attach_btf_id;
+
+		attach_btf_id = libbpf_find_vmlinux_btf_id(test->kfunc,
+						opts.expected_attach_type);
+		if (attach_btf_id < 0) {
 			printf("FAIL\nFailed to find BTF ID for '%s'!\n",
 				test->kfunc);
 			(*errors)++;
 			return;
 		}
+
+		opts.attach_btf_id = attach_btf_id;
 	}
 
-	fd_prog = bpf_load_program_xattr(&attr, bpf_vlog, sizeof(bpf_vlog));
+	opts.log_buf = bpf_vlog;
+	opts.log_size = sizeof(bpf_vlog);
+	fd_prog = bpf_prog_load(prog_type, NULL, "GPL", prog, prog_len, &opts);
 	saved_errno = errno;
 
 	/* BPF_PROG_TYPE_TRACING requires more setup and
-- 
2.30.2

