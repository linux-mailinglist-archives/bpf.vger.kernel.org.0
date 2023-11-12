Return-Path: <bpf+bounces-14904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F4A7E8DD7
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 02:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4891C2082E
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 01:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4350915D1;
	Sun, 12 Nov 2023 01:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F051817EA
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 01:07:04 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462B5171A
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:07:03 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AC0BLug014174
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:07:02 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ua884jg95-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:07:02 -0800
Received: from twshared19681.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 11 Nov 2023 17:06:59 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id AE7913B5D52AB; Sat, 11 Nov 2023 17:06:47 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>
Subject: [PATCH v2 bpf-next 11/13] selftests/bpf: set BPF_F_TEST_SANITY_SCRIPT by default
Date: Sat, 11 Nov 2023 17:06:07 -0800
Message-ID: <20231112010609.848406-12-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231112010609.848406-1-andrii@kernel.org>
References: <20231112010609.848406-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: JKRTUj5bj1t6j1gfQINL6x2KmXZl_h8n
X-Proofpoint-ORIG-GUID: JKRTUj5bj1t6j1gfQINL6x2KmXZl_h8n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-11_21,2023-11-09_01,2023-05-22_02

Make sure to set BPF_F_TEST_SANITY_STRICT program flag by default across
most verifier tests (and a bunch of others that set custom prog flags).

There are currently two tests that do fail validation, if enforced
strictly: verifier_bounds/crossing_64_bit_signed_boundary_2 and
verifier_bounds/crossing_32_bit_signed_boundary_2. To accommodate them,
we teach test_loader a flag negation:

__flag(!<flagname>) will *clear* specified flag, allowing easy opt-out.

We apply __flag(!BPF_F_TEST_SANITY_STRICT) to these to tests.

Also sprinkle BPF_F_TEST_SANITY_STRICT everywhere where we already set
test-only BPF_F_TEST_RND_HI32 flag, for completeness.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/prog_tests/bpf_verif_scale.c          |  2 +-
 .../selftests/bpf/progs/verifier_bounds.c     |  2 ++
 tools/testing/selftests/bpf/test_loader.c     | 35 ++++++++++++++-----
 tools/testing/selftests/bpf/test_sock_addr.c  |  1 +
 tools/testing/selftests/bpf/test_verifier.c   |  2 +-
 tools/testing/selftests/bpf/testing_helpers.c |  4 +--
 6 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/t=
ools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
index 731c343897d8..3f2d70831873 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
@@ -35,7 +35,7 @@ static int check_load(const char *file, enum bpf_prog_t=
ype type)
 	}
=20
 	bpf_program__set_type(prog, type);
-	bpf_program__set_flags(prog, BPF_F_TEST_RND_HI32);
+	bpf_program__set_flags(prog, BPF_F_TEST_RND_HI32 | BPF_F_TEST_SANITY_ST=
RICT);
 	bpf_program__set_log_level(prog, 4 | extra_prog_load_log_flags);
