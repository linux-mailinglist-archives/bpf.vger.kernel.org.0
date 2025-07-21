Return-Path: <bpf+bounces-63945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 269D0B0CC5D
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 23:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 595B57ADC8B
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 21:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8A923F413;
	Mon, 21 Jul 2025 21:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TW2/ebg2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6069E2222BB;
	Mon, 21 Jul 2025 21:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753132807; cv=none; b=L1J/q5wnmPVBT7U+OxcgG2A3ztk+V6gSZA80KcLTVwm86av7wtPByftC6D/OmtsyfjCBr9wzPniMxKhxKwmh1PWE2zKqrlSN44Ue7wQYUd6PnxOaYX6rouwnTymFF30ANnq/ZYkKg92LwNrPCNTAXEswH4HHEwvm9GDsbV9JBaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753132807; c=relaxed/simple;
	bh=HS6EPGfhWtK/L8mCBzBDS4SiTHs7/Apq55upmZKTeDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MScYUyL/vmmukwug+GuX+uuqw58scGRHsXtCVzzPW5sd/aYClxUlaA3RaPBTNyABDHgWGA3uH3r/fr8KOqu90R88OIOCQoyh++2S3SrJ1l88dE3plUHjhE3voiIpaqJxOl4jRFmNi6LECWK4xEG6I5TsqkPStYZyypAFI0pL0vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TW2/ebg2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3E8C4CEF5;
	Mon, 21 Jul 2025 21:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753132807;
	bh=HS6EPGfhWtK/L8mCBzBDS4SiTHs7/Apq55upmZKTeDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TW2/ebg2X5TeDIeVsFMcWSST3BVclDYS2F4gTT6H1h6BC/Xabr21ANMroKPF70EPD
	 BBM49YqhkeDoOLMkHBrZVJByvJm4+9grQpaT+0zkpIn6VSR82qM9/CWD7jk34rC+9C
	 n4Fg7Ptibd3sEeATlRyhx5IolJUbwWfmPLuUgw77KJmoP4IB4tl9pMWDfedGlfbVgn
	 MAV+tjNamqUdbtombx9/Q1U0Qyyr9lAq7m7sWYGBb8xsxacQp+OQUSLPCRFkQTzdPa
	 hAV2rKYzx3Ui99HUf3J+TYviguK87VIiT5riICd7NRLf2RVXGFhOvbPAihNMmFUK6Z
	 2hVSQ6BFkYe5w==
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
Subject: [PATCH v2 01/13] bpf: Update the bpf_prog_calc_tag to use SHA256
Date: Mon, 21 Jul 2025 23:19:46 +0200
Message-ID: <20250721211958.1881379-2-kpsingh@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721211958.1881379-1-kpsingh@kernel.org>
References: <20250721211958.1881379-1-kpsingh@kernel.org>
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
 include/linux/bpf.h    |  6 ++++-
 include/linux/filter.h |  6 -----
 kernel/bpf/Kconfig     |  2 +-
 kernel/bpf/core.c      | 50 +++++++-----------------------------------
 4 files changed, 14 insertions(+), 50 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f9cd2164ed23..06cb73df94b3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -31,6 +31,7 @@
 #include <linux/memcontrol.h>
 #include <linux/cfi.h>
 #include <asm/rqspinlock.h>
+#include <crypto/sha2.h>
 
 struct bpf_verifier_env;
 struct bpf_verifier_log;
@@ -1701,7 +1702,10 @@ struct bpf_prog {
 	enum bpf_attach_type	expected_attach_type; /* For some prog types */
 	u32			len;		/* Number of filter blocks */
 	u32			jited_len;	/* Size of jited insns in bytes */
-	u8			tag[BPF_TAG_SIZE];
+	union {
+		u8 digest[SHA256_DIGEST_SIZE];
+		u8 tag[BPF_TAG_SIZE];
+	};
 	struct bpf_prog_stats __percpu *stats;
 	int __percpu		*active;
 	unsigned int		(*bpf_func)(const void *ctx,
diff --git a/include/linux/filter.h b/include/linux/filter.h
index eca229752cbe..403bbf3320a4 100644
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
diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index 17067dcb4386..eb3de35734f0 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -3,7 +3,7 @@
 # BPF interpreter that, for example, classic socket filters depend on.
 config BPF
 	bool
-	select CRYPTO_LIB_SHA1
+	select CRYPTO_LIB_SHA256
 
 # Used by archs to tell that they support BPF JIT compiler plus which
 # flavour. Only one of the two can be selected for a specific arch since
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 61613785bdd0..b298f3726922 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -38,6 +38,7 @@
 #include <linux/bpf_mem_alloc.h>
 #include <linux/memcontrol.h>
 #include <linux/execmem.h>
+#include <crypto/sha2.h>
 
 #include <asm/barrier.h>
 #include <linux/unaligned.h>
@@ -293,28 +294,18 @@ void __bpf_prog_free(struct bpf_prog *fp)
 
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
@@ -334,34 +325,9 @@ int bpf_prog_calc_tag(struct bpf_prog *fp)
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
+	sha256((u8 *)dst, insn_size, fp->digest);
+	vfree(dst);
+	return ret;
 }
 
 static int bpf_adj_delta_to_imm(struct bpf_insn *insn, u32 pos, s32 end_old,
-- 
2.43.0


