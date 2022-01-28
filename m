Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262D349F07D
	for <lists+bpf@lfdr.de>; Fri, 28 Jan 2022 02:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344622AbiA1BXl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 20:23:41 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57854 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345027AbiA1BXk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 27 Jan 2022 20:23:40 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20RNabXE021049
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 17:23:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=bMJFeTjwWCahxau7yzt0HDs4zIfLWs8mtaNqRb2XO6c=;
 b=TVTr5+UPt2iQD586s/V/Y5RPg/q/C12iNdoTsHptZKfXKZKvkGZkzhpRKsK6lrY+TTg8
 d4tkJRvXTQ/luRbs5fWvL8gJieREDlGIGo0GbDQDQQXyxqbPTJNo7+6I63Ro4iRliQft
 q4dj1IOUADFe6PQlZ6KQxK/5uLU3EGGATmQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3due548ehv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 17:23:39 -0800
Received: from twshared29821.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 27 Jan 2022 17:23:38 -0800
Received: by devvm3278.frc0.facebook.com (Postfix, from userid 8598)
        id 657B51C1215E1; Thu, 27 Jan 2022 17:23:28 -0800 (PST)
From:   Delyan Kratunov <delyank@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     Delyan Kratunov <delyank@fb.com>
Subject: [PATCH bpf-next v2 2/4] selftests: bpf: migrate from bpf_prog_test_run_xattr
Date:   Thu, 27 Jan 2022 17:23:17 -0800
Message-ID: <20220128012319.2494472-3-delyank@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220128012319.2494472-1-delyank@fb.com>
References: <20220128012319.2494472-1-delyank@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 8-PRD1mHZj6GgT9s7J_6fKhB5z1f370R
X-Proofpoint-ORIG-GUID: 8-PRD1mHZj6GgT9s7J_6fKhB5z1f370R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_06,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 mlxscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201280004
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 .../selftests/bpf/prog_tests/check_mtu.c      | 47 +++++-----
 .../selftests/bpf/prog_tests/cls_redirect.c   | 30 +++---
 .../selftests/bpf/prog_tests/dummy_st_ops.c   | 31 +++----
 .../selftests/bpf/prog_tests/flow_dissector.c | 75 ++++++++-------
 .../selftests/bpf/prog_tests/kfree_skb.c      | 16 ++--
 .../selftests/bpf/prog_tests/prog_run_xattr.c |  5 +
 .../bpf/prog_tests/raw_tp_test_run.c          | 85 ++++++++---------
 .../selftests/bpf/prog_tests/skb_ctx.c        | 93 ++++++++-----------
 .../selftests/bpf/prog_tests/skb_helpers.c    | 16 ++--
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 19 ++--
 .../selftests/bpf/prog_tests/syscall.c        | 12 +--
 .../selftests/bpf/prog_tests/test_profiler.c  | 16 ++--
 .../bpf/prog_tests/xdp_adjust_tail.c          | 34 +++----
 13 files changed, 227 insertions(+), 252 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/check_mtu.c b/tools/t=
esting/selftests/bpf/prog_tests/check_mtu.c
index f73e6e36b74d..b5ab3ef7e9d3 100644
--- a/tools/testing/selftests/bpf/prog_tests/check_mtu.c
+++ b/tools/testing/selftests/bpf/prog_tests/check_mtu.c
@@ -83,24 +83,22 @@ static void test_check_mtu_run_xdp(struct test_check_=
mtu *skel,
 	int retval_expect =3D XDP_PASS;
 	__u32 mtu_result =3D 0;
 	char buf[256] =3D {};
-	int err;
-	struct bpf_prog_test_run_attr tattr =3D {
-		.repeat =3D 1,
-		.data_in =3D &pkt_v4,
+	int err, prog_fd =3D bpf_program__fd(prog);
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.repeat =3D 1, .data_in =3D &pkt_v4,
 		.data_size_in =3D sizeof(pkt_v4),
 		.data_out =3D buf,
 		.data_size_out =3D sizeof(buf),
-		.prog_fd =3D bpf_program__fd(prog),
-	};
+	);

-	err =3D bpf_prog_test_run_xattr(&tattr);
-	CHECK_ATTR(err !=3D 0, "bpf_prog_test_run",
-		   "prog_name:%s (err %d errno %d retval %d)\n",
-		   prog_name, err, errno, tattr.retval);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	CHECK_OPTS(err !=3D 0, "bpf_prog_test_run",
+		   "prog_name:%s (err %d errno %d retval %d)\n", prog_name, err,
+		   errno, topts.retval);

-	CHECK(tattr.retval !=3D retval_expect, "retval",
-	      "progname:%s unexpected retval=3D%d expected=3D%d\n",
-	      prog_name, tattr.retval, retval_expect);
+	CHECK(topts.retval !=3D retval_expect, "retval",
+	      "progname:%s unexpected retval=3D%d expected=3D%d\n", prog_name,
+	      topts.retval, retval_expect);

 	/* Extract MTU that BPF-prog got */
 	mtu_result =3D skel->bss->global_bpf_mtu_xdp;
@@ -143,24 +141,23 @@ static void test_check_mtu_run_tc(struct test_check=
_mtu *skel,
 	int retval_expect =3D BPF_OK;
 	__u32 mtu_result =3D 0;
 	char buf[256] =3D {};
-	int err;
-	struct bpf_prog_test_run_attr tattr =3D {
-		.repeat =3D 1,
+	int err, prog_fd =3D bpf_program__fd(prog);
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
 		.data_in =3D &pkt_v4,
 		.data_size_in =3D sizeof(pkt_v4),
 		.data_out =3D buf,
 		.data_size_out =3D sizeof(buf),
-		.prog_fd =3D bpf_program__fd(prog),
-	};
+		.repeat =3D 1,
+	);

-	err =3D bpf_prog_test_run_xattr(&tattr);
-	CHECK_ATTR(err !=3D 0, "bpf_prog_test_run",
-		   "prog_name:%s (err %d errno %d retval %d)\n",
-		   prog_name, err, errno, tattr.retval);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	CHECK_OPTS(err !=3D 0, "bpf_prog_test_run",
+		   "prog_name:%s (err %d errno %d retval %d)\n", prog_name, err,
+		   errno, topts.retval);

