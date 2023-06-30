Return-Path: <bpf+bounces-3770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B4F74374C
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 10:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51AE4280DC9
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 08:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266BBA957;
	Fri, 30 Jun 2023 08:34:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B9A1FB8
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 08:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A326C433C0;
	Fri, 30 Jun 2023 08:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688114065;
	bh=IK+MfoK/+sXqjHtk5grgY3lYySrmEECf+JLE2l/bfRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UOr5VAA5hsugPhNTiNvglTblu89NkdogW45XR/+XCzdq2ryd/qCAdWs5wWVBSNXaV
	 F9FF64FzMThWhG98PReE1QkV2CEEOEcleYA3n9CH4L/E+cVy3bOzZ6K5WAEmc+s7F4
	 XL7C5vl6Wm/hzsXn2g7Ia92ilfMmLw2yHMm80DK7boj+1N/LYvYsUHHgRpAn5QYqVF
	 gSvddPj/woTYGc8s++p+dNGdjTtSas+WlXSURTbSe2s8TwQnMjncNw1zD/zXsgAGmP
	 v+vxSQu2Xk9TlaMVnZxWPoUrYqhSJeHWuI+lem5j5SZtHwbopC15Jtfo1UusR6wUvQ
	 T0m/S6N5sv6pg==
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
	Hao Luo <haoluo@google.com>
Subject: [PATCHv3 bpf-next 03/26] bpf: Add cookies support for uprobe_multi link
Date: Fri, 30 Jun 2023 10:33:21 +0200
Message-ID: <20230630083344.984305-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630083344.984305-1-jolsa@kernel.org>
References: <20230630083344.984305-1-jolsa@kernel.org>
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
index a236139f08ce..4103f395593b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1592,6 +1592,7 @@ union bpf_attr {
 				__aligned_u64	path;
 				__aligned_u64	offsets;
 				__aligned_u64	ref_ctr_offsets;
+				__aligned_u64	cookies;
 			} uprobe_multi;
 		};
 	} link_create;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 3b0582a64ce4..affad356c603 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4680,7 +4680,7 @@ static int bpf_map_do_batch(const union bpf_attr *attr,
 	return err;
 }
 
-#define BPF_LINK_CREATE_LAST_FIELD link_create.kprobe_multi.cookies
+#define BPF_LINK_CREATE_LAST_FIELD link_create.uprobe_multi.cookies
 static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 {
 	struct bpf_prog *prog;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a0b9d034300f..4657df8f884e 100644
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
@@ -2930,6 +2946,7 @@ struct bpf_uprobe_multi_link;
 struct bpf_uprobe {
 	struct bpf_uprobe_multi_link *link;
 	loff_t offset;
+	u64 cookie;
 	struct uprobe_consumer consumer;
 };
 
@@ -2943,6 +2960,7 @@ struct bpf_uprobe_multi_link {
 struct bpf_uprobe_multi_run_ctx {
 	struct bpf_run_ctx run_ctx;
 	unsigned long entry_ip;
+	struct bpf_uprobe *uprobe;
 };
 
 static void bpf_uprobe_unregister(struct path *path, struct bpf_uprobe *uprobes,
@@ -2986,6 +3004,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 	struct bpf_uprobe_multi_link *link = uprobe->link;
 	struct bpf_uprobe_multi_run_ctx run_ctx = {
 		.entry_ip = entry_ip,
+		.uprobe = uprobe,
 	};
 	struct bpf_prog *prog = link->link.prog;
 	bool sleepable = prog->aux->sleepable;
@@ -3032,6 +3051,14 @@ uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, s
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
@@ -3040,6 +3067,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	struct bpf_link_primer link_primer;
 	struct bpf_uprobe *uprobes = NULL;
 	unsigned long __user *uoffsets;
+	u64 __user *ucookies;
 	void __user *upath;
 	u32 flags, cnt, i;
 	struct path path;
@@ -3059,7 +3087,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 
 	/*
 	 * path, offsets and cnt are mandatory,
-	 * ref_ctr_offsets is optional
+	 * ref_ctr_offsets and cookies are optional
 	 */
 	upath = u64_to_user_ptr(attr->link_create.uprobe_multi.path);
 	uoffsets = u64_to_user_ptr(attr->link_create.uprobe_multi.offsets);
@@ -3069,6 +3097,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 		return -EINVAL;
 
 	uref_ctr_offsets = u64_to_user_ptr(attr->link_create.uprobe_multi.ref_ctr_offsets);
+	ucookies = u64_to_user_ptr(attr->link_create.uprobe_multi.cookies);
 
 	name = strndup_user(upath, PATH_MAX);
 	if (IS_ERR(name)) {
@@ -3101,6 +3130,10 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	}
 
 	for (i = 0; i < cnt; i++) {
+		if (ucookies && __get_user(uprobes[i].cookie, ucookies + i)) {
+			err = -EFAULT;
+			goto error_free;
+		}
 		if (uref_ctr_offsets && __get_user(ref_ctr_offsets[i], uref_ctr_offsets + i)) {
 			err = -EFAULT;
 			goto error_free;
@@ -3158,4 +3191,8 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 {
 	return -EOPNOTSUPP;
 }
+static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx)
+{
+	return 0;
+}
 #endif /* CONFIG_UPROBES */
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index a236139f08ce..4103f395593b 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1592,6 +1592,7 @@ union bpf_attr {
 				__aligned_u64	path;
 				__aligned_u64	offsets;
 				__aligned_u64	ref_ctr_offsets;
+				__aligned_u64	cookies;
 			} uprobe_multi;
 		};
 	} link_create;
-- 
2.41.0


