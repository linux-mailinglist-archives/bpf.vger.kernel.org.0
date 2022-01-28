Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFE949F07F
	for <lists+bpf@lfdr.de>; Fri, 28 Jan 2022 02:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345031AbiA1B0H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 20:26:07 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57756 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1345028AbiA1B0H (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 27 Jan 2022 20:26:07 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 20S0n2k4007588
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 17:26:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Dl+L9M5IFcdN+El0QhlzMmpDECvdZjrDQ1HGNfbe2y0=;
 b=WiZAhOJy0xK+Q4xTQBwVhXhXW8DBIO8i5tXOWshpECErfUTa3DJsyOtmeKEp7BL0sSKh
 AsrLVlwslS+WcKcODilLx71PBFJzwPwS+4OvgqNZE1u4vjkjCb0XxhgpsWsKlsu2KYnv
 250QpoycvSSDugL9cYfP/12711br7RXIdd0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3dv695r5y1-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 17:26:06 -0800
Received: from twshared18912.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 27 Jan 2022 17:26:03 -0800
Received: by devvm3278.frc0.facebook.com (Postfix, from userid 8598)
        id 5C2011C1215DF; Thu, 27 Jan 2022 17:23:28 -0800 (PST)
From:   Delyan Kratunov <delyank@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     Delyan Kratunov <delyank@fb.com>
Subject: [PATCH bpf-next v2 1/4] selftests: bpf: migrate from bpf_prog_test_run
Date:   Thu, 27 Jan 2022 17:23:16 -0800
Message-ID: <20220128012319.2494472-2-delyank@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220128012319.2494472-1-delyank@fb.com>
References: <20220128012319.2494472-1-delyank@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 24uVPNBIFpchYR8SvyeEYeX19r5YjIfK
X-Proofpoint-GUID: 24uVPNBIFpchYR8SvyeEYeX19r5YjIfK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_06,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0
 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201280004
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 .../selftests/bpf/prog_tests/atomics.c        |  86 +++---
 .../testing/selftests/bpf/prog_tests/bpf_nf.c |  10 +-
 .../selftests/bpf/prog_tests/fentry_fexit.c   |  33 ++-
 .../selftests/bpf/prog_tests/fentry_test.c    |   9 +-
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  |  33 ++-
 .../selftests/bpf/prog_tests/fexit_stress.c   |  26 +-
 .../selftests/bpf/prog_tests/fexit_test.c     |   9 +-
 .../prog_tests/flow_dissector_load_bytes.c    |  27 +-
 .../selftests/bpf/prog_tests/for_each.c       |  32 ++-
 .../bpf/prog_tests/get_func_args_test.c       |  14 +-
 .../bpf/prog_tests/get_func_ip_test.c         |  12 +-
 .../selftests/bpf/prog_tests/global_data.c    |  25 +-
 .../bpf/prog_tests/global_func_args.c         |  13 +-
 .../selftests/bpf/prog_tests/kfunc_call.c     |  46 ++--
 .../selftests/bpf/prog_tests/ksyms_module.c   |  23 +-
 .../selftests/bpf/prog_tests/l4lb_all.c       |  35 ++-
 .../selftests/bpf/prog_tests/map_lock.c       |  15 +-
 .../selftests/bpf/prog_tests/map_ptr.c        |  18 +-
 .../selftests/bpf/prog_tests/modify_return.c  |  38 +--
 .../selftests/bpf/prog_tests/pkt_access.c     |  27 +-
 .../selftests/bpf/prog_tests/pkt_md_access.c  |  15 +-
 .../bpf/prog_tests/queue_stack_map.c          |  43 +--
 .../bpf/prog_tests/raw_tp_writable_test_run.c |  16 +-
 .../selftests/bpf/prog_tests/signal_pending.c |  24 +-
 .../selftests/bpf/prog_tests/spinlock.c       |  15 +-
 .../selftests/bpf/prog_tests/tailcalls.c      | 245 ++++++++++--------
 .../bpf/prog_tests/test_skb_pkt_end.c         |  15 +-
 .../testing/selftests/bpf/prog_tests/timer.c  |   9 +-
 .../selftests/bpf/prog_tests/timer_mim.c      |   9 +-
 .../selftests/bpf/prog_tests/trace_ext.c      |  28 +-
 tools/testing/selftests/bpf/prog_tests/xdp.c  |  35 ++-
 .../bpf/prog_tests/xdp_adjust_frags.c         |  34 ++-
 .../bpf/prog_tests/xdp_adjust_tail.c          | 114 +++++---
 .../selftests/bpf/prog_tests/xdp_bpf2bpf.c    |  16 +-
 .../selftests/bpf/prog_tests/xdp_noinline.c   |  45 ++--
 .../selftests/bpf/prog_tests/xdp_perf.c       |  19 +-
 tools/testing/selftests/bpf/test_lru_map.c    |  11 +-
 tools/testing/selftests/bpf/test_progs.h      |   2 +
 tools/testing/selftests/bpf/test_verifier.c   |  16 +-
 39 files changed, 727 insertions(+), 515 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/atomics.c b/tools/tes=
ting/selftests/bpf/prog_tests/atomics.c
index 86b7d5d84eec..12ecb3ae5c28 100644
--- a/tools/testing/selftests/bpf/prog_tests/atomics.c
+++ b/tools/testing/selftests/bpf/prog_tests/atomics.c
@@ -7,18 +7,20 @@
 static void test_add(struct atomics_lskel *skel)
 {
 	int err, prog_fd;
-	__u32 duration =3D 0, retval;
 	int link_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.repeat =3D 1,
+	);

 	link_fd =3D atomics_lskel__add__attach(skel);
 	if (!ASSERT_GT(link_fd, 0, "attach(add)"))
 		return;

 	prog_fd =3D skel->progs.add.prog_fd;
-	err =3D bpf_prog_test_run(prog_fd, 1, NULL, 0,
-				NULL, NULL, &retval, &duration);
-	if (CHECK(err || retval, "test_run add",
-		  "err %d errno %d retval %d duration %d\n", err, errno, retval, durat=
ion))
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	if (CHECK_OPTS(err || topts.retval, "test_run add",
+		       "err %d errno %d retval %d duration %d\n", err, errno,
+		       topts.retval, topts.duration))
 		goto cleanup;

 	ASSERT_EQ(skel->data->add64_value, 3, "add64_value");
@@ -39,19 +41,20 @@ static void test_add(struct atomics_lskel *skel)
 static void test_sub(struct atomics_lskel *skel)
 {
 	int err, prog_fd;
-	__u32 duration =3D 0, retval;
 	int link_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.repeat =3D 1,
+	);

 	link_fd =3D atomics_lskel__sub__attach(skel);
 	if (!ASSERT_GT(link_fd, 0, "attach(sub)"))
 		return;

 	prog_fd =3D skel->progs.sub.prog_fd;
-	err =3D bpf_prog_test_run(prog_fd, 1, NULL, 0,
-				NULL, NULL, &retval, &duration);
-	if (CHECK(err || retval, "test_run sub",
-		  "err %d errno %d retval %d duration %d\n",
-		  err, errno, retval, duration))
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	if (CHECK_OPTS(err || topts.retval, "test_run sub",
+		       "err %d errno %d retval %d duration %d\n", err, errno,
+		       topts.retval, topts.duration))
 		goto cleanup;

 	ASSERT_EQ(skel->data->sub64_value, -1, "sub64_value");
@@ -72,18 +75,20 @@ static void test_sub(struct atomics_lskel *skel)
 static void test_and(struct atomics_lskel *skel)
 {
 	int err, prog_fd;
-	__u32 duration =3D 0, retval;
 	int link_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.repeat =3D 1,
+	);

 	link_fd =3D atomics_lskel__and__attach(skel);
 	if (!ASSERT_GT(link_fd, 0, "attach(and)"))
 		return;

 	prog_fd =3D skel->progs.and.prog_fd;
-	err =3D bpf_prog_test_run(prog_fd, 1, NULL, 0,
-				NULL, NULL, &retval, &duration);
-	if (CHECK(err || retval, "test_run and",
-		  "err %d errno %d retval %d duration %d\n", err, errno, retval, durat=
ion))
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	if (CHECK_OPTS(err || topts.retval, "test_run and",
+		       "err %d errno %d retval %d duration %d\n", err, errno,
+		       topts.retval, topts.duration))
 		goto cleanup;

 	ASSERT_EQ(skel->data->and64_value, 0x010ull << 32, "and64_value");
@@ -100,19 +105,20 @@ static void test_and(struct atomics_lskel *skel)
 static void test_or(struct atomics_lskel *skel)
 {
 	int err, prog_fd;
-	__u32 duration =3D 0, retval;
 	int link_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.repeat =3D 1,
+	);

 	link_fd =3D atomics_lskel__or__attach(skel);
 	if (!ASSERT_GT(link_fd, 0, "attach(or)"))
 		return;

 	prog_fd =3D skel->progs.or.prog_fd;
-	err =3D bpf_prog_test_run(prog_fd, 1, NULL, 0,
-				NULL, NULL, &retval, &duration);
-	if (CHECK(err || retval, "test_run or",
-		  "err %d errno %d retval %d duration %d\n",
-		  err, errno, retval, duration))
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	if (CHECK_OPTS(err || topts.retval, "test_run or",
+		       "err %d errno %d retval %d duration %d\n", err, errno,
+		       topts.retval, topts.duration))
 		goto cleanup;

 	ASSERT_EQ(skel->data->or64_value, 0x111ull << 32, "or64_value");
@@ -129,18 +135,20 @@ static void test_or(struct atomics_lskel *skel)
 static void test_xor(struct atomics_lskel *skel)
 {
 	int err, prog_fd;
-	__u32 duration =3D 0, retval;
 	int link_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.repeat =3D 1,
+	);

 	link_fd =3D atomics_lskel__xor__attach(skel);
 	if (!ASSERT_GT(link_fd, 0, "attach(xor)"))
 		return;

 	prog_fd =3D skel->progs.xor.prog_fd;
-	err =3D bpf_prog_test_run(prog_fd, 1, NULL, 0,
-				NULL, NULL, &retval, &duration);
-	if (CHECK(err || retval, "test_run xor",
-		  "err %d errno %d retval %d duration %d\n", err, errno, retval, durat=
ion))
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	if (CHECK_OPTS(err || topts.retval, "test_run xor",
+		       "err %d errno %d retval %d duration %d\n", err, errno,
+		       topts.retval, topts.duration))
 		goto cleanup;

 	ASSERT_EQ(skel->data->xor64_value, 0x101ull << 32, "xor64_value");
@@ -157,18 +165,20 @@ static void test_xor(struct atomics_lskel *skel)
 static void test_cmpxchg(struct atomics_lskel *skel)
 {
 	int err, prog_fd;
-	__u32 duration =3D 0, retval;
 	int link_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.repeat =3D 1,
+	);

 	link_fd =3D atomics_lskel__cmpxchg__attach(skel);
 	if (!ASSERT_GT(link_fd, 0, "attach(cmpxchg)"))
 		return;

 	prog_fd =3D skel->progs.cmpxchg.prog_fd;
-	err =3D bpf_prog_test_run(prog_fd, 1, NULL, 0,
-				NULL, NULL, &retval, &duration);
-	if (CHECK(err || retval, "test_run cmpxchg",
-		  "err %d errno %d retval %d duration %d\n", err, errno, retval, durat=
ion))
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	if (CHECK_OPTS(err || topts.retval, "test_run cmpxchg",
+		       "err %d errno %d retval %d duration %d\n", err, errno,
+		       topts.retval, topts.duration))
 		goto cleanup;

 	ASSERT_EQ(skel->data->cmpxchg64_value, 2, "cmpxchg64_value");
@@ -186,18 +196,20 @@ static void test_cmpxchg(struct atomics_lskel *skel=
)
 static void test_xchg(struct atomics_lskel *skel)
 {
 	int err, prog_fd;
-	__u32 duration =3D 0, retval;
 	int link_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.repeat =3D 1,
+	);

 	link_fd =3D atomics_lskel__xchg__attach(skel);
 	if (!ASSERT_GT(link_fd, 0, "attach(xchg)"))
 		return;

 	prog_fd =3D skel->progs.xchg.prog_fd;
-	err =3D bpf_prog_test_run(prog_fd, 1, NULL, 0,
-				NULL, NULL, &retval, &duration);
-	if (CHECK(err || retval, "test_run xchg",
-		  "err %d errno %d retval %d duration %d\n", err, errno, retval, durat=
ion))
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	if (CHECK_OPTS(err || topts.retval, "test_run xchg",
+		       "err %d errno %d retval %d duration %d\n", err, errno,
+		       topts.retval, topts.duration))
 		goto cleanup;

 	ASSERT_EQ(skel->data->xchg64_value, 2, "xchg64_value");
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c b/tools/test=
ing/selftests/bpf/prog_tests/bpf_nf.c
index e3166a81e989..dd30b1e3a67c 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
@@ -11,7 +11,12 @@ enum {
 void test_bpf_nf_ct(int mode)
 {
 	struct test_bpf_nf *skel;
-	int prog_fd, err, retval;
+	int prog_fd, err;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.repeat =3D 1,
+	);

 	skel =3D test_bpf_nf__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "test_bpf_nf__open_and_load"))
@@ -22,8 +27,7 @@ void test_bpf_nf_ct(int mode)
 	else
 		prog_fd =3D bpf_program__fd(skel->progs.nf_skb_ct_test);

-	err =3D bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4), NULL, NU=
LL,
-				(__u32 *)&retval, NULL);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
 	if (!ASSERT_OK(err, "bpf_prog_test_run"))
 		goto end;

diff --git a/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c b/tool=
s/testing/selftests/bpf/prog_tests/fentry_fexit.c
index 4374ac8a8a91..cb0bcd9bb950 100644
--- a/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c
+++ b/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c
@@ -9,38 +9,43 @@ void test_fentry_fexit(void)
 	struct fentry_test_lskel *fentry_skel =3D NULL;
 	struct fexit_test_lskel *fexit_skel =3D NULL;
 	__u64 *fentry_res, *fexit_res;
-	__u32 duration =3D 0, retval;
 	int err, prog_fd, i;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.repeat =3D 1,
+	);

 	fentry_skel =3D fentry_test_lskel__open_and_load();
-	if (CHECK(!fentry_skel, "fentry_skel_load", "fentry skeleton failed\n")=
)
+	if (CHECK_OPTS(!fentry_skel, "fentry_skel_load",
+		       "fentry skeleton failed\n"))
 		goto close_prog;
 	fexit_skel =3D fexit_test_lskel__open_and_load();
-	if (CHECK(!fexit_skel, "fexit_skel_load", "fexit skeleton failed\n"))
+	if (CHECK_OPTS(!fexit_skel, "fexit_skel_load",
+		       "fexit skeleton failed\n"))
 		goto close_prog;

 	err =3D fentry_test_lskel__attach(fentry_skel);
-	if (CHECK(err, "fentry_attach", "fentry attach failed: %d\n", err))
+	if (CHECK_OPTS(err, "fentry_attach", "fentry attach failed: %d\n", err)=
)
 		goto close_prog;
 	err =3D fexit_test_lskel__attach(fexit_skel);
