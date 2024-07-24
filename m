Return-Path: <bpf+bounces-35574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE15993B94E
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 00:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C471F2452B
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 22:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA4C13D882;
	Wed, 24 Jul 2024 22:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQwpSIMi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0F54D8C6
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 22:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721861557; cv=none; b=MuejeI0J4LBF73QK5+h2AyckPNH/wpY3LVNGWSs3dwAf51HCh0V0w5mIAbQ5zQj/+Wmw2tOU8h6eMcL3KoshdBs8uxag7nuDE3q1ozJFptYUTxqNXTZUnNva0kZLIuicbjKRLZ1W/GIIrGZsAMq1kHGJHLy7NN+xljbaSK/x4+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721861557; c=relaxed/simple;
	bh=ntgIIpn+tzkBcO08o2+RKeRyEZVireJUIPte90Dh4v8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfeueVRljcKLZNEOit4EXqncwD220bZpU6SG3EuI+Z1OiftgHSv4qyC2NT+nHHT/bqH7G5XfPmq1FFi/Zs5OZn+7HDdgLBtNj16QA1YWT1PJaT3JdebirVjg6ucCZgEOjDp3ZSMx6vwWQWGrJXtSXqUywHo1EVR+SJhQT1os+8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQwpSIMi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA922C32781;
	Wed, 24 Jul 2024 22:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721861556;
	bh=ntgIIpn+tzkBcO08o2+RKeRyEZVireJUIPte90Dh4v8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DQwpSIMimhn7FkBAz2vr8LNKFVUQN83+hiSazx2Qt70eqWzSTOLdzhmnRy2wauKDC
	 XprAOeoDwPz6pMgua9jNTDdtoZJnpt50jO3m0QcetBXcmIA8QAdtdsI5KaOKIjZ1AC
	 w9vkqW0aq5enF+8I1XGYtiyOYNBVO/F+V2o/u7oBAXDrbIay1V+rNz9TI4T8pfamGA
	 0/u2trA0alBnBrJLjiK+Ydm9nA3nQzoZlHqXaCoZWbNDKkQOkoDFHiL2USGDbGWZRQ
	 9YorGVDfMlYftfv7v+SXMpkIo61qyCkdZza2jvCfu6uIaes9fzSh9ctcz/3Phbjfze
	 Utnqd2yaZxa9A==
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
Subject: [PATCH v2 bpf-next 07/10] lib/buildid: harden build ID parsing logic some more
Date: Wed, 24 Jul 2024 15:52:07 -0700
Message-ID: <20240724225210.545423-8-andrii@kernel.org>
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

Harden build ID parsing logic some more, adding explicit READ_ONCE()
when fetching values that we then use to check correctness and various
note iteration invariants.

Suggested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 lib/buildid.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index 419966d88cd5..7e36a32fbb90 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -158,7 +158,7 @@ static int parse_build_id(struct freader *r, unsigned char *build_id, __u32 *siz
 	const char note_name[] = "GNU";
 	const size_t note_name_sz = sizeof(note_name);
 	u64 build_id_off, new_offs, note_end = note_offs + note_size;
-	u32 build_id_sz;
+	u32 build_id_sz, name_sz, desc_sz;
 	const Elf32_Nhdr *nhdr;
 	const char *data;
 
@@ -171,14 +171,15 @@ static int parse_build_id(struct freader *r, unsigned char *build_id, __u32 *siz
 		if (!nhdr)
 			return r->err;
 
-		if (nhdr->n_type == BUILD_ID &&
-		    nhdr->n_namesz == note_name_sz &&
-		    !strcmp((char *)(nhdr + 1), note_name) &&
-		    nhdr->n_descsz > 0 &&
-		    nhdr->n_descsz <= BUILD_ID_SIZE_MAX) {
+		name_sz = READ_ONCE(nhdr->n_namesz);
+		desc_sz = READ_ONCE(nhdr->n_descsz);
+		if (READ_ONCE(nhdr->n_type) == BUILD_ID &&
+		    name_sz == note_name_sz &&
+		    !strncmp((char *)(nhdr + 1), note_name, note_name_sz) &&
+		    desc_sz > 0 && desc_sz <= BUILD_ID_SIZE_MAX) {
 
 			build_id_off = note_offs + sizeof(Elf32_Nhdr) + ALIGN(note_name_sz, 4);
-			build_id_sz = nhdr->n_descsz;
+			build_id_sz = desc_sz;
 
 			/* freader_fetch() will invalidate nhdr pointer */
 			data = freader_fetch(r, build_id_off, build_id_sz);
@@ -192,8 +193,7 @@ static int parse_build_id(struct freader *r, unsigned char *build_id, __u32 *siz
 			return 0;
 		}
 
-		new_offs = note_offs + sizeof(Elf32_Nhdr) +
-			   ALIGN(nhdr->n_namesz, 4) + ALIGN(nhdr->n_descsz, 4);
+		new_offs = note_offs + sizeof(Elf32_Nhdr) + ALIGN(name_sz, 4) + ALIGN(desc_sz, 4);
 		if (new_offs <= note_offs)  /* overflow */
 			break;
 		note_offs = new_offs;
@@ -214,7 +214,7 @@ static int get_build_id_32(struct freader *r, unsigned char *build_id, __u32 *si
 		return r->err;
 
 	/* subsequent freader_fetch() calls invalidate pointers, so remember locally */
-	phnum = ehdr->e_phnum;
+	phnum = READ_ONCE(ehdr->e_phnum);
 	phoff = READ_ONCE(ehdr->e_phoff);
 
 	/* set upper bound on amount of segments (phdrs) we iterate */
@@ -226,8 +226,9 @@ static int get_build_id_32(struct freader *r, unsigned char *build_id, __u32 *si
 		if (!phdr)
 			return r->err;
 
-		if (phdr->p_type == PT_NOTE &&
-		    !parse_build_id(r, build_id, size, phdr->p_offset, phdr->p_filesz))
+		if (READ_ONCE(phdr->p_type) == PT_NOTE &&
+		    !parse_build_id(r, build_id, size,
+				    READ_ONCE(phdr->p_offset), READ_ONCE(phdr->p_filesz)))
 			return 0;
 	}
 	return -EINVAL;
@@ -246,7 +247,7 @@ static int get_build_id_64(struct freader *r, unsigned char *build_id, __u32 *si
 		return r->err;
 
 	/* subsequent freader_fetch() calls invalidate pointers, so remember locally */
-	phnum = ehdr->e_phnum;
+	phnum = READ_ONCE(ehdr->e_phnum);
 	phoff = READ_ONCE(ehdr->e_phoff);
 
 	/* set upper bound on amount of segments (phdrs) we iterate */
@@ -258,8 +259,9 @@ static int get_build_id_64(struct freader *r, unsigned char *build_id, __u32 *si
 		if (!phdr)
 			return r->err;
 
-		if (phdr->p_type == PT_NOTE &&
-		    !parse_build_id(r, build_id, size, phdr->p_offset, phdr->p_filesz))
+		if (READ_ONCE(phdr->p_type) == PT_NOTE &&
+		    !parse_build_id(r, build_id, size,
+				    READ_ONCE(phdr->p_offset), READ_ONCE(phdr->p_filesz)))
 			return 0;
 	}
 
-- 
2.43.0


