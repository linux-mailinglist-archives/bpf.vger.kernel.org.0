Return-Path: <bpf+bounces-79684-lists+bpf=lfdr.de@vger.kernel.org>
Delivered-To: lists+bpf@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BW0IM3Ub2mgMQAAu9opvQ
	(envelope-from <bpf+bounces-79684-lists+bpf=lfdr.de@vger.kernel.org>)
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 20:17:33 +0100
X-Original-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6C44A290
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 20:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 66E2A58D700
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 18:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2743C1986;
	Tue, 20 Jan 2026 18:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="VKOIzjgq";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="mQD520Nb"
X-Original-To: bpf@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B194279E1;
	Tue, 20 Jan 2026 18:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768935016; cv=none; b=PiFbijRu/uhzjKR6nnMCZzFCQ2S/ZXqRR5rh2dDWXI+ORS6Q9vjcsLXZ22D7gLTg1IRY7bzYDIeHZ9h1+NLaQ0Ec100Mj8J159gROK+4XeefWp1jiUTjmD7X4pAzpTGJsYtxjiWGIhYFgqpSOLwa2w6+T1ETc9F3lJKe1+MAepc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768935016; c=relaxed/simple;
	bh=sQBJHKrap30cro4X2Ai4jsqMgrOVRDKh5aZHCOpqwLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SxDiu5+46h8dwvPb0Tb+Pocv8nAeRaprPnpc3+DIBfrdPwQ1XUZDzbYP/jWidN4Hn63EavHU8vsUeLpmYSfz/tsipTWzfgXpVbGqZYK+T2y4R7q5m+M67yegfOxWWY59X6lav5u6ZWEDJw2GzZL0oCnh4ulmBNOj9TLCLMZHPgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=VKOIzjgq; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=mQD520Nb; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1768934823; bh=yz3V5Cr9bLGhpWSl7MHOeZq
	Im+CTBlyn06rztwC9qmY=; b=VKOIzjgqhd8uvaGFtWDnsdVuZ6X/U/lOCU78VeaUkUJaeNITqI
	w06Gmqlc1FdWnJJVV+w9WNXsJ4570xsPOJ96tNU33UaY8hslQv/kZjkLP8ZLUcUszhkKV1rCCzx
	z0L8xVBJ6Mpl9KE+s5bms9rEZggUviZN7eJc5yUSDxMRkYkoF/KE7zqfJkIoBAFmad/DMYA+dnp
	OVidmuw6jNcTYW2+P1DF29rQXyPW7myQUO9zTHNmn5KfZb1Tx0p3CG2UDZ+pic/iawzwjVBlbll
	fw5jRkPOF9WQY9MaRxWArvoFqM5mljnmPKTh5IWHa08eZX8CmBIgpQ870iiniMAy2TA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1768934823; bh=yz3V5Cr9bLGhpWSl7MHOeZq
	Im+CTBlyn06rztwC9qmY=; b=mQD520NbkIjDeZNlxmO9lSKW5u3kzu3zI3aA8jGYnpzA6+A7TG
	QSgpWpztGc8UMeE+xoZ1VVtTPZgP3BI3VaAw==;
