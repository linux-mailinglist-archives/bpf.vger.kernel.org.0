Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107F4447A63
	for <lists+bpf@lfdr.de>; Mon,  8 Nov 2021 07:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237684AbhKHGQ0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 8 Nov 2021 01:16:26 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:12126 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237685AbhKHGQY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 8 Nov 2021 01:16:24 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A7L9jNB014275
        for <bpf@vger.kernel.org>; Sun, 7 Nov 2021 22:13:40 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c6gykkhk5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 07 Nov 2021 22:13:40 -0800
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sun, 7 Nov 2021 22:13:38 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id C569884C49CD; Sun,  7 Nov 2021 22:13:33 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 08/11] selftests/bpf: migrate all deprecated perf_buffer uses
Date:   Sun, 7 Nov 2021 22:13:13 -0800
Message-ID: <20211108061316.203217-9-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211108061316.203217-1-andrii@kernel.org>
References: <20211108061316.203217-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: XgdkWsG8xp-ogXHf2oqH-cF_F_PUG4dn
X-Proofpoint-GUID: XgdkWsG8xp-ogXHf2oqH-cF_F_PUG4dn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-08_01,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 spamscore=0
 mlxscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111080040
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Migrate all old-style perf_buffer__new() and perf_buffer__new_raw()
calls to new v1.0+ variants.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/benchs/bench_ringbufs.c       | 8 ++------
 tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c | 5 ++---
 tools/testing/selftests/bpf/prog_tests/kfree_skb.c        | 6 ++----
 tools/testing/selftests/bpf/prog_tests/perf_buffer.c      | 6 ++----
 tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c      | 7 ++-----
 tools/testing/selftests/bpf/test_tcpnotify_user.c         | 4 +---
 6 files changed, 11 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_ringbufs.c b/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
