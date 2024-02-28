Return-Path: <bpf+bounces-22850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1463386AAD4
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 10:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 400171C25D09
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 09:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9990D32189;
	Wed, 28 Feb 2024 09:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVDKyDT+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D65F2561B
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 09:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110980; cv=none; b=uYr8uyElc0wcdOnrox7sYgSUAZLmVPED1x/ntxtq5P/bij6L+E2PwXnMjulCBC/aMHNldKzR0ywjnC8fXsNbwPxdprx4zWE3nefFgC0BXr8QyzgoWirF61KQSzxG81nyUGYA3SNcReD7NkT2oEkcjcL2ilDjELxCxpy1UazBJ9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110980; c=relaxed/simple;
	bh=ugJhC1/AS7mf1O1Y1+e1uC4RUh5tRY/HN/xHPbfkmjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IbKfOFHUlDIViuwyjzsXSFZXwPkDaZXPu3etbQ7JipiAr/S0EIOXNe46OTB/OewgCkzvPp6yUl1ATveHcm3DbOK871ihctYtzHvvBz4sXXrV4xZAuYsCHYwaICGpsZjc5VxUuQN7NJYiCiIyYm2crV8Dpchbb8t3ACrZjYzi5KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVDKyDT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5325EC433C7;
	Wed, 28 Feb 2024 09:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709110979;
	bh=ugJhC1/AS7mf1O1Y1+e1uC4RUh5tRY/HN/xHPbfkmjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pVDKyDT+EFrxMLmVK7Jwa6xKBmmNsgsx+2no2OjXqBm/ua0uRmiSSolr1bfGkcakL
	 o+YiRlTK0Q9JrqZFo4rjeQy6RQCUqjdxAuBClytO3PXXtZdsdW70ACKLHeG+dqmg2x
	 zBa9sOkDDfOhMX65a+hWjQoTRnkFRnVQMe5pRM/V3BHKG9iMzYuf7+wZIbarlddetU
	 l68k2OwV6P7Ez67tEPm4KEwZxia8TVmS/duqRT9WdMZi1SpLtFgJ0ph9mMmnwlZAQC
	 JwzD2/a722uPXebk7uDQRHty+rBBT7f3yWt/I8Jdr+2qHbH+NHCoqqEP9eQ47X9cYH
	 JSJteypnYqxeA==
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
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH RFCv2 bpf-next 1/4] bpf: Add support for kprobe multi wrapper attach
Date: Wed, 28 Feb 2024 10:02:39 +0100
Message-ID: <20240228090242.4040210-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228090242.4040210-1-jolsa@kernel.org>
References: <20240228090242.4040210-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support to attach bpf program for entry and return probe
of the same function. This is common usecase and at the moment
it requires to create two kprobe multi links.

Adding new attr.link_create.kprobe_multi.flags value that instructs
kernel to attach link program to both entry and exit probe.

It's possible to control execution of the bpf program on return
probe simply by returning zero or non zero from the entry bpf
program execution to execute or not respectively the bpf program
on return probe.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/bpf.h       |  3 ++-
 kernel/trace/bpf_trace.c       | 24 ++++++++++++++++++------
 tools/include/uapi/linux/bpf.h |  3 ++-
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d2e6c5fcec01..a430855c5bcd 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1247,7 +1247,8 @@ enum bpf_perf_event_type {
  * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
  */
 enum {
-	BPF_F_KPROBE_MULTI_RETURN = (1U << 0)
+	BPF_F_KPROBE_MULTI_RETURN  = (1U << 0),
+	BPF_F_KPROBE_MULTI_WRAPPER = (1U << 1),
 };
 
 /* link_create.uprobe_multi.flags used in LINK_CREATE command for
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 241ddf5e3895..726a8c71f0da 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2587,6 +2587,7 @@ struct bpf_kprobe_multi_link {
 	u32 mods_cnt;
 	struct module **mods;
 	u32 flags;
+	bool is_wrapper;
 };
 
 struct bpf_kprobe_multi_run_ctx {
@@ -2826,10 +2827,11 @@ kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
 			  void *data)
 {
 	struct bpf_kprobe_multi_link *link;
+	int err;
 
 	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
-	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
-	return 0;
+	err = kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
+	return link->is_wrapper ? err : 0;
 }
 
 static void
@@ -2967,6 +2969,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	void __user *uaddrs;
 	u64 *cookies = NULL;
 	void __user *usyms;
+	bool is_wrapper;
 	int err;
 
 	/* no support for 32bit archs yet */
@@ -2977,9 +2980,12 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 		return -EINVAL;
 
 	flags = attr->link_create.kprobe_multi.flags;
-	if (flags & ~BPF_F_KPROBE_MULTI_RETURN)
+	if (flags & ~(BPF_F_KPROBE_MULTI_RETURN|
+		      BPF_F_KPROBE_MULTI_WRAPPER))
 		return -EINVAL;
 
+	is_wrapper = flags & BPF_F_KPROBE_MULTI_WRAPPER;
+
 	uaddrs = u64_to_user_ptr(attr->link_create.kprobe_multi.addrs);
 	usyms = u64_to_user_ptr(attr->link_create.kprobe_multi.syms);
 	if (!!uaddrs == !!usyms)
@@ -3054,15 +3060,21 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	if (err)
 		goto error;
 
-	if (flags & BPF_F_KPROBE_MULTI_RETURN)
-		link->fp.exit_handler = kprobe_multi_link_exit_handler;
-	else
+	if (is_wrapper) {
 		link->fp.entry_handler = kprobe_multi_link_handler;
+		link->fp.exit_handler = kprobe_multi_link_exit_handler;
+	} else {
+		if (flags & BPF_F_KPROBE_MULTI_RETURN)
+			link->fp.exit_handler = kprobe_multi_link_exit_handler;
+		else
+			link->fp.entry_handler = kprobe_multi_link_handler;
+	}
 
 	link->addrs = addrs;
 	link->cookies = cookies;
 	link->cnt = cnt;
 	link->flags = flags;
+	link->is_wrapper = is_wrapper;
 
 	if (cookies) {
 		/*
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index d2e6c5fcec01..a430855c5bcd 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1247,7 +1247,8 @@ enum bpf_perf_event_type {
  * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
  */
 enum {
-	BPF_F_KPROBE_MULTI_RETURN = (1U << 0)
+	BPF_F_KPROBE_MULTI_RETURN  = (1U << 0),
+	BPF_F_KPROBE_MULTI_WRAPPER = (1U << 1),
 };
 
 /* link_create.uprobe_multi.flags used in LINK_CREATE command for
-- 
2.43.2