-	if (CHECK(err, "fexit_attach", "fexit attach failed: %d\n", err))
+	if (CHECK_OPTS(err, "fexit_attach", "fexit attach failed: %d\n", err))
 		goto close_prog;

 	prog_fd =3D fexit_skel->progs.test1.prog_fd;
-	err =3D bpf_prog_test_run(prog_fd, 1, NULL, 0,
-				NULL, NULL, &retval, &duration);
-	CHECK(err || retval, "ipv6",
-	      "err %d errno %d retval %d duration %d\n",
-	      err, errno, retval, duration);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	CHECK_OPTS(err || topts.retval, "ipv6",
+		   "err %d errno %d retval %d duration %d\n", err, errno,
+		   topts.retval, topts.duration);

 	fentry_res =3D (__u64 *)fentry_skel->bss;
 	fexit_res =3D (__u64 *)fexit_skel->bss;
 	printf("%lld\n", fentry_skel->bss->test1_result);
 	for (i =3D 0; i < 8; i++) {
-		CHECK(fentry_res[i] !=3D 1, "result",
-		      "fentry_test%d failed err %lld\n", i + 1, fentry_res[i]);
-		CHECK(fexit_res[i] !=3D 1, "result",
-		      "fexit_test%d failed err %lld\n", i + 1, fexit_res[i]);
+		CHECK_OPTS(fentry_res[i] !=3D 1, "result",
+			   "fentry_test%d failed err %lld\n", i + 1,
+			   fentry_res[i]);
+		CHECK_OPTS(fexit_res[i] !=3D 1, "result",
+			   "fexit_test%d failed err %lld\n", i + 1,
+			   fexit_res[i]);
 	}

 close_prog:
diff --git a/tools/testing/selftests/bpf/prog_tests/fentry_test.c b/tools=
/testing/selftests/bpf/prog_tests/fentry_test.c
index 12921b3850d2..6cbf96ef3bdd 100644
--- a/tools/testing/selftests/bpf/prog_tests/fentry_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/fentry_test.c
@@ -6,9 +6,11 @@
 static int fentry_test(struct fentry_test_lskel *fentry_skel)
 {
 	int err, prog_fd, i;
-	__u32 duration =3D 0, retval;
 	int link_fd;
 	__u64 *result;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.repeat =3D 1,
+	);

 	err =3D fentry_test_lskel__attach(fentry_skel);
 	if (!ASSERT_OK(err, "fentry_attach"))
@@ -20,10 +22,9 @@ static int fentry_test(struct fentry_test_lskel *fentr=
y_skel)
 		return -1;

 	prog_fd =3D fentry_skel->progs.test1.prog_fd;
-	err =3D bpf_prog_test_run(prog_fd, 1, NULL, 0,
-				NULL, NULL, &retval, &duration);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_OK(err, "test_run");
-	ASSERT_EQ(retval, 0, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run");

 	result =3D (__u64 *)fentry_skel->bss;
 	for (i =3D 0; i < sizeof(*fentry_skel->bss) / sizeof(__u64); i++) {
diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/too=
ls/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
index e83575e5480f..de70b9877438 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
@@ -58,12 +58,17 @@ static void test_fexit_bpf2bpf_common(const char *obj=
_file,
 				      test_cb cb)
 {
 	struct bpf_object *obj =3D NULL, *tgt_obj;
-	__u32 retval, tgt_prog_id, info_len;
+	__u32 tgt_prog_id, info_len;
 	struct bpf_prog_info prog_info =3D {};
 	struct bpf_program **prog =3D NULL, *p;
 	struct bpf_link **link =3D NULL;
 	int err, tgt_fd, i;
 	struct btf *btf;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v6,
+		.data_size_in =3D sizeof(pkt_v6),
+		.repeat =3D 1,
+	);

 	err =3D bpf_prog_test_load(target_obj_file, BPF_PROG_TYPE_UNSPEC,
 			    &tgt_obj, &tgt_fd);
@@ -147,10 +152,9 @@ static void test_fexit_bpf2bpf_common(const char *ob=
j_file,
 	if (!run_prog)
 		goto close_prog;

-	err =3D bpf_prog_test_run(tgt_fd, 1, &pkt_v6, sizeof(pkt_v6),
-				NULL, NULL, &retval, NULL);
+	err =3D bpf_prog_test_run_opts(tgt_fd, &topts);
 	ASSERT_OK(err, "prog_run");
-	ASSERT_EQ(retval, 0, "prog_run_ret");
+	ASSERT_EQ(topts.retval, 0, "prog_run_ret");

 	if (check_data_map(obj, prog_cnt, false))
 		goto close_prog;
@@ -225,29 +229,32 @@ static int test_second_attach(struct bpf_object *ob=
j)
 	const char *tgt_obj_file =3D "./test_pkt_access.o";
 	struct bpf_program *prog =3D NULL;
 	struct bpf_object *tgt_obj;
-	__u32 duration =3D 0, retval;
 	struct bpf_link *link;
 	int err =3D 0, tgt_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v6,
+		.data_size_in =3D sizeof(pkt_v6),
+		.repeat =3D 1,
+	);

 	prog =3D bpf_object__find_program_by_name(obj, prog_name);
-	if (CHECK(!prog, "find_prog", "prog %s not found\n", prog_name))
+	if (CHECK_OPTS(!prog, "find_prog", "prog %s not found\n", prog_name))
 		return -ENOENT;

 	err =3D bpf_prog_test_load(tgt_obj_file, BPF_PROG_TYPE_UNSPEC,
 			    &tgt_obj, &tgt_fd);
-	if (CHECK(err, "second_prog_load", "file %s err %d errno %d\n",
-		  tgt_obj_file, err, errno))
+	if (CHECK_OPTS(err, "second_prog_load", "file %s err %d errno %d\n",
+		       tgt_obj_file, err, errno))
 		return err;

 	link =3D bpf_program__attach_freplace(prog, tgt_fd, tgt_name);
 	if (!ASSERT_OK_PTR(link, "second_link"))
 		goto out;

-	err =3D bpf_prog_test_run(tgt_fd, 1, &pkt_v6, sizeof(pkt_v6),
-				NULL, NULL, &retval, &duration);
-	if (CHECK(err || retval, "ipv6",
-		  "err %d errno %d retval %d duration %d\n",
-		  err, errno, retval, duration))
+	err =3D bpf_prog_test_run_opts(tgt_fd, &topts);
+	if (CHECK_OPTS(err || topts.retval, "ipv6",
+		       "err %d errno %d retval %d duration %d\n", err, errno,
+		       topts.retval, topts.duration))
 		goto out;

 	err =3D check_data_map(obj, 1, true);
diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_stress.c b/tool=
s/testing/selftests/bpf/prog_tests/fexit_stress.c
index e4cede6b4b2d..e6c43321f0db 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
@@ -10,9 +10,7 @@ void test_fexit_stress(void)
 	char test_skb[128] =3D {};
 	int fexit_fd[CNT] =3D {};
 	int link_fd[CNT] =3D {};
-	__u32 duration =3D 0;
 	char error[4096];
-	__u32 prog_ret;
 	int err, i, filter_fd;

 	const struct bpf_insn trace_program[] =3D {
@@ -36,9 +34,15 @@ void test_fexit_stress(void)
 		.log_size =3D sizeof(error),
 	);

+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D test_skb,
+		.data_size_in =3D sizeof(test_skb),
+		.repeat =3D 1,
+	);
+
 	err =3D libbpf_find_vmlinux_btf_id("bpf_fentry_test1",
 					 trace_opts.expected_attach_type);
-	if (CHECK(err <=3D 0, "find_vmlinux_btf_id", "failed: %d\n", err))
+	if (CHECK_OPTS(err <=3D 0, "find_vmlinux_btf_id", "failed: %d\n", err))
 		goto out;
 	trace_opts.attach_btf_id =3D err;

@@ -47,24 +51,24 @@ void test_fexit_stress(void)
 					    trace_program,
 					    sizeof(trace_program) / sizeof(struct bpf_insn),
 					    &trace_opts);
-		if (CHECK(fexit_fd[i] < 0, "fexit loaded",
-			  "failed: %d errno %d\n", fexit_fd[i], errno))
+		if (CHECK_OPTS(fexit_fd[i] < 0, "fexit loaded",
+			       "failed: %d errno %d\n", fexit_fd[i], errno))
 			goto out;
 		link_fd[i] =3D bpf_raw_tracepoint_open(NULL, fexit_fd[i]);
-		if (CHECK(link_fd[i] < 0, "fexit attach failed",
-			  "prog %d failed: %d err %d\n", i, link_fd[i], errno))
+		if (CHECK_OPTS(link_fd[i] < 0, "fexit attach failed",
+			       "prog %d failed: %d err %d\n", i, link_fd[i],
+			       errno))
 			goto out;
 	}

 	filter_fd =3D bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL",
 				  skb_program, sizeof(skb_program) / sizeof(struct bpf_insn),
 				  &skb_opts);
-	if (CHECK(filter_fd < 0, "test_program_loaded", "failed: %d errno %d\n"=
,
-		  filter_fd, errno))
+	if (CHECK_OPTS(filter_fd < 0, "test_program_loaded",
+		       "failed: %d errno %d\n", filter_fd, errno))
 		goto out;

-	err =3D bpf_prog_test_run(filter_fd, 1, test_skb, sizeof(test_skb), 0,
-				0, &prog_ret, 0);
+	err =3D bpf_prog_test_run_opts(filter_fd, &topts);
 	close(filter_fd);
 	CHECK_FAIL(err);
 out:
diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_test.c b/tools/=
testing/selftests/bpf/prog_tests/fexit_test.c
index d4887d8bb396..641ba92aec7e 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_test.c
@@ -6,9 +6,11 @@
 static int fexit_test(struct fexit_test_lskel *fexit_skel)
 {
 	int err, prog_fd, i;
-	__u32 duration =3D 0, retval;
 	int link_fd;
 	__u64 *result;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.repeat =3D 1,
+	);

 	err =3D fexit_test_lskel__attach(fexit_skel);
 	if (!ASSERT_OK(err, "fexit_attach"))
@@ -20,10 +22,9 @@ static int fexit_test(struct fexit_test_lskel *fexit_s=
kel)
 		return -1;

 	prog_fd =3D fexit_skel->progs.test1.prog_fd;
-	err =3D bpf_prog_test_run(prog_fd, 1, NULL, 0,
-				NULL, NULL, &retval, &duration);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_OK(err, "test_run");
-	ASSERT_EQ(retval, 0, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run");

 	result =3D (__u64 *)fexit_skel->bss;
 	for (i =3D 0; i < sizeof(*fexit_skel->bss) / sizeof(__u64); i++) {
diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_b=
ytes.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes=
.c
index 93ac3f28226c..17bbd7576843 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c
@@ -5,7 +5,6 @@
 void serial_test_flow_dissector_load_bytes(void)
 {
 	struct bpf_flow_keys flow_keys;
-	__u32 duration =3D 0, retval, size;
 	struct bpf_insn prog[] =3D {
 		// BPF_REG_1 - 1st argument: context
 		// BPF_REG_2 - 2nd argument: offset, start at first byte
@@ -27,22 +26,28 @@ void serial_test_flow_dissector_load_bytes(void)
 		BPF_EXIT_INSN(),
 	};
 	int fd, err;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.data_out =3D &flow_keys,
+		.data_size_out =3D sizeof(flow_keys),
+		.repeat =3D 1,
+	);

 	/* make sure bpf_skb_load_bytes is not allowed from skb-less context
 	 */
 	fd =3D bpf_test_load_program(BPF_PROG_TYPE_FLOW_DISSECTOR, prog,
 			      ARRAY_SIZE(prog), "GPL", 0, NULL, 0);
-	CHECK(fd < 0,
-	      "flow_dissector-bpf_skb_load_bytes-load",
-	      "fd %d errno %d\n",
-	      fd, errno);
+	CHECK_OPTS(fd < 0, "flow_dissector-bpf_skb_load_bytes-load",
+		   "fd %d errno %d\n", fd, errno);

-	err =3D bpf_prog_test_run(fd, 1, &pkt_v4, sizeof(pkt_v4),
-				&flow_keys, &size, &retval, &duration);
-	CHECK(size !=3D sizeof(flow_keys) || err || retval !=3D 1,
-	      "flow_dissector-bpf_skb_load_bytes",
-	      "err %d errno %d retval %d duration %d size %u/%zu\n",
-	      err, errno, retval, duration, size, sizeof(flow_keys));
+	err =3D bpf_prog_test_run_opts(fd, &topts);
+	CHECK_OPTS(topts.data_size_out !=3D sizeof(flow_keys) || err ||
+		   topts.retval !=3D 1,
+		   "flow_dissector-bpf_skb_load_bytes",
+		   "err %d errno %d retval %d duration %d size %u/%zu\n", err,
+		   errno, topts.retval, topts.duration, topts.data_size_out,
+		   sizeof(flow_keys));

 	if (fd >=3D -1)
 		close(fd);
diff --git a/tools/testing/selftests/bpf/prog_tests/for_each.c b/tools/te=
sting/selftests/bpf/prog_tests/for_each.c
index 68eb12a287d4..044df13ee069 100644
--- a/tools/testing/selftests/bpf/prog_tests/for_each.c
+++ b/tools/testing/selftests/bpf/prog_tests/for_each.c
@@ -12,8 +12,13 @@ static void test_hash_map(void)
 	int i, err, hashmap_fd, max_entries, percpu_map_fd;
 	struct for_each_hash_map_elem *skel;
 	__u64 *percpu_valbuf =3D NULL;
-	__u32 key, num_cpus, retval;
+	__u32 key, num_cpus;
 	__u64 val;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.repeat =3D 1,
+	);

 	skel =3D for_each_hash_map_elem__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "for_each_hash_map_elem__open_and_load"))
@@ -42,11 +47,10 @@ static void test_hash_map(void)
 	if (!ASSERT_OK(err, "percpu_map_update"))
 		goto out;

-	err =3D bpf_prog_test_run(bpf_program__fd(skel->progs.test_pkt_access),
-				1, &pkt_v4, sizeof(pkt_v4), NULL, NULL,
-				&retval, &duration);
-	if (CHECK(err || retval, "ipv4", "err %d errno %d retval %d\n",
-		  err, errno, retval))
+	err =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_pkt_acc=
ess), &topts);
+	duration =3D topts.duration;
+	if (CHECK(err || topts.retval, "ipv4", "err %d errno %d retval %d\n",
+		  err, errno, topts.retval))
 		goto out;

 	ASSERT_EQ(skel->bss->hashmap_output, 4, "hashmap_output");
@@ -69,11 +73,16 @@ static void test_hash_map(void)

 static void test_array_map(void)
 {
-	__u32 key, num_cpus, max_entries, retval;
+	__u32 key, num_cpus, max_entries;
 	int i, arraymap_fd, percpu_map_fd, err;
 	struct for_each_array_map_elem *skel;
 	__u64 *percpu_valbuf =3D NULL;
 	__u64 val, expected_total;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.repeat =3D 1,
+	);

 	skel =3D for_each_array_map_elem__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "for_each_array_map_elem__open_and_load"))
