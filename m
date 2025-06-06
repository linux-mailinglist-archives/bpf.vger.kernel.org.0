Return-Path: <bpf+bounces-59949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C680AD098F
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE2503B5F87
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 21:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC676236A79;
	Fri,  6 Jun 2025 21:31:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C501E2602
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 21:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749245471; cv=none; b=LZUZDrb/HX3O1mEbc//qdKVMc7gS/COnj5g1yJgZWfJtiGWRi///Q9dpJ95K7an32rI+AG5eP4IIl52zim2eJsoNGWCdAzduqP9ZRx+yUZhwMjyz7hDo+S1CQwNv3ezGsu3WS2G05rfftXHCf5QNSzA3uE8WMwWBN0xZfEfQMTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749245471; c=relaxed/simple;
	bh=5X4KtSXE65HbJUqdwkwuwl8cJgNXO8AWqJgsXCObhPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YcOOpIWal7mE/94fncPbSH0/fkoL04gghCoM96387JyDq7x3/438weM/W5v+izjL+6IO4HvMgLIkMP/ApURdfVrPFz64GSlbRXW+vetPcJPFTeeVN6IB0nNCU+yAfvXCyR1dxR87hRMDIelr7tAr9eqEHDYtTz5IocyqAR48CmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 47BB3906E22C; Fri,  6 Jun 2025 14:30:58 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 2/4] selftests/bpf: Fix bpf_mod_race test failure with arm64 64KB page size
Date: Fri,  6 Jun 2025 14:30:58 -0700
Message-ID: <20250606213058.340725-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250606213048.340421-1-yonghong.song@linux.dev>
References: <20250606213048.340421-1-yonghong.song@linux.dev>
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


