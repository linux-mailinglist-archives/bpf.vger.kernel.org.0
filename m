Return-Path: <bpf+bounces-14798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D0A7E83DC
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 21:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA61B281412
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 20:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C033B2B6;
	Fri, 10 Nov 2023 20:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="fYfjiQYF"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019451D68D;
	Fri, 10 Nov 2023 20:35:30 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D788E185;
	Fri, 10 Nov 2023 12:35:28 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAH7gAp023574;
	Fri, 10 Nov 2023 12:35:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=YtGS36oBZ1DBwYOqMss0EAO1hpi8EZJUJ2jcThnDfzI=;
 b=fYfjiQYFShd/aUEi0/T1KFzLY8KapYdxGLPtwK/DdrSBR8kgfq9OBIdtPJR5XYfZQj2m
 WUL6aigJlU7sKnHcGiXKn51/2mfT7yn+1vkxeGlhww4b082fApeV6JKLU+deJZ04f8C8
 0mlhWFl8AdqbmsKyy6ga76fQyxufX2gEkPa2YwEnDkPBpDqqPAFqC4GaA3lA1q1fP74y
 mVB2c6ySP+KwxyEw7OIr+0+jB5bwyv8TrBwniqzUiZHyl3rRHs29zMx9WBzLuzIJFi7t
 Q8imq40my1aAdX0Mj39vJs6zkym/LsifN+4sFHwW1nGmU7tfAT278HZIG3F8UmGgCCmq ZA== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u9cx461c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 10 Nov 2023 12:35:17 -0800
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server id
 15.1.2507.34; Fri, 10 Nov 2023 12:35:15 -0800
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Jakub Kicinski
	<kuba@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko
	<andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko
	<mykolal@fb.com>
CC: Vadim Fedorenko <vadfed@meta.com>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Subject: [PATCH bpf-next v4 1/2] bpf: add skcipher API support to TC/XDP programs
Date: Fri, 10 Nov 2023 12:34:59 -0800
Message-ID: <20231110203500.2787316-1-vadfed@meta.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2620:10d:c0a8:1b::2d]
X-Proofpoint-GUID: 8iGndIjHok6WmXn3XHHjrZvJsnfhhhjZ
X-Proofpoint-ORIG-GUID: 8iGndIjHok6WmXn3XHHjrZvJsnfhhhjZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_18,2023-11-09_01,2023-05-22_02

Add crypto API support to BPF to be able to decrypt or encrypt packets
in TC/XDP BPF programs. Only symmetric key ciphers are supported for
now. Special care should be taken for initialization part of crypto algo
because crypto_alloc_sync_skcipher() doesn't work with preemtion
disabled, it can be run only in sleepable BPF program. Also async crypto
is not supported because of the very same issue - TC/XDP BPF programs
are not sleepable.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
v3 -> v4:
- reuse __bpf_dynptr_data and remove own implementation
- use const __str to provide algorithm name
- use kfunc macroses to avoid compilator warnings
v2 -> v3:
- fix kdoc issues
v1 -> v2:
- use kmalloc in sleepable func, suggested by Alexei
- use __bpf_dynptr_is_rdonly() to check destination, suggested by Jakub
- use __bpf_dynptr_data_ptr() for all dynptr accesses
---
 include/linux/bpf.h   |   1 +
 kernel/bpf/Makefile   |   3 +
 kernel/bpf/crypto.c   | 265 ++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/helpers.c  |   2 +-
 kernel/bpf/verifier.c |   1 +
 5 files changed, 271 insertions(+), 1 deletion(-)
 create mode 100644 kernel/bpf/crypto.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4001d11be151..77934ab7421d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1224,6 +1224,7 @@ int bpf_dynptr_check_size(u32 size);
 u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
 const void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 len);
 void *__bpf_dynptr_data_rw(const struct bpf_dynptr_kern *ptr, u32 len);