-	CHECK(tattr.retval !=3D retval_expect, "retval",
-	      "progname:%s unexpected retval=3D%d expected=3D%d\n",
-	      prog_name, tattr.retval, retval_expect);
+	CHECK(topts.retval !=3D retval_expect, "retval",
+	      "progname:%s unexpected retval=3D%d expected=3D%d\n", prog_name,
+	      topts.retval, retval_expect);

 	/* Extract MTU that BPF-prog got */
 	mtu_result =3D skel->bss->global_bpf_mtu_tc;
diff --git a/tools/testing/selftests/bpf/prog_tests/cls_redirect.c b/tool=
s/testing/selftests/bpf/prog_tests/cls_redirect.c
index e075d03ab630..fec0d3dd00ce 100644
--- a/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
@@ -161,9 +161,9 @@ static socklen_t prepare_addr(struct sockaddr_storage=
 *addr, int family)
 	}
 }

-static bool was_decapsulated(struct bpf_prog_test_run_attr *tattr)
+static bool was_decapsulated(struct bpf_test_run_opts *topts)
 {
-	return tattr->data_size_out < tattr->data_size_in;
+	return topts->data_size_out < topts->data_size_in;
 }

 enum type {
@@ -367,12 +367,12 @@ static void close_fds(int *fds, int n)

 static void test_cls_redirect_common(struct bpf_program *prog)
 {
-	struct bpf_prog_test_run_attr tattr =3D {};
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
 	int families[] =3D { AF_INET, AF_INET6 };
 	struct sockaddr_storage ss;
 	struct sockaddr *addr;
 	socklen_t slen;
-	int i, j, err;
+	int i, j, err, prog_fd;
 	int servers[__NR_KIND][ARRAY_SIZE(families)] =3D {};
 	int conns[__NR_KIND][ARRAY_SIZE(families)] =3D {};
 	struct tuple tuples[__NR_KIND][ARRAY_SIZE(families)];
@@ -394,7 +394,7 @@ static void test_cls_redirect_common(struct bpf_progr=
am *prog)
 			goto cleanup;
 	}

-	tattr.prog_fd =3D bpf_program__fd(prog);
+	prog_fd =3D bpf_program__fd(prog);
 	for (i =3D 0; i < ARRAY_SIZE(tests); i++) {
 		struct test_cfg *test =3D &tests[i];

@@ -407,31 +407,31 @@ static void test_cls_redirect_common(struct bpf_pro=
gram *prog)
 			if (!test__start_subtest(tmp))
 				continue;

-			tattr.data_out =3D tmp;
-			tattr.data_size_out =3D sizeof(tmp);
+			topts.data_out =3D tmp;
+			topts.data_size_out =3D sizeof(tmp);

-			tattr.data_in =3D input;
-			tattr.data_size_in =3D build_input(test, input, tuple);
-			if (CHECK_FAIL(!tattr.data_size_in))
+			topts.data_in =3D input;
+			topts.data_size_in =3D build_input(test, input, tuple);
+			if (CHECK_FAIL(!topts.data_size_in))
 				continue;

-			err =3D bpf_prog_test_run_xattr(&tattr);
+			err =3D bpf_prog_test_run_opts(prog_fd, &topts);
 			if (CHECK_FAIL(err))
 				continue;

-			if (tattr.retval !=3D TC_ACT_REDIRECT) {
+			if (topts.retval !=3D TC_ACT_REDIRECT) {
 				PRINT_FAIL("expected TC_ACT_REDIRECT, got %d\n",
-					   tattr.retval);
+					   topts.retval);
 				continue;
 			}

 			switch (test->result) {
 			case ACCEPT:
-				if (CHECK_FAIL(!was_decapsulated(&tattr)))
+				if (CHECK_FAIL(!was_decapsulated(&topts)))
 					continue;
 				break;
 			case FORWARD:
-				if (CHECK_FAIL(was_decapsulated(&tattr)))
+				if (CHECK_FAIL(was_decapsulated(&topts)))
 					continue;
 				break;
 			default:
diff --git a/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c b/tool=
s/testing/selftests/bpf/prog_tests/dummy_st_ops.c
index cbaa44ffb8c6..81b2f670526a 100644
--- a/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
+++ b/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
@@ -26,10 +26,10 @@ static void test_dummy_st_ops_attach(void)
 static void test_dummy_init_ret_value(void)
 {
 	__u64 args[1] =3D {0};
-	struct bpf_prog_test_run_attr attr =3D {
-		.ctx_size_in =3D sizeof(args),
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
 		.ctx_in =3D args,
-	};
+		.ctx_size_in =3D sizeof(args),
+	);
 	struct dummy_st_ops *skel;
 	int fd, err;

@@ -38,10 +38,9 @@ static void test_dummy_init_ret_value(void)
 		return;

 	fd =3D bpf_program__fd(skel->progs.test_1);
-	attr.prog_fd =3D fd;
-	err =3D bpf_prog_test_run_xattr(&attr);
+	err =3D bpf_prog_test_run_opts(fd, &topts);
 	ASSERT_OK(err, "test_run");
-	ASSERT_EQ(attr.retval, 0xf2f3f4f5, "test_ret");
+	ASSERT_EQ(topts.retval, 0xf2f3f4f5, "test_ret");

 	dummy_st_ops__destroy(skel);
 }
@@ -53,10 +52,10 @@ static void test_dummy_init_ptr_arg(void)
 		.val =3D exp_retval,
 	};
 	__u64 args[1] =3D {(unsigned long)&in_state};
-	struct bpf_prog_test_run_attr attr =3D {
-		.ctx_size_in =3D sizeof(args),
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
 		.ctx_in =3D args,
-	};
+		.ctx_size_in =3D sizeof(args),
+	);
 	struct dummy_st_ops *skel;
 	int fd, err;

