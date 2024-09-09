Return-Path: <bpf+bounces-39271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3157971015
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 09:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074671C22084
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 07:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858671B0131;
	Mon,  9 Sep 2024 07:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXqmtOcp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050F01AF4EB;
	Mon,  9 Sep 2024 07:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725867987; cv=none; b=ecCQ9jlb/DbmvhFbo0R2RN6uQNIdwEOlnUYZolBJsvnFyeZc8IYIe5mS06iT1l5rT2rmCCEHrohrlMosgT+/5FrlQKaAkY1H8WAWEGBZCqJ/CMsaXCkb3Z7VTNgaNsi04x3LFiJBXqt0SXAzK3t+P08k52oHNqfr7seD753/duE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725867987; c=relaxed/simple;
	bh=xAFY2t2/AZlQClCjMks65BvDZWK7PpFqi2ElzOn5PTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8e/caEvZHLL7IDAx1ojxTmpiDHfNI/hqNjoMn3O7SOMuoIreywqYXEp5BY0nr71FsBvnAChx/P7aoXDiLECAmy1WnW/vpe2e+yibrriRRnKju83MHAQsghvBkyuny+YSW0RyQmq5IFqLZ83ChFSlThDY5Sawt1CVUGPJ03EnnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXqmtOcp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA75C4CEC8;
	Mon,  9 Sep 2024 07:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725867984;
	bh=xAFY2t2/AZlQClCjMks65BvDZWK7PpFqi2ElzOn5PTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aXqmtOcp8YpYB+2gYlaJpfaxf6bCH365qqsO8TKDxjgQcfctK+hI1DG0TcB2zG/zC
	 NCr/rlDFyhDozZnUE9OofPURFNb6Rili2BRvoVJp4VydR+OmhnsGXqGkQV9HEeytKs
	 Br++ls07BgrmZpeboEqgOGOVfoh7wQv3CtVxEvnkK9Cf3UJ4Fhvbeu/dnAfg5NnLSG
	 zYYZ23OsJEB0t7R4QfbnPluQUYGwDN+E7GWAy9nCUguQHpBv0Uoa9Dv2cXAKz+bzqV
	 Yd5ejqsVLUVkgCUsoAXhsmeh6x+3hkBtiQMpuuEnt1mVEpSdFEXDsDniC6pdm4fE1q
	 jWRHiBS0WxsKg==
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
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv3 2/7] bpf: Add support for uprobe multi session attach
Date: Mon,  9 Sep 2024 09:45:49 +0200
Message-ID: <20240909074554.2339984-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909074554.2339984-1-jolsa@kernel.org>
References: <20240909074554.2339984-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support to attach bpf program for entry and return probe
of the same function. This is common use case which at the moment
requires to create two uprobe multi links.

Adding new BPF_TRACE_UPROBE_SESSION attach type that instructs
kernel to attach single link program to both entry and exit probe.

It's possible to control execution of the bpf program on return
probe simply by returning zero or non zero from the entry bpf
program execution to execute or not the bpf program on return
probe respectively.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/syscall.c           |  9 +++++++--
 kernel/trace/bpf_trace.c       | 32 ++++++++++++++++++++++++--------
 tools/include/uapi/linux/bpf.h |  1 +
 tools/lib/bpf/libbpf.c         |  1 +
 5 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 35bcf52dbc65..1d93cb014884 100644
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
index bf6c5f685ea2..1347f3000bd0 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4049,10 +4049,14 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
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
@@ -5315,7 +5319,8 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 		else if (attr->link_create.attach_type == BPF_TRACE_KPROBE_MULTI ||
 			 attr->link_create.attach_type == BPF_TRACE_KPROBE_SESSION)
 			ret = bpf_kprobe_multi_link_attach(attr, prog);
-		else if (attr->link_create.attach_type == BPF_TRACE_UPROBE_MULTI)
+		else if (attr->link_create.attach_type == BPF_TRACE_UPROBE_MULTI ||
+			 attr->link_create.attach_type == BPF_TRACE_UPROBE_SESSION)
 			ret = bpf_uprobe_multi_link_attach(attr, prog);
 		break;
 	default:
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index de241503c8fb..a433e80771d2 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1645,6 +1645,17 @@ static inline bool is_kprobe_session(const struct bpf_prog *prog)
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
@@ -1662,13 +1673,13 @@ kprobe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
@@ -3336,9 +3347,13 @@ uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs,
 			  __u64 *data)
 {
 	struct bpf_uprobe *uprobe;
+	int ret;
 
 	uprobe = container_of(con, struct bpf_uprobe, consumer);
-	return uprobe_prog_run(uprobe, instruction_pointer(regs), regs);
+	ret = uprobe_prog_run(uprobe, instruction_pointer(regs), regs);
+	if (uprobe->consumer.session)
+		return ret ? UPROBE_HANDLER_IGNORE : 0;
+	return ret;
 }
 
 static int
@@ -3387,7 +3402,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	if (sizeof(u64) != sizeof(void *))
 		return -EOPNOTSUPP;
 
-	if (prog->expected_attach_type != BPF_TRACE_UPROBE_MULTI)
+	if (!is_uprobe_multi(prog))
 		return -EINVAL;
 
 	flags = attr->link_create.uprobe_multi.flags;
@@ -3463,11 +3478,12 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 
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
+			uprobes[i].consumer.session = true;
 		if (pid)
 			uprobes[i].consumer.filter = uprobe_multi_link_filter;
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 35bcf52dbc65..1d93cb014884 100644
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
index a3be6f8fac09..274441674f92 100644
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
2.46.0


