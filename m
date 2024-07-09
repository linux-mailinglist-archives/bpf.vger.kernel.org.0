Return-Path: <bpf+bounces-34293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D3892C4ED
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 22:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D252D1F21C8D
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 20:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962BC18785E;
	Tue,  9 Jul 2024 20:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDy3fCoO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B464149C40
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 20:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557792; cv=none; b=KHEb3YJttT4z17xb4xPxRRl5VkO1whsOm5Zrji+/4ZnZjbqLFSTcxAtani9oU+fy8h0H/ywgAGHSKuaGygflPbefFO4OVFSlKf8oNa4OVtlc94ntDm5aF4cDxcCRwmSdvIcb8HC23s83qTSS3es2rlYmQIE19NhcOdvEQM7bCYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557792; c=relaxed/simple;
	bh=z2GiV9WjwgN2ZnoTOoBHdWopafhvx9MuPC6sEC6Crd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWS4I9JHUmwp0g2/Q8OOB62ToJKZE3oq9bHva1dwteix1X6bsU+FmQET/tDQ+HGexcY4A9f3ehiO/RrmIqsUzM7rjQjXJUAH2mA7k46o51mZtW2LGDJtDeND1gWeGU4MuTWNDhbOuqqbUxOPIwLJEAlUdi79J0SUy2XNnf4iPC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDy3fCoO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E1EC3277B;
	Tue,  9 Jul 2024 20:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720557791;
	bh=z2GiV9WjwgN2ZnoTOoBHdWopafhvx9MuPC6sEC6Crd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tDy3fCoO6SHfaItCzW9k8CB8fBKXCs1BTlMP2WzJw0Fs+wUdyGhbkQHRpAw2ChWsx
	 PRrd5MiymWcZG0I/t0RJcTbpdUHKqRfUQNjfIY4+zt0VVLsjFiTFCoPbHNyJ32cYSu
	 2mtfAkldPT3hZ03K66B/JV/pK8E+zeW4kfqqUogOk94XGfrE1siXmMecEByhGf4Qy/
	 Elrl4rMytkXAQE56K2FJjXo+rv68tM8ZnwKH1ZmesV3BwnO6vy8zo351XHmryBi/0b
	 bG2A0ILRlmFyPcKGUk+QWYQ3fg7ISLwYytUMqbfoZCVCPeD0WKHlq3pbT0fu59vPCK
	 DKtb+WC5pg2RQ==
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
Subject: [PATCH bpf-next 06/10] lib/buildid: don't limit .note.gnu.build-id to the first page in ELF
Date: Tue,  9 Jul 2024 13:42:41 -0700
Message-ID: <20240709204245.3847811-7-andrii@kernel.org>
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


