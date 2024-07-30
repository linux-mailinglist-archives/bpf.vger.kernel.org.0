Return-Path: <bpf+bounces-36084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 142FE9421AA
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 22:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 467AC1C23E4F
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 20:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E221118DF87;
	Tue, 30 Jul 2024 20:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYVZiwdu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644E01684BE;
	Tue, 30 Jul 2024 20:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722371961; cv=none; b=RenskmXpniIyBpXYkhw7NHCXnLJ0/Gk6F3wlJw5axnoObmYiZQL+VxOAa5KEOKzhMaRooXnT41258SRLV1Ng5XwrzwmIsfgrH9ffGDR+9bTve2kLLhjoo7AEhGxR1C9C/fN9A1hLE4OFKvas1cuGBI8pDjhfYd2UUqY12GEQpc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722371961; c=relaxed/simple;
	bh=ZRyyWIOIJMw57Vd+3odqRxOMUMVme1VBHFLkZo7b9vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9dRuH4HG3v5QqQVTU65zTf8FFmx+ePMHUDUVYc12Yg6qqRjtEjEakqEEUxvMjytrloLZBZu7gt6ycrEf2PRUSd2mVPykwlLLRH9DBIWDJI+H2BLyud+aTFfA20zR1bR8TvKgwL8T7naG6kBI4QDO3R8cuKGVii3snU5hac990k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYVZiwdu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F30C32782;
	Tue, 30 Jul 2024 20:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722371961;
	bh=ZRyyWIOIJMw57Vd+3odqRxOMUMVme1VBHFLkZo7b9vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZYVZiwdu9FZhd7Cszk73xFZXTFp9z7q0D9Jb4gM2liZG8RTSeaBKLF/JfdS4rmEuO
	 lJ/oObjBX08TbU4zWqTbW1L+Ux1FYemOFWSHWw6ai8DvlXdvUXW10wbDb/BsHh0+V/
	 sM2vFuK77AWUPzJmjeSS2KWIweCAIAPLkCIt7Xd9+xJ0mm+9yvJw66CgP66mQoSXcr
	 WTJXklXl5GOBqey2p5ly2euAdlH3l72owAH7qaJJ3rFBOv3h2pgnWTA14wOi8logW9
	 2tnC5iWbCY3KwPibPVhI/3dNm81qxKntuy6CxlZ6XbBpTWBYI8FJx86gMqNYc9hQTy
	 CfCA6W8i3poTw==
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
	Andrii Nakryiko <andrii@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 bpf-next 01/10] lib/buildid: harden build ID parsing logic
Date: Tue, 30 Jul 2024 13:39:05 -0700
Message-ID: <20240730203914.1182569-2-andrii@kernel.org>
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

Harden build ID parsing logic, adding explicit READ_ONCE() where it's
important to have a consistent value read and validated just once.

Fixes tag below points to the code that moved this code into
lib/buildid.c, and then subsequently was used in perf subsystem, making
this code exposed to perf_event_open() users in v5.12+.

