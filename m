Return-Path: <bpf+bounces-65547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07507B254C7
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 22:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7DD49A47D4
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 20:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F512F0C55;
	Wed, 13 Aug 2025 20:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNBFjLH6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23402EBDD2;
	Wed, 13 Aug 2025 20:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755118538; cv=none; b=eTHlDvyxJKPF7A3bbmW6ZgZsBJ4N5Hb9wwDnbZxNDp63J5LXyWUsE0jfE+PEhy9sYl+mjcnge1DTkhshNnRe2xUgdjJhlbXJYhYVLfiIKTIrh6vVJn/fbmL+aGiMNLQB7qyMphiBFOnNnGcwZIOQgB1y74dLMuIJbe9SKEjq/i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755118538; c=relaxed/simple;
	bh=o+QnQXBbsNnhzc+F7XR5RGGcsAzuJwGoRpwGKKVP7iY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZYiG6BqF3Lbh6FcQT+rWMiQH3rNJPZ0yFO9Mn61uKvANwTfkVJQ7KHDw72pJc865WAz5pyFAydQYMGyIi8f90DhguISUx79RsnfZMs3i0L7qYj4ZbPfXv1Xpfqjpv7F1f5nsawIzWXb8+IzVg48WgqRUzOlfuWh9xB2YlV6pgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNBFjLH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B2DC4CEEB;
	Wed, 13 Aug 2025 20:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755118534;
	bh=o+QnQXBbsNnhzc+F7XR5RGGcsAzuJwGoRpwGKKVP7iY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QNBFjLH6XJmorVw7m/V+G+ydoKpJlWxlSi4khAVSppDyRrLoI/+lcnz9kGhOozG1I
	 ik6Na3jHYhGBdt8TTyQU6xQQauhY1vgopQfosrOIRn8F3f5MNcBqshYb2KngqY9gzd
	 Y5b1xRJS0LBKOL/TIEp7W/izdAg6TzCgO3l4BNpa+Q2DGzSYVDcyrNt+VUvBamlYdy
	 yadvJcg1myzDCK5tAgE4UcTcBw3vPm6mjLlM5ArfmdsQ/edJQKXUE8i5rzbJrPhBRA
	 ytlRVy7THEmsn5WhpqTeUL+CC7ci8KxJLtnr/elqMZgz8oUmZ9aBEqw/brbRbDaNvN
	 LAs1ANQrCqVpg==
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
Subject: [PATCH v3 01/12] bpf: Update the bpf_prog_calc_tag to use SHA256
Date: Wed, 13 Aug 2025 22:55:15 +0200
Message-ID: <20250813205526.2992911-2-kpsingh@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813205526.2992911-1-kpsingh@kernel.org>
References: <20250813205526.2992911-1-kpsingh@kernel.org>
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
index e7ee089e8a31..b98c5b5bf2a1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -31,6 +31,7 @@
 #include <linux/memcontrol.h>
 #include <linux/cfi.h>
 #include <asm/rqspinlock.h>
+#include <crypto/sha2.h>
 
 struct bpf_verifier_env;
 struct bpf_verifier_log;
@@ -1711,7 +1712,10 @@ struct bpf_prog {
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
index 1e7fd3ee759e..1bcc81ab3227 100644
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
index 5d1650af899d..d1a7ea759c82 100644
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
 
-	sha1_init_raw(digest);
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


