Return-Path: <bpf+bounces-71157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEC7BE56C6
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 22:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD1BA19A43F2
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 20:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86272E4279;
	Thu, 16 Oct 2025 20:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ivl6XtuP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1751119F48D
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 20:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647509; cv=none; b=CD8RbVoH+L/819uqgG7XXKUEcAAZkpO8d1/mQxeZMec0FC9K5TK3XlgV/evyAOgkwpwFsELE5vjOqLRZDDuioT9hg0UtQf5azIMUBMtANXB3VBRmdWcTZX1F//deeLNt3F4Q1+I+rz7ldJpDXOXXUWJtB4vM4QESvFy1tHmgYLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647509; c=relaxed/simple;
	bh=KOcdxzTTtq8Em9qroByJ8eMut+8WIyFvVQHqgJ/pWc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nB8YDjkrgZpFPCMaWOcnRjgg3a+zoKNNK9QT3hLy7F4kanrBpJ8hHKvTf9uPPQ3flKBUJ5jF+/M5CQrPD7q2AkVJXp5J/wTF8PSXSa5tp9yatyyYIeUJKUF/ThOGwGbSkvt3/o3zTxjAViWvsM2d4xTYOwEwAQi/DqlEL1fffJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ivl6XtuP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2698384978dso8984375ad.0
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 13:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760647507; x=1761252307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMrvzd50VbeEbuCp9cbDCbzIZmFB/ZT0z8NiVoSgkKQ=;
        b=Ivl6XtuPOTwwk6hwtuIGcQqZJzwftOQVIRG3UV8au0yAWYNGqyOzx6d3UMIRzp4dRe
         4IIGfuzRcBZRqVbQVCm2AL2hOXG0bd74ThZ5CdPEFG6iTNPsI3ciqzzCuiVFM8VAniOC
         GlOpDcTWleYkPpUG6BdqLpFmF2qmNMM+HUa5Q/izsbv6LAY+cZxjIKw00zxrX4HB/rEU
         cRI2wrN5yP2G5OeWhW/8QBUbDxbCgPMSohpQGwf1t1kexc30XPmpRpMNa+/8AfcDxjQE
         O+OREHfzAJ9lFjLQnYmaqY0rcaPc8jJt3k+oZbpyoYdDAhb8jEK1WZKWwL/ch5k1GYwC
         G/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760647507; x=1761252307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMrvzd50VbeEbuCp9cbDCbzIZmFB/ZT0z8NiVoSgkKQ=;
        b=EwCoPi6z3s2iPLlpQJh4FLXOqxLcJOR8j4s7be5c1ckYhF5P0gA7DXD0xY3HI/4oBb
         WqO+B7DKcqfTNA5bdUsbn10lkibZZNy9p/on98A0uRtePM8m5/XmEfiCRJ0rAgRA9iH3
         Q1DAt2rHvANS0hpVyFaabyw7lx7epS+14R2V5RDlm9aW/fiH3IETKILEwmctSDbiqAJ9
         SC1sRbXtiBt9nd0Jx88JKqp/fZV5hHE+sc7bgMrryzkEKRhID7W26Ft6CTN7aS3QBAiV
         M4R9s5ETF+J7odSpMV26W+B/+88fBCgPIwaebl7A99pQp83qkO64l33JbyZAFGyGBzqe
         Z12Q==
X-Gm-Message-State: AOJu0YwaSccRgciBTSi4936vX7Riu2s61V2oZKfCYdvan2lwIjTDej7X
	dYj3vfAr2nNcg8OLBBm8956MMORFA398+XIRSREjQnAq9nDJb+olFGDVWr0UIw==
X-Gm-Gg: ASbGncsOy7WPDqCW7mb6BNIE3y1eiHxZGoIf2yZKvJy/Z8G+Bc+CU28yelzh6a/cwjV
	0OZT26fuj9dsdrBw1l8+6Qc318tBcBSOTIzyx73PevH4LnJbGyfdF45rDkHBKeGvgtMaxm/9b8Z
	ETwQV1pOgNKAvMYeUcIvEcgwjwYfYw4RSXq1CuZhxryYs8ZnJ4de5QMokoLVEbNq3s10whT1HGz
	gayMHNCbBSKWESVfOH+0JtR2F2SMJ/BIcwwnCGtro74V8BKbRxA3MkUST7UiBC7lDz+2YvTtfaI
	4+zq4Yru/3zNwNr28D0tT5rkfdSOcyjvgwjmu2lnUJW+4NMH5Jka8VIeMNlaFFPzA3jDkiZbNN2
	xgl/CXxBFVQZoY1+kAvZXy6Pw3npD5VKlDJG29ZvTvDykT+ih6szLBNT5RKyD5L5ox9aGt0HQXi
	zMaL1KOz8ZacGI
