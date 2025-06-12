Return-Path: <bpf+bounces-60438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA77CAD6643
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 05:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09131BC1874
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 03:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269C81CEAA3;
	Thu, 12 Jun 2025 03:50:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD044A35
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 03:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749700243; cv=none; b=svvO8gQUh0rFIxxKQOtsaRuZisbfBdgpQz5rhzgoVgKpW6NbmmCH4GJYs0vEqwU2Gi2ubovjutpnFO12SnHdkHmrS9PmMuwt1Ol8X4YCICW2ZiwSSXK79hoiFNZ8/XWfHWwLXI/E+ZULrLed4rAb/98P5AcYqZavPSJ0brNpl8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749700243; c=relaxed/simple;
	bh=j1npOISRrO0I0GOuE5X95upNami/SAC3m1rIZvubE2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mE4SFZ3IxTBUHhsV0B7Sl+qgOxzfqnbQJdG2/ghfWZ+o+GYvVFo6DhNlb35EppLt+67oI/bgptyhu4P1QcYTIMi+8wL5GAvCMR3pVDzp8h3A6Kk58uj5lk+Nh+LNNHirXuLyLO5/3AFYzZAdYbC7Vhksq/qvheckUc7Lo+2gHeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 96D0B96FFD4B; Wed, 11 Jun 2025 20:50:32 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 1/3] bpf: Fix an issue in bpf_prog_test_run_xdp when page size greater than 4K
Date: Wed, 11 Jun 2025 20:50:32 -0700
Message-ID: <20250612035032.2207498-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250612035027.2207299-1-yonghong.song@linux.dev>
References: <20250612035027.2207299-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The bpf selftest xdp_adjust_tail/xdp_adjust_frags_tail_grow failed on
arm64 with 64KB page:
   xdp_adjust_tail/xdp_adjust_frags_tail_grow:FAIL

In bpf_prog_test_run_xdp(), the xdp->frame_sz is set to 4K, but later on
when constructing frags, with 64K page size, the frag data_len could
be more than 4K. This will cause problems in bpf_xdp_frags_increase_tail(=
).

To fix the failure, the xdp->frame_sz is set to be PAGE_SIZE so kernel
can test different page size properly. With the kernel change, the user
space and bpf prog needs adjustment. Currently, the MAX_SKB_FRAGS default
value is 17, so for 4K page, the maximum packet size will be less than 68=
K.
To test 64K page, a bigger maximum packet size than 68K is desired. So tw=
o
different functions are implemented for subtest xdp_adjust_frags_tail_gro=
w.
Depending on different page size, different data input/output sizes are u=
sed
to adapt with different page size.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 net/bpf/test_run.c                            |  2 +-
 .../bpf/prog_tests/xdp_adjust_tail.c          | 96 +++++++++++++++++--
 .../bpf/progs/test_xdp_adjust_tail_grow.c     |  8 +-
 3 files changed, 97 insertions(+), 9 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index aaf13a7d58ed..9728dbd4c66c 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1255,7 +1255,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, co=
nst union bpf_attr *kattr,
 		headroom -=3D ctx->data;
 	}
=20
-	max_data_sz =3D 4096 - headroom - tailroom;
+	max_data_sz =3D PAGE_SIZE - headroom - tailroom;
 	if (size > max_data_sz) {
 		/* disallow live data mode for jumbo frames */
 		if (do_live)
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c b/t=
ools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
index e361129402a1..43264347e7d7 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
@@ -37,21 +37,26 @@ static void test_xdp_adjust_tail_shrink(void)
 	bpf_object__close(obj);
 }
=20
-static void test_xdp_adjust_tail_grow(void)
+static void test_xdp_adjust_tail_grow(bool is_64k_pagesize)
 {
 	const char *file =3D "./test_xdp_adjust_tail_grow.bpf.o";
 	struct bpf_object *obj;
-	char buf[4096]; /* avoid segfault: large buf to hold grow results */
+	char buf[8192]; /* avoid segfault: large buf to hold grow results */
 	__u32 expect_sz;
 	int err, prog_fd;
 	LIBBPF_OPTS(bpf_test_run_opts, topts,
 		.data_in =3D &pkt_v4,
-		.data_size_in =3D sizeof(pkt_v4),
 		.data_out =3D buf,
 		.data_size_out =3D sizeof(buf),
 		.repeat =3D 1,
 	);
=20
+	/* topts.data_size_in as a special signal to bpf prog */
+	if (is_64k_pagesize)
+		topts.data_size_in =3D sizeof(pkt_v4) - 1;
+	else
+		topts.data_size_in =3D sizeof(pkt_v4);
+
 	err =3D bpf_prog_test_load(file, BPF_PROG_TYPE_XDP, &obj, &prog_fd);
 	if (!ASSERT_OK(err, "test_xdp_adjust_tail_grow"))
 		return;
@@ -208,7 +213,7 @@ static void test_xdp_adjust_frags_tail_shrink(void)
 	bpf_object__close(obj);
 }
