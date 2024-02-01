Return-Path: <bpf+bounces-20899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D31845029
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 05:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01FAA28FEC5
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 04:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4BC3BB36;
	Thu,  1 Feb 2024 04:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhOLFU2o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743D23B795
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 04:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706761290; cv=none; b=t6YTCxT2FNwu1zV6t9uYkntEGU4QVGMZoiXAFLIEbDtmMNHfD7RnDsceGX6tuPwgfisVKAAoEmCIzUYRoz54qz7FS37YpsWOuLqPHLFTUelPV6ImVUZFsVu5sMIMUXGR0g8caD5WbZt1ciKAYpNphYNrKWig1VqMKoJpR3wYgOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706761290; c=relaxed/simple;
	bh=sBIV6Wl9RHkDMRnh1vsABLcYDEGo4g1ambDgfDE4lIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c3vOswEnnKHLI1GQNS52hUq/9kjhpuOSfdpVVCoTNFAvzEjUfN1B/6vTnbD/vGIo6Uz8/c+YGey26IOb1M1YCoCOikQKPnKUV1xkUKz8eXYKELQNu35Jlq8Cr7RWKo6GyCERwawd4r2uUZI4p6O5JTM2JaSLtCo1aQBQnmQQta8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhOLFU2o; arc=none smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-2d0600551e8so6389881fa.0
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 20:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706761286; x=1707366086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7MaNjw8a51AIAgFfdQM8x4xHcs+fnZB56LSdgMMeYA=;
        b=QhOLFU2oL0wKp29OrwwctT7uqHKB4qxfGwY1n0z1Qi68lWQ9J8lwM7ektTocTpzwXq
         BKwAhDpxk2ZFdHD4KTkWO3LjhM4hYycs50jMCGc5KAa4UcxA6e4slilClcPwUfEdEkzn
         nlMdtep+xIZriuPBdrwwNeiZ0w08MTzIfuXcaW+HIy48wgMFd5jLzpSISkJLb2PHpNZl
         g2JhYCf16QV5RbjsgCl26ThLd5rzJDqQx7VyosXSfaRmU+TgRKC0bQ9Gq3ZSA9XwyZRL
         M2whsJ8/i6Ies+HgrAUM0JRWFtfwGDVnNvAcsywpd0zz1zZxhxZyA4qzYKHQKQcZzDAD
         64zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706761286; x=1707366086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7MaNjw8a51AIAgFfdQM8x4xHcs+fnZB56LSdgMMeYA=;
        b=Ce5xALZNyY18MmfeTYVwgKEwHJGvvMQ5eiqEWIxICnJ5IW1XoL9n5kr50oba8I3Wfq
         pIk+hJRXzMTH+Wz+W/CzHDIHIh/SMpGwxVeVS6F2QlcoDuioWlsuJ8YaatGXT98MYRxO
         JBwKzGvqYmu/J2J071rOamvaCNAwZYc3np6cFDfS4TzbJf0GFTS/j7SqCvIrnjUjJirj
         0UmeRiNz6dU6Hi0FQCYEHTxPLvdKoUUm3f1WgIgfbCI0kLgM8vIuxXx8Z3+nhiLHXvUp
         c01OgjpQzrtq3XLxVbBIojfv6RiVOG3TGYx/FfwuxyhdWk+phWrplzJxL6GDPgBH/Vw2
         OdEg==
X-Gm-Message-State: AOJu0YztRCikvuvVqQz/knFlRv3K2b3y7mh8KeSS0yBFMyTRIIQsemHL
	OBc9aASmlnraizweFE5aJ9pMVhQg8q4wo1T6JayLwo5+IKflgnxUmc8HMoZnTgU=
