Return-Path: <bpf+bounces-40026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8940A97AD16
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 10:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F13F1F24E81
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 08:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E299C15AACA;
	Tue, 17 Sep 2024 08:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIo8smlN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C1D150990;
	Tue, 17 Sep 2024 08:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563070; cv=none; b=Emg3NMk1RTmjcZyE/x7Xv2jy+zsdXEjYJC1kmnyCGtGoWOj/Pc2u+GGwWDBspDTmTr4qkO2AgHekTfHAwQ5z+n9yMGxYSZhgoqhJFnddB4fk1lIvbzJAzjNqt11/UkIJ32okG89agGwmsh1mBg792PHhYLnORNOoqh2g4sTabPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563070; c=relaxed/simple;
	bh=vvv2wFWusenVsANF2Ddd6xnu3Qyl4aYD0AqhkEHp8fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RN2x7q9hJtMqje4ZlbQMpLtL7IMTDkOFdX2k2vDobAkSneL90WOHOKQMkL6t8hRW4+cCJgjl+nfjWTfpiRzO0U7HeJl9/tSoq21Pp6z6aqQSSDGQcigAmEZ2EtnPkGXckoSsxg2yNsjC45N2IsB0Qcw3DIrFZl52P9bXT7y9cLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIo8smlN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47417C4CEC5;
	Tue, 17 Sep 2024 08:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726563070;
	bh=vvv2wFWusenVsANF2Ddd6xnu3Qyl4aYD0AqhkEHp8fM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FIo8smlNM76utJJRX2CWXev3bhPI4WE/UgchGzG2v662N9TzTt7Q24ASYMcnra5Xa
	 LxvWFiHatOBEB3UVfcfnly9NfHc+MRi4VuTvbvBqcfMMUQUuhjGiTa4ohqD9R6I/0o
	 J2O7AorHzvwQCbuP6shhqDH/po45tV5cnn3aHWcWX8DUt5F6rwBb7hvj6MiyBhEPxn
	 xwhslEIHSv1ZGXr/jgUtIWP09a3jY0AVgeyQe8Ic6mTXhLk3qsFG9no3IYN0io0xtZ
	 ZHgOdWQOzhZZgLGUzYSrbt6OzZ7mHJD9XcoL6uEeVOFLRlWL7wYbcd+EgmR2NPz+BL
	 958ZErlH2ranQ==
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
Subject: [PATCHv4 03/14] bpf: Add support for uprobe multi session attach
Date: Tue, 17 Sep 2024 10:50:13 +0200
Message-ID: <20240917085024.765883-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917085024.765883-1-jolsa@kernel.org>
References: <20240917085024.765883-1-jolsa@kernel.org>
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
index de241503c8fb..63ea457af16a 100644
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
@@ -3162,6 +3173,7 @@ struct bpf_uprobe {
 	u64 cookie;
 	struct uprobe *uprobe;
 	struct uprobe_consumer consumer;
+	bool session;
 };
 
 struct bpf_uprobe_multi_link {
@@ -3336,9 +3348,13 @@ uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs,
 			  __u64 *data)
 {
 	struct bpf_uprobe *uprobe;
+	int ret;
 
 	uprobe = container_of(con, struct bpf_uprobe, consumer);
-	return uprobe_prog_run(uprobe, instruction_pointer(regs), regs);
+	ret = uprobe_prog_run(uprobe, instruction_pointer(regs), regs);
+	if (uprobe->session)
+		return ret ? UPROBE_HANDLER_IGNORE : UPROBE_HANDLER_IWANTMYCOOKIE;
+	return ret;
 }
 
 static int
@@ -3348,6 +3364,12 @@ uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, s
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
 
@@ -3387,7 +3409,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	if (sizeof(u64) != sizeof(void *))
 		return -EOPNOTSUPP;
 
-	if (prog->expected_attach_type != BPF_TRACE_UPROBE_MULTI)
+	if (!is_uprobe_multi(prog))
 		return -EINVAL;
 
 	flags = attr->link_create.uprobe_multi.flags;
@@ -3463,11 +3485,12 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 
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


