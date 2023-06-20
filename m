Return-Path: <bpf+bounces-2884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E0973665B
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 10:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E07C1281060
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 08:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634EEBE62;
	Tue, 20 Jun 2023 08:36:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95D1AD56
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 08:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4D5C433C0;
	Tue, 20 Jun 2023 08:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687250194;
	bh=ZO8e7ZUuCYow+86JgR3lAD3XBHgd7dwTCkhXMwpkdsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vPs+BE0+DzQpAZZv+vgAs2X8p6zccoH+rGAvG1gt7hVnK8zynSUy9gAMHiJviODYC
	 dutVAXQjBX3WSGvih5IJKicSBHm1Ajvq8iRhMATt2gtrA/wrK8/G1NDVilkH+BSmNY
	 NCur1aZ2rqc+rqjrQbopzcPN0H51tfhygTJn38xWnddQJdSjSIzb8Z9HjHkqZLLgxy
	 lPstbAMK1IlD+3Lazy6MVR5ffiT525xKKwewsKWFSrhh3zmQ1TsVeVg+LpQb+8WmHD
	 cE+tEtTwAMgmOgHtJKD5rJnIsEE9BAbq7Pugkz43RVHV0HheX69plWEvgNreY1kVL7
	 MzPu5Ghj/NzMA==
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
Subject: [PATCHv2 bpf-next 04/24] bpf: Add bpf_get_func_ip helper support for uprobe link
Date: Tue, 20 Jun 2023 10:35:30 +0200
Message-ID: <20230620083550.690426-5-jolsa@kernel.org>
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

Adding support for bpf_get_func_ip helper being called from
ebpf program attached by uprobe_multi link.

It returns the ip of the uprobe.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 5c5b543d7d03..dfba0bb479a2 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -88,6 +88,7 @@ static u64 bpf_kprobe_multi_cookie(struct bpf_run_ctx *ctx);
 static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx);
 
 static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx);
+static u64 bpf_uprobe_multi_entry_ip(struct bpf_run_ctx *ctx);
 
 /**
  * trace_call_bpf - invoke BPF program
@@ -1091,6 +1092,18 @@ static const struct bpf_func_proto bpf_get_attach_cookie_proto_kmulti = {
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
@@ -1545,9 +1558,11 @@ kprobe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
@@ -3061,6 +3076,14 @@ uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, s
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
@@ -3221,4 +3244,8 @@ static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx)
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


