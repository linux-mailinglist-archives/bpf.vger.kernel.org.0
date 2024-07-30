Return-Path: <bpf+bounces-36086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 102A19421AC
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 22:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4221E1C23EB0
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 20:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7231818DF82;
	Tue, 30 Jul 2024 20:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJHHNmm0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B5C1684BE
	for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 20:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722371968; cv=none; b=ceY693Z1RE5BR8hUjP5rdp/hqL+LY/yyWZ6JEQ8wWPvSmA30UZC35u7fxIDcctk8iCKcGLX9XWYHORzd/AwISiqZkokjPd4LTLQ4EijkVTzG/+kSoXF229AlR14IPmbYm9EtN33o3lDv1AymaW6KtzNDKKDbt73dVQJJLmwIrUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722371968; c=relaxed/simple;
	bh=dgztIaI7wcUufYQC2M1f2CEzPpb4qtKFeC4HcS1F34s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UF2jP7DR9bToe72/NDFHkKoPDS2KX+hGvSqG1Humi/Zs80ATnuwj1qWsoV25cqZ+lmw+qwTmSg3ARtPjymEMuQweLEkj9fiCZjFQJUIeWqIErU0qaZ7686C3cOD1ybB62MuejAMSsuE1Rz0Lqu27FDDG0ZZ4d4StOiqNx+Nydvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJHHNmm0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635DDC32782;
	Tue, 30 Jul 2024 20:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722371967;
	bh=dgztIaI7wcUufYQC2M1f2CEzPpb4qtKFeC4HcS1F34s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JJHHNmm0RMR0lI68DTZjiB1Shtq5MZ1QfO8BeQ7hc3vZ0cTdbz1Q2AR5dSLhMOT+M
	 cDHtRFjC59k8ZM/cy8Y15dooEsrwrZzCEHtkmS55Ph7HFcsfKaMHsc45mMhLpzJ//9
	 cyCsUBW1oEof2DPgCMNLwCBerVU3wAhvxwxi9uCcjylMui6/QUGx06sOMMeEEMp2zn
	 lTA3faXrcDLFlWKdnkCV+S8opQPU55ht8uQx9kel3yiQszLvmpDVwgrqDoG457104d
	 3wg83ar9DdMT7ad3I3BUyAmad/M3b48csSLAYWbtjYb1367xyI9fEOdSKgSEoPObat
	 w119lCn4clZzA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	adobriyan@gmail.com,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	ak@linux.intel.com,
	osandov@osandov.com,
	song@kernel.org,
	jannh@google.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v3 bpf-next 03/10] lib/buildid: take into account e_phoff when fetching program headers
Date: Tue, 30 Jul 2024 13:39:07 -0700
Message-ID: <20240730203914.1182569-4-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730203914.1182569-1-andrii@kernel.org>
References: <20240730203914.1182569-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current code assumption is that program (segment) headers are following
ELF header immediately. This is a common case, but is not guaranteed. So
take into account e_phoff field of the ELF header when accessing program
headers.

Reported-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 lib/buildid.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index 522850f827a5..ba453a3784d1 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -207,27 +207,22 @@ static int get_build_id_32(struct freader *r, unsigned char *build_id, __u32 *si
 	const Elf32_Ehdr *ehdr;
 	const Elf32_Phdr *phdr;
 	__u32 phnum, i;
+	__u64 phoff;
 
 	ehdr = freader_fetch(r, 0, sizeof(Elf32_Ehdr));
 	if (!ehdr)
 		return r->err;
 
-	/*
-	 * FIXME
-	 * Neither ELF spec nor ELF loader require that program headers
-	 * start immediately after ELF header.
-	 */
-	if (ehdr->e_phoff != sizeof(Elf32_Ehdr))
-		return -EINVAL;
-
 	/* subsequent freader_fetch() calls invalidate pointers, so remember locally */
 	phnum = READ_ONCE(ehdr->e_phnum);
+	phoff = READ_ONCE(ehdr->e_phoff);
+
 	/* only supports phdr that fits in one page */
 	if (phnum > (PAGE_SIZE - sizeof(Elf32_Ehdr)) / sizeof(Elf32_Phdr))
 		return -EINVAL;
 
 	for (i = 0; i < phnum; ++i) {
-		phdr = freader_fetch(r, i * sizeof(Elf32_Phdr), sizeof(Elf32_Phdr));
+		phdr = freader_fetch(r, phoff + i * sizeof(Elf32_Phdr), sizeof(Elf32_Phdr));
 		if (!phdr)
 			return r->err;
 
@@ -245,27 +240,22 @@ static int get_build_id_64(struct freader *r, unsigned char *build_id, __u32 *si
 	const Elf64_Ehdr *ehdr;
 	const Elf64_Phdr *phdr;
 	__u32 phnum, i;
+	__u64 phoff;
 
 	ehdr = freader_fetch(r, 0, sizeof(Elf64_Ehdr));
 	if (!ehdr)
 		return r->err;
 
-	/*
-	 * FIXME
-	 * Neither ELF spec nor ELF loader require that program headers
-	 * start immediately after ELF header.
-	 */
-	if (ehdr->e_phoff != sizeof(Elf64_Ehdr))
-		return -EINVAL;
-
 	/* subsequent freader_fetch() calls invalidate pointers, so remember locally */
 	phnum = READ_ONCE(ehdr->e_phnum);
+	phoff = READ_ONCE(ehdr->e_phoff);
+
 	/* only supports phdr that fits in one page */
 	if (phnum > (PAGE_SIZE - sizeof(Elf64_Ehdr)) / sizeof(Elf64_Phdr))
 		return -EINVAL;
 
 	for (i = 0; i < phnum; ++i) {
-		phdr = freader_fetch(r, i * sizeof(Elf64_Phdr), sizeof(Elf64_Phdr));
+		phdr = freader_fetch(r, phoff + i * sizeof(Elf64_Phdr), sizeof(Elf64_Phdr));
 		if (!phdr)
 			return r->err;
 
-- 
2.43.0