X-Google-Smtp-Source: AGHT+IFbGPrnUo22ypTMw92PfcfgDUjBRQ/t9g3Fme4tG4rCZzAgOKtaDslMBhEDpBGWF+rAbypz4w==
X-Received: by 2002:a05:6512:1046:b0:510:1b51:e431 with SMTP id c6-20020a056512104600b005101b51e431mr922204lfb.4.1706761286153;
        Wed, 31 Jan 2024 20:21:26 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id pv13-20020a170907208d00b00a35b708185esm3979717ejb.71.2024.01.31.20.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 20:21:25 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>,
	Raj Sahu <rjsu26@vt.edu>,
	Dan Williams <djwillia@vt.edu>,
	Rishabh Iyer <rishabh.iyer@epfl.ch>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [RFC PATCH v1 10/14] bpf, x86: Implement runtime resource cleanup for exceptions
Date: Thu,  1 Feb 2024 04:21:05 +0000
Message-Id: <20240201042109.1150490-11-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240201042109.1150490-1-memxor@gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14238; i=memxor@gmail.com; h=from:subject; bh=sBIV6Wl9RHkDMRnh1vsABLcYDEGo4g1ambDgfDE4lIQ=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBluxwPokv+N84diq7OXurgPSnkvSchzZAM/sp5F vhd0B3JVJWJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZbscDwAKCRBM4MiGSL8R yiqaEACDHlBTBlzBgKWah8mU7e8A6YGpl75GZDhxf29s3PDNn+tnbpMQq0cON2jG/I41VqgxZVz l0iDMvCPC2Oor3nlTMVG6dFD3ikJ/yGTh0uvf6mZe/Uwp6MDR0hW235IjAc5jpwSjmttZ91Caic mxIAXHa4aXHkFqIhtHOsU6O98jcGD+k0puiVSrjIdf335jX/vuH+kk18ktWqMlBPBacBw6bJDsO gA8Ylz7oOA2ckJA3qlt+nw3DBFMOz/g/huoliThvyjQYYG/En4iiaDvPXP1mWXTEC6aMMZ12Zq3 G+4T+djDN5wSlYE9dMm4IA3+YRB+GNz18DYo8ZfhjODI0B3MVndJl7R5cSBkluF4gPYsfwrZcvq psh9yW/jieH4TPOmWRTgGwd9XkR0t2aGuO/1r46CklhOi887QYTcwR3WUnfZZZKvmATeSFGNa/P ZhYkgGIfI1WaJErYAKAwkCdeq3zJNSoI+dPBUuteo5RbmkyNTsmyvt5xS6TpLMVVP/tbPW4SrEB 34m344y72sF6cyzMIZ1eBziOZxoh+pRDFrgVDIXwIV/iNgPWMfPWWIxIMZVuofy59PnLcGDQ1Ts imLWzx4AZ0MSZr/xl5LY1tWeOtt5GV55AGrcSoxA5bLQXq47TIgCYo8zZYTr/qmvtkP0adyypCN PLGVDDDjRWtnuBQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Finally, tie all ends together and implement functionality to process a
frame descriptor at runtime for each frame when bpf_throw is called, and
release resources present on the program's stack frames.

For each frame, we do bpf_cleanup_frame_resource, which will use the
instruction pointer at runtime to figure out the right frame descriptor
entry. After this, we explore all stack and registers and call their
respective cleanup procedures.

Next, if the frame corresponds to a subprog, we all save the location of
where it has spilled its callers R6-R9 registers. If so, we record their
value in the unwinding context. Only doing this when each frame has
scratched the register in question allows us to arrive at the set of
values actually needed during the freeing step for registers, regardless
of how many callees existed and the varying locations of spilled callee
saved registers. These registers can also lie across different frames,
but will collected top down when arriving at a frame.

Finally, after doing the cleanup, we go on to execute the exception
callback and finish unwinding the stack.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c |  81 ++++++++++++++++++++++++
 include/linux/bpf.h         |  22 +++++++
 include/linux/filter.h      |   3 +
 kernel/bpf/core.c           |   5 ++
 kernel/bpf/helpers.c        | 121 +++++++++++++++++++++++++++++++++---
 kernel/bpf/verifier.c       |  20 ++++++
 net/core/filter.c           |   5 ++
 7 files changed, 247 insertions(+), 10 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 0dd0791c6ee0..26a96fee2f4e 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3191,6 +3191,11 @@ bool bpf_jit_supports_exceptions(void)
 	return IS_ENABLED(CONFIG_UNWINDER_ORC);
 }
 
