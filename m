Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67AC6ED1FA
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 18:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjDXQF0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 12:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjDXQFZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 12:05:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4335FE4
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 09:05:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16EB861B3B
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 16:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F5FC433D2;
        Mon, 24 Apr 2023 16:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682352322;
        bh=6Xz5NBC/2mzygyBPXXz1IntEiDLJO7+qmSTPRMLiIuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R6tgQ1ReLsnI0vk2/f+fzuNgm41FyiSs5rwBtBWRtkwROeUTabmaBWtL2xNhTwvmP
         xQm+B1p34sq2zkKU1dexvUue707wJvDL+MN7Nz/EaKLXktevqxKocvfWM+VSzNn3wQ
         Ylci/+biAu3HqLiaIylDlLyXp/ybw7PArCfT0vRrRqV+iEv1KBtMrF/ZXAhMdANT/i
         X5RC6aaOkwkLr6Jk4TQlg/6lSUQE0r9XtzBEEpsP7hy7ZRA4DhJJa/CYunyOHQUlVg
         HY1X3kmBsY+bUkUcz5sLhrtwcwYzmpOCFOAgGo/h49rBhZ+rhCkj2w8b+q2/q5kIFN
         kS1PT3FVGGdFA==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [RFC/PATCH bpf-next 03/20] bpf: Add bpf_get_func_ip helper support for uprobe link
Date:   Mon, 24 Apr 2023 18:04:30 +0200
Message-Id: <20230424160447.2005755-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424160447.2005755-1-jolsa@kernel.org>
References: <20230424160447.2005755-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding support for bpf_get_func_ip helper being called from
ebpf program attached by uprobe_multi link.

It returns the ip of the uprobe.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f795cfc00e5f..b9a4a8ff51d7 100644
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
@@ -3024,6 +3039,14 @@ uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, s
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
@@ -3171,4 +3194,8 @@ static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx)
 {
 	return 0;
 }
+static u64 bpf_uprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
+{
+	return 0;
+}
 #endif /* CONFIG_UPROBES */
-- 
2.40.0

