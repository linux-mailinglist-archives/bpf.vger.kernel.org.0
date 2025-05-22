Return-Path: <bpf+bounces-58712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 309EEAC03CC
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 07:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE2B1BC1426
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 05:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113D71A23B7;
	Thu, 22 May 2025 05:05:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1FE1632D7
	for <bpf@vger.kernel.org>; Thu, 22 May 2025 05:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747890337; cv=none; b=pLaiorGDxERBXJKN11mthuUtxJHamMVIkhgE/LIYixtFxpC7f7EEgbYkiP7r3eOpAJexA1zObGyPx/HowznxmnqkiNZwmqgkOSQw5Nxx3Dpc88QkW89BRZGNFnkwKXkeO2YzQTzoVDTMC/68OHJBKse4i9hHH4gSbCeGFwGD2G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747890337; c=relaxed/simple;
	bh=Xcj1eusfOr6ET9g+DonSYxFAeQfwpu8VnbjrGOAKfMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lsvahR015T2xq+hgOvqdKCZ1hGASBoL9x82PbEDXOMx/5XuIW3jVEGu4j8mzxfBYr3zpGnuX2ZtYKzNMlK0cbrvB7dOgWjdSbv0rw+UWSNHRXwtijA6mL+Kxn979/h0BGJpUxzLLi1EUX+nbBmuloK5zEtkh3Udm3jrsGNVINnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 915857F8AD47; Wed, 21 May 2025 22:02:44 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Add tests with stack ptr register in conditional jmp
Date: Wed, 21 May 2025 22:02:44 -0700
Message-ID: <20250522050244.2834992-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250522050239.2834718-1-yonghong.song@linux.dev>
References: <20250522050239.2834718-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add two tests:
  - one test has 'rX <op> r10' where rX is not r10, and
  - another test has 'rX <op> rY' where rX and rY are not r10
    but there is an early insn 'rX =3D r10'.

Without previous verifier change, both tests will fail.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/progs/verifier_precision.c  | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/too=
ls/testing/selftests/bpf/progs/verifier_precision.c
index 2dd0d15c2678..9fe5d255ee37 100644
--- a/tools/testing/selftests/bpf/progs/verifier_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
@@ -178,4 +178,57 @@ __naked int state_loop_first_last_equal(void)
 	);
 }
=20
+__used __naked static void __bpf_cond_op_r10(void)
+{
+	asm volatile (
+	"r2 =3D 2314885393468386424 ll;"
+	"goto +0;"
+	"if r2 <=3D r10 goto +3;"
+	"if r1 >=3D -1835016 goto +0;"
+	"if r2 <=3D 8 goto +0;"
+	"if r3 <=3D 0 goto +0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("8: (bd) if r2 <=3D r10 goto pc+3")
+__msg("9: (35) if r1 >=3D 0xffe3fff8 goto pc+0")
+__msg("10: (b5) if r2 <=3D 0x8 goto pc+0")
+__msg("mark_precise: frame1: last_idx 10 first_idx 0 subseq_idx -1")
+__msg("mark_precise: frame1: regs=3Dr2 stack=3D before 9: (35) if r1 >=3D=
 0xffe3fff8 goto pc+0")
+__msg("mark_precise: frame1: regs=3Dr2 stack=3D before 8: (bd) if r2 <=3D=
 r10 goto pc+3")
+__msg("mark_precise: frame1: regs=3Dr2 stack=3D before 7: (05) goto pc+0=
")
+__naked void bpf_cond_op_r10(void)
+{
+	asm volatile (
+	"r3 =3D 0 ll;"
+	"call __bpf_cond_op_r10;"
+	"r0 =3D 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("3: (bf) r3 =3D r10")
+__msg("4: (bd) if r3 <=3D r2 goto pc+1")
+__msg("5: (b5) if r2 <=3D 0x8 goto pc+2")
+__msg("mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1")
+__msg("mark_precise: frame0: regs=3Dr2 stack=3D before 4: (bd) if r3 <=3D=
 r2 goto pc+1")
+__msg("mark_precise: frame0: regs=3Dr2 stack=3D before 3: (bf) r3 =3D r1=
0")
+__naked void bpf_cond_op_not_r10(void)
+{
+	asm volatile (
+	"r0 =3D 0;"
+	"r2 =3D 2314885393468386424 ll;"
+	"r3 =3D r10;"
+	"if r3 <=3D r2 goto +1;"
+	"if r2 <=3D 8 goto +2;"
+	"r0 =3D 2 ll;"
+	"exit;"
+	::: __clobber_all);
+}
+
 char _license[] SEC("license") =3D "GPL";
--=20
2.47.1


