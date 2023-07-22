Return-Path: <bpf+bounces-5667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AA175DA36
	for <lists+bpf@lfdr.de>; Sat, 22 Jul 2023 07:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 576752824DA
	for <lists+bpf@lfdr.de>; Sat, 22 Jul 2023 05:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76633DF61;
	Sat, 22 Jul 2023 05:23:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAB78BEC
	for <bpf@vger.kernel.org>; Sat, 22 Jul 2023 05:23:01 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E3A35A1
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 22:22:58 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-579ed2829a8so31253017b3.1
        for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 22:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690003377; x=1690608177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ju8JzguvwWcZgvT0E7BFe/QexbaqNyjWoGuuz+JUBIo=;
        b=H1uYtD/UvhQf7vame9qGVmgvmXGXlik5jHXfN+WFmMU5VSAteTd/KowVBm68Ns+iGx
         tdhThx8dGX6fTsKfYZWreWnvQ25W0kjc5Kfe61jMPoCP2TyghhtTjk+Bl6iLQ2UQwK7Z
         IEJuRbVVBWCGxLdFT8XCEFbKrQPEEf/0MjpzLy3IB/2T6LKVjCrfkWEQFi3/75qkGs2F
         +R/RbW5PS3zM1RaVhmsx07mJJW0OATcKrzy9L77b6pyRa1w4TJpox+Qvu97WPWhE84BG
         FzKNGmRrhA+yAFK9KkS96tIU7N4TiZJfuNDTX22L7VnhSalq9baJ2cvYPi0Za5iS4v6M
         h2MA==
X-Gm-Message-State: ABy/qLZmzUPvypNMxk5rKjW4yMLZ9XNtIddGWmT6wgI1kxVyL9LpWR0x
	XhTyhKrcs4lLIe3Ph4zFUWndMZSCwMhBPA==
X-Google-Smtp-Source: APBJJlGWwFs6An5LRgvTmlTzpo70AZ39GG0usBEEf2vZAVCrlqYAg44F9V0DnK3vppkcRgNl0GdJzw==
X-Received: by 2002:a81:bf53:0:b0:577:606b:735e with SMTP id s19-20020a81bf53000000b00577606b735emr1884120ywk.37.1690003375294;
        Fri, 21 Jul 2023 22:22:55 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:c289:3eeb:eb78:fe3b])
        by smtp.gmail.com with ESMTPSA id y191-20020a0dd6c8000000b00577335ea38csm1397829ywd.121.2023.07.21.22.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 22:22:55 -0700 (PDT)
From: kuifeng@meta.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	Kui-Feng Lee <kuifeng@meta.com>
Subject: [RFC bpf-next 3/5] bpf: Add a new dynptr type for CGRUP_SOCKOPT.
Date: Fri, 21 Jul 2023 22:22:46 -0700
Message-Id: <20230722052248.1062582-4-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722052248.1062582-1-kuifeng@meta.com>
References: <20230722052248.1062582-1-kuifeng@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <kuifeng@meta.com>

The new dynptr type (BPF_DYNPTR_TYPE_CGROUP_SOCKOPT) will be used by BPF
programs to create a buffer that can be installed on ctx to replace
exisiting optval or user_optval.

This feature is only allowed if ctx->flags & BPF_SOCKOPT_FLAG_OPTVAL_ALLOC
is true. It is enabled only for sleepable programs on the cgroup/setsockopt
hook.  BPF programs can install a new buffer holding by a dynptr to
increase the size of optval passed to setsockopt().