@@ -106,11 +115,10 @@ static void test_array_map(void)
 	if (!ASSERT_OK(err, "percpu_map_update"))
 		goto out;

-	err =3D bpf_prog_test_run(bpf_program__fd(skel->progs.test_pkt_access),
-				1, &pkt_v4, sizeof(pkt_v4), NULL, NULL,
-				&retval, &duration);
-	if (CHECK(err || retval, "ipv4", "err %d errno %d retval %d\n",
-		  err, errno, retval))
+	err =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_pkt_acc=
ess), &topts);
+	duration =3D topts.duration;
+	if (CHECK(err || topts.retval, "ipv4", "err %d errno %d retval %d\n",
+		  err, errno, topts.retval))
 		goto out;

 	ASSERT_EQ(skel->bss->arraymap_output, expected_total, "array_output");
diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c =
b/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
index 85c427119fe9..e3e71d41fb57 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
@@ -5,8 +5,10 @@
 void test_get_func_args_test(void)
 {
 	struct get_func_args_test *skel =3D NULL;
-	__u32 duration =3D 0, retval;
 	int err, prog_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.repeat =3D 1,
+	);

 	skel =3D get_func_args_test__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "get_func_args_test__open_and_load"))
@@ -20,19 +22,17 @@ void test_get_func_args_test(void)
 	 * fentry/fexit programs.
 	 */
 	prog_fd =3D bpf_program__fd(skel->progs.test1);
-	err =3D bpf_prog_test_run(prog_fd, 1, NULL, 0,
-				NULL, NULL, &retval, &duration);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_OK(err, "test_run");
-	ASSERT_EQ(retval, 0, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run");

 	/* This runs bpf_modify_return_test function and triggers
 	 * fmod_ret_test and fexit_test programs.
 	 */
 	prog_fd =3D bpf_program__fd(skel->progs.fmod_ret_test);
-	err =3D bpf_prog_test_run(prog_fd, 1, NULL, 0,
-				NULL, NULL, &retval, &duration);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_OK(err, "test_run");
-	ASSERT_EQ(retval, 1234, "test_run");
+	ASSERT_EQ(topts.retval, 1234, "test_run");

 	ASSERT_EQ(skel->bss->test1_result, 1, "test1_result");
 	ASSERT_EQ(skel->bss->test2_result, 1, "test2_result");
diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c b/=
tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
index 02a465f36d59..fd0299a94463 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
@@ -5,8 +5,10 @@
 void test_get_func_ip_test(void)
 {
 	struct get_func_ip_test *skel =3D NULL;
-	__u32 duration =3D 0, retval;
 	int err, prog_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.repeat =3D 1,
+	);

 	skel =3D get_func_ip_test__open();
 	if (!ASSERT_OK_PTR(skel, "get_func_ip_test__open"))
@@ -29,14 +31,12 @@ void test_get_func_ip_test(void)
 		goto cleanup;

 	prog_fd =3D bpf_program__fd(skel->progs.test1);
-	err =3D bpf_prog_test_run(prog_fd, 1, NULL, 0,
-				NULL, NULL, &retval, &duration);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_OK(err, "test_run");
-	ASSERT_EQ(retval, 0, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run");

 	prog_fd =3D bpf_program__fd(skel->progs.test5);
-	err =3D bpf_prog_test_run(prog_fd, 1, NULL, 0,
-				NULL, NULL, &retval, &duration);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);

 	ASSERT_OK(err, "test_run");

diff --git a/tools/testing/selftests/bpf/prog_tests/global_data.c b/tools=
/testing/selftests/bpf/prog_tests/global_data.c
index 917165e04427..feb56c1fe73f 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_data.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_data.c
@@ -132,24 +132,27 @@ static void test_global_data_rdonly(struct bpf_obje=
ct *obj, __u32 duration)
 void test_global_data(void)
 {
 	const char *file =3D "./test_global_data.o";
-	__u32 duration =3D 0, retval;
 	struct bpf_object *obj;
 	int err, prog_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.repeat =3D 1,
+	);

 	err =3D bpf_prog_test_load(file, BPF_PROG_TYPE_SCHED_CLS, &obj, &prog_f=
d);
-	if (CHECK(err, "load program", "error %d loading %s\n", err, file))
+	if (CHECK_OPTS(err, "load program", "error %d loading %s\n", err, file)=
)
 		return;

-	err =3D bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
-				NULL, NULL, &retval, &duration);
-	CHECK(err || retval, "pass global data run",
-	      "err %d errno %d retval %d duration %d\n",
-	      err, errno, retval, duration);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	CHECK_OPTS(err || topts.retval, "pass global data run",
+		   "err %d errno %d retval %d duration %d\n", err, errno,
+		   topts.retval, topts.duration);

-	test_global_data_number(obj, duration);
-	test_global_data_string(obj, duration);
-	test_global_data_struct(obj, duration);
-	test_global_data_rdonly(obj, duration);
+	test_global_data_number(obj, topts.duration);
+	test_global_data_string(obj, topts.duration);
+	test_global_data_struct(obj, topts.duration);
+	test_global_data_rdonly(obj, topts.duration);

 	bpf_object__close(obj);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/global_func_args.c b/=
tools/testing/selftests/bpf/prog_tests/global_func_args.c
index 93a2439237b0..ee3703f3ecec 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_func_args.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_func_args.c
@@ -40,19 +40,22 @@ static void test_global_func_args0(struct bpf_object =
*obj)
 void test_global_func_args(void)
 {
 	const char *file =3D "./test_global_func_args.o";
-	__u32 retval;
 	struct bpf_object *obj;
 	int err, prog_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.repeat =3D 1,
+	);

 	err =3D bpf_prog_test_load(file, BPF_PROG_TYPE_CGROUP_SKB, &obj, &prog_=
fd);
 	if (CHECK(err, "load program", "error %d loading %s\n", err, file))
 		return;

-	err =3D bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
-				NULL, NULL, &retval, &duration);
-	CHECK(err || retval, "pass global func args run",
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	CHECK(err || topts.retval, "pass global func args run",
 	      "err %d errno %d retval %d duration %d\n",
-	      err, errno, retval, duration);
+	      err, errno, topts.retval, topts.duration);

 	test_global_func_args0(obj);

diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/tools/=
testing/selftests/bpf/prog_tests/kfunc_call.c
index b39a4f09aefd..c00eb974eb85 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
@@ -9,29 +9,31 @@
 static void test_main(void)
 {
 	struct kfunc_call_test_lskel *skel;
-	int prog_fd, retval, err;
+	int prog_fd, err;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.repeat =3D 1,
+	);

 	skel =3D kfunc_call_test_lskel__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "skel"))
 		return;

 	prog_fd =3D skel->progs.kfunc_call_test1.prog_fd;
-	err =3D bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
-				NULL, NULL, (__u32 *)&retval, NULL);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_OK(err, "bpf_prog_test_run(test1)");
-	ASSERT_EQ(retval, 12, "test1-retval");
+	ASSERT_EQ(topts.retval, 12, "test1-retval");

 	prog_fd =3D skel->progs.kfunc_call_test2.prog_fd;
-	err =3D bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
-				NULL, NULL, (__u32 *)&retval, NULL);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_OK(err, "bpf_prog_test_run(test2)");
-	ASSERT_EQ(retval, 3, "test2-retval");
+	ASSERT_EQ(topts.retval, 3, "test2-retval");

 	prog_fd =3D skel->progs.kfunc_call_test_ref_btf_id.prog_fd;
-	err =3D bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
-				NULL, NULL, (__u32 *)&retval, NULL);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_OK(err, "bpf_prog_test_run(test_ref_btf_id)");
-	ASSERT_EQ(retval, 0, "test_ref_btf_id-retval");
+	ASSERT_EQ(topts.retval, 0, "test_ref_btf_id-retval");

 	kfunc_call_test_lskel__destroy(skel);
 }
@@ -39,17 +41,21 @@ static void test_main(void)
 static void test_subprog(void)
 {
 	struct kfunc_call_test_subprog *skel;
-	int prog_fd, retval, err;
+	int prog_fd, err;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.repeat =3D 1,
+	);

 	skel =3D kfunc_call_test_subprog__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "skel"))
 		return;

 	prog_fd =3D bpf_program__fd(skel->progs.kfunc_call_test1);
-	err =3D bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
-				NULL, NULL, (__u32 *)&retval, NULL);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_OK(err, "bpf_prog_test_run(test1)");
-	ASSERT_EQ(retval, 10, "test1-retval");
+	ASSERT_EQ(topts.retval, 10, "test1-retval");
 	ASSERT_NEQ(skel->data->active_res, -1, "active_res");
 	ASSERT_EQ(skel->data->sk_state_res, BPF_TCP_CLOSE, "sk_state_res");

@@ -59,17 +65,21 @@ static void test_subprog(void)
 static void test_subprog_lskel(void)
 {
 	struct kfunc_call_test_subprog_lskel *skel;
-	int prog_fd, retval, err;
+	int prog_fd, err;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.repeat =3D 1,
+	);

 	skel =3D kfunc_call_test_subprog_lskel__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "skel"))
 		return;

 	prog_fd =3D skel->progs.kfunc_call_test1.prog_fd;
-	err =3D bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
-				NULL, NULL, (__u32 *)&retval, NULL);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_OK(err, "bpf_prog_test_run(test1)");
-	ASSERT_EQ(retval, 10, "test1-retval");
+	ASSERT_EQ(topts.retval, 10, "test1-retval");
 	ASSERT_NEQ(skel->data->active_res, -1, "active_res");
 	ASSERT_EQ(skel->data->sk_state_res, BPF_TCP_CLOSE, "sk_state_res");

diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms_module.c b/tool=
s/testing/selftests/bpf/prog_tests/ksyms_module.c
index d490ad80eccb..ecc58c9e7631 100644
--- a/tools/testing/selftests/bpf/prog_tests/ksyms_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/ksyms_module.c
@@ -9,8 +9,12 @@
 void test_ksyms_module_lskel(void)
 {
 	struct test_ksyms_module_lskel *skel;
-	int retval;
 	int err;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.repeat =3D 1,
+	);

 	if (!env.has_testmod) {
 		test__skip();
@@ -20,11 +24,10 @@ void test_ksyms_module_lskel(void)
 	skel =3D test_ksyms_module_lskel__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "test_ksyms_module_lskel__open_and_load"))
 		return;
-	err =3D bpf_prog_test_run(skel->progs.load.prog_fd, 1, &pkt_v4, sizeof(=
pkt_v4),
-				NULL, NULL, (__u32 *)&retval, NULL);
+	err =3D bpf_prog_test_run_opts(skel->progs.load.prog_fd, &topts);
 	if (!ASSERT_OK(err, "bpf_prog_test_run"))
 		goto cleanup;
-	ASSERT_EQ(retval, 0, "retval");
+	ASSERT_EQ(topts.retval, 0, "retval");
 	ASSERT_EQ(skel->bss->out_bpf_testmod_ksym, 42, "bpf_testmod_ksym");
 cleanup:
 	test_ksyms_module_lskel__destroy(skel);
@@ -33,7 +36,12 @@ void test_ksyms_module_lskel(void)
 void test_ksyms_module_libbpf(void)
 {
 	struct test_ksyms_module *skel;
-	int retval, err;
+	int err;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.repeat =3D 1,
+	);

 	if (!env.has_testmod) {
 		test__skip();
@@ -43,11 +51,10 @@ void test_ksyms_module_libbpf(void)
 	skel =3D test_ksyms_module__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "test_ksyms_module__open"))
 		return;
-	err =3D bpf_prog_test_run(bpf_program__fd(skel->progs.load), 1, &pkt_v4=
,
-				sizeof(pkt_v4), NULL, NULL, (__u32 *)&retval, NULL);
+	err =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.load), &topt=
s);
 	if (!ASSERT_OK(err, "bpf_prog_test_run"))
 		goto cleanup;
-	ASSERT_EQ(retval, 0, "retval");
+	ASSERT_EQ(topts.retval, 0, "retval");
 	ASSERT_EQ(skel->bss->out_bpf_testmod_ksym, 42, "bpf_testmod_ksym");
 cleanup:
 	test_ksyms_module__destroy(skel);
diff --git a/tools/testing/selftests/bpf/prog_tests/l4lb_all.c b/tools/te=
sting/selftests/bpf/prog_tests/l4lb_all.c
index 540ef28fabff..aef03d4a74e6 100644
--- a/tools/testing/selftests/bpf/prog_tests/l4lb_all.c
+++ b/tools/testing/selftests/bpf/prog_tests/l4lb_all.c
@@ -23,12 +23,16 @@ static void test_l4lb(const char *file)
 		__u8 flags;
 	} real_def =3D {.dst =3D MAGIC_VAL};
 	__u32 ch_key =3D 11, real_num =3D 3;
-	__u32 duration, retval, size;
 	int err, i, prog_fd, map_fd;
 	__u64 bytes =3D 0, pkts =3D 0;
 	struct bpf_object *obj;
 	char buf[128];
 	u32 *magic =3D (u32 *)buf;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_out =3D buf,
+		.data_size_out =3D sizeof(buf),
+		.repeat =3D NUM_ITER,
+	);

 	err =3D bpf_prog_test_load(file, BPF_PROG_TYPE_SCHED_CLS, &obj, &prog_f=
d);
 	if (CHECK_FAIL(err))
@@ -49,19 +53,24 @@ static void test_l4lb(const char *file)
 		goto out;
 	bpf_map_update_elem(map_fd, &real_num, &real_def, 0);

-	err =3D bpf_prog_test_run(prog_fd, NUM_ITER, &pkt_v4, sizeof(pkt_v4),
-				buf, &size, &retval, &duration);
-	CHECK(err || retval !=3D 7/*TC_ACT_REDIRECT*/ || size !=3D 54 ||
-	      *magic !=3D MAGIC_VAL, "ipv4",
-	      "err %d errno %d retval %d size %d magic %x\n",
-	      err, errno, retval, size, *magic);
+	topts.data_in =3D &pkt_v4;
+	topts.data_size_in =3D sizeof(pkt_v4);

-	err =3D bpf_prog_test_run(prog_fd, NUM_ITER, &pkt_v6, sizeof(pkt_v6),
-				buf, &size, &retval, &duration);
-	CHECK(err || retval !=3D 7/*TC_ACT_REDIRECT*/ || size !=3D 74 ||
-	      *magic !=3D MAGIC_VAL, "ipv6",
-	      "err %d errno %d retval %d size %d magic %x\n",
-	      err, errno, retval, size, *magic);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	CHECK_OPTS(err || topts.retval !=3D 7 /*TC_ACT_REDIRECT*/ ||
+		   topts.data_size_out !=3D 54 || *magic !=3D MAGIC_VAL,
+		   "ipv4", "err %d errno %d retval %d size %d magic %x\n", err,
+		   errno, topts.retval, topts.data_size_out, *magic);
+
+	topts.data_in =3D &pkt_v6;
+	topts.data_size_in =3D sizeof(pkt_v6);
+	topts.data_size_out =3D sizeof(buf); /* reset out size */
+
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	CHECK_OPTS(err || topts.retval !=3D 7 /*TC_ACT_REDIRECT*/ ||
+			   topts.data_size_out !=3D 74 || *magic !=3D MAGIC_VAL,
+		   "ipv6", "err %d errno %d retval %d size %d magic %x\n", err,
+		   errno, topts.retval, topts.data_size_out, *magic);

 	map_fd =3D bpf_find_map(__func__, obj, "stats");
 	if (map_fd < 0)
