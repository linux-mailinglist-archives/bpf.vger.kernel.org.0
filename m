Return-Path: <bpf+bounces-40518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5997198976E
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 22:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47A841C20A7A
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 20:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0981516BE0D;
	Sun, 29 Sep 2024 20:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATdM21FL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0A3152178;
	Sun, 29 Sep 2024 20:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727643483; cv=none; b=Y+6fKopsWXh0fZ9KagF/BN8pzVtpOoZUH99Qo64YJ63wakrp263dJdxiui5YL313F5fAWt+65QmxwsJ/rwJZ4L0EQVAj59ubrPzFBJ/J2USLnvIoSz47u11gaVmeQUKXtA30o0vdmsRMkbhQ9wfqlXAu9BI/iWI+oaannbezYbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727643483; c=relaxed/simple;
	bh=NbIOzuT2nLtZ5vE0O540zbVsWi9LjQpTCYwdefeJy9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QGRZr/VKce2mPb8f01Y0N6FdbW8gCelWcNxGV7OrP30HdDAPlo9Viw8pNIseY9lUw7zEiJFUX+QErrBcnvb8xnqttawJosMnRSAG20ojv1fG9dHwpQXcd6E/C7CSqo1igw2LA7yTPGnz6V4BHZwFTBvViEY/RAfMGbDuFE710gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATdM21FL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865C3C4CEC5;
	Sun, 29 Sep 2024 20:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727643482;
	bh=NbIOzuT2nLtZ5vE0O540zbVsWi9LjQpTCYwdefeJy9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ATdM21FLOXjZB8F3CnHvNeolQewkP1mTSnabjpcSVBx4KPxWOOhLeWqQDkvwOD2iU
	 0DWtRzLCpJz3RX5pFO/ZZLkGCjJzGhlreK2IAXEIV418cxUkcGhaWkvqPpqz11C7CZ
	 2upfdvzXTn1C+QfCyb1sHXGC5O4HEcE5/56epuz21tuBeaqw1xjSYDtWk2E8KMLRcj
	 ANuDThW+7KtOkYSSWPArwdp4WJFAzk2eoAqUqlMtVVm2BNfzSNgX0Q8/BF8SZ3Oz3g
	 jAyz+Lbj3K/BsVwotht3ZhPzal3KGNP5+nP5hiU7T4DHX/MXlJqO/I84eEuwD6xRE3
	 eWtiLQT2wZOsQ==
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
Subject: [PATCHv5 bpf-next 03/13] bpf: Add support for uprobe multi session attach
Date: Sun, 29 Sep 2024 22:57:07 +0200
Message-ID: <20240929205717.3813648-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240929205717.3813648-1-jolsa@kernel.org>
References: <20240929205717.3813648-1-jolsa@kernel.org>
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
 kernel/bpf/syscall.c           |  9 ++++++--
 kernel/trace/bpf_trace.c       | 39 +++++++++++++++++++++++++++-------
 tools/include/uapi/linux/bpf.h |  1 +
 tools/lib/bpf/libbpf.c         |  1 +
 5 files changed, 41 insertions(+), 10 deletions(-)

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
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index fdab7ecd8dfa..98e940ec184d 100644
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
@@ -3248,9 +3260,13 @@ uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs,
 			  __u64 *data)
 {
 	struct bpf_uprobe *uprobe;
+	int ret;
 
 	uprobe = container_of(con, struct bpf_uprobe, consumer);
-	return uprobe_prog_run(uprobe, instruction_pointer(regs), regs);
+	ret = uprobe_prog_run(uprobe, instruction_pointer(regs), regs);
+	if (uprobe->session)
+		return ret ? UPROBE_HANDLER_IGNORE : 0;
+	return ret;
 }
 
 static int
@@ -3260,6 +3276,12 @@ uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, s
 	struct bpf_uprobe *uprobe;
 
 	uprobe = container_of(con, struct bpf_uprobe, consumer);
+	/*
+	 * There's chance we could get called with NULL data if we registered uprobe
+	 * after it hit entry but before it hit return probe, just ignore it.
+	 */
+	if (uprobe->session && !data)
+		return 0;
 	return uprobe_prog_run(uprobe, func, regs);
 }
 
@@ -3299,7 +3321,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	if (sizeof(u64) != sizeof(void *))
 		return -EOPNOTSUPP;
 
-	if (prog->expected_attach_type != BPF_TRACE_UPROBE_MULTI)
+	if (!is_uprobe_multi(prog))
 		return -EINVAL;
 
 	flags = attr->link_create.uprobe_multi.flags;
@@ -3375,11 +3397,12 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 
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
index 712b95e8891b..3587ed7ec359 100644
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
2.46.1