Cc: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>
Suggested-by: Andi Kleen <ak@linux.intel.com>
Fixes: bd7525dacd7e ("bpf: Move stack_map_get_build_id into lib")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 lib/buildid.c | 51 +++++++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index e02b5507418b..d21d86f6c19a 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -18,28 +18,29 @@ static int parse_build_id_buf(unsigned char *build_id,
 			      const void *note_start,
 			      Elf32_Word note_size)
 {
+	const char note_name[] = "GNU";
+	const size_t note_name_sz = sizeof(note_name);
 	Elf32_Word note_offs = 0, new_offs;
+	u32 name_sz, desc_sz;
+	const char *data;
 
 	while (note_offs + sizeof(Elf32_Nhdr) < note_size) {
 		Elf32_Nhdr *nhdr = (Elf32_Nhdr *)(note_start + note_offs);
 
+		name_sz = READ_ONCE(nhdr->n_namesz);
+		desc_sz = READ_ONCE(nhdr->n_descsz);
 		if (nhdr->n_type == BUILD_ID &&
-		    nhdr->n_namesz == sizeof("GNU") &&
-		    !strcmp((char *)(nhdr + 1), "GNU") &&
-		    nhdr->n_descsz > 0 &&
-		    nhdr->n_descsz <= BUILD_ID_SIZE_MAX) {
-			memcpy(build_id,
-			       note_start + note_offs +
-			       ALIGN(sizeof("GNU"), 4) + sizeof(Elf32_Nhdr),
-			       nhdr->n_descsz);
-			memset(build_id + nhdr->n_descsz, 0,
-			       BUILD_ID_SIZE_MAX - nhdr->n_descsz);
+		    name_sz == note_name_sz &&
+		    strcmp((char *)(nhdr + 1), note_name) == 0 &&
+		    desc_sz > 0 && desc_sz <= BUILD_ID_SIZE_MAX) {
+			data = note_start + note_offs + ALIGN(note_name_sz, 4);
+			memcpy(build_id, data, desc_sz);
+			memset(build_id + desc_sz, 0, BUILD_ID_SIZE_MAX - desc_sz);
 			if (size)
-				*size = nhdr->n_descsz;
+				*size = desc_sz;
 			return 0;
 		}
-		new_offs = note_offs + sizeof(Elf32_Nhdr) +
-			ALIGN(nhdr->n_namesz, 4) + ALIGN(nhdr->n_descsz, 4);
+		new_offs = note_offs + sizeof(Elf32_Nhdr) + ALIGN(name_sz, 4) + ALIGN(desc_sz, 4);
 		if (new_offs <= note_offs)  /* overflow */
 			break;
 		note_offs = new_offs;
@@ -71,7 +72,7 @@ static int get_build_id_32(const void *page_addr, unsigned char *build_id,
 {
 	Elf32_Ehdr *ehdr = (Elf32_Ehdr *)page_addr;
 	Elf32_Phdr *phdr;
-	int i;
+	__u32 i, phnum;
 
 	/*
 	 * FIXME
@@ -80,9 +81,10 @@ static int get_build_id_32(const void *page_addr, unsigned char *build_id,
 	 */
 	if (ehdr->e_phoff != sizeof(Elf32_Ehdr))
 		return -EINVAL;
+
+	phnum = READ_ONCE(ehdr->e_phnum);
 	/* only supports phdr that fits in one page */
-	if (ehdr->e_phnum >
-	    (PAGE_SIZE - sizeof(Elf32_Ehdr)) / sizeof(Elf32_Phdr))
+	if (phnum > (PAGE_SIZE - sizeof(Elf32_Ehdr)) / sizeof(Elf32_Phdr))
 		return -EINVAL;
 
 	phdr = (Elf32_Phdr *)(page_addr + sizeof(Elf32_Ehdr));
@@ -90,8 +92,8 @@ static int get_build_id_32(const void *page_addr, unsigned char *build_id,
 	for (i = 0; i < ehdr->e_phnum; ++i) {
 		if (phdr[i].p_type == PT_NOTE &&
 		    !parse_build_id(page_addr, build_id, size,
-				    page_addr + phdr[i].p_offset,
-				    phdr[i].p_filesz))
+				    page_addr + READ_ONCE(phdr[i].p_offset),
+				    READ_ONCE(phdr[i].p_filesz)))
 			return 0;
 	}
 	return -EINVAL;
@@ -103,7 +105,7 @@ static int get_build_id_64(const void *page_addr, unsigned char *build_id,
 {
 	Elf64_Ehdr *ehdr = (Elf64_Ehdr *)page_addr;
 	Elf64_Phdr *phdr;
-	int i;
+	__u32 i, phnum;
 
 	/*
 	 * FIXME
@@ -112,18 +114,19 @@ static int get_build_id_64(const void *page_addr, unsigned char *build_id,
 	 */
 	if (ehdr->e_phoff != sizeof(Elf64_Ehdr))
 		return -EINVAL;
+
+	phnum = READ_ONCE(ehdr->e_phnum);
 	/* only supports phdr that fits in one page */
-	if (ehdr->e_phnum >
-	    (PAGE_SIZE - sizeof(Elf64_Ehdr)) / sizeof(Elf64_Phdr))
+	if (phnum > (PAGE_SIZE - sizeof(Elf64_Ehdr)) / sizeof(Elf64_Phdr))
 		return -EINVAL;
 
 	phdr = (Elf64_Phdr *)(page_addr + sizeof(Elf64_Ehdr));
 
-	for (i = 0; i < ehdr->e_phnum; ++i) {
+	for (i = 0; i < phnum; ++i) {
 		if (phdr[i].p_type == PT_NOTE &&
 		    !parse_build_id(page_addr, build_id, size,
-				    page_addr + phdr[i].p_offset,
-				    phdr[i].p_filesz))
+				    page_addr + READ_ONCE(phdr[i].p_offset),
+				    READ_ONCE(phdr[i].p_filesz)))
 			return 0;
 	}
 	return -EINVAL;
-- 
2.43.0


