Return-Path: <bpf+bounces-13289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA3E7D7A96
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 04:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B76FB21321
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 02:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE08849C;
	Thu, 26 Oct 2023 02:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="YhlRHLDw"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AF6469D;
	Thu, 26 Oct 2023 02:00:08 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39858128;
	Wed, 25 Oct 2023 19:00:05 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 39PLfNvc016399;
	Wed, 25 Oct 2023 18:59:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=OZPz1Oq2LyaUZOw961SQOKp4naN5ewSkvLqajBv5OZo=;
 b=YhlRHLDw7tSocLSNlatu7lVt4UM1d8z/9m6lNwEWQWUTLgdaATA/TWzzW6NsfPz4MJ9N
 xPDUkbTXJ3KbKUXMGX2Yj7bpjFScmV0EfVOXQru0O6X3AeB5S537x05qHcWU4xg6qmsc
 0Hwb/cyY4BZ2WgR0OwDYDjVLsCg/A57Lm+WTBAB77StGFXRE4FarxI0PHZFw4SRRzxkz
 X+EzAo+okpCuFBjMrYXSKItKrhHcNOJcnUQsxNrNaJDgDXYAc24S+0CxDex5HcGedLio
 doVcHheSaz6WXPFh7Uhs0gUJJhc8lEik5zlgCtrIXDlKC5pb82GK/pTAPnPfWgGfyIKH Dw== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3ty54a4fdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 25 Oct 2023 18:59:49 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server id
 15.1.2507.34; Wed, 25 Oct 2023 18:59:46 -0700
From: Vadim Fedorenko <vadfed@meta.com>
To: Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko
	<andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko
	<mykolal@fb.com>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Vadim Fedorenko
	<vadfed@meta.com>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: [PATCH bpf-next 1/2] bpf: add skcipher API support to TC/XDP programs
Date: Wed, 25 Oct 2023 18:59:37 -0700
Message-ID: <20231026015938.276743-1-vadfed@meta.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2620:10d:c085:208::11]
X-Proofpoint-ORIG-GUID: RY2iX-rENakqTmMALOZ3NMME7fkdaggl
X-Proofpoint-GUID: RY2iX-rENakqTmMALOZ3NMME7fkdaggl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_13,2023-10-25_01,2023-05-22_02

Add crypto API support to BPF to be able to decrypt or encrypt packets
in TC/XDP BPF programs. Only symmetric key ciphers are supported for
now. Special care should be taken for initialization part of crypto algo
because crypto_alloc_sync_skcipher() doesn't work with preemtion
disabled, it can be run only in sleepable BPF program. Also async crypto
is not supported because of the very same issue - TC/XDP BPF programs
are not sleepable.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 include/linux/bpf.h   |   1 +
 kernel/bpf/Makefile   |   3 +
 kernel/bpf/crypto.c   | 278 ++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/helpers.c  |   2 +-
 kernel/bpf/verifier.c |   1 +
 5 files changed, 284 insertions(+), 1 deletion(-)
 create mode 100644 kernel/bpf/crypto.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d3c51a507508..17145738f176 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1222,6 +1222,7 @@ enum bpf_dynptr_type {
 
 int bpf_dynptr_check_size(u32 size);
 u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
+enum bpf_dynptr_type bpf_dynptr_get_type(const struct bpf_dynptr_kern *ptr);
 
 #ifdef CONFIG_BPF_JIT
 int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr);
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index f526b7573e97..e14b5834c477 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -41,6 +41,9 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_struct_ops.o
 obj-$(CONFIG_BPF_SYSCALL) += cpumask.o
 obj-${CONFIG_BPF_LSM} += bpf_lsm.o
 endif
+ifeq ($(CONFIG_CRYPTO_SKCIPHER),y)
+obj-$(CONFIG_BPF_SYSCALL) += crypto.o
+endif
 obj-$(CONFIG_BPF_PRELOAD) += preload/
 
 obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
