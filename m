Return-Path: <bpf+bounces-52377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25222A42671
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 16:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15BA516153B
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 15:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F06023BCE1;
	Mon, 24 Feb 2025 15:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GN/y/Fdu"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2BA191484
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411295; cv=none; b=JqNYxf8Vum/Du4M2q2tfcCPxM/2WrqxemTsVRaIplkE0wZr6DG1TdMh/Jk39yFw5wegPil2yQpgXnsftGVjJWpgpm2PJ9r8PzIkFMocB6/UvHmW6TKTEIbGBluMXxPkJt17VpzbcsSXEqw9hyFSJKi34NPTk1tAXSztmx6zYzbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411295; c=relaxed/simple;
	bh=fO9FKDyQsGIpCW2ukJsHabWhQKIz1LgxYbqwqzd643w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGoM2XoDD8NYASM81QCN8fj8KScs2UvaIGN6cRO+xMVFmOt4Xhvxa3o8ZfJvlvZ+kFsSEcv3WpNYy3ZUUE+HgLdOqqyXgQDJ63NUNQZ3B23EaGDGqd8STAWPrQOKp2X7At+h3LYUsxDkGLtC5L7wt+15jbQviW/s/NKQxPfKbbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GN/y/Fdu; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740411291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+8fcTgD5LO6+bcE+SbfGH4RpabVsyxmBruYFLbBTnUk=;
	b=GN/y/FduqAgF5kkAKeiF7jjLC/Uox3Xladuuoak3Uy+wu4fiPO5LFpG+VfgIfswG7HtK1T
	F6XB+j+db3an3fJI+wSLK8KQy+DHmVDrxgihapRQ0IGdXb53B+PQiUUFL1VgBMvPW8RnG0
	AfE5JZQKhdCWsFxvCYQ/C660ELRxexk=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	me@manjusaka.me,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v4 3/4] bpf, libbpf: Capture error message of freplace attachment failure
Date: Mon, 24 Feb 2025 23:33:51 +0800
Message-ID: <20250224153352.64689-4-leon.hwang@linux.dev>
In-Reply-To: <20250224153352.64689-1-leon.hwang@linux.dev>
References: <20250224153352.64689-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

To improve debugging, this patch captures the log of
bpf_check_attach_target() when a freplace program fails to attach. Users
can supply a buffer to receive the log.

Changes:

* Extended bpf_attr and bpf_link_create_opts to include a log buffer for
  tracing.
* Updated bpf_link_create() to handle log buffer properly.
* Add bpf_program__attach_freplace_opts() to use users' supplied log
  buffer.

