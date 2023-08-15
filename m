Return-Path: <bpf+bounces-7835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B75C77D14F
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 19:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FCDC2814B0
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 17:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6F0156F7;
	Tue, 15 Aug 2023 17:47:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195BE13AFD
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 17:47:38 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F110C1BCC
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 10:47:35 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-58c4e337357so17644877b3.0
        for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 10:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692121655; x=1692726455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxdWDKd1S8Tu9hMxk7z8Po/VzXEND29ljbXI3nxnuCM=;
        b=rOXq1mlzlwoGAHMAOcg0A5VDT8B86Sd4F2Ih+xs1mJlmZAjG/wYdiRtq7edOjeUcRs
         1VlrGDX4hbSwusLLxRISarxQsi0AZDlORZzu034pUo5fVPr0XuB5vDe023+YaXLhovpa
         6pLjnGpcfts//jwPVMixKmy/EP52ebw1ouq0JQf/YXg2/GNbkPKv50AZYSimvqzWN/oG
         OhRd/MaZO9QMZlgf5GcXorhRy2LdQgDpWo0/QDTDikb3IDK0cOUn3Y/i4J5MiiPnyIrZ
         4qXs7rXcnHXbj9VR1FCY814BVZmP+eG5rOmeHW9PnrYlHDF/EicXG7efIZnk1/SoajzI
         +oJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692121655; x=1692726455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxdWDKd1S8Tu9hMxk7z8Po/VzXEND29ljbXI3nxnuCM=;
        b=EC/BfTSZ9AqOZv4jEgvRSxQr8WYw+Z9Jzrv9EqBMQ9pk74EE/7lDAHyR/6W4UUWkKS
         uNujyg+wwfAF9Pced1WVdtU0dqRFuRgAyau7fsnQlLHaxesqO1f2SoemMF/dkEFGqE1J
         sh76upeChsYnR8HtiWrSMnm4BJ5CQBAJWef7GRlaKdyHLlD80uIfbTa+EGIecEIW+jx/
         DWr8kuPpbSBnvJVeBVBIOuup+tqyRXQuy9lHpRG60SYH9NEkgJqHMKrENH4gPzHUVuGh
         uNkEcX4vXqfSpcJMES5m/AECfmb8af6boq7wcrAxxNyBjQapG0BnlBv2CKbS9Mo+o9H5
         pX5g==
X-Gm-Message-State: AOJu0YwRp/naMOKykg/FpNzXdak4OsR0d715P454Uih3B20fYAnT+jsb
	mwsmj0Z2PFz6GghnIQtmZfgtbayg/c2yug==
X-Google-Smtp-Source: AGHT+IGfKd+6huQrGj0xwVrJrGX5AJd0HL4tAfHce4yMBwTWpbJeJsMMYh7f3mwQeS835fx02ycUOQ==
X-Received: by 2002:a81:6d4f:0:b0:589:eb9f:8d70 with SMTP id i76-20020a816d4f000000b00589eb9f8d70mr8911332ywc.4.1692121654838;
        Tue, 15 Aug 2023 10:47:34 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:84ee:9e38:88fa:8a7b])
        by smtp.gmail.com with ESMTPSA id o128-20020a0dcc86000000b00577139f85dfsm3509404ywd.22.2023.08.15.10.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 10:47:34 -0700 (PDT)
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
Subject: [RFC bpf-next v3 4/5] bpf: Add a new dynptr type for CGRUP_SOCKOPT.
Date: Tue, 15 Aug 2023 10:47:11 -0700
Message-Id: <20230815174712.660956-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815174712.660956-1-thinker.li@gmail.com>
References: <20230815174712.660956-1-thinker.li@gmail.com>
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

