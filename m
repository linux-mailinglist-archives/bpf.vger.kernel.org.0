Return-Path: <bpf+bounces-7298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB777755AB
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 10:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3031C2119F
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 08:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6338118001;
	Wed,  9 Aug 2023 08:35:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAF5613E
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 08:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23661C433C8;
	Wed,  9 Aug 2023 08:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691570146;
	bh=7++ffCO+n58pyNqJHV/sopLtGjDbpbOGtk800+Y7QZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ubqzBGZ5r22ygoEd+gSjJukW93Z/Ev7fzlGUo9rS4e5s2JI+E/8PvHXziIFKd4Oxi
	 FjVYwwNLgyTVzyKor7SVryDoTKUNbFPAmnU123R7mA5LR2GARTM9u7GA22+beIKJuR
	 kZa0JA/11DvQErY6F7zO4tYPaa5CL54ROxoVBkZZqv8b3sk83guZqd3QDR7yb5eebZ
	 bvYpNCQoQuvh2AfusCPVrpz/q5qPIQdvAtWtwToJEw+HnLhRi2QG1nslkU/wensGOl
	 22vCklhiqipetI3FMQ6+9FbcVLRlchmXGG0xIuW9jphVRmoh8OC+UhBGtLZ9mdT/Xa
	 pPC7NEaxSZX3A==
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
Subject: [PATCHv7 bpf-next 06/28] bpf: Add bpf_get_func_ip helper support for uprobe link
Date: Wed,  9 Aug 2023 10:34:18 +0200
Message-ID: <20230809083440.3209381-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809083440.3209381-1-jolsa@kernel.org>
References: <20230809083440.3209381-1-jolsa@kernel.org>
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
index e45aebed62f5..a7264b2c17ad 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -88,6 +88,7 @@ static u64 bpf_kprobe_multi_cookie(struct bpf_run_ctx *ctx);
 static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx);
 
 static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx);
+static u64 bpf_uprobe_multi_entry_ip(struct bpf_run_ctx *ctx);
 
 /**
  * trace_call_bpf - invoke BPF program
@@ -1106,6 +1107,18 @@ static const struct bpf_func_proto bpf_get_attach_cookie_proto_kmulti = {
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
@@ -1560,9 +1573,11 @@ kprobe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
@@ -3113,6 +3128,14 @@ uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, s
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
@@ -3272,4 +3295,8 @@ static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx)
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


