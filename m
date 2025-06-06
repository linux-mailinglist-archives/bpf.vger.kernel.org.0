Return-Path: <bpf+bounces-59966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EC1AD0A3E
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 01:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4D401741D4
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5B623F40A;
	Fri,  6 Jun 2025 23:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2kPFVqv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D92126C17;
	Fri,  6 Jun 2025 23:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749252565; cv=none; b=D0unYjuqU2UJ2n69UYr1oyiZumx9SRaF3RjswtSsloypRtzbQx9cukkuSXahK0KTp0/UctTcCw89CITWGZzJpTHe3x4dhR0diK+jU8/MtNh/4ICsb4XiMDAAGhtxHr5coonoR2n6DZH1Xk9NUt9I50aDYniHEcFa/sJSFxU/bPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749252565; c=relaxed/simple;
	bh=0T1uugVE+ggolvflgJ9UFes0+bKxR+oyOzhWZEtAkZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GW0pMpUOHIngWleRB9JghHDgvJLt0cfP3efWAv4bfmPzG+BEB0blZGcttjQckpKMmD22XMVCDHdkWFuaxyzawlklM2VmWyqDKYiRDMZKvjbR0hxbN60Gsvj3R/bnllbcHjHTxyR/W/cnQ2Ztc5KndV7Jy69OIpLtMl+sqlUKmNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2kPFVqv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B281BC4CEF2;
	Fri,  6 Jun 2025 23:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749252564;
	bh=0T1uugVE+ggolvflgJ9UFes0+bKxR+oyOzhWZEtAkZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F2kPFVqvVI6uaQM7tXSLIogNStc9VnlDWbv17s1X/NWYH6mUmJkAXf78EIOC+VKLx
	 3Tn/elvIt5TG/Ap8OLnWi5ya/DSoCk4jy8eUr1V+gmY0+XFWYG5bxwlkupfYH6qmdC
	 lqtiZC2IP1UOzhRD2BNs4/ZZ8jDMrcb8+4BFu2dhMihrBb/D2zjuQDKR1jOKTjVo6S
	 iuWuEcU6+FvoyJFIHTv2NH5/ctRIKfs7nu+dEV7gYbOVTLQvgssB+kgZ+e+fBHlOYM
	 A4QF/Aql5smx9/8b7/PT0D5QvJtgtgx8hHHEL2UuH/a3x6+ni8FsMtpr18ajrbLx7L
	 cQMNTRljO4O0g==
From: KP Singh <kpsingh@kernel.org>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: bboscaccy@linux.microsoft.com,
	paul@paul-moore.com,
	kys@microsoft.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH 02/12] bpf: Update the bpf_prog_calc_tag to use SHA256
Date: Sat,  7 Jun 2025 01:29:04 +0200
Message-ID: <20250606232914.317094-3-kpsingh@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250606232914.317094-1-kpsingh@kernel.org>
References: <20250606232914.317094-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exclusive maps restrict map access to specific programs using a hash.
The current hash used for this is SHA1, which is prone to collisions.
This patch uses SHA256, which  is more resilient against
collisions. This new hash is stored in bpf_prog and used by the verifier
to determine if a program can access a given exclusive map.

The original 64-bit tags are kept, as they are used by users as a short,
possibly colliding program identifier for non-security purposes.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/bpf.h    |  8 ++++++-
 include/linux/filter.h |  6 ------
 kernel/bpf/core.c      | 49 ++++++------------------------------------
 3 files changed, 14 insertions(+), 49 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d5ae43b36e68..77d62c74a4e7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -31,6 +31,7 @@
 #include <linux/memcontrol.h>
 #include <linux/cfi.h>
 #include <asm/rqspinlock.h>
+#include <crypto/sha2.h>
 
 struct bpf_verifier_env;
 struct bpf_verifier_log;