From: Kui-Feng Lee <thinker.li@gmail.com>

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

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h    |   7 +-
 include/linux/filter.h |   4 +
 kernel/bpf/btf.c       |   3 +
 kernel/bpf/cgroup.c    |   5 +-
 kernel/bpf/helpers.c   | 197 +++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c  |  47 +++++++++-
 6 files changed, 259 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index edb35bcfa548..b9e4d7752555 100644
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
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 2aa2a96526de..df12fddd2f21 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1347,6 +1347,10 @@ struct bpf_sockopt_kern {
 enum bpf_sockopt_kern_flags {
 	/* optval is a pointer to user space memory */
 	BPF_SOCKOPT_FLAG_OPTVAL_USER    = (1U << 0),
+	/* able to install new optval */
+	BPF_SOCKOPT_FLAG_OPTVAL_REPLACE	= (1U << 1),
+	/* optval is referenced by a dynptr */
+	BPF_SOCKOPT_FLAG_OPTVAL_DYNPTR	= (1U << 2),
 };
 
 int copy_bpf_fprog_from_user(struct sock_fprog *dst, sockptr_t src, int len);
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
index 425094e071ba..164dee8753cf 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1865,6 +1865,8 @@ static int filter_setsockopt_progs_cb(void *arg,
 	if (max_optlen < 0)
 		return max_optlen;
 
+	ctx->flags = BPF_SOCKOPT_FLAG_OPTVAL_REPLACE;
+
 	if (copy_from_user(ctx->optval, optval,
 			   min(ctx->optlen, max_optlen)) != 0)
 		return -EFAULT;
@@ -1893,7 +1895,8 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 	ctx.optlen = *optlen;
 	ctx.optval = optval;
 	ctx.optval_end = optval + *optlen;
-	ctx.flags = BPF_SOCKOPT_FLAG_OPTVAL_USER;
+	ctx.flags = BPF_SOCKOPT_FLAG_OPTVAL_USER |
+		BPF_SOCKOPT_FLAG_OPTVAL_REPLACE;
 
 	lock_sock(sk);
 	ret = bpf_prog_run_array_cg_cb(&cgrp->bpf, CGROUP_SETSOCKOPT,
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index eb91cae0612a..fc38aff02654 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1537,6 +1537,7 @@ BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, const struct bpf_dynptr_kern
 	switch (type) {
 	case BPF_DYNPTR_TYPE_LOCAL:
 	case BPF_DYNPTR_TYPE_RINGBUF:
+	case BPF_DYNPTR_TYPE_CGROUP_SOCKOPT:
 		/* Source and destination may possibly overlap, hence use memmove to
 		 * copy the data. E.g. bpf_dynptr_from_mem may create two dynptr
 		 * pointing to overlapping PTR_TO_MAP_VALUE regions.
@@ -1582,6 +1583,7 @@ BPF_CALL_5(bpf_dynptr_write, const struct bpf_dynptr_kern *, dst, u32, offset, v
 	switch (type) {
 	case BPF_DYNPTR_TYPE_LOCAL:
 	case BPF_DYNPTR_TYPE_RINGBUF:
+	case BPF_DYNPTR_TYPE_CGROUP_SOCKOPT:
 		if (flags)
 			return -EINVAL;
 		/* Source and destination may possibly overlap, hence use memmove to
@@ -1634,6 +1636,7 @@ BPF_CALL_3(bpf_dynptr_data, const struct bpf_dynptr_kern *, ptr, u32, offset, u3
 	switch (type) {
 	case BPF_DYNPTR_TYPE_LOCAL:
 	case BPF_DYNPTR_TYPE_RINGBUF:
+	case BPF_DYNPTR_TYPE_CGROUP_SOCKOPT:
 		return (unsigned long)(ptr->data + ptr->offset + offset);
 	case BPF_DYNPTR_TYPE_SKB:
 	case BPF_DYNPTR_TYPE_XDP:
@@ -2261,6 +2264,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset
 	switch (type) {
 	case BPF_DYNPTR_TYPE_LOCAL:
 	case BPF_DYNPTR_TYPE_RINGBUF:
+	case BPF_DYNPTR_TYPE_CGROUP_SOCKOPT:
 		return ptr->data + ptr->offset + offset;
 	case BPF_DYNPTR_TYPE_SKB:
 		if (buffer__opt)
@@ -2429,6 +2433,185 @@ __bpf_kfunc void bpf_rcu_read_unlock(void)
 	rcu_read_unlock();
 }
 
+/* Create a buffer of the given size for a {set,get}sockopt BPF filter.
+ *
+ * This kfunc is only avaliabe for sleeplabe contexts. The dynptr should be
+ * released by bpf_sockopt_dynptr_install() or bpf_sockopt_release().
+ */
+__bpf_kfunc int bpf_sockopt_dynptr_alloc(struct bpf_sockopt *sopt, int size,
+					 struct bpf_dynptr_kern *ptr__uninit)
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
+ * allocated by bpf_sockopt_dynptr_alloc().  The dynptr is invalid after
+ * returning from this function successfully.
+ */
+__bpf_kfunc int bpf_sockopt_dynptr_install(struct bpf_sockopt *sopt,
+					   struct bpf_dynptr_kern *ptr)
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
+		/* This dynptr is initialized by bpf_sockopt_dynptr_from()
+		 * and the optval is not overwritten by
+		 * bpf_sockopt_dynptr_install() yet.
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
+__bpf_kfunc int bpf_sockopt_dynptr_release(struct bpf_sockopt *sopt,
+					   struct bpf_dynptr_kern *ptr)
+{
+	struct bpf_sockopt_kern *sopt_kern = (struct bpf_sockopt_kern *)sopt;
+
+	if (bpf_dynptr_get_type(ptr) != BPF_DYNPTR_TYPE_CGROUP_SOCKOPT ||
+	    !ptr->data)
+		return -EINVAL;
+
+	if (sopt_kern->optval == ptr->data &&
+	    !(sopt_kern->flags & BPF_SOCKOPT_FLAG_OPTVAL_USER))
+		/* This dynptr is initialized by bpf_sockopt_dynptr_from()
+		 * and the optval is not overwritten by
+		 * bpf_sockopt_dynptr_install() yet.
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
+ * installed by other BPF programs through bpf_sockopt_dynptr_install().
+ *
+ * Atmost one dynptr shall be created by this function at any moment, or
+ * it will return -EINVAL. You can create another dypptr by this function
+ * after release the previous one by bpf_sockopt_dynptr_release().
+ *
+ * A dynptr that is initialized when optval is a user pointer is an
+ * exception. In this case, the dynptr will point to a kernel buffer with
+ * the same content as the user buffer. To simplify the code, users should
+ * always make sure having only one dynptr initialized by this function at
+ * any moment.
+ */
+__bpf_kfunc int bpf_sockopt_dynptr_from(struct bpf_sockopt *sopt,
+					struct bpf_dynptr_kern *ptr__uninit,
+					unsigned int size)
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
+		err = bpf_sockopt_dynptr_alloc(sopt, sopt_kern->optlen,
+					       ptr__uninit);
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
+ * int bpf_sockopt_dynptr_copy_to(struct bpf_sockopt *sopt,
+ *				  struct bpf_dynptr_kern *ptr)
+ *     Description
+ *             Copy data from *ptr* to *sopt->optval*.
+ *     Return
+ *             >= 0 on success, or a negative error in case of failure.
+ */
+__bpf_kfunc int bpf_sockopt_dynptr_copy_to(struct bpf_sockopt *sopt,
+					   struct bpf_dynptr_kern *ptr)
+{
+	__u32 size = bpf_dynptr_size(ptr);
+
+	struct bpf_sockopt_kern *sopt_kern = (struct bpf_sockopt_kern *)sopt;
+	int ret;
+
+	if (size > (sopt_kern->optval_end - sopt_kern->optval))
+		return -EINVAL;
+
+	if (sopt_kern->flags & BPF_SOCKOPT_FLAG_OPTVAL_USER) {
+		ret = copy_to_user(sopt_kern->optval, ptr->data,
+				   size);
+		if (unlikely(ret))
+			return -EFAULT;
+	} else {
+		/* Use memmove() in case of optval & ptr overlap. */
+		memmove(sopt_kern->optval, ptr->data, size);
+		ret = size;
+	}
+
+	return ret;
+}
+
 __diag_pop();
 
 BTF_SET8_START(generic_btf_ids)
@@ -2494,6 +2677,19 @@ static const struct btf_kfunc_id_set common_kfunc_set = {
 	.set   = &common_btf_ids,
 };
 
+BTF_SET8_START(cgroup_common_btf_ids)
+BTF_ID_FLAGS(func, bpf_sockopt_dynptr_copy_to, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_sockopt_dynptr_alloc, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_sockopt_dynptr_install, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_sockopt_dynptr_release, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_sockopt_dynptr_from, KF_SLEEPABLE)
+BTF_SET8_END(cgroup_common_btf_ids)
+
+static const struct btf_kfunc_id_set cgroup_kfunc_set = {
+	.owner	= THIS_MODULE,
+	.set	= &cgroup_common_btf_ids,
+};
+
 static int __init kfunc_init(void)
 {
 	int ret;
@@ -2513,6 +2709,7 @@ static int __init kfunc_init(void)
 	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCKOPT, &cgroup_kfunc_set);
 	ret = ret ?: register_btf_id_dtor_kfuncs(generic_dtors,
 						  ARRAY_SIZE(generic_dtors),
 						  THIS_MODULE);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 936a171ea976..83d65a6e1309 100644
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
+	KF_bpf_sockopt_dynptr_alloc,
+	KF_bpf_sockopt_dynptr_install,
+	KF_bpf_sockopt_dynptr_release,
+	KF_bpf_sockopt_dynptr_from,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -10291,6 +10302,10 @@ BTF_ID(func, bpf_dynptr_from_xdp)
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
 BTF_ID(func, bpf_dynptr_clone)
+BTF_ID(func, bpf_sockopt_dynptr_alloc)
+BTF_ID(func, bpf_sockopt_dynptr_install)
+BTF_ID(func, bpf_sockopt_dynptr_release)
+BTF_ID(func, bpf_sockopt_dynptr_from)
 BTF_SET_END(special_kfunc_set)
 
 BTF_ID_LIST(special_kfunc_list)
@@ -10313,6 +10328,10 @@ BTF_ID(func, bpf_dynptr_from_xdp)
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
 BTF_ID(func, bpf_dynptr_clone)
+BTF_ID(func, bpf_sockopt_dynptr_alloc)
+BTF_ID(func, bpf_sockopt_dynptr_install)
+BTF_ID(func, bpf_sockopt_dynptr_release)
+BTF_ID(func, bpf_sockopt_dynptr_from)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -10966,6 +10985,20 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			arg_type |= OBJ_RELEASE;
 			break;
 		case KF_ARG_PTR_TO_DYNPTR:
+			if (meta->func_id == special_kfunc_list[KF_bpf_sockopt_dynptr_install] ||
+			    meta->func_id == special_kfunc_list[KF_bpf_sockopt_dynptr_release]) {
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
+			} else if ((meta->func_id == special_kfunc_list[KF_bpf_sockopt_dynptr_alloc] ||
+				    meta->func_id == special_kfunc_list[KF_bpf_sockopt_dynptr_from]) &&
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
+		if (meta.func_id == special_kfunc_list[KF_bpf_sockopt_dynptr_install] ||
+		    meta.func_id == special_kfunc_list[KF_bpf_sockopt_dynptr_release])
+			err = unmark_stack_slots_dynptr(env, &regs[meta.release_regno]);
+		else
+			err = release_reference(env, regs[meta.release_regno].ref_obj_id);
 		if (err) {
 			verbose(env, "kfunc %s#%d reference has not been acquired before\n",
 				func_name, meta.func_id);
-- 
2.34.1


