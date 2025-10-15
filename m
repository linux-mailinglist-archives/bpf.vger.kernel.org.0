Return-Path: <bpf+bounces-71021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB413BDF96B
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 18:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 72864357BFF
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 16:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0047E3375B5;
	Wed, 15 Oct 2025 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTTih1Ie"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E03335BDB
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544725; cv=none; b=aAP9KBgq5pTtdHaqpALzQG93jqX1NK9WhUc0AVcgGVu/O8Iw96HNyJhwWSA4gYuTiwJ6d/xp93gjt4lIpbRtdirP/0WVbdefXgUcJBBoSNxcZE8dmlEsh9HAelvF0Z8k3WmYTp+5iJ2SMCZWdoR4UahrEdZvXdLF2uE0eo3EPjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544725; c=relaxed/simple;
	bh=GevRS8UyFVwDdHEKJ61rvGZ/ttzolMtmQO5nLYQ7rTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5yAEt6BuEdVFuXVqsfc7TNcYMmPxLAxuVNj02FtUxHHSRAEX6wxIo3fvz7/yNr1Mh/eFEqmUiP4M/CvOWCzcOB0kIOEBitI754BXz4FAAQTNvtUKaiULQtas/2RHcaxUraMSzHEhpqzJO7hKZzhynlVr6mDcCyG4uRp2+qjPfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTTih1Ie; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46b303f7469so47102805e9.1
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 09:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760544721; x=1761149521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=al+jsfgWOHOFRTZNNopTyz5f+hXuJolRTda5yAwuug8=;
        b=dTTih1Iek2whLaJIad/BpyR+0Jryo58NNspoT6FpmGjRyxbvSoy2cQamGdY+Ty1+OE
         EThLkk4aBxq6uBo9mgilw9RqnSoJThs2+dTgBrdSc5JUIy9f5GeJknkEuJexyVBKBT8T
         +vc5y1CwvENPPPeFV5t9Sdi1jEFQ8oqO1iomPL6MyFYn/dR61T6eqKezVYUgSlC+0i21
         k0h2VdGC5uMsHkQqM6CKKC8KuvP6PqI2G0cFiUWcsHa/BULta2fftQeETllGHSbIzoA8
         vhBakprZAScHgbckVM7RZsXjGnJBmssflOqSFigtBdK/JyLLQP4cG/DS3R/DmGlN5sk8
         NtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760544721; x=1761149521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=al+jsfgWOHOFRTZNNopTyz5f+hXuJolRTda5yAwuug8=;
        b=Yvtwz0hcfJCklCiZ0oCj60GK4d+6ST5t1tPIcLjeR5Y5/bQBbzDNZHZebhsDaId0+4
         vIWVOUZMKuOAane5WoNcSn/9ZzsGudLpzGC//h2HOVI/QDEexlU1bPNtLDYkBrqfs9t/
         SJEHjGw2Mm4axlArrkoi7VxYokqGUJbOI0n4uU7qbZUzPl3jv1h1QPWZ4e1F8eJC4/vx
         6TC2wDH6VA9LUTYy+b2Z2W5rxtb+qJeuUzBVPTESt8JhDh3KEFHLT42qkwQcdz4eh8Ek
         HZBHExKwWth7DFqPfN2FbLGRu7qUMhvPdEOZNkobCczQJMuIEHMPGVnnDBKPTlMurHqX
         oz5w==
X-Gm-Message-State: AOJu0YzqcxzXpNQMX80sZ+eyHGNfXmC4joWu4OG1y9kTI4S/9XUxZcM+
	EQQsOqs9HaodVcMnj+UTLLMbnq0ok3MbaL/V0OlsVGEg4i5dg6a+juIMA6dQ7A==
X-Gm-Gg: ASbGnctzGLrddQCkt4ZcqE8cQmFJujT5H+vMGtdqwVyxKTfudS+jXASxORG8Y+dr8hb
	k5H195uLpjhHudR7wl3rr4Gh8LKKOfc/bnDcS9rr8roTBUMQn72yJ5b5C6tvFtwKepajSYAuMwx
	jWuRsVx5y8JbBaPEiLC7MV3mF8nzQooMI4qLIDaWHrhWvMdtR76UrPrh40evv7uL0uWliRbPzBb
	ZqAWATWFdD+MhOQ6qZPRf1igavb/xZBpva4B+Azi/rh4sIw7J/MKqp7ozvNnd8Bf8vKIrehqVqC
	AauvYde4mJMaT/MnoOptirO3548GnmuIkU/TMLutp8tG2znyrZ515UTcN8V+cwMwRUQAyudiOt5
	UjwXT+NiX2oygEoX66p2vtlq1aD1wWWckQl0WVKwqGasZ22b0USNlOe0=
X-Google-Smtp-Source: AGHT+IGslBzMt/4lYT3o6RPTx9zg2gYzfRvhRSCKPP1zlSn6zx4Xb3hLg836kz86lpI1HsEL1hTv5Q==
X-Received: by 2002:a05:600c:350b:b0:46e:6603:2ab0 with SMTP id 5b1f17b1804b1-46fa9aeff11mr203090355e9.24.1760544721058;
        Wed, 15 Oct 2025 09:12:01 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47101be0caasm36952555e9.3.2025.10.15.09.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 09:12:00 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [RFC PATCH v2 03/11] lib: move freader into buildid.h
Date: Wed, 15 Oct 2025 17:11:47 +0100
Message-ID: <20251015161155.120148-4-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
References: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
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
index 46126ce2f968..c0dd43d517c5 100644
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