From: Daniel Hodges <git@danielhodges.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Song Liu <song@kernel.org>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Yonghong Song <yonghong.song@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Daniel Hodges <git@danielhodges.dev>
Subject: [PATCH bpf-next v5 6/7] bpf: Add signature verification kfuncs
Date: Tue, 20 Jan 2026 13:47:00 -0500
Message-ID: <20260120184701.23082-7-git@danielhodges.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120184701.23082-1-git@danielhodges.dev>
References: <20260120184701.23082-1-git@danielhodges.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[danielhodges.dev:s=202510r,danielhodges.dev:s=202510e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,meta.com,gmail.com,google.com,fomichev.me,gondor.apana.org.au,davemloft.net,vger.kernel.org,danielhodges.dev];
	TAGGED_FROM(0.00)[bounces-79684-lists,bpf=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[danielhodges.dev:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[git@danielhodges.dev,bpf@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[danielhodges.dev,reject];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[bpf];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[danielhodges.dev:email,danielhodges.dev:dkim,danielhodges.dev:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 2B6C44A290
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce bpf_sig_verify, bpf_sig_keysize, bpf_sig_digestsize,
and bpf_sig_maxsize kfuncs enabling BPF programs to verify digital
signatures using the kernel's crypto infrastructure.

This adds enum bpf_crypto_type_id for runtime type checking to ensure
operations are performed on the correct crypto context type. The enum
values are assigned to all crypto type modules (skcipher, hash, sig).

The verify kfunc takes a crypto context (initialized with the "sig"
type and appropriate algorithm like "ecdsa-nist-p256"), a message
digest, and a signature. It uses dynptr for memory access.

These kfuncs support any signature algorithm registered with the
crypto subsystem (e.g., ECDSA, RSA).

Signed-off-by: Daniel Hodges <git@danielhodges.dev>
---
 crypto/bpf_crypto_sig.c      |  22 +++++++
 crypto/bpf_crypto_skcipher.c |   1 +
 include/linux/bpf_crypto.h   |   2 +
 kernel/bpf/crypto.c          | 117 +++++++++++++++++++++++++++++++++++
 4 files changed, 142 insertions(+)

diff --git a/crypto/bpf_crypto_sig.c b/crypto/bpf_crypto_sig.c
index 1d6521a066be..2dc82c5f9abb 100644
--- a/crypto/bpf_crypto_sig.c
+++ b/crypto/bpf_crypto_sig.c
@@ -37,6 +37,25 @@ static int bpf_crypto_sig_verify(void *tfm, const u8 *sig, unsigned int sig_len,
 	return crypto_sig_verify(tfm, sig, sig_len, msg, msg_len);
 }
 
+static unsigned int bpf_crypto_sig_keysize(void *tfm)
+{
+	return crypto_sig_keysize(tfm);
+}
+
+static unsigned int bpf_crypto_sig_digestsize(void *tfm)
+{
+	struct sig_alg *alg = crypto_sig_alg(tfm);
+
+	return alg->digest_size ? alg->digest_size(tfm) : 0;
+}
+
+static unsigned int bpf_crypto_sig_maxsize(void *tfm)
+{
+	struct sig_alg *alg = crypto_sig_alg(tfm);
+
+	return alg->max_size ? alg->max_size(tfm) : 0;
+}
+
 static const struct bpf_crypto_type bpf_crypto_sig_type = {
 	.alloc_tfm	= bpf_crypto_sig_alloc_tfm,
 	.free_tfm	= bpf_crypto_sig_free_tfm,
@@ -44,6 +63,9 @@ static const struct bpf_crypto_type bpf_crypto_sig_type = {
 	.get_flags	= bpf_crypto_sig_get_flags,
 	.setkey		= bpf_crypto_sig_setkey,
 	.verify		= bpf_crypto_sig_verify,
+	.keysize	= bpf_crypto_sig_keysize,
+	.digestsize	= bpf_crypto_sig_digestsize,
+	.maxsize	= bpf_crypto_sig_maxsize,
 	.owner		= THIS_MODULE,
 	.type_id	= BPF_CRYPTO_TYPE_SIG,
 	.name		= "sig",
diff --git a/crypto/bpf_crypto_skcipher.c b/crypto/bpf_crypto_skcipher.c
index a88798d3e8c8..79d310fbcc48 100644
--- a/crypto/bpf_crypto_skcipher.c
+++ b/crypto/bpf_crypto_skcipher.c
@@ -63,6 +63,7 @@ static const struct bpf_crypto_type bpf_crypto_lskcipher_type = {
 	.statesize	= bpf_crypto_lskcipher_statesize,
 	.get_flags	= bpf_crypto_lskcipher_get_flags,
 	.owner		= THIS_MODULE,
+	.type_id	= BPF_CRYPTO_TYPE_SKCIPHER,
 	.name		= "skcipher",
 };
 
diff --git a/include/linux/bpf_crypto.h b/include/linux/bpf_crypto.h
index 363ed72561f4..e0f946926f69 100644
--- a/include/linux/bpf_crypto.h
+++ b/include/linux/bpf_crypto.h
@@ -23,6 +23,8 @@ struct bpf_crypto_type {
 	unsigned int (*ivsize)(void *tfm);
 	unsigned int (*statesize)(void *tfm);
 	unsigned int (*digestsize)(void *tfm);
+	unsigned int (*keysize)(void *tfm);
+	unsigned int (*maxsize)(void *tfm);
 	u32 (*get_flags)(void *tfm);
 	struct module *owner;
 	enum bpf_crypto_type_id type_id;
diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
index c8f354b1a2cb..6bc534cd4076 100644
--- a/kernel/bpf/crypto.c
+++ b/kernel/bpf/crypto.c
@@ -413,6 +413,117 @@ __bpf_kfunc int bpf_crypto_hash(struct bpf_crypto_ctx *ctx,
 }
 #endif /* CONFIG_CRYPTO_HASH2 */
 
+#if IS_ENABLED(CONFIG_CRYPTO_SIG2)
+/**
+ * bpf_sig_verify() - Verify digital signature using configured context
+ * @ctx:	The crypto context being used. The ctx must be a trusted pointer.
+ * @message:	bpf_dynptr to the message hash to verify. Must be a trusted pointer.
+ * @signature:	bpf_dynptr to the signature. Must be a trusted pointer.
+ *
+ * Verifies a digital signature over a message hash using the public key
+ * configured in the crypto context. Supports any signature algorithm
+ * registered with the crypto subsystem (e.g., ECDSA, RSA).
+ *
+ * Return: 0 on success (valid signature), negative error code on failure.
+ */
+__bpf_kfunc int bpf_sig_verify(struct bpf_crypto_ctx *ctx,
+				 const struct bpf_dynptr *message,
+				 const struct bpf_dynptr *signature)
+{
+	const struct bpf_dynptr_kern *msg_kern = (struct bpf_dynptr_kern *)message;
+	const struct bpf_dynptr_kern *sig_kern = (struct bpf_dynptr_kern *)signature;
+	u64 msg_len, sig_len;
+	const u8 *msg_ptr, *sig_ptr;
+
+	if (ctx->type->type_id != BPF_CRYPTO_TYPE_SIG)
+		return -EINVAL;
+
+	if (!ctx->type->verify)
+		return -EOPNOTSUPP;
+
+	msg_len = __bpf_dynptr_size(msg_kern);
+	sig_len = __bpf_dynptr_size(sig_kern);
+
+	if (msg_len == 0 || msg_len > UINT_MAX)
+		return -EINVAL;
+	if (sig_len == 0 || sig_len > UINT_MAX)
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
+	return ctx->type->verify(ctx->tfm, sig_ptr, sig_len, msg_ptr, msg_len);
+}
+
+/**
+ * bpf_sig_keysize() - Get the key size for signature context
+ * @ctx:	The crypto context being used. The ctx must be a trusted pointer.
+ *
+ * Return: The key size in bytes, or negative error code on failure.
+ */
+__bpf_kfunc int bpf_sig_keysize(struct bpf_crypto_ctx *ctx)
+{
+	if (ctx->type->type_id != BPF_CRYPTO_TYPE_SIG)
+		return -EINVAL;
+
+	if (!ctx->type->keysize)
+		return -EOPNOTSUPP;
+
+	return ctx->type->keysize(ctx->tfm);
+}
+
+/**
+ * bpf_sig_digestsize() - Get the digest size for signature context
+ * @ctx:	The crypto context being used. The ctx must be a trusted pointer.
+ *
+ * Return: The digest size in bytes, or negative error code on failure.
+ */
+__bpf_kfunc int bpf_sig_digestsize(struct bpf_crypto_ctx *ctx)
+{
+	unsigned int size;
+
+	if (ctx->type->type_id != BPF_CRYPTO_TYPE_SIG)
+		return -EINVAL;
+
+	if (!ctx->type->digestsize)
+		return -EOPNOTSUPP;
+
+	size = ctx->type->digestsize(ctx->tfm);
+	if (!size)
+		return -EOPNOTSUPP;
+
+	return size;
+}
+
+/**
+ * bpf_sig_maxsize() - Get the maximum signature size for signature context
+ * @ctx:	The crypto context being used. The ctx must be a trusted pointer.
+ *
+ * Return: The maximum signature size in bytes, or negative error code on failure.
+ */
+__bpf_kfunc int bpf_sig_maxsize(struct bpf_crypto_ctx *ctx)
+{
+	unsigned int size;
+
+	if (ctx->type->type_id != BPF_CRYPTO_TYPE_SIG)
+		return -EINVAL;
+
+	if (!ctx->type->maxsize)
+		return -EOPNOTSUPP;
+
+	size = ctx->type->maxsize(ctx->tfm);
+	if (!size)
+		return -EOPNOTSUPP;
+
+	return size;
+}
+#endif /* CONFIG_CRYPTO_SIG2 */
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(crypt_init_kfunc_btf_ids)
@@ -432,6 +543,12 @@ BTF_ID_FLAGS(func, bpf_crypto_encrypt, KF_RCU)
 #if IS_ENABLED(CONFIG_CRYPTO_HASH2)
 BTF_ID_FLAGS(func, bpf_crypto_hash, KF_RCU)
 #endif
+#if IS_ENABLED(CONFIG_CRYPTO_SIG2)
+BTF_ID_FLAGS(func, bpf_sig_verify, KF_RCU)
+BTF_ID_FLAGS(func, bpf_sig_keysize)
+BTF_ID_FLAGS(func, bpf_sig_digestsize)
+BTF_ID_FLAGS(func, bpf_sig_maxsize)
+#endif
 BTF_KFUNCS_END(crypt_kfunc_btf_ids)
 
 static const struct btf_kfunc_id_set crypt_kfunc_set = {
-- 
2.52.0