+bool bpf_jit_supports_exceptions_cleanup(void)
+{
+	return bpf_jit_supports_exceptions();
+}
+
 void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie)
 {
 #if defined(CONFIG_UNWINDER_ORC)
@@ -3208,6 +3213,82 @@ void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp
 	WARN(1, "verification of programs using bpf_throw should have failed\n");
 }
 
+static int bpf_frame_spilled_caller_reg_off(struct bpf_prog *prog, int regno)
+{
+	int off = 0;
+
+	for (int i = BPF_REG_9; i >= BPF_REG_6; i--) {
+		if (regno == i)
+			return off;
+		if (prog->aux->callee_regs_used[i - BPF_REG_6])
+			off += sizeof(u64);
+	}
+	WARN_ON_ONCE(1);
+	return 0;
+}
+
+void arch_bpf_cleanup_frame_resource(struct bpf_prog *prog, struct bpf_throw_ctx *ctx, u64 ip, u64 sp, u64 bp) {
+	struct bpf_exception_frame_desc_tab *fdtab = prog->aux->fdtab;
+	struct bpf_exception_frame_desc *fd = NULL;
+	u64 ip_off = ip - (u64)prog->bpf_func;
+
+	/* Hidden subprogs and subprogs without fdtab do not need cleanup. */
+	if (bpf_is_hidden_subprog(prog) || !fdtab)
+		goto end;
+
+	for (int i = 0; i < fdtab->cnt; i++) {
+		if (ip_off != fdtab->desc[i]->pc)
+			continue;
+		fd = fdtab->desc[i];
+		break;
+	}
+	/* This should always be found, but let's bail if we cannot find it. */
+	if (WARN_ON_ONCE(!fd))
+		return;
+
+	for (int i = 0; i < fd->stack_cnt; i++) {
+		void *ptr = (void *)((s64)bp + fd->stack[i].off);
+
+		bpf_cleanup_resource(fd->stack + i, ptr);
+	}
+
+	for (int i = 0; i < ARRAY_SIZE(fd->regs); i++) {
+		void *ptr;
+
+		if (!fd->regs[i].regno || fd->regs[i].type == NOT_INIT || fd->regs[i].type == SCALAR_VALUE)
+			continue;
+		/* Our sp will be bp of new frame before caller regs are spilled, so offset is relative to our sp. */
+		WARN_ON_ONCE(!ctx->saved_reg[i]);
+		ptr = (void *)&ctx->saved_reg[i];
+		bpf_cleanup_resource(fd->regs + i, ptr);
+		ctx->saved_reg[i] = 0;
+	}
+end:
+	/* There could be a case where we have something in main R6, R7, R8, R9 that
+	 * needs releasing, and the callchain is as follows:
+	 * main -> subprog1 -> subprog2 -> bpf_throw_tramp -> bpf_throw
+	 * In such a case, subprog1 may use only R6, R7 and subprog2 may use R8, R9 being unscratched until
+	 * subprog2 calls bpf_throw. In that case, subprog2 will spill R6-R9. The
+	 * loop below when we are called for each subprog in order will ensure we have the correct saved_reg
+	 * from the PoV of the current bpf_prog corresponding to a frame.
+	 * E.g. in the chain main -> s1 -> s2 -> bpf_throw_tramp -> bpf_throw
+	 * Let's say R6-R9 have values A, B, C, D in main when calling subprog1.
+	 * Below, we show the computed saved_regs values as we walk the stack:
+	 * For bpf_throw_tramp, saved_regs = { 0, 0, 0, 0 }
+	 * For s2, saved_regs = { 0, 0, 0, D } // D loaded from bpf_throw_tramp frame
+	 * For s1, saved_regs = { 0, 0, C, D } // C loaded from subprog2 frame
+	 * For main, saved_regs = { A, B, C, D } // A, B loaded from subprog1 frame
+	 * Thus, for main, we have the correct saved_regs values even though they
+	 * were spilled in multiple callee stack frames down the call chain.
+	 */
+	if (bpf_is_subprog(prog)) {
+		for (int i = 0; i < ARRAY_SIZE(prog->aux->callee_regs_used); i++) {
+			if (prog->aux->callee_regs_used[i])
+				ctx->saved_reg[i] = *(u64 *)((s64)sp + bpf_frame_spilled_caller_reg_off(prog, BPF_REG_6 + i));
+		}
+	}
+}
+
 void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
 			       struct bpf_prog *new, struct bpf_prog *old)
 {
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e310d3ceb14e..a7c8c118c534 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3402,4 +3402,26 @@ struct bpf_exception_frame_desc_tab {
 
 void bpf_exception_frame_desc_tab_free(struct bpf_exception_frame_desc_tab *fdtab);
 
+struct bpf_throw_ctx {
+	struct bpf_prog_aux *aux;
+	u64 sp;
+	u64 bp;
+	union {
+		struct {
+			u64 saved_r6;
+			u64 saved_r7;
+			u64 saved_r8;
+			u64 saved_r9;
+		};
+		u64 saved_reg[4];
+	};
+	int cnt;
+};
+
+void arch_bpf_cleanup_frame_resource(struct bpf_prog *prog, struct bpf_throw_ctx *ctx, u64 ip, u64 sp, u64 bp);
+void bpf_cleanup_resource(struct bpf_frame_desc_reg_entry *fd, void *ptr);
+int bpf_cleanup_resource_reg(struct bpf_frame_desc_reg_entry *fd, void *ptr);
+int bpf_cleanup_resource_dynptr(struct bpf_frame_desc_reg_entry *fd, void *ptr);
+int bpf_cleanup_resource_iter(struct bpf_frame_desc_reg_entry *fd, void *ptr);
+
 #endif /* _LINUX_BPF_H */
diff --git a/include/linux/filter.h b/include/linux/filter.h
index fee070b9826e..9779d8281a59 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -955,6 +955,7 @@ bool bpf_jit_supports_subprog_tailcalls(void);
 bool bpf_jit_supports_kfunc_call(void);
 bool bpf_jit_supports_far_kfunc_call(void);
 bool bpf_jit_supports_exceptions(void);
+bool bpf_jit_supports_exceptions_cleanup(void);
 bool bpf_jit_supports_ptr_xchg(void);
 void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie);
 bool bpf_helper_changes_pkt_data(void *func);
@@ -1624,4 +1625,6 @@ static inline void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off, voi
 }
 #endif /* CONFIG_NET */
 
