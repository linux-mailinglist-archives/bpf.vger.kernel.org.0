Return-Path: <bpf+bounces-59908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DB5AD07A1
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 19:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86E6017ACA4
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 17:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D5728C005;
	Fri,  6 Jun 2025 17:42:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D090A288C05
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749231723; cv=none; b=ZsF99dR+KAtW70Uwgd/RwNVGcpaIyjPl/EMdOSBCHc2O3LCOyzoZYwknfPVzayX3UwOuPBVrsCQRF2xDpYRLL3YxKMkLwE2eHZMmKvSJLUDEbgnYwFBEDxA1nodnAJ5kBXFw4Rd6or3bDv6saNchW0hg5csP/rwpLqooWg4zZDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749231723; c=relaxed/simple;
	bh=5X4KtSXE65HbJUqdwkwuwl8cJgNXO8AWqJgsXCObhPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHcJKH9rAMkF2Oubr2I08uNxDuvYGkvp0dOFtBnuj0by8ddrCD+CP6yoj9nX4SLpmfTlMB93XKpbz9XqPGKpKrNVfaDZ6NTQLqi33swJJoGmvJ3kDkxq1fp+je1feYO97OnkcixsGAY/ZfCxFXf/twNTPPwNdRCoBX43AnU/TOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 327719046D11; Fri,  6 Jun 2025 10:41:50 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 2/4] selftests/bpf: Fix bpf_mod_race test failure with arm64 64KB page size
Date: Fri,  6 Jun 2025 10:41:50 -0700
Message-ID: <20250606174150.3037178-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250606174139.3036576-1-yonghong.song@linux.dev>
References: <20250606174139.3036576-1-yonghong.song@linux.dev>
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


