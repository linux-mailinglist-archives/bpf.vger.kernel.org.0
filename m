Return-Path: <bpf+bounces-60607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E59AD915F
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 17:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB78E3AAFBC
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 15:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E027E1EF0BE;
	Fri, 13 Jun 2025 15:35:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6591EB19B
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749828902; cv=none; b=gGlyh8R73G7LbohG4e7EDG5VecU81BET0RZILRKya0U3loDh5Bgw9flN6iKlUJx2vwEngwXwaCtB6ofGGlZpLKTTdzI+tgi6ifVwfsK5MxoHifD1QOudWaAp8N8lc81mvKWA7Iv0HhkJweeSbuUN3La3UTNEwMKyqXj40xnfjjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749828902; c=relaxed/simple;
	bh=MQQkrIGq1vPghKvYALORsJ3AChXO74YD8tN/jlfb9vE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GjB+6I8+1XCh3D8jmePkPDyVZJn6/ClVKjhjhgtDxAYoM+aanKvQ7hAh0bsefTbdvLKwyZbOGP6WPBoyESSaUq1YnQxvX6wk/59HNrCXuqBxg8VojDAiD7+u8X5zFlAeZGpMU2ZqFPvFwHmkjWM+Aqx2uunueCAV3rAm7Vl78lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id DF299989C596; Fri, 13 Jun 2025 08:34:46 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Fix usdt multispec failure with arm64/clang20 selftest build
Date: Fri, 13 Jun 2025 08:34:46 -0700
Message-ID: <20250613153446.2256725-1-yonghong.song@linux.dev>
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
  #469/2   usdt/multispec:FAIL
  #469     usdt:FAIL

But gcc11 built kernel/selftests succeeded. Further debug found clang gen=
erated
code has much less argument pattern after dedup, but gcc generated code h=
as
a lot more.

Below is the test:usdt_100 stapsdt's with clang20 generated binary:

  $ readelf -n usdt.test.o
  Displaying notes found in: .note.stapsdt
  Owner                Data size        Description
  stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe descr=
iptors)
    Provider: test
    Name: usdt_100
    Location: 0x0000000000000024, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000006
    Arguments: -4@[x9]
  stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe descr=
iptors)
    Provider: test
    Name: usdt_100
    Location: 0x000000000000003c, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000006
    Arguments: -4@[x9]
  ...
    stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe des=
criptors)
    Provider: test
    Name: usdt_100
    Location: 0x0000000000000954, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000006
    Arguments: -4@[x9]
  stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe descr=
iptors)
    Provider: test
    Name: usdt_100
    Location: 0x000000000000096c, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000006
    Arguments: -4@[x8]

Below is the test:usdt_100 stapsdt's with gcc11 generated binary:

  $ readelf -n usdt.test.o
  Displaying notes found in: .note.stapsdt
  Owner                Data size        Description
  ...
  stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe descr=
iptors)
    Provider: test
    Name: usdt_100
    Location: 0x000000000000470c, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000006
    Arguments: -4@[sp]
  stapsdt              0x00000031       NT_STAPSDT (SystemTap probe descr=
iptors)
    Provider: test
    Name: usdt_100
    Location: 0x0000000000004724, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000006
    Arguments: -4@[sp, 4]
  ...
  stapsdt              0x00000033       NT_STAPSDT (SystemTap probe descr=
iptors)
    Provider: test
    Name: usdt_100
    Location: 0x000000000000503c, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000006
    Arguments: -4@[sp, 392]
  stapsdt              0x00000033       NT_STAPSDT (SystemTap probe descr=
iptors)
    Provider: test
    Name: usdt_100
    Location: 0x0000000000005054, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000006
    Arguments: -4@[sp, 396]

Considering libbpf dedup of usdt spec's, the clang generated code has 3 s=
pec's, and
gcc has 100 spec's. Due to this, bpf_program__attach_usdt() failed with g=
cc but succeeded
with clang. To fix the test failure for clang generated code, make bpf_pr=
ogram__attach_usdt()
succeed with necessary macro guards.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/usdt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testin=
g/selftests/bpf/prog_tests/usdt.c
index 495d66414b57..7429029cbd63 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@ -272,12 +272,19 @@ static void subtest_multispec_usdt(void)
=20
 	/* we'll reuse usdt_100 BPF program for usdt_300 test */
 	bpf_link__destroy(skel->links.usdt_100);
+
 	skel->links.usdt_100 =3D bpf_program__attach_usdt(skel->progs.usdt_100,=
 -1, "/proc/self/exe",
 							"test", "usdt_300", NULL);
+#if __clang__ && defined(__aarch64__)
+	if (!ASSERT_OK_PTR(skel->links.usdt_100, "usdt_300_bad_attach"))
+		goto cleanup;
+	bpf_link__destroy(skel->links.usdt_100);
+#else
 	err =3D -errno;
 	if (!ASSERT_ERR_PTR(skel->links.usdt_100, "usdt_300_bad_attach"))
 		goto cleanup;
 	ASSERT_EQ(err, -E2BIG, "usdt_300_attach_err");
+#endif
=20
 	/* let's check that there are no "dangling" BPF programs attached due
 	 * to partial success of the above test:usdt_300 attachment
--=20
2.47.1


