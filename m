Return-Path: <bpf+bounces-64522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0378B13D14
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 16:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10FF3166179
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 14:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E271C26F443;
	Mon, 28 Jul 2025 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DbRr27rA"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CEB26E717
	for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753712690; cv=none; b=DO3o1WBFPrNTI7gvHDQt2+U6ylauUdU9JISqXmUW+V6G4JgSd+k6n1jD/JTkeAc60bsfzcNRB/PRwdFjVzynQxx1H+/s1eGTjtsMO7Sk/KJoHWHlmvNlg8Uu/jRGt8wQ65p9GJCviYbbeIX65EIN6LdrDq9PJutYcHGKL7luJ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753712690; c=relaxed/simple;
	bh=cEWf9MxitnKSFfehldLkfK67Vcgi+E2QFGvhDdE5MR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RW18QJrql5e44KiLMfvPmQsyCmlW2aBbX9DBHi24ChfYBMfneQnY+jiBRHP/KZvwbfsuwLHhucW3QqTZt3XyZ8ZWUnmNB2i4fkxZXHZtH/h0dZ5HkJ8ctdL0Nrrm6e8qFAjdZG5HyBllvMShxuUkl3DAG4BhKUsbwo6QnwXQR04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DbRr27rA; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753712686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9rydG5nhmRJLCjB0+AvfYAEc1UpG4+ETvpV0BzQLu6w=;
	b=DbRr27rApBOGDIeSLIggQF3Jvy4Qej2JwW4nVNYhlUVxAgh15Y33h8/afTVCHuFdzqP90T
	uG82twVZjbBAkzsFAwsdciIToYUvkebjIIT407CX3TwgSyDPeGWI9YVBiM+ngapvYS9s1e
	xyEjO48n9UiRVSSDIKmtonxdRCuQCPw=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	menglong8.dong@gmail.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf-next 4/5] libbpf: Capture error message on freplace attach failure
Date: Mon, 28 Jul 2025 22:23:45 +0800
Message-ID: <20250728142346.95681-5-leon.hwang@linux.dev>
In-Reply-To: <20250728142346.95681-1-leon.hwang@linux.dev>
References: <20250728142346.95681-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Extend 'bpf_link_create()' to support capturing log output from the kernel
when creating a freplace link.

Additionally, introduce a new API, 'bpf_program__attach_freplace_log()',
to allow users to retrieve detailed error message when a freplace program
fails to attach.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/bpf.c      | 14 ++++++++++++--
 tools/lib/bpf/bpf.h      |  2 ++
 tools/lib/bpf/libbpf.c   | 18 ++++++++++++++----
 tools/lib/bpf/libbpf.h   |  4 ++++
 tools/lib/bpf/libbpf.map |  1 +
 5 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index de0c5c6c8ae6..25e88219d140 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -772,6 +772,7 @@ int bpf_link_create(int prog_fd, int target_fd,
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, link_create);
 	__u32 target_btf_id, iter_info_len, relative_id;
+	struct bpf_common_attr common_attrs;
 	int fd, err, relative_fd;
 	union bpf_attr attr;
 