It is not enabled for cgroup/getsockopt since you can not increased a
buffer created, by user program, to return data from getsockopt().

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 include/linux/bpf.h            |  7 +++-
 include/uapi/linux/bpf.h       |  2 +
 kernel/bpf/btf.c               |  3 ++
 kernel/bpf/cgroup.c            |  3 +-
 kernel/bpf/helpers.c           | 73 ++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c          | 43 +++++++++++++++++++-
 tools/include/uapi/linux/bpf.h |  2 +
 7 files changed, 129 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ceaa8c23287f..40eede696ac5 100644
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
index b2f81193f97b..13bdf8e78d01 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7144,6 +7144,8 @@ struct bpf_sockopt {
 enum bpf_sockopt_flags {
 	/* optval is a pointer to user space memory */
 	BPF_SOCKOPT_FLAG_OPTVAL_USER	= (1U << 0),
+	/* able to allocate and install new optval */
+	BPF_SOCKOPT_FLAG_OPTVAL_ALLOC	= (1U << 1),
 };
 
 struct bpf_pidns_info {
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index ef9581a580e2..718494edbfc6 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -216,6 +216,7 @@ enum btf_kfunc_hook {
 	BTF_KFUNC_HOOK_SOCKET_FILTER,
 	BTF_KFUNC_HOOK_LWT,
 	BTF_KFUNC_HOOK_NETFILTER,
+	BTF_KFUNC_HOOK_CGROUP_SOCKOPT,
 	BTF_KFUNC_HOOK_MAX,
 };
 
@@ -7845,6 +7846,8 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 		return BTF_KFUNC_HOOK_LWT;
 	case BPF_PROG_TYPE_NETFILTER:
 		return BTF_KFUNC_HOOK_NETFILTER;
+	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
+		return BTF_KFUNC_HOOK_CGROUP_SOCKOPT;
 	default:
 		return BTF_KFUNC_HOOK_MAX;
 	}
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 8e3a615f3fc8..f42e76501e1c 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1847,7 +1847,8 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 		ctx.optlen = *optlen;
 		ctx.user_optval = optval;
 		ctx.user_optval_end = optval + *optlen;
-		ctx.flags = BPF_SOCKOPT_FLAG_OPTVAL_USER;
+		ctx.flags = BPF_SOCKOPT_FLAG_OPTVAL_USER |
+			BPF_SOCKOPT_FLAG_OPTVAL_ALLOC;
 	} else {
 		/* Allocate a bit more than the initial user buffer for
 		 * BPF program. The canonical use case is overriding
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 5b1a62c20bb8..92ec80e3a5d3 100644
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
@@ -2449,6 +2453,72 @@ __bpf_kfunc void bpf_rcu_read_unlock(void)
 	rcu_read_unlock();
 }
 
+__bpf_kfunc int bpf_sockopt_alloc_optval(struct bpf_sockopt *sopt, int size,
+					 struct bpf_dynptr_kern *ptr__uninit)
+{
+	struct bpf_sockopt_kern *sopt_kern = (struct bpf_sockopt_kern *)sopt;
+	void *optval;
+	int err;
+
+	if (!(sopt_kern->flags & BPF_SOCKOPT_FLAG_OPTVAL_ALLOC))
+		return -EINVAL;
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
+__bpf_kfunc int bpf_sockopt_install_optval(struct bpf_sockopt *sopt,
+					   struct bpf_dynptr_kern *ptr)
+{
+	struct bpf_sockopt_kern *sopt_kern = (struct bpf_sockopt_kern *)sopt;
+
+	if (!(sopt_kern->flags & BPF_SOCKOPT_FLAG_OPTVAL_ALLOC) ||
+	    bpf_dynptr_get_type(ptr) != BPF_DYNPTR_TYPE_CGROUP_SOCKOPT ||
+	    !ptr->data)
+		return -EINVAL;
+
+	if (sopt_kern->optval &&
+	    !(sopt_kern->flags & BPF_SOCKOPT_FLAG_OPTVAL_USER))
+		kfree(sopt_kern->optval);
+
+	sopt_kern->optval = ptr->data;
+	sopt_kern->optval_end = ptr->data + __bpf_dynptr_size(ptr);
+	sopt_kern->user_optval = NULL;
+	sopt_kern->user_optval_end = NULL;
+	sopt_kern->optlen = __bpf_dynptr_size(ptr);
+	sopt_kern->flags &= ~BPF_SOCKOPT_FLAG_OPTVAL_USER;
+
+	bpf_dynptr_set_null(ptr);
+
+	return 0;
+}
+
+__bpf_kfunc int bpf_sockopt_release_optval(struct bpf_sockopt *sopt,
+					   struct bpf_dynptr_kern *ptr)
+{
+	struct bpf_sockopt_kern *sopt_kern = (struct bpf_sockopt_kern *)sopt;
+
+	if (!(sopt_kern->flags & BPF_SOCKOPT_FLAG_OPTVAL_ALLOC) ||
+	    bpf_dynptr_get_type(ptr) != BPF_DYNPTR_TYPE_CGROUP_SOCKOPT ||
+	    !ptr->data)
+		return -EINVAL;
+
+	kfree(ptr->data);
+	bpf_dynptr_set_null(ptr);
+
+	return 0;
+}
+
 __diag_pop();
 
 BTF_SET8_START(generic_btf_ids)
@@ -2517,6 +2587,9 @@ static const struct btf_kfunc_id_set common_kfunc_set = {
 
 BTF_SET8_START(cgroup_common_btf_ids)
 BTF_ID_FLAGS(func, bpf_copy_to_user, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_sockopt_alloc_optval)
+BTF_ID_FLAGS(func, bpf_sockopt_install_optval)
+BTF_ID_FLAGS(func, bpf_sockopt_release_optval)
 BTF_SET8_END(cgroup_common_btf_ids)
 
 static const struct btf_kfunc_id_set cgroup_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8cb25a775119..53e133525dc1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -744,6 +744,8 @@ static const char *dynptr_type_str(enum bpf_dynptr_type type)
 		return "skb";
 	case BPF_DYNPTR_TYPE_XDP:
 		return "xdp";
+	case BPF_DYNPTR_TYPE_CGROUP_SOCKOPT:
+		return "cgroup_sockopt";
 	case BPF_DYNPTR_TYPE_INVALID:
 		return "<invalid>";
 	default:
@@ -825,6 +827,8 @@ static enum bpf_dynptr_type arg_to_dynptr_type(enum bpf_arg_type arg_type)
 		return BPF_DYNPTR_TYPE_SKB;
 	case DYNPTR_TYPE_XDP:
 		return BPF_DYNPTR_TYPE_XDP;
+	case DYNPTR_TYPE_CGROUP_SOCKOPT:
+		return BPF_DYNPTR_TYPE_CGROUP_SOCKOPT;
 	default:
 		return BPF_DYNPTR_TYPE_INVALID;
 	}
@@ -841,6 +845,8 @@ static enum bpf_type_flag get_dynptr_type_flag(enum bpf_dynptr_type type)
 		return DYNPTR_TYPE_SKB;
 	case BPF_DYNPTR_TYPE_XDP:
 		return DYNPTR_TYPE_XDP;
+	case BPF_DYNPTR_TYPE_CGROUP_SOCKOPT:
+		return DYNPTR_TYPE_CGROUP_SOCKOPT;
 	default:
 		return 0;
 	}
@@ -848,7 +854,8 @@ static enum bpf_type_flag get_dynptr_type_flag(enum bpf_dynptr_type type)
 
 static bool dynptr_type_refcounted(enum bpf_dynptr_type type)
 {
-	return type == BPF_DYNPTR_TYPE_RINGBUF;
+	return type == BPF_DYNPTR_TYPE_RINGBUF ||
+		type == BPF_DYNPTR_TYPE_CGROUP_SOCKOPT;
 }
 
 static void __mark_dynptr_reg(struct bpf_reg_state *reg,
@@ -10101,6 +10108,9 @@ enum special_kfunc_type {
 	KF_bpf_dynptr_slice,
 	KF_bpf_dynptr_slice_rdwr,
 	KF_bpf_dynptr_clone,
+	KF_bpf_sockopt_alloc_optval,
+	KF_bpf_sockopt_install_optval,
+	KF_bpf_sockopt_release_optval,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -10121,6 +10131,9 @@ BTF_ID(func, bpf_dynptr_from_xdp)
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
 BTF_ID(func, bpf_dynptr_clone)
+BTF_ID(func, bpf_sockopt_alloc_optval)
+BTF_ID(func, bpf_sockopt_install_optval)
+BTF_ID(func, bpf_sockopt_release_optval)
 BTF_SET_END(special_kfunc_set)
 
 BTF_ID_LIST(special_kfunc_list)
@@ -10143,6 +10156,9 @@ BTF_ID(func, bpf_dynptr_from_xdp)
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
 BTF_ID(func, bpf_dynptr_clone)
+BTF_ID(func, bpf_sockopt_alloc_optval)
+BTF_ID(func, bpf_sockopt_install_optval)
+BTF_ID(func, bpf_sockopt_release_optval)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -10796,6 +10812,20 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			arg_type |= OBJ_RELEASE;
 			break;
 		case KF_ARG_PTR_TO_DYNPTR:
+			if (meta->func_id == special_kfunc_list[KF_bpf_sockopt_install_optval] ||
+			    meta->func_id == special_kfunc_list[KF_bpf_sockopt_release_optval]) {
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
@@ -10883,6 +10913,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 					verbose(env, "verifier internal error: missing ref obj id for parent of clone\n");
 					return -EFAULT;
 				}
+			} else if (meta->func_id == special_kfunc_list[KF_bpf_sockopt_alloc_optval] &&
+				   (dynptr_arg_type & MEM_UNINIT)) {
+				dynptr_arg_type |= DYNPTR_TYPE_CGROUP_SOCKOPT;
 			}
 
 			ret = process_dynptr_func(env, regno, insn_idx, dynptr_arg_type, clone_ref_obj_id);
@@ -11191,7 +11224,13 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	 * PTR_TO_BTF_ID in bpf_kfunc_arg_meta, do the release now.
 	 */
 	if (meta.release_regno) {
-		err = release_reference(env, regs[meta.release_regno].ref_obj_id);
+		verbose(env, "release refcounted PTR_TO_BTF_ID %s\n",
+			meta.func_name);
+		if (meta.func_id == special_kfunc_list[KF_bpf_sockopt_install_optval] ||
+		    meta.func_id == special_kfunc_list[KF_bpf_sockopt_release_optval])
+			err = unmark_stack_slots_dynptr(env, &regs[meta.release_regno]);
+		else
+			err = release_reference(env, regs[meta.release_regno].ref_obj_id);
 		if (err) {
 			verbose(env, "kfunc %s#%d reference has not been acquired before\n",
 				func_name, meta.func_id);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index b2f81193f97b..13bdf8e78d01 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7144,6 +7144,8 @@ struct bpf_sockopt {
 enum bpf_sockopt_flags {
 	/* optval is a pointer to user space memory */
 	BPF_SOCKOPT_FLAG_OPTVAL_USER	= (1U << 0),
+	/* able to allocate and install new optval */
+	BPF_SOCKOPT_FLAG_OPTVAL_ALLOC	= (1U << 1),
 };
 
 struct bpf_pidns_info {
-- 
2.34.1


