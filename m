Return-Path: <bpf+bounces-6356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6147685B3
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 15:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019C01C209B2
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 13:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7FE2102;
	Sun, 30 Jul 2023 13:43:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E37363
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 13:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6B0C433C7;
	Sun, 30 Jul 2023 13:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690724589;
	bh=e+EK2Q98JrhSsz3BORKtpTTOScJ6D/7ZZliGU3056ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g7oU4Hn8f8M3TIJ/fNdNsRxFePU37z59Zc3uURyJJfGbTgEX+YwbbzlyTIIIFKSAd
	 D6K3mtu56NKeFtdmNDkxsV7AVEJUqzkY5qlm15js1jiorNJApj2Nphtwb5gK6lhnfj
	 W6rdKS8d3fC3NOeARjiJhA/+hJMaeBidiWHg/ZQJPlotJTDMFvxa9hE/zs4Jl0ns90
	 /06McplspkCZj0+CMlfwoWkBQffiUM3MEYYP156Gz8RcSnH5+txSnpm5CAU5m9m1qg
	 nf0hIQ5SmVPR7LPMuJFY1gscVbppCkOayQTVMQF5oKJ4g+1x/vouDVkNswXpI44ecj
	 6DIhOeDhxWwjw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCHv5 bpf-next 04/28] bpf: Add cookies support for uprobe_multi link
Date: Sun, 30 Jul 2023 15:41:59 +0200
Message-ID: <20230730134223.94496-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230730134223.94496-1-jolsa@kernel.org>
References: <20230730134223.94496-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support to specify cookies array for uprobe_multi link.

The cookies array share indexes and length with other uprobe_multi
arrays (offsets/ref_ctr_offsets).

The cookies[i] value defines cookie for i-the uprobe and will be
returned by bpf_get_attach_cookie helper when called from ebpf
program hooked to that specific uprobe.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/syscall.c           |  2 +-
 kernel/trace/bpf_trace.c       | 45 +++++++++++++++++++++++++++++++---
 tools/include/uapi/linux/bpf.h |  1 +
 4 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f112a0b948f3..2b6cd7d1c165 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1639,6 +1639,7 @@ union bpf_attr {
 				__aligned_u64	path;
 				__aligned_u64	offsets;
 				__aligned_u64	ref_ctr_offsets;
+				__aligned_u64	cookies;
 				__u32		cnt;
 				__u32		flags;
 			} uprobe_multi;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 75c83300339e..98459fb34ff7 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4883,7 +4883,7 @@ static int bpf_map_do_batch(const union bpf_attr *attr,
 	return err;
 }
 