index d167bffac679..52d4a2f91dbd 100644
--- a/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
+++ b/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
@@ -394,11 +394,6 @@ static void perfbuf_libbpf_setup()
 {
 	struct perfbuf_libbpf_ctx *ctx = &perfbuf_libbpf_ctx;
 	struct perf_event_attr attr;
-	struct perf_buffer_raw_opts pb_opts = {
-		.event_cb = perfbuf_process_sample_raw,
-		.ctx = (void *)(long)0,
-		.attr = &attr,
-	};
 	struct bpf_link *link;
 
 	ctx->skel = perfbuf_setup_skeleton();
@@ -423,7 +418,8 @@ static void perfbuf_libbpf_setup()
 	}
 
 	ctx->perfbuf = perf_buffer__new_raw(bpf_map__fd(ctx->skel->maps.perfbuf),
-					    args.perfbuf_sz, &pb_opts);
+					    args.perfbuf_sz, &attr,
+					    perfbuf_process_sample_raw, NULL, NULL);
 	if (!ctx->perfbuf) {
 		fprintf(stderr, "failed to create perfbuf\n");
 		exit(1);
diff --git a/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c b/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
index 569fcc6ed660..4184c399d4c6 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
@@ -85,7 +85,6 @@ void test_get_stack_raw_tp(void)
 	const char *file_err = "./test_get_stack_rawtp_err.o";
 	const char *prog_name = "raw_tracepoint/sys_enter";
 	int i, err, prog_fd, exp_cnt = MAX_CNT_RAWTP;
-	struct perf_buffer_opts pb_opts = {};
 	struct perf_buffer *pb = NULL;
 	struct bpf_link *link = NULL;
 	struct timespec tv = {0, 10};
@@ -124,8 +123,8 @@ void test_get_stack_raw_tp(void)
 	if (!ASSERT_OK_PTR(link, "attach_raw_tp"))
 		goto close_prog;
 
-	pb_opts.sample_cb = get_stack_print_output;
-	pb = perf_buffer__new(bpf_map__fd(map), 8, &pb_opts);
+	pb = perf_buffer__new(bpf_map__fd(map), 8, get_stack_print_output,
+			      NULL, NULL, NULL);
 	if (!ASSERT_OK_PTR(pb, "perf_buf__new"))
 		goto close_prog;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/kfree_skb.c b/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
index 885413ed5c96..2a49f8fcde06 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
@@ -66,7 +66,6 @@ void serial_test_kfree_skb(void)
 	struct bpf_map *perf_buf_map, *global_data;
 	struct bpf_program *prog, *fentry, *fexit;
 	struct bpf_object *obj, *obj2 = NULL;
-	struct perf_buffer_opts pb_opts = {};
 	struct perf_buffer *pb = NULL;
 	int err, kfree_skb_fd;
 	bool passed = false;
@@ -112,9 +111,8 @@ void serial_test_kfree_skb(void)
 		goto close_prog;
 
 	/* set up perf buffer */
-	pb_opts.sample_cb = on_sample;
-	pb_opts.ctx = &passed;
-	pb = perf_buffer__new(bpf_map__fd(perf_buf_map), 1, &pb_opts);
+	pb = perf_buffer__new(bpf_map__fd(perf_buf_map), 1,
+			      on_sample, NULL, &passed, NULL);
 	if (!ASSERT_OK_PTR(pb, "perf_buf__new"))
 		goto close_prog;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/perf_buffer.c b/tools/testing/selftests/bpf/prog_tests/perf_buffer.c
index 4e32f3586a75..5fc2b3a0711e 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_buffer.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_buffer.c
@@ -47,7 +47,6 @@ void serial_test_perf_buffer(void)
 {
 	int err, on_len, nr_on_cpus = 0, nr_cpus, i, j;
 	int zero = 0, my_pid = getpid();
-	struct perf_buffer_opts pb_opts = {};
 	struct test_perf_buffer *skel;
 	cpu_set_t cpu_seen;
 	struct perf_buffer *pb;
@@ -82,9 +81,8 @@ void serial_test_perf_buffer(void)
 		goto out_close;
 
 	/* set up perf buffer */
-	pb_opts.sample_cb = on_sample;
-	pb_opts.ctx = &cpu_seen;
-	pb = perf_buffer__new(bpf_map__fd(skel->maps.perf_buf_map), 1, &pb_opts);
+	pb = perf_buffer__new(bpf_map__fd(skel->maps.perf_buf_map), 1,
+			      on_sample, NULL, &cpu_seen, NULL);
 	if (!ASSERT_OK_PTR(pb, "perf_buf__new"))
 		goto out_close;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c
index 3bd5904b4db5..f99386d1dc4c 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c
@@ -49,7 +49,6 @@ void test_xdp_bpf2bpf(void)
 	struct vip key4 = {.protocol = 6, .family = AF_INET};
 	struct bpf_program *prog;
 	struct perf_buffer *pb = NULL;
-	struct perf_buffer_opts pb_opts = {};
 
 	/* Load XDP program to introspect */
 	pkt_skel = test_xdp__open_and_load();
@@ -86,10 +85,8 @@ void test_xdp_bpf2bpf(void)
 		goto out;
 
 	/* Set up perf buffer */
-	pb_opts.sample_cb = on_sample;
-	pb_opts.ctx = &passed;
-	pb = perf_buffer__new(bpf_map__fd(ftrace_skel->maps.perf_buf_map),
-			      1, &pb_opts);
+	pb = perf_buffer__new(bpf_map__fd(ftrace_skel->maps.perf_buf_map), 1,
+			      on_sample, NULL, &passed, NULL);
 	if (!ASSERT_OK_PTR(pb, "perf_buf__new"))
 		goto out;
 
diff --git a/tools/testing/selftests/bpf/test_tcpnotify_user.c b/tools/testing/selftests/bpf/test_tcpnotify_user.c
index 63111cb082fe..4c5114765b23 100644
--- a/tools/testing/selftests/bpf/test_tcpnotify_user.c
+++ b/tools/testing/selftests/bpf/test_tcpnotify_user.c
@@ -72,7 +72,6 @@ int main(int argc, char **argv)
 {
 	const char *file = "test_tcpnotify_kern.o";
 	struct bpf_map *perf_map, *global_map;
-	struct perf_buffer_opts pb_opts = {};
 	struct tcpnotify_globals g = {0};
 	struct perf_buffer *pb = NULL;
 	const char *cg_path = "/foo";
@@ -117,8 +116,7 @@ int main(int argc, char **argv)
 		return -1;
 	}
 
-	pb_opts.sample_cb = dummyfn;
-	pb = perf_buffer__new(bpf_map__fd(perf_map), 8, &pb_opts);
+	pb = perf_buffer__new(bpf_map__fd(perf_map), 8, dummyfn, NULL, NULL, NULL);
 	if (!pb)
 		goto err;
 
-- 
2.30.2

