Return-Path: <bpf+bounces-27486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B98778AD85B
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 01:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27C64B23CAD
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 23:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1843416D4FC;
	Mon, 22 Apr 2024 22:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ILRSWnaW"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F893F8D1;
	Mon, 22 Apr 2024 22:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713826250; cv=none; b=IAgXI+36pmiQCYi/ewZsCxeirnLBFRUC4YXJsARsJhsF3lebnhEDYVebYR9v3RKdUrmUoS8Zfq6Sr0EOX77JmptAnRj3z7PbBJALOankItXtUxQ162eLBLlrHIasLxApazAjqvSHO3IbR28xgI0xwpYE+OD2pgJsxgp4SyrMr1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713826250; c=relaxed/simple;
	bh=MrfNVJfwkTelNTk8aRrFFVdy2I+fB3qFFeBz6DcdODs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CTg4MNekIdZQnDirpQa1W8ob2OmVY3B9HdZRZ/OV0SEP3WmCJQfO4Pt8sxcI6lVoE9Qd18ULjczGagKb9+leJQghMLCxWX0yDEjGCig71tGMxenLAIwgBtSZqkQj28l6WsQjB4saTPWpvln2LoiWW4rTRXZ7Jh41NRd9U/Idau4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ILRSWnaW; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MKgpqL017890;
	Mon, 22 Apr 2024 15:50:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=6wmzW1ObkN3MR2gU/JEN9RvXsLLzHyFsU8ZLwsaJekM=;
 b=ILRSWnaW8Lmo1S2vDfXoxh8wND0H56DfQIBgPOSYqZ5OKhDuv5wmyCOgjr6vb32AFZZg
 7lFvtKSJwtcxojEw+tudbJVYjsIIf/+AjA44u6bpL2uceb35rqJcaOVM5p3LVsPgJcM0
 GOcsaKhPnyJKsZxefCO6stvQePxhLKTm17oc+DE8PdsKuy3RyLRRvdQk3fdc5V51FSbl
 m67sc2PlrOoM0/0b6+s2SyDjn6QODg2iBXo60Ti7nwsaPXj5vHfhhgTeBKV6M9Q8Rd8k
 A/0Iaesbp2TIw2tBHgLGBVfpIEBfr/ZMQXCjK4nwQik2ictnQkiynKeYXRe+jykIHXWF /A== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3xm9rpb7p1-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 22 Apr 2024 15:50:38 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server id
 15.1.2507.35; Mon, 22 Apr 2024 22:50:33 +0000
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
Subject: [PATCH bpf-next v10 1/4] bpf: make common crypto API for TC/XDP programs
Date: Mon, 22 Apr 2024 15:50:21 -0700
Message-ID: <20240422225024.2847039-2-vadfed@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422225024.2847039-1-vadfed@meta.com>
References: <20240422225024.2847039-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: mOLSkY_4gU4FyXg8qgWz645h7AX8Bqx4
X-Proofpoint-ORIG-GUID: mOLSkY_4gU4FyXg8qgWz645h7AX8Bqx4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_16,2024-04-22_01,2023-05-22_02

Add crypto API support to BPF to be able to decrypt or encrypt packets
in TC/XDP BPF programs. Special care should be taken for initialization
part of crypto algo because crypto alloc) doesn't work with preemtion
disabled, it can be run only in sleepable BPF program. Also async crypto
is not supported because of the very same issue - TC/XDP BPF programs
are not sleepable.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
v9 -> v10:
- add params__sz parameter to check the size of parameters structure.
- add reserved[2] into a hole in the structure and check this fields
  to be zero to avoid any confusion in case new version of structure
- improved documentation
- improved sanity checks of parameters (suggested by Martin)
v8 -> v9:
- improve initialization API to provide more data and make one call to
  have crypto context fully initialized and ready to do crypto actions
- improve fast path to avoid indirect calls
- make bpf_crypto_create runnable from syscall type programs
v7 -> v8:
- add statesize ops to bpf crypto type as some ciphers are now stateful
- improve error path in bpf_crypto_create
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
 include/linux/bpf_crypto.h |  24 +++
 kernel/bpf/Makefile        |   3 +
 kernel/bpf/crypto.c        | 382 +++++++++++++++++++++++++++++++++++++
 kernel/bpf/helpers.c       |   2 +-
 kernel/bpf/verifier.c      |   1 +
 6 files changed, 412 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/bpf_crypto.h
 create mode 100644 kernel/bpf/crypto.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5034c1b4ded7..acc479c13f52 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1265,6 +1265,7 @@ int bpf_dynptr_check_size(u32 size);
 u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
 const void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 len);
 void *__bpf_dynptr_data_rw(const struct bpf_dynptr_kern *ptr, u32 len);
