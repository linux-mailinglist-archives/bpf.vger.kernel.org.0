Return-Path: <bpf+bounces-35406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEA793A464
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 18:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E77D1F23517
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 16:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF6C157E94;
	Tue, 23 Jul 2024 16:29:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96F414D2B8
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721752191; cv=none; b=qIvuPmXegkhchJSTICuQjlQm/+lOwZO2SGMNRK4uk1ea4h02tY6uM2/dmOTFAtPnXW98gUnbSIhlizfjs2eZlTlzuhZnVJLXZLeeIv0ZSeFalNp2GEBUNAAx4+w4Olb2y7tAQqXCmTewc1yD5ZrvZNIl/5171aNcI3UuLXl0GiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721752191; c=relaxed/simple;
	bh=wPy96mAFzSyXWbxGd5HyrYc+tAhLNE8c6yGsjtLJlws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjyOE1hD3HsjirHpjhF3498AeIYLABPtwdu0yJ9J/v5vILCpkPXavaWl3TR2msfcnPYqojKT6DfhVfO3zE0zQyBiHuXpmUi1owFEArXz1pWWkXCd7l0jL15izPPZ43DqRMhtfVR9xDmwtOA3yfBhoTVFRy4XzNkoR9vbSWuurXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 12A946E9B471; Tue, 23 Jul 2024 09:29:40 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v5 2/2] selftests/bpf: Add reg_bounds tests for ldsx and subreg compare
Date: Tue, 23 Jul 2024 09:29:40 -0700
Message-ID: <20240723162940.2732171-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240723162933.2731620-1-yonghong.song@linux.dev>
References: <20240723162933.2731620-1-yonghong.song@linux.dev>
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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/reg_bounds.c        | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/=
testing/selftests/bpf/prog_tests/reg_bounds.c
index eb74363f9f70..0da4225749bd 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -433,6 +433,19 @@ static struct range range_refine(enum num_t x_t, str=
uct range x, enum num_t y_t,
=20
 	y_cast =3D range_cast(y_t, x_t, y);
=20
+	/* If we know that
+	 *   - *x* is in the range of signed 32bit value, and
+	 *   - *y_cast* range is 32-bit signed non-negative
+	 * then *x* range can be improved with *y_cast* such that *x* range
+	 * is 32-bit signed non-negative. Otherwise, if the new range for *x*
+	 * allows upper 32-bit * 0xffffffff then the eventual new range for
+	 * *x* will be out of signed 32-bit range which violates the origin
+	 * *x* range.
+	 */
+	if (x_t =3D=3D S64 && y_t =3D=3D S32 && y_cast.a <=3D S32_MAX  && y_cas=
t.b <=3D S32_MAX &&
+	    (s64)x.a >=3D S32_MIN && (s64)x.b <=3D S32_MAX)
+		return range_improve(x_t, x, y_cast);
+
 	/* the case when new range knowledge, *y*, is a 32-bit subregister
 	 * range, while previous range knowledge, *x*, is a full register
 	 * 64-bit range, needs special treatment to take into account upper 32
@@ -2108,6 +2121,9 @@ static struct subtest_case crafted_cases[] =3D {
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