@@ -785,7 +786,9 @@ int bpf_link_create(int prog_fd, int target_fd,
 	if (iter_info_len || target_btf_id) {
 		if (iter_info_len && target_btf_id)
 			return libbpf_err(-EINVAL);
-		if (!OPTS_ZEROED(opts, target_btf_id))
+		if (iter_info_len && !OPTS_ZEROED(opts, target_btf_id))
+			return libbpf_err(-EINVAL);
+		if (target_btf_id && !OPTS_ZEROED(opts, tracing.log_size))
 			return libbpf_err(-EINVAL);
 	}
 
@@ -795,7 +798,12 @@ int bpf_link_create(int prog_fd, int target_fd,
 	attr.link_create.attach_type = attach_type;
 	attr.link_create.flags = OPTS_GET(opts, flags, 0);
 
+	memset(&common_attrs, 0, sizeof(common_attrs));
 	if (target_btf_id) {
+		common_attrs.log_buf = (__u64) OPTS_GET(opts, tracing.log_buf, NULL);
+		common_attrs.log_size = OPTS_GET(opts, tracing.log_size, 0);
+		if (common_attrs.log_buf && !feat_supported(NULL, FEAT_EXTENDED_SYSCALL))
+			return libbpf_err(-EOPNOTSUPP);
 		attr.link_create.target_btf_id = target_btf_id;
 		goto proceed;
 	}
@@ -931,7 +939,9 @@ int bpf_link_create(int prog_fd, int target_fd,
 		break;
 	}
 proceed:
-	fd = sys_bpf_fd(BPF_LINK_CREATE, &attr, attr_sz);
+	fd = !common_attrs.log_buf ? sys_bpf_fd(BPF_LINK_CREATE, &attr, attr_sz)
+				   : sys_bpf_fd_extended(BPF_LINK_CREATE, &attr, attr_sz,
+							 &common_attrs, sizeof(common_attrs));
 	if (fd >= 0)
 		return fd;
 	/* we'll get EINVAL if LINK_CREATE doesn't support attaching fentry
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 38819071ecbe..5720d3e3df76 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -422,6 +422,8 @@ struct bpf_link_create_opts {
 		} uprobe_multi;
 		struct {
 			__u64 cookie;
+			const char *log_buf;
+			unsigned int log_size;
 		} tracing;
 		struct {
 			__u32 pf;
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e067cb5776bd..9748466691f3 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -12949,9 +12949,11 @@ bpf_program__attach_netkit(const struct bpf_program *prog, int ifindex,
 	return bpf_program_attach_fd(prog, ifindex, "netkit", &link_create_opts);
 }
 
-struct bpf_link *bpf_program__attach_freplace(const struct bpf_program *prog,
-					      int target_fd,
-					      const char *attach_func_name)
+struct bpf_link *bpf_program__attach_freplace_log(const struct bpf_program *prog,
+						  int target_fd,
+						  const char *attach_func_name,
+						  const char *log_buf,
+						  unsigned int log_size)
 {
 	int btf_id;
 
@@ -12975,7 +12977,8 @@ struct bpf_link *bpf_program__attach_freplace(const struct bpf_program *prog,
 			return libbpf_err_ptr(btf_id);
 
 		target_opts.target_btf_id = btf_id;
-
+		target_opts.tracing.log_buf = log_buf;
+		target_opts.tracing.log_size = log_size;
 		return bpf_program_attach_fd(prog, target_fd, "freplace",
 					     &target_opts);
 	} else {
@@ -12986,6 +12989,13 @@ struct bpf_link *bpf_program__attach_freplace(const struct bpf_program *prog,
 	}
 }
 
+struct bpf_link *bpf_program__attach_freplace(const struct bpf_program *prog,
+					      int target_fd,
+					      const char *attach_func_name)
+{
+	return bpf_program__attach_freplace_log(prog, target_fd, attach_func_name, NULL, 0);
+}
+
 struct bpf_link *
 bpf_program__attach_iter(const struct bpf_program *prog,
 			 const struct bpf_iter_attach_opts *opts)
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index d1cf813a057b..01a0bf76adf5 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -829,6 +829,10 @@ bpf_program__attach_sockmap(const struct bpf_program *prog, int map_fd);
 LIBBPF_API struct bpf_link *
 bpf_program__attach_xdp(const struct bpf_program *prog, int ifindex);
 LIBBPF_API struct bpf_link *
+bpf_program__attach_freplace_log(const struct bpf_program *prog,
+				 int target_fd, const char *attach_func_name,
+				 const char *log_buf, unsigned int log_size);
+LIBBPF_API struct bpf_link *
 bpf_program__attach_freplace(const struct bpf_program *prog,
 			     int target_fd, const char *attach_func_name);
 
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 83d3d1af5ed1..25cd2d54b7d9 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -449,5 +449,6 @@ LIBBPF_1.6.0 {
 
 LIBBPF_1.7.0 {
 	global:
+		bpf_program__attach_freplace_log;
 		probe_sys_bpf_extended;
 } LIBBPF_1.6.0;
-- 
2.50.1