@@ -1669,7 +1670,12 @@ struct bpf_prog {
 	enum bpf_attach_type	expected_attach_type; /* For some prog types */
 	u32			len;		/* Number of filter blocks */
 	u32			jited_len;	/* Size of jited insns in bytes */
-	u8			tag[BPF_TAG_SIZE];
+	union {
+		u8 digest[SHA256_DIGEST_SIZE];
+		struct {
+			u8 tag[BPF_TAG_SIZE];
+		};
+	};
 	struct bpf_prog_stats __percpu *stats;
 	int __percpu		*active;
 	unsigned int		(*bpf_func)(const void *ctx,
diff --git a/include/linux/filter.h b/include/linux/filter.h
index f5cf4d35d83e..3aa33e904a4e 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -997,12 +997,6 @@ static inline u32 bpf_prog_insn_size(const struct bpf_prog *prog)
 	return prog->len * sizeof(struct bpf_insn);
 }
 
-static inline u32 bpf_prog_tag_scratch_size(const struct bpf_prog *prog)
-{
-	return round_up(bpf_prog_insn_size(prog) +
-			sizeof(__be64) + 1, SHA1_BLOCK_SIZE);
-}
-
 static inline unsigned int bpf_prog_size(unsigned int proglen)
 {
 	return max(sizeof(struct bpf_prog),
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 607d5322ef94..f280de0a306c 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -328,28 +328,18 @@ int bpf_sha256(u8 *data, size_t data_size, u8 *output_digest)
 
 int bpf_prog_calc_tag(struct bpf_prog *fp)
 {
-	const u32 bits_offset = SHA1_BLOCK_SIZE - sizeof(__be64);
-	u32 raw_size = bpf_prog_tag_scratch_size(fp);
-	u32 digest[SHA1_DIGEST_WORDS];
-	u32 ws[SHA1_WORKSPACE_WORDS];
-	u32 i, bsize, psize, blocks;
+	u32 insn_size = bpf_prog_insn_size(fp);
 	struct bpf_insn *dst;
 	bool was_ld_map;
-	u8 *raw, *todo;
-	__be32 *result;
-	__be64 *bits;
+	int i, ret = 0;
 
-	raw = vmalloc(raw_size);
-	if (!raw)
+	dst = vmalloc(insn_size);
+	if (!dst)
 		return -ENOMEM;
 
-	sha1_init(digest);
-	memset(ws, 0, sizeof(ws));
-
 	/* We need to take out the map fd for the digest calculation
 	 * since they are unstable from user space side.
 	 */
-	dst = (void *)raw;
 	for (i = 0, was_ld_map = false; i < fp->len; i++) {
 		dst[i] = fp->insnsi[i];
 		if (!was_ld_map &&
@@ -369,34 +359,9 @@ int bpf_prog_calc_tag(struct bpf_prog *fp)
 			was_ld_map = false;
 		}
 	}
-
-	psize = bpf_prog_insn_size(fp);
-	memset(&raw[psize], 0, raw_size - psize);
-	raw[psize++] = 0x80;
-
-	bsize  = round_up(psize, SHA1_BLOCK_SIZE);
-	blocks = bsize / SHA1_BLOCK_SIZE;
-	todo   = raw;
-	if (bsize - psize >= sizeof(__be64)) {
-		bits = (__be64 *)(todo + bsize - sizeof(__be64));
-	} else {
-		bits = (__be64 *)(todo + bsize + bits_offset);
-		blocks++;
-	}
-	*bits = cpu_to_be64((psize - 1) << 3);
-
-	while (blocks--) {
-		sha1_transform(digest, todo, ws);
-		todo += SHA1_BLOCK_SIZE;
-	}
-
-	result = (__force __be32 *)digest;
-	for (i = 0; i < SHA1_DIGEST_WORDS; i++)
-		result[i] = cpu_to_be32(digest[i]);
-	memcpy(fp->tag, result, sizeof(fp->tag));
-
-	vfree(raw);
-	return 0;
+	ret = bpf_sha256((u8 *)dst, insn_size, fp->digest);
+	vfree(dst);
+	return ret;
 }
 
 static int bpf_adj_delta_to_imm(struct bpf_insn *insn, u32 pos, s32 end_old,
-- 
2.43.0


