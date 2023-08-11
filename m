Return-Path: <bpf+bounces-7519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE70778687
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 06:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13D8E28165F
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 04:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D301869;
	Fri, 11 Aug 2023 04:31:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD1810F8
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 04:31:41 +0000 (UTC)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970262696
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 21:31:39 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-765942d497fso122804985a.1
        for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 21:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691728298; x=1692333098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmUovy0h/gfUHzYWEmM9zldwIzXh6MZPBnB9ZFx6Q6U=;
        b=DNjASwDkudTtdpsxtytx3EJToCndt8WyvWTLln9RM7r/Cz1NxNpl7KsWyk88Q8u9oX
         AEbVcR8Nu7oq+3+jPSPqtYsEJtO8gTBdVdEP2ADdDGXlIVYvB0sMJMRJfM4ZI7EcQE/M
         YuF0Uo0qBa1NbzgKN9vgWVNXGdin43ugSai1znSCLts1m21O6P70bQ1JcRPGexfvOBtg
         kozGuZeW7Icu9lK5ILcKMGNkv4IzB5fVlTak4HkOtpy19XdF2u/IR9hgWrO0BSPAM0ks
         wt0kRsYecJaZR5t+wrlCWqGp9LZrOSrooYcNP+Y4Ik5jOpR6Ufa9Pmh3DjYWGopLc2r9
         4fSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691728298; x=1692333098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NmUovy0h/gfUHzYWEmM9zldwIzXh6MZPBnB9ZFx6Q6U=;
        b=kmz6l8djQdUN0ScbAN2iSWBltcMIQ+rW305+YbH60P2FPZe9DvlzGpSlm9XERl5n8T
         ylsu5Qu0m5pfUL7EPTYhiAm6TW1YnNOh7pX5bf8sHRm9PuugPiivNyBOlfgmXuabBId5
         Rz4Yqhl+ceotvRI3FRsVODrlWMETo1sVYsHRbipL+vH8zjM/czfj5HupkS6THYg1Ofqy
         ACg6PkWm9MFCx+r4mDZ9sEFZx2ii7PP6fkYxUvLMu4rZB9gQkQ4t2Igf2iWXKn5iGa4U
         UJLUXcMydzypHxj3NU7IVGnWeqB0z/iX4Ebz534V7LqJKkYl9CVBpJiHNfHPqzYk3CKV
         TfYA==
X-Gm-Message-State: AOJu0YzS5dRFWukdv9nccEzRv09z2tg7TRlRSZmaekFtCli6bnOUZtED
	mKVF33cKeYfwd0rtGMgtQspJ9tf55WQKGQ==
X-Google-Smtp-Source: AGHT+IGsqWrVqygF7CUt563m06ekYX9LdGOxYIPs1U5LrJyg8unMS9vZMOvBQJoJ7Bgm5bDDL5+h0A==
X-Received: by 2002:a05:620a:2047:b0:76c:bd42:16dc with SMTP id d7-20020a05620a204700b0076cbd4216dcmr832770qka.70.1691728298354;
        Thu, 10 Aug 2023 21:31:38 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:16da:9387:4176:e970])
        by smtp.gmail.com with ESMTPSA id n15-20020a819c4f000000b00583e52232f1sm767961ywa.112.2023.08.10.21.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 21:31:37 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	sdf@google.com,
	yonghong.song@linux.dev
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v2 5/6] bpf: Add a new dynptr type for CGRUP_SOCKOPT.
Date: Thu, 10 Aug 2023 21:31:26 -0700
Message-Id: <20230811043127.1318152-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811043127.1318152-1-thinker.li@gmail.com>
References: <20230811043127.1318152-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <kuifeng@meta.com>

The new dynptr type (BPF_DYNPTR_TYPE_CGROUP_SOCKOPT) will be used by BPF
programs to create a buffer that can be installed on ctx to replace
exisiting optval or user_optval.

Installation is only allowed if ctx->flags &
BPF_SOCKOPT_FLAG_OPTVAL_REPLACE is true. It is enabled only for sleepable
programs on the cgroup/setsockopt hook.  BPF programs can install a new
buffer holding by a dynptr to increase the size of optval passed to
setsockopt().

