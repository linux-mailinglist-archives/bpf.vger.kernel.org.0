Return-Path: <bpf+bounces-41624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7796499936D
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 22:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7FD11F24B2D
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 20:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5081E1C1A;
	Thu, 10 Oct 2024 20:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6QCLt/k"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2118919C553;
	Thu, 10 Oct 2024 20:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728591066; cv=none; b=NZvLC5Mc6+eC6PPQNYCqszV1CiSIHosCG4eKynDk2bQy3JzcXSTCh+QN/oXiIBd6nfoo/hQphHk//1JFGs1sVKg6j6TbXi94bRczYS5n3UX4fmoKf3F85dfypQUjP6oaTNyhgtlyO4YGmOPlp/Un0ZJwkDFfHMKaB+PYWXSxDxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728591066; c=relaxed/simple;
	bh=Egd9yHpt7DStjWnY/MiUguu8Zo1DJ/1r6pyBYjgxp8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rkTgG45hDvM9ginMWLDjmuoVqqV9/2etWSdO8SJJFJ0ZenfyiE5nx25P6dN8bJOxpVZDLx5eIwxlwfU4FUJd/1RURj5BrvbPsiBoML5ftLFxrFemc8PAzfqi9Q20/67my0W2XXiXOIUzWCQzAraUC0HEWmGk4hItAfxU/AESspg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6QCLt/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4473C4CEC5;
	Thu, 10 Oct 2024 20:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728591065;
	bh=Egd9yHpt7DStjWnY/MiUguu8Zo1DJ/1r6pyBYjgxp8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X6QCLt/kIhFfUGcBIi8lxt8yQoGGKlCFZDR50Wa6h4+0G9JiVSKXZVTnM0FL3SC3E
	 x3Z/ugVzhTeLNxsg5hEcNurqu0LL6CRqHo9fUJT/Mje8zt41UlZEz3j1hxn/cI6YWu
	 hHOvW40xirOiB8kjFNQgikBEB4pNL1aydlhVc0uny+fx4brLdy5Z/sfN5Ftpl7C+Da
	 sFCxihXEfQ8FZsjctHkBxd+ycfkk0yjqchgNlHIclwiMzvQFGvYNYHcguzV3zCJ3mR
	 vmzndMq+i+sW97gfO8BXk32QOhwASalAwDJulPISNbnE7fLpDe486SZy2hulhXj8yo
	 b/Trhvv6sPfrA==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv6 bpf-next 05/16] bpf: Add support for uprobe multi session attach
Date: Thu, 10 Oct 2024 22:09:46 +0200
Message-ID: <20241010200957.2750179-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241010200957.2750179-1-jolsa@kernel.org>
References: <20241010200957.2750179-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support to attach BPF program for entry and return probe
of the same function. This is common use case which at the moment
requires to create two uprobe multi links.

Adding new BPF_TRACE_UPROBE_SESSION attach type that instructs
kernel to attach single link program to both entry and exit probe.

It's possible to control execution of the BPF program on return
probe simply by returning zero or non zero from the entry BPF
program execution to execute or not the BPF program on return
probe respectively.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/syscall.c           |  9 +++++++--
 kernel/bpf/verifier.c          |  1 +
 kernel/trace/bpf_trace.c       | 36 +++++++++++++++++++++++++---------
 tools/include/uapi/linux/bpf.h |  1 +
 tools/lib/bpf/libbpf.c         |  1 +
 6 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 8ab4d8184b9d..77d0bc5fa986 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1116,6 +1116,7 @@ enum bpf_attach_type {
 	BPF_NETKIT_PRIMARY,
 	BPF_NETKIT_PEER,
 	BPF_TRACE_KPROBE_SESSION,
+	BPF_TRACE_UPROBE_SESSION,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a8f1808a1ca5..0cf7617e6cb6 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3983,10 +3983,14 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
 		if (prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI &&
 		    attach_type != BPF_TRACE_UPROBE_MULTI)
 			return -EINVAL;
+		if (prog->expected_attach_type == BPF_TRACE_UPROBE_SESSION &&
+		    attach_type != BPF_TRACE_UPROBE_SESSION)
+			return -EINVAL;
 		if (attach_type != BPF_PERF_EVENT &&
 		    attach_type != BPF_TRACE_KPROBE_MULTI &&
 		    attach_type != BPF_TRACE_KPROBE_SESSION &&
-		    attach_type != BPF_TRACE_UPROBE_MULTI)
+		    attach_type != BPF_TRACE_UPROBE_MULTI &&
+		    attach_type != BPF_TRACE_UPROBE_SESSION)
 			return -EINVAL;
 		return 0;
 	case BPF_PROG_TYPE_SCHED_CLS:
@@ -5239,7 +5243,8 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 		else if (attr->link_create.attach_type == BPF_TRACE_KPROBE_MULTI ||
 			 attr->link_create.attach_type == BPF_TRACE_KPROBE_SESSION)
 			ret = bpf_kprobe_multi_link_attach(attr, prog);
