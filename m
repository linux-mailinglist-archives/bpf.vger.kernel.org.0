Return-Path: <bpf+bounces-70208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1C9BB4663
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 17:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C6A3265B0
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 15:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F96235360;
	Thu,  2 Oct 2025 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GlU+UQrH"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10EF23183F
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759420183; cv=none; b=Dsy6f2pTMCSdLXn1rMG1nlIP2ms/QnOkJDcf7g6xXnvP5hY1ViMYbwD6Jk7sqClOLX+ogJ6H+YjikZ7gMdhjIdbB38hSrATkJk3BLx7aSUhMd4fyXhh38bkvX6KD5LK2hio2IQRYEMSvoc+ZVxDFecLwiWcvRFmwdMHBPlJ/vtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759420183; c=relaxed/simple;
	bh=oRP3QFJYy13SVfpZhAfq6oi5AqGQXMfxSOdFdndVE/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DpysmhNgIL773sWCxZXJYexx0X3t0nwnVpIK0hQWz3neTzRQbQ6VnhguYyvq6nomNVMbvYMPPHc3kz23ozk+K2G3SN9vAXIdh9mVBezukRmsIIU0yquJBLNsdl5WRaq2YFwP6q8lS4aukgnLlgJBCtrbMA7X+L+TWLPae0sQyBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GlU+UQrH; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759420180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VEJFDTofsHchVZSsBL0H/IUQPIZQ3zi+Yyf4Hpzizn8=;
	b=GlU+UQrHqScZVDgEvl2SyqsCLuyOX/wq+F3YdvLhD2Gbo+OswUBphqUp88rfv1RcoGt2xG
	OAWrhfJ6x3PZTSKGBOaWsSKtlW5yZHHHw60ReqW09EbND2uZoQVJWksEYySXZ4RNjXIuH7
	WM67MhFU4eom5DLvLwzNoFfKQ0qEXMM=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf-next v3 09/10] libbpf: Add common attr support for map_create
Date: Thu,  2 Oct 2025 23:48:40 +0800
Message-ID: <20251002154841.99348-10-leon.hwang@linux.dev>
In-Reply-To: <20251002154841.99348-1-leon.hwang@linux.dev>
References: <20251002154841.99348-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

With the previous commit adding common attribute support for
BPF_MAP_CREATE, it is now possible to retrieve detailed error messages
when map creation fails by using the 'log_buf' field from the common
attributes.

Extend 'bpf_map_create_opts' with these new fields, 'log_buf', 'log_size'
, 'log_level' and 'log_true_size', allowing users to capture and inspect
those log messages.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/bpf.c | 17 +++++++++++++++--
 tools/lib/bpf/bpf.h |  9 +++++++--
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 9cd79beb13a2d..ca66fcdb3f49f 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -203,10 +203,13 @@ int bpf_map_create(enum bpf_map_type map_type,
 		   __u32 key_size,
 		   __u32 value_size,
 		   __u32 max_entries,
-		   const struct bpf_map_create_opts *opts)
+		   struct bpf_map_create_opts *opts)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, excl_prog_hash_size);
+	const size_t common_attrs_sz = sizeof(struct bpf_common_attr);
+	struct bpf_common_attr common_attrs;
 	union bpf_attr attr;
+	const char *log_buf;
 	int fd;
 
 	bump_rlimit_memlock();
@@ -239,7 +242,17 @@ int bpf_map_create(enum bpf_map_type map_type,
 	attr.excl_prog_hash = ptr_to_u64(OPTS_GET(opts, excl_prog_hash, NULL));
 	attr.excl_prog_hash_size = OPTS_GET(opts, excl_prog_hash_size, 0);
 
-	fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
+	log_buf = OPTS_GET(opts, log_buf, NULL);
+	if (log_buf && feat_supported(NULL, FEAT_EXTENDED_SYSCALL)) {
+		memset(&common_attrs, 0, common_attrs_sz);
+		common_attrs.log_buf = ptr_to_u64(log_buf);
+		common_attrs.log_size = OPTS_GET(opts, log_size, 0);
+		common_attrs.log_level = OPTS_GET(opts, log_level, 0);
+		fd = sys_bpf_ext_fd(BPF_MAP_CREATE, &attr, attr_sz, &common_attrs, common_attrs_sz);
+		OPTS_SET(opts, log_true_size, common_attrs.log_true_size);
+	} else {
+		fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
+	}
 	return libbpf_err_errno(fd);
 }
 
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index e983a3e40d612..77d475e7274a0 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -57,16 +57,21 @@ struct bpf_map_create_opts {
 
 	const void *excl_prog_hash;
 	__u32 excl_prog_hash_size;
+
+	const char *log_buf;
+	__u32 log_size;
+	__u32 log_level;
+	__u32 log_true_size;
 	size_t :0;
 };
-#define bpf_map_create_opts__last_field excl_prog_hash_size
+#define bpf_map_create_opts__last_field log_true_size
 
 LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
 			      const char *map_name,
 			      __u32 key_size,
 			      __u32 value_size,
 			      __u32 max_entries,
-			      const struct bpf_map_create_opts *opts);
+			      struct bpf_map_create_opts *opts);
 
 struct bpf_prog_load_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
-- 
2.51.0


