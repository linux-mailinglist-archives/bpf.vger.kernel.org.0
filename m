Return-Path: <bpf+bounces-60691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D183ADA30E
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 20:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CADA018896E5
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 18:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C19327C162;
	Sun, 15 Jun 2025 18:54:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E9127BF7E
	for <bpf@vger.kernel.org>; Sun, 15 Jun 2025 18:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750013645; cv=none; b=BcAN+WOMA5081S85z0YAdJGnHXr+ZcSYwwZ9iX3jVhA2FsYQpf2DjvidAch2dR9UnCDNOm3++EYjX42LIHQsPcVrf0MTUrDc4kDTVVf2FsQQuZ6FXxFsshumyTBZh9ZEF8JuYakHc7hXamkjcykyQPGFSU4vwGpg/gzJ/QJCLAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750013645; c=relaxed/simple;
	bh=RcFbp71hneABuGi1jdXYX2ftw1kDTz5pc3YN784wq5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XH551OuAjevGuuQJXSnsxY+J5L3EYppi/rNnaKDqH/0gWJA/0Thd7ITw1iLmi3xCb7ylPifJ4NPmulVb+v7tvTTGY5u9N9WilhjYWcnCh73vGJGLsl8aLMBjl6PEgWDOdZEs197O6P0m10SSGYt9k7shk1gLWfA0vvPrMLl9NQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 1BBE39A90F6B; Sun, 15 Jun 2025 11:53:51 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 1/3] selftests/bpf: Refactor the failed assertion to another subtest
Date: Sun, 15 Jun 2025 11:53:51 -0700
Message-ID: <20250615185351.2757391-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250615185345.2756663-1-yonghong.song@linux.dev>
References: <20250615185345.2756663-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When building the selftest with arm64/clang20, the following test failed:
    ...
    ubtest_multispec_usdt:PASS:usdt_100_called 0 nsec
    subtest_multispec_usdt:PASS:usdt_100_sum 0 nsec
    subtest_multispec_usdt:FAIL:usdt_300_bad_attach unexpected pointer: 0=
xaaaad82a2a80
    #469/2   usdt/multispec:FAIL
    #469     usdt:FAIL

The failed assertion
    subtest_multispec_usdt:FAIL:usdt_300_bad_attach unexpected pointer: 0=
xaaaad82a2a80
is caused by bpf_program__attach_usdt() which is expected to fail. But
with arm64/clang20 bpf_program__attach_usdt() actually succeeded.

Checking usdt probes with usdt.test.o,

with gcc11 build binary:
  stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe descr=
iptors)
    Provider: test
    Name: usdt_300
    Location: 0x00000000000054f8, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000008
    Arguments: -4@[sp]
  stapsdt              0x00000031       NT_STAPSDT (SystemTap probe descr=
iptors)
    Provider: test
    Name: usdt_300
    Location: 0x0000000000005510, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000008
    Arguments: -4@[sp, 4]
  ...
  stapsdt              0x00000032       NT_STAPSDT (SystemTap probe descr=
iptors)
    Provider: test
    Name: usdt_300
    Location: 0x0000000000005660, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000008
    Arguments: -4@[sp, 60]
  ...
  stapsdt              0x00000034       NT_STAPSDT (SystemTap probe descr=
iptors)
    Provider: test
    Name: usdt_300
    Location: 0x00000000000070e8, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000008
    Arguments: -4@[sp, 1192]
  stapsdt              0x00000034       NT_STAPSDT (SystemTap probe descr=
iptors)
    Provider: test
    Name: usdt_300
    Location: 0x0000000000007100, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000008
    Arguments: -4@[sp, 1196]
  ...
  stapsdt              0x00000032       NT_STAPSDT (SystemTap probe descr=
iptors)
    Provider: test
    Name: usdt_300
    Location: 0x0000000000009ec4, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000008
    Arguments: -4@[sp, 60]

with clang20 build binary:
  stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe descr=
iptors)
    Provider: test
    Name: usdt_300
    Location: 0x00000000000009a0, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000008
    Arguments: -4@[x9]
  stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe descr=
iptors)
    Provider: test
    Name: usdt_300
    Location: 0x00000000000009b8, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000008
    Arguments: -4@[x9]
  ...
  stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe descr=