+void bpf_sk_release_dtor(void *ptr);
+
 #endif /* __LINUX_FILTER_H__ */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 995a4dcfa970..6e6260c1e926 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2979,6 +2979,11 @@ bool __weak bpf_jit_supports_exceptions(void)
 	return false;
 }
 
+bool __weak bpf_jit_supports_exceptions_cleanup(void)
+{
+	return false;
+}
+
 void __weak arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie)
 {
 }
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 4db1c658254c..304fe26cba65 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2011-2014 PLUMgrid, http://plumgrid.com
  */
 #include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
 #include <linux/btf.h>
 #include <linux/bpf-cgroup.h>
 #include <linux/cgroup.h>
@@ -2499,12 +2500,113 @@ __bpf_kfunc void bpf_rcu_read_unlock(void)
 	rcu_read_unlock();
 }
 
-struct bpf_throw_ctx {
-	struct bpf_prog_aux *aux;
-	u64 sp;
-	u64 bp;
-	int cnt;
-};
+int bpf_cleanup_resource_reg(struct bpf_frame_desc_reg_entry *fd, void *ptr)
+{
+	u64 reg_value = ptr ? *(u64 *)ptr : 0;
+	struct btf_struct_meta *meta;
+	const struct btf_type *t;
+	u32 dtor_id;
+
+	switch (fd->type) {
+	case PTR_TO_SOCKET:
+	case PTR_TO_TCP_SOCK:
+	case PTR_TO_SOCK_COMMON:
+		if (reg_value)
+			bpf_sk_release_dtor((void *)reg_value);
+		return 0;
+	case PTR_TO_MEM | MEM_RINGBUF:
+		if (reg_value)
+			bpf_ringbuf_discard_proto.func(reg_value, 0, 0, 0, 0);
+		return 0;
+	case PTR_TO_BTF_ID | MEM_ALLOC:
+	case PTR_TO_BTF_ID | MEM_ALLOC | MEM_PERCPU:
+		if (!reg_value)
+			return 0;
+		meta = btf_find_struct_meta(fd->btf, fd->btf_id);
+		if (fd->type & MEM_PERCPU)
+			bpf_percpu_obj_drop_impl((void *)reg_value, meta);
+		else
+			bpf_obj_drop_impl((void *)reg_value, meta);
+		return 0;
+	case PTR_TO_BTF_ID:
+#ifdef CONFIG_NET
+		if (bsearch(&fd->btf_id, btf_sock_ids, MAX_BTF_SOCK_TYPE, sizeof(btf_sock_ids[0]), btf_id_cmp_func)) {
+			if (reg_value)
+				bpf_sk_release_dtor((void *)reg_value);
+			return 0;
+		}
+#endif
+		dtor_id = btf_find_dtor_kfunc(fd->btf, fd->btf_id, BPF_DTOR_KPTR | BPF_DTOR_CLEANUP);
+		if (dtor_id < 0)
+			return -EINVAL;
+		t = btf_type_by_id(fd->btf, dtor_id);
+		if (!t)
+			return -EINVAL;
+		if (reg_value) {
+			void (*dtor)(void *) = (void *)kallsyms_lookup_name(btf_name_by_offset(fd->btf, t->name_off));
+			dtor((void *)reg_value);
+		}
+		return 0;
+	case SCALAR_VALUE:
+	case NOT_INIT:
+		return 0;
+	default:
+		break;
+	}
+	return -EINVAL;
+}
+
+int bpf_cleanup_resource_dynptr(struct bpf_frame_desc_reg_entry *fd, void *ptr)
+{
+	switch (fd->type) {
+	case BPF_DYNPTR_TYPE_RINGBUF:
+		if (ptr)
+			bpf_ringbuf_discard_dynptr_proto.func((u64)ptr, 0, 0, 0, 0);
+		return 0;
+	default:
+		break;
+	}
+	return -EINVAL;
+}
+
+int bpf_cleanup_resource_iter(struct bpf_frame_desc_reg_entry *fd, void *ptr)
+{
+	const struct btf_type *t;
+	void (*dtor)(void *);
+	u32 dtor_id;
+
+	dtor_id = btf_find_dtor_kfunc(fd->btf, fd->btf_id, BPF_DTOR_CLEANUP);
+	if (dtor_id < 0)
+		return -EINVAL;
+	t = btf_type_by_id(fd->btf, dtor_id);
+	if (!t)
+		return -EINVAL;
+	dtor = (void *)kallsyms_lookup_name(btf_name_by_offset(fd->btf, t->name_off));
+	if (ptr)
+		dtor(ptr);
+	return 0;
+}
+
+void bpf_cleanup_resource(struct bpf_frame_desc_reg_entry *fd, void *ptr)
+{
+	if (!ptr)
+		return;
+	switch (fd->spill_type) {
+	case STACK_DYNPTR:
+		bpf_cleanup_resource_dynptr(fd, ptr);
+		break;
+	case STACK_ITER:
+		bpf_cleanup_resource_iter(fd, ptr);
+		break;
+	case STACK_SPILL:
+	case STACK_INVALID:
+		bpf_cleanup_resource_reg(fd, ptr);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		break;
+	}
+}
 
 static bool bpf_stack_walker(void *cookie, u64 ip, u64 sp, u64 bp)
 {
@@ -2514,13 +2616,12 @@ static bool bpf_stack_walker(void *cookie, u64 ip, u64 sp, u64 bp)
 	if (!is_bpf_text_address(ip))
 		return !ctx->cnt;
 	prog = bpf_prog_ksym_find(ip);
-	ctx->cnt++;
-	if (bpf_is_subprog(prog))
-		return true;
 	ctx->aux = prog->aux;
 	ctx->sp = sp;
 	ctx->bp = bp;
-	return false;
+	arch_bpf_cleanup_frame_resource(prog, ctx, ip, sp, bp);
+	ctx->cnt++;
+	return bpf_is_subprog(prog);
 }
 
 __bpf_kfunc void bpf_throw(u64 cookie)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ec9acadc9ea8..3e3b8a20451c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10216,6 +10216,11 @@ static int gen_exception_frame_desc_reg_entry(struct bpf_verifier_env *env, stru
 	fd.off = off;
 	verbose(env, "frame_desc: frame%d: insn_idx=%d %s=%d size=%d ref_obj_id=%d type=%s\n",
 		frameno, env->insn_idx, off < 0 ? "off" : "regno", off, BPF_REG_SIZE, reg->ref_obj_id, reg_type_str(env, reg->type));
+
+	if (bpf_cleanup_resource_reg(&fd, NULL)) {
+		verbose(env, "frame_desc: frame%d: failed to simulate cleanup for frame desc entry\n", frameno);
+		return -EFAULT;
+	}
 	return push_exception_frame_desc(env, frameno, &fd);
 }
 