+bool __bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr);
 
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
index 000000000000..4fe1470ad4b8
--- /dev/null
+++ b/kernel/bpf/crypto.c
@@ -0,0 +1,265 @@
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
+struct bpf_crypto_skcipher_ctx {
+	struct crypto_sync_skcipher *tfm;
+	struct rcu_head rcu;
+	refcount_t usage;
+};
+
+__bpf_kfunc_start_defs();
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
+ * @algo__str: pointer to string representation of algorithm.
+ * @pkey:      bpf_dynptr which holds cipher key to do crypto.
+ * @err:       integer to store error code when NULL is returned
+ */
+__bpf_kfunc struct bpf_crypto_skcipher_ctx *
+bpf_crypto_skcipher_ctx_create(const char *algo__str, const struct bpf_dynptr_kern *pkey,
+			       int *err)
+{
+	struct bpf_crypto_skcipher_ctx *ctx;
+	const u8 *key;
+	u32 key_len;
+
+	if (!crypto_has_skcipher(algo__str, CRYPTO_ALG_TYPE_SKCIPHER, CRYPTO_ALG_TYPE_MASK)) {
+		*err = -EOPNOTSUPP;
+		return NULL;
+	}
+
+	key_len = __bpf_dynptr_size(pkey);
+	if (!key_len) {
+		*err = -EINVAL;
+		return NULL;
+	}
+	key = __bpf_dynptr_data(pkey, key_len);
+	if (!key) {
+		*err = -EINVAL;
+		return NULL;
+	}
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx) {
+		*err = -ENOMEM;
+		return NULL;
+	}
+
+	ctx->tfm = crypto_alloc_sync_skcipher(algo__str, 0, 0);
+	if (IS_ERR(ctx->tfm)) {
+		*err = PTR_ERR(ctx->tfm);
+		ctx->tfm = NULL;
+		goto err;
+	}
+
+	*err = crypto_sync_skcipher_setkey(ctx->tfm, key, key_len);
+	if (*err)
+		goto err;
+
+	refcount_set(&ctx->usage, 1);
+
+	return ctx;
+err:
+	if (ctx->tfm)
+		crypto_free_sync_skcipher(ctx->tfm);
+	kfree(ctx);
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
+	kfree(ctx);
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
+static int bpf_crypto_skcipher_crypt(struct crypto_sync_skcipher *tfm,
+				     const struct bpf_dynptr_kern *src,
+				     struct bpf_dynptr_kern *dst,
+				     const struct bpf_dynptr_kern *iv,
+				     bool decrypt)
+{
+	SYNC_SKCIPHER_REQUEST_ON_STACK(req, tfm);
+	struct scatterlist sgin, sgout;
+	u32 src_len, dst_len, iv_len;
+	const u8 *psrc;
+	u8 *pdst, *piv;
+	int err;
+
+	if (crypto_sync_skcipher_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
+		return -EINVAL;
+
+	if (__bpf_dynptr_is_rdonly(dst))
+		return -EINVAL;
+
+	iv_len = __bpf_dynptr_size(iv);
+	src_len = __bpf_dynptr_size(src);
+	dst_len = __bpf_dynptr_size(dst);
+	if (!src_len || !dst_len)
+		return -EINVAL;
+
+	if (iv_len != crypto_sync_skcipher_ivsize(tfm))
+		return -EINVAL;
+
+	psrc = __bpf_dynptr_data(src, src_len);
+	if (!psrc)
+		return -EINVAL;
+	pdst = __bpf_dynptr_data_rw(dst, dst_len);
+	if (!pdst)
+		return -EINVAL;
+
+	piv = iv_len ? __bpf_dynptr_data_rw(iv, iv_len) : NULL;
+	if (iv_len && !piv)
+		return -EINVAL;
+
+	sg_init_one(&sgin, psrc, src_len);
+	sg_init_one(&sgout, pdst, dst_len);
+
+	skcipher_request_set_sync_tfm(req, tfm);
+	skcipher_request_set_callback(req, 0, NULL, NULL);
+	skcipher_request_set_crypt(req, &sgin, &sgout, src_len, piv);
+
+	err = decrypt ? crypto_skcipher_decrypt(req) : crypto_skcipher_encrypt(req);
+	skcipher_request_zero(req);
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
+					    struct bpf_dynptr_kern *iv)
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
+					    struct bpf_dynptr_kern *iv)
+{
+	return bpf_crypto_skcipher_crypt(ctx->tfm, src, dst, iv, false);
+}
+
+__bpf_kfunc_end_defs();
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
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &crypt_skcipher_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &crypt_skcipher_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &crypt_skcipher_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
+					       &crypt_skcipher_init_kfunc_set);
+	return  ret ?: register_btf_id_dtor_kfuncs(crypto_skcipher_dtors,
+						   ARRAY_SIZE(crypto_skcipher_dtors),
+						   THIS_MODULE);
+}
+
+late_initcall(crypto_skcipher_kfunc_init);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 03517db5cfb3..eb6ddc7e7fdc 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1436,7 +1436,7 @@ static const struct bpf_func_proto bpf_kptr_xchg_proto = {
 #define DYNPTR_SIZE_MASK	0xFFFFFF
 #define DYNPTR_RDONLY_BIT	BIT(31)
 
-static bool __bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr)
+bool __bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr)
 {
 	return ptr->size & DYNPTR_RDONLY_BIT;
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9ae6eae13471..aac46e7f22ab 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5552,6 +5552,7 @@ BTF_ID(struct, cgroup)
 #endif
 BTF_ID(struct, bpf_cpumask)
 BTF_ID(struct, task_struct)
+BTF_ID(struct, bpf_crypto_skcipher_ctx)
 BTF_SET_END(rcu_protected_types)
 
 static bool rcu_protected_object(const struct btf *btf, u32 btf_id)
-- 
2.39.3


