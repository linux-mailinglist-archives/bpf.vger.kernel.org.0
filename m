Return-Path: <bpf+bounces-19752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27E8830EE0
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 22:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4A6285A3F
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 21:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF71286B9;
	Wed, 17 Jan 2024 21:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2cGaJcc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC10C2557E;
	Wed, 17 Jan 2024 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705528590; cv=none; b=qH9EfUmVw5trauFlX+HuAx4RJRdTfu4rEhGC8HaTKZ/xOAoZtXtoMR9fN0JQj1Uv++4otKBiNBJLWFow8E4PNOgCoJVJfpxUlcQUhBh7rruXbRZ9mqrgO67YQ2xvru+7/RqK2RNLxjBpPRoLt+v7oRx6rfJf0fGhnLKPsh/JC4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705528590; c=relaxed/simple;
	bh=8pbOavnSscO+wB6RQW+gthln+vXcr4SYu4tqvN+dSro=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=FZl+IttjQt1t5bXNc0bTbL37/KLAYENlb/dY4ugdV/ngN52d4aKrvoFvE4xVoOK3dI7qh0N4E4sIzNod55n3eSsvQ3HK3KQns2budpa5uFysbNMkEklPygAO+DrMFGT6LdWgYOlf+kG4diabFWILsC9Fz+UrkHLqMG5+A46xmh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2cGaJcc; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42a0ba5098bso8208951cf.0;
        Wed, 17 Jan 2024 13:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705528587; x=1706133387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdZKs2b8dosnxgwWywIaRPsTh9LO0asJn6WR5363DGI=;
        b=T2cGaJcc6oFXe0+kNZbNY23TUFnmR1WnWi8c5hL5NBIdA7sMI1ulfNIV9GKpQXughQ
         ADG7Qg2P57ybyjmZmrIZcw/4Ywe3W5CqX81H3DEivGWpeiZ8x5dMeHJCaNTPAeSfT21V
         V0AJRDdaRjFR0ZcmXcNVa2XEjHrYY9LLAoC55WMCLXZ0F2wsQmwGXGSjkF58Pbqx9WuJ
         15+DZntMs/u3amCJjVwAmFtGqicik+qoYHHBuLGV0oQ0J9nfCoCEbNPuEVECk0Fkpdbu
         CiWuW36aohdR00tTZu96Gg558KXKlBHBFngcPHAL+ELB3oWcEYANepLM5NqqXP/KAzM4
         wV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705528587; x=1706133387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WdZKs2b8dosnxgwWywIaRPsTh9LO0asJn6WR5363DGI=;
        b=DhBb+f/pa5Xt3ZzTrgIEiAvMCs48Vu6KZQGHKdye9JmXi5J2zheLpNT20hVdBZZIZy
         iAgCq0SqHk3P7gmFAu/pER7u7U8Zm7OhaNuzLQqI8/QUQk1Q58vLGQ7wTgoRqFxts7Hz
         3aOsgRINlbBIgBkvMdcxzhYrDfxvw1iLQq49p7TK77GqurKFnwAZY6f4rKKN7zE5yTGW
         skkopku5WF8WQj9SAvK5iLIz4layWIoyLGbRWRlBABf+lTWBXEHOGOPGQBlYFBleQBN6
         xir1/N+V+J9+3CnEL8TSNCmaCdUbW3RZafmbNsk/CdRWzmhncSoLa8rUUOqIyjM1uvw8
         Bb0A==
X-Gm-Message-State: AOJu0Ywea54B2E//n/R6/65z5AyXfZIg8L+nfCd03VUmTDyFV4C17eFr
	XLYc/8hssyHGDzfUn7YJz64QWpt0hxE=
X-Google-Smtp-Source: AGHT+IFdRFkv7bVBJ2CRO8eDcPFNvI9xuwF8agTzpuHJzS6i66DYAUqfYCljc0812Zh0Fi9Fnt+qzA==
X-Received: by 2002:a05:622a:14f:b0:429:c98e:7fd3 with SMTP id v15-20020a05622a014f00b00429c98e7fd3mr9519296qtw.68.1705528586593;
        Wed, 17 Jan 2024 13:56:26 -0800 (PST)
Received: from n36-183-057.byted.org ([147.160.184.91])
        by smtp.gmail.com with ESMTPSA id hj11-20020a05622a620b00b00428346b88bfsm6105263qtb.65.2024.01.17.13.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 13:56:26 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	yangpeihao@sjtu.edu.cn,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	sdf@google.com,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com
Subject: [RFC PATCH v7 1/8] net_sched: Introduce eBPF based Qdisc
Date: Wed, 17 Jan 2024 21:56:17 +0000
Message-Id: <232881645a5c4c05a35df4ff1f08a19ef9a02662.1705432850.git.amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1705432850.git.amery.hung@bytedance.com>
References: <cover.1705432850.git.amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Cong Wang <xiyou.wangcong@gmail.com>

