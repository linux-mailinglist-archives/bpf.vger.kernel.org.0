Return-Path: <bpf+bounces-61443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31152AE7177
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 23:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB74C5A27CE
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 21:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFBB252900;
	Tue, 24 Jun 2025 21:18:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A52D47F4A
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 21:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750799899; cv=none; b=YxIuZ+zf52iu+1GwwVy2zQGCr2odMzFeqg2Xjx4a+hAbZdisXZQoctmNUEGbzc5qKfEU/N+8BETDXfA+wRHGnwfACTZaa+HzrsYUlhwBhNwe2XrAV1rOe1CFo9YK1WQ3SFaK6GiCxZ9BHTXpxPDJHRZyB9iFxNq8h9UgAPZudRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750799899; c=relaxed/simple;
	bh=pFUG0trft62R96hu6NOuJtQUk+M8QOlre8YRJEvAASc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U8V4T2TNuf2WCwfaiXLc7nF2GkA0mGQ0pAaR0dQQABzlShbSOVbJLLArw58rGZwf6TzWJR3S1VlNmGeOY+wroFsmYAA8SgAfLnuufnzFUmftLINb8ZDp4XqFCEtsQshP/P8+nZaEuW8GP/9IDTPeQ3fiKE0A/1M1r42PmH/81us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id DAA79A49EBF4; Tue, 24 Jun 2025 14:18:02 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3] selftests/bpf: Fix usdt multispec failure with arm64/clang20 selftest build
Date: Tue, 24 Jun 2025 14:18:02 -0700
Message-ID: <20250624211802.2198821-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
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
  subtest_multispec_usdt:FAIL:usdt_300_bad_attach unexpected pointer: 0xa=
aaad82a2a80
  #471/2   usdt/multispec:FAIL
  #471     usdt:FAIL

But arm64/gcc11 built kernel selftests succeeded. Further debug found arm=
64/clang
generated code has much less argument pattern after dedup, but gcc genera=
ted
code has a lot more.

Check usdt probes with usdt.test.o on arm64 platform:

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

There are total 300 locations for usdt_300. For gcc11 built binary, there=
 are
300 spec's. But for clang20 built binary, there are 3 spec's. The default
BPF_USDT_MAX_SPEC_CNT is 256, so bpf_program__attach_usdt() will fail for=
 gcc
but it will succeed with clang.

To fix the problem, do not do bpf_program__attach_usdt() for usdt_300
with arm64/clang setup.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/usdt.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

Changelogs:
  v2 -> v3:
    - v2: https://lore.kernel.org/bpf/20250615185345.2756663-1-yonghong.s=
ong@linux.dev/
    - Skip some tests where not arm64/clang setup will succeed and arm64/=
clang
      setup will fail.
  v1 -> v2:
    - v1: https://lore.kernel.org/bpf/20250613153446.2256725-1-yonghong.s=
ong@linux.dev/
    - The commit description in v1 is not right, it checks sdt's for usdt=
_100
      while actually it usdt_300 should be checked. Patch 1 has proper
      descriptions.
    - Refactor the code to add a new test ust/multispec_fail where a new
      prog is added and in that new prog BPF_USDT_MAX_SPEC_CNT can overwr=
ite
      the default value in order to pass the test.

diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testin=
g/selftests/bpf/prog_tests/usdt.c
index 495d66414b57..9057e983cc54 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@ -270,8 +270,16 @@ static void subtest_multispec_usdt(void)
 	 */
 	trigger_300_usdts();
=20
-	/* we'll reuse usdt_100 BPF program for usdt_300 test */
 	bpf_link__destroy(skel->links.usdt_100);
+
+	bss->usdt_100_called =3D 0;
+	bss->usdt_100_sum =3D 0;
+
+	/* If built with arm64/clang, there will be much less number of specs
+	 * for usdt_300 call sites.
+	 */
+#if !defined(__aarch64__) || !defined(__clang__)
+	/* we'll reuse usdt_100 BPF program for usdt_300 test */
 	skel->links.usdt_100 =3D bpf_program__attach_usdt(skel->progs.usdt_100,=
 -1, "/proc/self/exe",
 							"test", "usdt_300", NULL);
 	err =3D -errno;
@@ -282,13 +290,11 @@ static void subtest_multispec_usdt(void)
 	/* let's check that there are no "dangling" BPF programs attached due
 	 * to partial success of the above test:usdt_300 attachment
 	 */
-	bss->usdt_100_called =3D 0;
-	bss->usdt_100_sum =3D 0;
-
 	f300(777); /* this is 301st instance of usdt_300 */
=20
 	ASSERT_EQ(bss->usdt_100_called, 0, "usdt_301_called");
 	ASSERT_EQ(bss->usdt_100_sum, 0, "usdt_301_sum");
+#endif
=20
 	/* This time we have USDT with 400 inlined invocations, but arg specs
 	 * should be the same across all sites, so libbpf will only need to
--=20
2.47.1


