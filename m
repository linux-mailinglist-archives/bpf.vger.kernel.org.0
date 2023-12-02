Return-Path: <bpf+bounces-16486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE371801947
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 02:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E98CE1F2111D
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 01:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A2317E2;
	Sat,  2 Dec 2023 01:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="MKffO8IT"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE573D54;
	Fri,  1 Dec 2023 17:06:30 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B20JbSD023440;
	Fri, 1 Dec 2023 17:06:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=sZqp4PTqOYxAkc8ohnYgYVdr+0ck7ZgqFjqslP6Q6oU=;
 b=MKffO8ITjGw/4H9nYrRrZbv/jt5nnP1sxv8qnjv+AIJto2KYoFH8PJ/72KBP8U+qjjEo
 /mk4FsdBx4NorD7wwLqttsTPBi9EOMVO3tXSo7IxFyDbgzP/oMe3L7f+l/t8tg39DrAg
 3yNYTCeERLb+bQT+tQsN7aYmDIIJuc92cIkNTbTmD5v55JIejBMjwZL5p3OnyJ3MJ8q0
 gUY6Q97y8LDIBs6DNeGZF903JLlRQF8n2j4yDr820HWq8UpYncFAkWyn60j/QnSGpxeb
 jCyJTyjdI/GuFcePl7FUSVviS/0TTqWpKEORq81qW2XXTFGl6O5q14u9PyJhwCcOeY7W fg== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uqb185vxg-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 01 Dec 2023 17:06:16 -0800
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server id
 15.1.2507.34; Fri, 1 Dec 2023 17:06:14 -0800
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Jakub Kicinski
	<kuba@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko
	<andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko
	<mykolal@fb.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC: Vadim Fedorenko <vadfed@meta.com>, <netdev@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v7 1/3] bpf: make common crypto API for TC/XDP programs
Date: Fri, 1 Dec 2023 17:06:02 -0800
Message-ID: <20231202010604.1877561-1-vadfed@meta.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: CC0u4AfUXDLo3tSuRXxGHXrYaPj5J7-d
X-Proofpoint-GUID: CC0u4AfUXDLo3tSuRXxGHXrYaPj5J7-d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_24,2023-11-30_01,2023-05-22_02

Add crypto API support to BPF to be able to decrypt or encrypt packets
in TC/XDP BPF programs. Special care should be taken for initialization
part of crypto algo because crypto alloc) doesn't work with preemtion
disabled, it can be run only in sleepable BPF program. Also async crypto
is not supported because of the very same issue - TC/XDP BPF programs
are not sleepable.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
v6 -> v7:
- style fixes
v5 -> v6:
- replace lskcipher with infrastructure to provide pluggable cipher
  types
- add BPF skcipher as plug-in module in a separate patch
v4 -> v5:
- replace crypto API to use lskcipher (suggested by Herbert Xu)
- remove SG list usage and provide raw buffers
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
 include/linux/bpf.h        |   1 +
 include/linux/bpf_crypto.h |  23 +++
 kernel/bpf/Makefile        |   3 +
 kernel/bpf/crypto.c        | 364 +++++++++++++++++++++++++++++++++++++
 kernel/bpf/helpers.c       |   2 +-
 kernel/bpf/verifier.c      |   1 +
 6 files changed, 393 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/bpf_crypto.h
 create mode 100644 kernel/bpf/crypto.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index eb447b0a9423..0143ff6c93a1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1228,6 +1228,7 @@ int bpf_dynptr_check_size(u32 size);
 u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
 const void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 len);
 void *__bpf_dynptr_data_rw(const struct bpf_dynptr_kern *ptr, u32 len);
+bool __bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr);
 
 #ifdef CONFIG_BPF_JIT
 int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr);
diff --git a/include/linux/bpf_crypto.h b/include/linux/bpf_crypto.h
new file mode 100644
index 000000000000..e81bd8ab979c
--- /dev/null
+++ b/include/linux/bpf_crypto.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+#ifndef _BPF_CRYPTO_H
+#define _BPF_CRYPTO_H
+
+struct bpf_crypto_type {
+	void *(*alloc_tfm)(const char *algo);
+	void (*free_tfm)(void *tfm);
+	int (*has_algo)(const char *algo);
+	int (*setkey)(void *tfm, const u8 *key, unsigned int keylen);
+	int (*setauthsize)(void *tfm, unsigned int authsize);
+	int (*encrypt)(void *tfm, const u8 *src, u8 *dst, unsigned int len, u8 *iv);
+	int (*decrypt)(void *tfm, const u8 *src, u8 *dst, unsigned int len, u8 *iv);
+	unsigned int (*ivsize)(void *tfm);
+	u32 (*get_flags)(void *tfm);
+	struct module *owner;
+	char name[14];
+};
+
+int bpf_crypto_register_type(const struct bpf_crypto_type *type);
+int bpf_crypto_unregister_type(const struct bpf_crypto_type *type);
+
+#endif /* _BPF_CRYPTO_H */
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index f526b7573e97..bcde762bb2c2 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -41,6 +41,9 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_struct_ops.o
 obj-$(CONFIG_BPF_SYSCALL) += cpumask.o
 obj-${CONFIG_BPF_LSM} += bpf_lsm.o
 endif
