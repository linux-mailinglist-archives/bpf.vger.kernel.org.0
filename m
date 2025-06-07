Return-Path: <bpf+bounces-59981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 378EAAD0ADB
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 03:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D48E189330C
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 01:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227AF22FF2B;
	Sat,  7 Jun 2025 01:36:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0856E8F6B
	for <bpf@vger.kernel.org>; Sat,  7 Jun 2025 01:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749260190; cv=none; b=PuLaRQon9OxfG7eoB8E0IvhVe2rS9I6pXiu01kYo2Pn1PyKIGfv092z5oRoisneylcOTOrrJnZVHvOQjL1gH3JxU6Whcs+kJM+QVnL7ikXqGJiO8mlH8l9SkwIJLMXBqNjjuB9CF09T4VhqGIuwJ7BzS1KESavNqCJwxZjizUMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749260190; c=relaxed/simple;
	bh=5X4KtSXE65HbJUqdwkwuwl8cJgNXO8AWqJgsXCObhPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqPZhsqQ8/vVeCRM8SPridjS5l3WT0IBuH+flDUERAP5hWnMF/c+qBZLAJZXCye6ekKIrrLMk79ezEnaSD7BaS9sYsfxntKBEC526pKwghJktMhhknTOCMKBUvDoiF6xoiRZbJdWuHKzwaqZaO1/ecaMtAJmpFiR/eTwUOBT4pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id E980C909743B; Fri,  6 Jun 2025 18:36:15 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 2/4] selftests/bpf: Fix bpf_mod_race test failure with arm64 64KB page size
Date: Fri,  6 Jun 2025 18:36:15 -0700
Message-ID: <20250607013615.1551783-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250607013605.1550284-1-yonghong.song@linux.dev>
References: <20250607013605.1550284-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently, uffd_register.range.len is set to 4096 for command
'ioctl(uffd, UFFDIO_REGISTER, &uffd_register)'. For arm64 64KB page size,
the len must be 64KB size aligned as page size alignment is required.
See fs/userfaultfd.c:validate_unaligned_range().

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c b/tool=
s/testing/selftests/bpf/prog_tests/bpf_mod_race.c
index fe2c502e5089..ecc3d47919ad 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c
@@ -78,7 +78,7 @@ static int test_setup_uffd(void *fault_addr)
 	}
=20
 	uffd_register.range.start =3D (unsigned long)fault_addr;
-	uffd_register.range.len =3D 4096;
+	uffd_register.range.len =3D getpagesize();
 	uffd_register.mode =3D UFFDIO_REGISTER_MODE_MISSING;
 	if (ioctl(uffd, UFFDIO_REGISTER, &uffd_register)) {
 		close(uffd);
--=20
2.47.1