@@ -10241,6 +10246,11 @@ static int gen_exception_frame_desc_dynptr_entry(struct bpf_verifier_env *env, s
 		verbose(env, "verifier internal error: refcounted dynptr type unhandled for exception frame descriptor entry\n");
 		return -EFAULT;
 	}
+
+	if (bpf_cleanup_resource_dynptr(&fd, NULL)) {
+		verbose(env, "frame_desc: frame%d: failed to simulate cleanup for frame desc entry\n", frameno);
+		return -EFAULT;
+	}
 	return push_exception_frame_desc(env, frameno, &fd);
 }
 
@@ -10268,6 +10278,11 @@ static int gen_exception_frame_desc_iter_entry(struct bpf_verifier_env *env, str
 		btf_put(btf);
 		return ret;
 	}
+
+	if (bpf_cleanup_resource_iter(&fd, NULL)) {
+		verbose(env, "frame_desc: frame%d: failed to simulate cleanup for frame desc entry\n", frameno);
+		return -EFAULT;
+	}
 	return push_exception_frame_desc(env, frameno, &fd);
 }
 
@@ -10348,6 +10363,11 @@ static int gen_exception_frame_descs(struct bpf_verifier_env *env)
 
 	__mark_reg_not_init(env, &not_init_reg);
 
+	if (!bpf_jit_supports_exceptions_cleanup()) {
+		verbose(env, "JIT does not support cleanup of resources when throwing exceptions\n");
+		return -ENOTSUPP;
+	}
+
 	for (int frameno = env->cur_state->curframe; frameno >= 0; frameno--) {
 		struct bpf_func_state *frame = env->cur_state->frame[frameno];
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 524adf1fa6d0..789e36f79f4c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6912,6 +6912,11 @@ static const struct bpf_func_proto bpf_sk_release_proto = {
 	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON | OBJ_RELEASE,
 };
 
+void bpf_sk_release_dtor(void *ptr)
+{
+	bpf_sk_release((u64)ptr, 0, 0, 0, 0);
+}
+
 BPF_CALL_5(bpf_xdp_sk_lookup_udp, struct xdp_buff *, ctx,
 	   struct bpf_sock_tuple *, tuple, u32, len, u32, netns_id, u64, flags)
 {
-- 
2.40.1


