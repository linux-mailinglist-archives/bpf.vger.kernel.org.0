Return-Path: <bpf+bounces-5447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8259275AD1A
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 13:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D2911C2130B
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 11:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FBE17AC3;
	Thu, 20 Jul 2023 11:36:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF13617744
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 11:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00FBC433C8;
	Thu, 20 Jul 2023 11:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689853016;
	bh=GlUrnE4DR8dOqOUYw41o7qMLNx1RMy/hwmpDx4wG5zA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hynJXD2M+r/Ndjewmz72/UwXRlFaaLB4kraBRzLzOTqESXU9z4fdUg7RUn6QADhtM
	 cqW/hy6QhM5o/uS5RGzJlNAjeaWga3zdAL04pRGJ7p/WcAUZcl0KrozZ4iDFu89dvW
	 7t+RqVXD6i5H51IvjW+oc51v4eMRyTgNMJnAepOwbrzdCY9mw8K/EJr3HD4uG6d8Th
	 GxB0HSyMzP0wCcYqg8F9fj+ZEKjMO9cuhQ6me2QmQIeJ8rSYBkKSIJQN0lk0Kp0+MO
	 Uxwk9LU6yNAs+lc9UbnWfPMxWGGhpjQVQ5pk9Aml8rN0GRytN3BrO2mhW/58PMFWZY
	 CqCPbt9Lo1lUg==
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
Subject: [PATCHv4 bpf-next 06/28] bpf: Add bpf_get_func_ip helper support for uprobe link
Date: Thu, 20 Jul 2023 13:35:28 +0200
Message-ID: <20230720113550.369257-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720113550.369257-1-jolsa@kernel.org>
References: <20230720113550.369257-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support for bpf_get_func_ip helper being called from
ebpf program attached by uprobe_multi link.

It returns the ip of the uprobe.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d5f30747378a..6554555d84be 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -88,6 +88,7 @@ static u64 bpf_kprobe_multi_cookie(struct bpf_run_ctx *ctx);
 static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx);
 
 static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx);
+static u64 bpf_uprobe_multi_entry_ip(struct bpf_run_ctx *ctx);
 
 /**
  * trace_call_bpf - invoke BPF program
@@ -1101,6 +1102,18 @@ static const struct bpf_func_proto bpf_get_attach_cookie_proto_kmulti = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 };
 
+BPF_CALL_1(bpf_get_func_ip_uprobe_multi, struct pt_regs *, regs)
+{
+	return bpf_uprobe_multi_entry_ip(current->bpf_ctx);
+}
+
+static const struct bpf_func_proto bpf_get_func_ip_proto_uprobe_multi = {
+	.func		= bpf_get_func_ip_uprobe_multi,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+};
+
 BPF_CALL_1(bpf_get_attach_cookie_uprobe_multi, struct pt_regs *, regs)
 {
 	return bpf_uprobe_multi_cookie(current->bpf_ctx);
@@ -1555,9 +1568,11 @@ kprobe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_override_return_proto;
 #endif
 	case BPF_FUNC_get_func_ip:
-		return prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI ?
-			&bpf_get_func_ip_proto_kprobe_multi :
-			&bpf_get_func_ip_proto_kprobe;
+		if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI)
+			return &bpf_get_func_ip_proto_kprobe_multi;
+		if (prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI)
+			return &bpf_get_func_ip_proto_uprobe_multi;
+		return &bpf_get_func_ip_proto_kprobe;
 	case BPF_FUNC_get_attach_cookie:
 		if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI)
 			return &bpf_get_attach_cookie_proto_kmulti;
@@ -3110,6 +3125,14 @@ uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, s
 	return uprobe_prog_run(uprobe, func, regs);
 }
 
+static u64 bpf_uprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
+{
+	struct bpf_uprobe_multi_run_ctx *run_ctx;
+
+	run_ctx = container_of(current->bpf_ctx, struct bpf_uprobe_multi_run_ctx, run_ctx);
+	return run_ctx->entry_ip;
+}
+
 static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx)
 {
 	struct bpf_uprobe_multi_run_ctx *run_ctx;
@@ -3271,4 +3294,8 @@ static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx)
 {
 	return 0;
 }
+static u64 bpf_uprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
+{
+	return 0;
+}
 #endif /* CONFIG_UPROBES */
-- 
2.41.0


