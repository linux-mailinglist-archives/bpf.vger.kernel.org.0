Return-Path: <bpf+bounces-69135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF595B8DBEA
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 15:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A4733B26B6
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 13:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4CC2D7DE3;
	Sun, 21 Sep 2025 13:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwKzduc/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C2D2D73B0;
	Sun, 21 Sep 2025 13:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758461501; cv=none; b=Cvd7QT2Pu7dkFNFxv3K2l95rQS/LQL09FJA3xWT+EGfuvKRkCc4IkEEVQOIK9rHAFrExzrt8IjBNkYLb54dpWet0pEf7K5HYZ/fRjz8Mv1vIH4EwrXlKoEr7fKufB7k2zK3a7zDMz2yIfIdbOaChX4oj9Cg7Ea41ZSpYHEkLpSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758461501; c=relaxed/simple;
	bh=mVzuBM7YN1GiYFKCgsjuvP48gHWPaH9Xlg2yE5+AwIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUSOQJpAfYoXTJrXdSP237VVpSmrLF6gdO6FZ6tjCD4R3ZDiOOS02rTL8/zBMmdfmGxPjzJG5+a10tMRDRWVrM/cXi6b5Lzb/Rjbvsf1mMFSHiDx1wLzVoG93NTblZ85umU1wmAEORVAhrENI3qlu9C2nSwylj6nUm1+eUHy1kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwKzduc/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28EFC116B1;
	Sun, 21 Sep 2025 13:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758461500;
	bh=mVzuBM7YN1GiYFKCgsjuvP48gHWPaH9Xlg2yE5+AwIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KwKzduc/R9vRH4ugDQnDFi8FNXV2zFYb7AXzy1YYBNtYaesJjXeKIHjKO/DQgEl38
	 JOsHaZ8iDnSQet1uracdgZaDP9sb2e2sFGpX+22DOU+9xw8jQx6+jeGo8DUVrAzkpY
	 lmbi4dJBZAaAbDPbCHlg/aJ0QSIGcE18UmHUoeCQmoG5KxbR4+5TtuizOi66I2Ay5r
	 /1GrLDtaMxUXrYPuLS6EqnHnqbBRVC1UUNm7+FwtUP8n0TSFg+HK8Zi1aw6gnXQv28
	 IB3IGdDFlbBGYtwmR2Y9Z6uulcRITwrU5rP9oo3E0dPpgQZ9uFqGcAW+ms3bIvtg3W
	 WVE8CDQKYF8sA==
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
Subject: [PATCH v5 01/12] bpf: Update the bpf_prog_calc_tag to use SHA256
Date: Sun, 21 Sep 2025 15:31:22 +0200
Message-ID: <20250921133133.82062-2-kpsingh@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250921133133.82062-1-kpsingh@kernel.org>
References: <20250921133133.82062-1-kpsingh@kernel.org>
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
 include/linux/bpf.h | 6 +++++-
 kernel/bpf/Kconfig  | 2 +-
 kernel/bpf/core.c   | 5 ++---
 3 files changed, 8 insertions(+), 5 deletions(-)

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
index 1cda2589d4b3..9b64674df16b 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -39,6 +39,7 @@
 #include <linux/bpf_mem_alloc.h>
 #include <linux/memcontrol.h>
 #include <linux/execmem.h>
+#include <crypto/sha2.h>
 
 #include <asm/barrier.h>
 #include <linux/unaligned.h>
@@ -296,7 +297,6 @@ void __bpf_prog_free(struct bpf_prog *fp)
 int bpf_prog_calc_tag(struct bpf_prog *fp)
 {
 	size_t size = bpf_prog_insn_size(fp);
-	u8 digest[SHA1_DIGEST_SIZE];
 	struct bpf_insn *dst;
 	bool was_ld_map;
 	u32 i;
@@ -327,8 +327,7 @@ int bpf_prog_calc_tag(struct bpf_prog *fp)
 			was_ld_map = false;
 		}
 	}
-	sha1((const u8 *)dst, size, digest);
-	memcpy(fp->tag, digest, sizeof(fp->tag));
+	sha256((u8 *)dst, size, fp->digest);
 	vfree(dst);
 	return 0;
 }
-- 
2.43.0