Installation is not enabled for cgroup/getsockopt since you can not
increased a buffer created, by user program, to return data from
getsockopt().

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h            |   7 +-
 include/uapi/linux/bpf.h       |   4 +
 kernel/bpf/btf.c               |   3 +
 kernel/bpf/cgroup.c            |   5 +-
 kernel/bpf/helpers.c           | 202 +++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c          |  47 +++++++-
 tools/include/uapi/linux/bpf.h |   4 +
 7 files changed, 268 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index abe75063630b..618ca061f319 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -663,12 +663,15 @@ enum bpf_type_flag {
 	/* DYNPTR points to xdp_buff */
 	DYNPTR_TYPE_XDP		= BIT(16 + BPF_BASE_TYPE_BITS),
 
+	/* DYNPTR points to optval buffer of bpf_sockopt */
+	DYNPTR_TYPE_CGROUP_SOCKOPT = BIT(17 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
 };
 
 #define DYNPTR_TYPE_FLAG_MASK	(DYNPTR_TYPE_LOCAL | DYNPTR_TYPE_RINGBUF | DYNPTR_TYPE_SKB \
-				 | DYNPTR_TYPE_XDP)
+				 | DYNPTR_TYPE_XDP | DYNPTR_TYPE_CGROUP_SOCKOPT)
 
 /* Max number of base types. */
 #define BPF_BASE_TYPE_LIMIT	(1UL << BPF_BASE_TYPE_BITS)
