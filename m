Return-Path: <bpf+bounces-74803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE7EC6640E
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 22:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 923802964E
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 21:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81ED4322539;
	Mon, 17 Nov 2025 21:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="bU814iID";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="HNX6Fm+f"
X-Original-To: bpf@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5414D265621;
	Mon, 17 Nov 2025 21:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763414369; cv=none; b=Oz0su4pCRS64rvgjoUK7ps4t50BigabAii7f6OKNdRe2FTeht99keImqE3FaAuyHZo+1A6G7JcQWDOuMGjBxaHhg/7FQzVA3lvGLddeWkY4C9oowShyUjqmNqUZh5KWqdd131xFCSlLqHl7i3DvZFRViGBavraWvHaR9A3qcUHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763414369; c=relaxed/simple;
	bh=hhWsIEhg8dOWtB8beGeredqlzU4oJwOYtF0tn+8lKrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ezd5fGol+Z8/hlnDBdPVaQDzbVBmRF6/od7FlqG0lTNyadIv3xdxZOKHGn1qv/xbvjkVmDkoHjGIMy0xC5ReeXnn1ApLWzAclKb3qg0xgleZIr6krjSXrQRkQ3xhJzY1MyUa5GbfckiLi1+XDA364uliDciBuS2M7UhOkj0jztw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=bU814iID; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=HNX6Fm+f; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1763414070; bh=jl4pESYU046bgMbTdyczb4r
	/NoQlMV6hNGDcgqbnsjQ=; b=bU814iIDSN5ZPPjBkWEH8665JEDLWdRVyUtpDQ+ExigIxwspks
	JlTPLH4gvQYqFc9yvA1EqjSW6Xysf88oTbS6gxH8aXerBydqW3Y64kqtoEdESoFP2yKEQciAbuj
	k0o20hM4NP9su9GqrlDbRPbWIh9rekUIj2UtL1Qb7iqbI2LaEjn0Ec7GxZ2cNCpr19uqU0OMM0W
	nRihSCR7yUGFXC1PAhhCWJnLQ0Id46tN3kyfLw8/N/92BNSN7bIn3ApYfgCCBJLH0d3YzBZ/pLX
	Nym7UhaQNyNyzMN5Hv1z43SxGQNbJ9xEgP0UBu1HOwZhc0OMUe+O+z3itW2q/gIss0w==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1763414070; bh=jl4pESYU046bgMbTdyczb4r
	/NoQlMV6hNGDcgqbnsjQ=; b=HNX6Fm+figy6z/aWa5i5Jxu0S8IHScP3TT4pWbMkHT12SDHRiL
	iocxvlUTPGR9AOdyRXTARdlkA5ayc9Bt+nAw==;
From: Daniel Hodges <git@danielhodges.dev>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [CRYPTO]),
	linux-kernel@vger.kernel.org (open list)
Cc: Daniel Hodges <git@danielhodges.dev>
Subject: [PATCH bpf-next 1/4] bpf: Add SHA hash kfuncs for cryptographic hashing
Date: Mon, 17 Nov 2025 16:13:58 -0500
Message-ID: <20251117211413.1394-2-git@danielhodges.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117211413.1394-1-git@danielhodges.dev>
References: <20251117211413.1394-1-git@danielhodges.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add three new kfuncs for computing cryptographic hashes in BPF programs:
- bpf_sha256_hash(): Computes SHA-256 hash (32-byte output)
- bpf_sha384_hash(): Computes SHA-384 hash (48-byte output)
- bpf_sha512_hash(): Computes SHA-512 hash (64-byte output)

These kfuncs leverage the kernel's existing crypto library (sha256/sha384/
sha512 functions) and use bpf_dynptr for safe memory access without risk
of page faults. The functions validate input parameters including checking
for read-only output buffers and ensuring sufficient buffer sizes.

This enables BPF programs to compute cryptographic hashes for use cases
such as content verification, integrity checking, and data authentication.

Signed-off-by: Daniel Hodges <git@danielhodges.dev>
---
 kernel/bpf/crypto.c | 125 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 124 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
index 83c4d9943084..485972b0f858 100644
--- a/kernel/bpf/crypto.c
+++ b/kernel/bpf/crypto.c
@@ -8,7 +8,8 @@
 #include <linux/filter.h>
 #include <linux/scatterlist.h>
 #include <linux/skbuff.h>