@@ -65,11 +64,10 @@ static void test_dummy_init_ptr_arg(void)
 		return;

 	fd =3D bpf_program__fd(skel->progs.test_1);
-	attr.prog_fd =3D fd;
-	err =3D bpf_prog_test_run_xattr(&attr);
+	err =3D bpf_prog_test_run_opts(fd, &topts);
 	ASSERT_OK(err, "test_run");
 	ASSERT_EQ(in_state.val, 0x5a, "test_ptr_ret");
-	ASSERT_EQ(attr.retval, exp_retval, "test_ret");
+	ASSERT_EQ(topts.retval, exp_retval, "test_ret");

 	dummy_st_ops__destroy(skel);
 }
@@ -77,10 +75,10 @@ static void test_dummy_init_ptr_arg(void)
 static void test_dummy_multiple_args(void)
 {
 	__u64 args[5] =3D {0, -100, 0x8a5f, 'c', 0x1234567887654321ULL};
-	struct bpf_prog_test_run_attr attr =3D {
-		.ctx_size_in =3D sizeof(args),
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
 		.ctx_in =3D args,
-	};
+		.ctx_size_in =3D sizeof(args),
+	);
 	struct dummy_st_ops *skel;
 	int fd, err;
 	size_t i;
@@ -91,8 +89,7 @@ static void test_dummy_multiple_args(void)
 		return;

 	fd =3D bpf_program__fd(skel->progs.test_2);
-	attr.prog_fd =3D fd;
-	err =3D bpf_prog_test_run_xattr(&attr);
+	err =3D bpf_prog_test_run_opts(fd, &topts);
 	ASSERT_OK(err, "test_run");
 	for (i =3D 0; i < ARRAY_SIZE(args); i++) {
 		snprintf(name, sizeof(name), "arg %zu", i);
diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/to=
ols/testing/selftests/bpf/prog_tests/flow_dissector.c
index dfafd62df50b..0bcf8e503c5f 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -13,30 +13,30 @@
 #endif

 #define CHECK_FLOW_KEYS(desc, got, expected)				\
-	CHECK_ATTR(memcmp(&got, &expected, sizeof(got)) !=3D 0,		\
-	      desc,							\
-	      "nhoff=3D%u/%u "						\
-	      "thoff=3D%u/%u "						\
-	      "addr_proto=3D0x%x/0x%x "					\
-	      "is_frag=3D%u/%u "						\
-	      "is_first_frag=3D%u/%u "					\
-	      "is_encap=3D%u/%u "						\
-	      "ip_proto=3D0x%x/0x%x "					\
-	      "n_proto=3D0x%x/0x%x "					\
-	      "flow_label=3D0x%x/0x%x "					\
-	      "sport=3D%u/%u "						\
-	      "dport=3D%u/%u\n",						\
-	      got.nhoff, expected.nhoff,				\
-	      got.thoff, expected.thoff,				\
-	      got.addr_proto, expected.addr_proto,			\
-	      got.is_frag, expected.is_frag,				\
-	      got.is_first_frag, expected.is_first_frag,		\
-	      got.is_encap, expected.is_encap,				\
-	      got.ip_proto, expected.ip_proto,				\
-	      got.n_proto, expected.n_proto,				\
-	      got.flow_label, expected.flow_label,			\
-	      got.sport, expected.sport,				\
-	      got.dport, expected.dport)
+	CHECK_OPTS(memcmp(&got, &expected, sizeof(got)) !=3D 0,		\
+			   desc,							\
+			   "nhoff=3D%u/%u "						\
+			   "thoff=3D%u/%u "						\
+			   "addr_proto=3D0x%x/0x%x "					\
+			   "is_frag=3D%u/%u "						\
+			   "is_first_frag=3D%u/%u "					\
+			   "is_encap=3D%u/%u "						\
+			   "ip_proto=3D0x%x/0x%x "					\
+			   "n_proto=3D0x%x/0x%x "					\
+			   "flow_label=3D0x%x/0x%x "					\
+			   "sport=3D%u/%u "						\
+			   "dport=3D%u/%u\n",						\
+			   got.nhoff, expected.nhoff,				\
+			   got.thoff, expected.thoff,				\
+			   got.addr_proto, expected.addr_proto,			\
+			   got.is_frag, expected.is_frag,				\
+			   got.is_first_frag, expected.is_first_frag,		\
+			   got.is_encap, expected.is_encap,				\
+			   got.ip_proto, expected.ip_proto,				\
+			   got.n_proto, expected.n_proto,				\
+			   got.flow_label, expected.flow_label,			\
+			   got.sport, expected.sport,				\
+			   got.dport, expected.dport)

 struct ipv4_pkt {
 	struct ethhdr eth;
@@ -487,7 +487,7 @@ static void run_tests_skb_less(int tap_fd, struct bpf=
_map *keys)
 		/* Keep in sync with 'flags' from eth_get_headlen. */
 		__u32 eth_get_headlen_flags =3D
 			BPF_FLOW_DISSECTOR_F_PARSE_1ST_FRAG;
-		struct bpf_prog_test_run_attr tattr =3D {};
+		LIBBPF_OPTS(bpf_test_run_opts, topts);
 		struct bpf_flow_keys flow_keys =3D {};
 		__u32 key =3D (__u32)(tests[i].keys.sport) << 16 |
 			    tests[i].keys.dport;
@@ -503,13 +503,13 @@ static void run_tests_skb_less(int tap_fd, struct b=
pf_map *keys)
 		CHECK(err < 0, "tx_tap", "err %d errno %d\n", err, errno);

 		err =3D bpf_map_lookup_elem(keys_fd, &key, &flow_keys);
-		CHECK_ATTR(err, tests[i].name, "bpf_map_lookup_elem %d\n", err);
+		CHECK_OPTS(err, tests[i].name, "bpf_map_lookup_elem %d\n", err);

-		CHECK_ATTR(err, tests[i].name, "skb-less err %d\n", err);
+		CHECK_OPTS(err, tests[i].name, "skb-less err %d\n", err);
 		CHECK_FLOW_KEYS(tests[i].name, flow_keys, tests[i].keys);

 		err =3D bpf_map_delete_elem(keys_fd, &key);
-		CHECK_ATTR(err, tests[i].name, "bpf_map_delete_elem %d\n", err);
+		CHECK_OPTS(err, tests[i].name, "bpf_map_delete_elem %d\n", err);
 	}
 }

