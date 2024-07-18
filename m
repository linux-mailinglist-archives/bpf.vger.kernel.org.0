Return-Path: <bpf+bounces-34986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B465C93479D
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 07:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1711C2171C
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 05:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF0742AA6;
	Thu, 18 Jul 2024 05:28:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B730340856
	for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 05:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721280521; cv=none; b=AcqyTqTaVQyx/15Mpj52gJele01GsnzLy4A4kG/MszahTIIoSLWKJjb+xFxnFFDBNVQoR6FgE/u4ZzJxzNsSeC/2w9FWWxR/umozNtPGqlBwBFQZL3neNMvZ7AuttLoTAcoE7S6JjBOR7fmJ3VD1FpSj+lU9AhLeh8tKUs2PcxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721280521; c=relaxed/simple;
	bh=cpr319tkZTEluoaKnYybCQfJXi7p3KKEO7BPPn4Dzug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDG1LWTr4WU06vq0Yxg+dByHRTFOE4UIgs3WG93ZKeN5a6H7NnbgnytnVhW5Wa2PJ8gsWch9tKwx6jOgluiu+zXFpcvnfxlifIXcwVk897o0DS9KsVga4WHSul3mLA5weYyzs7rGlG1qrcZWlhPUXQv7TaFHoX8msgy7MOZ5JRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 175A16B68DF3; Wed, 17 Jul 2024 22:28:27 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Add reg_bounds tests for ldsx and subreg compare
Date: Wed, 17 Jul 2024 22:28:27 -0700
Message-ID: <20240718052827.3753696-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240718052821.3753486-1-yonghong.song@linux.dev>
References: <20240718052821.3753486-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a few reg_bounds selftests to test 32/16/8-bit ldsx and subreg compar=
ison.
Without the previous patch, all added tests will fail.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/reg_bounds.c       | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/=
testing/selftests/bpf/prog_tests/reg_bounds.c
index eb74363f9f70..cd9bafe9c057 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -441,6 +441,20 @@ static struct range range_refine(enum num_t x_t, str=
uct range x, enum num_t y_t,
 	if (t_is_32(y_t) && !t_is_32(x_t)) {
 		struct range x_swap;
=20
+		/* If we know that
+		 *   - *x* is in the range of signed 32bit value
+		 *   - *y_cast* range is 32-bit sign non-negative, and
+		 * then *x* range can be narrowed to the interaction of
+		 * *x* and *y_cast*. Otherwise, if the new range for *x*
+		 * allows upper 32-bit 0xffffffff then the eventual new
+		 * range for *x* will be out of signed 32-bit range
+		 * which violates the origin *x* range.
+		 */
+		if (x_t =3D=3D S64 && y_t =3D=3D S32 &&
+		    !(y_cast.a & 0xffffffff80000000ULL) && !(y_cast.b & 0xffffffff8000=
0000) &&
+		    (long long)x.a >=3D S32_MIN && (long long)x.b <=3D S32_MAX)
+			return range_improve(x_t, x, y_cast);
+
 		/* some combinations of upper 32 bits and sign bit can lead to
 		 * invalid ranges, in such cases it's easier to detect them
 		 * after cast/swap than try to enumerate all the conditions
@@ -2108,6 +2122,9 @@ static struct subtest_case crafted_cases[] =3D {
 	{S32, U32, {(u32)S32_MIN, 0}, {0, 0}},
 	{S32, U32, {(u32)S32_MIN, 0}, {(u32)S32_MIN, (u32)S32_MIN}},
 	{S32, U32, {(u32)S32_MIN, S32_MAX}, {S32_MAX, S32_MAX}},
+	{S64, U32, {0x0, 0x1f}, {0xffffffff80000000ULL, 0x000000007fffffffULL}}=
,
+	{S64, U32, {0x0, 0x1f}, {0xffffffffffff8000ULL, 0x0000000000007fffULL}}=
,
+	{S64, U32, {0x0, 0x1f}, {0xffffffffffffff80ULL, 0x000000000000007fULL}}=
,
 };
=20
 /* Go over crafted hard-coded cases. This is fast, so we do it as part o=
f
--=20
2.43.0