This helps diagnose freplace attachment failures more efficiently.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/include/uapi/linux/bpf.h |  2 ++
 tools/lib/bpf/bpf.c            |  6 +++++-
 tools/lib/bpf/bpf.h            |  2 ++
 tools/lib/bpf/libbpf.c         | 29 +++++++++++++++++++++++++----
 tools/lib/bpf/libbpf.h         | 14 ++++++++++++++
 tools/lib/bpf/libbpf.map       |  1 +
 6 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index fff6cdb8d11a2..bea4d802d4463 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1759,6 +1759,8 @@ union bpf_attr {
 				 * accessible through bpf_get_attach_cookie() BPF helper
 				 */
 				__u64		cookie;
+				__aligned_u64	log_buf;	/* user supplied buffer */
+				__u32		log_size;	/* size of user buffer */
 			} tracing;
 			struct {
 				__u32		pf;
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 359f73ead6137..cd422ecd53ae2 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -741,7 +741,7 @@ int bpf_link_create(int prog_fd, int target_fd,
 	if (iter_info_len || target_btf_id) {
 		if (iter_info_len && target_btf_id)
 			return libbpf_err(-EINVAL);
-		if (!OPTS_ZEROED(opts, target_btf_id))
+		if (!OPTS_ZEROED(opts, tracing))
 			return libbpf_err(-EINVAL);
 	}
 
@@ -753,6 +753,8 @@ int bpf_link_create(int prog_fd, int target_fd,
 
 	if (target_btf_id) {
 		attr.link_create.target_btf_id = target_btf_id;
+		attr.link_create.tracing.log_buf = ptr_to_u64(OPTS_GET(opts, tracing.log_buf, 0));
+		attr.link_create.tracing.log_size = OPTS_GET(opts, tracing.log_size, 0);
 		goto proceed;
 	}
 
@@ -794,6 +796,8 @@ int bpf_link_create(int prog_fd, int target_fd,
 	case BPF_MODIFY_RETURN:
 	case BPF_LSM_MAC:
 		attr.link_create.tracing.cookie = OPTS_GET(opts, tracing.cookie, 0);
+		attr.link_create.tracing.log_buf = 0;
+		attr.link_create.tracing.log_size = 0;
 		if (!OPTS_ZEROED(opts, tracing))
 			return libbpf_err(-EINVAL);
 		break;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 435da95d20589..c76222617c18c 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -421,6 +421,8 @@ struct bpf_link_create_opts {
 		} uprobe_multi;
 		struct {
 			__u64 cookie;
+			const char *log_buf;
+			size_t log_size;
 		} tracing;
 		struct {
 			__u32 pf;
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6df258912e1ec..f0c42669ec1e1 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -12837,10 +12837,11 @@ bpf_program__attach_netkit(const struct bpf_program *prog, int ifindex,
 	return bpf_program_attach_fd(prog, ifindex, "netkit", &link_create_opts);
 }
 
-struct bpf_link *bpf_program__attach_freplace(const struct bpf_program *prog,
-					      int target_fd,
-					      const char *attach_func_name)
+static struct bpf_link *bpf_program_attach_freplace(const struct bpf_freplace_opts *opts)
 {
+	const char *attach_func_name = opts->attach_func_name;
+	const struct bpf_program *prog = opts->prog;
+	int target_fd = opts->target_prog_fd;
 	int btf_id;
 
 	if (!!target_fd != !!attach_func_name) {
@@ -12863,7 +12864,8 @@ struct bpf_link *bpf_program__attach_freplace(const struct bpf_program *prog,
 			return libbpf_err_ptr(btf_id);
 
 		target_opts.target_btf_id = btf_id;
-
+		target_opts.tracing.log_buf = opts->log_buf;
+		target_opts.tracing.log_size = opts->log_buf_size;
 		return bpf_program_attach_fd(prog, target_fd, "freplace",
 					     &target_opts);
 	} else {
@@ -12874,6 +12876,25 @@ struct bpf_link *bpf_program__attach_freplace(const struct bpf_program *prog,
 	}
 }
 
+struct bpf_link *bpf_program__attach_freplace(const struct bpf_program *prog,
+					      int target_fd,
+					      const char *attach_func_name)
+{
+	LIBBPF_OPTS(bpf_freplace_opts, opts,
+		    .prog = prog,
+		    .target_prog_fd = target_fd,
+		    .attach_func_name = attach_func_name,
+	);
+
+	return bpf_program_attach_freplace(&opts);
+}
+
+struct bpf_link *
+bpf_program__attach_freplace_opts(const struct bpf_freplace_opts *opts)
+{
+	return bpf_program_attach_freplace(opts);
+}
+
 struct bpf_link *
 bpf_program__attach_iter(const struct bpf_program *prog,
 			 const struct bpf_iter_attach_opts *opts)
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 3020ee45303a0..8de595da7e7d7 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -819,6 +819,20 @@ LIBBPF_API struct bpf_link *
 bpf_program__attach_freplace(const struct bpf_program *prog,
 			     int target_fd, const char *attach_func_name);
 
+struct bpf_freplace_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+
+	/* freplace bpf prog */
+	const struct bpf_program *prog;
+	int target_prog_fd;
+	const char *attach_func_name;
+	/* buffer to receive error message when fail to bpf_check_attach_target */
+	const char *log_buf;
+	size_t log_buf_size;
+};
+LIBBPF_API struct bpf_link *
+bpf_program__attach_freplace_opts(const struct bpf_freplace_opts *opts);
+
 struct bpf_netfilter_opts {
 	/* size of this struct, for forward/backward compatibility */
 	size_t sz;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index b5a838de6f47c..5088f8af51dd6 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -438,4 +438,5 @@ LIBBPF_1.6.0 {
 		bpf_linker__new_fd;
 		btf__add_decl_attr;
 		btf__add_type_attr;
+		bpf_program__attach_freplace_opts;
 } LIBBPF_1.5.0;
-- 
2.47.1


