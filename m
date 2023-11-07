Return-Path: <bpf+bounces-14387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 385A97E3709
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 09:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D3A280F04
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 08:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35121171B;
	Tue,  7 Nov 2023 08:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="KRR4TwYp"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231B9DDB5
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 08:57:00 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74D7106
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 00:56:58 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6NHsQ5009020
	for <bpf@vger.kernel.org>; Tue, 7 Nov 2023 00:56:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=m4r9IIJz+2ad0J+iajXHajvwxTbT/D45vCbZ3bkpeXQ=;
 b=KRR4TwYpXlv3uNI/Hgwwi9Zf7tvuBzVHfizInd8xtpAhL0wP9SqOutc5R8c6WU7YMmfG
 Vc0cEo/7lYdygcBNKWMxIKj6Ke92gMh/m/huQcuXxhJmy17sovRymoEl5ec5SAEdR4OC
 jtVEuHGII0Yar98EVbTlujhnkaEv7V5dnMc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u79h5k60e-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 07 Nov 2023 00:56:57 -0800
Received: from twshared1106.02.ash9.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 00:56:53 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 7C9A126E3B72A; Tue,  7 Nov 2023 00:56:46 -0800 (PST)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Yonghong Song
	<yonghong.song@linux.dev>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 6/6] selftests/bpf: Test bpf_refcount_acquire of node obtained via direct ld
Date: Tue, 7 Nov 2023 00:56:39 -0800
Message-ID: <20231107085639.3016113-7-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107085639.3016113-1-davemarchevsky@fb.com>
References: <20231107085639.3016113-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: PifUbeAOLJjzgZstccmf5t6I7LJN1PVK
X-Proofpoint-ORIG-GUID: PifUbeAOLJjzgZstccmf5t6I7LJN1PVK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02

This patch demonstrates that verifier changes earlier in this series
result in bpf_refcount_acquire(mapval->stashed_kptr) passing
verification. The added test additionally validates that stashing a kptr
in mapval and - in a separate BPF program - refcount_acquiring the kptr
without unstashing works as expected at runtime.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 .../bpf/prog_tests/local_kptr_stash.c         | 33 +++++++++
 .../selftests/bpf/progs/local_kptr_stash.c    | 71 +++++++++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/local_kptr_stash.c b/=
tools/testing/selftests/bpf/prog_tests/local_kptr_stash.c
index b25b870f87ba..e6e50a394472 100644
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
+	ASSERT_EQ(opts.retval, 42, "refcount_acquire_without_unstash (2) retval=
");
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
index b567a666d2b8..1769fdff6aea 100644
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
@@ -132,4 +151,56 @@ long stash_test_ref_kfunc(void *ctx)
 	return 0;
 }
=20
+SEC("tc")
+long refcount_acquire_without_unstash(void *ctx)
+{
+	struct refcounted_node *p;
+	struct stash *s;
+	int ret =3D 0;
+
+	s =3D bpf_map_lookup_elem(&refcounted_node_stash, &ret);
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
+
+	ret =3D s->stashed ? s->stashed->data : -1;
+	bpf_obj_drop(p);
+	return ret;
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
+	p->data =3D 42;
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