=20
-static void test_xdp_adjust_frags_tail_grow(void)
+static void test_xdp_adjust_frags_tail_grow_4k(void)
 {
 	const char *file =3D "./test_xdp_adjust_tail_grow.bpf.o";
 	__u32 exp_size;
@@ -279,16 +284,93 @@ static void test_xdp_adjust_frags_tail_grow(void)
 	bpf_object__close(obj);
 }
=20
+static void test_xdp_adjust_frags_tail_grow_64k(void)
+{
+	const char *file =3D "./test_xdp_adjust_tail_grow.bpf.o";
+	__u32 exp_size;
+	struct bpf_program *prog;
+	struct bpf_object *obj;
+	int err, i, prog_fd;
+	__u8 *buf;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	obj =3D bpf_object__open(file);
+	if (libbpf_get_error(obj))
+		return;
+
+	prog =3D bpf_object__next_program(obj, NULL);
+	if (bpf_object__load(obj))
+		goto out;
+
+	prog_fd =3D bpf_program__fd(prog);
+
+	buf =3D malloc(262144);
+	if (!ASSERT_OK_PTR(buf, "alloc buf 256Kb"))
+		goto out;
+
+	/* Test case add 10 bytes to last frag */
+	memset(buf, 1, 262144);
+	exp_size =3D 90000 + 10;
+
+	topts.data_in =3D buf;
+	topts.data_out =3D buf;
+	topts.data_size_in =3D 90000;
+	topts.data_size_out =3D 262144;
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+
+	ASSERT_OK(err, "90Kb+10b");
+	ASSERT_EQ(topts.retval, XDP_TX, "90Kb+10b retval");
+	ASSERT_EQ(topts.data_size_out, exp_size, "90Kb+10b size");
+
+	for (i =3D 0; i < 90000; i++) {
+		if (buf[i] !=3D 1)
+			ASSERT_EQ(buf[i], 1, "90Kb+10b-old");
+	}
+
+	for (i =3D 90000; i < 90010; i++) {
+		if (buf[i] !=3D 0)
+			ASSERT_EQ(buf[i], 0, "90Kb+10b-new");
+	}
+
+	for (i =3D 90010; i < 262144; i++) {
+		if (buf[i] !=3D 1)
+			ASSERT_EQ(buf[i], 1, "90Kb+10b-untouched");
+	}
+
+	/* Test a too large grow */
+	memset(buf, 1, 262144);
+	exp_size =3D 90001;
+
+	topts.data_in =3D topts.data_out =3D buf;
+	topts.data_size_in =3D 90001;
+	topts.data_size_out =3D 262144;
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+
+	ASSERT_OK(err, "90Kb+10b");
+	ASSERT_EQ(topts.retval, XDP_DROP, "90Kb+10b retval");
+	ASSERT_EQ(topts.data_size_out, exp_size, "90Kb+10b size");
+
+	free(buf);
+out:
+	bpf_object__close(obj);
+}
+
 void test_xdp_adjust_tail(void)
 {
+	int page_size =3D getpagesize();
+
 	if (test__start_subtest("xdp_adjust_tail_shrink"))
 		test_xdp_adjust_tail_shrink();
 	if (test__start_subtest("xdp_adjust_tail_grow"))
-		test_xdp_adjust_tail_grow();
+		test_xdp_adjust_tail_grow(page_size =3D=3D 65536);
 	if (test__start_subtest("xdp_adjust_tail_grow2"))
 		test_xdp_adjust_tail_grow2();
 	if (test__start_subtest("xdp_adjust_frags_tail_shrink"))
 		test_xdp_adjust_frags_tail_shrink();
-	if (test__start_subtest("xdp_adjust_frags_tail_grow"))
-		test_xdp_adjust_frags_tail_grow();
+	if (test__start_subtest("xdp_adjust_frags_tail_grow")) {
+		if (page_size =3D=3D 65536)
+			test_xdp_adjust_frags_tail_grow_64k();
+		else
+			test_xdp_adjust_frags_tail_grow_4k();
+	}
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.=
c b/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c
index dc74d8cf9e3f..5904f45cfbc4 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c
@@ -19,7 +19,9 @@ int _xdp_adjust_tail_grow(struct xdp_md *xdp)
 	/* Data length determine test case */
=20
 	if (data_len =3D=3D 54) { /* sizeof(pkt_v4) */
-		offset =3D 4096; /* test too large offset */
+		offset =3D 4096; /* test too large offset, 4k page size */
+	} else if (data_len =3D=3D 53) { /* sizeof(pkt_v4) - 1 */
+		offset =3D 65536; /* test too large offset, 64k page size */
 	} else if (data_len =3D=3D 74) { /* sizeof(pkt_v6) */
 		offset =3D 40;
 	} else if (data_len =3D=3D 64) {
@@ -31,6 +33,10 @@ int _xdp_adjust_tail_grow(struct xdp_md *xdp)
 		offset =3D 10;
 	} else if (data_len =3D=3D 9001) {
 		offset =3D 4096;
+	} else if (data_len =3D=3D 90000) {
+		offset =3D 10; /* test a small offset, 64k page size */
+	} else if (data_len =3D=3D 90001) {
+		offset =3D 65536; /* test too large offset, 64k page size */
 	} else {
 		return XDP_ABORTED; /* No matching test */
 	}
--=20
2.47.1