@@ -1206,6 +1209,8 @@ enum bpf_dynptr_type {
 	BPF_DYNPTR_TYPE_SKB,
 	/* Underlying data is a xdp_buff */
 	BPF_DYNPTR_TYPE_XDP,
+	/* Underlying data is for the optval of a cgroup sock */
+	BPF_DYNPTR_TYPE_CGROUP_SOCKOPT,
 };
 
 int bpf_dynptr_check_size(u32 size);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index fff6f7dff408..c648a7a2b985 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7145,6 +7145,10 @@ struct bpf_sockopt {
 enum bpf_sockopt_flags {
 	/* optval is a pointer to user space memory */
 	BPF_SOCKOPT_FLAG_OPTVAL_USER	= (1U << 0),
+	/* able to install new optval */
+	BPF_SOCKOPT_FLAG_OPTVAL_REPLACE	= (1U << 1),
+	/* optval is referenced by a dynptr */
+	BPF_SOCKOPT_FLAG_OPTVAL_DYNPTR	= (1U << 2),
 };
 
 struct bpf_pidns_info {
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 249657c466dd..6d6a040688be 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -217,6 +217,7 @@ enum btf_kfunc_hook {
 	BTF_KFUNC_HOOK_SOCKET_FILTER,
 	BTF_KFUNC_HOOK_LWT,
 	BTF_KFUNC_HOOK_NETFILTER,
+	BTF_KFUNC_HOOK_CGROUP_SOCKOPT,
 	BTF_KFUNC_HOOK_MAX,
 };
 
@@ -7846,6 +7847,8 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 		return BTF_KFUNC_HOOK_LWT;
 	case BPF_PROG_TYPE_NETFILTER:
 		return BTF_KFUNC_HOOK_NETFILTER;
+	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
+		return BTF_KFUNC_HOOK_CGROUP_SOCKOPT;
 	default:
 		return BTF_KFUNC_HOOK_MAX;
 	}
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index c15a72860d2a..196391c6716a 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1877,6 +1877,8 @@ static int filter_setsockopt_progs_cb(void *arg,
 	if (max_optlen < 0)
 		return max_optlen;
 
+	ctx->flags = BPF_SOCKOPT_FLAG_OPTVAL_REPLACE;
+
 	if (copy_from_user(ctx->optval, optval,
 			   min(ctx->optlen, max_optlen)) != 0)
 		return -EFAULT;
@@ -1905,7 +1907,8 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 	ctx.optlen = *optlen;
 	ctx.optval = optval;
 	ctx.optval_end = optval + *optlen;
-	ctx.flags = BPF_SOCKOPT_FLAG_OPTVAL_USER;
+	ctx.flags = BPF_SOCKOPT_FLAG_OPTVAL_USER |
+		BPF_SOCKOPT_FLAG_OPTVAL_REPLACE;
 
 	lock_sock(sk);
 	ret = bpf_prog_run_array_cg_cb(&cgrp->bpf, CGROUP_SETSOCKOPT,
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index ff240db1512c..981dde97460b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1557,6 +1557,7 @@ BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, const struct bpf_dynptr_kern
 	switch (type) {
 	case BPF_DYNPTR_TYPE_LOCAL:
 	case BPF_DYNPTR_TYPE_RINGBUF:
+	case BPF_DYNPTR_TYPE_CGROUP_SOCKOPT:
 		/* Source and destination may possibly overlap, hence use memmove to
 		 * copy the data. E.g. bpf_dynptr_from_mem may create two dynptr
 		 * pointing to overlapping PTR_TO_MAP_VALUE regions.
@@ -1602,6 +1603,7 @@ BPF_CALL_5(bpf_dynptr_write, const struct bpf_dynptr_kern *, dst, u32, offset, v
 	switch (type) {
 	case BPF_DYNPTR_TYPE_LOCAL:
 	case BPF_DYNPTR_TYPE_RINGBUF:
+	case BPF_DYNPTR_TYPE_CGROUP_SOCKOPT:
 		if (flags)
 			return -EINVAL;
 		/* Source and destination may possibly overlap, hence use memmove to
@@ -1654,6 +1656,7 @@ BPF_CALL_3(bpf_dynptr_data, const struct bpf_dynptr_kern *, ptr, u32, offset, u3
 	switch (type) {
 	case BPF_DYNPTR_TYPE_LOCAL:
 	case BPF_DYNPTR_TYPE_RINGBUF:
+	case BPF_DYNPTR_TYPE_CGROUP_SOCKOPT:
 		return (unsigned long)(ptr->data + ptr->offset + offset);
 	case BPF_DYNPTR_TYPE_SKB:
 	case BPF_DYNPTR_TYPE_XDP:
@@ -2281,6 +2284,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset
 	switch (type) {
 	case BPF_DYNPTR_TYPE_LOCAL:
 	case BPF_DYNPTR_TYPE_RINGBUF:
+	case BPF_DYNPTR_TYPE_CGROUP_SOCKOPT:
 		return ptr->data + ptr->offset + offset;
 	case BPF_DYNPTR_TYPE_SKB:
 		if (buffer__opt)
@@ -2449,6 +2453,198 @@ __bpf_kfunc void bpf_rcu_read_unlock(void)
 	rcu_read_unlock();
 }
 
+/* Create a buffer of the given size for a {set,get}sockopt BPF filter.
+ *
+ * This kfunc is only avaliabe for sleeplabe contexts. The dynptr should be
+ * released by bpf_so_optval_install() or bpf_sockopt_release().
+ */
+__bpf_kfunc int bpf_so_optval_alloc(struct bpf_sockopt *sopt, int size,
+				    struct bpf_dynptr_kern *ptr__uninit)
+{
+	void *optval;
+	int err;
+
+	bpf_dynptr_set_null(ptr__uninit);
+
+	err = bpf_dynptr_check_size(size);
+	if (err)
+		return err;
+
+	optval = kzalloc(size, GFP_KERNEL);
+	if (!optval)
+		return -ENOMEM;
+
+	bpf_dynptr_init(ptr__uninit, optval,
+			BPF_DYNPTR_TYPE_CGROUP_SOCKOPT, 0, size);
+
+	return size;
+}
+
+/* Install the buffer of the dynptr into the sockopt context.
+ *
+ * This kfunc is only avaliabe for sleeplabe contexts. The dynptr should be
+ * allocated by bpf_so_optval_alloc().  The dynptr is invalid after
+ * returning from this function successfully.
+ */
+__bpf_kfunc int bpf_so_optval_install(struct bpf_sockopt *sopt,
+				      struct bpf_dynptr_kern *ptr)
+{
+	struct bpf_sockopt_kern *sopt_kern = (struct bpf_sockopt_kern *)sopt;
+
+	if (!(sopt_kern->flags & BPF_SOCKOPT_FLAG_OPTVAL_REPLACE) ||
+	    bpf_dynptr_get_type(ptr) != BPF_DYNPTR_TYPE_CGROUP_SOCKOPT ||
+	    !ptr->data)
+		return -EINVAL;
+
+	if (sopt_kern->optval == ptr->data &&
+	    !(sopt_kern->flags & BPF_SOCKOPT_FLAG_OPTVAL_USER)) {
+		/* This dynptr is initialized by bpf_so_optval_from() and
+		 * the optval is not overwritten by bpf_so_optval_install()
+		 * yet.
+		 */
+		bpf_dynptr_set_null(ptr);
+		sopt_kern->flags &= ~BPF_SOCKOPT_FLAG_OPTVAL_DYNPTR;
+		return 0;
+	}
+
+	if (sopt_kern->optval &&
+	    !(sopt_kern->flags & (BPF_SOCKOPT_FLAG_OPTVAL_USER |
+				  BPF_SOCKOPT_FLAG_OPTVAL_DYNPTR)))
+		kfree(sopt_kern->optval);
+
+	sopt_kern->optval = ptr->data;
+	sopt_kern->optval_end = ptr->data + __bpf_dynptr_size(ptr);
+	sopt_kern->optlen = __bpf_dynptr_size(ptr);
+	sopt_kern->flags &= ~(BPF_SOCKOPT_FLAG_OPTVAL_USER |
+			      BPF_SOCKOPT_FLAG_OPTVAL_DYNPTR);
+
+	bpf_dynptr_set_null(ptr);
+
+	return 0;
+}
+
+__bpf_kfunc int bpf_so_optval_release(struct bpf_sockopt *sopt,
+				      struct bpf_dynptr_kern *ptr)
+{
+	struct bpf_sockopt_kern *sopt_kern = (struct bpf_sockopt_kern *)sopt;
+
+	if (bpf_dynptr_get_type(ptr) != BPF_DYNPTR_TYPE_CGROUP_SOCKOPT ||
+	    !ptr->data)
+		return -EINVAL;
+
+	if (sopt_kern->optval == ptr->data &&
+	    !(sopt_kern->flags & BPF_SOCKOPT_FLAG_OPTVAL_USER))
+		/* This dynptr is initialized by bpf_so_optval_from() and
+		 * the optval is not overwritten by bpf_so_optval_install()
+		 * yet.
+		 */
+		sopt_kern->flags &= ~BPF_SOCKOPT_FLAG_OPTVAL_DYNPTR;
+	else
+		kfree(ptr->data);
+	bpf_dynptr_set_null(ptr);
+
+	return 0;
+}
+
+/* Initialize a sockopt dynptr from a user or installed optval pointer.
+ *
+ * sopt->optval can be a user pointer or a kernel pointer. A kernel pointer
+ * can be a buffer allocated by the caller of the BPF program or a buffer
+ * installed by other BPF programs through bpf_so_optval_install().
+ *
+ * Atmost one dynptr shall be created by this function at any moment, or
+ * it will return -EINVAL. You can create another dypptr by this function
+ * after release the previous one by bpf_so_optval_release().
+ *
+ * A dynptr that is initialized when optval is a user pointer is an
+ * exception. In this case, the dynptr will point to a kernel buffer with
+ * the same content as the user buffer. To simplify the code, users should
+ * always make sure having only one dynptr initialized by this function at
+ * any moment.
+ */
+__bpf_kfunc int bpf_so_optval_from(struct bpf_sockopt *sopt,
+				   struct bpf_dynptr_kern *ptr__uninit,
+				   unsigned int size)
+{
+	struct bpf_sockopt_kern *sopt_kern = (struct bpf_sockopt_kern *)sopt;
+	int err;
+
+	bpf_dynptr_set_null(ptr__uninit);
+
+	if (size > (sopt_kern->optval_end - sopt_kern->optval))
+		return -EINVAL;
+
+	if (size == 0)
+		size = min(sopt_kern->optlen,
+			   (int)(sopt_kern->optval_end - sopt_kern->optval));
+
+	if (sopt_kern->flags & BPF_SOCKOPT_FLAG_OPTVAL_DYNPTR)
+		return -EINVAL;
+
+	if (sopt_kern->flags & BPF_SOCKOPT_FLAG_OPTVAL_USER) {
+		err = bpf_so_optval_alloc(sopt, sopt_kern->optlen, ptr__uninit);
+		if (err >= 0)
+			err = copy_from_user(ptr__uninit->data,
+					     sopt_kern->optval,
+					     size);
+		return err;
+	}
+
+	bpf_dynptr_init(ptr__uninit, sopt_kern->optval,
+			BPF_DYNPTR_TYPE_CGROUP_SOCKOPT, 0,
+			size);
+	sopt_kern->flags |= BPF_SOCKOPT_FLAG_OPTVAL_DYNPTR;
+
+	return size;
+}
+
+/**
+ * int bpf_so_optval_copy_to_r(struct bpf_sockopt *sopt,
+ *                             void *ptr, u32 ptr__sz)
+ *     Description
+ *             Copy data from *ptr* to *sopt->optval*.
+ *     Return
+ *             >= 0 on success, or a negative error in case of failure.
+ */
+__bpf_kfunc int bpf_so_optval_copy_to_r(struct bpf_sockopt *sopt,
+					void *ptr, u32 ptr__sz)
+{
+	struct bpf_sockopt_kern *sopt_kern = (struct bpf_sockopt_kern *)sopt;
+	int ret;
+
+	if (ptr__sz > (sopt_kern->optval_end - sopt_kern->optval))
+		return -EINVAL;
+
+	if (sopt_kern->flags & BPF_SOCKOPT_FLAG_OPTVAL_USER) {
+		ret = copy_to_user(sopt_kern->optval, ptr,
+				   ptr__sz);
+		if (unlikely(ret))
+			return -EFAULT;
+	} else {
+		/* Use memmove() in case of optval & ptr overlap. */
+		memmove(sopt_kern->optval, ptr, ptr__sz);
+		ret = ptr__sz;
+	}
+
+	return ret;
+}
+
+/**
+ * int bpf_so_optval_copy_to(struct bpf_sockopt *sopt,
+ *                           struct bpf_dynptr_kern *ptr)
+ *     Description
+ *             Copy data from *ptr* to *sopt->optval*.
+ *     Return
+ *             >= 0 on success, or a negative error in case of failure.
+ */
+__bpf_kfunc int bpf_so_optval_copy_to(struct bpf_sockopt *sopt,
+				      struct bpf_dynptr_kern *ptr)
+{
+	__u32 size = bpf_dynptr_size(ptr);
+
+	return bpf_so_optval_copy_to_r(sopt, ptr->data, size);
+}
+
 __diag_pop();
 
 BTF_SET8_START(generic_btf_ids)
@@ -2517,6 +2713,12 @@ static const struct btf_kfunc_id_set common_kfunc_set = {
 
 BTF_SET8_START(cgroup_common_btf_ids)
 BTF_ID_FLAGS(func, bpf_copy_to_user, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_so_optval_copy_to_r, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_so_optval_copy_to, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_so_optval_alloc, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_so_optval_install, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_so_optval_release, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_so_optval_from, KF_SLEEPABLE)
 BTF_SET8_END(cgroup_common_btf_ids)
 
 static const struct btf_kfunc_id_set cgroup_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ca27be76207a..a65e0117139e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -745,6 +745,8 @@ static const char *dynptr_type_str(enum bpf_dynptr_type type)
 		return "skb";
 	case BPF_DYNPTR_TYPE_XDP:
 		return "xdp";
+	case BPF_DYNPTR_TYPE_CGROUP_SOCKOPT:
+		return "cgroup_sockopt";
 	case BPF_DYNPTR_TYPE_INVALID:
 		return "<invalid>";
 	default:
@@ -826,6 +828,8 @@ static enum bpf_dynptr_type arg_to_dynptr_type(enum bpf_arg_type arg_type)
 		return BPF_DYNPTR_TYPE_SKB;
 	case DYNPTR_TYPE_XDP:
 		return BPF_DYNPTR_TYPE_XDP;
+	case DYNPTR_TYPE_CGROUP_SOCKOPT:
+		return BPF_DYNPTR_TYPE_CGROUP_SOCKOPT;
 	default:
 		return BPF_DYNPTR_TYPE_INVALID;
 	}
@@ -842,6 +846,8 @@ static enum bpf_type_flag get_dynptr_type_flag(enum bpf_dynptr_type type)
 		return DYNPTR_TYPE_SKB;
 	case BPF_DYNPTR_TYPE_XDP:
 		return DYNPTR_TYPE_XDP;
+	case BPF_DYNPTR_TYPE_CGROUP_SOCKOPT:
+		return DYNPTR_TYPE_CGROUP_SOCKOPT;
 	default:
 		return 0;
 	}
@@ -849,7 +855,8 @@ static enum bpf_type_flag get_dynptr_type_flag(enum bpf_dynptr_type type)
 
 static bool dynptr_type_refcounted(enum bpf_dynptr_type type)
 {
-	return type == BPF_DYNPTR_TYPE_RINGBUF;
+	return type == BPF_DYNPTR_TYPE_RINGBUF ||
+		type == BPF_DYNPTR_TYPE_CGROUP_SOCKOPT;
 }
 
 static void __mark_dynptr_reg(struct bpf_reg_state *reg,
@@ -10271,6 +10278,10 @@ enum special_kfunc_type {
 	KF_bpf_dynptr_slice,
 	KF_bpf_dynptr_slice_rdwr,
 	KF_bpf_dynptr_clone,
+	KF_bpf_sockopt_alloc_optval,
+	KF_bpf_so_optval_install,
+	KF_bpf_so_optval_release,
+	KF_bpf_so_optval_from,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -10291,6 +10302,10 @@ BTF_ID(func, bpf_dynptr_from_xdp)
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
 BTF_ID(func, bpf_dynptr_clone)
+BTF_ID(func, bpf_so_optval_alloc)
+BTF_ID(func, bpf_so_optval_install)
+BTF_ID(func, bpf_so_optval_release)
+BTF_ID(func, bpf_so_optval_from)
 BTF_SET_END(special_kfunc_set)
 
 BTF_ID_LIST(special_kfunc_list)
@@ -10313,6 +10328,10 @@ BTF_ID(func, bpf_dynptr_from_xdp)
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
 BTF_ID(func, bpf_dynptr_clone)
+BTF_ID(func, bpf_so_optval_alloc)
+BTF_ID(func, bpf_so_optval_install)
+BTF_ID(func, bpf_so_optval_release)
+BTF_ID(func, bpf_so_optval_from)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -10966,6 +10985,20 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			arg_type |= OBJ_RELEASE;
 			break;
 		case KF_ARG_PTR_TO_DYNPTR:
+			if (meta->func_id == special_kfunc_list[KF_bpf_so_optval_install] ||
+			    meta->func_id == special_kfunc_list[KF_bpf_so_optval_release]) {
+				int ref_obj_id = dynptr_ref_obj_id(env, reg);
+
+				if (ref_obj_id < 0) {
+					verbose(env, "R%d is not a valid dynptr\n", regno);
+					return -EINVAL;
+				}
+
+				/* Required by check_func_arg_reg_off() */
+				arg_type |= ARG_PTR_TO_DYNPTR | OBJ_RELEASE;
+				meta->release_regno = regno;
+			}
+			break;
 		case KF_ARG_PTR_TO_ITER:
 		case KF_ARG_PTR_TO_LIST_HEAD:
 		case KF_ARG_PTR_TO_LIST_NODE:
@@ -11053,6 +11086,10 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 					verbose(env, "verifier internal error: missing ref obj id for parent of clone\n");
 					return -EFAULT;
 				}
+			} else if ((meta->func_id == special_kfunc_list[KF_bpf_sockopt_alloc_optval] ||
+				    meta->func_id == special_kfunc_list[KF_bpf_so_optval_from]) &&
+				   (dynptr_arg_type & MEM_UNINIT)) {
+				dynptr_arg_type |= DYNPTR_TYPE_CGROUP_SOCKOPT;
 			}
 
 			ret = process_dynptr_func(env, regno, insn_idx, dynptr_arg_type, clone_ref_obj_id);
@@ -11361,7 +11398,13 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	 * PTR_TO_BTF_ID in bpf_kfunc_arg_meta, do the release now.
 	 */
 	if (meta.release_regno) {
-		err = release_reference(env, regs[meta.release_regno].ref_obj_id);
+		verbose(env, "release refcounted PTR_TO_BTF_ID %s\n",
+			meta.func_name);
+		if (meta.func_id == special_kfunc_list[KF_bpf_so_optval_install] ||
+		    meta.func_id == special_kfunc_list[KF_bpf_so_optval_release])
+			err = unmark_stack_slots_dynptr(env, &regs[meta.release_regno]);
+		else
+			err = release_reference(env, regs[meta.release_regno].ref_obj_id);
 		if (err) {
 			verbose(env, "kfunc %s#%d reference has not been acquired before\n",
 				func_name, meta.func_id);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index fff6f7dff408..c648a7a2b985 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7145,6 +7145,10 @@ struct bpf_sockopt {
 enum bpf_sockopt_flags {
 	/* optval is a pointer to user space memory */
 	BPF_SOCKOPT_FLAG_OPTVAL_USER	= (1U << 0),
+	/* able to install new optval */
+	BPF_SOCKOPT_FLAG_OPTVAL_REPLACE	= (1U << 1),
+	/* optval is referenced by a dynptr */
+	BPF_SOCKOPT_FLAG_OPTVAL_DYNPTR	= (1U << 2),
 };
 
 struct bpf_pidns_info {
-- 
2.34.1


