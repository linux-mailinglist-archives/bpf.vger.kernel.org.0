Return-Path: <bpf+bounces-34294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8CD92C4EE
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 22:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19BEB1C21A0B
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 20:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCA9187862;
	Tue,  9 Jul 2024 20:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FT3VeWnK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD6D13B7BE
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 20:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557795; cv=none; b=sxPxj2poveWII1332H5q/sBAwSVl/dEnqTc9RF0ztjBMeqzDQIHPmE5QSfUbNNVvkuDoP930F6oGp1jzMVCoJDNDGovEpFKl6zEGnkq2/4vwZZI+C7U3OTU1RtKrtgByvkk0dclN1uBNSvO6hSmEVlwG5/qT4TGGN5P4U5RHMnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557795; c=relaxed/simple;
	bh=ntgIIpn+tzkBcO08o2+RKeRyEZVireJUIPte90Dh4v8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7utkBPMXRkVujjzPtLFhPJLikSC4HORA6mxopAdGwroh1GGwd6jwOCiAmbhuhMyhdIqpCpXAj/aXBG1NIuPGp+ua0f7/y1D2Z2s2uFS2dinZdGARbfgLHh0AhNEry1aZfd4fHwxYOy/iDyl8RMMU5r3QvN0gEqK/tt8kWCA/KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FT3VeWnK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC70C3277B;
	Tue,  9 Jul 2024 20:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720557795;
	bh=ntgIIpn+tzkBcO08o2+RKeRyEZVireJUIPte90Dh4v8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FT3VeWnKtWaL7Gbbv2pnSaxMvBXc21UChw8rj1kgj/anWnhmDG4nwXOHcG+aOzxgb
	 VotIDtFAfz/XE8izfTt3S08+En+tj7Zfcw6vU8EmRqR2ssaVUwDiyBucSYBmlVUNTu
	 0i3d27DXzO+uKIVH4TKmPAdzahRpg90xGw+9Yb/MYeHAahjEF9B38Rhu2/OHQsyp78
	 MyOiFFwfoKzGK+pGBwc1paG/8eI7Esy+Vv7SsCwHmMDh5UknwSbdUdKSF9JW7mFKBH
	 STzwdtinTGuqEnzure0ARFMPb3GcBUlc/hW6nUtR+sNSg3hufnwOL2JBFQE3OnKUjr
	 yGjixGGcAaPfg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	adobriyan@gmail.com,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	ak@linux.intel.com,
	osandov@osandov.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 07/10] lib/buildid: harden build ID parsing logic some more
Date: Tue,  9 Jul 2024 13:42:42 -0700
Message-ID: <20240709204245.3847811-8-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709204245.3847811-1-andrii@kernel.org>
References: <20240709204245.3847811-1-andrii@kernel.org>
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


