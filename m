Return-Path: <bpf+bounces-13279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E2C7D76F1
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 23:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3460F1C20F2D
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 21:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ADF34CC5;
	Wed, 25 Oct 2023 21:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="O8hB8VGi"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC21B347DC
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 21:41:38 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052CB13A
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 14:41:36 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 39PLfYSA022808
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 14:41:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Gn9ZI5J32KHghiDHay1p9T3BbJPaY/nbEdwAVEvo64o=;
 b=O8hB8VGipJ2WKWkiL07/WMb1YLrRasYctTYnU+MWlgv6yzKXaxQ3VJkL8HkWr5jmKsiV
 0UElQHA9B87V/WEsH9NDiTuerl79ZdZ4qZS+6AsOY2vDN8+TR5EN5w8s9rrLP+vofnJ4
 QbUcNPb7t2ibIeqw9jHKy/3dsZxNwBXr7sg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 3ty557k6w9-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 14:41:35 -0700
Received: from twshared4242.09.ash9.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 25 Oct 2023 14:40:27 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 9D5C4264D4716; Wed, 25 Oct 2023 14:40:17 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky
	<davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 6/6] selftests/bpf: Test bpf_refcount_acquire of node obtained via direct ld
Date: Wed, 25 Oct 2023 14:40:07 -0700
Message-ID: <20231025214007.2920506-7-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025214007.2920506-1-davemarchevsky@fb.com>
References: <20231025214007.2920506-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: RCDV1XNjFsshkV2OX07_MiEceP-Q8TyB
X-Proofpoint-GUID: RCDV1XNjFsshkV2OX07_MiEceP-Q8TyB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_11,2023-10-25_01,2023-05-22_02

This patch demonstrates that verifier changes earlier in this series
result in bpf_refcount_acquire(mapval->stashed_kptr) passing
verification. The added test additionally validates that stashing a kptr
in mapval and - in a separate BPF program - refcount_acquiring the kptr
without unstashing works as expected at runtime.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 .../bpf/prog_tests/local_kptr_stash.c         | 33 +++++++++
 .../selftests/bpf/progs/local_kptr_stash.c    | 68 +++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/local_kptr_stash.c b/=
tools/testing/selftests/bpf/prog_tests/local_kptr_stash.c
index b25b870f87ba..cdc91a184aee 100644
--- a/tools/testing/selftests/bpf/prog_tests/local_kptr_stash.c
+++ b/tools/testing/selftests/bpf/prog_tests/local_kptr_stash.c
@@ -73,6 +73,37 @@ static void test_local_kptr_stash_unstash(void)
 	local_kptr_stash__destroy(skel);
 }
=20
+static void test_refcount_acquire_without_unstash(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		    .data_in =3D &pkt_v4,
+		    .data_size_in =3D sizeof(pkt_v4),
+		    .repeat =3D 1,
+	);
+	struct local_kptr_stash *skel;
+	int ret;
+
+	skel =3D local_kptr_stash__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "local_kptr_stash__open_and_load"))
+		return;
+
+	ret =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.refcount_acq=
uire_without_unstash),
+				     &opts);
+	ASSERT_OK(ret, "refcount_acquire_without_unstash run");
+	ASSERT_EQ(opts.retval, 2, "refcount_acquire_without_unstash retval");
+
+	ret =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.stash_refcou=
nted_node), &opts);
+	ASSERT_OK(ret, "stash_refcounted_node run");
+	ASSERT_OK(opts.retval, "stash_refcounted_node retval");
+
+	ret =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.refcount_acq=
uire_without_unstash),
+				     &opts);
+	ASSERT_OK(ret, "refcount_acquire_without_unstash (2) run");
+	ASSERT_OK(opts.retval, "refcount_acquire_without_unstash (2) retval");
+
+	local_kptr_stash__destroy(skel);
+}
+
 static void test_local_kptr_stash_fail(void)
 {
 	RUN_TESTS(local_kptr_stash_fail);
@@ -86,6 +117,8 @@ void test_local_kptr_stash(void)
 		test_local_kptr_stash_plain();
 	if (test__start_subtest("local_kptr_stash_unstash"))
 		test_local_kptr_stash_unstash();
+	if (test__start_subtest("refcount_acquire_without_unstash"))
+		test_refcount_acquire_without_unstash();
 	if (test__start_subtest("local_kptr_stash_fail"))
 		test_local_kptr_stash_fail();
 }
diff --git a/tools/testing/selftests/bpf/progs/local_kptr_stash.c b/tools=
/testing/selftests/bpf/progs/local_kptr_stash.c
index b567a666d2b8..47bac1e5f45b 100644
--- a/tools/testing/selftests/bpf/progs/local_kptr_stash.c
+++ b/tools/testing/selftests/bpf/progs/local_kptr_stash.c
@@ -14,6 +14,24 @@ struct node_data {
 	struct bpf_rb_node node;
 };
=20
+struct refcounted_node {
+	long data;
+	struct bpf_rb_node rb_node;
+	struct bpf_refcount refcount;
+};
+
+struct stash {
+	struct bpf_spin_lock l;
+	struct refcounted_node __kptr *stashed;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct stash);
+	__uint(max_entries, 10);
+} refcounted_node_stash SEC(".maps");
+
 struct plain_local {
 	long key;
 	long data;
@@ -38,6 +56,7 @@ struct map_value {
  * Had to do the same w/ bpf_kfunc_call_test_release below
  */
 struct node_data *just_here_because_btf_bug;
+struct refcounted_node *just_here_because_btf_bug2;
=20
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
@@ -132,4 +151,53 @@ long stash_test_ref_kfunc(void *ctx)
 	return 0;
 }
=20
+SEC("tc")
+long refcount_acquire_without_unstash(void *ctx)
+{
+	struct refcounted_node *p;
+	struct stash *s;
+	int key =3D 0;
+
+	s =3D bpf_map_lookup_elem(&refcounted_node_stash, &key);
+	if (!s)
+		return 1;
+
+	if (!s->stashed)
+		/* refcount_acquire failure is expected when no refcounted_node
+		 * has been stashed before this program executes
+		 */
+		return 2;
+
+	p =3D bpf_refcount_acquire(s->stashed);
+	if (!p)
+		return 3;
+	bpf_obj_drop(p);
+	return 0;
+}
+
+/* Helper for refcount_acquire_without_unstash test */
+SEC("tc")
+long stash_refcounted_node(void *ctx)
+{
+	struct refcounted_node *p;
+	struct stash *s;
+	int key =3D 0;
+
+	s =3D bpf_map_lookup_elem(&refcounted_node_stash, &key);
+	if (!s)
+		return 1;
+
+	p =3D bpf_obj_new(typeof(*p));
+	if (!p)
+		return 2;
+
+	p =3D bpf_kptr_xchg(&s->stashed, p);
+	if (p) {
+		bpf_obj_drop(p);
+		return 3;
+	}
+
+	return 0;
+}
+
 char _license[] SEC("license") =3D "GPL";
--=20
2.34.1