-#define BPF_LINK_CREATE_LAST_FIELD link_create.kprobe_multi.cookies
+#define BPF_LINK_CREATE_LAST_FIELD link_create.uprobe_multi.flags
 static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 {
 	struct bpf_prog *prog;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 10284fd46f98..d73a47bd2bbd 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -87,6 +87,8 @@ static int bpf_btf_printf_prepare(struct btf_ptr *ptr, u32 btf_ptr_size,
 static u64 bpf_kprobe_multi_cookie(struct bpf_run_ctx *ctx);
 static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx);
 
+static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx);
+
 /**
  * trace_call_bpf - invoke BPF program
  * @call: tracepoint event
@@ -1099,6 +1101,18 @@ static const struct bpf_func_proto bpf_get_attach_cookie_proto_kmulti = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 };
 
+BPF_CALL_1(bpf_get_attach_cookie_uprobe_multi, struct pt_regs *, regs)
+{
+	return bpf_uprobe_multi_cookie(current->bpf_ctx);
+}
+
+static const struct bpf_func_proto bpf_get_attach_cookie_proto_umulti = {
+	.func		= bpf_get_attach_cookie_uprobe_multi,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+};
+
 BPF_CALL_1(bpf_get_attach_cookie_trace, void *, ctx)
 {
 	struct bpf_trace_run_ctx *run_ctx;
@@ -1545,9 +1559,11 @@ kprobe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 			&bpf_get_func_ip_proto_kprobe_multi :
 			&bpf_get_func_ip_proto_kprobe;
 	case BPF_FUNC_get_attach_cookie:
-		return prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI ?
-			&bpf_get_attach_cookie_proto_kmulti :
-			&bpf_get_attach_cookie_proto_trace;
+		if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI)
+			return &bpf_get_attach_cookie_proto_kmulti;
+		if (prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI)
+			return &bpf_get_attach_cookie_proto_umulti;
+		return &bpf_get_attach_cookie_proto_trace;
 	default:
 		return bpf_tracing_func_proto(func_id, prog);
 	}
@@ -2973,6 +2989,7 @@ struct bpf_uprobe_multi_link;
 struct bpf_uprobe {
 	struct bpf_uprobe_multi_link *link;
 	loff_t offset;
+	u64 cookie;
 	struct uprobe_consumer consumer;
 };
 
@@ -2986,6 +3003,7 @@ struct bpf_uprobe_multi_link {
 struct bpf_uprobe_multi_run_ctx {
 	struct bpf_run_ctx run_ctx;
 	unsigned long entry_ip;
+	struct bpf_uprobe *uprobe;
 };
 
 static void bpf_uprobe_unregister(struct path *path, struct bpf_uprobe *uprobes,
@@ -3029,6 +3047,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 	struct bpf_uprobe_multi_link *link = uprobe->link;
 	struct bpf_uprobe_multi_run_ctx run_ctx = {
 		.entry_ip = entry_ip,
+		.uprobe = uprobe,
 	};
 	struct bpf_prog *prog = link->link.prog;
 	bool sleepable = prog->aux->sleepable;
@@ -3075,6 +3094,14 @@ uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, s
 	return uprobe_prog_run(uprobe, func, regs);
 }
 
+static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx)
+{
+	struct bpf_uprobe_multi_run_ctx *run_ctx;
+
+	run_ctx = container_of(current->bpf_ctx, struct bpf_uprobe_multi_run_ctx, run_ctx);
+	return run_ctx->uprobe->cookie;
+}
+
 int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
 	struct bpf_uprobe_multi_link *link = NULL;
@@ -3083,6 +3110,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	struct bpf_link_primer link_primer;
 	struct bpf_uprobe *uprobes = NULL;
 	unsigned long __user *uoffsets;
+	u64 __user *ucookies;
 	void __user *upath;
 	u32 flags, cnt, i;
 	struct path path;
@@ -3102,7 +3130,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 
 	/*
 	 * path, offsets and cnt are mandatory,
-	 * ref_ctr_offsets is optional
+	 * ref_ctr_offsets and cookies are optional
 	 */
 	upath = u64_to_user_ptr(attr->link_create.uprobe_multi.path);
 	uoffsets = u64_to_user_ptr(attr->link_create.uprobe_multi.offsets);
@@ -3112,6 +3140,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 		return -EINVAL;
 
 	uref_ctr_offsets = u64_to_user_ptr(attr->link_create.uprobe_multi.ref_ctr_offsets);
+	ucookies = u64_to_user_ptr(attr->link_create.uprobe_multi.cookies);
 
 	name = strndup_user(upath, PATH_MAX);
 	if (IS_ERR(name)) {
@@ -3144,6 +3173,10 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	}
 
 	for (i = 0; i < cnt; i++) {
+		if (ucookies && __get_user(uprobes[i].cookie, ucookies + i)) {
+			err = -EFAULT;
+			goto error_free;
+		}
 		if (uref_ctr_offsets && __get_user(ref_ctr_offsets[i], uref_ctr_offsets + i)) {
 			err = -EFAULT;
 			goto error_free;
@@ -3201,4 +3234,8 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 {
 	return -EOPNOTSUPP;
 }
+static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx)
+{
+	return 0;
+}
 #endif /* CONFIG_UPROBES */
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index f112a0b948f3..2b6cd7d1c165 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1639,6 +1639,7 @@ union bpf_attr {
 				__aligned_u64	path;
 				__aligned_u64	offsets;
 				__aligned_u64	ref_ctr_offsets;
+				__aligned_u64	cookies;
 				__u32		cnt;
 				__u32		flags;
 			} uprobe_multi;
-- 
2.41.0