new file mode 100644
index 000000000000..f7803a5591b0
--- /dev/null
+++ b/kernel/bpf/crypto.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2023 Meta, Inc */
+#include <linux/bpf.h>
+#include <linux/bpf_mem_alloc.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/filter.h>
+#include <linux/scatterlist.h>
+#include <linux/skbuff.h>
+#include <crypto/skcipher.h>
+
+/**
+ * struct bpf_crypto_skcipher_ctx - refcounted BPF sync skcipher context structure
+ * @tfm:	The pointer to crypto_sync_skcipher struct.
+ * @rcu:	The RCU head used to free the crypto context with RCU safety.
+ * @usage:	Object reference counter. When the refcount goes to 0, the
+ *		memory is released back to the BPF allocator, which provides
+ *		RCU safety.
+ */
+
+struct bpf_crypto_skcipher_ctx {
+	struct crypto_sync_skcipher *tfm;
+	struct rcu_head rcu;
+	refcount_t usage;
+};
+
+static struct bpf_mem_alloc bpf_crypto_ctx_ma;
+
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global kfuncs as their definitions will be in BTF");
+
+/**
+ * bpf_crypto_skcipher_ctx_create() - Create a mutable BPF crypto context.
+ *
+ * Allocates a crypto context that can be used, acquired, and released by
+ * a BPF program. The crypto context returned by this function must either
+ * be embedded in a map as a kptr, or freed with bpf_crypto_skcipher_ctx_release().
+ *
+ * bpf_crypto_skcipher_ctx_create() allocates memory using the BPF memory
+ * allocator, and will not block. It may return NULL if no memory is available.
+ * @algo: bpf_dynptr which holds string representation of algorithm.
+ * @key:  bpf_dynptr which holds cipher key to do crypto.
+ */
+__bpf_kfunc struct bpf_crypto_skcipher_ctx *
+bpf_crypto_skcipher_ctx_create(const struct bpf_dynptr_kern *algo, const struct bpf_dynptr_kern *key,
+			       int *err)
+{
+	struct bpf_crypto_skcipher_ctx *ctx;
+
+	if (__bpf_dynptr_size(algo) > CRYPTO_MAX_ALG_NAME) {
+		*err = -EINVAL;
+		return NULL;
+	}
+
+	if (!crypto_has_skcipher(algo->data, CRYPTO_ALG_TYPE_SKCIPHER, CRYPTO_ALG_TYPE_MASK)) {
+		*err = -EOPNOTSUPP;
+		return NULL;
+	}
+
+	ctx = bpf_mem_cache_alloc(&bpf_crypto_ctx_ma);
+	if (!ctx) {
+		*err = -ENOMEM;
+		return NULL;
+	}
+
+	memset(ctx, 0, sizeof(*ctx));
+
+	ctx->tfm = crypto_alloc_sync_skcipher(algo->data, 0, 0);
+	if (IS_ERR(ctx->tfm)) {
+		*err = PTR_ERR(ctx->tfm);
+		ctx->tfm = NULL;
+		goto err;
+	}
+
+	*err = crypto_sync_skcipher_setkey(ctx->tfm, key->data, __bpf_dynptr_size(key));
+	if (*err)
+		goto err;
+
+	refcount_set(&ctx->usage, 1);
+
+	return ctx;
+err:
+	if (ctx->tfm)
+		crypto_free_sync_skcipher(ctx->tfm);
+	bpf_mem_cache_free(&bpf_crypto_ctx_ma, ctx);
+
+	return NULL;
+}
+
+static void crypto_free_sync_skcipher_cb(struct rcu_head *head)
+{
+	struct bpf_crypto_skcipher_ctx *ctx;
+
+	ctx = container_of(head, struct bpf_crypto_skcipher_ctx, rcu);
+	crypto_free_sync_skcipher(ctx->tfm);
+	migrate_disable();
+	bpf_mem_cache_free(&bpf_crypto_ctx_ma, ctx);
+	migrate_enable();
+}
+
+/**
+ * bpf_crypto_skcipher_ctx_acquire() - Acquire a reference to a BPF crypto context.
+ * @ctx: The BPF crypto context being acquired. The ctx must be a trusted
+ *	     pointer.
+ *
+ * Acquires a reference to a BPF crypto context. The context returned by this function
+ * must either be embedded in a map as a kptr, or freed with
+ * bpf_crypto_skcipher_ctx_release().
+ */
+__bpf_kfunc struct bpf_crypto_skcipher_ctx *
+bpf_crypto_skcipher_ctx_acquire(struct bpf_crypto_skcipher_ctx *ctx)
+{
+	refcount_inc(&ctx->usage);
+	return ctx;
+}
+
+/**
+ * bpf_crypto_skcipher_ctx_release() - Release a previously acquired BPF crypto context.
+ * @ctx: The crypto context being released.
+ *
+ * Releases a previously acquired reference to a BPF cpumask. When the final
+ * reference of the BPF cpumask has been released, it is subsequently freed in
+ * an RCU callback in the BPF memory allocator.
+ */
+__bpf_kfunc void bpf_crypto_skcipher_ctx_release(struct bpf_crypto_skcipher_ctx *ctx)
+{
+	if (refcount_dec_and_test(&ctx->usage))
+		call_rcu(&ctx->rcu, crypto_free_sync_skcipher_cb);
+}
+
+static void *__bpf_dynptr_data_ptr(const struct bpf_dynptr_kern *ptr)
+{
+	enum bpf_dynptr_type type;
+
+	if (!ptr->data)
+		return NULL;
+
+	type = bpf_dynptr_get_type(ptr);
+
+	switch (type) {
+	case BPF_DYNPTR_TYPE_LOCAL:
+	case BPF_DYNPTR_TYPE_RINGBUF:
+		return ptr->data + ptr->offset;
+	case BPF_DYNPTR_TYPE_SKB:
+		return skb_pointer_if_linear(ptr->data, ptr->offset, __bpf_dynptr_size(ptr));
+	case BPF_DYNPTR_TYPE_XDP:
+	{
+		void *xdp_ptr = bpf_xdp_pointer(ptr->data, ptr->offset, __bpf_dynptr_size(ptr));
+		if (!IS_ERR_OR_NULL(xdp_ptr))
+			return xdp_ptr;
+
+		return NULL;
+	}
+	default:
+		WARN_ONCE(true, "unknown dynptr type %d\n", type);
+		return NULL;
+	}
+}
+
+static int bpf_crypto_skcipher_crypt(struct crypto_sync_skcipher *tfm,
+				     const struct bpf_dynptr_kern *src,
+				     struct bpf_dynptr_kern *dst,
+				     const struct bpf_dynptr_kern *iv,
+				     bool decrypt)
+{
+	struct skcipher_request *req = NULL;
+	struct scatterlist sgin, sgout;
+	int err;
+
+	if (crypto_sync_skcipher_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
+		return -EINVAL;
+
+	if (!__bpf_dynptr_size(dst) || !__bpf_dynptr_size(src))
+		return -EINVAL;
+
+	if (__bpf_dynptr_size(iv) != crypto_sync_skcipher_ivsize(tfm))
+		return -EINVAL;
+
+	req = skcipher_request_alloc(&tfm->base, GFP_ATOMIC);
+	if (!req)
+		return -ENOMEM;
+
+	sg_init_one(&sgin, __bpf_dynptr_data_ptr(src), __bpf_dynptr_size(src));
+	sg_init_one(&sgout, __bpf_dynptr_data_ptr(dst), __bpf_dynptr_size(dst));
+
+	skcipher_request_set_crypt(req, &sgin, &sgout, __bpf_dynptr_size(src),
+				   __bpf_dynptr_data_ptr(iv));
+
+	err = decrypt ? crypto_skcipher_decrypt(req) : crypto_skcipher_encrypt(req);
+
+	skcipher_request_free(req);
+
+	return err;
+}
+
+/**
+ * bpf_crypto_skcipher_decrypt() - Decrypt buffer using configured context and IV provided.
+ * @ctx:	The crypto context being used. The ctx must be a trusted pointer.
+ * @src:	bpf_dynptr to the encrypted data. Must be a trusted pointer.
+ * @dst:	bpf_dynptr to the buffer where to store the result. Must be a trusted pointer.
+ * @iv:		bpf_dynptr to IV data to be used by decryptor.
+ *
+ * Decrypts provided buffer using IV data and the crypto context. Crypto context must be configured.
+ */
+__bpf_kfunc int bpf_crypto_skcipher_decrypt(struct bpf_crypto_skcipher_ctx *ctx,
+					    const struct bpf_dynptr_kern *src,
+					    struct bpf_dynptr_kern *dst,
+					    const struct bpf_dynptr_kern *iv)
+{
+	return bpf_crypto_skcipher_crypt(ctx->tfm, src, dst, iv, true);
+}
+
+/**
+ * bpf_crypto_skcipher_encrypt() - Encrypt buffer using configured context and IV provided.
+ * @ctx:	The crypto context being used. The ctx must be a trusted pointer.
+ * @src:	bpf_dynptr to the plain data. Must be a trusted pointer.
+ * @dst:	bpf_dynptr to buffer where to store the result. Must be a trusted pointer.
+ * @iv:		bpf_dynptr to IV data to be used by decryptor.
+ *
+ * Encrypts provided buffer using IV data and the crypto context. Crypto context must be configured.
+ */
+__bpf_kfunc int bpf_crypto_skcipher_encrypt(struct bpf_crypto_skcipher_ctx *ctx,
+					    const struct bpf_dynptr_kern *src,
+					    struct bpf_dynptr_kern *dst,
+					    const struct bpf_dynptr_kern *iv)
+{
+	return bpf_crypto_skcipher_crypt(ctx->tfm, src, dst, iv, false);
+}
+
+__diag_pop();
+
+BTF_SET8_START(crypt_skcipher_init_kfunc_btf_ids)
+BTF_ID_FLAGS(func, bpf_crypto_skcipher_ctx_create, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_crypto_skcipher_ctx_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_crypto_skcipher_ctx_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
+BTF_SET8_END(crypt_skcipher_init_kfunc_btf_ids)
+
+static const struct btf_kfunc_id_set crypt_skcipher_init_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &crypt_skcipher_init_kfunc_btf_ids,
+};
+
+BTF_SET8_START(crypt_skcipher_kfunc_btf_ids)
+BTF_ID_FLAGS(func, bpf_crypto_skcipher_decrypt, KF_RCU)
+BTF_ID_FLAGS(func, bpf_crypto_skcipher_encrypt, KF_RCU)
+BTF_SET8_END(crypt_skcipher_kfunc_btf_ids)
+
+static const struct btf_kfunc_id_set crypt_skcipher_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &crypt_skcipher_kfunc_btf_ids,
+};
+
+BTF_ID_LIST(crypto_skcipher_dtor_ids)
+BTF_ID(struct, bpf_crypto_skcipher_ctx)
+BTF_ID(func, bpf_crypto_skcipher_ctx_release)
+
+static int __init crypto_skcipher_kfunc_init(void)
+{
+	int ret;
+	const struct btf_id_dtor_kfunc crypto_skcipher_dtors[] = {
+		{
+			.btf_id	      = crypto_skcipher_dtor_ids[0],
+			.kfunc_btf_id = crypto_skcipher_dtor_ids[1]
+		},
+	};
+
+	ret = bpf_mem_alloc_init(&bpf_crypto_ctx_ma, sizeof(struct bpf_crypto_skcipher_ctx), false);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &crypt_skcipher_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &crypt_skcipher_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &crypt_skcipher_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &crypt_skcipher_init_kfunc_set);
+	return  ret ?: register_btf_id_dtor_kfuncs(crypto_skcipher_dtors,
+						   ARRAY_SIZE(crypto_skcipher_dtors),
+						   THIS_MODULE);
+}
+
+late_initcall(crypto_skcipher_kfunc_init);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 62a53ebfedf9..0c2a10ff5dfd 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1444,7 +1444,7 @@ static void bpf_dynptr_set_type(struct bpf_dynptr_kern *ptr, enum bpf_dynptr_typ
 	ptr->size |= type << DYNPTR_TYPE_SHIFT;
 }
 
-static enum bpf_dynptr_type bpf_dynptr_get_type(const struct bpf_dynptr_kern *ptr)
+enum bpf_dynptr_type bpf_dynptr_get_type(const struct bpf_dynptr_kern *ptr)
 {
 	return (ptr->size & ~(DYNPTR_RDONLY_BIT)) >> DYNPTR_TYPE_SHIFT;
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb58987e4844..75d2f47ca3cb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5184,6 +5184,7 @@ BTF_ID(struct, prog_test_ref_kfunc)
 BTF_ID(struct, cgroup)
 BTF_ID(struct, bpf_cpumask)
 BTF_ID(struct, task_struct)
+BTF_ID(struct, bpf_crypto_skcipher_ctx)
 BTF_SET_END(rcu_protected_types)
 
 static bool rcu_protected_object(const struct btf *btf, u32 btf_id)
-- 
2.39.3