-		else if (attr->link_create.attach_type == BPF_TRACE_UPROBE_MULTI)
+		else if (attr->link_create.attach_type == BPF_TRACE_UPROBE_MULTI ||
+			 attr->link_create.attach_type == BPF_TRACE_UPROBE_SESSION)
 			ret = bpf_uprobe_multi_link_attach(attr, prog);
 		break;
 	default:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 787008872a14..c4d7b7369259 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15913,6 +15913,7 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 	case BPF_PROG_TYPE_KPROBE:
 		switch (env->prog->expected_attach_type) {
 		case BPF_TRACE_KPROBE_SESSION:
+		case BPF_TRACE_UPROBE_SESSION:
 			range = retval_range(0, 1);
 			break;
 		default:
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3c1e5a561df4..5f10994376d0 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1557,6 +1557,17 @@ static inline bool is_kprobe_session(const struct bpf_prog *prog)
 	return prog->expected_attach_type == BPF_TRACE_KPROBE_SESSION;
 }
 
+static inline bool is_uprobe_multi(const struct bpf_prog *prog)
+{
+	return prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI ||
+	       prog->expected_attach_type == BPF_TRACE_UPROBE_SESSION;
+}
+
+static inline bool is_uprobe_session(const struct bpf_prog *prog)
+{
+	return prog->expected_attach_type == BPF_TRACE_UPROBE_SESSION;
+}
+
 static const struct bpf_func_proto *
 kprobe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -1574,13 +1585,13 @@ kprobe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_get_func_ip:
 		if (is_kprobe_multi(prog))
 			return &bpf_get_func_ip_proto_kprobe_multi;
-		if (prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI)
+		if (is_uprobe_multi(prog))
 			return &bpf_get_func_ip_proto_uprobe_multi;
 		return &bpf_get_func_ip_proto_kprobe;
 	case BPF_FUNC_get_attach_cookie:
 		if (is_kprobe_multi(prog))
 			return &bpf_get_attach_cookie_proto_kmulti;
-		if (prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI)
+		if (is_uprobe_multi(prog))
 			return &bpf_get_attach_cookie_proto_umulti;
 		return &bpf_get_attach_cookie_proto_trace;
 	default:
@@ -3074,6 +3085,7 @@ struct bpf_uprobe {
 	u64 cookie;
 	struct uprobe *uprobe;
 	struct uprobe_consumer consumer;
+	bool session;
 };
 
 struct bpf_uprobe_multi_link {
@@ -3247,9 +3259,13 @@ uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs,
 			  __u64 *data)
 {
 	struct bpf_uprobe *uprobe;
+	int ret;
 
 	uprobe = container_of(con, struct bpf_uprobe, consumer);
-	return uprobe_prog_run(uprobe, instruction_pointer(regs), regs);
+	ret = uprobe_prog_run(uprobe, instruction_pointer(regs), regs);
+	if (uprobe->session)
+		return ret ? UPROBE_HANDLER_IGNORE : 0;
+	return 0;
 }
 
 static int
@@ -3259,7 +3275,8 @@ uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, s
 	struct bpf_uprobe *uprobe;
 
 	uprobe = container_of(con, struct bpf_uprobe, consumer);
-	return uprobe_prog_run(uprobe, func, regs);
+	uprobe_prog_run(uprobe, func, regs);
+	return 0;
 }
 
 static u64 bpf_uprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
@@ -3298,7 +3315,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	if (sizeof(u64) != sizeof(void *))
 		return -EOPNOTSUPP;
 
-	if (prog->expected_attach_type != BPF_TRACE_UPROBE_MULTI)
+	if (!is_uprobe_multi(prog))
 		return -EINVAL;
 
 	flags = attr->link_create.uprobe_multi.flags;
@@ -3374,11 +3391,12 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 
 		uprobes[i].link = link;
 
-		if (flags & BPF_F_UPROBE_MULTI_RETURN)
-			uprobes[i].consumer.ret_handler = uprobe_multi_link_ret_handler;
-		else
+		if (!(flags & BPF_F_UPROBE_MULTI_RETURN))
 			uprobes[i].consumer.handler = uprobe_multi_link_handler;
-
+		if (flags & BPF_F_UPROBE_MULTI_RETURN || is_uprobe_session(prog))
+			uprobes[i].consumer.ret_handler = uprobe_multi_link_ret_handler;
+		if (is_uprobe_session(prog))
+			uprobes[i].session = true;
 		if (pid)
 			uprobes[i].consumer.filter = uprobe_multi_link_filter;
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7610883c8191..09bdb1867d4a 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1116,6 +1116,7 @@ enum bpf_attach_type {
 	BPF_NETKIT_PRIMARY,
 	BPF_NETKIT_PEER,
 	BPF_TRACE_KPROBE_SESSION,
+	BPF_TRACE_UPROBE_SESSION,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 05ad264ff09b..1caa9d20de5d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -133,6 +133,7 @@ static const char * const attach_type_name[] = {
 	[BPF_NETKIT_PRIMARY]		= "netkit_primary",
 	[BPF_NETKIT_PEER]		= "netkit_peer",
 	[BPF_TRACE_KPROBE_SESSION]	= "trace_kprobe_session",
+	[BPF_TRACE_UPROBE_SESSION]	= "trace_uprobe_session",
 };
 
 static const char * const link_type_name[] = {
-- 
2.46.2