@@ -573,27 +573,26 @@ void test_flow_dissector(void)

 	for (i =3D 0; i < ARRAY_SIZE(tests); i++) {
 		struct bpf_flow_keys flow_keys;
-		struct bpf_prog_test_run_attr tattr =3D {
-			.prog_fd =3D prog_fd,
+		LIBBPF_OPTS(bpf_test_run_opts, topts,
 			.data_in =3D &tests[i].pkt,
 			.data_size_in =3D sizeof(tests[i].pkt),
 			.data_out =3D &flow_keys,
-		};
+		);
 		static struct bpf_flow_keys ctx =3D {};

 		if (tests[i].flags) {
-			tattr.ctx_in =3D &ctx;
-			tattr.ctx_size_in =3D sizeof(ctx);
+			topts.ctx_in =3D &ctx;
+			topts.ctx_size_in =3D sizeof(ctx);
 			ctx.flags =3D tests[i].flags;
 		}

-		err =3D bpf_prog_test_run_xattr(&tattr);
-		CHECK_ATTR(tattr.data_size_out !=3D sizeof(flow_keys) ||
-			   err || tattr.retval !=3D 1,
+		err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+		CHECK_OPTS(topts.data_size_out !=3D sizeof(flow_keys) ||
+			   err || topts.retval !=3D 1,
 			   tests[i].name,
 			   "err %d errno %d retval %d duration %d size %u/%zu\n",
-			   err, errno, tattr.retval, tattr.duration,
-			   tattr.data_size_out, sizeof(flow_keys));
+			   err, errno, topts.retval, topts.duration,
+			   topts.data_size_out, sizeof(flow_keys));
 		CHECK_FLOW_KEYS(tests[i].name, flow_keys, tests[i].keys);
 	}

diff --git a/tools/testing/selftests/bpf/prog_tests/kfree_skb.c b/tools/t=
esting/selftests/bpf/prog_tests/kfree_skb.c
index ce10d2fc3a6c..7e50d6147e08 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
@@ -53,24 +53,24 @@ static void on_sample(void *ctx, int cpu, void *data,=
 __u32 size)
 void serial_test_kfree_skb(void)
 {
 	struct __sk_buff skb =3D {};
-	struct bpf_prog_test_run_attr tattr =3D {
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
 		.data_in =3D &pkt_v6,
 		.data_size_in =3D sizeof(pkt_v6),
 		.ctx_in =3D &skb,
 		.ctx_size_in =3D sizeof(skb),
-	};
+	);
 	struct kfree_skb *skel =3D NULL;
 	struct bpf_link *link;
 	struct bpf_object *obj;
 	struct perf_buffer *pb =3D NULL;
-	int err;
+	int err, prog_fd;
 	bool passed =3D false;
 	__u32 duration =3D 0;
 	const int zero =3D 0;
 	bool test_ok[2];

 	err =3D bpf_prog_test_load("./test_pkt_access.o", BPF_PROG_TYPE_SCHED_C=
LS,
-			    &obj, &tattr.prog_fd);
+				 &obj, &prog_fd);
 	if (CHECK(err, "prog_load sched cls", "err %d errno %d\n", err, errno))
 		return;

@@ -100,11 +100,11 @@ void serial_test_kfree_skb(void)
 		goto close_prog;

 	memcpy(skb.cb, &cb, sizeof(cb));
-	err =3D bpf_prog_test_run_xattr(&tattr);
-	duration =3D tattr.duration;
-	CHECK(err || tattr.retval, "ipv6",
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	duration =3D topts.duration;
+	CHECK(err || topts.retval, "ipv6",
 	      "err %d errno %d retval %d duration %d\n",
-	      err, errno, tattr.retval, duration);
+	      err, errno, topts.retval, duration);

 	/* read perf buffer */
 	err =3D perf_buffer__poll(pb, 100);
diff --git a/tools/testing/selftests/bpf/prog_tests/prog_run_xattr.c b/to=
ols/testing/selftests/bpf/prog_tests/prog_run_xattr.c
index 89fc98faf19e..53c75fa7acac 100644
--- a/tools/testing/selftests/bpf/prog_tests/prog_run_xattr.c
+++ b/tools/testing/selftests/bpf/prog_tests/prog_run_xattr.c
@@ -20,6 +20,9 @@ static void check_run_cnt(int prog_fd, __u64 run_cnt)
 	      "incorrect number of repetitions, want %llu have %llu\n", run_cnt=
, info.run_cnt);
 }

+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
+
 void test_prog_run_xattr(void)
 {
 	struct test_pkt_access *skel;
@@ -81,3 +84,5 @@ void test_prog_run_xattr(void)
 	if (stats_fd >=3D 0)
 		close(stats_fd);
 }
+
+#pragma GCC diagnostic pop
diff --git a/tools/testing/selftests/bpf/prog_tests/raw_tp_test_run.c b/t=
ools/testing/selftests/bpf/prog_tests/raw_tp_test_run.c
index 41720a62c4fa..8ba2681c9ffa 100644
--- a/tools/testing/selftests/bpf/prog_tests/raw_tp_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/raw_tp_test_run.c
@@ -5,89 +5,84 @@
 #include "bpf/libbpf_internal.h"
 #include "test_raw_tp_test_run.skel.h"

-static int duration;
-
 void test_raw_tp_test_run(void)
 {
-	struct bpf_prog_test_run_attr test_attr =3D {};
 	int comm_fd =3D -1, err, nr_online, i, prog_fd;
 	__u64 args[2] =3D {0x1234ULL, 0x5678ULL};
 	int expected_retval =3D 0x1234 + 0x5678;
 	struct test_raw_tp_test_run *skel;
 	char buf[] =3D "new_name";
 	bool *online =3D NULL;
-	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
-			    .ctx_in =3D args,
-			    .ctx_size_in =3D sizeof(args),
-			    .flags =3D BPF_F_TEST_RUN_ON_CPU,
-		);
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.ctx_in =3D args,
+		.ctx_size_in =3D sizeof(args),
+	);

 	err =3D parse_cpu_mask_file("/sys/devices/system/cpu/online", &online,
 				  &nr_online);