diff --git a/tools/testing/selftests/bpf/prog_tests/map_lock.c b/tools/te=
sting/selftests/bpf/prog_tests/map_lock.c
index 23d19e9cf26a..a290297905f9 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_lock.c
@@ -4,14 +4,17 @@

 static void *spin_lock_thread(void *arg)
 {
-	__u32 duration, retval;
 	int err, prog_fd =3D *(u32 *) arg;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.repeat =3D 10000,
+	);

-	err =3D bpf_prog_test_run(prog_fd, 10000, &pkt_v4, sizeof(pkt_v4),
-				NULL, NULL, &retval, &duration);
-	CHECK(err || retval, "",
-	      "err %d errno %d retval %d duration %d\n",
-	      err, errno, retval, duration);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	CHECK_OPTS(err || topts.retval, "",
+		   "err %d errno %d retval %d duration %d\n", err, errno,
+		   topts.retval, topts.duration);
 	pthread_exit(arg);
 }

diff --git a/tools/testing/selftests/bpf/prog_tests/map_ptr.c b/tools/tes=
ting/selftests/bpf/prog_tests/map_ptr.c
index 273725504f11..67c7517283da 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_ptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_ptr.c
@@ -9,10 +9,16 @@
 void test_map_ptr(void)
 {
 	struct map_ptr_kern_lskel *skel;
-	__u32 duration =3D 0, retval;
 	char buf[128];
 	int err;
 	int page_size =3D getpagesize();
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.data_out =3D buf,
+		.data_size_out =3D sizeof(buf),
+		.repeat =3D 1,
+	);

 	skel =3D map_ptr_kern_lskel__open();
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
@@ -26,14 +32,14 @@ void test_map_ptr(void)

 	skel->bss->page_size =3D page_size;

-	err =3D bpf_prog_test_run(skel->progs.cg_skb.prog_fd, 1, &pkt_v4,
-				sizeof(pkt_v4), buf, NULL, &retval, NULL);
+	err =3D bpf_prog_test_run_opts(skel->progs.cg_skb.prog_fd, &topts);

-	if (CHECK(err, "test_run", "err=3D%d errno=3D%d\n", err, errno))
+	if (CHECK_OPTS(err, "test_run", "err=3D%d errno=3D%d\n", err, errno))
 		goto cleanup;

-	if (CHECK(!retval, "retval", "retval=3D%d map_type=3D%u line=3D%u\n", r=
etval,
-		  skel->bss->g_map_type, skel->bss->g_line))
+	if (CHECK_OPTS(!topts.retval, "retval",
+		       "retval=3D%d map_type=3D%u line=3D%u\n", topts.retval,
+		       skel->bss->g_map_type, skel->bss->g_line))
 		goto cleanup;

 cleanup:
diff --git a/tools/testing/selftests/bpf/prog_tests/modify_return.c b/too=
ls/testing/selftests/bpf/prog_tests/modify_return.c
index b772fe30ce9b..55ae9da1241a 100644
--- a/tools/testing/selftests/bpf/prog_tests/modify_return.c
+++ b/tools/testing/selftests/bpf/prog_tests/modify_return.c
@@ -15,39 +15,40 @@ static void run_test(__u32 input_retval, __u16 want_s=
ide_effect, __s16 want_ret)
 {
 	struct modify_return *skel =3D NULL;
 	int err, prog_fd;
-	__u32 duration =3D 0, retval;
 	__u16 side_effect;
 	__s16 ret;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.repeat =3D 1,
+	);

 	skel =3D modify_return__open_and_load();
-	if (CHECK(!skel, "skel_load", "modify_return skeleton failed\n"))
+	if (CHECK_OPTS(!skel, "skel_load", "modify_return skeleton failed\n"))
 		goto cleanup;

 	err =3D modify_return__attach(skel);
-	if (CHECK(err, "modify_return", "attach failed: %d\n", err))
+	if (CHECK_OPTS(err, "modify_return", "attach failed: %d\n", err))
 		goto cleanup;

 	skel->bss->input_retval =3D input_retval;
 	prog_fd =3D bpf_program__fd(skel->progs.fmod_ret_test);
-	err =3D bpf_prog_test_run(prog_fd, 1, NULL, 0, NULL, 0,
-				&retval, &duration);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);

-	CHECK(err, "test_run", "err %d errno %d\n", err, errno);
+	CHECK_OPTS(err, "test_run", "err %d errno %d\n", err, errno);

-	side_effect =3D UPPER(retval);
-	ret  =3D LOWER(retval);
+	side_effect =3D UPPER(topts.retval);
+	ret =3D LOWER(topts.retval);

-	CHECK(ret !=3D want_ret, "test_run",
-	      "unexpected ret: %d, expected: %d\n", ret, want_ret);
-	CHECK(side_effect !=3D want_side_effect, "modify_return",
-	      "unexpected side_effect: %d\n", side_effect);
+	CHECK_OPTS(ret !=3D want_ret, "test_run",
+		   "unexpected ret: %d, expected: %d\n", ret, want_ret);
+	CHECK_OPTS(side_effect !=3D want_side_effect, "modify_return",
+		   "unexpected side_effect: %d\n", side_effect);

-	CHECK(skel->bss->fentry_result !=3D 1, "modify_return",
-	      "fentry failed\n");
-	CHECK(skel->bss->fexit_result !=3D 1, "modify_return",
-	      "fexit failed\n");
-	CHECK(skel->bss->fmod_ret_result !=3D 1, "modify_return",
-	      "fmod_ret failed\n");
+	CHECK_OPTS(skel->bss->fentry_result !=3D 1, "modify_return",
+		   "fentry failed\n");
+	CHECK_OPTS(skel->bss->fexit_result !=3D 1, "modify_return",
+		   "fexit failed\n");
+	CHECK_OPTS(skel->bss->fmod_ret_result !=3D 1, "modify_return",
+		   "fmod_ret failed\n");

 cleanup:
 	modify_return__destroy(skel);
@@ -63,4 +64,3 @@ void serial_test_modify_return(void)
 		 0 /* want_side_effect */,
 		 -EINVAL /* want_ret */);
 }
-
diff --git a/tools/testing/selftests/bpf/prog_tests/pkt_access.c b/tools/=
testing/selftests/bpf/prog_tests/pkt_access.c
index 6628710ec3c6..7205aeabb6c3 100644
--- a/tools/testing/selftests/bpf/prog_tests/pkt_access.c
+++ b/tools/testing/selftests/bpf/prog_tests/pkt_access.c
@@ -6,23 +6,28 @@ void test_pkt_access(void)
 {
 	const char *file =3D "./test_pkt_access.o";
 	struct bpf_object *obj;
-	__u32 duration, retval;
 	int err, prog_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.repeat =3D 100000,
+	);

 	err =3D bpf_prog_test_load(file, BPF_PROG_TYPE_SCHED_CLS, &obj, &prog_f=
d);
 	if (CHECK_FAIL(err))
 		return;

-	err =3D bpf_prog_test_run(prog_fd, 100000, &pkt_v4, sizeof(pkt_v4),
-				NULL, NULL, &retval, &duration);
-	CHECK(err || retval, "ipv4",
-	      "err %d errno %d retval %d duration %d\n",
-	      err, errno, retval, duration);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	CHECK_OPTS(err || topts.retval, "ipv4",
+		   "err %d errno %d retval %d duration %d\n", err, errno,
+		   topts.retval, topts.duration);

-	err =3D bpf_prog_test_run(prog_fd, 100000, &pkt_v6, sizeof(pkt_v6),
-				NULL, NULL, &retval, &duration);
-	CHECK(err || retval, "ipv6",
-	      "err %d errno %d retval %d duration %d\n",
-	      err, errno, retval, duration);
+	topts.data_in =3D &pkt_v6;
+	topts.data_size_in =3D sizeof(pkt_v6);
+	topts.data_size_out =3D 0; /* reset from last call */
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	CHECK_OPTS(err || topts.retval, "ipv6",
+		   "err %d errno %d retval %d duration %d\n", err, errno,
+		   topts.retval, topts.duration);
 	bpf_object__close(obj);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/pkt_md_access.c b/too=
ls/testing/selftests/bpf/prog_tests/pkt_md_access.c
index c9d2d6a1bfcc..5810a3074dfd 100644
--- a/tools/testing/selftests/bpf/prog_tests/pkt_md_access.c
+++ b/tools/testing/selftests/bpf/prog_tests/pkt_md_access.c
@@ -6,18 +6,21 @@ void test_pkt_md_access(void)
 {
 	const char *file =3D "./test_pkt_md_access.o";
 	struct bpf_object *obj;
-	__u32 duration, retval;
 	int err, prog_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.repeat =3D 10,
+	);

 	err =3D bpf_prog_test_load(file, BPF_PROG_TYPE_SCHED_CLS, &obj, &prog_f=
d);
 	if (CHECK_FAIL(err))
 		return;

-	err =3D bpf_prog_test_run(prog_fd, 10, &pkt_v4, sizeof(pkt_v4),
-				NULL, NULL, &retval, &duration);
-	CHECK(err || retval, "",
-	      "err %d errno %d retval %d duration %d\n",
-	      err, errno, retval, duration);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	CHECK_OPTS(err || topts.retval, "",
+		   "err %d errno %d retval %d duration %d\n", err, errno,
+		   topts.retval, topts.duration);

 	bpf_object__close(obj);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c b/t=
ools/testing/selftests/bpf/prog_tests/queue_stack_map.c
index b9822f914eeb..1a06e2d55a4b 100644
--- a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
@@ -10,11 +10,18 @@ enum {
 static void test_queue_stack_map_by_type(int type)
 {
 	const int MAP_SIZE =3D 32;
-	__u32 vals[MAP_SIZE], duration, retval, size, val;
+	__u32 vals[MAP_SIZE], val;
 	int i, err, prog_fd, map_in_fd, map_out_fd;
 	char file[32], buf[128];
 	struct bpf_object *obj;
 	struct iphdr iph;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.data_out =3D buf,
+		.data_size_out =3D sizeof(buf),
+		.repeat =3D 1,
+	);

 	/* Fill test values to be used */
 	for (i =3D 0; i < MAP_SIZE; i++)
@@ -58,27 +65,31 @@ static void test_queue_stack_map_by_type(int type)
 			pkt_v4.iph.saddr =3D vals[MAP_SIZE - 1 - i] * 5;
 		}

-		err =3D bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
-					buf, &size, &retval, &duration);
-		if (err || retval || size !=3D sizeof(pkt_v4))
+		topts.data_size_out =3D sizeof(buf);
+		err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+		if (err || topts.retval ||
+		    topts.data_size_out !=3D sizeof(pkt_v4))
 			break;
 		memcpy(&iph, buf + sizeof(struct ethhdr), sizeof(iph));
 		if (iph.daddr !=3D val)
 			break;
 	}

-	CHECK(err || retval || size !=3D sizeof(pkt_v4) || iph.daddr !=3D val,
-	      "bpf_map_pop_elem",
-	      "err %d errno %d retval %d size %d iph->daddr %u\n",
-	      err, errno, retval, size, iph.daddr);
+	CHECK_OPTS(err || topts.retval ||
+		   topts.data_size_out !=3D sizeof(pkt_v4) ||
+		   iph.daddr !=3D val,
+		   "bpf_map_pop_elem",
+		   "err %d errno %d retval %d size %d iph->daddr %u\n", err,
+		   errno, topts.retval, topts.data_size_out, iph.daddr);

 	/* Queue is empty, program should return TC_ACT_SHOT */
-	err =3D bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
-				buf, &size, &retval, &duration);
-	CHECK(err || retval !=3D 2 /* TC_ACT_SHOT */|| size !=3D sizeof(pkt_v4)=
,
-	      "check-queue-stack-map-empty",
-	      "err %d errno %d retval %d size %d\n",
-	      err, errno, retval, size);
+	topts.data_size_out =3D sizeof(buf);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	CHECK_OPTS(err || topts.retval !=3D 2 /* TC_ACT_SHOT */ ||
+			   topts.data_size_out !=3D sizeof(pkt_v4),
+		   "check-queue-stack-map-empty",
+		   "err %d errno %d retval %d size %d\n", err, errno,
+		   topts.retval, topts.data_size_out);

 	/* Check that the program pushed elements correctly */
 	for (i =3D 0; i < MAP_SIZE; i++) {
@@ -87,8 +98,8 @@ static void test_queue_stack_map_by_type(int type)
 			break;
 	}

-	CHECK(i !=3D MAP_SIZE && (err || val !=3D vals[i] * 5),
-	      "bpf_map_push_elem", "err %d value %u\n", err, val);
+	CHECK_OPTS(i !=3D MAP_SIZE && (err || val !=3D vals[i] * 5),
+		   "bpf_map_push_elem", "err %d value %u\n", err, val);

 out:
 	pkt_v4.iph.saddr =3D 0;
diff --git a/tools/testing/selftests/bpf/prog_tests/raw_tp_writable_test_=
run.c b/tools/testing/selftests/bpf/prog_tests/raw_tp_writable_test_run.c
index 239baccabccb..f4aa7dab4766 100644
--- a/tools/testing/selftests/bpf/prog_tests/raw_tp_writable_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/raw_tp_writable_test_run.c
@@ -56,21 +56,23 @@ void serial_test_raw_tp_writable_test_run(void)
 		0,
 	};

-	__u32 prog_ret;
-	int err =3D bpf_prog_test_run(filter_fd, 1, test_skb, sizeof(test_skb),=
 0,
-				    0, &prog_ret, 0);
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D test_skb,
+		.data_size_in =3D sizeof(test_skb),
+		.repeat =3D 1,
+	);
+	int err =3D bpf_prog_test_run_opts(filter_fd, &topts);
 	CHECK(err !=3D 42, "test_run",
 	      "tracepoint did not modify return value\n");
