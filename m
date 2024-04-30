Return-Path: <bpf+bounces-28249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C01108B743A
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 13:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E397A1C21F3C
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 11:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BDB12D74E;
	Tue, 30 Apr 2024 11:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLhJ4vBh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F6A17592
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 11:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476526; cv=none; b=pHaZ3eSMBR6OXXP9zhvkdl/WNub95mde9k9fh4tzb8iiVnBpSSdoDz9T0ljAAJJ9IxWCfPuYsqvFWt0IOw000i3yfHfMOSSTdIL+i7YBE8Rw1PaOmHHA1pCMAp3iwmrYRslDLLqDDCL4QybdinqC/BP/YcEDBb9kGEaFnMF05bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476526; c=relaxed/simple;
	bh=+Wyt40nHXygASe1A/r/6/0sD5kuRWHrKMcELD2/oqis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbLCeRDWkSbTHpfMWv8N7oeKbjh8ym/SPPAWtcUNOgOHfsG4mYoVYrGyTtgNqKirRtck3Lhe9om8Rnw+tODrl4C+s+XIhwZdlckVAjJYOgOzBXpYC99QZL4UxDaqBLyIJQUk+1WeWEIsBfBwAdZIykPvQvXOfjX3n1qPIgxfJd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLhJ4vBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE893C2BBFC;
	Tue, 30 Apr 2024 11:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714476525;
	bh=+Wyt40nHXygASe1A/r/6/0sD5kuRWHrKMcELD2/oqis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vLhJ4vBhUdfxboLohJgV6grypvmnbPj67DnzPl4f7fs1O1elQtSxRCXtSMguqTNIa
	 R1j/aMKvrP3M/7FdMp4K2uu/4v7YlgVpN4j7Dxkr6Bw3BBGtReshTg55IYZohlqU43
	 SmMkl/WTAxc3amCNLjVCziihzUs5i4cNT6G+U5berh2F7MfsbzcpFOI//vpaJWjRhg
	 Tm/H7ptX84aBV4Jywrju/lX55WZ+vXh3ZkHYl8IhbVPHFqZrsJ2bdINZrnqytYTzFM
	 F2AWMJvKXplWM7UEaCn3OP5IulsDyhJVNTpXJMTDSM6ArB7GWNOyqqUxiMQl07OgBa
	 sib05nCuKTj0A==
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
	Viktor Malik <vmalik@redhat.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCHv2 bpf-next 1/7] bpf: Add support for kprobe session attach
Date: Tue, 30 Apr 2024 13:28:24 +0200
Message-ID: <20240430112830.1184228-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430112830.1184228-1-jolsa@kernel.org>
References: <20240430112830.1184228-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support to attach bpf program for entry and return probe
of the same function. This is common use case which at the moment
requires to create two kprobe multi links.

Adding new BPF_TRACE_KPROBE_SESSION attach type that instructs
kernel to attach single link program to both entry and exit probe.

It's possible to control execution of the bpf program on return
probe simply by returning zero or non zero from the entry bpf
program execution to execute or not the bpf program on return
probe respectively.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/syscall.c           |  7 ++++++-
 kernel/trace/bpf_trace.c       | 28 ++++++++++++++++++++--------
 tools/include/uapi/linux/bpf.h |  1 +
 4 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d94a72593ead..90706a47f6ff 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1115,6 +1115,7 @@ enum bpf_attach_type {
 	BPF_CGROUP_UNIX_GETSOCKNAME,
 	BPF_NETKIT_PRIMARY,
 	BPF_NETKIT_PEER,
+	BPF_TRACE_KPROBE_SESSION,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f655adf42e39..13ad74ecf2cd 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4016,11 +4016,15 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
 		if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI &&
 		    attach_type != BPF_TRACE_KPROBE_MULTI)
 			return -EINVAL;
