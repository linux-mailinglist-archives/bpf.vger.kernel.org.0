Return-Path: <bpf+bounces-65382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E900B21659
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 22:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38DA73AECE4
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 20:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733A62D9EE4;
	Mon, 11 Aug 2025 20:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xd676GSC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9C32C21D8;
	Mon, 11 Aug 2025 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754943464; cv=none; b=A5bG0NMiPPPSfC42NULTr2wrnMNF8570/ktjTPERRoG/4vMFDPyh6AHMx9h8rdiKKbFCoyLUfuA8EdkBfpTq5gkw7ntJEZeujmKvyPd/oTRBM59XrRT6uZ83BHHUYjDXh+PjAAbuTf0zrgykXbq6VzvnNN9tTxyjhPIADi/w0cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754943464; c=relaxed/simple;
	bh=DOwmxNLZI60agFmstZolEJAAmbCBbJ+wc74CSz5vleQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MyQCG1yNSBWD+udcLfw/vVixH92w0YaY7eJSgzxQVnGebzpSoXxgXSFlKDOUXj5EWE2fuVWqz7zHsYXFMa3X7Yn1hDudvYxTZ70b639MTxMSLIF7cbdS9QWx/yk3WQI+eYeeTdyVYGXL5SEsICsL/IJivwB4ayAsCIFU/6+gGEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xd676GSC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C3BC4CEF1;
	Mon, 11 Aug 2025 20:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754943463;
	bh=DOwmxNLZI60agFmstZolEJAAmbCBbJ+wc74CSz5vleQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Xd676GSClTBFKmiUZ+BLn/TqzHYhI0mRLyIJuf9rAjC5uXrtBFGn0qnDptl1RyhWv
	 phxmHFjiRxpRMNs/CiS3Khqc+u0Op+lDwYl1gTXdDpnFurWrRh45GgLfUDhh/EKe3K
	 QGFsiN6jjbdlQ+W1Pk6Szp2fiMVUTlhN/L9+OoPILX7Qb3unImXNO4ChjjqCE6kRRc
	 8vicbgOYEZ9D4ixmRSm0lmfg6sGobaBnsthYM+Zg6+LgI4YBovRoXzabtuPsk7bpki
	 v5eoqrDY4aA1ZqWS2sWTgx1E4gNSrOw9iabFCnmSmQjMJjkNv8Y3ozzlugoiza6Mc2
	 TQdDDsxJWLuBg==
From: Eric Biggers <ebiggers@kernel.org>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: linux-crypto@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH bpf-next] bpf: Use sha1() instead of sha1_transform() in bpf_prog_calc_tag()
Date: Mon, 11 Aug 2025 13:16:15 -0700
Message-ID: <20250811201615.564461-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that there's a proper SHA-1 library API, just use that instead of
the low-level SHA-1 compression function.  This eliminates the need for
bpf_prog_calc_tag() to implement the SHA-1 padding itself.  No
functional change; the computed tags remain the same.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 include/linux/filter.h |  6 -----
 kernel/bpf/core.c      | 50 ++++++++----------------------------------
 2 files changed, 9 insertions(+), 47 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 1e7fd3ee759e0..1bcc81ab32273 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -995,16 +995,10 @@ void bpf_prog_change_xdp(struct bpf_prog *prev_prog, struct bpf_prog *prog);
 static inline u32 bpf_prog_insn_size(const struct bpf_prog *prog)
 {
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
 		   offsetof(struct bpf_prog, insns[proglen]));
 }
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 5d1650af899d0..ef01cc644a965 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -16,10 +16,11 @@
  * Andi Kleen - Fix a few bad bugs and races.
  * Kris Katterjohn - Added many additional checks in bpf_check_classic()
  */
 
 #include <uapi/linux/btf.h>
+#include <crypto/sha1.h>
 #include <linux/filter.h>
 #include <linux/skbuff.h>
 #include <linux/vmalloc.h>
 #include <linux/prandom.h>
 #include <linux/bpf.h>
@@ -291,32 +292,23 @@ void __bpf_prog_free(struct bpf_prog *fp)
 	vfree(fp);
 }
 
 int bpf_prog_calc_tag(struct bpf_prog *fp)
 {
-	const u32 bits_offset = SHA1_BLOCK_SIZE - sizeof(__be64);
-	u32 raw_size = bpf_prog_tag_scratch_size(fp);
-	u32 digest[SHA1_DIGEST_WORDS];
-	u32 ws[SHA1_WORKSPACE_WORDS];
-	u32 i, bsize, psize, blocks;
+	size_t size = bpf_prog_insn_size(fp);
+	u8 digest[SHA1_DIGEST_SIZE];
 	struct bpf_insn *dst;
 	bool was_ld_map;
-	u8 *raw, *todo;
-	__be32 *result;
-	__be64 *bits;
+	u32 i;
 
-	raw = vmalloc(raw_size);
-	if (!raw)
+	dst = vmalloc(size);
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
 		    dst[i].code == (BPF_LD | BPF_IMM | BPF_DW) &&
 		    (dst[i].src_reg == BPF_PSEUDO_MAP_FD ||
@@ -332,37 +324,13 @@ int bpf_prog_calc_tag(struct bpf_prog *fp)
 			dst[i].imm = 0;
 		} else {
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
+	sha1((const u8 *)dst, size, digest);
+	memcpy(fp->tag, digest, sizeof(fp->tag));
+	vfree(dst);
 	return 0;
 }
 
 static int bpf_adj_delta_to_imm(struct bpf_insn *insn, u32 pos, s32 end_old,
 				s32 end_new, s32 curr, const bool probe_pass)

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.50.1