-	if (CHECK(err, "parse_cpu_mask_file", "err %d\n", err))
+	if (CHECK_OPTS(err, "parse_cpu_mask_file", "err %d\n", err))
 		return;

 	skel =3D test_raw_tp_test_run__open_and_load();
-	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
+	if (CHECK_OPTS(!skel, "skel_open", "failed to open skeleton\n"))
 		goto cleanup;

 	err =3D test_raw_tp_test_run__attach(skel);
-	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
+	if (CHECK_OPTS(err, "skel_attach", "skeleton attach failed: %d\n", err)=
)
 		goto cleanup;

 	comm_fd =3D open("/proc/self/comm", O_WRONLY|O_TRUNC);
-	if (CHECK(comm_fd < 0, "open /proc/self/comm", "err %d\n", errno))
+	if (CHECK_OPTS(comm_fd < 0, "open /proc/self/comm", "err %d\n", errno))
 		goto cleanup;

 	err =3D write(comm_fd, buf, sizeof(buf));
-	CHECK(err < 0, "task rename", "err %d", errno);
+	CHECK_OPTS(err < 0, "task rename", "err %d", errno);

-	CHECK(skel->bss->count =3D=3D 0, "check_count", "didn't increase\n");
-	CHECK(skel->data->on_cpu !=3D 0xffffffff, "check_on_cpu", "got wrong va=
lue\n");
+	CHECK_OPTS(skel->bss->count =3D=3D 0, "check_count", "didn't increase\n=
");
+	CHECK_OPTS(skel->data->on_cpu !=3D 0xffffffff, "check_on_cpu",
+		   "got wrong value\n");

 	prog_fd =3D bpf_program__fd(skel->progs.rename);
-	test_attr.prog_fd =3D prog_fd;
-	test_attr.ctx_in =3D args;
-	test_attr.ctx_size_in =3D sizeof(__u64);
+	topts.ctx_in =3D args;
+	topts.ctx_size_in =3D sizeof(__u64);

-	err =3D bpf_prog_test_run_xattr(&test_attr);
-	CHECK(err =3D=3D 0, "test_run", "should fail for too small ctx\n");
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	CHECK_OPTS(err =3D=3D 0, "test_run", "should fail for too small ctx\n")=
;

-	test_attr.ctx_size_in =3D sizeof(args);
-	err =3D bpf_prog_test_run_xattr(&test_attr);
-	CHECK(err < 0, "test_run", "err %d\n", errno);
-	CHECK(test_attr.retval !=3D expected_retval, "check_retval",
-	      "expect 0x%x, got 0x%x\n", expected_retval, test_attr.retval);
+	topts.ctx_size_in =3D sizeof(args);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	CHECK_OPTS(err < 0, "test_run", "err %d\n", errno);
+	CHECK_OPTS(topts.retval !=3D expected_retval, "check_retval",
+		   "expect 0x%x, got 0x%x\n", expected_retval, topts.retval);

 	for (i =3D 0; i < nr_online; i++) {
 		if (!online[i])
 			continue;

-		opts.cpu =3D i;
-		opts.retval =3D 0;
-		err =3D bpf_prog_test_run_opts(prog_fd, &opts);
-		CHECK(err < 0, "test_run_opts", "err %d\n", errno);
-		CHECK(skel->data->on_cpu !=3D i, "check_on_cpu",
-		      "expect %d got %d\n", i, skel->data->on_cpu);
-		CHECK(opts.retval !=3D expected_retval,
-		      "check_retval", "expect 0x%x, got 0x%x\n",
-		      expected_retval, opts.retval);
+		topts.flags =3D BPF_F_TEST_RUN_ON_CPU;
+		topts.cpu =3D i;
+		topts.retval =3D 0;
+		err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+		CHECK_OPTS(err < 0, "test_run_opts", "err %d\n", errno);
+		CHECK_OPTS(skel->data->on_cpu !=3D i, "check_on_cpu",
+			   "expect %d got %d\n", i, skel->data->on_cpu);
+		CHECK_OPTS(topts.retval !=3D expected_retval, "check_retval",
+			   "expect 0x%x, got 0x%x\n", expected_retval,
+			   topts.retval);
 	}

 	/* invalid cpu ID should fail with ENXIO */
-	opts.cpu =3D 0xffffffff;
-	err =3D bpf_prog_test_run_opts(prog_fd, &opts);
-	CHECK(err >=3D 0 || errno !=3D ENXIO,
-	      "test_run_opts_fail",
-	      "should failed with ENXIO\n");
+	topts.cpu =3D 0xffffffff;
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	CHECK_OPTS(err >=3D 0 || errno !=3D ENXIO, "test_run_opts_fail",
+		   "should failed with ENXIO\n");

 	/* non-zero cpu w/o BPF_F_TEST_RUN_ON_CPU should fail with EINVAL */
-	opts.cpu =3D 1;
-	opts.flags =3D 0;
-	err =3D bpf_prog_test_run_opts(prog_fd, &opts);
-	CHECK(err >=3D 0 || errno !=3D EINVAL,
-	      "test_run_opts_fail",
-	      "should failed with EINVAL\n");
+	topts.cpu =3D 1;
+	topts.flags =3D 0;
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	CHECK_OPTS(err >=3D 0 || errno !=3D EINVAL, "test_run_opts_fail",
+		   "should failed with EINVAL\n");

 cleanup:
 	close(comm_fd);
diff --git a/tools/testing/selftests/bpf/prog_tests/skb_ctx.c b/tools/tes=
ting/selftests/bpf/prog_tests/skb_ctx.c
index b5319ba2ee27..b6fba0b93733 100644
--- a/tools/testing/selftests/bpf/prog_tests/skb_ctx.c
+++ b/tools/testing/selftests/bpf/prog_tests/skb_ctx.c
@@ -20,97 +20,82 @@ void test_skb_ctx(void)
 		.gso_size =3D 10,
 		.hwtstamp =3D 11,
 	};
-	struct bpf_prog_test_run_attr tattr =3D {
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
 		.data_in =3D &pkt_v4,
 		.data_size_in =3D sizeof(pkt_v4),
 		.ctx_in =3D &skb,
 		.ctx_size_in =3D sizeof(skb),
 		.ctx_out =3D &skb,
 		.ctx_size_out =3D sizeof(skb),
-	};
+	);
 	struct bpf_object *obj;