+		if (prog->expected_attach_type == BPF_TRACE_KPROBE_SESSION &&
+		    attach_type != BPF_TRACE_KPROBE_SESSION)
+			return -EINVAL;
 		if (prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI &&
 		    attach_type != BPF_TRACE_UPROBE_MULTI)
 			return -EINVAL;
 		if (attach_type != BPF_PERF_EVENT &&
 		    attach_type != BPF_TRACE_KPROBE_MULTI &&
+		    attach_type != BPF_TRACE_KPROBE_SESSION &&
 		    attach_type != BPF_TRACE_UPROBE_MULTI)
 			return -EINVAL;
 		return 0;
@@ -5281,7 +5285,8 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 	case BPF_PROG_TYPE_KPROBE:
 		if (attr->link_create.attach_type == BPF_PERF_EVENT)
 			ret = bpf_perf_link_attach(attr, prog);
-		else if (attr->link_create.attach_type == BPF_TRACE_KPROBE_MULTI)
+		else if (attr->link_create.attach_type == BPF_TRACE_KPROBE_MULTI ||
+			 attr->link_create.attach_type == BPF_TRACE_KPROBE_SESSION)
 			ret = bpf_kprobe_multi_link_attach(attr, prog);
 		else if (attr->link_create.attach_type == BPF_TRACE_UPROBE_MULTI)
 			ret = bpf_uprobe_multi_link_attach(attr, prog);
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0ba722b57af3..06a9671834b6 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1631,6 +1631,17 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	}
 }
 
+static bool is_kprobe_multi(const struct bpf_prog *prog)
+{
+	return prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI ||
+	       prog->expected_attach_type == BPF_TRACE_KPROBE_SESSION;
+}
+
+static inline bool is_kprobe_session(const struct bpf_prog *prog)
+{
+	return prog->expected_attach_type == BPF_TRACE_KPROBE_SESSION;
+}
+
 static const struct bpf_func_proto *
 kprobe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -1646,13 +1657,13 @@ kprobe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_override_return_proto;
 #endif
 	case BPF_FUNC_get_func_ip:
-		if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI)
+		if (is_kprobe_multi(prog))
 			return &bpf_get_func_ip_proto_kprobe_multi;
 		if (prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI)
 			return &bpf_get_func_ip_proto_uprobe_multi;
 		return &bpf_get_func_ip_proto_kprobe;
 	case BPF_FUNC_get_attach_cookie:
-		if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI)
+		if (is_kprobe_multi(prog))
 			return &bpf_get_attach_cookie_proto_kmulti;
 		if (prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI)
 			return &bpf_get_attach_cookie_proto_umulti;
@@ -2834,10 +2845,11 @@ kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
 			  void *data)
 {
 	struct bpf_kprobe_multi_link *link;
+	int err;
 
 	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
-	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
-	return 0;
+	err = kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
+	return is_kprobe_session(link->link.prog) ? err : 0;
 }
 
 static void
@@ -2981,7 +2993,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	if (sizeof(u64) != sizeof(void *))
 		return -EOPNOTSUPP;
 
-	if (prog->expected_attach_type != BPF_TRACE_KPROBE_MULTI)
+	if (!is_kprobe_multi(prog))
 		return -EINVAL;
 
 	flags = attr->link_create.kprobe_multi.flags;
@@ -3062,10 +3074,10 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	if (err)
 		goto error;
 
-	if (flags & BPF_F_KPROBE_MULTI_RETURN)
-		link->fp.exit_handler = kprobe_multi_link_exit_handler;
-	else
+	if (!(flags & BPF_F_KPROBE_MULTI_RETURN))
 		link->fp.entry_handler = kprobe_multi_link_handler;
+	if ((flags & BPF_F_KPROBE_MULTI_RETURN) || is_kprobe_session(prog))
+		link->fp.exit_handler = kprobe_multi_link_exit_handler;
 
 	link->addrs = addrs;
 	link->cookies = cookies;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index d94a72593ead..90706a47f6ff 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1115,6 +1115,7 @@ enum bpf_attach_type {
 	BPF_CGROUP_UNIX_GETSOCKNAME,
 	BPF_NETKIT_PRIMARY,
 	BPF_NETKIT_PEER,
+	BPF_TRACE_KPROBE_SESSION,
 	__MAX_BPF_ATTACH_TYPE
 };
 
-- 
2.44.0


