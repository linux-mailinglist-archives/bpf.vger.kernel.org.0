Return-Path: <bpf+bounces-2882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C87736659
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 10:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4718B281060
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 08:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89373C125;
	Tue, 20 Jun 2023 08:36:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D650DAD48
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 08:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD47C433C0;
	Tue, 20 Jun 2023 08:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687250174;
	bh=sySKb4Ev6ELu3Ea540K+o88gaaVbxK9cLOEE5AzbNFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oj8PnGEXj0E1rWnVwQJr6+e7qgfZvaUby27wQ5TqCZiq6s++zrRDZMxS5nhTQXyvc
	 DLfleIt6LY+CI9XfpPFJ84Tc94Nwq2SMaBGiNy5WHgU3RKdgqiwyHo8cxkA3VUYpbz
	 C2oMOhZU5nQv4zqOhtV/wuDZsQPj/xBR+B4iA0JztqXg95OG3k4oqJk044UOi0KIyg
	 vc3NoV7wauOu2MXmAA/VpEnyDiWTmmF67voxE1PkyiQf2ikhI3Z5azxJn1ZSShwj1r
	 V8PxNWJ1WsPnNdhZv0qF+ORznmQmG37M2h4jLWU59CfYXqoMXgLFjbP2HiM6N7a1ks
	 j3Jc5Jk2VY81w==
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
Subject: [PATCHv2 bpf-next 02/24] bpf: Add cookies support for uprobe_multi link
Date: Tue, 20 Jun 2023 10:35:28 +0200
Message-ID: <20230620083550.690426-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620083550.690426-1-jolsa@kernel.org>
References: <20230620083550.690426-1-jolsa@kernel.org>
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
 kernel/trace/bpf_trace.c       | 48 +++++++++++++++++++++++++++++++---
 tools/include/uapi/linux/bpf.h |  1 +
 4 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index bfbc1246b220..12d4174fce8f 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1591,6 +1591,7 @@ union bpf_attr {
 				__aligned_u64	path;
 				__aligned_u64	offsets;
 				__aligned_u64	ref_ctr_offsets;
+				__aligned_u64	cookies;
 			} uprobe_multi;
 		};
 	} link_create;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a96e46cd407e..3ae444898c15 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4651,7 +4651,7 @@ static int bpf_map_do_batch(const union bpf_attr *attr,
 	return err;
 }
 
-#define BPF_LINK_CREATE_LAST_FIELD link_create.kprobe_multi.cookies
+#define BPF_LINK_CREATE_LAST_FIELD link_create.uprobe_multi.cookies
 static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 {
 	enum bpf_prog_type ptype;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 806ea9fd210d..f9cd7d283426 100644
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
@@ -1089,6 +1091,18 @@ static const struct bpf_func_proto bpf_get_attach_cookie_proto_kmulti = {
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
@@ -1535,9 +1549,11 @@ kprobe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
@@ -2920,6 +2936,7 @@ struct bpf_uprobe_multi_link;
 struct bpf_uprobe {
 	struct bpf_uprobe_multi_link *link;
 	loff_t offset;
+	u64 cookie;
 	struct uprobe_consumer consumer;
 };
 
@@ -2933,6 +2950,7 @@ struct bpf_uprobe_multi_link {
 struct bpf_uprobe_multi_run_ctx {
 	struct bpf_run_ctx run_ctx;
 	unsigned long entry_ip;
+	struct bpf_uprobe *uprobe;
 };
 
 static void bpf_uprobe_unregister(struct path *path, struct bpf_uprobe *uprobes,
@@ -2976,6 +2994,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 	struct bpf_uprobe_multi_link *link = uprobe->link;
 	struct bpf_uprobe_multi_run_ctx run_ctx = {
 		.entry_ip = entry_ip,
+		.uprobe = uprobe,
 	};
 	struct bpf_prog *prog = link->link.prog;
 	struct bpf_run_ctx *old_run_ctx;
@@ -3026,6 +3045,16 @@ uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, s
 	return uprobe_prog_run(uprobe, func, regs);
 }
 
+static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx)
+{
+	struct bpf_uprobe_multi_run_ctx *run_ctx;
+
+	if (!ctx)
+		return 0;
+	run_ctx = container_of(current->bpf_ctx, struct bpf_uprobe_multi_run_ctx, run_ctx);
+	return run_ctx->uprobe->cookie;
+}
+
 int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
 	unsigned long __user *uref_ctr_offsets, ref_ctr_offset = 0;
@@ -3034,6 +3063,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	unsigned long *ref_ctr_offsets = NULL;
 	struct bpf_link_primer link_primer;
 	struct bpf_uprobe *uprobes = NULL;
+	u64 __user *ucookies, cookie = 0;
 	void __user *upath;
 	u32 flags, cnt, i;
 	struct path path;
@@ -3053,7 +3083,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 
 	/*
 	 * path, offsets and cnt are mandatory,
-	 * ref_ctr_offsets is optional
+	 * ref_ctr_offsets and cookies are optional
 	 */
 	upath = u64_to_user_ptr(attr->link_create.uprobe_multi.path);
 	uoffsets = u64_to_user_ptr(attr->link_create.uprobe_multi.offsets);
@@ -3062,6 +3092,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 		return -EINVAL;
 
 	uref_ctr_offsets = u64_to_user_ptr(attr->link_create.uprobe_multi.ref_ctr_offsets);
+	ucookies = u64_to_user_ptr(attr->link_create.uprobe_multi.cookies);
 
 	name = strndup_user(upath, PATH_MAX);
 	if (IS_ERR(name)) {
@@ -3089,6 +3120,10 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 		goto error_free;
 
 	for (i = 0; i < cnt; i++) {
+		if (ucookies && __get_user(cookie, ucookies + i)) {
+			err = -EFAULT;
+			goto error_free;
+		}
 		if (uref_ctr_offsets && __get_user(ref_ctr_offset, uref_ctr_offsets + i)) {
 			err = -EFAULT;
 			goto error_free;
@@ -3099,6 +3134,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 		}
 
 		uprobes[i].offset = offset;
+		uprobes[i].cookie = cookie;
 		uprobes[i].link = link;
 
 		if (flags & BPF_F_UPROBE_MULTI_RETURN)
@@ -3148,4 +3184,8 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 {
 	return -EOPNOTSUPP;
 }
+static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx)
+{
+	return 0;
+}
 #endif /* CONFIG_UPROBES */
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index bfbc1246b220..12d4174fce8f 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1591,6 +1591,7 @@ union bpf_attr {
 				__aligned_u64	path;
 				__aligned_u64	offsets;
 				__aligned_u64	ref_ctr_offsets;
+				__aligned_u64	cookies;
 			} uprobe_multi;
 		};
 	} link_create;
-- 
2.41.0