+bool __bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr);
 
 #ifdef CONFIG_BPF_JIT
 int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr);
diff --git a/include/linux/bpf_crypto.h b/include/linux/bpf_crypto.h
new file mode 100644
index 000000000000..a41e71d4e2d9
--- /dev/null
+++ b/include/linux/bpf_crypto.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
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
+	unsigned int (*statesize)(void *tfm);
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
index 368c5d86b5b7..736bd22e5ce0 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -44,6 +44,9 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_struct_ops.o
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
index 000000000000..fe5e60a2f6ca
--- /dev/null
+++ b/kernel/bpf/crypto.c
@@ -0,0 +1,382 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024 Meta, Inc */
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
+/* BPF crypto initialization parameters struct */
+/**
+ * struct bpf_crypto_params - BPF crypto initialization parameters structure
+ * @type:	The string of crypto operation type.
+ * @algo:	The string of algorithm to initialize.
+ * @key:	The cipher key used to init crypto algorithm.
+ * @key_len:	The length of cipher key.
+ * @authsize:	The length of authentication tag used by algorithm.
+ */
+struct bpf_crypto_params {
+	char type[14];
+	u8 reserved[2];
+	char algo[128];
+	u8 key[256];
+	u32 key_len;
+	u32 authsize;
+};
+
+static LIST_HEAD(bpf_crypto_types);
+static DECLARE_RWSEM(bpf_crypto_types_sem);
+
+/**
+ * struct bpf_crypto_ctx - refcounted BPF crypto context structure
+ * @type:	The pointer to bpf crypto type
+ * @tfm:	The pointer to instance of crypto API struct.
+ * @siv_len     Size of IV and state storage for cipher
+ * @rcu:	The RCU head used to free the crypto context with RCU safety.
+ * @usage:	Object reference counter. When the refcount goes to 0, the
+ *		memory is released back to the BPF allocator, which provides
+ *		RCU safety.
+ */
+struct bpf_crypto_ctx {
+	const struct bpf_crypto_type *type;
+	void *tfm;
+	u32 siv_len;
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
+ * @params:	pointer to struct bpf_crypto_params which contains all the
+ *		details needed to initialise crypto context.
+ * @params__sz:	size of steuct bpf_crypto_params usef by bpf program
+ * @err:	integer to store error code when NULL is returned.
+ */
+__bpf_kfunc struct bpf_crypto_ctx *
+bpf_crypto_ctx_create(const struct bpf_crypto_params *params, u32 params__sz,
+		      int *err)
+{
+	const struct bpf_crypto_type *type;
+	struct bpf_crypto_ctx *ctx;
+
+	if (!params || params->reserved[0] || params->reserved[1] ||
+	    params__sz != sizeof(struct bpf_crypto_params)) {
+		*err = -EINVAL;
+		return NULL;
+	}
+
+	type = bpf_crypto_get_type(params->type);
+	if (IS_ERR(type)) {
+		*err = PTR_ERR(type);
+		return NULL;
+	}
+
+	if (!type->has_algo(params->algo)) {
+		*err = -EOPNOTSUPP;
+		goto err_module_put;
+	}
+
+	if (!!params->authsize ^ !!type->setauthsize) {
+		*err = -EOPNOTSUPP;
+		goto err_module_put;
+	}
+
+	if (!params->key_len || params->key_len > sizeof(params->key)) {
+		*err = -EINVAL;
+		goto err_module_put;
+	}
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx) {
+		*err = -ENOMEM;
+		goto err_module_put;
+	}
+
+	ctx->type = type;
+	ctx->tfm = type->alloc_tfm(params->algo);
+	if (IS_ERR(ctx->tfm)) {
+		*err = PTR_ERR(ctx->tfm);
+		goto err_free_ctx;
+	}
+
+	if (params->authsize) {
+		*err = type->setauthsize(ctx->tfm, params->authsize);
+		if (*err)
+			goto err_free_tfm;
+	}
+
+	*err = type->setkey(ctx->tfm, params->key, params->key_len);
+	if (*err)
+		goto err_free_tfm;
+
+	if (type->get_flags(ctx->tfm) & CRYPTO_TFM_NEED_KEY) {
+		*err = -EINVAL;
+		goto err_free_tfm;
+	}
+
+	ctx->siv_len = type->ivsize(ctx->tfm) + type->statesize(ctx->tfm);
+
+	refcount_set(&ctx->usage, 1);
+
+	return ctx;
+
+err_free_tfm:
+	type->free_tfm(ctx->tfm);
+err_free_ctx:
+	kfree(ctx);
+err_module_put:
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
+	if (!refcount_inc_not_zero(&ctx->usage))
+		return NULL;
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
+			    const struct bpf_dynptr_kern *siv,
+			    bool decrypt)
+{
+	u32 src_len, dst_len, siv_len;
+	const u8 *psrc;
+	u8 *pdst, *piv;
+	int err;
+
+	if (__bpf_dynptr_is_rdonly(dst))
+		return -EINVAL;
+
+	siv_len = __bpf_dynptr_size(siv);
+	src_len = __bpf_dynptr_size(src);
+	dst_len = __bpf_dynptr_size(dst);
+	if (!src_len || !dst_len)
+		return -EINVAL;
+
+	if (siv_len != ctx->siv_len)
+		return -EINVAL;
+
+	psrc = __bpf_dynptr_data(src, src_len);
+	if (!psrc)
+		return -EINVAL;
+	pdst = __bpf_dynptr_data_rw(dst, dst_len);
+	if (!pdst)
+		return -EINVAL;
+
+	piv = siv_len ? __bpf_dynptr_data_rw(siv, siv_len) : NULL;
+	if (siv_len && !piv)
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
+ * @siv:	bpf_dynptr to IV data and state data to be used by decryptor.
+ *
+ * Decrypts provided buffer using IV data and the crypto context. Crypto context must be configured.
+ */
+__bpf_kfunc int bpf_crypto_decrypt(struct bpf_crypto_ctx *ctx,
+				   const struct bpf_dynptr_kern *src,
+				   struct bpf_dynptr_kern *dst,
+				   struct bpf_dynptr_kern *siv)
+{
+	return bpf_crypto_crypt(ctx, src, dst, siv, true);
+}
+
+/**
+ * bpf_crypto_encrypt() - Encrypt buffer using configured context and IV provided.
+ * @ctx:	The crypto context being used. The ctx must be a trusted pointer.
+ * @src:	bpf_dynptr to the plain data. Must be a trusted pointer.
+ * @dst:	bpf_dynptr to buffer where to store the result. Must be a trusted pointer.
+ * @siv:		bpf_dynptr to IV data and state data to be used by decryptor.
+ *
+ * Encrypts provided buffer using IV data and the crypto context. Crypto context must be configured.
+ */
+__bpf_kfunc int bpf_crypto_encrypt(struct bpf_crypto_ctx *ctx,
+				   const struct bpf_dynptr_kern *src,
+				   struct bpf_dynptr_kern *dst,
+				   struct bpf_dynptr_kern *siv)
+{
+	return bpf_crypto_crypt(ctx, src, dst, siv, false);
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(crypt_init_kfunc_btf_ids)
+BTF_ID_FLAGS(func, bpf_crypto_ctx_create, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_crypto_ctx_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_crypto_ctx_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
+BTF_KFUNCS_END(crypt_init_kfunc_btf_ids)
+
+static const struct btf_kfunc_id_set crypt_init_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &crypt_init_kfunc_btf_ids,
+};
+
+BTF_KFUNCS_START(crypt_kfunc_btf_ids)
+BTF_ID_FLAGS(func, bpf_crypto_decrypt, KF_RCU)
+BTF_ID_FLAGS(func, bpf_crypto_encrypt, KF_RCU)
+BTF_KFUNCS_END(crypt_kfunc_btf_ids)
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
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
+					       &crypt_init_kfunc_set);
+	return  ret ?: register_btf_id_dtor_kfuncs(bpf_crypto_dtors,
+						   ARRAY_SIZE(bpf_crypto_dtors),
+						   THIS_MODULE);
+}
+
+late_initcall(crypto_kfunc_init);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8cde717137bd..a67fa076b844 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1443,7 +1443,7 @@ static const struct bpf_func_proto bpf_kptr_xchg_proto = {
 #define DYNPTR_SIZE_MASK	0xFFFFFF
 #define DYNPTR_RDONLY_BIT	BIT(31)
 
-static bool __bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr)
+bool __bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr)
 {
 	return ptr->size & DYNPTR_RDONLY_BIT;
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2aad6d90550f..f83f537af60f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5295,6 +5295,7 @@ BTF_ID(struct, cgroup)
 BTF_ID(struct, bpf_cpumask)
 #endif
 BTF_ID(struct, task_struct)
+BTF_ID(struct, bpf_crypto_ctx)
 BTF_SET_END(rcu_protected_types)
 
 static bool rcu_protected_object(const struct btf *btf, u32 btf_id)
-- 
2.43.0