+ifeq ($(CONFIG_CRYPTO),y)
+obj-$(CONFIG_BPF_SYSCALL) += crypto.o
+endif
 obj-$(CONFIG_BPF_PRELOAD) += preload/
 
 obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
new file mode 100644
index 000000000000..a1e543d1d7fe
--- /dev/null
+++ b/kernel/bpf/crypto.c
@@ -0,0 +1,364 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2023 Meta, Inc */
+#include <linux/bpf.h>
+#include <linux/bpf_crypto.h>
+#include <linux/bpf_mem_alloc.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/filter.h>
+#include <linux/scatterlist.h>
+#include <linux/skbuff.h>
+#include <crypto/skcipher.h>
+
+struct bpf_crypto_type_list {
+	const struct bpf_crypto_type *type;
+	struct list_head list;
+};
+
+static LIST_HEAD(bpf_crypto_types);
+static DECLARE_RWSEM(bpf_crypto_types_sem);
+
+/**
+ * struct bpf_crypto_ctx - refcounted BPF crypto context structure
+ * @type:	The pointer to bpf crypto type
+ * @tfm:	The pointer to instance of crypto API struct.
+ * @rcu:	The RCU head used to free the crypto context with RCU safety.
+ * @usage:	Object reference counter. When the refcount goes to 0, the
+ *		memory is released back to the BPF allocator, which provides
+ *		RCU safety.
+ */
+struct bpf_crypto_ctx {
+	const struct bpf_crypto_type *type;
+	void *tfm;
+	struct rcu_head rcu;
+	refcount_t usage;
+};
+
+int bpf_crypto_register_type(const struct bpf_crypto_type *type)
+{
+	struct bpf_crypto_type_list *node;
+	int err = -EEXIST;
+
+	down_write(&bpf_crypto_types_sem);
+	list_for_each_entry(node, &bpf_crypto_types, list) {
+		if (!strcmp(node->type->name, type->name))
+			goto unlock;
+	}
+
+	node = kmalloc(sizeof(*node), GFP_KERNEL);
+	err = -ENOMEM;
+	if (!node)
+		goto unlock;
+
+	node->type = type;
+	list_add(&node->list, &bpf_crypto_types);
+	err = 0;
+
+unlock:
+	up_write(&bpf_crypto_types_sem);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(bpf_crypto_register_type);
+
+int bpf_crypto_unregister_type(const struct bpf_crypto_type *type)
+{
+	struct bpf_crypto_type_list *node;
+	int err = -ENOENT;
+
+	down_write(&bpf_crypto_types_sem);
+	list_for_each_entry(node, &bpf_crypto_types, list) {
+		if (strcmp(node->type->name, type->name))
+			continue;
+
+		list_del(&node->list);
+		kfree(node);
+		err = 0;
+		break;
+	}
+	up_write(&bpf_crypto_types_sem);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(bpf_crypto_unregister_type);
+
+static const struct bpf_crypto_type *bpf_crypto_get_type(const char *name)
+{
+	const struct bpf_crypto_type *type = ERR_PTR(-ENOENT);
+	struct bpf_crypto_type_list *node;
+
+	down_read(&bpf_crypto_types_sem);
+	list_for_each_entry(node, &bpf_crypto_types, list) {
+		if (strcmp(node->type->name, name))
+			continue;
+
+		if (try_module_get(node->type->owner))
+			type = node->type;
+		break;
+	}
+	up_read(&bpf_crypto_types_sem);
+
+	return type;
+}
+
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_crypto_ctx_create() - Create a mutable BPF crypto context.
+ *
+ * Allocates a crypto context that can be used, acquired, and released by
+ * a BPF program. The crypto context returned by this function must either
+ * be embedded in a map as a kptr, or freed with bpf_crypto_ctx_release().
+ * As crypto API functions use GFP_KERNEL allocations, this function can
+ * only be used in sleepable BPF programs.
+ *
+ * bpf_crypto_ctx_create() allocates memory for crypto context.
+ * It may return NULL if no memory is available.
+ * @type__str: pointer to string representation of crypto type.
+ * @algo__str: pointer to string representation of algorithm.
+ * @pkey:      bpf_dynptr which holds cipher key to do crypto.
+ * @err:       integer to store error code when NULL is returned
+ */
+__bpf_kfunc struct bpf_crypto_ctx *
+bpf_crypto_ctx_create(const char *type__str, const char *algo__str,
+		      const struct bpf_dynptr_kern *pkey,
+		      unsigned int authsize, int *err)
+{
+	const struct bpf_crypto_type *type = bpf_crypto_get_type(type__str);
+	struct bpf_crypto_ctx *ctx;
+	const u8 *key;
+	u32 key_len;
+
+	type = bpf_crypto_get_type(type__str);
+	if (IS_ERR(type)) {
+		*err = PTR_ERR(type);
+		return NULL;
+	}
+
+	if (!type->has_algo(algo__str)) {
+		*err = -EOPNOTSUPP;
+		goto err;
+	}
+
+	if (!authsize && type->setauthsize) {
+		*err = -EOPNOTSUPP;
+		goto err;
+	}
+
+	if (authsize && !type->setauthsize) {
+		*err = -EOPNOTSUPP;
+		goto err;
+	}
+
+	key_len = __bpf_dynptr_size(pkey);
+	if (!key_len) {
+		*err = -EINVAL;
+		goto err;
+	}
+	key = __bpf_dynptr_data(pkey, key_len);
+	if (!key) {
+		*err = -EINVAL;
+		goto err;
+	}
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx) {
+		*err = -ENOMEM;
+		goto err;
+	}
+
+	ctx->type = type;
+	ctx->tfm = type->alloc_tfm(algo__str);
+	if (IS_ERR(ctx->tfm)) {
+		*err = PTR_ERR(ctx->tfm);
+		ctx->tfm = NULL;
+		goto err;
+	}
+
+	if (authsize) {
+		*err = type->setauthsize(ctx->tfm, authsize);
+		if (*err)
+			goto err;
+	}
+
+	*err = type->setkey(ctx->tfm, key, key_len);
+	if (*err)
+		goto err;
+
+	refcount_set(&ctx->usage, 1);
+
+	return ctx;
+err:
+	if (ctx->tfm)
+		type->free_tfm(ctx->tfm);
+	kfree(ctx);
+	module_put(type->owner);
+
+	return NULL;
+}
+
+static void crypto_free_cb(struct rcu_head *head)
+{
+	struct bpf_crypto_ctx *ctx;
+
+	ctx = container_of(head, struct bpf_crypto_ctx, rcu);
+	ctx->type->free_tfm(ctx->tfm);
+	module_put(ctx->type->owner);
+	kfree(ctx);
+}
+
+/**
+ * bpf_crypto_ctx_acquire() - Acquire a reference to a BPF crypto context.
+ * @ctx: The BPF crypto context being acquired. The ctx must be a trusted
+ *	     pointer.
+ *
+ * Acquires a reference to a BPF crypto context. The context returned by this function
+ * must either be embedded in a map as a kptr, or freed with
+ * bpf_crypto_skcipher_ctx_release().
+ */
+__bpf_kfunc struct bpf_crypto_ctx *
+bpf_crypto_ctx_acquire(struct bpf_crypto_ctx *ctx)
+{
+	refcount_inc(&ctx->usage);
+	return ctx;
+}
+
+/**
+ * bpf_crypto_ctx_release() - Release a previously acquired BPF crypto context.
+ * @ctx: The crypto context being released.
+ *
+ * Releases a previously acquired reference to a BPF crypto context. When the final
+ * reference of the BPF crypto context has been released, it is subsequently freed in
+ * an RCU callback in the BPF memory allocator.
+ */
+__bpf_kfunc void bpf_crypto_ctx_release(struct bpf_crypto_ctx *ctx)
+{
+	if (refcount_dec_and_test(&ctx->usage))
+		call_rcu(&ctx->rcu, crypto_free_cb);
+}
+
+static int bpf_crypto_crypt(const struct bpf_crypto_ctx *ctx,
+			    const struct bpf_dynptr_kern *src,
+			    struct bpf_dynptr_kern *dst,
+			    const struct bpf_dynptr_kern *iv,
+			    bool decrypt)
+{
+	u32 src_len, dst_len, iv_len;
+	const u8 *psrc;
+	u8 *pdst, *piv;
+	int err;
+
+	if (ctx->type->get_flags(ctx->tfm) & CRYPTO_TFM_NEED_KEY)
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
+	if (iv_len != ctx->type->ivsize(ctx->tfm))
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
+	err = decrypt ? ctx->type->decrypt(ctx->tfm, psrc, pdst, src_len, piv)
+		      : ctx->type->encrypt(ctx->tfm, psrc, pdst, src_len, piv);
+
+	return err;
+}
+
+/**
+ * bpf_crypto_decrypt() - Decrypt buffer using configured context and IV provided.
+ * @ctx:	The crypto context being used. The ctx must be a trusted pointer.
+ * @src:	bpf_dynptr to the encrypted data. Must be a trusted pointer.
+ * @dst:	bpf_dynptr to the buffer where to store the result. Must be a trusted pointer.
+ * @iv:		bpf_dynptr to IV data to be used by decryptor.
+ *
+ * Decrypts provided buffer using IV data and the crypto context. Crypto context must be configured.
+ */
+__bpf_kfunc int bpf_crypto_decrypt(struct bpf_crypto_ctx *ctx,
+				   const struct bpf_dynptr_kern *src,
+				   struct bpf_dynptr_kern *dst,
+				   struct bpf_dynptr_kern *iv)
+{
+	return bpf_crypto_crypt(ctx, src, dst, iv, true);
+}
+
+/**
+ * bpf_crypto_encrypt() - Encrypt buffer using configured context and IV provided.
+ * @ctx:	The crypto context being used. The ctx must be a trusted pointer.
+ * @src:	bpf_dynptr to the plain data. Must be a trusted pointer.
+ * @dst:	bpf_dynptr to buffer where to store the result. Must be a trusted pointer.
+ * @iv:		bpf_dynptr to IV data to be used by decryptor.
+ *
+ * Encrypts provided buffer using IV data and the crypto context. Crypto context must be configured.
+ */
+__bpf_kfunc int bpf_crypto_encrypt(struct bpf_crypto_ctx *ctx,
+				   const struct bpf_dynptr_kern *src,
+				   struct bpf_dynptr_kern *dst,
+				   struct bpf_dynptr_kern *iv)
+{
+	return bpf_crypto_crypt(ctx, src, dst, iv, false);
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_SET8_START(crypt_init_kfunc_btf_ids)
+BTF_ID_FLAGS(func, bpf_crypto_ctx_create, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_crypto_ctx_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_crypto_ctx_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
+BTF_SET8_END(crypt_init_kfunc_btf_ids)
+
+static const struct btf_kfunc_id_set crypt_init_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &crypt_init_kfunc_btf_ids,
+};
+
+BTF_SET8_START(crypt_kfunc_btf_ids)
+BTF_ID_FLAGS(func, bpf_crypto_decrypt, KF_RCU)
+BTF_ID_FLAGS(func, bpf_crypto_encrypt, KF_RCU)
+BTF_SET8_END(crypt_kfunc_btf_ids)
+
+static const struct btf_kfunc_id_set crypt_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &crypt_kfunc_btf_ids,
+};
+
+BTF_ID_LIST(bpf_crypto_dtor_ids)
+BTF_ID(struct, bpf_crypto_ctx)
+BTF_ID(func, bpf_crypto_ctx_release)
+
+static int __init crypto_kfunc_init(void)
+{
+	int ret;
+	const struct btf_id_dtor_kfunc bpf_crypto_dtors[] = {
+		{
+			.btf_id	      = bpf_crypto_dtor_ids[0],
+			.kfunc_btf_id = bpf_crypto_dtor_ids[1]
+		},
+	};
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &crypt_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &crypt_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &crypt_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
+					       &crypt_init_kfunc_set);
+	return  ret ?: register_btf_id_dtor_kfuncs(bpf_crypto_dtors,
+						   ARRAY_SIZE(bpf_crypto_dtors),
+						   THIS_MODULE);
+}
+
+late_initcall(crypto_kfunc_init);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b45a8381f9bd..b73314c0124e 100644
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
index 8e7b6072e3f4..c54716966d5d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5162,6 +5162,7 @@ BTF_ID(struct, cgroup)
 #endif
 BTF_ID(struct, bpf_cpumask)
 BTF_ID(struct, task_struct)
+BTF_ID(struct, bpf_crypto_ctx)
 BTF_SET_END(rcu_protected_types)
 
 static bool rcu_protected_object(const struct btf *btf, u32 btf_id)
-- 
2.39.3