Introduce a new Qdisc which is completely managed by eBPF program
of type BPF_PROG_TYPE_QDISC. It accepts two eBPF programs of
the same type, but one for enqueue and the other for dequeue.

It interacts with Qdisc layer in two ways:
1) It relies on Qdisc watchdog to handle throttling;
2) It could pass the skb enqueue/dequeue down to child classes

The context is used differently for enqueue and dequeue, as shown below:

┌──────────┬───────────────┬──────────────────────────────────┐
│ prog     │     input     │              output              │
├──────────┼───────────────┼──────────────────────────────────┤
│          │ ctx->skb      │ SCH_BPF_THROTTLE: ctx->expire    │
│          │               │                   ctx->delta_ns  │
│          │ ctx->classid  │                                  │
│          │               │ SCH_BPF_QUEUED: None             │
│          │               │                                  │
│          │               │ SCH_BPF_BYPASS: None             │
│ enqueue  │               │                                  │
│          │               │ SCH_BPF_STOLEN: None             │
│          │               │                                  │
│          │               │ SCH_BPF_DROP: None               │
│          │               │                                  │
│          │               │ SCH_BPF_CN: None                 │
│          │               │                                  │
│          │               │ SCH_BPF_PASS: ctx->classid       │
├──────────┼───────────────┼──────────────────────────────────┤
│          │ ctx->classid  │ SCH_BPF_THROTTLE: ctx->expire    │
│          │               │                   ctx->delta_ns  │
│          │               │                                  │
│ dequeue  │               │ SCH_BPF_DEQUEUED: None           │
│          │               │                                  │
│          │               │ SCH_BPF_DROP: None               │
│          │               │                                  │
│          │               │ SCH_BPF_PASS: ctx->classid       │
└──────────┴───────────────┴──────────────────────────────────┘

Signed-off-by: Cong Wang <cong.wang@bytedance.com>
Co-developed-by: Amery Hung <amery.hung@bytedance.com>
Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 include/linux/bpf_types.h      |   4 +
 include/uapi/linux/bpf.h       |  21 ++
 include/uapi/linux/pkt_sched.h |  16 +
 kernel/bpf/btf.c               |   5 +
 kernel/bpf/helpers.c           |   1 +
 kernel/bpf/syscall.c           |   8 +
 net/core/filter.c              |  96 ++++++
 net/sched/Kconfig              |  15 +
 net/sched/Makefile             |   1 +
 net/sched/sch_bpf.c            | 537 +++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  21 ++
 11 files changed, 725 insertions(+)
 create mode 100644 net/sched/sch_bpf.c

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index a4247377e951..3e35033a9126 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -83,6 +83,10 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_SYSCALL, bpf_syscall,
 BPF_PROG_TYPE(BPF_PROG_TYPE_NETFILTER, netfilter,
 	      struct bpf_nf_ctx, struct bpf_nf_ctx)
 #endif
+#ifdef CONFIG_NET
+BPF_PROG_TYPE(BPF_PROG_TYPE_QDISC, tc_qdisc,
+	      struct bpf_qdisc_ctx, struct bpf_qdisc_ctx)
+#endif
 
 BPF_MAP_TYPE(BPF_MAP_TYPE_ARRAY, array_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_ARRAY, percpu_array_map_ops)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0bb92414c036..df280bbb7c0d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -997,6 +997,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
 	BPF_PROG_TYPE_NETFILTER,