-	int err;
-	int i;
+	int err, prog_fd, i;

-	err =3D bpf_prog_test_load("./test_skb_ctx.o", BPF_PROG_TYPE_SCHED_CLS,=
 &obj,
-			    &tattr.prog_fd);
-	if (CHECK_ATTR(err, "load", "err %d errno %d\n", err, errno))
+	err =3D bpf_prog_test_load("./test_skb_ctx.o", BPF_PROG_TYPE_SCHED_CLS,
+				 &obj, &prog_fd);
+	if (CHECK_OPTS(err, "load", "err %d errno %d\n", err, errno))
 		return;

 	/* ctx_in !=3D NULL, ctx_size_in =3D=3D 0 */

-	tattr.ctx_size_in =3D 0;
-	err =3D bpf_prog_test_run_xattr(&tattr);
-	CHECK_ATTR(err =3D=3D 0, "ctx_size_in", "err %d errno %d\n", err, errno=
);
-	tattr.ctx_size_in =3D sizeof(skb);
+	topts.ctx_size_in =3D 0;
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	CHECK_OPTS(err =3D=3D 0, "ctx_size_in", "err %d errno %d\n", err, errno=
);
+	topts.ctx_size_in =3D sizeof(skb);

 	/* ctx_out !=3D NULL, ctx_size_out =3D=3D 0 */

-	tattr.ctx_size_out =3D 0;
-	err =3D bpf_prog_test_run_xattr(&tattr);
-	CHECK_ATTR(err =3D=3D 0, "ctx_size_out", "err %d errno %d\n", err, errn=
o);
-	tattr.ctx_size_out =3D sizeof(skb);
+	topts.ctx_size_out =3D 0;
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	CHECK_OPTS(err =3D=3D 0, "ctx_size_out", "err %d errno %d\n", err, errn=
o);
+	topts.ctx_size_out =3D sizeof(skb);

 	/* non-zero [len, tc_index] fields should be rejected*/

 	skb.len =3D 1;
-	err =3D bpf_prog_test_run_xattr(&tattr);
-	CHECK_ATTR(err =3D=3D 0, "len", "err %d errno %d\n", err, errno);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	CHECK_OPTS(err =3D=3D 0, "len", "err %d errno %d\n", err, errno);
 	skb.len =3D 0;

 	skb.tc_index =3D 1;
-	err =3D bpf_prog_test_run_xattr(&tattr);
-	CHECK_ATTR(err =3D=3D 0, "tc_index", "err %d errno %d\n", err, errno);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	CHECK_OPTS(err =3D=3D 0, "tc_index", "err %d errno %d\n", err, errno);
 	skb.tc_index =3D 0;

 	/* non-zero [hash, sk] fields should be rejected */

 	skb.hash =3D 1;
-	err =3D bpf_prog_test_run_xattr(&tattr);
-	CHECK_ATTR(err =3D=3D 0, "hash", "err %d errno %d\n", err, errno);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	CHECK_OPTS(err =3D=3D 0, "hash", "err %d errno %d\n", err, errno);
 	skb.hash =3D 0;

 	skb.sk =3D (struct bpf_sock *)1;
-	err =3D bpf_prog_test_run_xattr(&tattr);
-	CHECK_ATTR(err =3D=3D 0, "sk", "err %d errno %d\n", err, errno);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	CHECK_OPTS(err =3D=3D 0, "sk", "err %d errno %d\n", err, errno);
 	skb.sk =3D 0;

-	err =3D bpf_prog_test_run_xattr(&tattr);
-	CHECK_ATTR(err !=3D 0 || tattr.retval,
-		   "run",
-		   "err %d errno %d retval %d\n",
-		   err, errno, tattr.retval);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	CHECK_OPTS(err !=3D 0 || topts.retval, "run",
+		   "err %d errno %d retval %d\n", err, errno, topts.retval);

-	CHECK_ATTR(tattr.ctx_size_out !=3D sizeof(skb),
-		   "ctx_size_out",
-		   "incorrect output size, want %zu have %u\n",
-		   sizeof(skb), tattr.ctx_size_out);
+	CHECK_OPTS(topts.ctx_size_out !=3D sizeof(skb), "ctx_size_out",
+		   "incorrect output size, want %zu have %u\n", sizeof(skb),
+		   topts.ctx_size_out);

 	for (i =3D 0; i < 5; i++)
