Return-Path: <bpf+bounces-35573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E9F93B94D
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 00:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465D32866E2
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 22:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB5413C683;
	Wed, 24 Jul 2024 22:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHUH9AVU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1806B13D610
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 22:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721861554; cv=none; b=CpuQlriia7VLcH0hVhVYrJSMG74wrG/mOK3vskwmnJEvGslYwwoGUayLQqG0Nj92yoj0F7qQyQzopoPRSZAYRYdYx4UfJaf8JGd9tlHetFQPhdSqNRtt2UPGtd6uCtRaNo+bkIAByjTN7LdWlqtn0OkcXo66tdz7T6H2lX3vO38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721861554; c=relaxed/simple;
	bh=z2GiV9WjwgN2ZnoTOoBHdWopafhvx9MuPC6sEC6Crd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOhTIsSps+mNV0HU/IPdRv6hMC/vDrXMbXWPKqLKXetpDaDTA7I/aB86GchZQ8C4dR0QxOlflxj1RFFExzL1WkWkVbyRXlCP/K0ovfQgMGfskLHXR/y/cd19NJ5o54nCdS3HbjbDhm4w7S83rB8OCgQb+6cEu8nuXWpmqZGV2+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHUH9AVU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788D3C32781;
	Wed, 24 Jul 2024 22:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721861553;
	bh=z2GiV9WjwgN2ZnoTOoBHdWopafhvx9MuPC6sEC6Crd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iHUH9AVUcEK7NLYHGspPRaMdC8HeusUjt3LTsHRjp9gWWo4MPW4MgLl2MGu3YDiIs
	 xVyIwtqGyMCbLdQyVaoad66Nd0AA9SZ+DyPte034LGtLR7fMFcHhOKt8yV5Pi1zHCV
	 7NIF+N1Jgy1otd8xqT8YO1nsRgn33w2pwuxtxCiWzVy/AyvV5kCs5GbNH9l7iEojsQ
	 0mBTpOZrMJlWbOXIk690QI2WW2TOrsWw9b4/lRTZgE4+q/bMAR3EsUPnO8vFWkD80U
	 3kWPgDLeUtEvxJnjxMcMrqxANgHr5nvlHIwutDewpDBIRh5kCeXTbwsPo0/iF5oCME
	 rrEf7fiznF4RQ==
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
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 bpf-next 06/10] lib/buildid: don't limit .note.gnu.build-id to the first page in ELF
Date: Wed, 24 Jul 2024 15:52:06 -0700
Message-ID: <20240724225210.545423-7-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240724225210.545423-1-andrii@kernel.org>
References: <20240724225210.545423-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With freader we don't need to restrict ourselves to a single page, so
let's allow ELF notes to be at any valid position with the file.

We also merge parse_build_id() and parse_build_id_buf() as now the only
difference between them is note offset overflow, which makes sense to
check in all situations.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 lib/buildid.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index 23bfc811981a..419966d88cd5 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -152,9 +152,8 @@ static void freader_cleanup(struct freader *r)
  * 32-bit and 64-bit system, because Elf32_Nhdr and Elf64_Nhdr are
  * identical.
  */
-static int parse_build_id_buf(struct freader *r,
-			      unsigned char *build_id, __u32 *size,
-			      u64 note_offs, Elf32_Word note_size)
+static int parse_build_id(struct freader *r, unsigned char *build_id, __u32 *size,
+			  u64 note_offs, Elf32_Word note_size)
 {
 	const char note_name[] = "GNU";
 	const size_t note_name_sz = sizeof(note_name);
@@ -163,6 +162,10 @@ static int parse_build_id_buf(struct freader *r,
 	const Elf32_Nhdr *nhdr;
 	const char *data;
 
+	/* check for overflow */
+	if (note_offs + note_size < note_offs)
+		return -EINVAL;
+
 	while (note_offs + sizeof(Elf32_Nhdr) < note_end) {
 		nhdr = freader_fetch(r, note_offs, sizeof(Elf32_Nhdr) + note_name_sz);
 		if (!nhdr)
@@ -199,23 +202,6 @@ static int parse_build_id_buf(struct freader *r,
 	return -EINVAL;
 }
 
-static inline int parse_build_id(struct freader *r,
-				 unsigned char *build_id,
-				 __u32 *size,
-				 u64 note_start_off,
-				 Elf32_Word note_size)
-{
-	/* check for overflow */
-	if (note_start_off + note_size < note_start_off)
-		return -EINVAL;
-
-	/* only supports note that fits in the first page */
-	if (note_start_off + note_size > PAGE_SIZE)
-		return -EINVAL;
-
-	return parse_build_id_buf(r, build_id, size, note_start_off, note_size);
-}
-
 /* Parse build ID from 32-bit ELF */
 static int get_build_id_32(struct freader *r, unsigned char *build_id, __u32 *size)
 {
@@ -369,7 +355,7 @@ int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size)
 
 	freader_init_from_mem(&r, buf, buf_size);
 
-	return parse_build_id_buf(&r, build_id, NULL, 0, buf_size);
+	return parse_build_id(&r, build_id, NULL, 0, buf_size);
 }
 
 #if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) || IS_ENABLED(CONFIG_VMCORE_INFO)
-- 
2.43.0


