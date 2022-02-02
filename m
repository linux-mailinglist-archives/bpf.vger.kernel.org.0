Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FF94A7BFE
	for <lists+bpf@lfdr.de>; Thu,  3 Feb 2022 00:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348195AbiBBX4r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Feb 2022 18:56:47 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32828 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344344AbiBBX4r (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Feb 2022 18:56:47 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 212Lpp5i031267
        for <bpf@vger.kernel.org>; Wed, 2 Feb 2022 15:56:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=i1dvtfFMoHCKQsQTCPHBSFCLwSdMWTt7WMNC4IIexpE=;
 b=DLRekBXqQtfr2MZ4F4MXCZOrIqdFmG34I6N7Cjs0rmtqHKMADYW/S31HG79Okb6Bk8QB
 k7mAKDl/x+kUOBEhxfY0AVwHSV/ksrhqHhe+wScLXAO8PtPGdmvV36Gjvob2SjJIP/1v
 fJR6j6e0suq/5fUhX3OSlbfUdG95Q8vmHmU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dym1gx3mh-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 02 Feb 2022 15:56:46 -0800
Received: from twshared14630.35.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Feb 2022 15:56:45 -0800
Received: by devvm3278.frc0.facebook.com (Postfix, from userid 8598)
        id 367BB1C61C1FD; Wed,  2 Feb 2022 15:56:33 -0800 (PST)
From:   Delyan Kratunov <delyank@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     Delyan Kratunov <delyank@fb.com>
Subject: [PATCH bpf-next v3 2/4] selftests/bpf: migrate from bpf_prog_test_run_xattr
Date:   Wed, 2 Feb 2022 15:54:21 -0800
Message-ID: <20220202235423.1097270-3-delyank@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202235423.1097270-1-delyank@fb.com>
References: <20220202235423.1097270-1-delyank@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 5QHtsIppSc5fS6EBhaXgcI_tJ82poVbr
X-Proofpoint-ORIG-GUID: 5QHtsIppSc5fS6EBhaXgcI_tJ82poVbr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_11,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202020130
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_prog_test_run_xattr is being deprecated in favor of the OPTS-based
bpf_prog_test_run_opts.
We end up unable to use CHECK_ATTR so replace usages with ASSERT_* calls.
Also, prog_run_xattr is now prog_run_opts.

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 .../selftests/bpf/prog_tests/check_mtu.c      | 40 +++------
 .../selftests/bpf/prog_tests/cls_redirect.c   | 10 +--
 .../selftests/bpf/prog_tests/dummy_st_ops.c   | 27 +++---
 .../selftests/bpf/prog_tests/flow_dissector.c | 31 ++++---
 .../selftests/bpf/prog_tests/kfree_skb.c      | 16 ++--
 .../selftests/bpf/prog_tests/prog_run_opts.c  | 77 +++++++++++++++++
 .../selftests/bpf/prog_tests/prog_run_xattr.c | 83 -------------------
 .../bpf/prog_tests/raw_tp_test_run.c          | 64 ++++++--------
 .../selftests/bpf/prog_tests/skb_ctx.c        | 81 +++++++-----------
 .../selftests/bpf/prog_tests/skb_helpers.c    | 16 ++--
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 20 ++---
 .../selftests/bpf/prog_tests/syscall.c        | 10 +--
 .../selftests/bpf/prog_tests/test_profiler.c  | 14 ++--
 .../bpf/prog_tests/xdp_adjust_tail.c          | 12 +--
 14 files changed, 218 insertions(+), 283 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/prog_run_opts.=
c
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/prog_run_xattr=
.c

diff --git a/tools/testing/selftests/bpf/prog_tests/check_mtu.c b/tools/t=
esting/selftests/bpf/prog_tests/check_mtu.c
index f73e6e36b74d..12f4395f18b3 100644
--- a/tools/testing/selftests/bpf/prog_tests/check_mtu.c
+++ b/tools/testing/selftests/bpf/prog_tests/check_mtu.c
@@ -79,28 +79,21 @@ static void test_check_mtu_run_xdp(struct test_check_=
mtu *skel,
 				   struct bpf_program *prog,
 				   __u32 mtu_expect)
 {
-	const char *prog_name =3D bpf_program__name(prog);
 	int retval_expect =3D XDP_PASS;
 	__u32 mtu_result =3D 0;
 	char buf[256] =3D {};
-	int err;
-	struct bpf_prog_test_run_attr tattr =3D {
+	int err, prog_fd =3D bpf_program__fd(prog);
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
 		.repeat =3D 1,
 		.data_in =3D &pkt_v4,
 		.data_size_in =3D sizeof(pkt_v4),
 		.data_out =3D buf,
 		.data_size_out =3D sizeof(buf),
-		.prog_fd =3D bpf_program__fd(prog),
-	};
-
-	err =3D bpf_prog_test_run_xattr(&tattr);
-	CHECK_ATTR(err !=3D 0, "bpf_prog_test_run",
-		   "prog_name:%s (err %d errno %d retval %d)\n",
-		   prog_name, err, errno, tattr.retval);
+	);

-	CHECK(tattr.retval !=3D retval_expect, "retval",
-	      "progname:%s unexpected retval=3D%d expected=3D%d\n",
-	      prog_name, tattr.retval, retval_expect);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, retval_expect, "retval");

 	/* Extract MTU that BPF-prog got */
 	mtu_result =3D skel->bss->global_bpf_mtu_xdp;
