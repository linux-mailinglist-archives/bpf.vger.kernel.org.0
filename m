Return-Path: <bpf+bounces-72278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C246C0B359
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 21:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BFEA14EC9C5
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 20:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5282F7AB1;
	Sun, 26 Oct 2025 20:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICACeaK0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6BC1C84D0
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 20:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761511151; cv=none; b=elT6jPM5/VLXmzjkAxOxtFHvre356Theb24C3KMnAmypT4Sg0sjgJ1eGkPF0LaDbAK30UHsi03mofLeCKVLbEvgzityN68fSisYIvjWbMgWyLcfIcTuWkshj02nkSRGuragNB8RUrstONu2fZwSuAgB00diUatxNNWms4MyNmzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761511151; c=relaxed/simple;
	bh=uEftEbXwvp8w9flWvBB+7yaSoLMlfedOsaB9YYBtIiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dt6ZsCZxhPEBCPx1rwqVmolCYixPyebTTWzMJFU97wOFuPVYWoePjxtO7O+0xwk8u1IGLQq0dckpWH6GLihZQS55ZH+WwYtal1rmPlDg+tUkLcWfdoQ9ide1r3vstQba1jqvigy6C8myOr0oPb5f5A3oCSmpwDjW6QFsbFJbHcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICACeaK0; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-475de184058so4232605e9.2
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 13:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761511147; x=1762115947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1O4jMfEotJt0uEpRkTiHUBTteoE/4zTKfKOJ6aa25R4=;
        b=ICACeaK0JVf+R9hF1AH8yWe/tmlRhhxnlrV+giseAkUfQVWItYjXxxscNcC072FMUf
         U5Y9IpMvxvDA+p6LaVGAq5oHGvAXeILL9IiU6UIS5Rt32qlZnSHnpg5wsF9vgXOOhY7d
         wNWRz9jNdw0DoYvCmnKbHYZURG2wLlvwS70dnj9/BjzemLm32woLWhMowdingU2LUquq
         XhPtJ00HztuZtkJTU5aeDe6qHs/reCBYlIttgaRyHob/Kd9gfW39eIndAq/4CPkFg2hJ
         +oURdFftVmqXXsk6xmFvCMipub/Ky+Uvcxq/5toIT3J5q39cE9lPGu0EYHrJJELFZ97N
         h+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761511147; x=1762115947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1O4jMfEotJt0uEpRkTiHUBTteoE/4zTKfKOJ6aa25R4=;
        b=YOzrJxYinJKRL0nP9zIuW29L/WG4SgLZZeF3l155Jvmj5nSZqhwHEGqE0y2buZD7UJ
         KYnGStdwY05w/Ix2xW57+vsnS+Y+FMpKaI8HvR8xaq6Ip7z83IAuNPux/Gxdu9jmoZPG
         Ey4foEnTLzEDgcgvbnJD2lA8gbVlt2tVHwRRLIBSEoMpK5ghn1Iy9r7XN1tVtARYwicE
         9TdllY/6eCdW6z1nII6R4t5rW2VWQD8vrAghziqCeAh8P/7AHTcjUzvJSp99NmPGGQeM
         kzhz9B5NM0rZs5gNKX95y+iQo07Os8Z3LPUzv33fQhldcwuqP3mk9BBmm2vta5KFbH0h
         jIBA==
X-Gm-Message-State: AOJu0YzC0jJ3F5Rlm3BXzGPoT14o6QzvSfsh9F/jaudg/QKALPWBa4TZ
	xBNOfPyTtS6QPW/PT8xRnMrkYAtX/pqLbSnvUKCOk9Oa3KldWyHhFNFGnB8nrQ==
X-Gm-Gg: ASbGnctVVe5jEzI0EFDeMzYMRnInrLlKkHI0LbcwhdmxWID19XJFES4bJHE9GCYa52H
	U11VTcBtgn4V8ik/JVF/pTReCWIATFwBnErNY5ovQ9aF6sOkPHfIZm9NWN2IwFQ+4F1dRECr6Vs
	Y1r0Gg0CrZBwlq2tuoTX+f31ThWqD6b1TdpMuW65GiNlLrx7oxyFIV8zGrhxbCeWVENqz1ucXdV
	evsWBZatnHMnLpoTgGcB7DHUNggPZBkJLKsaNDSrGBCBepg0LABjNEcL3lg92+XzDy/oc/2gwkR
	oPkChJJ+/LfP3b4XBrlVZyWu4QPJHVrPHNhdrazF2sxyJH/RTIDXqDyyaYvRsExU8HwJ7FGZB6E
	xgXqdrh4ILHIHLa2lpPnJWBTCGNwuOis5ZA6HC+g+I4ZsHRNCsg9zIvG7ZFLRNah1h80Rnw==
