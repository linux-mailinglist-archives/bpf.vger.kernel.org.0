Return-Path: <bpf+bounces-74802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B6FC663FF
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 22:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 60C25356346
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 21:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D58322DCB;
	Mon, 17 Nov 2025 21:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="caeLT/VN";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="kBS3PMte"
X-Original-To: bpf@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC4432277B;
	Mon, 17 Nov 2025 21:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763414246; cv=none; b=IOVD1CbS9Ag5UPIsQmXg+uwK73lWAMDA6e3yG/mQ41bJbre20u16oulbqCCpILJz95sJCBiYcEK236HnxPtwmDCCwwDVdl6Dcgq8hUYrKi6QbtIGNwC/9r+9h53Ih8ia4DqXSFpNl++otTCDCUhTesR9XyhCBTKunAw9VJN0oAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763414246; c=relaxed/simple;
	bh=q7oiqKYNeIH4V+EpznDvix0WOfT/cJu4T8CC6YGRElo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oa1iF06VEr4DFBSuogDB+2RU/GwwCGFZqicTVzuyUjooyeO0sAjvnPVT/k4UvTLHnhgeNVhred3rpMECYx8AIqltoxLeZZTf8SjUS0o9m79BIZlXgLE53KiUVBIjyqxJZhU6KLUUc0zbLBadNKt9jGTEru4+mLJSy7GrkSAM06U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=caeLT/VN; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=kBS3PMte; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1763414076; bh=iKAmdgfT4hfOLGE3sOLuEjq
	WZlOk4sWCqPdMMWGkkNM=; b=caeLT/VNptkG26BTlTxVV9qLKig70E3qYxpC7kfXRNZQThwRYt
	PUM+n9BViVkaAQV080RUOoa97QDr+O+fgwED3Yw5XOe3rFRQbko6vCVsGe7cDZQUjZu5iaL/k8+
	EyMt5k/fyoiA82PWNGzdvCULZyypHwV1BHpoUXdw4QJHWRTubpdkZdyWcBIfLknzoLIKD+uNZDl
	3mbnFf0mM7pSk4f0kSv46lYZ+CGBV48pSfSs9GTaCAfG5WFokCinm7/Y0CJh0o1IajkXxIk8+80
	u37ELJrmzoYJqJ7vfbu3EPmx17u5pf4eo08+8WL/O3/gtx9Gq4G8Z8Tnr36SRIuOllg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1763414076; bh=iKAmdgfT4hfOLGE3sOLuEjq
	WZlOk4sWCqPdMMWGkkNM=; b=kBS3PMtenX1mAF+n4yNAOHHAbkRfg9Ea5HkffgTVtQ2ot+Qvh0
	W4geKkwq/w+KnBW7Vr0x5x0wavZ6LNfZa6Bg==;
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
Subject: [PATCH bpf-next 3/4] bpf: Add ECDSA signature verification kfuncs
Date: Mon, 17 Nov 2025 16:14:00 -0500
Message-ID: <20251117211413.1394-4-git@danielhodges.dev>
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

Add context-based ECDSA signature verification kfuncs:
- bpf_ecdsa_ctx_create(): Creates reusable ECDSA context with public key
- bpf_ecdsa_verify(): Verifies signatures using the context
- bpf_ecdsa_ctx_acquire(): Increments context reference count
- bpf_ecdsa_ctx_release(): Releases context with RCU safety

The ECDSA implementation supports NIST curves (P-256, P-384, P-521) and
uses the kernel's crypto_sig API. Public keys must be in uncompressed
format (0x04 || x || y), and signatures are in r || s format.

Signed-off-by: Daniel Hodges <git@danielhodges.dev>
---
 kernel/bpf/crypto.c | 358 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 358 insertions(+)

diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
index 485972b0f858..e9a282ade788 100644
--- a/kernel/bpf/crypto.c
+++ b/kernel/bpf/crypto.c
@@ -8,6 +8,7 @@
 #include <linux/filter.h>
 #include <linux/scatterlist.h>
 #include <linux/skbuff.h>
+#include <crypto/skcipher.h>
 #include <crypto/sha2.h>
 #include <crypto/sig.h>
 
