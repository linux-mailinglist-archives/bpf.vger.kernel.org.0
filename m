Return-Path: <bpf+bounces-51753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1078A387FE
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 16:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20D31888A5E
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 15:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB85E224AFF;
	Mon, 17 Feb 2025 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VQuAYFEo"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79676224B08
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807053; cv=none; b=IyluxK1za6jOHPY6Nj+T4mYyVowmRfroG2Tgq+mZp31OsAt4JkouiVP6imTeF8fo2WTnMEp03E0GnJE7wNcYieii2rghs40sQrFwn0kbwyXPPRzi6JtjaraeL+EClZQWFReZoBTEF+LCXcO1kMRGaf3QSFXPZUm2WLjWbcZDnkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807053; c=relaxed/simple;
	bh=+9vyifcyKnWj7zJQGtZ9E308W2V7srbmv7S33eL0qbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgmR+V6YegbKOodsyyVAErXY/dZh97Wim0ACoD421NDM3hAFBHm4IiQAN3Bv8rIyhTMixEbGxC9e7RyrcDVYqOTOf09EaBzl8LNfx51JVThjHSq1rSAWNJDf8pB3kKw970r9E5gEOMIF9C6DH31VMY7nmvOv6mSloQB3lq2+yDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VQuAYFEo; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739807049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tG7RecffuK2oeRDwfGIrChaIKCunFziEYWQ9ZvWV92g=;
	b=VQuAYFEoxChKLY9iKWuuGm5KLoSKr7lBV4ApkCWio8tKUYCkzY4KVLOl0N0/hIIMF1YBJ9
	3KhrDXFqzBZfao30Xp0nObiHCNHK8vg5amssFOPDmHj73UZ4yw26YKDEvjpRLUK1LguReq
	MRuT6JlYTV02pfeIoifkymHaBvHKGgY=
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
Subject: [PATCH bpf-next v3 3/4] bpf, libbpf: Capture and log freplace attachment failure
Date: Mon, 17 Feb 2025 23:43:17 +0800
Message-ID: <20250217154318.76145-4-leon.hwang@linux.dev>
In-Reply-To: <20250217154318.76145-1-leon.hwang@linux.dev>
References: <20250217154318.76145-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

To improve debugging, this patch captures logs when a freplace program
fails to attach. It provides a buffer to store the log and prints it using
pr_warn, making failure reasons more visible.

Changes:

* Extended bpf_attr and bpf_link_create_opts to include a log buffer for
  tracing.
* Updated bpf_link_create() to handle log buffer properly.
* Modified bpf_program__attach_freplace() to store and print attachment
  failure log.

Example output:

prog 'new_test_pkt_access': attach log: subprog_tail() is not a global function

This helps diagnose freplace attachment failures more efficiently.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/include/uapi/linux/bpf.h |  2 ++
 tools/lib/bpf/bpf.c            |  6 +++++-
 tools/lib/bpf/bpf.h            |  2 ++
 tools/lib/bpf/libbpf.c         | 14 ++++++++++++--
 4 files changed, 21 insertions(+), 3 deletions(-)

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
index 435da95d20589..daf62f1bda80f 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -421,6 +421,8 @@ struct bpf_link_create_opts {
 		} uprobe_multi;
 		struct {
 			__u64 cookie;
+			const char *log_buf;
+			__u32 log_size;
 		} tracing;
 		struct {
 			__u32 pf;
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 194809da51725..f9266bd0ff709 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -12841,6 +12841,8 @@ struct bpf_link *bpf_program__attach_freplace(const struct bpf_program *prog,
 					      int target_fd,
 					      const char *attach_func_name)
 {
+	struct bpf_link *link;
+	char log_buf[64];
 	int btf_id;
 
 	if (!!target_fd != !!attach_func_name) {
@@ -12862,10 +12864,18 @@ struct bpf_link *bpf_program__attach_freplace(const struct bpf_program *prog,
 		if (btf_id < 0)
 			return libbpf_err_ptr(btf_id);
 
+		log_buf[0] = '\0';
 		target_opts.target_btf_id = btf_id;
-
-		return bpf_program_attach_fd(prog, target_fd, "freplace",
+		target_opts.tracing.log_buf = log_buf;
+		target_opts.tracing.log_size = sizeof(log_buf);
+		link = bpf_program_attach_fd(prog, target_fd, "freplace",
 					     &target_opts);
+		if (libbpf_get_error(link) && log_buf[0] != '\0') {
+			log_buf[sizeof(log_buf)-1] = '\0';
+			log_buf[sizeof(log_buf)-2] = '\n';
+			pr_warn("prog '%s': attach log: %s", prog->name, log_buf);
+		}
+		return link;
 	} else {
 		/* no target, so use raw_tracepoint_open for compatibility
 		 * with old kernels
-- 
2.47.1