X-Google-Smtp-Source: AGHT+IEZAtTKmpJrBB2u5C8sV+6csdZ/WHskkooXUM9VpNsCUfuLYBq001wxX+7NcqX0YBJimBF0Gw==
X-Received: by 2002:a05:600c:840a:b0:476:57b4:72b6 with SMTP id 5b1f17b1804b1-47657b47376mr45839825e9.8.1761511147225;
        Sun, 26 Oct 2025 13:39:07 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:4ccd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475ddb01036sm45741475e9.13.2025.10.26.13.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 13:39:06 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v5 03/10] lib: move freader into buildid.h
Date: Sun, 26 Oct 2025 20:38:46 +0000
Message-ID: <20251026203853.135105-4-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251026203853.135105-1-mykyta.yatsenko5@gmail.com>
References: <20251026203853.135105-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Move struct freader and prototypes of the functions operating on it into
the buildid.h.

This allows reusing freader outside buildid, e.g. for file dynptr
support added later.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 MAINTAINERS             |  1 +
 include/linux/buildid.h | 25 +++++++++++++++++++++++++
 lib/buildid.c           | 29 +++++------------------------
 3 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 545a4776795e..7564692f2f3c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4648,6 +4648,7 @@ F:	Documentation/userspace-api/ebpf/
 F:	arch/*/net/*
 F:	include/linux/bpf*
 F:	include/linux/btf*
+F:	include/linux/buildid.h
 F:	include/linux/filter.h
 F:	include/trace/events/xdp.h
 F:	include/uapi/linux/bpf*
diff --git a/include/linux/buildid.h b/include/linux/buildid.h
index 014a88c41073..831c1b4b626c 100644
--- a/include/linux/buildid.h
+++ b/include/linux/buildid.h
@@ -18,4 +18,29 @@ void init_vmlinux_build_id(void);
 static inline void init_vmlinux_build_id(void) { }
 #endif
 
+struct freader {
+	void *buf;
+	u32 buf_sz;
+	int err;
+	union {
+		struct {
+			struct file *file;
+			struct folio *folio;
+			void *addr;
+			loff_t folio_off;
+			bool may_fault;
+		};
+		struct {
+			const char *data;
+			u64 data_sz;
+		};
+	};
+};
+
+void freader_init_from_file(struct freader *r, void *buf, u32 buf_sz,
+			    struct file *file, bool may_fault);
+void freader_init_from_mem(struct freader *r, const char *data, u64 data_sz);
+const void *freader_fetch(struct freader *r, loff_t file_off, size_t sz);
+void freader_cleanup(struct freader *r);
+
 #endif
diff --git a/lib/buildid.c b/lib/buildid.c
index c4b0f376fb34..df06e492810d 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -11,27 +11,8 @@
 
 #define MAX_PHDR_CNT 256
 
-struct freader {
-	void *buf;
-	u32 buf_sz;
-	int err;
-	union {
-		struct {
-			struct file *file;
-			struct folio *folio;
-			void *addr;
-			loff_t folio_off;
-			bool may_fault;
-		};
-		struct {
-			const char *data;
-			u64 data_sz;
-		};
-	};
-};
-
-static void freader_init_from_file(struct freader *r, void *buf, u32 buf_sz,
-				   struct file *file, bool may_fault)
+void freader_init_from_file(struct freader *r, void *buf, u32 buf_sz,
+			    struct file *file, bool may_fault)
 {
 	memset(r, 0, sizeof(*r));
 	r->buf = buf;
@@ -40,7 +21,7 @@ static void freader_init_from_file(struct freader *r, void *buf, u32 buf_sz,
 	r->may_fault = may_fault;
 }
 
-static void freader_init_from_mem(struct freader *r, const char *data, u64 data_sz)
+void freader_init_from_mem(struct freader *r, const char *data, u64 data_sz)
 {
 	memset(r, 0, sizeof(*r));
 	r->data = data;
@@ -92,7 +73,7 @@ static int freader_get_folio(struct freader *r, loff_t file_off)
 	return 0;
 }
 
-static const void *freader_fetch(struct freader *r, loff_t file_off, size_t sz)
+const void *freader_fetch(struct freader *r, loff_t file_off, size_t sz)
 {
 	size_t folio_sz;
 
@@ -147,7 +128,7 @@ static const void *freader_fetch(struct freader *r, loff_t file_off, size_t sz)
 	return r->addr + (file_off - r->folio_off);
 }
 
-static void freader_cleanup(struct freader *r)
+void freader_cleanup(struct freader *r)
 {
 	if (!r->buf)
 		return; /* non-file-backed mode */
-- 
2.51.0


