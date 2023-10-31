Return-Path: <bpf+bounces-13706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8544D7DCE30
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 14:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E1EBB21047
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 13:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE4D1DA5F;
	Tue, 31 Oct 2023 13:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Y7aDYyHP"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10AE12B98;
	Tue, 31 Oct 2023 13:49:21 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12308DE;
	Tue, 31 Oct 2023 06:49:19 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39V8VtNO027765;
	Tue, 31 Oct 2023 06:49:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=llQV7ParuMWiOSU4IleaKAza2Dyfrfhwq3vIn7wQwrk=;
 b=Y7aDYyHP0n4VoGoBVNzNy/0dp7idC2KDYtRHfOSJfSgfBjd5jW4/pMYa/TJxrYjNPt7O
 N2dELJg1p8Km8Siuux2PCGSlLJA1dp+Lv6CVgZNgkuoX86wu42gA4yi9v5bWQnHdZ5pS
 Q4ARfqJflAnswAAZziQFyUphTAIo3IObpYieoC9/NPn7Ebv3Jjb5AqMmrChsPP56hf86
 flGTyHacNN5WZE7KKQmdL8k0yqhnmq0Mg8BVbPogugs0DQAQTcGMFAouAJS23vGjARue
 8YfF9es9jnZvdu3XCe+6hZbPlpvXRuQL1D0MLeHfJGeyF5RaDhcTsZALBeCt4g1q9Knw AQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u2j6vw9yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 31 Oct 2023 06:49:11 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server id
 15.1.2507.34; Tue, 31 Oct 2023 06:49:08 -0700
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
Subject: [PATCH bpf-next v3 1/2] bpf: add skcipher API support to TC/XDP programs
Date: Tue, 31 Oct 2023 06:48:59 -0700
Message-ID: <20231031134900.1432945-1-vadfed@meta.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2620:10d:c085:208::f]
X-Proofpoint-ORIG-GUID: s3C4WEFCo5LXvSCenAUmImXitDFKvU0s
X-Proofpoint-GUID: s3C4WEFCo5LXvSCenAUmImXitDFKvU0s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_01,2023-10-31_03,2023-05-22_02

Add crypto API support to BPF to be able to decrypt or encrypt packets
in TC/XDP BPF programs. Only symmetric key ciphers are supported for
now. Special care should be taken for initialization part of crypto algo
because crypto_alloc_sync_skcipher() doesn't work with preemtion
disabled, it can be run only in sleepable BPF program. Also async crypto
is not supported because of the very same issue - TC/XDP BPF programs
are not sleepable.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
v2 -> v3:
- fix kdoc issues
v1 -> v2:
- use kmalloc in sleepable func, suggested by Alexei
- use __bpf_dynptr_is_rdonly() to check destination, suggested by Jakub
- use __bpf_dynptr_data_ptr() for all dynptr accesses

 include/linux/bpf.h   |   2 +
 kernel/bpf/Makefile   |   3 +
 kernel/bpf/crypto.c   | 280 ++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/helpers.c  |   4 +-
 kernel/bpf/verifier.c |   1 +
 5 files changed, 288 insertions(+), 2 deletions(-)
 create mode 100644 kernel/bpf/crypto.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d3c51a507508..5ad1e83394b3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1222,6 +1222,8 @@ enum bpf_dynptr_type {
 
 int bpf_dynptr_check_size(u32 size);
 u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
+enum bpf_dynptr_type bpf_dynptr_get_type(const struct bpf_dynptr_kern *ptr);
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
index 000000000000..c2a0703934fc
--- /dev/null
+++ b/kernel/bpf/crypto.c
@@ -0,0 +1,280 @@
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
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global kfuncs as their definitions will be in BTF");
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
+bpf_crypto_skcipher_ctx_create(const struct bpf_dynptr_kern *palgo,
+			       const struct bpf_dynptr_kern *pkey, int *err)
+{
+	struct bpf_crypto_skcipher_ctx *ctx;
+	char *algo;
+
+	if (__bpf_dynptr_size(palgo) > CRYPTO_MAX_ALG_NAME) {
+		*err = -EINVAL;
+		return NULL;
+	}
+
+	algo = __bpf_dynptr_data_ptr(palgo);
+
+	if (!crypto_has_skcipher(algo, CRYPTO_ALG_TYPE_SKCIPHER, CRYPTO_ALG_TYPE_MASK)) {
+		*err = -EOPNOTSUPP;
+		return NULL;
+	}
+
+	ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx) {
+		*err = -ENOMEM;
+		return NULL;
+	}
+
+	memset(ctx, 0, sizeof(*ctx));
+
+	ctx->tfm = crypto_alloc_sync_skcipher(algo, 0, 0);
+	if (IS_ERR(ctx->tfm)) {
+		*err = PTR_ERR(ctx->tfm);
+		ctx->tfm = NULL;
+		goto err;
+	}
+
+	*err = crypto_sync_skcipher_setkey(ctx->tfm, __bpf_dynptr_data_ptr(pkey),
+					   __bpf_dynptr_size(pkey));
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
+	struct skcipher_request *req = NULL;
+	struct scatterlist sgin, sgout;
+	int err;
+
+	if (crypto_sync_skcipher_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
+		return -EINVAL;
+
+	if (__bpf_dynptr_is_rdonly(dst))
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
index 62a53ebfedf9..2020884fca3d 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1429,7 +1429,7 @@ static const struct bpf_func_proto bpf_kptr_xchg_proto = {
 #define DYNPTR_SIZE_MASK	0xFFFFFF
 #define DYNPTR_RDONLY_BIT	BIT(31)
 
-static bool __bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr)
+bool __bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr)
 {
 	return ptr->size & DYNPTR_RDONLY_BIT;
 }
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


