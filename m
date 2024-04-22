Return-Path: <bpf+bounces-27403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2C58ACC98
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 14:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3085A1C22AB0
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 12:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806261474A0;
	Mon, 22 Apr 2024 12:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHFtgBDv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC55146A77
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 12:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713787978; cv=none; b=eQElVP0SNhrYe8bYQSJCCgqFFcwRBzCl0JiUldIAE7iWNNVSsozcQq61sZwN3MGY1X9HCt0QRH1Mjr+dPC/hFqLHQWm4l32z2HNNSx4VcJFTxtrnKq0ikuzzvO8azHxy09axh+8ZcZ35EHGuHy2pJ/rkk7eRtrblBjErbH9c79w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713787978; c=relaxed/simple;
	bh=wnkKXr6zmUT5MphzZJyIk64Fw+8h5OVX6OVpwcSEEzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8PV344V23Llh9RJ7gC1ctV7fnwc3hX9pxKTeuSokMcc6RwCe4suQwZ8qtVKf5OPCZ/o+M99vzpYObM4A/kjWyUbwOD56zpDsuUGd3Ru0fAOVxFiIoKtcC1sBNb5aZfcCi7icgwg13K/iHCZ6ZXmaDPkIIldV48cb36jXCWTrDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHFtgBDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55AAAC113CC;
	Mon, 22 Apr 2024 12:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713787977;
	bh=wnkKXr6zmUT5MphzZJyIk64Fw+8h5OVX6OVpwcSEEzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sHFtgBDvdw4g/9ouoxMgO0EFAIwcoE9u4/Gs3xQCUfNSxFY7djDLzWIVZIXQeYsD8
	 D018V0CTrIgy/XR2vRcum4JIGHJlpZSVhlW0nqAh3abdtoZfVYUK0m1G1MXfOGTGy0
	 L8YNZRePEpyB3c+0nD+oZCXJMdABmbKcoULNHb160LFL/envFnRUtZXr8AIgrDiStD
	 DH7uspqKrRmcCPk5GLmFSTQ4YZnzABHAtzPfe8gL66pY3mLnLhgX1zHPMVKFMngd8n
	 jWRGQWSH78hEgKEA0uFfX5+FsagdJxst/k9HwBkfjKPqz3+zA4SwYJGcNnZrM+jG4g
	 treYh2wmss8Kw==
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
Subject: [PATCH bpf-next 1/7] bpf: Add support for kprobe multi session attach
Date: Mon, 22 Apr 2024 14:12:35 +0200
Message-ID: <20240422121241.1307168-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422121241.1307168-1-jolsa@kernel.org>
References: <20240422121241.1307168-1-jolsa@kernel.org>
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

Adding new BPF_TRACE_KPROBE_MULTI_SESSION attach type that instructs
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
index cee0a7915c08..fb8ecb199273 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1115,6 +1115,7 @@ enum bpf_attach_type {
 	BPF_CGROUP_UNIX_GETSOCKNAME,
 	BPF_NETKIT_PRIMARY,
 	BPF_NETKIT_PEER,
+	BPF_TRACE_KPROBE_MULTI_SESSION,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7d392ec83655..7c0cb1800b9f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3974,11 +3974,15 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
 		if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI &&
 		    attach_type != BPF_TRACE_KPROBE_MULTI)
 			return -EINVAL;
+		if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI_SESSION &&
+		    attach_type != BPF_TRACE_KPROBE_MULTI_SESSION)
+			return -EINVAL;
 		if (prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI &&
 		    attach_type != BPF_TRACE_UPROBE_MULTI)
 			return -EINVAL;
 		if (attach_type != BPF_PERF_EVENT &&
 		    attach_type != BPF_TRACE_KPROBE_MULTI &&
+		    attach_type != BPF_TRACE_KPROBE_MULTI_SESSION &&
 		    attach_type != BPF_TRACE_UPROBE_MULTI)
 			return -EINVAL;
 		return 0;
@@ -5239,7 +5243,8 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 	case BPF_PROG_TYPE_KPROBE:
 		if (attr->link_create.attach_type == BPF_PERF_EVENT)
 			ret = bpf_perf_link_attach(attr, prog);
-		else if (attr->link_create.attach_type == BPF_TRACE_KPROBE_MULTI)
+		else if (attr->link_create.attach_type == BPF_TRACE_KPROBE_MULTI ||
+			 attr->link_create.attach_type == BPF_TRACE_KPROBE_MULTI_SESSION)
 			ret = bpf_kprobe_multi_link_attach(attr, prog);
 		else if (attr->link_create.attach_type == BPF_TRACE_UPROBE_MULTI)
 			ret = bpf_uprobe_multi_link_attach(attr, prog);
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index afb232b1d7c2..3b15a40f425f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1631,6 +1631,17 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	}
 }
 
+static bool is_kprobe_multi(const struct bpf_prog *prog)
+{
+	return prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI ||
+	       prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI_SESSION;
+}
+
+static inline bool is_kprobe_multi_session(const struct bpf_prog *prog)
+{
+	return prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI_SESSION;
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
+	return is_kprobe_multi_session(link->link.prog) ? err : 0;
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
+	if ((flags & BPF_F_KPROBE_MULTI_RETURN) || is_kprobe_multi_session(prog))
+		link->fp.exit_handler = kprobe_multi_link_exit_handler;
 
 	link->addrs = addrs;
 	link->cookies = cookies;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index cee0a7915c08..fb8ecb199273 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1115,6 +1115,7 @@ enum bpf_attach_type {
 	BPF_CGROUP_UNIX_GETSOCKNAME,
 	BPF_NETKIT_PRIMARY,
 	BPF_NETKIT_PEER,
+	BPF_TRACE_KPROBE_MULTI_SESSION,
 	__MAX_BPF_ATTACH_TYPE
 };
 
-- 
2.44.0