-		CHECK_ATTR(skb.cb[i] !=3D i + 2,
-			   "ctx_out_cb",
-			   "skb->cb[i] =3D=3D %d, expected %d\n",
-			   skb.cb[i], i + 2);
-	CHECK_ATTR(skb.priority !=3D 7,
-		   "ctx_out_priority",
-		   "skb->priority =3D=3D %d, expected %d\n",
-		   skb.priority, 7);
-	CHECK_ATTR(skb.ifindex !=3D 1,
-		   "ctx_out_ifindex",
-		   "skb->ifindex =3D=3D %d, expected %d\n",
-		   skb.ifindex, 1);
-	CHECK_ATTR(skb.ingress_ifindex !=3D 11,
-		   "ctx_out_ingress_ifindex",
+		CHECK_OPTS(skb.cb[i] !=3D i + 2, "ctx_out_cb",
+			   "skb->cb[i] =3D=3D %d, expected %d\n", skb.cb[i], i + 2);
+	CHECK_OPTS(skb.priority !=3D 7, "ctx_out_priority",
+		   "skb->priority =3D=3D %d, expected %d\n", skb.priority, 7);
+	CHECK_OPTS(skb.ifindex !=3D 1, "ctx_out_ifindex",
+		   "skb->ifindex =3D=3D %d, expected %d\n", skb.ifindex, 1);
+	CHECK_OPTS(skb.ingress_ifindex !=3D 11, "ctx_out_ingress_ifindex",
 		   "skb->ingress_ifindex =3D=3D %d, expected %d\n",
 		   skb.ingress_ifindex, 11);
-	CHECK_ATTR(skb.tstamp !=3D 8,
-		   "ctx_out_tstamp",
-		   "skb->tstamp =3D=3D %lld, expected %d\n",
-		   skb.tstamp, 8);
-	CHECK_ATTR(skb.mark !=3D 10,
-		   "ctx_out_mark",
-		   "skb->mark =3D=3D %u, expected %d\n",
-		   skb.mark, 10);
+	CHECK_OPTS(skb.tstamp !=3D 8, "ctx_out_tstamp",
+		   "skb->tstamp =3D=3D %lld, expected %d\n", skb.tstamp, 8);
+	CHECK_OPTS(skb.mark !=3D 10, "ctx_out_mark",
+		   "skb->mark =3D=3D %u, expected %d\n", skb.mark, 10);

 	bpf_object__close(obj);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/skb_helpers.c b/tools=
/testing/selftests/bpf/prog_tests/skb_helpers.c
index 6f802a1c0800..d7516180925a 100644
--- a/tools/testing/selftests/bpf/prog_tests/skb_helpers.c
+++ b/tools/testing/selftests/bpf/prog_tests/skb_helpers.c
@@ -9,22 +9,22 @@ void test_skb_helpers(void)
 		.gso_segs =3D 8,
 		.gso_size =3D 10,
 	};
-	struct bpf_prog_test_run_attr tattr =3D {
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
 		.data_in =3D &pkt_v4,
 		.data_size_in =3D sizeof(pkt_v4),
 		.ctx_in =3D &skb,
 		.ctx_size_in =3D sizeof(skb),
 		.ctx_out =3D &skb,
 		.ctx_size_out =3D sizeof(skb),
-	};
+	);
 	struct bpf_object *obj;
-	int err;
+	int err, prog_fd;

-	err =3D bpf_prog_test_load("./test_skb_helpers.o", BPF_PROG_TYPE_SCHED_=
CLS, &obj,
-			    &tattr.prog_fd);
-	if (CHECK_ATTR(err, "load", "err %d errno %d\n", err, errno))
+	err =3D bpf_prog_test_load("./test_skb_helpers.o",
+				 BPF_PROG_TYPE_SCHED_CLS, &obj, &prog_fd);
+	if (CHECK_OPTS(err, "load", "err %d errno %d\n", err, errno))
 		return;
-	err =3D bpf_prog_test_run_xattr(&tattr);
-	CHECK_ATTR(err, "len", "err %d errno %d\n", err, errno);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	CHECK_OPTS(err, "len", "err %d errno %d\n", err, errno);
 	bpf_object__close(obj);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/too=
ls/testing/selftests/bpf/prog_tests/sockmap_basic.c
index b97a8f236b3a..546ad5a6455e 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -140,12 +140,16 @@ static void test_skmsg_helpers(enum bpf_map_type ma=
p_type)

 static void test_sockmap_update(enum bpf_map_type map_type)
 {
-	struct bpf_prog_test_run_attr tattr;
 	int err, prog, src, duration =3D 0;
 	struct test_sockmap_update *skel;
 	struct bpf_map *dst_map;
 	const __u32 zero =3D 0;
 	char dummy[14] =3D {0};
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D dummy,
+		.data_size_in =3D sizeof(dummy),
+		.repeat =3D 1,
+	);
 	__s64 sk;

 	sk =3D connected_socket_v4();
@@ -167,16 +171,9 @@ static void test_sockmap_update(enum bpf_map_type ma=
p_type)
 	if (CHECK(err, "update_elem(src)", "errno=3D%u\n", errno))
 		goto out;

-	tattr =3D (struct bpf_prog_test_run_attr){
-		.prog_fd =3D prog,
-		.repeat =3D 1,
-		.data_in =3D dummy,
-		.data_size_in =3D sizeof(dummy),
-	};
-
-	err =3D bpf_prog_test_run_xattr(&tattr);
-	if (CHECK_ATTR(err || !tattr.retval, "bpf_prog_test_run",
-		       "errno=3D%u retval=3D%u\n", errno, tattr.retval))
+	err =3D bpf_prog_test_run_opts(prog, &topts);
+	if (CHECK_OPTS(err || !topts.retval, "bpf_prog_test_run",
+		       "errno=3D%u retval=3D%u\n", errno, topts.retval))
 		goto out;

 	compare_cookies(skel->maps.src, dst_map);
diff --git a/tools/testing/selftests/bpf/prog_tests/syscall.c b/tools/tes=
ting/selftests/bpf/prog_tests/syscall.c
index 81e997a69f7a..542c9b2a860a 100644
--- a/tools/testing/selftests/bpf/prog_tests/syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/syscall.c
@@ -20,22 +20,22 @@ void test_syscall(void)
 		.log_buf =3D (uintptr_t) verifier_log,
 		.log_size =3D sizeof(verifier_log),
 	};
-	struct bpf_prog_test_run_attr tattr =3D {
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
 		.ctx_in =3D &ctx,
 		.ctx_size_in =3D sizeof(ctx),
-	};
+	);
 	struct syscall *skel =3D NULL;
 	__u64 key =3D 12, value =3D 0;
-	int err;
+	int err, prog_fd;

 	skel =3D syscall__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "skel_load"))
 		goto cleanup;