-	CHECK(prog_ret !=3D 0, "test_run_ret",
+	CHECK(topts.retval !=3D 0, "test_run_ret",
 	      "socket_filter did not return 0\n");

 	close(tp_fd);

-	err =3D bpf_prog_test_run(filter_fd, 1, test_skb, sizeof(test_skb), 0, =
0,
-				&prog_ret, 0);
+	err =3D bpf_prog_test_run_opts(filter_fd, &topts);
 	CHECK(err !=3D 0, "test_run_notrace",
 	      "test_run failed with %d errno %d\n", err, errno);
-	CHECK(prog_ret !=3D 0, "test_run_ret_notrace",
+	CHECK(topts.retval !=3D 0, "test_run_ret_notrace",
 	      "socket_filter did not return 0\n");

 out_filterfd:
diff --git a/tools/testing/selftests/bpf/prog_tests/signal_pending.c b/to=
ols/testing/selftests/bpf/prog_tests/signal_pending.c
index aecfe662c070..b70d88bc0380 100644
--- a/tools/testing/selftests/bpf/prog_tests/signal_pending.c
+++ b/tools/testing/selftests/bpf/prog_tests/signal_pending.c
@@ -13,10 +13,14 @@ static void test_signal_pending_by_type(enum bpf_prog=
_type prog_type)
 	struct itimerval timeo =3D {
 		.it_value.tv_usec =3D 100000, /* 100ms */
 	};
-	__u32 duration =3D 0, retval;
 	int prog_fd;
 	int err;
 	int i;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.repeat =3D 0xffffffff,
+	);

 	for (i =3D 0; i < ARRAY_SIZE(prog); i++)
 		prog[i] =3D BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0);
@@ -24,20 +28,18 @@ static void test_signal_pending_by_type(enum bpf_prog=
_type prog_type)

 	prog_fd =3D bpf_test_load_program(prog_type, prog, ARRAY_SIZE(prog),
 				   "GPL", 0, NULL, 0);
-	CHECK(prog_fd < 0, "test-run", "errno %d\n", errno);
+	CHECK_OPTS(prog_fd < 0, "test-run", "errno %d\n", errno);

 	err =3D sigaction(SIGALRM, &sigalrm_action, NULL);
-	CHECK(err, "test-run-signal-sigaction", "errno %d\n", errno);
+	CHECK_OPTS(err, "test-run-signal-sigaction", "errno %d\n", errno);

 	err =3D setitimer(ITIMER_REAL, &timeo, NULL);
-	CHECK(err, "test-run-signal-timer", "errno %d\n", errno);
-
-	err =3D bpf_prog_test_run(prog_fd, 0xffffffff, &pkt_v4, sizeof(pkt_v4),
-				NULL, NULL, &retval, &duration);
-	CHECK(duration > 500000000, /* 500ms */
-	      "test-run-signal-duration",
-	      "duration %dns > 500ms\n",
-	      duration);
+	CHECK_OPTS(err, "test-run-signal-timer", "errno %d\n", errno);
+
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	CHECK_OPTS(topts.duration > 500000000, /* 500ms */
+		   "test-run-signal-duration", "duration %dns > 500ms\n",
+		   topts.duration);

 	signal(SIGALRM, SIG_DFL);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/spinlock.c b/tools/te=
sting/selftests/bpf/prog_tests/spinlock.c
index 6307f5d2b417..c76f2bce0570 100644
--- a/tools/testing/selftests/bpf/prog_tests/spinlock.c
+++ b/tools/testing/selftests/bpf/prog_tests/spinlock.c
@@ -4,14 +4,17 @@

 static void *spin_lock_thread(void *arg)
 {
-	__u32 duration, retval;
 	int err, prog_fd =3D *(u32 *) arg;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.repeat =3D 10000,
+	);

-	err =3D bpf_prog_test_run(prog_fd, 10000, &pkt_v4, sizeof(pkt_v4),
-				NULL, NULL, &retval, &duration);
-	CHECK(err || retval, "",
-	      "err %d errno %d retval %d duration %d\n",
-	      err, errno, retval, duration);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	CHECK_OPTS(err || topts.retval, "",
+		   "err %d errno %d retval %d duration %d\n", err, errno,
+		   topts.retval, topts.duration);
 	pthread_exit(arg);
 }

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/t=
esting/selftests/bpf/prog_tests/tailcalls.c
index 796f231582f8..532515be494a 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -12,9 +12,13 @@ static void test_tailcall_1(void)
 	struct bpf_map *prog_array;
 	struct bpf_program *prog;
 	struct bpf_object *obj;
-	__u32 retval, duration;
 	char prog_name[32];
 	char buff[128] =3D {};
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D buff,
+		.data_size_in =3D sizeof(buff),
+		.repeat =3D 1,
+	);

 	err =3D bpf_prog_test_load("tailcall1.o", BPF_PROG_TYPE_SCHED_CLS, &obj=
,
 			    &prog_fd);
@@ -54,20 +58,19 @@ static void test_tailcall_1(void)
 	}

 	for (i =3D 0; i < bpf_map__max_entries(prog_array); i++) {
-		err =3D bpf_prog_test_run(main_fd, 1, buff, sizeof(buff), 0,
-					&duration, &retval, NULL);
-		CHECK(err || retval !=3D i, "tailcall",
-		      "err %d errno %d retval %d\n", err, errno, retval);
+		err =3D bpf_prog_test_run_opts(main_fd, &topts);
+		CHECK_OPTS(err || topts.retval !=3D i, "tailcall",
+			   "err %d errno %d retval %d\n", err, errno,
+			   topts.retval);

 		err =3D bpf_map_delete_elem(map_fd, &i);
 		if (CHECK_FAIL(err))
 			goto out;
 	}

-	err =3D bpf_prog_test_run(main_fd, 1, buff, sizeof(buff), 0,
-				&duration, &retval, NULL);
-	CHECK(err || retval !=3D 3, "tailcall", "err %d errno %d retval %d\n",
-	      err, errno, retval);
+	err =3D bpf_prog_test_run_opts(main_fd, &topts);
+	CHECK_OPTS(err || topts.retval !=3D 3, "tailcall",
+		   "err %d errno %d retval %d\n", err, errno, topts.retval);

 	for (i =3D 0; i < bpf_map__max_entries(prog_array); i++) {
 		snprintf(prog_name, sizeof(prog_name), "classifier_%d", i);
@@ -85,10 +88,9 @@ static void test_tailcall_1(void)
 			goto out;
 	}

-	err =3D bpf_prog_test_run(main_fd, 1, buff, sizeof(buff), 0,
-				&duration, &retval, NULL);
-	CHECK(err || retval !=3D 0, "tailcall", "err %d errno %d retval %d\n",
-	      err, errno, retval);
+	err =3D bpf_prog_test_run_opts(main_fd, &topts);
+	CHECK_OPTS(err || topts.retval !=3D 0, "tailcall",
+		   "err %d errno %d retval %d\n", err, errno, topts.retval);

 	for (i =3D 0; i < bpf_map__max_entries(prog_array); i++) {
 		j =3D bpf_map__max_entries(prog_array) - 1 - i;
@@ -110,30 +112,29 @@ static void test_tailcall_1(void)
 	for (i =3D 0; i < bpf_map__max_entries(prog_array); i++) {
 		j =3D bpf_map__max_entries(prog_array) - 1 - i;

-		err =3D bpf_prog_test_run(main_fd, 1, buff, sizeof(buff), 0,
-					&duration, &retval, NULL);
-		CHECK(err || retval !=3D j, "tailcall",
-		      "err %d errno %d retval %d\n", err, errno, retval);
+		err =3D bpf_prog_test_run_opts(main_fd, &topts);
+		CHECK_OPTS(err || topts.retval !=3D j, "tailcall",
+			   "err %d errno %d retval %d\n", err, errno,
+			   topts.retval);

 		err =3D bpf_map_delete_elem(map_fd, &i);
 		if (CHECK_FAIL(err))
 			goto out;
 	}

-	err =3D bpf_prog_test_run(main_fd, 1, buff, sizeof(buff), 0,
-				&duration, &retval, NULL);
-	CHECK(err || retval !=3D 3, "tailcall", "err %d errno %d retval %d\n",
-	      err, errno, retval);
+	err =3D bpf_prog_test_run_opts(main_fd, &topts);
+	CHECK_OPTS(err || topts.retval !=3D 3, "tailcall",
+		   "err %d errno %d retval %d\n", err, errno, topts.retval);

 	for (i =3D 0; i < bpf_map__max_entries(prog_array); i++) {
 		err =3D bpf_map_delete_elem(map_fd, &i);
 		if (CHECK_FAIL(err >=3D 0 || errno !=3D ENOENT))
 			goto out;

-		err =3D bpf_prog_test_run(main_fd, 1, buff, sizeof(buff), 0,
-					&duration, &retval, NULL);
-		CHECK(err || retval !=3D 3, "tailcall",
-		      "err %d errno %d retval %d\n", err, errno, retval);
+		err =3D bpf_prog_test_run_opts(main_fd, &topts);
+		CHECK_OPTS(err || topts.retval !=3D 3, "tailcall",
+			   "err %d errno %d retval %d\n", err, errno,
+			   topts.retval);
 	}

 out:
@@ -150,9 +151,13 @@ static void test_tailcall_2(void)
 	struct bpf_map *prog_array;
 	struct bpf_program *prog;
 	struct bpf_object *obj;
-	__u32 retval, duration;
 	char prog_name[32];
 	char buff[128] =3D {};
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D buff,
+		.data_size_in =3D sizeof(buff),
+		.repeat =3D 1,
+	);

 	err =3D bpf_prog_test_load("tailcall2.o", BPF_PROG_TYPE_SCHED_CLS, &obj=
,
 			    &prog_fd);
@@ -191,30 +196,27 @@ static void test_tailcall_2(void)
 			goto out;
 	}

-	err =3D bpf_prog_test_run(main_fd, 1, buff, sizeof(buff), 0,
-				&duration, &retval, NULL);
-	CHECK(err || retval !=3D 2, "tailcall", "err %d errno %d retval %d\n",
-	      err, errno, retval);
+	err =3D bpf_prog_test_run_opts(main_fd, &topts);
+	CHECK_OPTS(err || topts.retval !=3D 2, "tailcall",
+		   "err %d errno %d retval %d\n", err, errno, topts.retval);

 	i =3D 2;
 	err =3D bpf_map_delete_elem(map_fd, &i);
 	if (CHECK_FAIL(err))
 		goto out;

-	err =3D bpf_prog_test_run(main_fd, 1, buff, sizeof(buff), 0,
-				&duration, &retval, NULL);
-	CHECK(err || retval !=3D 1, "tailcall", "err %d errno %d retval %d\n",
-	      err, errno, retval);
+	err =3D bpf_prog_test_run_opts(main_fd, &topts);
+	CHECK_OPTS(err || topts.retval !=3D 1, "tailcall",
+		   "err %d errno %d retval %d\n", err, errno, topts.retval);

 	i =3D 0;
 	err =3D bpf_map_delete_elem(map_fd, &i);
 	if (CHECK_FAIL(err))
 		goto out;

-	err =3D bpf_prog_test_run(main_fd, 1, buff, sizeof(buff), 0,
-				&duration, &retval, NULL);
-	CHECK(err || retval !=3D 3, "tailcall", "err %d errno %d retval %d\n",
-	      err, errno, retval);
+	err =3D bpf_prog_test_run_opts(main_fd, &topts);
+	CHECK_OPTS(err || topts.retval !=3D 3, "tailcall",
+		   "err %d errno %d retval %d\n", err, errno, topts.retval);
 out:
 	bpf_object__close(obj);
 }
@@ -225,8 +227,12 @@ static void test_tailcall_count(const char *which)
 	struct bpf_map *prog_array, *data_map;
 	struct bpf_program *prog;
 	struct bpf_object *obj;
-	__u32 retval, duration;
 	char buff[128] =3D {};
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D buff,
+		.data_size_in =3D sizeof(buff),
+		.repeat =3D 1,
+	);

 	err =3D bpf_prog_test_load(which, BPF_PROG_TYPE_SCHED_CLS, &obj,
 			    &prog_fd);
@@ -262,10 +268,9 @@ static void test_tailcall_count(const char *which)
 	if (CHECK_FAIL(err))
 		goto out;

-	err =3D bpf_prog_test_run(main_fd, 1, buff, sizeof(buff), 0,
-				&duration, &retval, NULL);
-	CHECK(err || retval !=3D 1, "tailcall", "err %d errno %d retval %d\n",
-	      err, errno, retval);
+	err =3D bpf_prog_test_run_opts(main_fd, &topts);
+	CHECK_OPTS(err || topts.retval !=3D 1, "tailcall",
+		   "err %d errno %d retval %d\n", err, errno, topts.retval);

 	data_map =3D bpf_object__find_map_by_name(obj, "tailcall.bss");
 	if (CHECK_FAIL(!data_map || !bpf_map__is_internal(data_map)))
@@ -277,18 +282,17 @@ static void test_tailcall_count(const char *which)

 	i =3D 0;
 	err =3D bpf_map_lookup_elem(data_fd, &i, &val);
-	CHECK(err || val !=3D 33, "tailcall count", "err %d errno %d count %d\n=
",
-	      err, errno, val);
+	CHECK_OPTS(err || val !=3D 33, "tailcall count",
+		   "err %d errno %d count %d\n", err, errno, val);

 	i =3D 0;
 	err =3D bpf_map_delete_elem(map_fd, &i);
 	if (CHECK_FAIL(err))
 		goto out;

-	err =3D bpf_prog_test_run(main_fd, 1, buff, sizeof(buff), 0,
-				&duration, &retval, NULL);
-	CHECK(err || retval !=3D 0, "tailcall", "err %d errno %d retval %d\n",
-	      err, errno, retval);
+	err =3D bpf_prog_test_run_opts(main_fd, &topts);
+	CHECK_OPTS(err || topts.retval !=3D 0, "tailcall",
+		   "err %d errno %d retval %d\n", err, errno, topts.retval);
 out:
 	bpf_object__close(obj);
 }
@@ -319,10 +323,14 @@ static void test_tailcall_4(void)
 	struct bpf_map *prog_array, *data_map;
 	struct bpf_program *prog;
 	struct bpf_object *obj;
-	__u32 retval, duration;
 	static const int zero =3D 0;
 	char buff[128] =3D {};
 	char prog_name[32];
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D buff,
+		.data_size_in =3D sizeof(buff),
+		.repeat =3D 1,
+	);

 	err =3D bpf_prog_test_load("tailcall4.o", BPF_PROG_TYPE_SCHED_CLS, &obj=
,
 			    &prog_fd);
@@ -374,10 +382,10 @@ static void test_tailcall_4(void)
 		if (CHECK_FAIL(err))
 			goto out;

-		err =3D bpf_prog_test_run(main_fd, 1, buff, sizeof(buff), 0,
-					&duration, &retval, NULL);
-		CHECK(err || retval !=3D i, "tailcall",
-		      "err %d errno %d retval %d\n", err, errno, retval);
+		err =3D bpf_prog_test_run_opts(main_fd, &topts);
+		CHECK_OPTS(err || topts.retval !=3D i, "tailcall",
+			   "err %d errno %d retval %d\n", err, errno,
+			   topts.retval);
 	}

 	for (i =3D 0; i < bpf_map__max_entries(prog_array); i++) {
@@ -389,10 +397,10 @@ static void test_tailcall_4(void)
 		if (CHECK_FAIL(err))
 			goto out;

-		err =3D bpf_prog_test_run(main_fd, 1, buff, sizeof(buff), 0,
-					&duration, &retval, NULL);
-		CHECK(err || retval !=3D 3, "tailcall",
-		      "err %d errno %d retval %d\n", err, errno, retval);
+		err =3D bpf_prog_test_run_opts(main_fd, &topts);
+		CHECK_OPTS(err || topts.retval !=3D 3, "tailcall",
+			   "err %d errno %d retval %d\n", err, errno,
+			   topts.retval);
 	}
 out:
 	bpf_object__close(obj);