@@ -139,28 +132,21 @@ static void test_check_mtu_run_tc(struct test_check=
_mtu *skel,
 				  struct bpf_program *prog,
 				  __u32 mtu_expect)
 {
-	const char *prog_name =3D bpf_program__name(prog);
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
-
-	err =3D bpf_prog_test_run_xattr(&tattr);
-	CHECK_ATTR(err !=3D 0, "bpf_prog_test_run",
-		   "prog_name:%s (err %d errno %d retval %d)\n",
-		   prog_name, err, errno, tattr.retval);
+		.repeat =3D 1,
+	);

-	CHECK(tattr.retval !=3D retval_expect, "retval",
-	      "progname:%s unexpected retval=3D%d expected=3D%d\n",
-	      prog_name, tattr.retval, retval_expect);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, retval_expect, "retval");

 	/* Extract MTU that BPF-prog got */
 	mtu_result =3D skel->bss->global_bpf_mtu_tc;
diff --git a/tools/testing/selftests/bpf/prog_tests/cls_redirect.c b/tool=
s/testing/selftests/bpf/prog_tests/cls_redirect.c
index e075d03ab630..224f016b0a53 100644
--- a/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
@@ -161,7 +161,7 @@ static socklen_t prepare_addr(struct sockaddr_storage=
 *addr, int family)
 	}
 }

-static bool was_decapsulated(struct bpf_prog_test_run_attr *tattr)
+static bool was_decapsulated(struct bpf_test_run_opts *tattr)
 {
 	return tattr->data_size_out < tattr->data_size_in;
 }