X-Google-Smtp-Source: AGHT+IHMDjd5z2okgXhxfefo8LVS6frNU+rzb6uzgl7Iz6OuCeVp4+LYtZTw+jv2tJptJQuVS4qCWQ==
X-Received: by 2002:a17:902:f550:b0:275:81ca:2c5 with SMTP id d9443c01a7336-290cba42439mr16470735ad.59.1760647506943;
        Thu, 16 Oct 2025 13:45:06 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4c::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099aab735sm40135795ad.77.2025.10.16.13.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 13:45:06 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 3/4] libbpf: Add bpf_prog_assoc_struct_ops() API
Date: Thu, 16 Oct 2025 13:45:02 -0700
Message-ID: <20251016204503.3203690-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016204503.3203690-1-ameryhung@gmail.com>
References: <20251016204503.3203690-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add low-level wrapper API for BPF_PROG_ASSOC_STRUCT_OPS command in the
bpf() syscall.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/lib/bpf/bpf.c      | 19 +++++++++++++++++++
 tools/lib/bpf/bpf.h      | 20 ++++++++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 40 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 339b19797237..020149da30dd 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1397,3 +1397,22 @@ int bpf_prog_stream_read(int prog_fd, __u32 stream_id, void *buf, __u32 buf_len,
 	err = sys_bpf(BPF_PROG_STREAM_READ_BY_FD, &attr, attr_sz);
 	return libbpf_err_errno(err);
 }
+
+int bpf_prog_assoc_struct_ops(int map_fd, int prog_fd,
+			      struct bpf_prog_assoc_struct_ops_opts *opts)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, prog_assoc_struct_ops);
+	union bpf_attr attr;
+	int err;
+
+	if (!OPTS_VALID(opts, bpf_prog_assoc_struct_ops_opts))
+		return libbpf_err(-EINVAL);
+
+	memset(&attr, 0, attr_sz);
+	attr.prog_assoc_struct_ops.map_fd = map_fd;
+	attr.prog_assoc_struct_ops.prog_fd = prog_fd;
+	attr.prog_assoc_struct_ops.flags = OPTS_GET(opts, flags, 0);
+
+	err = sys_bpf(BPF_PROG_ASSOC_STRUCT_OPS, &attr, attr_sz);
+	return libbpf_err_errno(err);
+}
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index e983a3e40d61..14687c08772d 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -733,6 +733,26 @@ struct bpf_prog_stream_read_opts {
 LIBBPF_API int bpf_prog_stream_read(int prog_fd, __u32 stream_id, void *buf, __u32 buf_len,
 				    struct bpf_prog_stream_read_opts *opts);
 
+struct bpf_prog_assoc_struct_ops_opts {
+	size_t sz;
+	__u32 flags;
+	size_t :0;
+};
+#define bpf_prog_assoc_struct_ops_opts__last_field flags
+/**
+ * @brief **bpf_prog_assoc_struct_ops** associates a BPF program with a
+ * struct_ops map.
+ *
+ * @param map_fd FD for the struct_ops map to be associated with a BPF program
+ * @param prog_fd FD for the BPF program
+ * @param opts optional options, can be NULL
+ *
+ * @return 0 on success; negative error code, otherwise (errno is also set to
+ * the error code)
+ */
+LIBBPF_API int bpf_prog_assoc_struct_ops(int map_fd, int prog_fd,
+					 struct bpf_prog_assoc_struct_ops_opts *opts);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 8ed8749907d4..e1602569426a 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -451,4 +451,5 @@ LIBBPF_1.7.0 {
 	global:
 		bpf_map__set_exclusive_program;
 		bpf_map__exclusive_program;
+		bpf_prog_assoc_struct_ops;
 } LIBBPF_1.6.0;
-- 
2.47.3