@@ -407,10 +415,14 @@ static void test_tailcall_5(void)
 	struct bpf_map *prog_array, *data_map;
 	struct bpf_program *prog;
 	struct bpf_object *obj;
-	__u32 retval, duration;
 	static const int zero =3D 0;
 	char buff[128] =3D {};
 	char prog_name[32];
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D buff,
+		.data_size_in =3D sizeof(buff),
+		.repeat =3D 1,
+	);

 	err =3D bpf_prog_test_load("tailcall5.o", BPF_PROG_TYPE_SCHED_CLS, &obj=
,
 			    &prog_fd);
@@ -462,10 +474,10 @@ static void test_tailcall_5(void)
 		if (CHECK_FAIL(err))
 			goto out;

-		err =3D bpf_prog_test_run(main_fd, 1, buff, sizeof(buff), 0,
-					&duration, &retval, NULL);
-		CHECK(err || retval !=3D i, "tailcall",
-		      "err %d errno %d retval %d\n", err, errno, retval);
+		err =3D bpf_prog_test_run_opts(main_fd, &topts);
+		CHECK_OPTS(err || topts.retval !=3D i, "tailcall",
+			   "err %d errno %d retval %d\n", err, errno,
+			   topts.retval);
 	}

 	for (i =3D 0; i < bpf_map__max_entries(prog_array); i++) {
@@ -477,10 +489,10 @@ static void test_tailcall_5(void)
 		if (CHECK_FAIL(err))
 			goto out;

-		err =3D bpf_prog_test_run(main_fd, 1, buff, sizeof(buff), 0,
-					&duration, &retval, NULL);
-		CHECK(err || retval !=3D 3, "tailcall",
-		      "err %d errno %d retval %d\n", err, errno, retval);
+		err =3D bpf_prog_test_run_opts(main_fd, &topts);
+		CHECK_OPTS(err || topts.retval !=3D 3, "tailcall",
+			   "err %d errno %d retval %d\n", err, errno,
+			   topts.retval);
 	}
 out:
 	bpf_object__close(obj);
@@ -495,8 +507,12 @@ static void test_tailcall_bpf2bpf_1(void)
 	struct bpf_map *prog_array;
 	struct bpf_program *prog;
 	struct bpf_object *obj;
-	__u32 retval, duration;
 	char prog_name[32];
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.repeat =3D 1,
+	);

 	err =3D bpf_prog_test_load("tailcall_bpf2bpf1.o", BPF_PROG_TYPE_SCHED_C=
LS,
 			    &obj, &prog_fd);
@@ -536,10 +552,9 @@ static void test_tailcall_bpf2bpf_1(void)
 			goto out;
 	}

-	err =3D bpf_prog_test_run(main_fd, 1, &pkt_v4, sizeof(pkt_v4), 0,
-				0, &retval, &duration);
-	CHECK(err || retval !=3D 1, "tailcall",
-	      "err %d errno %d retval %d\n", err, errno, retval);
+	err =3D bpf_prog_test_run_opts(main_fd, &topts);
+	CHECK_OPTS(err || topts.retval !=3D 1, "tailcall",
+		   "err %d errno %d retval %d\n", err, errno, topts.retval);

 	/* jmp -> nop, call subprog that will do tailcall */
 	i =3D 1;
@@ -547,10 +562,9 @@ static void test_tailcall_bpf2bpf_1(void)
 	if (CHECK_FAIL(err))
 		goto out;

-	err =3D bpf_prog_test_run(main_fd, 1, &pkt_v4, sizeof(pkt_v4), 0,
-				0, &retval, &duration);
-	CHECK(err || retval !=3D 0, "tailcall", "err %d errno %d retval %d\n",
-	      err, errno, retval);
+	err =3D bpf_prog_test_run_opts(main_fd, &topts);
+	CHECK_OPTS(err || topts.retval !=3D 0, "tailcall",
+		   "err %d errno %d retval %d\n", err, errno, topts.retval);

 	/* make sure that subprog can access ctx and entry prog that
 	 * called this subprog can properly return
@@ -560,11 +574,9 @@ static void test_tailcall_bpf2bpf_1(void)
 	if (CHECK_FAIL(err))
 		goto out;

-	err =3D bpf_prog_test_run(main_fd, 1, &pkt_v4, sizeof(pkt_v4), 0,
-				0, &retval, &duration);
-	CHECK(err || retval !=3D sizeof(pkt_v4) * 2,
-	      "tailcall", "err %d errno %d retval %d\n",
-	      err, errno, retval);
+	err =3D bpf_prog_test_run_opts(main_fd, &topts);
+	CHECK_OPTS(err || topts.retval !=3D sizeof(pkt_v4) * 2, "tailcall",
+		   "err %d errno %d retval %d\n", err, errno, topts.retval);
 out:
 	bpf_object__close(obj);
 }
@@ -579,8 +591,12 @@ static void test_tailcall_bpf2bpf_2(void)
 	struct bpf_map *prog_array, *data_map;
 	struct bpf_program *prog;
 	struct bpf_object *obj;
-	__u32 retval, duration;
 	char buff[128] =3D {};
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D buff,
+		.data_size_in =3D sizeof(buff),
+		.repeat =3D 1,
+	);

 	err =3D bpf_prog_test_load("tailcall_bpf2bpf2.o", BPF_PROG_TYPE_SCHED_C=
LS,
 			    &obj, &prog_fd);
@@ -616,10 +632,9 @@ static void test_tailcall_bpf2bpf_2(void)
 	if (CHECK_FAIL(err))
 		goto out;

-	err =3D bpf_prog_test_run(main_fd, 1, buff, sizeof(buff), 0,
-				&duration, &retval, NULL);
-	CHECK(err || retval !=3D 1, "tailcall", "err %d errno %d retval %d\n",
-	      err, errno, retval);
+	err =3D bpf_prog_test_run_opts(main_fd, &topts);
+	CHECK_OPTS(err || topts.retval !=3D 1, "tailcall",
+		   "err %d errno %d retval %d\n", err, errno, topts.retval);

 	data_map =3D bpf_object__find_map_by_name(obj, "tailcall.bss");
 	if (CHECK_FAIL(!data_map || !bpf_map__is_internal(data_map)))
@@ -631,18 +646,17 @@ static void test_tailcall_bpf2bpf_2(void)

 	i =3D 0;
 	err =3D bpf_map_lookup_elem(data_fd, &i, &val);
-	CHECK(err || val !=3D 33, "tailcall count", "err %d errno %d count %d\n=
",
-	      err, errno, val);
+	CHECK_OPTS(err || val !=3D 33, "tailcall count",
+		   "err %d errno %d count %d\n", err, errno, val);

 	i =3D 0;
 	err =3D bpf_map_delete_elem(map_fd, &i);
 	if (CHECK_FAIL(err))
 		goto out;

-	err =3D bpf_prog_test_run(main_fd, 1, buff, sizeof(buff), 0,
-				&duration, &retval, NULL);
-	CHECK(err || retval !=3D 0, "tailcall", "err %d errno %d retval %d\n",
-	      err, errno, retval);
+	err =3D bpf_prog_test_run_opts(main_fd, &topts);
+	CHECK_OPTS(err || topts.retval !=3D 0, "tailcall",
+		   "err %d errno %d retval %d\n", err, errno, topts.retval);
 out:
 	bpf_object__close(obj);
 }
@@ -657,8 +671,12 @@ static void test_tailcall_bpf2bpf_3(void)
 	struct bpf_map *prog_array;
 	struct bpf_program *prog;
 	struct bpf_object *obj;
-	__u32 retval, duration;
 	char prog_name[32];
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.repeat =3D 1,
+	);

 	err =3D bpf_prog_test_load("tailcall_bpf2bpf3.o", BPF_PROG_TYPE_SCHED_C=
LS,
 			    &obj, &prog_fd);
@@ -697,33 +715,27 @@ static void test_tailcall_bpf2bpf_3(void)
 			goto out;
 	}

-	err =3D bpf_prog_test_run(main_fd, 1, &pkt_v4, sizeof(pkt_v4), 0,
-				&duration, &retval, NULL);
-	CHECK(err || retval !=3D sizeof(pkt_v4) * 3,
-	      "tailcall", "err %d errno %d retval %d\n",
-	      err, errno, retval);
+	err =3D bpf_prog_test_run_opts(main_fd, &topts);
+	CHECK_OPTS(err || topts.retval !=3D sizeof(pkt_v4) * 3, "tailcall",
+		   "err %d errno %d retval %d\n", err, errno, topts.retval);

 	i =3D 1;
 	err =3D bpf_map_delete_elem(map_fd, &i);
 	if (CHECK_FAIL(err))
 		goto out;

-	err =3D bpf_prog_test_run(main_fd, 1, &pkt_v4, sizeof(pkt_v4), 0,
-				&duration, &retval, NULL);
-	CHECK(err || retval !=3D sizeof(pkt_v4),
-	      "tailcall", "err %d errno %d retval %d\n",
-	      err, errno, retval);
+	err =3D bpf_prog_test_run_opts(main_fd, &topts);
+	CHECK_OPTS(err || topts.retval !=3D sizeof(pkt_v4), "tailcall",
+		   "err %d errno %d retval %d\n", err, errno, topts.retval);

 	i =3D 0;
 	err =3D bpf_map_delete_elem(map_fd, &i);
 	if (CHECK_FAIL(err))
 		goto out;

-	err =3D bpf_prog_test_run(main_fd, 1, &pkt_v4, sizeof(pkt_v4), 0,
-				&duration, &retval, NULL);
-	CHECK(err || retval !=3D sizeof(pkt_v4) * 2,
-	      "tailcall", "err %d errno %d retval %d\n",
-	      err, errno, retval);
+	err =3D bpf_prog_test_run_opts(main_fd, &topts);
+	CHECK_OPTS(err || topts.retval !=3D sizeof(pkt_v4) * 2, "tailcall",
+		   "err %d errno %d retval %d\n", err, errno, topts.retval);
 out:
 	bpf_object__close(obj);
 }
@@ -754,8 +766,12 @@ static void test_tailcall_bpf2bpf_4(bool noise)
 	struct bpf_map *prog_array, *data_map;
 	struct bpf_program *prog;
 	struct bpf_object *obj;
-	__u32 retval, duration;
 	char prog_name[32];
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.repeat =3D 1,
+	);

 	err =3D bpf_prog_test_load("tailcall_bpf2bpf4.o", BPF_PROG_TYPE_SCHED_C=
LS,
 			    &obj, &prog_fd);
@@ -809,15 +825,14 @@ static void test_tailcall_bpf2bpf_4(bool noise)
 	if (CHECK_FAIL(err))
 		goto out;

-	err =3D bpf_prog_test_run(main_fd, 1, &pkt_v4, sizeof(pkt_v4), 0,
-				&duration, &retval, NULL);
-	CHECK(err || retval !=3D sizeof(pkt_v4) * 3, "tailcall", "err %d errno =
%d retval %d\n",
-	      err, errno, retval);
+	err =3D bpf_prog_test_run_opts(main_fd, &topts);
+	CHECK_OPTS(err || topts.retval !=3D sizeof(pkt_v4) * 3, "tailcall",
+		   "err %d errno %d retval %d\n", err, errno, topts.retval);

 	i =3D 0;
 	err =3D bpf_map_lookup_elem(data_fd, &i, &val);
-	CHECK(err || val.count !=3D 31, "tailcall count", "err %d errno %d coun=
t %d\n",
-	      err, errno, val.count);
+	CHECK_OPTS(err || val.count !=3D 31, "tailcall count",
+		   "err %d errno %d count %d\n", err, errno, val.count);

 out:
 	bpf_object__close(obj);
diff --git a/tools/testing/selftests/bpf/prog_tests/test_skb_pkt_end.c b/=
tools/testing/selftests/bpf/prog_tests/test_skb_pkt_end.c
index cf1215531920..22ea144abea3 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_skb_pkt_end.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_skb_pkt_end.c
@@ -6,15 +6,18 @@

 static int sanity_run(struct bpf_program *prog)
 {
-	__u32 duration, retval;
 	int err, prog_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.repeat =3D 1,
+	);

 	prog_fd =3D bpf_program__fd(prog);
-	err =3D bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
-				NULL, NULL, &retval, &duration);
-	if (CHECK(err || retval !=3D 123, "test_run",
-		  "err %d errno %d retval %d duration %d\n",
-		  err, errno, retval, duration))
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	if (CHECK_OPTS(err || topts.retval !=3D 123, "test_run",
+		       "err %d errno %d retval %d duration %d\n", err, errno,
+		       topts.retval, topts.duration))
 		return -1;
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testi=
ng/selftests/bpf/prog_tests/timer.c
index 0f4e49e622cd..dbed89cff2ee 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer.c
@@ -6,7 +6,9 @@
 static int timer(struct timer *timer_skel)
 {
 	int err, prog_fd;
-	__u32 duration =3D 0, retval;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.repeat =3D 1,
+	);

 	err =3D timer__attach(timer_skel);
 	if (!ASSERT_OK(err, "timer_attach"))
@@ -16,10 +18,9 @@ static int timer(struct timer *timer_skel)
 	ASSERT_EQ(timer_skel->data->callback2_check, 52, "callback2_check1");

 	prog_fd =3D bpf_program__fd(timer_skel->progs.test1);
-	err =3D bpf_prog_test_run(prog_fd, 1, NULL, 0,
-				NULL, NULL, &retval, &duration);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_OK(err, "test_run");
-	ASSERT_EQ(retval, 0, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run");
 	timer__detach(timer_skel);

 	usleep(50); /* 10 usecs should be enough, but give it extra */
diff --git a/tools/testing/selftests/bpf/prog_tests/timer_mim.c b/tools/t=
esting/selftests/bpf/prog_tests/timer_mim.c
index 949a0617869d..b5166d448172 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer_mim.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer_mim.c
@@ -6,19 +6,20 @@

 static int timer_mim(struct timer_mim *timer_skel)
 {
-	__u32 duration =3D 0, retval;
 	__u64 cnt1, cnt2;
 	int err, prog_fd, key1 =3D 1;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.repeat =3D 1,
+	);

 	err =3D timer_mim__attach(timer_skel);
 	if (!ASSERT_OK(err, "timer_attach"))
 		return err;

 	prog_fd =3D bpf_program__fd(timer_skel->progs.test1);
-	err =3D bpf_prog_test_run(prog_fd, 1, NULL, 0,
-				NULL, NULL, &retval, &duration);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_OK(err, "test_run");
-	ASSERT_EQ(retval, 0, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run");
 	timer_mim__detach(timer_skel);

 	/* check that timer_cb[12] are incrementing 'cnt' */
diff --git a/tools/testing/selftests/bpf/prog_tests/trace_ext.c b/tools/t=
esting/selftests/bpf/prog_tests/trace_ext.c
index 924441d4362d..0d36c43c59de 100644
--- a/tools/testing/selftests/bpf/prog_tests/trace_ext.c
+++ b/tools/testing/selftests/bpf/prog_tests/trace_ext.c
@@ -23,8 +23,12 @@ void test_trace_ext(void)
 	int err, pkt_fd, ext_fd;
 	struct bpf_program *prog;
 	char buf[100];
-	__u32 retval;
 	__u64 len;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.repeat =3D 1,
+	);

 	/* open/load/attach test_pkt_md_access */
 	skel_pkt =3D test_pkt_md_access__open_and_load();