-#include <crypto/skcipher.h>
+#include <crypto/sha2.h>
+#include <crypto/sig.h>
 
 struct bpf_crypto_type_list {
 	const struct bpf_crypto_type *type;
@@ -343,6 +344,122 @@ __bpf_kfunc int bpf_crypto_encrypt(struct bpf_crypto_ctx *ctx,
 	return bpf_crypto_crypt(ctx, src_kern, dst_kern, siv_kern, false);
 }
 
+#if IS_ENABLED(CONFIG_CRYPTO_LIB_SHA256)
+/**
+ * bpf_sha256_hash() - Compute SHA-256 hash using kernel crypto library
+ * @data: bpf_dynptr to the input data to hash. Must be a trusted pointer.
+ * @out: bpf_dynptr to the output buffer (must be at least 32 bytes). Must be a trusted pointer.
+ *
+ * Computes SHA-256 hash of the input data. Uses bpf_dynptr to ensure safe memory access
+ * without risk of page faults.
+ */
+__bpf_kfunc int bpf_sha256_hash(const struct bpf_dynptr *data, const struct bpf_dynptr *out)
+{
+	const struct bpf_dynptr_kern *data_kern = (struct bpf_dynptr_kern *)data;
+	const struct bpf_dynptr_kern *out_kern = (struct bpf_dynptr_kern *)out;
+	u32 data_len, out_len;
+	const u8 *data_ptr;
+	u8 *out_ptr;
+
+	if (__bpf_dynptr_is_rdonly(out_kern))
+		return -EINVAL;
+
+	data_len = __bpf_dynptr_size(data_kern);
+	out_len = __bpf_dynptr_size(out_kern);
+
+	if (data_len == 0 || out_len < 32)
+		return -EINVAL;
+
+	data_ptr = __bpf_dynptr_data(data_kern, data_len);
+	if (!data_ptr)
+		return -EINVAL;
+
+	out_ptr = __bpf_dynptr_data_rw(out_kern, out_len);
+	if (!out_ptr)
+		return -EINVAL;
+
+	sha256(data_ptr, data_len, out_ptr);
+
+	return 0;
+}
+
+/**
+ * bpf_sha384_hash() - Compute SHA-384 hash using kernel crypto library
+ * @data: bpf_dynptr to the input data to hash. Must be a trusted pointer.
+ * @out: bpf_dynptr to the output buffer (must be at least 48 bytes). Must be a trusted pointer.
+ *
+ * Computes SHA-384 hash of the input data. Uses bpf_dynptr to ensure safe memory access
+ * without risk of page faults.
+ */
+__bpf_kfunc int bpf_sha384_hash(const struct bpf_dynptr *data, const struct bpf_dynptr *out)
+{
+	const struct bpf_dynptr_kern *data_kern = (struct bpf_dynptr_kern *)data;
+	const struct bpf_dynptr_kern *out_kern = (struct bpf_dynptr_kern *)out;
+	u32 data_len, out_len;
+	const u8 *data_ptr;
+	u8 *out_ptr;
+
+	if (__bpf_dynptr_is_rdonly(out_kern))
+		return -EINVAL;
+
+	data_len = __bpf_dynptr_size(data_kern);
+	out_len = __bpf_dynptr_size(out_kern);
+
+	if (data_len == 0 || out_len < 48)
+		return -EINVAL;
+
+	data_ptr = __bpf_dynptr_data(data_kern, data_len);
+	if (!data_ptr)
+		return -EINVAL;
+
+	out_ptr = __bpf_dynptr_data_rw(out_kern, out_len);
+	if (!out_ptr)
+		return -EINVAL;
+
+	sha384(data_ptr, data_len, out_ptr);
+
+	return 0;
+}
+
+/**
+ * bpf_sha512_hash() - Compute SHA-512 hash using kernel crypto library
+ * @data: bpf_dynptr to the input data to hash. Must be a trusted pointer.
+ * @out: bpf_dynptr to the output buffer (must be at least 64 bytes). Must be a trusted pointer.
+ *
+ * Computes SHA-512 hash of the input data. Uses bpf_dynptr to ensure safe memory access
+ * without risk of page faults.
+ */
+__bpf_kfunc int bpf_sha512_hash(const struct bpf_dynptr *data, const struct bpf_dynptr *out)
+{
+	const struct bpf_dynptr_kern *data_kern = (struct bpf_dynptr_kern *)data;
+	const struct bpf_dynptr_kern *out_kern = (struct bpf_dynptr_kern *)out;
+	u32 data_len, out_len;
+	const u8 *data_ptr;
+	u8 *out_ptr;
+
+	if (__bpf_dynptr_is_rdonly(out_kern))
+		return -EINVAL;
+
+	data_len = __bpf_dynptr_size(data_kern);
+	out_len = __bpf_dynptr_size(out_kern);
+
+	if (data_len == 0 || out_len < 64)
+		return -EINVAL;
+
+	data_ptr = __bpf_dynptr_data(data_kern, data_len);
+	if (!data_ptr)
+		return -EINVAL;
+
+	out_ptr = __bpf_dynptr_data_rw(out_kern, out_len);
+	if (!out_ptr)
+		return -EINVAL;
+
+	sha512(data_ptr, data_len, out_ptr);
+
+	return 0;
+}
+#endif /* CONFIG_CRYPTO_LIB_SHA256 */
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(crypt_init_kfunc_btf_ids)
@@ -359,6 +476,11 @@ static const struct btf_kfunc_id_set crypt_init_kfunc_set = {
 BTF_KFUNCS_START(crypt_kfunc_btf_ids)
 BTF_ID_FLAGS(func, bpf_crypto_decrypt, KF_RCU)
 BTF_ID_FLAGS(func, bpf_crypto_encrypt, KF_RCU)
+#if IS_ENABLED(CONFIG_CRYPTO_LIB_SHA256)
+BTF_ID_FLAGS(func, bpf_sha256_hash, 0)
+BTF_ID_FLAGS(func, bpf_sha384_hash, 0)
+BTF_ID_FLAGS(func, bpf_sha512_hash, 0)
+#endif
 BTF_KFUNCS_END(crypt_kfunc_btf_ids)
 
 static const struct btf_kfunc_id_set crypt_kfunc_set = {
@@ -383,6 +505,7 @@ static int __init crypto_kfunc_init(void)
 	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &crypt_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &crypt_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &crypt_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &crypt_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
 					       &crypt_init_kfunc_set);
 	return  ret ?: register_btf_id_dtor_kfuncs(bpf_crypto_dtors,
-- 
2.51.0


