Return-Path: <bpf+bounces-8117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C14227816EE
	for <lists+bpf@lfdr.de>; Sat, 19 Aug 2023 05:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3AEF1C20DBB
	for <lists+bpf@lfdr.de>; Sat, 19 Aug 2023 03:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D535136C;
	Sat, 19 Aug 2023 03:01:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CCB1368
	for <bpf@vger.kernel.org>; Sat, 19 Aug 2023 03:01:55 +0000 (UTC)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C7E4224
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 20:01:53 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d72fca0043aso1514137276.1
        for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 20:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692414112; x=1693018912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pDKeioD9VkAqH4669Dt/WS61Ku2CiWURjTuSdp81L0=;
        b=ZmAPOmoKUjaA4V/nSoGU6l2nXgpGjZYQM9od6NA6n5outo7FFVCmSQ33kX5r2KmFqk
         9DpHuANJD5E3XdF7fKDkXDHnMhcogAb0sz2iHaySqKodtAI+R6Ae79afNaxHXVUuLCjl
         PYMR10q5ZGwbczbjU3hJJMG7zlnMXUx1aE/S3NLNLcLMQouxpycJ45d2aVvEz+a3SUWQ
         02A+h5ojCKZGTxyUX69GLzjs+a1h/KtmxAXxuN8ujcUt/O0wEqsAceN/lbT5jeZGsWIW
         Qw2mhGpSVN69dAkT4kZIzEwlNRbNTdvaHEfFCqD51b1c36Xn4hTdD0sXRWvQ/tGZhr/5
         SPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692414112; x=1693018912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pDKeioD9VkAqH4669Dt/WS61Ku2CiWURjTuSdp81L0=;
        b=Gshg0g7ly9fPWMkUMx7zxgSpAUVRhH+dDjJxrNIcy/tGEottKDJ0ehYmohZm540WBJ
         gG1EcB4Xnp14aeNv8JrCLbLNGkT0tCI9DJDLNpjngmkbJtt3lmuoIakJYvGRau2BrZNo
         5ERN2J4OdUg6c0sMQhDQaOwLWeZdWERYnIaFYHBc+U5F6oqKbF9t1EP7Q/NlmSlE4u1a
         Crr0Ky35PJ2I5en6k6egDs0TmKd06OD607OOydd8aSb0VmYLAg4DHc0SHMilnYcTTYAV
         buMn4UOoLQ4DpvFAqQntl07ruvKBHNMAUNzok98HfQX6zvBefVWsfzkmXCvwE9le03Gr
         M+vg==
X-Gm-Message-State: AOJu0YzWjnzvT4pPI4f/BY6FrdGIzbyjhP1pX2fm0o7sGCstDPO3jMy4
	HnX0gyWg66ZZRVmYVoxuqM9q/eJY+ohIaA==
