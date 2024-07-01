Return-Path: <bpf+bounces-33514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA4591E58B
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 18:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1203B282016
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 16:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512B216D9CA;
	Mon,  1 Jul 2024 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ju8H2Vqa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E7D16D9D9;
	Mon,  1 Jul 2024 16:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852130; cv=none; b=T5j0C1l4PKQxJEoWmNFsmhN7cg4MoMfeC8sNPWsKsGIYWTCGJaTQuJS5YTi7vmDMA/adhkrYw6V8S/Z+ipT8dwLBToOV4gUq85ps/DsS2vI4JOHFgtP0eMjV+NKo2cuGbMN/fUes/57n3N/6HMnOtvSkDuonhpv/VVzoeOwAegA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852130; c=relaxed/simple;
	bh=Ug3V3kjs/SqMzYO3TzeAnR5TQPaQ/Fmt65FqJtd/pJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQoEuqUYfracAUNyEcdkYhsZLYU8ogGgmODIXJosoQA2feGEN5/5wFwk9hL4DDhT1tTulZqNPiqTeVSftUFQWX4WPFXkrf9y/Su1fiMOgtQhRshmu85h21JizHkQt8z3Ec2j30u2OifxCAg8lRNhiMYzcwdI+OlhzZD4iUqoHVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ju8H2Vqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B9DC116B1;
	Mon,  1 Jul 2024 16:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719852130;
	bh=Ug3V3kjs/SqMzYO3TzeAnR5TQPaQ/Fmt65FqJtd/pJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ju8H2VqaqNrtILbNYoT5qR4DQGBXKOLCBQ5HKEIt6OCLNjKnGOcld7UvrTl0ivYC7
	 1bTKDtEPlpqNVblYw6kzx332J7/W1AJS35VMqlJ19lCq/cYXTTgYtzTqJO2iHoN0eZ
	 oeJAk+t/ZKjYIyA4Joei+6Y9LiLjTwV1NZT0wGynmwvMubgWDyoJvyJDR5UxPU3J+b
	 mw+FtmGOL4cXPkZCba602kGYxygne3wDdCdppGoipA/kYARNfas00cRkcU5KLO9mCG
	 4M+2t9S/bcAo9G/K49FcTgfiPkBEe8dDfjAKiXXRs2OjxwRZcc0gFrkP5jJupBwF18
	 iZ4lyu11aIjcA==
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
Subject: [PATCHv2 bpf-next 2/9] bpf: Add support for uprobe multi session attach
Date: Mon,  1 Jul 2024 18:41:08 +0200
Message-ID: <20240701164115.723677-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701164115.723677-1-jolsa@kernel.org>
References: <20240701164115.723677-1-jolsa@kernel.org>
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
 kernel/trace/bpf_trace.c       | 25 +++++++++++++++++++------
 tools/include/uapi/linux/bpf.h |  1 +
 4 files changed, 28 insertions(+), 8 deletions(-)

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
index 869265852d51..2a63a528fa3c 100644
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
index 02d052639dfe..1b19c1cdb5e1 100644
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
@@ -3387,7 +3398,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	if (sizeof(u64) != sizeof(void *))
 		return -EOPNOTSUPP;
 
-	if (prog->expected_attach_type != BPF_TRACE_UPROBE_MULTI)
+	if (!is_uprobe_multi(prog))
 		return -EINVAL;
 
 	flags = attr->link_create.uprobe_multi.flags;
@@ -3463,10 +3474,12 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 
 		uprobes[i].link = link;
 
-		if (flags & BPF_F_UPROBE_MULTI_RETURN)
-			uprobes[i].consumer.ret_handler = uprobe_multi_link_ret_handler;
-		else
+		if (!(flags & BPF_F_UPROBE_MULTI_RETURN))
 			uprobes[i].consumer.handler = uprobe_multi_link_handler;
+		if (flags & BPF_F_UPROBE_MULTI_RETURN || is_uprobe_session(prog))
+			uprobes[i].consumer.ret_handler = uprobe_multi_link_ret_handler;
+		if (is_uprobe_session(prog))
+			uprobes[i].consumer.session = true;
 
 		if (pid)
 			uprobes[i].consumer.filter = uprobe_multi_link_filter;
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
 
-- 
2.45.2