iptors)
    Provider: test
    Name: usdt_300
    Location: 0x0000000000002590, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000008
    Arguments: -4@[x9]
  stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe descr=
iptors)
    Provider: test
    Name: usdt_300
    Location: 0x00000000000025a8, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000008
    Arguments: -4@[x8]
  ...
  stapsdt              0x0000002f       NT_STAPSDT (SystemTap probe descr=
iptors)
    Provider: test
    Name: usdt_300
    Location: 0x0000000000007fdc, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000008
    Arguments: -4@[x10]

There are total 301 locations for usdt_300. For gcc11 built binary, there=
 are
300 spec's. But for clang20 built binary, there are 3 spec's. The libbpf =
default
BPF_USDT_MAX_SPEC_CNT is 256. So for gcc11, the above bpf_program__attach=
_usdt() will
fail, but the function will succeed for clang20.

Note that we cannot just change BPF_USDT_MAX_SPEC_CNT from 256 to 2 (thro=
ugh overwriting
BPF_USDT_MAX_SPEC_CNT before usdt.bpf.h) since it will cause other test f=
ailures.
We cannot just set BPF_USDT_MAX_SPEC_CNT to 2 for test_usdt_multispec.c s=
ince we
have below in the Makefile:
  test_usdt.skel.h-deps :=3D test_usdt.bpf.o test_usdt_multispec.bpf.o
and the linker will enforce that BPF_USDT_MAX_SPEC_CNT values for both pr=
ogs must
be the same.

The refactoring does not change existing test result. But the future chan=
ge will
allow to set BPF_USDT_MAX_SPEC_CNT to be 2 for arm64/clang20 case, which =
will have
the same attachment failure as in gcc11.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/usdt.c | 35 +++++++++++++------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testin=
g/selftests/bpf/prog_tests/usdt.c
index 495d66414b57..dc29ef94312a 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@ -270,18 +270,8 @@ static void subtest_multispec_usdt(void)
 	 */
 	trigger_300_usdts();
=20
-	/* we'll reuse usdt_100 BPF program for usdt_300 test */
 	bpf_link__destroy(skel->links.usdt_100);
-	skel->links.usdt_100 =3D bpf_program__attach_usdt(skel->progs.usdt_100,=
 -1, "/proc/self/exe",
-							"test", "usdt_300", NULL);
-	err =3D -errno;
-	if (!ASSERT_ERR_PTR(skel->links.usdt_100, "usdt_300_bad_attach"))
-		goto cleanup;
-	ASSERT_EQ(err, -E2BIG, "usdt_300_attach_err");
=20
-	/* let's check that there are no "dangling" BPF programs attached due
-	 * to partial success of the above test:usdt_300 attachment
-	 */
 	bss->usdt_100_called =3D 0;
 	bss->usdt_100_sum =3D 0;
=20
@@ -312,6 +302,29 @@ static void subtest_multispec_usdt(void)
 	test_usdt__destroy(skel);
 }
=20
+static void subtest_multispec_fail_usdt(void)
+{
+	LIBBPF_OPTS(bpf_usdt_opts, opts);
+	struct test_usdt *skel;
+	int err;
+
+	skel =3D test_usdt__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	skel->bss->my_pid =3D getpid();
+
+	skel->links.usdt_100 =3D bpf_program__attach_usdt(skel->progs.usdt_100,=
 -1, "/proc/self/exe",
+							"test", "usdt_300", NULL);
+	err =3D -errno;
+	if (!ASSERT_ERR_PTR(skel->links.usdt_100, "usdt_300_bad_attach"))
+		goto cleanup;
+	ASSERT_EQ(err, -E2BIG, "usdt_300_attach_err");
+
+cleanup:
+	test_usdt__destroy(skel);
+}
+
 static FILE *urand_spawn(int *pid)
 {
 	FILE *f;
@@ -422,6 +435,8 @@ void test_usdt(void)
 		subtest_basic_usdt();
 	if (test__start_subtest("multispec"))
 		subtest_multispec_usdt();
+	if (test__start_subtest("multispec_fail"))
+		subtest_multispec_fail_usdt();
 	if (test__start_subtest("urand_auto_attach"))
 		subtest_urandom_usdt(true /* auto_attach */);
 	if (test__start_subtest("urand_pid_attach"))
--=20
2.47.1


