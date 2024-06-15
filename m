Return-Path: <bpf+bounces-32231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A87909957
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 19:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BDD51F22106
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 17:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED434EB37;
	Sat, 15 Jun 2024 17:46:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60391EA90
	for <bpf@vger.kernel.org>; Sat, 15 Jun 2024 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718473607; cv=none; b=BjX0mFu8LmLfWhlJ8dgLBA2TggSegzle13QQpiqC70PYJ15nf9+qF1Q8a7PjW09nE6fR+ZkNPq0z2VLSwGxSerq7WMcvBdi/5xcwsCYKTmOa6h9Y/nsNtcH3sb6CMxdrZc0OsqI8iPwe1GoimKuhOFqKDraXLlwdk5l55ucx43s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718473607; c=relaxed/simple;
	bh=82CPaoEIAPsHNbJj17Iy+FhuLgHoHFzd1cpdSkTQ59g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhnfvVmHbTJ7MySTNX089BtxUtl8df4mPL2J2TWYLIpQZ/3DygTmJWzs6FGY8lBEYTkKGKdNKrzLB1wkI8bgB3zCPzz6oY3XWwuAuzO8ctpYZvGJsrjU1KhebaAuZ6HIRDUSDNcdNCXkhY8h9iC8eIhGKoyBnt+53qJI4RN+2m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 2CDEE58024E3; Sat, 15 Jun 2024 10:46:37 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf 3/3] selftests/bpf: Add a few tests to cover
Date: Sat, 15 Jun 2024 10:46:37 -0700
Message-ID: <20240615174637.3995589-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240615174621.3994321-1-yonghong.song@linux.dev>
References: <20240615174621.3994321-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add three unit tests in verifier_movsx.c to cover
cases where missed var_off setting can cause
unexpected verification success or failure.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/progs/verifier_movsx.c      | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_movsx.c b/tools/t=
esting/selftests/bpf/progs/verifier_movsx.c
index cbb9d6714f53..028ec855587b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_movsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
@@ -224,6 +224,69 @@ l0_%=3D:							\
 	: __clobber_all);
 }
=20
+SEC("socket")
+__description("MOV32SX, S8, var_off u32_max")
+__failure __msg("infinite loop detected")
+__failure_unpriv __msg_unpriv("back-edge from insn 2 to 0")
+__naked void mov64sx_s32_varoff_1(void)
+{
+	asm volatile ("					\
+l0_%=3D:							\
+	r3 =3D *(u8 *)(r10 -387);				\
+	w7 =3D (s8)w3;					\
+	if w7 >=3D 0x2533823b goto l0_%=3D;			\
+	w0 =3D 0;						\
+	exit;						\
+"	:
+	:
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("MOV32SX, S8, var_off not u32_max, positive after s8 exten=
sion")
+__success __retval(0)
+__failure_unpriv __msg_unpriv("frame pointer is read only")
+__naked void mov64sx_s32_varoff_2(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r3 =3D r0;					\
+	r3 &=3D 0xf;					\
+	w7 =3D (s8)w3;					\
+	if w7 s>=3D 16 goto l0_%=3D;			\
+	w0 =3D 0;						\
+	exit;						\
+l0_%=3D:							\
+	r10 =3D 1;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("MOV32SX, S8, var_off not u32_max, negative after s8 exten=
sion")
+__success __retval(0)
+__failure_unpriv __msg_unpriv("frame pointer is read only")
+__naked void mov64sx_s32_varoff_3(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r3 =3D r0;					\
+	r3 &=3D 0xf;					\
+	r3 |=3D 0x80;					\
+	w7 =3D (s8)w3;					\
+	if w7 s>=3D -5 goto l0_%=3D;			\
+	w0 =3D 0;						\
+	exit;						\
+l0_%=3D:							\
+	r10 =3D 1;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 #else
=20
 SEC("socket")
--=20
2.43.0