@@ -77,32 +81,32 @@ void test_trace_ext(void)

 	/* load/attach tracing */
 	err =3D test_trace_ext_tracing__load(skel_trace);
-	if (CHECK(err, "setup", "tracing/test_pkt_md_access_new load failed\n")=
) {
+	if (CHECK_OPTS(err, "setup", "tracing/test_pkt_md_access_new load faile=
d\n")) {
 		libbpf_strerror(err, buf, sizeof(buf));
 		fprintf(stderr, "%s\n", buf);
 		goto cleanup;
 	}

 	err =3D test_trace_ext_tracing__attach(skel_trace);
-	if (CHECK(err, "setup", "tracing/test_pkt_md_access_new attach failed: =
%d\n", err))
+	if (CHECK_OPTS(err, "setup", "tracing/test_pkt_md_access_new attach fai=
led: %d\n", err))
 		goto cleanup;

 	/* trigger the test */
-	err =3D bpf_prog_test_run(pkt_fd, 1, &pkt_v4, sizeof(pkt_v4),
-				NULL, NULL, &retval, &duration);
-	CHECK(err || retval, "run", "err %d errno %d retval %d\n", err, errno, =
retval);
+	err =3D bpf_prog_test_run_opts(pkt_fd, &topts);
+	CHECK_OPTS(err || topts.retval, "run", "err %d errno %d retval %d\n",
+		   err, errno, topts.retval);

 	bss_ext =3D skel_ext->bss;
 	bss_trace =3D skel_trace->bss;

 	len =3D bss_ext->ext_called;

-	CHECK(bss_ext->ext_called =3D=3D 0,
-		"check", "failed to trigger freplace/test_pkt_md_access\n");
-	CHECK(bss_trace->fentry_called !=3D len,
-		"check", "failed to trigger fentry/test_pkt_md_access_new\n");
-	CHECK(bss_trace->fexit_called !=3D len,
-		"check", "failed to trigger fexit/test_pkt_md_access_new\n");
+	CHECK_OPTS(bss_ext->ext_called =3D=3D 0, "check",
+		   "failed to trigger freplace/test_pkt_md_access\n");
+	CHECK_OPTS(bss_trace->fentry_called !=3D len, "check",
+		   "failed to trigger fentry/test_pkt_md_access_new\n");
+	CHECK_OPTS(bss_trace->fexit_called !=3D len, "check",
+		   "failed to trigger fexit/test_pkt_md_access_new\n");

 cleanup:
 	test_trace_ext_tracing__destroy(skel_trace);
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp.c b/tools/testing=
/selftests/bpf/prog_tests/xdp.c
index ac65456b7ab8..2499b6b6ab28 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp.c
@@ -13,8 +13,14 @@ void test_xdp(void)
 	char buf[128];
 	struct ipv6hdr iph6;
 	struct iphdr iph;
-	__u32 duration, retval, size;
 	int err, prog_fd, map_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.data_out =3D buf,
+		.data_size_out =3D sizeof(buf),
+		.repeat =3D 1,
+	);

 	err =3D bpf_prog_test_load(file, BPF_PROG_TYPE_XDP, &obj, &prog_fd);
 	if (CHECK_FAIL(err))
@@ -26,21 +32,24 @@ void test_xdp(void)
 	bpf_map_update_elem(map_fd, &key4, &value4, 0);
 	bpf_map_update_elem(map_fd, &key6, &value6, 0);

-	err =3D bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
-				buf, &size, &retval, &duration);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
 	memcpy(&iph, buf + sizeof(struct ethhdr), sizeof(iph));
-	CHECK(err || retval !=3D XDP_TX || size !=3D 74 ||
-	      iph.protocol !=3D IPPROTO_IPIP, "ipv4",
-	      "err %d errno %d retval %d size %d\n",
-	      err, errno, retval, size);
+	CHECK_OPTS(err || topts.retval !=3D XDP_TX || topts.data_size_out !=3D =
74 ||
+		   iph.protocol !=3D IPPROTO_IPIP,
+		   "ipv4", "err %d errno %d retval %d size %d\n", err, errno,
+		   topts.retval, topts.data_size_out);

-	err =3D bpf_prog_test_run(prog_fd, 1, &pkt_v6, sizeof(pkt_v6),
-				buf, &size, &retval, &duration);
+	topts.data_in =3D &pkt_v6;
+	topts.data_size_in =3D sizeof(pkt_v6);
+	topts.data_size_out =3D sizeof(buf);
+
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
 	memcpy(&iph6, buf + sizeof(struct ethhdr), sizeof(iph6));
-	CHECK(err || retval !=3D XDP_TX || size !=3D 114 ||
-	      iph6.nexthdr !=3D IPPROTO_IPV6, "ipv6",
-	      "err %d errno %d retval %d size %d\n",
-	      err, errno, retval, size);
+	CHECK_OPTS(err || topts.retval !=3D XDP_TX ||
+		   topts.data_size_out !=3D 114 ||
+		   iph6.nexthdr !=3D IPPROTO_IPV6,
+		   "ipv6", "err %d errno %d retval %d size %d\n", err, errno,
+		   topts.retval, topts.data_size_out);
 out:
 	bpf_object__close(obj);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c b/=
tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
index 31c188666e81..80be24f50982 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
@@ -5,12 +5,14 @@
 void test_xdp_update_frags(void)
 {
 	const char *file =3D "./test_xdp_update_frags.o";
-	__u32 duration, retval, size;
 	struct bpf_program *prog;
 	struct bpf_object *obj;
 	int err, prog_fd;
 	__u32 *offset;
 	__u8 *buf;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.repeat =3D 1,
+	);

 	obj =3D bpf_object__open(file);
 	if (libbpf_get_error(obj))
@@ -32,12 +34,16 @@ void test_xdp_update_frags(void)
 	buf[*offset] =3D 0xaa;		/* marker at offset 16 (head) */
 	buf[*offset + 15] =3D 0xaa;	/* marker at offset 31 (head) */

-	err =3D bpf_prog_test_run(prog_fd, 1, buf, 128,
-				buf, &size, &retval, &duration);
+	topts.data_in =3D buf;
+	topts.data_out =3D buf;
+	topts.data_size_in =3D 128;
+	topts.data_size_out =3D 128;
+
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);

 	/* test_xdp_update_frags: buf[16,31]: 0xaa -> 0xbb */
 	ASSERT_OK(err, "xdp_update_frag");
-	ASSERT_EQ(retval, XDP_PASS, "xdp_update_frag retval");
+	ASSERT_EQ(topts.retval, XDP_PASS, "xdp_update_frag retval");
 	ASSERT_EQ(buf[16], 0xbb, "xdp_update_frag buf[16]");
 	ASSERT_EQ(buf[31], 0xbb, "xdp_update_frag buf[31]");

@@ -53,12 +59,16 @@ void test_xdp_update_frags(void)
 	buf[*offset] =3D 0xaa;		/* marker at offset 5000 (frag0) */
 	buf[*offset + 15] =3D 0xaa;	/* marker at offset 5015 (frag0) */

-	err =3D bpf_prog_test_run(prog_fd, 1, buf, 9000,
-				buf, &size, &retval, &duration);
+	topts.data_in =3D buf;
+	topts.data_out =3D buf;
+	topts.data_size_in =3D 9000;
+	topts.data_size_out =3D 9000;
+
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);

 	/* test_xdp_update_frags: buf[5000,5015]: 0xaa -> 0xbb */
 	ASSERT_OK(err, "xdp_update_frag");
-	ASSERT_EQ(retval, XDP_PASS, "xdp_update_frag retval");
+	ASSERT_EQ(topts.retval, XDP_PASS, "xdp_update_frag retval");
 	ASSERT_EQ(buf[5000], 0xbb, "xdp_update_frag buf[5000]");
 	ASSERT_EQ(buf[5015], 0xbb, "xdp_update_frag buf[5015]");

@@ -68,12 +78,11 @@ void test_xdp_update_frags(void)
 	buf[*offset] =3D 0xaa;		/* marker at offset 3510 (head) */
 	buf[*offset + 15] =3D 0xaa;	/* marker at offset 3525 (frag0) */

-	err =3D bpf_prog_test_run(prog_fd, 1, buf, 9000,
-				buf, &size, &retval, &duration);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);

 	/* test_xdp_update_frags: buf[3510,3525]: 0xaa -> 0xbb */
 	ASSERT_OK(err, "xdp_update_frag");
-	ASSERT_EQ(retval, XDP_PASS, "xdp_update_frag retval");
+	ASSERT_EQ(topts.retval, XDP_PASS, "xdp_update_frag retval");
 	ASSERT_EQ(buf[3510], 0xbb, "xdp_update_frag buf[3510]");
 	ASSERT_EQ(buf[3525], 0xbb, "xdp_update_frag buf[3525]");

@@ -83,12 +92,11 @@ void test_xdp_update_frags(void)
 	buf[*offset] =3D 0xaa;		/* marker at offset 7606 (frag0) */
 	buf[*offset + 15] =3D 0xaa;	/* marker at offset 7621 (frag1) */

-	err =3D bpf_prog_test_run(prog_fd, 1, buf, 9000,
-				buf, &size, &retval, &duration);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);

 	/* test_xdp_update_frags: buf[7606,7621]: 0xaa -> 0xbb */
 	ASSERT_OK(err, "xdp_update_frag");
-	ASSERT_EQ(retval, XDP_PASS, "xdp_update_frag retval");
+	ASSERT_EQ(topts.retval, XDP_PASS, "xdp_update_frag retval");
 	ASSERT_EQ(buf[7606], 0xbb, "xdp_update_frag buf[7606]");
 	ASSERT_EQ(buf[7621], 0xbb, "xdp_update_frag buf[7621]");

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c b/t=
ools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
index ccc9e63254a8..bb1b833318d3 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
@@ -5,26 +5,34 @@
 static void test_xdp_adjust_tail_shrink(void)
 {
 	const char *file =3D "./test_xdp_adjust_tail_shrink.o";
-	__u32 duration, retval, size, expect_sz;
+	__u32 expect_sz;
 	struct bpf_object *obj;
 	int err, prog_fd;
 	char buf[128];
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.data_out =3D buf,
+		.data_size_out =3D sizeof(buf),
+		.repeat =3D 1,
+	);

 	err =3D bpf_prog_test_load(file, BPF_PROG_TYPE_XDP, &obj, &prog_fd);
 	if (ASSERT_OK(err, "test_xdp_adjust_tail_shrink"))
 		return;

-	err =3D bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
-				buf, &size, &retval, &duration);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_OK(err, "ipv4");
-	ASSERT_EQ(retval, XDP_DROP, "ipv4 retval");
+	ASSERT_EQ(topts.retval, XDP_DROP, "ipv4 retval");

 	expect_sz =3D sizeof(pkt_v6) - 20;  /* Test shrink with 20 bytes */
-	err =3D bpf_prog_test_run(prog_fd, 1, &pkt_v6, sizeof(pkt_v6),
-				buf, &size, &retval, &duration);
+	topts.data_in =3D &pkt_v6;
+	topts.data_size_in =3D sizeof(pkt_v6);
+	topts.data_size_out =3D sizeof(buf);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_OK(err, "ipv6");
-	ASSERT_EQ(retval, XDP_TX, "ipv6 retval");
-	ASSERT_EQ(size, expect_sz, "ipv6 size");
+	ASSERT_EQ(topts.retval, XDP_TX, "ipv6 retval");
+	ASSERT_EQ(topts.data_size_out, expect_sz, "ipv6 size");

 	bpf_object__close(obj);
 }
@@ -34,24 +42,31 @@ static void test_xdp_adjust_tail_grow(void)
 	const char *file =3D "./test_xdp_adjust_tail_grow.o";
 	struct bpf_object *obj;
 	char buf[4096]; /* avoid segfault: large buf to hold grow results */
-	__u32 duration, retval, size, expect_sz;
+	__u32 expect_sz;
 	int err, prog_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.data_out =3D buf,
+		.data_size_out =3D sizeof(buf),
+		.repeat =3D 1,
+	);

 	err =3D bpf_prog_test_load(file, BPF_PROG_TYPE_XDP, &obj, &prog_fd);
 	if (ASSERT_OK(err, "test_xdp_adjust_tail_grow"))
 		return;

-	err =3D bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
-				buf, &size, &retval, &duration);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_OK(err, "ipv4");
-	ASSERT_EQ(retval, XDP_DROP, "ipv4 retval");
+	ASSERT_EQ(topts.retval, XDP_DROP, "ipv4 retval");

 	expect_sz =3D sizeof(pkt_v6) + 40; /* Test grow with 40 bytes */
-	err =3D bpf_prog_test_run(prog_fd, 1, &pkt_v6, sizeof(pkt_v6) /* 74 */,
-				buf, &size, &retval, &duration);
+	topts.data_in =3D &pkt_v6;
+	topts.data_size_in =3D sizeof(pkt_v6);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_OK(err, "ipv6");
-	ASSERT_EQ(retval, XDP_TX, "ipv6 retval");
-	ASSERT_EQ(size, expect_sz, "ipv6 size");
+	ASSERT_EQ(topts.retval, XDP_TX, "ipv6 retval");
+	ASSERT_EQ(topts.data_size_out, expect_sz, "ipv6 size");

 	bpf_object__close(obj);
 }
@@ -121,11 +136,14 @@ static void test_xdp_adjust_tail_grow2(void)
 void test_xdp_adjust_frags_tail_shrink(void)
 {
 	const char *file =3D "./test_xdp_adjust_tail_shrink.o";
-	__u32 duration, retval, size, exp_size;
+	__u32 exp_size;
 	struct bpf_program *prog;
 	struct bpf_object *obj;
 	int err, prog_fd;
 	__u8 *buf;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.repeat =3D 1,
+	);

 	/* For the individual test cases, the first byte in the packet
 	 * indicates which test will be run.
@@ -148,32 +166,36 @@ void test_xdp_adjust_frags_tail_shrink(void)

 	/* Test case removing 10 bytes from last frag, NOT freeing it */
 	exp_size =3D 8990; /* 9000 - 10 */
-	err =3D bpf_prog_test_run(prog_fd, 1, buf, 9000,
-				buf, &size, &retval, &duration);
+	topts.data_in =3D buf;
+	topts.data_out =3D buf;
+	topts.data_size_in =3D 9000;
+	topts.data_size_out =3D 9000;
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);

 	ASSERT_OK(err, "9Kb-10b");
