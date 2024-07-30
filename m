Return-Path: <bpf+bounces-36090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF799421B0
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 22:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65E6C1F2431D
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 20:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D6D18DF82;
	Tue, 30 Jul 2024 20:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdF8aL+o"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F224D18DF79
	for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 20:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722371981; cv=none; b=ODg93jlkD6lHYJqb/IlZmvfPYw6e/MbMCarf05k9d1G+erLkC0JEsegZN3Y0wflYLgXgYJL50F1eqo2OBUD64Hm6q0zmq+c7d06OMjMZmRUf48N8s9N9dhAiqSPHpEQylYIPG4EBhxvpmhpA5kjO5wydtKJyIgYeMobVMI3aids=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722371981; c=relaxed/simple;
	bh=L5Vw+vnTqV23U/YAvF1BJ8hsl5vO8thQWupiLEtL3t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnlsdM2GOU8TMCTi8j7WSWWe0lnUMR0+zR/tAl+7O1E1h95FZGoQe7a3XIWlFolOid+ngG/8kbwPkLpQUqVcpcq/uMWK/dX72tTUE0aHy+ps+kB6svz+E1mc6oIlCzrad1qo8u4DLA+I7BjFzfVMNJ3eq7XRxT5eAM+Lf8n0p+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdF8aL+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E189C32782;
	Tue, 30 Jul 2024 20:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722371980;
	bh=L5Vw+vnTqV23U/YAvF1BJ8hsl5vO8thQWupiLEtL3t0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cdF8aL+omLwMD7juVUd9qTLY6t8I5+wuqDBQM6vN0qVd3vJssbaT6H57XKDCpvhWT
	 BHdr0BHNHgGo1BVoybKHiQn+Gv/W5sjGXkVSmDlZIR+WQVV72ezblveJT5HZSGu6//
	 8hh3k83fVGCphdLC/DPDTE39Xk/wKQf4sjxssYJ6OUhNAVDS/CwarwoFm/n3i8f28C
	 tCK29d9yFVLjjTqf7pfb0FrQpe57Kc+qBOC1AiDG7295hAENyV6fRc2B71owh7cg+3
	 889a0VWLJAg5TFaPsoMvSmdOeNgCCeEpqGA9DG9XXIHJn39/COyaKfM7dcZE6mJQ/U
	 MwX2ScXQHjamg==
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
Subject: [PATCH v3 bpf-next 07/10] lib/buildid: don't limit .note.gnu.build-id to the first page in ELF
Date: Tue, 30 Jul 2024 13:39:11 -0700
Message-ID: <20240730203914.1182569-8-andrii@kernel.org>
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

With freader we don't need to restrict ourselves to a single page, so
let's allow ELF notes to be at any valid position with the file.

We also merge parse_build_id() and parse_build_id_buf() as now the only
difference between them is note offset overflow, which makes sense to
check in all situations.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 lib/buildid.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index 6b5558cd95bf..78cfb3048385 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -155,9 +155,8 @@ static void freader_cleanup(struct freader *r)
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
@@ -166,6 +165,10 @@ static int parse_build_id_buf(struct freader *r,
 	u32 name_sz, desc_sz;
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
-- 
2.43.0


