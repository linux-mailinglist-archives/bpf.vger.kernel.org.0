Return-Path: <bpf+bounces-57987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AA0AB2987
	for <lists+bpf@lfdr.de>; Sun, 11 May 2025 18:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA583B39DC
	for <lists+bpf@lfdr.de>; Sun, 11 May 2025 16:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5CA25B68A;
	Sun, 11 May 2025 16:28:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5146149C53
	for <bpf@vger.kernel.org>; Sun, 11 May 2025 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746980896; cv=none; b=R4L9BfCrwaEUeTtlTGPIYDRnalPlnKITJ9/r4LEkksFwN6NPRtsqVOIzdGQVOjbB7k2VkPnMC5VpDpTCa0nCGYl7Xh/VS6Luh3rmFkUdjV5mjSjiifXhHpPZh6NSpXZunQQvVGzKoIAbqAVrJdeRbPVT42eAZ701hOBk4WRO2i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746980896; c=relaxed/simple;
	bh=7F+VoQY/PgVnFjhnSXZfpmE9AH6b1SS2NcbNsL/Jxd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYfmBiupkOiSnHN5aSjwN5D/z6PKsXgkeI5J2VRr17FtkHZA9XFUys6COTjKjb1hh6fLABHbqr+m2bTpU6vVAlPxGFWtxb5gWj1DKzZ/EOtwaOek0ZSaogK+DKJaqSA0zIOzHFpq0uII0GjVW3W/6lmxuaKGV6BCPhEjG8qP+K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id E076374BC054; Sun, 11 May 2025 09:28:03 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add a test with r10 in conditional jmp
Date: Sun, 11 May 2025 09:28:03 -0700
Message-ID: <20250511162803.281449-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250511162758.281071-1-yonghong.song@linux.dev>
References: <20250511162758.281071-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a test with r10 in conditional jmp where the test passed.
Without previous verifier change, the test will fail.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/progs/verifier_precision.c  | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/too=
ls/testing/selftests/bpf/progs/verifier_precision.c
index 2dd0d15c2678..1591635e6e93 100644
--- a/tools/testing/selftests/bpf/progs/verifier_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
@@ -178,4 +178,36 @@ __naked int state_loop_first_last_equal(void)
 	);
 }
=20
+__used __naked static void __bpf_jmp_r10(void)
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
+__naked void bpf_jmp_r10(void)
+{
+	asm volatile (
+	"r3 =3D 0 ll;"
+	"call __bpf_jmp_r10;"
+	"r0 =3D 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
 char _license[] SEC("license") =3D "GPL";
--=20
2.47.1