-	ASSERT_EQ(retval, XDP_TX, "9Kb-10b retval");
-	ASSERT_EQ(size, exp_size, "9Kb-10b size");
+	ASSERT_EQ(topts.retval, XDP_TX, "9Kb-10b retval");
+	ASSERT_EQ(topts.data_size_out, exp_size, "9Kb-10b size");

 	/* Test case removing one of two pages, assuming 4K pages */
 	buf[0] =3D 1;
 	exp_size =3D 4900; /* 9000 - 4100 */
-	err =3D bpf_prog_test_run(prog_fd, 1, buf, 9000,
-				buf, &size, &retval, &duration);
+
+	topts.data_size_out =3D 9000; /* reset from previous invocation */
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);

 	ASSERT_OK(err, "9Kb-4Kb");
-	ASSERT_EQ(retval, XDP_TX, "9Kb-4Kb retval");
-	ASSERT_EQ(size, exp_size, "9Kb-4Kb size");
+	ASSERT_EQ(topts.retval, XDP_TX, "9Kb-4Kb retval");
+	ASSERT_EQ(topts.data_size_out, exp_size, "9Kb-4Kb size");

 	/* Test case removing two pages resulting in a linear xdp_buff */
 	buf[0] =3D 2;
 	exp_size =3D 800; /* 9000 - 8200 */
-	err =3D bpf_prog_test_run(prog_fd, 1, buf, 9000,
-				buf, &size, &retval, &duration);
+	topts.data_size_out =3D 9000; /* reset from previous invocation */
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);

 	ASSERT_OK(err, "9Kb-9Kb");
-	ASSERT_EQ(retval, XDP_TX, "9Kb-9Kb retval");
-	ASSERT_EQ(size, exp_size, "9Kb-9Kb size");
+	ASSERT_EQ(topts.retval, XDP_TX, "9Kb-9Kb retval");
+	ASSERT_EQ(topts.data_size_out, exp_size, "9Kb-9Kb size");

 	free(buf);
 out:
@@ -183,11 +205,14 @@ void test_xdp_adjust_frags_tail_shrink(void)
 void test_xdp_adjust_frags_tail_grow(void)
 {
 	const char *file =3D "./test_xdp_adjust_tail_grow.o";
-	__u32 duration, retval, size, exp_size;
+	__u32 exp_size;
 	struct bpf_program *prog;
 	struct bpf_object *obj;
 	int err, i, prog_fd;
 	__u8 *buf;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.repeat =3D 1,
+	);

 	obj =3D bpf_object__open(file);
 	if (libbpf_get_error(obj))
@@ -205,14 +230,17 @@ void test_xdp_adjust_frags_tail_grow(void)

 	/* Test case add 10 bytes to last frag */
 	memset(buf, 1, 16384);
-	size =3D 9000;
-	exp_size =3D size + 10;
-	err =3D bpf_prog_test_run(prog_fd, 1, buf, size,
-				buf, &size, &retval, &duration);
+	exp_size =3D 9000 + 10;
+
+	topts.data_in =3D buf;
+	topts.data_out =3D buf;
+	topts.data_size_in =3D 9000;
+	topts.data_size_out =3D 16384;
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);

 	ASSERT_OK(err, "9Kb+10b");
-	ASSERT_EQ(retval, XDP_TX, "9Kb+10b retval");
-	ASSERT_EQ(size, exp_size, "9Kb+10b size");
+	ASSERT_EQ(topts.retval, XDP_TX, "9Kb+10b retval");
+	ASSERT_EQ(topts.data_size_out, exp_size, "9Kb+10b size");

 	for (i =3D 0; i < 9000; i++)
 		ASSERT_EQ(buf[i], 1, "9Kb+10b-old");
@@ -225,14 +253,16 @@ void test_xdp_adjust_frags_tail_grow(void)

 	/* Test a too large grow */
 	memset(buf, 1, 16384);
-	size =3D 9001;
-	exp_size =3D size;
-	err =3D bpf_prog_test_run(prog_fd, 1, buf, size,
-				buf, &size, &retval, &duration);
+	exp_size =3D 9001;
+
+	topts.data_in =3D topts.data_out =3D buf;
+	topts.data_size_in =3D 9001;
+	topts.data_size_out =3D 16384;
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);

 	ASSERT_OK(err, "9Kb+10b");
-	ASSERT_EQ(retval, XDP_DROP, "9Kb+10b retval");
-	ASSERT_EQ(size, exp_size, "9Kb+10b size");
+	ASSERT_EQ(topts.retval, XDP_DROP, "9Kb+10b retval");
+	ASSERT_EQ(topts.data_size_out, exp_size, "9Kb+10b size");

 	free(buf);
 out:
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c b/tools=
/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c
index 9c395ea680c6..836cbdafa527 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c
@@ -45,9 +45,11 @@ static void run_xdp_bpf2bpf_pkt_size(int pkt_fd, struc=
t perf_buffer *pb,
 				     struct test_xdp_bpf2bpf *ftrace_skel,
 				     int pkt_size)
 {
-	__u32 duration =3D 0, retval, size;
 	__u8 *buf, *buf_in;
 	int err;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.repeat =3D 1,
+	);

 	if (!ASSERT_LE(pkt_size, BUF_SZ, "pkt_size") ||
 	    !ASSERT_GE(pkt_size, sizeof(pkt_v4), "pkt_size"))
@@ -73,12 +75,16 @@ static void run_xdp_bpf2bpf_pkt_size(int pkt_fd, stru=
ct perf_buffer *pb,
 	}

 	/* Run test program */
-	err =3D bpf_prog_test_run(pkt_fd, 1, buf_in, pkt_size,
-				buf, &size, &retval, &duration);
+	topts.data_in =3D buf_in;
+	topts.data_size_in =3D pkt_size;
+	topts.data_out =3D buf;
+	topts.data_size_out =3D BUF_SZ;
+
+	err =3D bpf_prog_test_run_opts(pkt_fd, &topts);

 	ASSERT_OK(err, "ipv4");
-	ASSERT_EQ(retval, XDP_PASS, "ipv4 retval");
-	ASSERT_EQ(size, pkt_size, "ipv4 size");
+	ASSERT_EQ(topts.retval, XDP_PASS, "ipv4 retval");
+	ASSERT_EQ(topts.data_size_out, pkt_size, "ipv4 size");

 	/* Make sure bpf_xdp_output() was triggered and it sent the expected
 	 * data to the perf ring buffer.
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_noinline.c b/tool=
s/testing/selftests/bpf/prog_tests/xdp_noinline.c
index 0281095de266..ec1d6e68bdbc 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_noinline.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_noinline.c
@@ -25,43 +25,50 @@ void test_xdp_noinline(void)
 		__u8 flags;
 	} real_def =3D {.dst =3D MAGIC_VAL};
 	__u32 ch_key =3D 11, real_num =3D 3;
-	__u32 duration =3D 0, retval, size;
 	int err, i;
 	__u64 bytes =3D 0, pkts =3D 0;
 	char buf[128];
 	u32 *magic =3D (u32 *)buf;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.data_out =3D buf,
+		.data_size_out =3D sizeof(buf),
+		.repeat =3D NUM_ITER,
+	);

 	skel =3D test_xdp_noinline__open_and_load();
-	if (CHECK(!skel, "skel_open_and_load", "failed\n"))
+	if (CHECK_OPTS(!skel, "skel_open_and_load", "failed\n"))
 		return;

 	bpf_map_update_elem(bpf_map__fd(skel->maps.vip_map), &key, &value, 0);
 	bpf_map_update_elem(bpf_map__fd(skel->maps.ch_rings), &ch_key, &real_nu=
m, 0);
 	bpf_map_update_elem(bpf_map__fd(skel->maps.reals), &real_num, &real_def=
, 0);

-	err =3D bpf_prog_test_run(bpf_program__fd(skel->progs.balancer_ingress_=
v4),
-				NUM_ITER, &pkt_v4, sizeof(pkt_v4),
-				buf, &size, &retval, &duration);
-	CHECK(err || retval !=3D 1 || size !=3D 54 ||
-	      *magic !=3D MAGIC_VAL, "ipv4",
-	      "err %d errno %d retval %d size %d magic %x\n",
-	      err, errno, retval, size, *magic);
+	err =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.balancer_ing=
ress_v4), &topts);
+	CHECK_OPTS(err || topts.retval !=3D 1 || topts.data_size_out !=3D 54 ||
+		   *magic !=3D MAGIC_VAL,
+		   "ipv4", "err %d errno %d retval %d size %d magic %x\n", err,
+		   errno, topts.retval, topts.data_size_out, *magic);

-	err =3D bpf_prog_test_run(bpf_program__fd(skel->progs.balancer_ingress_=
v6),
-				NUM_ITER, &pkt_v6, sizeof(pkt_v6),
-				buf, &size, &retval, &duration);
-	CHECK(err || retval !=3D 1 || size !=3D 74 ||
-	      *magic !=3D MAGIC_VAL, "ipv6",
-	      "err %d errno %d retval %d size %d magic %x\n",
-	      err, errno, retval, size, *magic);
+	topts.data_in =3D &pkt_v6;
+	topts.data_size_in =3D sizeof(pkt_v6);
+	topts.data_out =3D buf;
+	topts.data_size_out =3D sizeof(buf);
+
+	err =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.balancer_ing=
ress_v6), &topts);
+	CHECK_OPTS(err || topts.retval !=3D 1 || topts.data_size_out !=3D 74 ||
+		   *magic !=3D MAGIC_VAL,
+		   "ipv6", "err %d errno %d retval %d size %d magic %x\n", err,
+		   errno, topts.retval, topts.data_size_out, *magic);

 	bpf_map_lookup_elem(bpf_map__fd(skel->maps.stats), &stats_key, stats);
 	for (i =3D 0; i < nr_cpus; i++) {
 		bytes +=3D stats[i].bytes;
 		pkts +=3D stats[i].pkts;
 	}
-	CHECK(bytes !=3D MAGIC_BYTES * NUM_ITER * 2 || pkts !=3D NUM_ITER * 2,
-	      "stats", "bytes %lld pkts %lld\n",
-	      (unsigned long long)bytes, (unsigned long long)pkts);
+	CHECK_OPTS(bytes !=3D MAGIC_BYTES * NUM_ITER * 2 || pkts !=3D NUM_ITER =
* 2,
+		   "stats", "bytes %lld pkts %lld\n", (unsigned long long)bytes,
+		   (unsigned long long)pkts);
 	test_xdp_noinline__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_perf.c b/tools/te=
sting/selftests/bpf/prog_tests/xdp_perf.c
index 15a3900e4370..d46ebbda7b49 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_perf.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_perf.c
@@ -4,22 +4,27 @@
 void test_xdp_perf(void)
 {
 	const char *file =3D "./xdp_dummy.o";
-	__u32 duration, retval, size;
 	struct bpf_object *obj;
 	char in[128], out[128];
 	int err, prog_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D in,
+		.data_size_in =3D sizeof(in),
+		.data_out =3D out,
+		.data_size_out =3D sizeof(out),
+		.repeat =3D 1000000,
+	);

 	err =3D bpf_prog_test_load(file, BPF_PROG_TYPE_XDP, &obj, &prog_fd);
 	if (CHECK_FAIL(err))
 		return;

-	err =3D bpf_prog_test_run(prog_fd, 1000000, &in[0], 128,
-				out, &size, &retval, &duration);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);

-	CHECK(err || retval !=3D XDP_PASS || size !=3D 128,
-	      "xdp-perf",
-	      "err %d errno %d retval %d size %d\n",
-	      err, errno, retval, size);
+	CHECK_OPTS(err || topts.retval !=3D XDP_PASS ||
+		   topts.data_size_out !=3D 128,
+		   "xdp-perf", "err %d errno %d retval %d size %d\n", err,
+		   errno, topts.retval, topts.data_size_out);

 	bpf_object__close(obj);
 }
diff --git a/tools/testing/selftests/bpf/test_lru_map.c b/tools/testing/s=
elftests/bpf/test_lru_map.c
index b9f1bbbc8aba..6e6235185a86 100644
--- a/tools/testing/selftests/bpf/test_lru_map.c
+++ b/tools/testing/selftests/bpf/test_lru_map.c
@@ -61,7 +61,11 @@ static int bpf_map_lookup_elem_with_ref_bit(int fd, un=
signed long long key,
 	};
 	__u8 data[64] =3D {};
 	int mfd, pfd, ret, zero =3D 0;
-	__u32 retval =3D 0;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D data,
+		.data_size_in =3D sizeof(data),
+		.repeat =3D 1,
+	);

 	mfd =3D bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, sizeof(int), sizeof(__=
u64), 1, NULL);
 	if (mfd < 0)
@@ -75,9 +79,8 @@ static int bpf_map_lookup_elem_with_ref_bit(int fd, uns=
igned long long key,
 		return -1;
 	}

-	ret =3D bpf_prog_test_run(pfd, 1, data, sizeof(data),
-				NULL, NULL, &retval, NULL);
-	if (ret < 0 || retval !=3D 42) {
+	ret =3D bpf_prog_test_run_opts(pfd, &topts);
+	if (ret < 0 || topts.retval !=3D 42) {
 		ret =3D -1;
 	} else {
 		assert(!bpf_map_lookup_elem(mfd, &zero, value));
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/sel=
ftests/bpf/test_progs.h
index 93c1ff705533..1afd90965afe 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -163,6 +163,8 @@ extern int test__join_cgroup(const char *path);
 	_CHECK(condition, tag, duration, format)
 #define CHECK_ATTR(condition, tag, format...) \
 	_CHECK(condition, tag, tattr.duration, format)
+#define CHECK_OPTS(condition, tag, format...) \
+	_CHECK(condition, tag, topts.duration, format)

 #define ASSERT_TRUE(actual, name) ({					\
 	static int duration =3D 0;					\
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/=
selftests/bpf/test_verifier.c
index 29bbaa58233c..163b303e8a2a 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -1021,13 +1021,18 @@ static int do_prog_test_run(int fd_prog, bool unp=
riv, uint32_t expected_val,
 {
 	__u8 tmp[TEST_DATA_LEN << 2];
 	__u32 size_tmp =3D sizeof(tmp);
-	uint32_t retval;
 	int err, saved_errno;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D data,
+		.data_size_in =3D size_data,
+		.data_out =3D tmp,
+		.data_size_out =3D size_tmp,
+		.repeat =3D 1,
+	);

 	if (unpriv)
 		set_admin(true);
-	err =3D bpf_prog_test_run(fd_prog, 1, data, size_data,
-				tmp, &size_tmp, &retval, NULL);
+	err =3D bpf_prog_test_run_opts(fd_prog, &topts);
 	saved_errno =3D errno;

 	if (unpriv)
@@ -1051,9 +1056,8 @@ static int do_prog_test_run(int fd_prog, bool unpri=
v, uint32_t expected_val,
 		}
 	}

-	if (retval !=3D expected_val &&
-	    expected_val !=3D POINTER_VALUE) {
-		printf("FAIL retval %d !=3D %d ", retval, expected_val);
+	if (topts.retval !=3D expected_val && expected_val !=3D POINTER_VALUE) =
{
+		printf("FAIL retval %d !=3D %d ", topts.retval, expected_val);
 		return 1;
 	}

--
2.30.2