-	tattr.prog_fd =3D bpf_program__fd(skel->progs.bpf_prog);
-	err =3D bpf_prog_test_run_xattr(&tattr);
+	prog_fd =3D bpf_program__fd(skel->progs.bpf_prog);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_EQ(err, 0, "err");
-	ASSERT_EQ(tattr.retval, 1, "retval");
+	ASSERT_EQ(topts.retval, 1, "retval");
 	ASSERT_GT(ctx.map_fd, 0, "ctx.map_fd");
 	ASSERT_GT(ctx.prog_fd, 0, "ctx.prog_fd");
 	ASSERT_OK(memcmp(verifier_log, "processed", sizeof("processed") - 1),
diff --git a/tools/testing/selftests/bpf/prog_tests/test_profiler.c b/too=
ls/testing/selftests/bpf/prog_tests/test_profiler.c
index 4ca275101ee0..67e32df1212f 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_profiler.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_profiler.c
@@ -8,19 +8,19 @@

 static int sanity_run(struct bpf_program *prog)
 {
-	struct bpf_prog_test_run_attr test_attr =3D {};
 	__u64 args[] =3D {1, 2, 3};
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.ctx_in =3D args,
+		.ctx_size_in =3D sizeof(args),
+	);
 	__u32 duration =3D 0;
 	int err, prog_fd;

 	prog_fd =3D bpf_program__fd(prog);
-	test_attr.prog_fd =3D prog_fd;
-	test_attr.ctx_in =3D args;
-	test_attr.ctx_size_in =3D sizeof(args);
-	err =3D bpf_prog_test_run_xattr(&test_attr);
-	if (CHECK(err || test_attr.retval, "test_run",
-		  "err %d errno %d retval %d duration %d\n",
-		  err, errno, test_attr.retval, duration))
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	if (CHECK(err || topts.retval, "test_run",
+		  "err %d errno %d retval %d duration %d\n", err, errno,
+		  topts.retval, duration))
 		return -1;
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c b/t=
ools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
index bb1b833318d3..f638cbf983e7 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
@@ -78,30 +78,30 @@ static void test_xdp_adjust_tail_grow2(void)
 	int tailroom =3D 320; /* SKB_DATA_ALIGN(sizeof(struct skb_shared_info))=
*/;
 	struct bpf_object *obj;
 	int err, cnt, i;
-	int max_grow;
+	int max_grow, prog_fd;

-	struct bpf_prog_test_run_attr tattr =3D {
-		.repeat		=3D 1,
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
 		.data_in	=3D &buf,
 		.data_out	=3D &buf,
 		.data_size_in	=3D 0, /* Per test */
 		.data_size_out	=3D 0, /* Per test */
-	};
+		.repeat		=3D 1,
+	);

-	err =3D bpf_prog_test_load(file, BPF_PROG_TYPE_XDP, &obj, &tattr.prog_f=
d);
+	err =3D bpf_prog_test_load(file, BPF_PROG_TYPE_XDP, &obj, &prog_fd);
 	if (ASSERT_OK(err, "test_xdp_adjust_tail_grow"))
 		return;

 	/* Test case-64 */
 	memset(buf, 1, sizeof(buf));
-	tattr.data_size_in  =3D  64; /* Determine test case via pkt size */
-	tattr.data_size_out =3D 128; /* Limit copy_size */
+	topts.data_size_in  =3D  64; /* Determine test case via pkt size */
+	topts.data_size_out =3D 128; /* Limit copy_size */
 	/* Kernel side alloc packet memory area that is zero init */
-	err =3D bpf_prog_test_run_xattr(&tattr);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);

 	ASSERT_EQ(errno, ENOSPC, "case-64 errno"); /* Due limit copy_size in bp=
f_test_finish */
-	ASSERT_EQ(tattr.retval, XDP_TX, "case-64 retval");
-	ASSERT_EQ(tattr.data_size_out, 192, "case-64 data_size_out"); /* Expect=
ed grow size */
+	ASSERT_EQ(topts.retval, XDP_TX, "case-64 retval");
+	ASSERT_EQ(topts.data_size_out, 192, "case-64 data_size_out"); /* Expect=
ed grow size */

 	/* Extra checks for data contents */
 	ASSERT_EQ(buf[0], 1, "case-64-data buf[0]"); /*  0-63  memset to 1 */
@@ -113,22 +113,22 @@ static void test_xdp_adjust_tail_grow2(void)

 	/* Test case-128 */
 	memset(buf, 2, sizeof(buf));
-	tattr.data_size_in  =3D 128; /* Determine test case via pkt size */
-	tattr.data_size_out =3D sizeof(buf);   /* Copy everything */
-	err =3D bpf_prog_test_run_xattr(&tattr);
+	topts.data_size_in  =3D 128; /* Determine test case via pkt size */
+	topts.data_size_out =3D sizeof(buf);   /* Copy everything */
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);

 	max_grow =3D 4096 - XDP_PACKET_HEADROOM -	tailroom; /* 3520 */
 	ASSERT_OK(err, "case-128");
-	ASSERT_EQ(tattr.retval, XDP_TX, "case-128 retval");
-	ASSERT_EQ(tattr.data_size_out, max_grow, "case-128 data_size_out"); /* =
Expect max grow */
+	ASSERT_EQ(topts.retval, XDP_TX, "case-128 retval");
+	ASSERT_EQ(topts.data_size_out, max_grow, "case-128 data_size_out"); /* =
Expect max grow */

 	/* Extra checks for data content: Count grow size, will contain zeros *=
/
 	for (i =3D 0, cnt =3D 0; i < sizeof(buf); i++) {
 		if (buf[i] =3D=3D 0)
 			cnt++;
 	}
-	ASSERT_EQ(cnt, max_grow - tattr.data_size_in, "case-128-data cnt"); /* =
Grow increase */
-	ASSERT_EQ(tattr.data_size_out, max_grow, "case-128-data data_size_out")=
; /* Total grow */
+	ASSERT_EQ(cnt, max_grow - topts.data_size_in, "case-128-data cnt"); /* =
Grow increase */
+	ASSERT_EQ(topts.data_size_out, max_grow, "case-128-data data_size_out")=
; /* Total grow */

 	bpf_object__close(obj);
 }
--
2.30.2
