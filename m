Return-Path: <bpf+bounces-3772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77313743750
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 10:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A9928100B
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 08:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BCBA957;
	Fri, 30 Jun 2023 08:34:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03DFA932
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 08:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE22C433CC;
	Fri, 30 Jun 2023 08:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688114089;
	bh=0qoRw/U65xIcHG3lNFN6XfJEJya6smmXh7LEKBX7N8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EkFDzDKo+kG2/pxVXpxhIeUuG3p4nDFB3u/E9KDmDVn9CyFpumMg4Kd+XaOlVKrLt
	 quHkFJTkU06fVYXiL224D494eoIQb3R2js43DcPhFsc5Ph/HizJTMqzHKauUhsOz1A
	 TpWWZ53X80iGN8tfrU21PiP3HrQw1VGAufuKboVU7cY6WxcVTudqgJTr5p0vyz9Tx+
	 yB1NoavLC9V2tLNE2lyC/kNWyp/jGMIBmsJrVJ+T1gvPNQDDQ+6Si7V6RGFbR1Z0kW
	 4abjfxe7iSPWQ07fL3HveVpFKIeoyY4P1bbGVPPsK8RueP9cNd4BU2YS33yPHv18Gm
	 fgNVIiOBhKO8w==
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
Subject: [PATCHv3 bpf-next 05/26] bpf: Add bpf_get_func_ip helper support for uprobe link
Date: Fri, 30 Jun 2023 10:33:23 +0200
Message-ID: <20230630083344.984305-6-jolsa@kernel.org>
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

Adding support for bpf_get_func_ip helper being called from
ebpf program attached by uprobe_multi link.

It returns the ip of the uprobe.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4ef51fd0497f..f5a41c1604b8 100644
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
@@ -3067,6 +3082,14 @@ uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, s
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
@@ -3228,4 +3251,8 @@ static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx)
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