=20
 	err =3D bpf_object__load(obj);
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/=
testing/selftests/bpf/progs/verifier_bounds.c
index c5588a14fe2e..0c1460936373 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -965,6 +965,7 @@ l0_%=3D:	r0 =3D 0;						\
 SEC("xdp")
 __description("bound check with JMP_JSLT for crossing 64-bit signed boun=
dary")
 __success __retval(0)
+__flag(!BPF_F_TEST_SANITY_STRICT) /* known sanity violation */
 __naked void crossing_64_bit_signed_boundary_2(void)
 {
 	asm volatile ("					\
@@ -1046,6 +1047,7 @@ l0_%=3D:	r0 =3D 0;						\
 SEC("xdp")
 __description("bound check with JMP32_JSLT for crossing 32-bit signed bo=
undary")
 __success __retval(0)
+__flag(!BPF_F_TEST_SANITY_STRICT) /* known sanity violation */
 __naked void crossing_32_bit_signed_boundary_2(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/se=
lftests/bpf/test_loader.c
index 37ffa57f28a1..57e27b1a73a6 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -153,6 +153,14 @@ static int parse_retval(const char *str, int *val, c=
onst char *name)
 	return parse_int(str, val, name);
 }
=20
+static void update_flags(int *flags, int flag, bool clear)
+{
+	if (clear)
+		*flags &=3D ~flag;
+	else
+		*flags |=3D flag;
+}
+
 /* Uses btf_decl_tag attributes to describe the expected test
  * behavior, see bpf_misc.h for detailed description of each attribute
  * and attribute combinations.
@@ -171,6 +179,7 @@ static int parse_test_spec(struct test_loader *tester=
,
 	memset(spec, 0, sizeof(*spec));
=20
 	spec->prog_name =3D bpf_program__name(prog);
+	spec->prog_flags =3D BPF_F_TEST_SANITY_STRICT; /* by default be strict =
*/
=20
 	btf =3D bpf_object__btf(obj);
 	if (!btf) {
@@ -187,7 +196,8 @@ static int parse_test_spec(struct test_loader *tester=
,
 	for (i =3D 1; i < btf__type_cnt(btf); i++) {
 		const char *s, *val, *msg;
 		const struct btf_type *t;
-		int tmp;
+		bool clear;
+		int flags;
=20
 		t =3D btf__type_by_id(btf, i);
 		if (!btf_is_decl_tag(t))
@@ -253,23 +263,30 @@ static int parse_test_spec(struct test_loader *test=
er,
 				goto cleanup;
 		} else if (str_has_pfx(s, TEST_TAG_PROG_FLAGS_PFX)) {
 			val =3D s + sizeof(TEST_TAG_PROG_FLAGS_PFX) - 1;
+
+			clear =3D val[0] =3D=3D '!';
+			if (clear)
+				val++;
+
 			if (strcmp(val, "BPF_F_STRICT_ALIGNMENT") =3D=3D 0) {
-				spec->prog_flags |=3D BPF_F_STRICT_ALIGNMENT;
+				update_flags(&spec->prog_flags, BPF_F_STRICT_ALIGNMENT, clear);
 			} else if (strcmp(val, "BPF_F_ANY_ALIGNMENT") =3D=3D 0) {
-				spec->prog_flags |=3D BPF_F_ANY_ALIGNMENT;
+				update_flags(&spec->prog_flags, BPF_F_ANY_ALIGNMENT, clear);
 			} else if (strcmp(val, "BPF_F_TEST_RND_HI32") =3D=3D 0) {
-				spec->prog_flags |=3D BPF_F_TEST_RND_HI32;
+				update_flags(&spec->prog_flags, BPF_F_TEST_RND_HI32, clear);
 			} else if (strcmp(val, "BPF_F_TEST_STATE_FREQ") =3D=3D 0) {
-				spec->prog_flags |=3D BPF_F_TEST_STATE_FREQ;
+				update_flags(&spec->prog_flags, BPF_F_TEST_STATE_FREQ, clear);
 			} else if (strcmp(val, "BPF_F_SLEEPABLE") =3D=3D 0) {
-				spec->prog_flags |=3D BPF_F_SLEEPABLE;
+				update_flags(&spec->prog_flags, BPF_F_SLEEPABLE, clear);
 			} else if (strcmp(val, "BPF_F_XDP_HAS_FRAGS") =3D=3D 0) {
-				spec->prog_flags |=3D BPF_F_XDP_HAS_FRAGS;
+				update_flags(&spec->prog_flags, BPF_F_XDP_HAS_FRAGS, clear);
+			} else if (strcmp(val, "BPF_F_TEST_SANITY_STRICT") =3D=3D 0) {
+				update_flags(&spec->prog_flags, BPF_F_TEST_SANITY_STRICT, clear);
 			} else /* assume numeric value */ {
-				err =3D parse_int(val, &tmp, "test prog flags");
+				err =3D parse_int(val, &flags, "test prog flags");
 				if (err)
 					goto cleanup;
-				spec->prog_flags |=3D tmp;
+				update_flags(&spec->prog_flags, flags, clear);
 			}
 		}
 	}
diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing=
/selftests/bpf/test_sock_addr.c
index 2c89674fc62c..878c077e0fa7 100644
--- a/tools/testing/selftests/bpf/test_sock_addr.c
+++ b/tools/testing/selftests/bpf/test_sock_addr.c
@@ -680,6 +680,7 @@ static int load_path(const struct sock_addr_test *tes=
t, const char *path)
 	bpf_program__set_type(prog, BPF_PROG_TYPE_CGROUP_SOCK_ADDR);
 	bpf_program__set_expected_attach_type(prog, test->expected_attach_type)=
;
 	bpf_program__set_flags(prog, BPF_F_TEST_RND_HI32);
+	bpf_program__set_flags(prog, BPF_F_TEST_SANITY_STRICT);
=20
 	err =3D bpf_object__load(obj);
 	if (err) {
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/=
selftests/bpf/test_verifier.c
index 98107e0452d3..4992022f3137 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -1588,7 +1588,7 @@ static void do_test_single(struct bpf_test *test, b=
ool unpriv,
 	if (fixup_skips !=3D skips)
 		return;
=20
-	pflags =3D BPF_F_TEST_RND_HI32;
+	pflags =3D BPF_F_TEST_RND_HI32 | BPF_F_TEST_SANITY_STRICT;
 	if (test->flags & F_LOAD_WITH_STRICT_ALIGNMENT)
 		pflags |=3D BPF_F_STRICT_ALIGNMENT;
 	if (test->flags & F_NEEDS_EFFICIENT_UNALIGNED_ACCESS)
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testin=
g/selftests/bpf/testing_helpers.c
index 8d994884c7b4..9786a94a666c 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -276,7 +276,7 @@ int bpf_prog_test_load(const char *file, enum bpf_pro=
g_type type,
 	if (type !=3D BPF_PROG_TYPE_UNSPEC && bpf_program__type(prog) !=3D type=
)
 		bpf_program__set_type(prog, type);
=20
-	flags =3D bpf_program__flags(prog) | BPF_F_TEST_RND_HI32;
+	flags =3D bpf_program__flags(prog) | BPF_F_TEST_RND_HI32 | BPF_F_TEST_S=
ANITY_STRICT;
 	bpf_program__set_flags(prog, flags);
=20
 	err =3D bpf_object__load(obj);
@@ -299,7 +299,7 @@ int bpf_test_load_program(enum bpf_prog_type type, co=
nst struct bpf_insn *insns,
 {
 	LIBBPF_OPTS(bpf_prog_load_opts, opts,
 		.kern_version =3D kern_version,
-		.prog_flags =3D BPF_F_TEST_RND_HI32,
+		.prog_flags =3D BPF_F_TEST_RND_HI32 | BPF_F_TEST_SANITY_STRICT,
 		.log_level =3D extra_prog_load_log_flags,
 		.log_buf =3D log_buf,
 		.log_size =3D log_buf_sz,
--=20
2.34.1