@@ -58,6 +59,21 @@ struct bpf_crypto_ctx {
 	refcount_t usage;
 };
 
+#if IS_ENABLED(CONFIG_CRYPTO_ECDSA)
+/**
+ * struct bpf_ecdsa_ctx - refcounted BPF ECDSA context structure
+ * @tfm:	The crypto_sig transform for ECDSA operations
+ * @rcu:	The RCU head used to free the context with RCU safety
+ * @usage:	Object reference counter. When the refcount goes to 0, the
+ *		memory is released with RCU safety.
+ */
+struct bpf_ecdsa_ctx {
+	struct crypto_sig *tfm;
+	struct rcu_head rcu;
+	refcount_t usage;
+};
+#endif
+
 int bpf_crypto_register_type(const struct bpf_crypto_type *type)
 {
 	struct bpf_crypto_type_list *node;
@@ -460,12 +476,332 @@ __bpf_kfunc int bpf_sha512_hash(const struct bpf_dynptr *data, const struct bpf_
 }
 #endif /* CONFIG_CRYPTO_LIB_SHA256 */
 
+#if IS_ENABLED(CONFIG_CRYPTO_ECDSA)
+/**
+ * bpf_ecdsa_ctx_create() - Create a BPF ECDSA verification context
+ * @algo_name: bpf_dynptr to the algorithm name (e.g., "p1363(ecdsa-nist-p256)")
+ * @public_key: bpf_dynptr to the public key in uncompressed format (0x04 || x || y)
+ *              Must be 65 bytes for P-256, 97 for P-384, 133 for P-521
+ * @err: Pointer to store error code on failure
+ *
+ * Creates an ECDSA verification context that can be reused for multiple
+ * signature verifications. This function uses GFP_KERNEL allocation and
+ * can only be called from sleepable BPF programs. Uses bpf_dynptr to ensure
+ * safe memory access without risk of page faults.
+ */
+__bpf_kfunc struct bpf_ecdsa_ctx *
+bpf_ecdsa_ctx_create(const struct bpf_dynptr *algo_name,
+		     const struct bpf_dynptr *public_key, int *err)
+{
+	const struct bpf_dynptr_kern *algo_kern = (struct bpf_dynptr_kern *)algo_name;
+	const struct bpf_dynptr_kern *key_kern = (struct bpf_dynptr_kern *)public_key;
+	struct bpf_ecdsa_ctx *ctx;
+	const char *algo_ptr;
+	const u8 *key_ptr;
+	u32 algo_len, key_len;
+	char algo[64];
+	int ret;
+
+	if (!err)
+		return NULL;
+
+	algo_len = __bpf_dynptr_size(algo_kern);
+	key_len = __bpf_dynptr_size(key_kern);
+
+	if (algo_len == 0 || algo_len >= sizeof(algo)) {
+		*err = -EINVAL;
+		return NULL;
+	}
+
+	if (key_len < 65) {
+		*err = -EINVAL;
+		return NULL;
+	}
+
+	algo_ptr = __bpf_dynptr_data(algo_kern, algo_len);
+	if (!algo_ptr) {
+		*err = -EINVAL;
+		return NULL;
+	}
+
+	key_ptr = __bpf_dynptr_data(key_kern, key_len);
+	if (!key_ptr) {
+		*err = -EINVAL;
+		return NULL;
+	}
+
+	if (key_ptr[0] != 0x04) {
+		*err = -EINVAL;
+		return NULL;
+	}
+
+	memcpy(algo, algo_ptr, algo_len);
+	algo[algo_len] = '\0';
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx) {
+		*err = -ENOMEM;
+		return NULL;
+	}
+
+	ctx->tfm = crypto_alloc_sig(algo, 0, 0);
+	if (IS_ERR(ctx->tfm)) {
+		*err = PTR_ERR(ctx->tfm);
+		kfree(ctx);
+		return NULL;
+	}
+
+	ret = crypto_sig_set_pubkey(ctx->tfm, key_ptr, key_len);
+	if (ret) {
+		*err = ret;
+		crypto_free_sig(ctx->tfm);
+		kfree(ctx);
+		return NULL;
+	}
+
+	refcount_set(&ctx->usage, 1);
+	*err = 0;
+	return ctx;
+}
+
+/**
+ * bpf_ecdsa_verify() - Verify ECDSA signature using pre-allocated context
+ * @ctx: ECDSA context created by bpf_ecdsa_ctx_create()
+ * @message: bpf_dynptr to the message hash to verify. Must be a trusted pointer.
+ * @signature: bpf_dynptr to the ECDSA signature in r || s format. Must be a trusted pointer.
+ *             Must be 64 bytes for P-256, 96 for P-384, 132 for P-521
+ *
+ * Verifies an ECDSA signature using a pre-allocated context. This function
+ * does not allocate memory and can be used in non-sleepable BPF programs.
+ * Uses bpf_dynptr to ensure safe memory access without risk of page faults.
+ */
+__bpf_kfunc int bpf_ecdsa_verify(struct bpf_ecdsa_ctx *ctx,
+				 const struct bpf_dynptr *message,
+				 const struct bpf_dynptr *signature)
+{
+	const struct bpf_dynptr_kern *msg_kern = (struct bpf_dynptr_kern *)message;
+	const struct bpf_dynptr_kern *sig_kern = (struct bpf_dynptr_kern *)signature;
+	const u8 *msg_ptr, *sig_ptr;
+	u32 msg_len, sig_len;
+
+	if (!ctx)
+		return -EINVAL;
+
+	msg_len = __bpf_dynptr_size(msg_kern);
+	sig_len = __bpf_dynptr_size(sig_kern);
+
+	if (msg_len == 0 || sig_len == 0)
+		return -EINVAL;
+
+	msg_ptr = __bpf_dynptr_data(msg_kern, msg_len);
+	if (!msg_ptr)
+		return -EINVAL;
+
+	sig_ptr = __bpf_dynptr_data(sig_kern, sig_len);
+	if (!sig_ptr)
+		return -EINVAL;
+
+	return crypto_sig_verify(ctx->tfm, sig_ptr, sig_len, msg_ptr, msg_len);
+}
+
+__bpf_kfunc struct bpf_ecdsa_ctx *
+bpf_ecdsa_ctx_acquire(struct bpf_ecdsa_ctx *ctx)
+{
+	if (!refcount_inc_not_zero(&ctx->usage))
+		return NULL;
+	return ctx;
+}
+
+static void ecdsa_free_cb(struct rcu_head *head)
+{
+	struct bpf_ecdsa_ctx *ctx = container_of(head, struct bpf_ecdsa_ctx, rcu);
+
+	crypto_free_sig(ctx->tfm);
+	kfree(ctx);
+}
+
+__bpf_kfunc void bpf_ecdsa_ctx_release(struct bpf_ecdsa_ctx *ctx)
+{
+	if (refcount_dec_and_test(&ctx->usage))
+		call_rcu(&ctx->rcu, ecdsa_free_cb);
+}
+
+/**
+ * bpf_ecdsa_ctx_create_with_privkey() - Create a BPF ECDSA signing context
+ * @algo_name: bpf_dynptr to the algorithm name (e.g., "p1363(ecdsa-nist-p256)")
+ * @private_key: bpf_dynptr to the private key in raw format
+ * @err: Pointer to store error code on failure
+ *
+ * Creates an ECDSA signing context that can be used for signing messages.
+ * This function uses GFP_KERNEL allocation and can only be called from
+ * sleepable BPF programs. Uses bpf_dynptr to ensure safe memory access
+ * without risk of page faults.
+ */
+__bpf_kfunc struct bpf_ecdsa_ctx *
+bpf_ecdsa_ctx_create_with_privkey(const struct bpf_dynptr *algo_name,
+				   const struct bpf_dynptr *private_key, int *err)
+{
+	const struct bpf_dynptr_kern *algo_kern = (struct bpf_dynptr_kern *)algo_name;
+	const struct bpf_dynptr_kern *key_kern = (struct bpf_dynptr_kern *)private_key;
+	struct bpf_ecdsa_ctx *ctx;
+	const char *algo_ptr;
+	const u8 *key_ptr;
+	u32 algo_len, key_len;
+	char algo[64];
+	int ret;
+
+	if (!err)
+		return NULL;
+
+	algo_len = __bpf_dynptr_size(algo_kern);
+	key_len = __bpf_dynptr_size(key_kern);
+
+	if (algo_len == 0 || algo_len >= sizeof(algo)) {
+		*err = -EINVAL;
+		return NULL;
+	}
+
+	if (key_len < 32) {
+		*err = -EINVAL;
+		return NULL;
+	}
+
+	algo_ptr = __bpf_dynptr_data(algo_kern, algo_len);
+	if (!algo_ptr) {
+		*err = -EINVAL;
+		return NULL;
+	}
+
+	key_ptr = __bpf_dynptr_data(key_kern, key_len);
+	if (!key_ptr) {
+		*err = -EINVAL;
+		return NULL;
+	}
+
+	memcpy(algo, algo_ptr, algo_len);
+	algo[algo_len] = '\0';
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx) {
+		*err = -ENOMEM;
+		return NULL;
+	}
+
+	ctx->tfm = crypto_alloc_sig(algo, 0, 0);
+	if (IS_ERR(ctx->tfm)) {
+		*err = PTR_ERR(ctx->tfm);
+		kfree(ctx);
+		return NULL;
+	}
+
+	ret = crypto_sig_set_privkey(ctx->tfm, key_ptr, key_len);
+	if (ret) {
+		*err = ret;
+		crypto_free_sig(ctx->tfm);
+		kfree(ctx);
+		return NULL;
+	}
+
+	refcount_set(&ctx->usage, 1);
+	*err = 0;
+	return ctx;
+}
+
+/**
+ * bpf_ecdsa_sign() - Sign a message using ECDSA
+ * @ctx: ECDSA context created with bpf_ecdsa_ctx_create_with_privkey()
+ * @message: bpf_dynptr to the message hash to sign. Must be a trusted pointer.
+ * @signature: bpf_dynptr to the output buffer for signature. Must be a trusted pointer.
+ *             Must be at least 64 bytes for P-256, 96 for P-384, 132 for P-521
+ *
+ * Signs a message hash using ECDSA with a pre-configured private key.
+ * The signature is returned in r || s format. Uses bpf_dynptr to ensure
+ * safe memory access without risk of page faults.
+ */
+__bpf_kfunc int bpf_ecdsa_sign(struct bpf_ecdsa_ctx *ctx,
+			       const struct bpf_dynptr *message,
+			       const struct bpf_dynptr *signature)
+{
+	const struct bpf_dynptr_kern *msg_kern = (struct bpf_dynptr_kern *)message;
+	const struct bpf_dynptr_kern *sig_kern = (struct bpf_dynptr_kern *)signature;
+	const u8 *msg_ptr;
+	u8 *sig_ptr;
+	u32 msg_len, sig_len;
+
+	if (!ctx)
+		return -EINVAL;
+
+	if (__bpf_dynptr_is_rdonly(sig_kern))
+		return -EINVAL;
+
+	msg_len = __bpf_dynptr_size(msg_kern);
+	sig_len = __bpf_dynptr_size(sig_kern);
+
+	if (msg_len == 0 || sig_len == 0)
+		return -EINVAL;
+
+	msg_ptr = __bpf_dynptr_data(msg_kern, msg_len);
+	if (!msg_ptr)
+		return -EINVAL;
+
+	sig_ptr = __bpf_dynptr_data_rw(sig_kern, sig_len);
+	if (!sig_ptr)
+		return -EINVAL;
+
+	return crypto_sig_sign(ctx->tfm, msg_ptr, msg_len, sig_ptr, sig_len);
+}
+
+/**
+ * bpf_ecdsa_keysize() - Get the key size for ECDSA context
+ * @ctx: ECDSA context
+ *
+ * Returns: Key size in bits, or negative error code on failure
+ */
+__bpf_kfunc int bpf_ecdsa_keysize(struct bpf_ecdsa_ctx *ctx)
+{
+	if (!ctx)
+		return -EINVAL;
+
+	return crypto_sig_keysize(ctx->tfm);
+}
+
+/**
+ * bpf_ecdsa_digestsize() - Get the maximum digest size for ECDSA context
+ * @ctx: ECDSA context
+ */
+__bpf_kfunc int bpf_ecdsa_digestsize(struct bpf_ecdsa_ctx *ctx)
+{
+	if (!ctx)
+		return -EINVAL;
+
+	return crypto_sig_digestsize(ctx->tfm);
+}
+
+/**
+ * bpf_ecdsa_maxsize() - Get the maximum signature size for ECDSA context
+ * @ctx: ECDSA context
+ */
+__bpf_kfunc int bpf_ecdsa_maxsize(struct bpf_ecdsa_ctx *ctx)
+{
+	if (!ctx)
+		return -EINVAL;
+
+	return crypto_sig_maxsize(ctx->tfm);
+}
+#endif /* CONFIG_CRYPTO_ECDSA */
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(crypt_init_kfunc_btf_ids)
 BTF_ID_FLAGS(func, bpf_crypto_ctx_create, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_crypto_ctx_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_crypto_ctx_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
+#if IS_ENABLED(CONFIG_CRYPTO_ECDSA)
+BTF_ID_FLAGS(func, bpf_ecdsa_ctx_create, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_ecdsa_ctx_create_with_privkey, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_ecdsa_ctx_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_ecdsa_ctx_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
+#endif
 BTF_KFUNCS_END(crypt_init_kfunc_btf_ids)
 
 static const struct btf_kfunc_id_set crypt_init_kfunc_set = {
@@ -481,6 +817,13 @@ BTF_ID_FLAGS(func, bpf_sha256_hash, 0)
 BTF_ID_FLAGS(func, bpf_sha384_hash, 0)
 BTF_ID_FLAGS(func, bpf_sha512_hash, 0)
 #endif
+#if IS_ENABLED(CONFIG_CRYPTO_ECDSA)
+BTF_ID_FLAGS(func, bpf_ecdsa_verify, 0)
+BTF_ID_FLAGS(func, bpf_ecdsa_sign, 0)
+BTF_ID_FLAGS(func, bpf_ecdsa_keysize, 0)
+BTF_ID_FLAGS(func, bpf_ecdsa_digestsize, 0)
+BTF_ID_FLAGS(func, bpf_ecdsa_maxsize, 0)
+#endif
 BTF_KFUNCS_END(crypt_kfunc_btf_ids)
 
 static const struct btf_kfunc_id_set crypt_kfunc_set = {
@@ -491,6 +834,10 @@ static const struct btf_kfunc_id_set crypt_kfunc_set = {
 BTF_ID_LIST(bpf_crypto_dtor_ids)
 BTF_ID(struct, bpf_crypto_ctx)
 BTF_ID(func, bpf_crypto_ctx_release)
+#if IS_ENABLED(CONFIG_CRYPTO_ECDSA)
+BTF_ID(struct, bpf_ecdsa_ctx)
+BTF_ID(func, bpf_ecdsa_ctx_release)
+#endif
 
 static int __init crypto_kfunc_init(void)
 {
@@ -500,6 +847,12 @@ static int __init crypto_kfunc_init(void)
 			.btf_id	      = bpf_crypto_dtor_ids[0],
 			.kfunc_btf_id = bpf_crypto_dtor_ids[1]
 		},
+#if IS_ENABLED(CONFIG_CRYPTO_ECDSA)
+		{
+			.btf_id       = bpf_crypto_dtor_ids[2],
+			.kfunc_btf_id = bpf_crypto_dtor_ids[3]
+		},
+#endif
 	};
 
 	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &crypt_kfunc_set);
@@ -508,6 +861,11 @@ static int __init crypto_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &crypt_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
 					       &crypt_init_kfunc_set);
+	/* Enable kptr pattern for TC and XDP programs */
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS,
+					       &crypt_init_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
+					       &crypt_init_kfunc_set);
 	return  ret ?: register_btf_id_dtor_kfuncs(bpf_crypto_dtors,
 						   ARRAY_SIZE(bpf_crypto_dtors),
 						   THIS_MODULE);
-- 
2.51.0


