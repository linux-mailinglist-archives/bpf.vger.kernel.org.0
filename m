Return-Path: <bpf+bounces-68168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01624B53963
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 18:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABEA33A2C9B
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 16:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8EA35A2AC;
	Thu, 11 Sep 2025 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ch6o1Js/"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751F334F46A
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757608439; cv=none; b=UN6wTlGcbito+vFsyJemjkqb16K4aJED40YELQFaf+8B3DgiVAICe78Xr22iXPXcLbX5xz+Rh4pBhWKe7ebwzdVrtuT/Im7a2n9e9xhyunBv731HTlocv4nyAJdr6oohmT+h07+g3ucO7xytgNgCY5/UgiYEDy+87Kwyeiryvt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757608439; c=relaxed/simple;
	bh=npuF6CMRcAzRo9pwJk3T17V95AM1edFEyAdIP0/LOHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uy7WsY3LtOkxMecctlRGcsEDDq2J5sOt/FvZevcXITLK2j4b37sAxdHrmq/C75q7q3xKqbTVHcbzSuFWOo+SFOVeODeIvJh+DBPo58Drgoe7jAVTAoXbCxF+D756L88ASn7ciWy5oCyYY9Yj/PB9MdGVhtf3G4omXAG4inFlu0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ch6o1Js/; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757608433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sF8CRgfRaF3or8sBGOPMP2KgsQ9SMAQgWYfVilthmdc=;
	b=Ch6o1Js/2jA8HpRbI9srd/tgjXkS990s3nIIiE7Va2zKXcCXliLkzCrBOM+mLSYZMhsBsU
	avjYHR2unPQ8csk/Xj7RyIsNsf9zO2RNYhEZYr9kxrnhiIllPTJgyA9h6ZjCDmt5QhLBSH
	KeqLowjau6hJaX1qrjQc76q9NGGog00=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	menglong8.dong@gmail.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf-next v2 5/6] libbpf: Add common attr support for map_create
Date: Fri, 12 Sep 2025 00:33:27 +0800
Message-ID: <20250911163328.93490-6-leon.hwang@linux.dev>
In-Reply-To: <20250911163328.93490-1-leon.hwang@linux.dev>
References: <20250911163328.93490-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

With the previous patch adding common attribute support for
BPF_MAP_CREATE, it is now possible to retrieve detailed error messages
when map creation fails by using the 'log_buf' field from the common
attributes.

This patch extends 'bpf_map_create_opts' with two new fields, 'log_buf'
and 'log_size', allowing users to capture and inspect these log messages.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/bpf.c | 16 +++++++++++++++-
 tools/lib/bpf/bpf.h |  5 ++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 27845e287dd5c..5b58e981a7669 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -218,7 +218,9 @@ int bpf_map_create(enum bpf_map_type map_type,
 		   const struct bpf_map_create_opts *opts)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, map_token_fd);
+	struct bpf_common_attr common_attrs;
 	union bpf_attr attr;
+	__u64 log_buf;
 	int fd;
 
 	bump_rlimit_memlock();
@@ -249,7 +251,19 @@ int bpf_map_create(enum bpf_map_type map_type,
 
 	attr.map_token_fd = OPTS_GET(opts, token_fd, 0);
 
-	fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
+	log_buf = (__u64) OPTS_GET(opts, log_buf, NULL);
+	if (log_buf) {
+		if (!feat_supported(NULL, FEAT_EXTENDED_SYSCALL))
+			return libbpf_err(-EOPNOTSUPP);
+
+		memset(&common_attrs, 0, sizeof(common_attrs));
+		common_attrs.log_buf = log_buf;
+		common_attrs.log_size = OPTS_GET(opts, log_size, 0);
+		fd = sys_bpf_extended(BPF_MAP_CREATE, &attr, attr_sz, &common_attrs,
+				      sizeof(common_attrs));
+	} else {
+		fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
+	}
 	return libbpf_err_errno(fd);
 }
 
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 38819071ecbe7..3b54d6feb5842 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -55,9 +55,12 @@ struct bpf_map_create_opts {
 	__s32 value_type_btf_obj_fd;
 
 	__u32 token_fd;
+
+	const char *log_buf;
+	__u32 log_size;
 	size_t :0;
 };
-#define bpf_map_create_opts__last_field token_fd
+#define bpf_map_create_opts__last_field log_size
 
 LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
 			      const char *map_name,
-- 
2.50.1


