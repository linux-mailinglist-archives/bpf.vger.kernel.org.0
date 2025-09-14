Return-Path: <bpf+bounces-68346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CAFB56CA6
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 23:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BD5D16DDA3
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 21:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084382E6CA9;
	Sun, 14 Sep 2025 21:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGtixqhs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCB41D7E4A;
	Sun, 14 Sep 2025 21:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757886715; cv=none; b=kQUo4LntuNRLScia9qvZ4kkoeq+ZEht5JfLn9FK+3Mx6xdC3FYMrnb2xa6QlOv4g9rAYKWhZPSBMzDV4BrsoG0yvvhlDiQgWvd1doVbT5cO092ZI6yTBWIEHgZ+ygRLMnBMaRVJxwKA6X9M3VOFM+TgHJ0A8bQ8elIaFt1os9b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757886715; c=relaxed/simple;
	bh=lbccPR/69pnRwSCPq/ceTy/gr9hd7+fQJ6/NYDn/gBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CO76MIGuUmxGsJyVhI4z0JPWkcwgZ0dEadaaj1FuGfE1J2xVvyXjFesbU80WkrRr5h9Vodt/qq9wcA0IrwfzKONFM/JYwVb2SD4Y6yVmiI3XN44qXvecN6+rMh7+rHN0R5IB5HFvYUj8iuI5YtxPLAD0J9pP7RJ5YxiuXqLq/LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGtixqhs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBFAC4CEFB;
	Sun, 14 Sep 2025 21:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757886715;
	bh=lbccPR/69pnRwSCPq/ceTy/gr9hd7+fQJ6/NYDn/gBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fGtixqhsDtFE+wd1uCBGqS2raKFTOfuhTPxNmqMt4GZiZNYs3jbDIkFLmBZABq4U4
	 g0Fq7l47w0FcoJN5rWTygmEpKKSbgV3WK2YxPMcTmqhap5ghKBZQZdTI8i5OTsQjfP
	 er0sBVx7NDRjVrsvsfCexPLMf+n7VupSOvHu1E6ndjj1wr/2OHmrA4YBPEAjjWntV2
	 l+a4O80sikmyKYuAKVzMJqe9HNM7zAIJjM/mivD1q0YbAaM/DotloxcP/zuITx8VEP
	 YIqBRUDQ/F5U+S4hW7GdE+AxYiw/uylx2eb1sMh6X53QXdLjCVFMxoo8sz2HfepSol
	 4Fu9HbvvNeP3Q==
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
Subject: [PATCH v4 01/12] bpf: Update the bpf_prog_calc_tag to use SHA256
Date: Sun, 14 Sep 2025 23:51:30 +0200
Message-ID: <20250914215141.15144-2-kpsingh@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914215141.15144-1-kpsingh@kernel.org>
References: <20250914215141.15144-1-kpsingh@kernel.org>
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
 include/linux/bpf.h |  6 +++++-
 kernel/bpf/Kconfig  |  2 +-
 kernel/bpf/core.c   | 13 ++++++-------
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 41f776071ff5..d75902074bd1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -31,6 +31,7 @@
 #include <linux/memcontrol.h>
 #include <linux/cfi.h>
 #include <asm/rqspinlock.h>
+#include <crypto/sha2.h>
 
 struct bpf_verifier_env;
 struct bpf_verifier_log;
@@ -1717,7 +1718,10 @@ struct bpf_prog {
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
index 1cda2589d4b3..0b3b88084f88 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -39,6 +39,7 @@
 #include <linux/bpf_mem_alloc.h>
 #include <linux/memcontrol.h>
 #include <linux/execmem.h>
+#include <crypto/sha2.h>
 
 #include <asm/barrier.h>
 #include <linux/unaligned.h>
@@ -295,13 +296,12 @@ void __bpf_prog_free(struct bpf_prog *fp)
 
 int bpf_prog_calc_tag(struct bpf_prog *fp)
 {
-	size_t size = bpf_prog_insn_size(fp);
-	u8 digest[SHA1_DIGEST_SIZE];
+	u32 insn_size = bpf_prog_insn_size(fp);
 	struct bpf_insn *dst;
 	bool was_ld_map;
-	u32 i;
+	int i, ret = 0;
 
-	dst = vmalloc(size);
+	dst = vmalloc(insn_size);
 	if (!dst)
 		return -ENOMEM;
 
@@ -327,10 +327,9 @@ int bpf_prog_calc_tag(struct bpf_prog *fp)
 			was_ld_map = false;
 		}
 	}
-	sha1((const u8 *)dst, size, digest);
-	memcpy(fp->tag, digest, sizeof(fp->tag));
+	sha256((u8 *)dst, insn_size, fp->digest);
 	vfree(dst);
-	return 0;
+	return ret;
 }
 
 static int bpf_adj_delta_to_imm(struct bpf_insn *insn, u32 pos, s32 end_old,
-- 
2.43.0