+	BPF_PROG_TYPE_QDISC,
 };
 
 enum bpf_attach_type {
@@ -1056,6 +1057,8 @@ enum bpf_attach_type {
 	BPF_CGROUP_UNIX_GETSOCKNAME,
 	BPF_NETKIT_PRIMARY,
 	BPF_NETKIT_PEER,
+	BPF_QDISC_ENQUEUE,
+	BPF_QDISC_DEQUEUE,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -7357,4 +7360,22 @@ struct bpf_iter_num {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));
 
+struct bpf_qdisc_ctx {
+	__bpf_md_ptr(struct sk_buff *, skb);
+	__u32 classid;
+	__u64 expire;
+	__u64 delta_ns;
+};
+
+enum {
+	SCH_BPF_QUEUED,
+	SCH_BPF_DEQUEUED = SCH_BPF_QUEUED,
+	SCH_BPF_DROP,
+	SCH_BPF_CN,
+	SCH_BPF_THROTTLE,
+	SCH_BPF_PASS,
+	SCH_BPF_BYPASS,
+	SCH_BPF_STOLEN,
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index f762a10bfb78..d05462309f5a 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -1317,4 +1317,20 @@ enum {
 
 #define TCA_ETS_MAX (__TCA_ETS_MAX - 1)
 
+#define TCA_SCH_BPF_FLAG_DIRECT _BITUL(0)
+enum {
+	TCA_SCH_BPF_UNSPEC,
+	TCA_SCH_BPF_ENQUEUE_PROG_NAME,	/* string */
+	TCA_SCH_BPF_ENQUEUE_PROG_FD,	/* u32 */
+	TCA_SCH_BPF_ENQUEUE_PROG_ID,	/* u32 */
+	TCA_SCH_BPF_ENQUEUE_PROG_TAG,	/* data */
+	TCA_SCH_BPF_DEQUEUE_PROG_NAME,	/* string */
+	TCA_SCH_BPF_DEQUEUE_PROG_FD,	/* u32 */
+	TCA_SCH_BPF_DEQUEUE_PROG_ID,	/* u32 */
+	TCA_SCH_BPF_DEQUEUE_PROG_TAG,	/* data */
+	__TCA_SCH_BPF_MAX,
+};
+
+#define TCA_SCH_BPF_MAX (__TCA_SCH_BPF_MAX - 1)
+
 #endif
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 15d71d2986d3..ee8d6c127b04 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -217,6 +217,7 @@ enum btf_kfunc_hook {
 	BTF_KFUNC_HOOK_SOCKET_FILTER,
 	BTF_KFUNC_HOOK_LWT,
 	BTF_KFUNC_HOOK_NETFILTER,
+	BTF_KFUNC_HOOK_QDISC,
 	BTF_KFUNC_HOOK_MAX,
 };
 
@@ -5928,6 +5929,8 @@ static bool prog_args_trusted(const struct bpf_prog *prog)
 		return bpf_lsm_is_trusted(prog);
 	case BPF_PROG_TYPE_STRUCT_OPS:
 		return true;
+	case BPF_PROG_TYPE_QDISC:
+		return true;
 	default:
 		return false;
 	}
@@ -7865,6 +7868,8 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 		return BTF_KFUNC_HOOK_LWT;
 	case BPF_PROG_TYPE_NETFILTER:
 		return BTF_KFUNC_HOOK_NETFILTER;
+	case BPF_PROG_TYPE_QDISC:
+		return BTF_KFUNC_HOOK_QDISC;
 	default:
 		return BTF_KFUNC_HOOK_MAX;
 	}
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 56b0c1f678ee..d5e581ccd9a0 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2610,6 +2610,7 @@ static int __init kfunc_init(void)
 
 	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_QDISC, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &generic_kfunc_set);
 	ret = ret ?: register_btf_id_dtor_kfuncs(generic_dtors,
 						  ARRAY_SIZE(generic_dtors),
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 13eb50446e7a..1838bddd8526 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2502,6 +2502,14 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
 		if (expected_attach_type == BPF_NETFILTER)
 			return 0;
 		return -EINVAL;
+	case BPF_PROG_TYPE_QDISC:
+		switch (expected_attach_type) {
+		case BPF_QDISC_ENQUEUE:
+		case BPF_QDISC_DEQUEUE:
+			return 0;
+		default:
+			return -EINVAL;
+		}
 	case BPF_PROG_TYPE_SYSCALL:
 	case BPF_PROG_TYPE_EXT:
 		if (expected_attach_type)
diff --git a/net/core/filter.c b/net/core/filter.c
index 383f96b0a1c7..f25a0b6b5d56 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8889,6 +8889,90 @@ static int tc_cls_act_btf_struct_access(struct bpf_verifier_log *log,
 	return ret;
 }
 
+static int tc_qdisc_prologue(struct bpf_insn *insn_buf, bool direct_write,
+			     const struct bpf_prog *prog)
+{
+	return bpf_unclone_prologue(insn_buf, direct_write, prog,
+				    SCH_BPF_DROP);
+}
+
+BTF_ID_LIST_SINGLE(tc_qdisc_ctx_access_btf_ids, struct, sk_buff)
+
+static bool tc_qdisc_is_valid_access(int off, int size,
+				     enum bpf_access_type type,
+				     const struct bpf_prog *prog,
+				     struct bpf_insn_access_aux *info)
+{
+	struct btf *btf;
+
+	if (off < 0 || off >= sizeof(struct bpf_qdisc_ctx))
+		return false;
+
+	switch (off) {
+	case offsetof(struct bpf_qdisc_ctx, skb):
+		if (type == BPF_WRITE ||
+		    size != sizeof_field(struct bpf_qdisc_ctx, skb))
+			return false;
+
+		if (prog->expected_attach_type != BPF_QDISC_ENQUEUE)
+			return false;
+
+		btf = bpf_get_btf_vmlinux();
+		if (IS_ERR_OR_NULL(btf))
+			return false;
+
+		info->btf = btf;
+		info->btf_id = tc_qdisc_ctx_access_btf_ids[0];
+		info->reg_type = PTR_TO_BTF_ID | PTR_TRUSTED;
+		return true;
+	case bpf_ctx_range(struct bpf_qdisc_ctx, classid):
+		return size == sizeof_field(struct bpf_qdisc_ctx, classid);
+	case bpf_ctx_range(struct bpf_qdisc_ctx, expire):
+		return size == sizeof_field(struct bpf_qdisc_ctx, expire);
+	case bpf_ctx_range(struct bpf_qdisc_ctx, delta_ns):
+		return size == sizeof_field(struct bpf_qdisc_ctx, delta_ns);
+	default:
+		return false;
+	}
+
+	return false;
+}
+
+static int tc_qdisc_btf_struct_access(struct bpf_verifier_log *log,
+				      const struct bpf_reg_state *reg,
+				      int off, int size)
+{
+	const struct btf_type *skbt, *t;
+	size_t end;
+
+	skbt = btf_type_by_id(reg->btf, tc_qdisc_ctx_access_btf_ids[0]);
+	t = btf_type_by_id(reg->btf, reg->btf_id);
+	if (t != skbt)
+		return -EACCES;
+
+	switch (off) {
+	case offsetof(struct sk_buff, cb) ...
+	     offsetofend(struct sk_buff, cb) - 1:
+		end = offsetofend(struct sk_buff, cb);
+		break;
+	case offsetof(struct sk_buff, tstamp):
+		end = offsetofend(struct sk_buff, tstamp);
+		break;
+	default:
+		bpf_log(log, "no write support to skb at off %d\n", off);
+		return -EACCES;
+	}
+
+	if (off + size > end) {
+		bpf_log(log,
+			"write access at off %d with size %d beyond the member of sk_buff ended at %zu\n",
+			off, size, end);
+		return -EACCES;
+	}
+
+	return 0;
+}
+
 static bool __is_valid_xdp_access(int off, int size)
 {
 	if (off < 0 || off >= sizeof(struct xdp_md))
@@ -10890,6 +10974,18 @@ const struct bpf_prog_ops tc_cls_act_prog_ops = {
 	.test_run		= bpf_prog_test_run_skb,
 };
 
+const struct bpf_verifier_ops tc_qdisc_verifier_ops = {
+	.get_func_proto		= tc_cls_act_func_proto,
+	.is_valid_access	= tc_qdisc_is_valid_access,
+	.gen_prologue		= tc_qdisc_prologue,
+	.gen_ld_abs		= bpf_gen_ld_abs,
+	.btf_struct_access	= tc_qdisc_btf_struct_access,
+};
+
+const struct bpf_prog_ops tc_qdisc_prog_ops = {
+	.test_run		= bpf_prog_test_run_skb,
+};
+
 const struct bpf_verifier_ops xdp_verifier_ops = {
 	.get_func_proto		= xdp_func_proto,
 	.is_valid_access	= xdp_is_valid_access,
diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index 470c70deffe2..e4ece091af4d 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -403,6 +403,21 @@ config NET_SCH_ETS
 
 	  If unsure, say N.
 
+config NET_SCH_BPF
+	tristate "eBPF based programmable queue discipline"
+	help
+	  This eBPF based queue discipline offers a way to program your
+	  own packet scheduling algorithm. This is a classful qdisc which
+	  also allows you to decide the hierarchy.
+
+	  Say Y here if you want to use the eBPF based programmable queue
+	  discipline.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called sch_bpf.
+
+	  If unsure, say N.
+
 menuconfig NET_SCH_DEFAULT
 	bool "Allow override default queue discipline"
 	help
diff --git a/net/sched/Makefile b/net/sched/Makefile
index b5fd49641d91..4e24c6c79cb8 100644
--- a/net/sched/Makefile
+++ b/net/sched/Makefile
@@ -63,6 +63,7 @@ obj-$(CONFIG_NET_SCH_FQ_PIE)	+= sch_fq_pie.o
 obj-$(CONFIG_NET_SCH_CBS)	+= sch_cbs.o
 obj-$(CONFIG_NET_SCH_ETF)	+= sch_etf.o
 obj-$(CONFIG_NET_SCH_TAPRIO)	+= sch_taprio.o
+obj-$(CONFIG_NET_SCH_BPF)	+= sch_bpf.o
 
 obj-$(CONFIG_NET_CLS_U32)	+= cls_u32.o
 obj-$(CONFIG_NET_CLS_ROUTE4)	+= cls_route.o
diff --git a/net/sched/sch_bpf.c b/net/sched/sch_bpf.c
new file mode 100644
index 000000000000..56f3ab9c6059
--- /dev/null
+++ b/net/sched/sch_bpf.c
@@ -0,0 +1,537 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Programmable Qdisc with eBPF
+ *
+ * Copyright (C) 2022, ByteDance, Cong Wang <cong.wang@bytedance.com>
+ */
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/jiffies.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/skbuff.h>
+#include <linux/slab.h>
+#include <linux/filter.h>
+#include <linux/bpf.h>
+#include <net/netlink.h>
+#include <net/pkt_sched.h>
+#include <net/pkt_cls.h>
+
+#define ACT_BPF_NAME_LEN	256
+
+struct sch_bpf_prog {
+	struct bpf_prog *prog;
+	const char *name;
+};
+
+struct sch_bpf_class {
+	struct Qdisc_class_common common;
+	struct Qdisc *qdisc;
+
+	unsigned int drops;
+	unsigned int overlimits;
+	struct gnet_stats_basic_sync bstats;
+};
+
+struct bpf_sched_data {
+	struct tcf_proto __rcu *filter_list; /* optional external classifier */
+	struct tcf_block *block;
+	struct Qdisc_class_hash clhash;
+	struct sch_bpf_prog __rcu enqueue_prog;
+	struct sch_bpf_prog __rcu dequeue_prog;
+
+	struct qdisc_watchdog watchdog;
+};
+
+static int sch_bpf_dump_prog(const struct sch_bpf_prog *prog, struct sk_buff *skb,
+			     int name, int id, int tag)
+{
+	struct nlattr *nla;
+
+	if (prog->name &&
+	    nla_put_string(skb, name, prog->name))
+		return -EMSGSIZE;
+
+	if (nla_put_u32(skb, id, prog->prog->aux->id))
+		return -EMSGSIZE;
+
+	nla = nla_reserve(skb, tag, sizeof(prog->prog->tag));
+	if (!nla)
+		return -EMSGSIZE;
+
+	memcpy(nla_data(nla), prog->prog->tag, nla_len(nla));
+	return 0;
+}
+
+static int sch_bpf_dump(struct Qdisc *sch, struct sk_buff *skb)
+{
+	struct bpf_sched_data *q = qdisc_priv(sch);
+	struct nlattr *opts;
+
+	opts = nla_nest_start_noflag(skb, TCA_OPTIONS);
+	if (!opts)
+		goto nla_put_failure;
+
+	if (sch_bpf_dump_prog(&q->enqueue_prog, skb, TCA_SCH_BPF_ENQUEUE_PROG_NAME,
+			      TCA_SCH_BPF_ENQUEUE_PROG_ID, TCA_SCH_BPF_ENQUEUE_PROG_TAG))
+		goto nla_put_failure;
+	if (sch_bpf_dump_prog(&q->dequeue_prog, skb, TCA_SCH_BPF_DEQUEUE_PROG_NAME,
+			      TCA_SCH_BPF_DEQUEUE_PROG_ID, TCA_SCH_BPF_DEQUEUE_PROG_TAG))
+		goto nla_put_failure;
+
+	return nla_nest_end(skb, opts);
+
+nla_put_failure:
+	return -1;
+}
+
+static int sch_bpf_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
+{
+	return 0;
+}
+
+static struct sch_bpf_class *sch_bpf_find(struct Qdisc *sch, u32 classid)
+{
+	struct bpf_sched_data *q = qdisc_priv(sch);
+	struct Qdisc_class_common *clc;
+
+	clc = qdisc_class_find(&q->clhash, classid);
+	if (!clc)
+		return NULL;
+	return container_of(clc, struct sch_bpf_class, common);
+}
+
+static int sch_bpf_enqueue(struct sk_buff *skb, struct Qdisc *sch,
+			   struct sk_buff **to_free)
+{
+	struct bpf_sched_data *q = qdisc_priv(sch);
+	unsigned int len = qdisc_pkt_len(skb);
+	struct bpf_qdisc_ctx ctx = {};
+	int res = NET_XMIT_SUCCESS;
+	struct sch_bpf_class *cl;
+	struct bpf_prog *enqueue;
+
+	enqueue = rcu_dereference(q->enqueue_prog.prog);
+	if (!enqueue)
+		return NET_XMIT_DROP;
+
+	ctx.skb = skb;
+	ctx.classid = sch->handle;
+	res = bpf_prog_run(enqueue, &ctx);
+	switch (res) {
+	case SCH_BPF_THROTTLE:
+		qdisc_watchdog_schedule_range_ns(&q->watchdog, ctx.expire, ctx.delta_ns);
+		qdisc_qstats_overlimit(sch);
+		fallthrough;
+	case SCH_BPF_QUEUED:
+		qdisc_qstats_backlog_inc(sch, skb);
+		return NET_XMIT_SUCCESS;
+	case SCH_BPF_BYPASS:
+		qdisc_qstats_drop(sch);
+		__qdisc_drop(skb, to_free);
+		return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
+	case SCH_BPF_STOLEN:
+		__qdisc_drop(skb, to_free);
+		return NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
+	case SCH_BPF_CN:
+		return NET_XMIT_CN;
+	case SCH_BPF_PASS:
+		break;
+	default:
+		return qdisc_drop(skb, sch, to_free);
+	}
+
+	cl = sch_bpf_find(sch, ctx.classid);
+	if (!cl || !cl->qdisc)
+		return qdisc_drop(skb, sch, to_free);
+
+	res = qdisc_enqueue(skb, cl->qdisc, to_free);
+	if (res != NET_XMIT_SUCCESS) {
+		if (net_xmit_drop_count(res)) {
+			qdisc_qstats_drop(sch);
+			cl->drops++;
+		}
+		return res;
+	}
+
+	sch->qstats.backlog += len;
+	sch->q.qlen++;
+	return res;
+}
+
+DEFINE_PER_CPU(struct sk_buff*, bpf_skb_dequeue);
+
+static struct sk_buff *sch_bpf_dequeue(struct Qdisc *sch)
+{
+	struct bpf_sched_data *q = qdisc_priv(sch);
+	struct bpf_qdisc_ctx ctx = {};
+	struct sk_buff *skb = NULL;
+	struct bpf_prog *dequeue;
+	struct sch_bpf_class *cl;
+	int res;
+
+	dequeue = rcu_dereference(q->dequeue_prog.prog);
+	if (!dequeue)
+		return NULL;
+
+	__this_cpu_write(bpf_skb_dequeue, NULL);
+	ctx.classid = sch->handle;
+	res = bpf_prog_run(dequeue, &ctx);
+	switch (res) {
+	case SCH_BPF_DEQUEUED:
+		skb = __this_cpu_read(bpf_skb_dequeue);
+		qdisc_bstats_update(sch, skb);
+		qdisc_qstats_backlog_dec(sch, skb);
+		break;
+	case SCH_BPF_THROTTLE:
+		qdisc_watchdog_schedule_range_ns(&q->watchdog, ctx.expire, ctx.delta_ns);
+		qdisc_qstats_overlimit(sch);
+		cl = sch_bpf_find(sch, ctx.classid);
+		if (cl)
+			cl->overlimits++;
+		return NULL;
+	case SCH_BPF_PASS:
+		cl = sch_bpf_find(sch, ctx.classid);
+		if (!cl || !cl->qdisc)
+			return NULL;
+		skb = qdisc_dequeue_peeked(cl->qdisc);
+		if (skb) {
+			bstats_update(&cl->bstats, skb);
+			qdisc_bstats_update(sch, skb);
+			qdisc_qstats_backlog_dec(sch, skb);
+			sch->q.qlen--;
+		}
+		break;
+	}
+
+	return skb;
+}
+
+static struct Qdisc *sch_bpf_leaf(struct Qdisc *sch, unsigned long arg)
+{
+	struct sch_bpf_class *cl = (struct sch_bpf_class *)arg;
+
+	return cl->qdisc;
+}
+
+static int sch_bpf_graft(struct Qdisc *sch, unsigned long arg, struct Qdisc *new,
+			 struct Qdisc **old, struct netlink_ext_ack *extack)
+{
+	struct sch_bpf_class *cl = (struct sch_bpf_class *)arg;
+
+	if (new)
+		*old = qdisc_replace(sch, new, &cl->qdisc);
+	return 0;
+}
+
+static unsigned long sch_bpf_bind(struct Qdisc *sch, unsigned long parent,
+				  u32 classid)
+{
+	return 0;
+}
+
+static void sch_bpf_unbind(struct Qdisc *q, unsigned long cl)
+{
+}
+
+static unsigned long sch_bpf_search(struct Qdisc *sch, u32 handle)
+{
+	return (unsigned long)sch_bpf_find(sch, handle);
+}
+
+static struct tcf_block *sch_bpf_tcf_block(struct Qdisc *sch, unsigned long cl,
+					   struct netlink_ext_ack *extack)
+{
+	struct bpf_sched_data *q = qdisc_priv(sch);
+
+	if (cl)
+		return NULL;
+	return q->block;
+}
+
+static const struct nla_policy sch_bpf_policy[TCA_SCH_BPF_MAX + 1] = {
+	[TCA_SCH_BPF_ENQUEUE_PROG_FD]	= { .type = NLA_U32 },
+	[TCA_SCH_BPF_ENQUEUE_PROG_NAME]	= { .type = NLA_NUL_STRING,
+					    .len = ACT_BPF_NAME_LEN },
+	[TCA_SCH_BPF_DEQUEUE_PROG_FD]	= { .type = NLA_U32 },
+	[TCA_SCH_BPF_DEQUEUE_PROG_NAME]	= { .type = NLA_NUL_STRING,
+					    .len = ACT_BPF_NAME_LEN },
+};
+
+static int bpf_init_prog(struct nlattr *fd, struct nlattr *name, struct sch_bpf_prog *prog)
+{
+	struct bpf_prog *fp, *old_fp;
+	char *prog_name = NULL;
+	u32 bpf_fd;
+
+	if (!fd)
+		return -EINVAL;
+	bpf_fd = nla_get_u32(fd);
+
+	fp = bpf_prog_get_type(bpf_fd, BPF_PROG_TYPE_QDISC);
+	if (IS_ERR(fp))
+		return PTR_ERR(fp);
+
+	if (name) {
+		prog_name = nla_memdup(name, GFP_KERNEL);
+		if (!prog_name) {
+			bpf_prog_put(fp);
+			return -ENOMEM;
+		}
+	}
+
+	prog->name = prog_name;
+
+	/* updates to prog->prog are prevent since the caller holds
+	 * sch_tree_lock
+	 */
+	old_fp = rcu_replace_pointer(prog->prog, fp, 1);
+	if (old_fp)
+		bpf_prog_put(old_fp);
+
+	return 0;
+}
+
+static void bpf_cleanup_prog(struct sch_bpf_prog *prog)
+{
+	struct bpf_prog *old_fp = NULL;
+
+	/* updates to prog->prog are prevent since the caller holds
+	 * sch_tree_lock
+	 */
+	old_fp = rcu_replace_pointer(prog->prog, old_fp, 1);
+	if (old_fp)
+		bpf_prog_put(old_fp);
+
+	kfree(prog->name);
+}
+
+static int sch_bpf_change(struct Qdisc *sch, struct nlattr *opt,
+			  struct netlink_ext_ack *extack)
+{
+	struct bpf_sched_data *q = qdisc_priv(sch);
+	struct nlattr *tb[TCA_SCH_BPF_MAX + 1];
+	int err;
+
+	if (!opt)
+		return -EINVAL;
+
+	err = nla_parse_nested_deprecated(tb, TCA_SCH_BPF_MAX, opt,
+					  sch_bpf_policy, NULL);
+	if (err < 0)
+		return err;
+
+	sch_tree_lock(sch);
+
+	err = bpf_init_prog(tb[TCA_SCH_BPF_ENQUEUE_PROG_FD],
+			    tb[TCA_SCH_BPF_ENQUEUE_PROG_NAME], &q->enqueue_prog);
+	if (err)
+		goto failure;
+	err = bpf_init_prog(tb[TCA_SCH_BPF_DEQUEUE_PROG_FD],
+			    tb[TCA_SCH_BPF_DEQUEUE_PROG_NAME], &q->dequeue_prog);
+failure:
+	sch_tree_unlock(sch);
+	return err;
+}
+
+static int sch_bpf_init(struct Qdisc *sch, struct nlattr *opt,
+			struct netlink_ext_ack *extack)
+{
+	struct bpf_sched_data *q = qdisc_priv(sch);
+	int err;
+
+	qdisc_watchdog_init(&q->watchdog, sch);
+	if (opt) {
+		err = sch_bpf_change(sch, opt, extack);
+		if (err)
+			return err;
+	}
+
+	err = tcf_block_get(&q->block, &q->filter_list, sch, extack);
+	if (err)
+		return err;
+
+	return qdisc_class_hash_init(&q->clhash);
+}
+
+static void sch_bpf_reset(struct Qdisc *sch)
+{
+	struct bpf_sched_data *q = qdisc_priv(sch);
+	struct sch_bpf_class *cl;
+	unsigned int i;
+
+	for (i = 0; i < q->clhash.hashsize; i++) {
+		hlist_for_each_entry(cl, &q->clhash.hash[i], common.hnode) {
+			if (cl->qdisc)
+				qdisc_reset(cl->qdisc);
+		}
+	}
+
+	qdisc_watchdog_cancel(&q->watchdog);
+}
+
+static void sch_bpf_destroy_class(struct Qdisc *sch, struct sch_bpf_class *cl)
+{
+	qdisc_put(cl->qdisc);
+	kfree(cl);
+}
+
+static void sch_bpf_destroy(struct Qdisc *sch)
+{
+	struct bpf_sched_data *q = qdisc_priv(sch);
+	struct sch_bpf_class *cl;
+	unsigned int i;
+
+	qdisc_watchdog_cancel(&q->watchdog);
+	tcf_block_put(q->block);
+	for (i = 0; i < q->clhash.hashsize; i++) {
+		hlist_for_each_entry(cl, &q->clhash.hash[i], common.hnode) {
+			sch_bpf_destroy_class(sch, cl);
+		}
+	}
+
+	qdisc_class_hash_destroy(&q->clhash);
+
+	sch_tree_lock(sch);
+	bpf_cleanup_prog(&q->enqueue_prog);
+	bpf_cleanup_prog(&q->dequeue_prog);
+	sch_tree_unlock(sch);
+}
+
+static int sch_bpf_change_class(struct Qdisc *sch, u32 classid,
+				u32 parentid, struct nlattr **tca,
+				unsigned long *arg,
+				struct netlink_ext_ack *extack)
+{
+	struct sch_bpf_class *cl = (struct sch_bpf_class *)*arg;
+	struct bpf_sched_data *q = qdisc_priv(sch);
+
+	if (!cl) {
+		if (classid == 0 || TC_H_MAJ(classid ^ sch->handle) != 0 ||
+		    sch_bpf_find(sch, classid))
+			return -EINVAL;
+
+		cl = kzalloc(sizeof(*cl), GFP_KERNEL);
+		if (!cl)
+			return -ENOBUFS;
+
+		cl->common.classid = classid;
+		gnet_stats_basic_sync_init(&cl->bstats);
+		qdisc_class_hash_insert(&q->clhash, &cl->common);
+	}
+
+	qdisc_class_hash_grow(sch, &q->clhash);
+	*arg = (unsigned long)cl;
+	return 0;
+}
+
+static int sch_bpf_delete(struct Qdisc *sch, unsigned long arg,
+			  struct netlink_ext_ack *extack)
+{
+	struct sch_bpf_class *cl = (struct sch_bpf_class *)arg;
+	struct bpf_sched_data *q = qdisc_priv(sch);
+
+	qdisc_class_hash_remove(&q->clhash, &cl->common);
+	if (cl->qdisc)
+		qdisc_put(cl->qdisc);
+	return 0;
+}
+
+static int sch_bpf_dump_class(struct Qdisc *sch, unsigned long arg,
+			      struct sk_buff *skb, struct tcmsg *tcm)
+{
+	return 0;
+}
+
+static int
+sch_bpf_dump_class_stats(struct Qdisc *sch, unsigned long arg, struct gnet_dump *d)
+{
+	struct sch_bpf_class *cl = (struct sch_bpf_class *)arg;
+	struct gnet_stats_queue qs = {
+		.drops = cl->drops,
+		.overlimits = cl->overlimits,
+	};
+	__u32 qlen = 0;
+
+	if (cl->qdisc)
+		qdisc_qstats_qlen_backlog(cl->qdisc, &qlen, &qs.backlog);
+	else
+		qlen = 0;
+
+	if (gnet_stats_copy_basic(d, NULL, &cl->bstats, true) < 0 ||
+	    gnet_stats_copy_queue(d, NULL, &qs, qlen) < 0)
+		return -1;
+	return 0;
+}
+
+static void sch_bpf_walk(struct Qdisc *sch, struct qdisc_walker *arg)
+{
+	struct bpf_sched_data *q = qdisc_priv(sch);
+	struct sch_bpf_class *cl;
+	unsigned int i;
+
+	if (arg->stop)
+		return;
+
+	for (i = 0; i < q->clhash.hashsize; i++) {
+		hlist_for_each_entry(cl, &q->clhash.hash[i], common.hnode) {
+			if (arg->count < arg->skip) {
+				arg->count++;
+				continue;
+			}
+			if (arg->fn(sch, (unsigned long)cl, arg) < 0) {
+				arg->stop = 1;
+				return;
+			}
+			arg->count++;
+		}
+	}
+}
+
+static const struct Qdisc_class_ops sch_bpf_class_ops = {
+	.graft		=	sch_bpf_graft,
+	.leaf		=	sch_bpf_leaf,
+	.find		=	sch_bpf_search,
+	.change		=	sch_bpf_change_class,
+	.delete		=	sch_bpf_delete,
+	.tcf_block	=	sch_bpf_tcf_block,
+	.bind_tcf	=	sch_bpf_bind,
+	.unbind_tcf	=	sch_bpf_unbind,
+	.dump		=	sch_bpf_dump_class,
+	.dump_stats	=	sch_bpf_dump_class_stats,
+	.walk		=	sch_bpf_walk,
+};
+
+static struct Qdisc_ops sch_bpf_qdisc_ops __read_mostly = {
+	.cl_ops		=	&sch_bpf_class_ops,
+	.id		=	"bpf",
+	.priv_size	=	sizeof(struct bpf_sched_data),
+	.enqueue	=	sch_bpf_enqueue,
+	.dequeue	=	sch_bpf_dequeue,
+	.peek		=	qdisc_peek_dequeued,
+	.init		=	sch_bpf_init,
+	.reset		=	sch_bpf_reset,
+	.destroy	=	sch_bpf_destroy,
+	.change		=	sch_bpf_change,
+	.dump		=	sch_bpf_dump,
+	.dump_stats	=	sch_bpf_dump_stats,
+	.owner		=	THIS_MODULE,
+};
+
+static int __init sch_bpf_mod_init(void)
+{
+	return register_qdisc(&sch_bpf_qdisc_ops);
+}
+
+static void __exit sch_bpf_mod_exit(void)
+{
+	unregister_qdisc(&sch_bpf_qdisc_ops);
+}
+
+module_init(sch_bpf_mod_init)
+module_exit(sch_bpf_mod_exit)
+MODULE_AUTHOR("Cong Wang");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("eBPF queue discipline");
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 0bb92414c036..df280bbb7c0d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -997,6 +997,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
 	BPF_PROG_TYPE_NETFILTER,
+	BPF_PROG_TYPE_QDISC,
 };
 
 enum bpf_attach_type {
@@ -1056,6 +1057,8 @@ enum bpf_attach_type {
 	BPF_CGROUP_UNIX_GETSOCKNAME,
 	BPF_NETKIT_PRIMARY,
 	BPF_NETKIT_PEER,
+	BPF_QDISC_ENQUEUE,
+	BPF_QDISC_DEQUEUE,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -7357,4 +7360,22 @@ struct bpf_iter_num {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));
 
+struct bpf_qdisc_ctx {
+	__bpf_md_ptr(struct sk_buff *, skb);
+	__u32 classid;
+	__u64 expire;
+	__u64 delta_ns;
+};
+
+enum {
+	SCH_BPF_QUEUED,
+	SCH_BPF_DEQUEUED = SCH_BPF_QUEUED,
+	SCH_BPF_DROP,
+	SCH_BPF_CN,
+	SCH_BPF_THROTTLE,
+	SCH_BPF_PASS,
+	SCH_BPF_BYPASS,
+	SCH_BPF_STOLEN,
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
-- 
2.20.1


