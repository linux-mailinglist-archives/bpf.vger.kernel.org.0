Return-Path: <bpf+bounces-5102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51607567C0
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 17:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD8A28108B
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 15:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D7ABA30;
	Mon, 17 Jul 2023 15:23:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1CBA94F
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 15:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EF8C433C7;
	Mon, 17 Jul 2023 15:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689607411;
	bh=cvdO36sarOiv5ZpCKU2EQAmrbByydT2MCd5DqCQtaFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CiXJ4YoiIgypHxscNLzvVUm/eIK/XxIR43zivwBPTByv4h1w2LYd6zyEgyEiBIBrS
	 UPpJHHiZe+fNd/ZojAuxR4+P5/pPkM9yBbGjByYAoLLiWrZKWf/BHq78hdMY4XJBz2
	 tgDychYcg15CMuYi3XkTGuGtcnQTIlc3fyLdrXli3bbCl84QOJWRyM74DcLoldDoRn
	 +9nWFfvceH7Ssv+9kw3oj7pABfrbMb4xnYq4MprQx80XHQ32WW8fMLG6JLf6Ne8Ldi
	 CS7YfmLgmDcUeOjnvHW9FuZRgAXPkoWZvbzHEw0H0eoYYkyfesnanBBH6+YJ19s+Kp
	 6CcB0qvYJ8kBg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v2 1/9] tracing/probes: Fix to add NULL check for BTF APIs
Date: Tue, 18 Jul 2023 00:23:27 +0900
Message-Id: <168960740754.34107.12202350138610653557.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <168960739768.34107.15145201749042174448.stgit@devnote2>
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since find_btf_func_param() abd btf_type_by_id() can return NULL,
the caller must check the return value correctly.

Fixes: b576e09701c7 ("tracing/probes: Support function parameters if BTF is available")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index b2b726bea1f9..c68a72707852 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -386,12 +386,12 @@ static const struct btf_type *find_btf_func_proto(const char *funcname)
 
 	/* Get BTF_KIND_FUNC type */
 	t = btf_type_by_id(btf, id);
-	if (!btf_type_is_func(t))
+	if (!t || !btf_type_is_func(t))
 		return ERR_PTR(-ENOENT);
 
 	/* The type of BTF_KIND_FUNC is BTF_KIND_FUNC_PROTO */
 	t = btf_type_by_id(btf, t->type);
-	if (!btf_type_is_func_proto(t))
+	if (!t || !btf_type_is_func_proto(t))
 		return ERR_PTR(-ENOENT);
 
 	return t;
@@ -443,7 +443,7 @@ static int parse_btf_arg(const char *varname, struct fetch_insn *code,
 	if (!ctx->params) {
 		params = find_btf_func_param(ctx->funcname, &ctx->nr_params,
 					     ctx->flags & TPARG_FL_TPOINT);
-		if (IS_ERR(params)) {
+		if (IS_ERR_OR_NULL(params)) {
 			trace_probe_log_err(ctx->offset, NO_BTF_ENTRY);
 			return PTR_ERR(params);
 		}
@@ -1273,7 +1273,7 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
 
 	params = find_btf_func_param(ctx->funcname, &nr_params,
 				     ctx->flags & TPARG_FL_TPOINT);
-	if (IS_ERR(params)) {
+	if (IS_ERR_OR_NULL(params)) {
 		if (args_idx != -1) {
 			/* $arg* requires BTF info */
 			trace_probe_log_err(0, NOSUP_BTFARG);


