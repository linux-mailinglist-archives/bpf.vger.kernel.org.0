Return-Path: <bpf+bounces-58409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17299ABA0A3
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 18:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958F0A008D5
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 16:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8681B87F0;
	Fri, 16 May 2025 16:10:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5220D323D
	for <bpf@vger.kernel.org>; Fri, 16 May 2025 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747411849; cv=none; b=QTzD4dDj48H5GFLfR/FjJKBuR46DcuVrHyV/OoNWj4KMIPARlJaPkxtgdVJdxWyjEBm6s+BJWlW/4thjQCFQbPxtWro2djP2HWzYus/wXkeICz9cAKywfj7SbQN9s3PIOG0ECa7GtPvHA+ELrpjTRu5351eJHObqS1APTrm1NeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747411849; c=relaxed/simple;
	bh=7F+VoQY/PgVnFjhnSXZfpmE9AH6b1SS2NcbNsL/Jxd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pfTm6B/k65mmSmQHJ9GAwoaG5uTV2ls07OMp5yYQg19OFFlyrhNhm8sk5O1Z3J02bplVj16PNowGVZ0bJXYjca1CLtVNXUuwXjpEMHS3OmxhOXVkszg3+f5X3CEuEUXUCetXxdUHnp6DAbZ2yfo6aV/9EWHnr2hvqbkKR1C4bbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 3153D7932EE2; Fri, 16 May 2025 09:10:34 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add a test with r10 in conditional jmp
Date: Fri, 16 May 2025 09:10:34 -0700
Message-ID: <20250516161034.963108-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250516161029.962760-1-yonghong.song@linux.dev>
References: <20250516161029.962760-1-yonghong.song@linux.dev>
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