X-Google-Smtp-Source: AGHT+IG5reTqG8Yvq4CMQgUdziEFDLVEbh1UdwfiU1QQ/mDNeCIBW3ysY/4DCD+MVXyZwQKOd4xmTw==
X-Received: by 2002:a0d:dd8d:0:b0:589:fb3b:9e67 with SMTP id g135-20020a0ddd8d000000b00589fb3b9e67mr1073351ywe.5.1692414112405;
        Fri, 18 Aug 2023 20:01:52 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:a059:9262:e315:4c20])
        by smtp.gmail.com with ESMTPSA id o199-20020a0dccd0000000b005704c4d3579sm903897ywd.40.2023.08.18.20.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 20:01:52 -0700 (PDT)
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
Subject: [RFC bpf-next v4 5/6] bpf: Add a new dynptr type for CGRUP_SOCKOPT.
Date: Fri, 18 Aug 2023 20:01:42 -0700
Message-Id: <20230819030143.419729-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230819030143.419729-1-thinker.li@gmail.com>
References: <20230819030143.419729-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 include/linux/bpf.h    |   7 ++-
 include/linux/filter.h |   4 ++
 kernel/bpf/btf.c       |   3 +
 kernel/bpf/cgroup.c    |   5 +-
 kernel/bpf/helpers.c   | 140 +++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c  |  38 ++++++++++-
 6 files changed, 193 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 40a3d392b7f1..aad34298bfd3 100644
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
@@ -1208,6 +1211,8 @@ enum bpf_dynptr_type {
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
index 1b2006dac4d5..b27a4fbc6ffe 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1866,6 +1866,8 @@ static int filter_setsockopt_progs_cb(void *arg,
 	if (max_optlen < 0)
 		return max_optlen;
 
+	ctx->flags = BPF_SOCKOPT_FLAG_OPTVAL_REPLACE;
+
 	if (copy_from_user(ctx->optval, optval,
 			   min(ctx->optlen, max_optlen)) != 0)
 		return -EFAULT;
@@ -1894,7 +1896,8 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 	ctx.optlen = *optlen;
 	ctx.optval = optval;
 	ctx.optval_end = optval + *optlen;
-	ctx.flags = BPF_SOCKOPT_FLAG_OPTVAL_USER;
+	ctx.flags = BPF_SOCKOPT_FLAG_OPTVAL_USER |
+		BPF_SOCKOPT_FLAG_OPTVAL_REPLACE;
 
 	lock_sock(sk);
 	ret = bpf_prog_run_array_cg_cb(&cgrp->bpf, CGROUP_SETSOCKOPT,
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index eb91cae0612a..5be1fd9e64f3 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1519,6 +1519,51 @@ static const struct bpf_func_proto bpf_dynptr_from_mem_proto = {
 	.arg4_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL | MEM_UNINIT,
 };
 
+static int __bpf_sockopt_store_bytes(struct bpf_sockopt_kern *sopt, u32 offset,
+				     void *src, u32 len)
+{
+	int buf_len, err;
+	void *buf;
+
+	if (!src)
+		return 0;
+
+	if (sopt->flags & BPF_SOCKOPT_FLAG_OPTVAL_USER) {
+		if (!(sopt->flags & BPF_SOCKOPT_FLAG_OPTVAL_REPLACE))
+			return copy_to_user(sopt->optval + offset, src, len) ?
+				-EFAULT : 0;
+		buf_len = sopt->optval_end - sopt->optval;
+		buf = kmalloc(buf_len, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+		err = copy_from_user(buf, sopt->optval, buf_len) ? -EFAULT : 0;
+		if (err < 0) {
+			kfree(buf);
+			return err;
+		}
+		sopt->optval = buf;
+		sopt->optval_end = buf + len;
+		sopt->flags &= ~BPF_SOCKOPT_FLAG_OPTVAL_USER;
+		memcpy(buf + offset, src, len);
+	}
+
+	memcpy(sopt->optval + offset, src, len);
+
+	return 0;
+}
+
+static int __bpf_sockopt_load_bytes(struct bpf_sockopt_kern *sopt, u32 offset,
+				    void *dst, u32 len)
+{
+	if (sopt->flags & BPF_SOCKOPT_FLAG_OPTVAL_USER)
+		return copy_from_user(dst, sopt->optval + offset, len) ?
+			-EFAULT : 0;
+
+	memcpy(dst, sopt->optval + offset, len);
+
+	return 0;
+}
+
 BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, const struct bpf_dynptr_kern *, src,
 	   u32, offset, u64, flags)
 {
@@ -1547,6 +1592,8 @@ BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, const struct bpf_dynptr_kern
 		return __bpf_skb_load_bytes(src->data, src->offset + offset, dst, len);
 	case BPF_DYNPTR_TYPE_XDP:
 		return __bpf_xdp_load_bytes(src->data, src->offset + offset, dst, len);
+	case BPF_DYNPTR_TYPE_CGROUP_SOCKOPT:
+		return __bpf_sockopt_load_bytes(src->data, src->offset + offset, dst, len);
 	default:
 		WARN_ONCE(true, "bpf_dynptr_read: unknown dynptr type %d\n", type);
 		return -EFAULT;
@@ -1597,6 +1644,10 @@ BPF_CALL_5(bpf_dynptr_write, const struct bpf_dynptr_kern *, dst, u32, offset, v
 		if (flags)
 			return -EINVAL;
 		return __bpf_xdp_store_bytes(dst->data, dst->offset + offset, src, len);
+	case BPF_DYNPTR_TYPE_CGROUP_SOCKOPT:
+		return __bpf_sockopt_store_bytes(dst->data,
+						 dst->offset + offset,
+						 src, len);
 	default:
 		WARN_ONCE(true, "bpf_dynptr_write: unknown dynptr type %d\n", type);
 		return -EFAULT;
@@ -1634,6 +1685,7 @@ BPF_CALL_3(bpf_dynptr_data, const struct bpf_dynptr_kern *, ptr, u32, offset, u3
 	switch (type) {
 	case BPF_DYNPTR_TYPE_LOCAL:
 	case BPF_DYNPTR_TYPE_RINGBUF:
+	case BPF_DYNPTR_TYPE_CGROUP_SOCKOPT:
 		return (unsigned long)(ptr->data + ptr->offset + offset);
 	case BPF_DYNPTR_TYPE_SKB:
 	case BPF_DYNPTR_TYPE_XDP:
@@ -2278,6 +2330,8 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset
 		bpf_xdp_copy_buf(ptr->data, ptr->offset + offset, buffer__opt, len, false);
 		return buffer__opt;
 	}
+	case BPF_DYNPTR_TYPE_CGROUP_SOCKOPT:
+		return NULL;
 	default:
 		WARN_ONCE(true, "unknown dynptr type %d\n", type);
 		return NULL;
@@ -2429,6 +2483,80 @@ __bpf_kfunc void bpf_rcu_read_unlock(void)
 	rcu_read_unlock();
 }
 
+__bpf_kfunc int bpf_sockopt_dynptr_release(struct bpf_sockopt *sopt,
+					   struct bpf_dynptr_kern *ptr)
+{
+	bpf_dynptr_set_null(ptr);
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
+__bpf_kfunc int bpf_dynptr_from_sockopt(struct bpf_sockopt *sopt,
+					struct bpf_dynptr_kern *ptr__uninit)
+{
+	struct bpf_sockopt_kern *sopt_kern = (struct bpf_sockopt_kern *)sopt;
+	unsigned int size;
+
+	size = sopt_kern->optval_end - sopt_kern->optval;
+
+	bpf_dynptr_init(ptr__uninit, sopt,
+			BPF_DYNPTR_TYPE_CGROUP_SOCKOPT, 0,
+			size);
+
+	return size;
+}
+
+__bpf_kfunc int bpf_sockopt_grow_to(struct bpf_sockopt *sopt,
+				    u32 newsize)
+{
+	struct bpf_sockopt_kern *sopt_kern = (struct bpf_sockopt_kern *)sopt;
+	void *newoptval;
+	int err;
+
+	if (newsize > DYNPTR_MAX_SIZE)
+		return -EINVAL;
+
+	if (newsize <= sopt_kern->optlen)
+		return 0;
+
+	if (sopt_kern->flags & BPF_SOCKOPT_FLAG_OPTVAL_USER) {
+		newoptval = kmalloc(newsize, GFP_KERNEL);
+		if (!newoptval)
+			return -ENOMEM;
+		err = copy_from_user(newoptval, sopt_kern->optval,
+				     sopt_kern->optval_end - sopt_kern->optval);
+		if (err < 0) {
+			kfree(newoptval);
+			return err;
+		}
+		sopt_kern->flags &= ~BPF_SOCKOPT_FLAG_OPTVAL_USER;
+	} else {
+		newoptval = krealloc(sopt_kern->optval, newsize, GFP_KERNEL);
+		if (!newoptval)
+			return -ENOMEM;
+	}
+
+	sopt_kern->optval = newoptval;
+	sopt_kern->optval_end = newoptval + newsize;
+
+	return 0;
+}
+
 __diag_pop();
 
 BTF_SET8_START(generic_btf_ids)
@@ -2494,6 +2622,17 @@ static const struct btf_kfunc_id_set common_kfunc_set = {
 	.set   = &common_btf_ids,
 };
 
+BTF_SET8_START(cgroup_common_btf_ids)
+BTF_ID_FLAGS(func, bpf_sockopt_dynptr_release, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_dynptr_from_sockopt, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_sockopt_grow_to, KF_SLEEPABLE)
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
@@ -2513,6 +2652,7 @@ static int __init kfunc_init(void)
 	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCKOPT, &cgroup_kfunc_set);
 	ret = ret ?: register_btf_id_dtor_kfuncs(generic_dtors,
 						  ARRAY_SIZE(generic_dtors),
 						  THIS_MODULE);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 83731e998b09..15119ff90bff 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -755,6 +755,8 @@ static const char *dynptr_type_str(enum bpf_dynptr_type type)
 		return "skb";
 	case BPF_DYNPTR_TYPE_XDP:
 		return "xdp";
+	case BPF_DYNPTR_TYPE_CGROUP_SOCKOPT:
+		return "cgroup_sockopt";
 	case BPF_DYNPTR_TYPE_INVALID:
 		return "<invalid>";
 	default:
@@ -836,6 +838,8 @@ static enum bpf_dynptr_type arg_to_dynptr_type(enum bpf_arg_type arg_type)
 		return BPF_DYNPTR_TYPE_SKB;
 	case DYNPTR_TYPE_XDP:
 		return BPF_DYNPTR_TYPE_XDP;
+	case DYNPTR_TYPE_CGROUP_SOCKOPT:
+		return BPF_DYNPTR_TYPE_CGROUP_SOCKOPT;
 	default:
 		return BPF_DYNPTR_TYPE_INVALID;
 	}
@@ -852,6 +856,8 @@ static enum bpf_type_flag get_dynptr_type_flag(enum bpf_dynptr_type type)
 		return DYNPTR_TYPE_SKB;
 	case BPF_DYNPTR_TYPE_XDP:
 		return DYNPTR_TYPE_XDP;
+	case BPF_DYNPTR_TYPE_CGROUP_SOCKOPT:
+		return DYNPTR_TYPE_CGROUP_SOCKOPT;
 	default:
 		return 0;
 	}
@@ -859,7 +865,8 @@ static enum bpf_type_flag get_dynptr_type_flag(enum bpf_dynptr_type type)
 
 static bool dynptr_type_refcounted(enum bpf_dynptr_type type)
 {
-	return type == BPF_DYNPTR_TYPE_RINGBUF;
+	return type == BPF_DYNPTR_TYPE_RINGBUF ||
+		type == BPF_DYNPTR_TYPE_CGROUP_SOCKOPT;
 }
 
 static void __mark_dynptr_reg(struct bpf_reg_state *reg,
@@ -10300,6 +10307,8 @@ enum special_kfunc_type {
 	KF_bpf_dynptr_slice,
 	KF_bpf_dynptr_slice_rdwr,
 	KF_bpf_dynptr_clone,
+	KF_bpf_sockopt_dynptr_release,
+	KF_bpf_dynptr_from_sockopt,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -10320,6 +10329,8 @@ BTF_ID(func, bpf_dynptr_from_xdp)
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
 BTF_ID(func, bpf_dynptr_clone)
+BTF_ID(func, bpf_sockopt_dynptr_release)
+BTF_ID(func, bpf_dynptr_from_sockopt)
 BTF_SET_END(special_kfunc_set)
 
 BTF_ID_LIST(special_kfunc_list)
@@ -10342,6 +10353,8 @@ BTF_ID(func, bpf_dynptr_from_xdp)
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
 BTF_ID(func, bpf_dynptr_clone)
+BTF_ID(func, bpf_sockopt_dynptr_release)
+BTF_ID(func, bpf_dynptr_from_sockopt)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -10995,6 +11008,19 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			arg_type |= OBJ_RELEASE;
 			break;
 		case KF_ARG_PTR_TO_DYNPTR:
+			if (meta->func_id == special_kfunc_list[KF_bpf_sockopt_dynptr_release]) {
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
@@ -11082,6 +11108,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 					verbose(env, "verifier internal error: missing ref obj id for parent of clone\n");
 					return -EFAULT;
 				}
+			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_sockopt] &&
+				   (dynptr_arg_type & MEM_UNINIT)) {
+				dynptr_arg_type |= DYNPTR_TYPE_CGROUP_SOCKOPT;
 			}
 
 			ret = process_dynptr_func(env, regno, insn_idx, dynptr_arg_type, clone_ref_obj_id);
@@ -11390,7 +11419,12 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	 * PTR_TO_BTF_ID in bpf_kfunc_arg_meta, do the release now.
 	 */
 	if (meta.release_regno) {
-		err = release_reference(env, regs[meta.release_regno].ref_obj_id);
+		verbose(env, "release refcounted PTR_TO_BTF_ID %s\n",
+			meta.func_name);
+		if (meta.func_id == special_kfunc_list[KF_bpf_sockopt_dynptr_release])
+			err = unmark_stack_slots_dynptr(env, &regs[meta.release_regno]);
+		else
+			err = release_reference(env, regs[meta.release_regno].ref_obj_id);
 		if (err) {
 			verbose(env, "kfunc %s#%d reference has not been acquired before\n",
 				func_name, meta.func_id);
-- 
2.34.1