@@ -367,12 +367,12 @@ static void close_fds(int *fds, int n)

 static void test_cls_redirect_common(struct bpf_program *prog)
 {
-	struct bpf_prog_test_run_attr tattr =3D {};
+	LIBBPF_OPTS(bpf_test_run_opts, tattr);
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

@@ -415,7 +415,7 @@ static void test_cls_redirect_common(struct bpf_progr=
am *prog)
 			if (CHECK_FAIL(!tattr.data_size_in))
 				continue;

-			err =3D bpf_prog_test_run_xattr(&tattr);
+			err =3D bpf_prog_test_run_opts(prog_fd, &tattr);
 			if (CHECK_FAIL(err))
 				continue;

diff --git a/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c b/tool=
s/testing/selftests/bpf/prog_tests/dummy_st_ops.c
index cbaa44ffb8c6..5aa52cc31dc2 100644
--- a/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
+++ b/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
@@ -26,10 +26,10 @@ static void test_dummy_st_ops_attach(void)
 static void test_dummy_init_ret_value(void)
 {
 	__u64 args[1] =3D {0};
-	struct bpf_prog_test_run_attr attr =3D {
-		.ctx_size_in =3D sizeof(args),
+	LIBBPF_OPTS(bpf_test_run_opts, attr,
 		.ctx_in =3D args,
-	};
+		.ctx_size_in =3D sizeof(args),
+	);
 	struct dummy_st_ops *skel;
 	int fd, err;

@@ -38,8 +38,7 @@ static void test_dummy_init_ret_value(void)
 		return;

 	fd =3D bpf_program__fd(skel->progs.test_1);
-	attr.prog_fd =3D fd;
-	err =3D bpf_prog_test_run_xattr(&attr);
+	err =3D bpf_prog_test_run_opts(fd, &attr);
 	ASSERT_OK(err, "test_run");
 	ASSERT_EQ(attr.retval, 0xf2f3f4f5, "test_ret");

@@ -53,10 +52,10 @@ static void test_dummy_init_ptr_arg(void)
 		.val =3D exp_retval,
 	};
 	__u64 args[1] =3D {(unsigned long)&in_state};
-	struct bpf_prog_test_run_attr attr =3D {
-		.ctx_size_in =3D sizeof(args),
+	LIBBPF_OPTS(bpf_test_run_opts, attr,
 		.ctx_in =3D args,
-	};
+		.ctx_size_in =3D sizeof(args),
+	);
 	struct dummy_st_ops *skel;
 	int fd, err;

@@ -65,8 +64,7 @@ static void test_dummy_init_ptr_arg(void)
 		return;

 	fd =3D bpf_program__fd(skel->progs.test_1);
-	attr.prog_fd =3D fd;
-	err =3D bpf_prog_test_run_xattr(&attr);
+	err =3D bpf_prog_test_run_opts(fd, &attr);
 	ASSERT_OK(err, "test_run");
 	ASSERT_EQ(in_state.val, 0x5a, "test_ptr_ret");
 	ASSERT_EQ(attr.retval, exp_retval, "test_ret");
@@ -77,10 +75,10 @@ static void test_dummy_init_ptr_arg(void)
 static void test_dummy_multiple_args(void)
 {
 	__u64 args[5] =3D {0, -100, 0x8a5f, 'c', 0x1234567887654321ULL};
-	struct bpf_prog_test_run_attr attr =3D {
-		.ctx_size_in =3D sizeof(args),
+	LIBBPF_OPTS(bpf_test_run_opts, attr,
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
+	err =3D bpf_prog_test_run_opts(fd, &attr);
 	ASSERT_OK(err, "test_run");
 	for (i =3D 0; i < ARRAY_SIZE(args); i++) {
 		snprintf(name, sizeof(name), "arg %zu", i);
diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/to=
ols/testing/selftests/bpf/prog_tests/flow_dissector.c
index dfafd62df50b..0c1661ea996e 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -13,8 +13,9 @@
 #endif

 #define CHECK_FLOW_KEYS(desc, got, expected)				\
-	CHECK_ATTR(memcmp(&got, &expected, sizeof(got)) !=3D 0,		\
+	_CHECK(memcmp(&got, &expected, sizeof(got)) !=3D 0,		\
 	      desc,							\
+	      topts.duration,						\
 	      "nhoff=3D%u/%u "						\
 	      "thoff=3D%u/%u "						\
 	      "addr_proto=3D0x%x/0x%x "					\
@@ -487,7 +488,7 @@ static void run_tests_skb_less(int tap_fd, struct bpf=
_map *keys)
 		/* Keep in sync with 'flags' from eth_get_headlen. */
 		__u32 eth_get_headlen_flags =3D
 			BPF_FLOW_DISSECTOR_F_PARSE_1ST_FRAG;
-		struct bpf_prog_test_run_attr tattr =3D {};
+		LIBBPF_OPTS(bpf_test_run_opts, topts);
 		struct bpf_flow_keys flow_keys =3D {};
 		__u32 key =3D (__u32)(tests[i].keys.sport) << 16 |
 			    tests[i].keys.dport;
@@ -503,13 +504,12 @@ static void run_tests_skb_less(int tap_fd, struct b=
pf_map *keys)
 		CHECK(err < 0, "tx_tap", "err %d errno %d\n", err, errno);

 		err =3D bpf_map_lookup_elem(keys_fd, &key, &flow_keys);
-		CHECK_ATTR(err, tests[i].name, "bpf_map_lookup_elem %d\n", err);
+		ASSERT_OK(err, "bpf_map_lookup_elem");

-		CHECK_ATTR(err, tests[i].name, "skb-less err %d\n", err);
 		CHECK_FLOW_KEYS(tests[i].name, flow_keys, tests[i].keys);

 		err =3D bpf_map_delete_elem(keys_fd, &key);
-		CHECK_ATTR(err, tests[i].name, "bpf_map_delete_elem %d\n", err);
+		ASSERT_OK(err, "bpf_map_delete_elem");
 	}
 }

@@ -573,27 +573,24 @@ void test_flow_dissector(void)

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
-			   tests[i].name,
-			   "err %d errno %d retval %d duration %d size %u/%zu\n",
-			   err, errno, tattr.retval, tattr.duration,
-			   tattr.data_size_out, sizeof(flow_keys));
+		err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+		ASSERT_OK(err, "test_run");
+		ASSERT_EQ(topts.retval, 1, "test_run retval");
+		ASSERT_EQ(topts.data_size_out, sizeof(flow_keys),
+			  "test_run data_size_out");
 		CHECK_FLOW_KEYS(tests[i].name, flow_keys, tests[i].keys);
 	}

diff --git a/tools/testing/selftests/bpf/prog_tests/kfree_skb.c b/tools/t=
esting/selftests/bpf/prog_tests/kfree_skb.c
index ce10d2fc3a6c..1cee6957285e 100644
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

@@ -100,11 +100,9 @@ void serial_test_kfree_skb(void)
 		goto close_prog;

 	memcpy(skb.cb, &cb, sizeof(cb));
-	err =3D bpf_prog_test_run_xattr(&tattr);
-	duration =3D tattr.duration;
-	CHECK(err || tattr.retval, "ipv6",
-	      "err %d errno %d retval %d duration %d\n",
-	      err, errno, tattr.retval, duration);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "ipv6 test_run");
+	ASSERT_OK(topts.retval, "ipv6 test_run retval");

 	/* read perf buffer */
 	err =3D perf_buffer__poll(pb, 100);
diff --git a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c b/too=
ls/testing/selftests/bpf/prog_tests/prog_run_opts.c
new file mode 100644
index 000000000000..1ccd2bdf8fa8
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+
+#include "test_pkt_access.skel.h"
+
+static const __u32 duration;
+
+static void check_run_cnt(int prog_fd, __u64 run_cnt)
+{
+	struct bpf_prog_info info =3D {};
+	__u32 info_len =3D sizeof(info);
+	int err;
+
+	err =3D bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
+	if (CHECK(err, "get_prog_info", "failed to get bpf_prog_info for fd %d\=
n", prog_fd))
+		return;
+
+	CHECK(run_cnt !=3D info.run_cnt, "run_cnt",
+	      "incorrect number of repetitions, want %llu have %llu\n", run_cnt=
, info.run_cnt);
+}
+
+void test_prog_run_opts(void)
+{
+	struct test_pkt_access *skel;
+	int err, stats_fd =3D -1, prog_fd;
+	char buf[10] =3D {};
+	__u64 run_cnt =3D 0;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.repeat =3D 1,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.data_out =3D buf,
+		.data_size_out =3D 5,
+	);
+
+	stats_fd =3D bpf_enable_stats(BPF_STATS_RUN_TIME);
+	if (!ASSERT_GE(stats_fd, 0, "enable_stats good fd"))
+		return;
+
+	skel =3D test_pkt_access__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto cleanup;
+
+	prog_fd =3D bpf_program__fd(skel->progs.test_pkt_access);
+
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_EQ(errno, ENOSPC, "test_run errno");
+	ASSERT_ERR(err, "test_run");
+	ASSERT_OK(topts.retval, "test_run retval");
+
+	ASSERT_EQ(topts.data_size_out, sizeof(pkt_v4), "test_run data_size_out"=
);
+	ASSERT_EQ(buf[5], 0, "overflow, BPF_PROG_TEST_RUN ignored size hint");
+
+	run_cnt +=3D topts.repeat;
+	check_run_cnt(prog_fd, run_cnt);
+
+	topts.data_out =3D NULL;
+	topts.data_size_out =3D 0;
+	topts.repeat =3D 2;
+	errno =3D 0;
+
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(errno, "run_no_output errno");
+	ASSERT_OK(err, "run_no_output err");
+	ASSERT_OK(topts.retval, "run_no_output retval");
+
+	run_cnt +=3D topts.repeat;
+	check_run_cnt(prog_fd, run_cnt);
+
+cleanup:
+	if (skel)
+		test_pkt_access__destroy(skel);
+	if (stats_fd >=3D 0)
+		close(stats_fd);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/prog_run_xattr.c b/to=
ols/testing/selftests/bpf/prog_tests/prog_run_xattr.c
deleted file mode 100644
index 89fc98faf19e..000000000000
--- a/tools/testing/selftests/bpf/prog_tests/prog_run_xattr.c
+++ /dev/null
@@ -1,83 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <test_progs.h>
-#include <network_helpers.h>
-
-#include "test_pkt_access.skel.h"
-
-static const __u32 duration;
-
-static void check_run_cnt(int prog_fd, __u64 run_cnt)
-{
-	struct bpf_prog_info info =3D {};
-	__u32 info_len =3D sizeof(info);
-	int err;
-
-	err =3D bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
-	if (CHECK(err, "get_prog_info", "failed to get bpf_prog_info for fd %d\=
n", prog_fd))
-		return;
-
-	CHECK(run_cnt !=3D info.run_cnt, "run_cnt",
-	      "incorrect number of repetitions, want %llu have %llu\n", run_cnt=
, info.run_cnt);
-}
-
-void test_prog_run_xattr(void)
-{
-	struct test_pkt_access *skel;
-	int err, stats_fd =3D -1;
-	char buf[10] =3D {};
-	__u64 run_cnt =3D 0;
-
-	struct bpf_prog_test_run_attr tattr =3D {
-		.repeat =3D 1,
-		.data_in =3D &pkt_v4,
-		.data_size_in =3D sizeof(pkt_v4),
-		.data_out =3D buf,
-		.data_size_out =3D 5,
-	};
-
-	stats_fd =3D bpf_enable_stats(BPF_STATS_RUN_TIME);
-	if (CHECK_ATTR(stats_fd < 0, "enable_stats", "failed %d\n", errno))
-		return;
-
-	skel =3D test_pkt_access__open_and_load();
-	if (CHECK_ATTR(!skel, "open_and_load", "failed\n"))
-		goto cleanup;
-
-	tattr.prog_fd =3D bpf_program__fd(skel->progs.test_pkt_access);
-
-	err =3D bpf_prog_test_run_xattr(&tattr);
-	CHECK_ATTR(err >=3D 0 || errno !=3D ENOSPC || tattr.retval, "run",
-	      "err %d errno %d retval %d\n", err, errno, tattr.retval);
-
-	CHECK_ATTR(tattr.data_size_out !=3D sizeof(pkt_v4), "data_size_out",
-	      "incorrect output size, want %zu have %u\n",
-	      sizeof(pkt_v4), tattr.data_size_out);
-
-	CHECK_ATTR(buf[5] !=3D 0, "overflow",
-	      "BPF_PROG_TEST_RUN ignored size hint\n");
-
-	run_cnt +=3D tattr.repeat;
-	check_run_cnt(tattr.prog_fd, run_cnt);
-
-	tattr.data_out =3D NULL;
-	tattr.data_size_out =3D 0;
-	tattr.repeat =3D 2;
-	errno =3D 0;
-
-	err =3D bpf_prog_test_run_xattr(&tattr);
-	CHECK_ATTR(err || errno || tattr.retval, "run_no_output",
-	      "err %d errno %d retval %d\n", err, errno, tattr.retval);
-
-	tattr.data_size_out =3D 1;
-	err =3D bpf_prog_test_run_xattr(&tattr);
-	CHECK_ATTR(err !=3D -EINVAL, "run_wrong_size_out", "err %d\n", err);
-
-	run_cnt +=3D tattr.repeat;
-	check_run_cnt(tattr.prog_fd, run_cnt);
-
-cleanup:
-	if (skel)
-		test_pkt_access__destroy(skel);
-	if (stats_fd >=3D 0)
-		close(stats_fd);
-}
diff --git a/tools/testing/selftests/bpf/prog_tests/raw_tp_test_run.c b/t=
ools/testing/selftests/bpf/prog_tests/raw_tp_test_run.c
index 41720a62c4fa..fe5b8fae2c36 100644
--- a/tools/testing/selftests/bpf/prog_tests/raw_tp_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/raw_tp_test_run.c
@@ -5,59 +5,54 @@
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
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.ctx_in =3D args,
+		.ctx_size_in =3D sizeof(args),
+		.flags =3D BPF_F_TEST_RUN_ON_CPU,
+	);

 	err =3D parse_cpu_mask_file("/sys/devices/system/cpu/online", &online,
 				  &nr_online);
-	if (CHECK(err, "parse_cpu_mask_file", "err %d\n", err))
+	if (!ASSERT_OK(err, "parse_cpu_mask_file"))
 		return;

 	skel =3D test_raw_tp_test_run__open_and_load();
-	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		goto cleanup;

 	err =3D test_raw_tp_test_run__attach(skel);
-	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
+	if (!ASSERT_OK(err, "skel_attach"))
 		goto cleanup;

 	comm_fd =3D open("/proc/self/comm", O_WRONLY|O_TRUNC);
-	if (CHECK(comm_fd < 0, "open /proc/self/comm", "err %d\n", errno))
+	if (!ASSERT_GE(comm_fd, 0, "open /proc/self/comm"))
 		goto cleanup;

 	err =3D write(comm_fd, buf, sizeof(buf));
-	CHECK(err < 0, "task rename", "err %d", errno);
+	ASSERT_GE(err, 0, "task rename");

-	CHECK(skel->bss->count =3D=3D 0, "check_count", "didn't increase\n");
-	CHECK(skel->data->on_cpu !=3D 0xffffffff, "check_on_cpu", "got wrong va=
lue\n");
+	ASSERT_NEQ(skel->bss->count, 0, "check_count");
+	ASSERT_EQ(skel->data->on_cpu, 0xffffffff, "check_on_cpu");

 	prog_fd =3D bpf_program__fd(skel->progs.rename);
-	test_attr.prog_fd =3D prog_fd;
-	test_attr.ctx_in =3D args;
-	test_attr.ctx_size_in =3D sizeof(__u64);
+	opts.ctx_in =3D args;
+	opts.ctx_size_in =3D sizeof(__u64);

-	err =3D bpf_prog_test_run_xattr(&test_attr);
-	CHECK(err =3D=3D 0, "test_run", "should fail for too small ctx\n");
+	err =3D bpf_prog_test_run_opts(prog_fd, &opts);
+	ASSERT_NEQ(err, 0, "test_run should fail for too small ctx");

-	test_attr.ctx_size_in =3D sizeof(args);
-	err =3D bpf_prog_test_run_xattr(&test_attr);
-	CHECK(err < 0, "test_run", "err %d\n", errno);
-	CHECK(test_attr.retval !=3D expected_retval, "check_retval",
-	      "expect 0x%x, got 0x%x\n", expected_retval, test_attr.retval);
+	opts.ctx_size_in =3D sizeof(args);
+	err =3D bpf_prog_test_run_opts(prog_fd, &opts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(opts.retval, expected_retval, "check_retval");

 	for (i =3D 0; i < nr_online; i++) {
 		if (!online[i])
@@ -66,28 +61,23 @@ void test_raw_tp_test_run(void)
 		opts.cpu =3D i;
 		opts.retval =3D 0;
 		err =3D bpf_prog_test_run_opts(prog_fd, &opts);
-		CHECK(err < 0, "test_run_opts", "err %d\n", errno);
-		CHECK(skel->data->on_cpu !=3D i, "check_on_cpu",
-		      "expect %d got %d\n", i, skel->data->on_cpu);
-		CHECK(opts.retval !=3D expected_retval,
-		      "check_retval", "expect 0x%x, got 0x%x\n",
-		      expected_retval, opts.retval);
+		ASSERT_OK(err, "test_run_opts");
+		ASSERT_EQ(skel->data->on_cpu, i, "check_on_cpu");
+		ASSERT_EQ(opts.retval, expected_retval, "check_retval");
 	}

 	/* invalid cpu ID should fail with ENXIO */
 	opts.cpu =3D 0xffffffff;
 	err =3D bpf_prog_test_run_opts(prog_fd, &opts);
-	CHECK(err >=3D 0 || errno !=3D ENXIO,
-	      "test_run_opts_fail",
-	      "should failed with ENXIO\n");
+	ASSERT_EQ(errno, ENXIO, "test_run_opts should fail with ENXIO");
+	ASSERT_ERR(err, "test_run_opts_fail");

 	/* non-zero cpu w/o BPF_F_TEST_RUN_ON_CPU should fail with EINVAL */
 	opts.cpu =3D 1;
 	opts.flags =3D 0;
 	err =3D bpf_prog_test_run_opts(prog_fd, &opts);
-	CHECK(err >=3D 0 || errno !=3D EINVAL,
-	      "test_run_opts_fail",
-	      "should failed with EINVAL\n");
+	ASSERT_EQ(errno, EINVAL, "test_run_opts should fail with EINVAL");
+	ASSERT_ERR(err, "test_run_opts_fail");

 cleanup:
 	close(comm_fd);
diff --git a/tools/testing/selftests/bpf/prog_tests/skb_ctx.c b/tools/tes=
ting/selftests/bpf/prog_tests/skb_ctx.c
index b5319ba2ee27..ce0e555b5e38 100644
--- a/tools/testing/selftests/bpf/prog_tests/skb_ctx.c
+++ b/tools/testing/selftests/bpf/prog_tests/skb_ctx.c
@@ -20,97 +20,72 @@ void test_skb_ctx(void)
 		.gso_size =3D 10,
 		.hwtstamp =3D 11,
 	};
-	struct bpf_prog_test_run_attr tattr =3D {
+	LIBBPF_OPTS(bpf_test_run_opts, tattr,
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
+	if (!ASSERT_OK(err, "load"))
 		return;

 	/* ctx_in !=3D NULL, ctx_size_in =3D=3D 0 */

 	tattr.ctx_size_in =3D 0;
-	err =3D bpf_prog_test_run_xattr(&tattr);
-	CHECK_ATTR(err =3D=3D 0, "ctx_size_in", "err %d errno %d\n", err, errno=
);
+	err =3D bpf_prog_test_run_opts(prog_fd, &tattr);
+	ASSERT_NEQ(err, 0, "ctx_size_in");
 	tattr.ctx_size_in =3D sizeof(skb);

 	/* ctx_out !=3D NULL, ctx_size_out =3D=3D 0 */

 	tattr.ctx_size_out =3D 0;
-	err =3D bpf_prog_test_run_xattr(&tattr);
-	CHECK_ATTR(err =3D=3D 0, "ctx_size_out", "err %d errno %d\n", err, errn=
o);
+	err =3D bpf_prog_test_run_opts(prog_fd, &tattr);
+	ASSERT_NEQ(err, 0, "ctx_size_out");
 	tattr.ctx_size_out =3D sizeof(skb);

 	/* non-zero [len, tc_index] fields should be rejected*/

 	skb.len =3D 1;
-	err =3D bpf_prog_test_run_xattr(&tattr);
-	CHECK_ATTR(err =3D=3D 0, "len", "err %d errno %d\n", err, errno);
+	err =3D bpf_prog_test_run_opts(prog_fd, &tattr);
+	ASSERT_NEQ(err, 0, "len");
 	skb.len =3D 0;

 	skb.tc_index =3D 1;
-	err =3D bpf_prog_test_run_xattr(&tattr);
-	CHECK_ATTR(err =3D=3D 0, "tc_index", "err %d errno %d\n", err, errno);
+	err =3D bpf_prog_test_run_opts(prog_fd, &tattr);
+	ASSERT_NEQ(err, 0, "tc_index");
 	skb.tc_index =3D 0;

 	/* non-zero [hash, sk] fields should be rejected */

 	skb.hash =3D 1;
-	err =3D bpf_prog_test_run_xattr(&tattr);
-	CHECK_ATTR(err =3D=3D 0, "hash", "err %d errno %d\n", err, errno);
+	err =3D bpf_prog_test_run_opts(prog_fd, &tattr);
+	ASSERT_NEQ(err, 0, "hash");
 	skb.hash =3D 0;

 	skb.sk =3D (struct bpf_sock *)1;
-	err =3D bpf_prog_test_run_xattr(&tattr);
-	CHECK_ATTR(err =3D=3D 0, "sk", "err %d errno %d\n", err, errno);
+	err =3D bpf_prog_test_run_opts(prog_fd, &tattr);
+	ASSERT_NEQ(err, 0, "sk");
 	skb.sk =3D 0;

-	err =3D bpf_prog_test_run_xattr(&tattr);
-	CHECK_ATTR(err !=3D 0 || tattr.retval,
-		   "run",
-		   "err %d errno %d retval %d\n",
-		   err, errno, tattr.retval);
-
-	CHECK_ATTR(tattr.ctx_size_out !=3D sizeof(skb),
-		   "ctx_size_out",
-		   "incorrect output size, want %zu have %u\n",
-		   sizeof(skb), tattr.ctx_size_out);
+	err =3D bpf_prog_test_run_opts(prog_fd, &tattr);
+	ASSERT_OK(err, "test_run");
+	ASSERT_OK(tattr.retval, "test_run retval");
+	ASSERT_EQ(tattr.ctx_size_out, sizeof(skb), "ctx_size_out");

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
-		   "skb->ingress_ifindex =3D=3D %d, expected %d\n",
-		   skb.ingress_ifindex, 11);
-	CHECK_ATTR(skb.tstamp !=3D 8,
-		   "ctx_out_tstamp",
-		   "skb->tstamp =3D=3D %lld, expected %d\n",
-		   skb.tstamp, 8);
-	CHECK_ATTR(skb.mark !=3D 10,
-		   "ctx_out_mark",
-		   "skb->mark =3D=3D %u, expected %d\n",
-		   skb.mark, 10);
+		ASSERT_EQ(skb.cb[i], i + 2, "ctx_out_cb");
+	ASSERT_EQ(skb.priority, 7, "ctx_out_priority");
+	ASSERT_EQ(skb.ifindex, 1, "ctx_out_ifindex");
+	ASSERT_EQ(skb.ingress_ifindex, 11, "ctx_out_ingress_ifindex");
+	ASSERT_EQ(skb.tstamp, 8, "ctx_out_tstamp");
+	ASSERT_EQ(skb.mark, 10, "ctx_out_mark");

 	bpf_object__close(obj);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/skb_helpers.c b/tools=
/testing/selftests/bpf/prog_tests/skb_helpers.c
index 6f802a1c0800..97dc8b14be48 100644
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
+	if (!ASSERT_OK(err, "load"))
 		return;
-	err =3D bpf_prog_test_run_xattr(&tattr);
-	CHECK_ATTR(err, "len", "err %d errno %d\n", err, errno);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
 	bpf_object__close(obj);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/too=
ls/testing/selftests/bpf/prog_tests/sockmap_basic.c
index b97a8f236b3a..cec5c0882372 100644
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
@@ -167,16 +171,10 @@ static void test_sockmap_update(enum bpf_map_type m=
ap_type)
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
+	if (!ASSERT_OK(err, "test_run"))
+		goto out;
+	if (!ASSERT_NEQ(topts.retval, 0, "test_run retval"))
 		goto out;

 	compare_cookies(skel->maps.src, dst_map);
diff --git a/tools/testing/selftests/bpf/prog_tests/syscall.c b/tools/tes=
ting/selftests/bpf/prog_tests/syscall.c
index 81e997a69f7a..f4d40001155a 100644
--- a/tools/testing/selftests/bpf/prog_tests/syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/syscall.c
@@ -20,20 +20,20 @@ void test_syscall(void)
 		.log_buf =3D (uintptr_t) verifier_log,
 		.log_size =3D sizeof(verifier_log),
 	};
-	struct bpf_prog_test_run_attr tattr =3D {
+	LIBBPF_OPTS(bpf_test_run_opts, tattr,
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
+	err =3D bpf_prog_test_run_opts(prog_fd, &tattr);
 	ASSERT_EQ(err, 0, "err");
 	ASSERT_EQ(tattr.retval, 1, "retval");
 	ASSERT_GT(ctx.map_fd, 0, "ctx.map_fd");
diff --git a/tools/testing/selftests/bpf/prog_tests/test_profiler.c b/too=
ls/testing/selftests/bpf/prog_tests/test_profiler.c
index 4ca275101ee0..de24e8f0e738 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_profiler.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_profiler.c
@@ -8,20 +8,20 @@

 static int sanity_run(struct bpf_program *prog)
 {
-	struct bpf_prog_test_run_attr test_attr =3D {};
+	LIBBPF_OPTS(bpf_test_run_opts, test_attr);
 	__u64 args[] =3D {1, 2, 3};
-	__u32 duration =3D 0;
 	int err, prog_fd;

 	prog_fd =3D bpf_program__fd(prog);
-	test_attr.prog_fd =3D prog_fd;
 	test_attr.ctx_in =3D args;
 	test_attr.ctx_size_in =3D sizeof(args);
-	err =3D bpf_prog_test_run_xattr(&test_attr);
-	if (CHECK(err || test_attr.retval, "test_run",
-		  "err %d errno %d retval %d duration %d\n",
-		  err, errno, test_attr.retval, duration))
+	err =3D bpf_prog_test_run_opts(prog_fd, &test_attr);
+	if (!ASSERT_OK(err, "test_run"))
+		return -1;
+
+	if (!ASSERT_OK(test_attr.retval, "test_run retval"))
 		return -1;
+
 	return 0;
 }

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c b/t=
ools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
index 0289d09b350f..528a8c387720 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
@@ -78,17 +78,17 @@ static void test_xdp_adjust_tail_grow2(void)
 	int tailroom =3D 320; /* SKB_DATA_ALIGN(sizeof(struct skb_shared_info))=
*/;
 	struct bpf_object *obj;
 	int err, cnt, i;
-	int max_grow;
+	int max_grow, prog_fd;

-	struct bpf_prog_test_run_attr tattr =3D {
+	LIBBPF_OPTS(bpf_test_run_opts, tattr,
 		.repeat		=3D 1,
 		.data_in	=3D &buf,
 		.data_out	=3D &buf,
 		.data_size_in	=3D 0, /* Per test */
 		.data_size_out	=3D 0, /* Per test */
-	};
+	);

-	err =3D bpf_prog_test_load(file, BPF_PROG_TYPE_XDP, &obj, &tattr.prog_f=
d);
+	err =3D bpf_prog_test_load(file, BPF_PROG_TYPE_XDP, &obj, &prog_fd);
 	if (ASSERT_OK(err, "test_xdp_adjust_tail_grow"))
 		return;

@@ -97,7 +97,7 @@ static void test_xdp_adjust_tail_grow2(void)
 	tattr.data_size_in  =3D  64; /* Determine test case via pkt size */
 	tattr.data_size_out =3D 128; /* Limit copy_size */
 	/* Kernel side alloc packet memory area that is zero init */
-	err =3D bpf_prog_test_run_xattr(&tattr);
+	err =3D bpf_prog_test_run_opts(prog_fd, &tattr);

 	ASSERT_EQ(errno, ENOSPC, "case-64 errno"); /* Due limit copy_size in bp=
f_test_finish */
 	ASSERT_EQ(tattr.retval, XDP_TX, "case-64 retval");
@@ -115,7 +115,7 @@ static void test_xdp_adjust_tail_grow2(void)
 	memset(buf, 2, sizeof(buf));
 	tattr.data_size_in  =3D 128; /* Determine test case via pkt size */
 	tattr.data_size_out =3D sizeof(buf);   /* Copy everything */
-	err =3D bpf_prog_test_run_xattr(&tattr);
+	err =3D bpf_prog_test_run_opts(prog_fd, &tattr);

 	max_grow =3D 4096 - XDP_PACKET_HEADROOM -	tailroom; /* 3520 */
 	ASSERT_OK(err, "case-128");
--
2.30.2
