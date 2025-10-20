Return-Path: <bpf+bounces-71466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C508BF3E36
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 00:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC68B4EA95D
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 22:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB8D2F25F2;
	Mon, 20 Oct 2025 22:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFVoctVG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E202F1FCA
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 22:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999151; cv=none; b=fvf5A2ej+fPhp4EpejMs0l8e5F8xrk2FbpvUFgsoVgDxybucikwbkf1mTLmhr2II77WcKTns46M1bLHrT3r8X6f6nMOldAdFsmXO9ikM6q4tq7wforzWnadFLBIWNaMcjhCPikfUV5Cu4RJjkQQzz0t+L9kEEnqqyN6r66sIVRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999151; c=relaxed/simple;
	bh=uEftEbXwvp8w9flWvBB+7yaSoLMlfedOsaB9YYBtIiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=as6nEB/RyatVhJgBF+3blauP5ipxUGH774EBPjs32hCBdAj7V3DYLpAx3/Zis+sTkhvQ7vFwZ6zXihL5C9Na/scrxBGNr83OJwrvwPpqnDeft6dqlCPzlpJcBSOFSOEWqhKkT2Pk80jn0YY1IZw411kViG162U6CCBbgQG2ClqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFVoctVG; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-471191ac79dso40027905e9.3
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 15:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760999148; x=1761603948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1O4jMfEotJt0uEpRkTiHUBTteoE/4zTKfKOJ6aa25R4=;
        b=QFVoctVGuBYDZF30t+YbkAJOp++GFojkaNK/zA/HjluGXngPOU3h4xr5m20V6WeTmS
         wCmbrs2X7reje71Wimfm1Ei/ktzqq6HS1czmIEmQvlTGqxOuiE9LwFIw5pjhfosLv9KW
         1hkIfAWBGExDFP2nzYXzNstYLANC+R5U9isGttENcBgmd8O3mjoeEBVJV63AzBav4/FA
         7omQQF9M/p5VmFyG4ANl5G4Q/HMvQsiSiFqbsVAkuem1TuvoghgCVHTe/hag93wRxvS9
         rDxhOb0w05aKmH8lnw8YuK9n5Apz1bTxNBerrPLN5aPoEEmIFBcBoog3LCvpIUEHposY
         1RXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760999148; x=1761603948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1O4jMfEotJt0uEpRkTiHUBTteoE/4zTKfKOJ6aa25R4=;
        b=cRMQj7AS8jjs9tngCJHhO3uhViGfKHm5wkQ1IFWSr2bXFbFECpWSnE3+vOkYa9xImS
         AXAaqgS7LOQxy3Zbh1j0OHYurRSn3zhFOVhLTTlgGqjlF593JonZd+O6xLoUnjk+A2Oc
         mGGJ2D2xGzy6oLjJa3flh/+WpH/C6MAPJJ9/pu7JoIcdz8IlkYHUG/iDaB9GL1wO7YI7
         NzXfAVAWZ2Rb+M5hlGUpOkeSh2CS9jbDktT/i2r2SP6jQ5kSzGId4jUkrRXfl/5uWiFW
         vTNhAM76bM7jotVhma3e2o/mai9vSc/vvhWMmM3QAtHbjgIspmDxphaRk5s+u9ImDScd
         KZwQ==
X-Gm-Message-State: AOJu0Yyy2d5bm7rH4VIcK75KxYCi+aLulZaUcIW5nNBHErpOikFad4tq
	GDJPps15Q9KFPnr6EA4v+F+uBhsw+Dagfnf6RzvkGnSDmufYDOoVEz7qwkCo6g==
X-Gm-Gg: ASbGncs5c4NOyY/H+P1jGIm2XGFdqKewKI0RqqScQuGGbc+uKIVEZg11HGkgcjNRPsr
	dYHPYrFPCo285wNb3no0Yucx+RyoPzVKTRWExaz72PZNv+ECHwrUqI5WaazwGDX2Iito4IFyeE2
	exu42tgBUynVddwRnBddcvd112yYWfkvu8oqHTmu/tjzKaCIHmGPAz6PeLemS0BfVENEr5El1uf
	uZwks5ewE6LThvUFxuR9kz4heS21bsc/pMMoWv+46FU8NUVPAfTgPoKnqbLg1yAkEJIDjDen3EH
	PCilKJB+58dJZjBeNU0TshMSxGwm37iu074UoYoWS4zoatkWQyPL/HWMYQa8hR9JANv8lHvCC2y
	/Do9Z4mKjPGEamI7+Ubr2PAM7QMfN8R5sDKUJMEEjPsd0jkONzueGcee1TD3Z2E8ztiyg+Q==
X-Google-Smtp-Source: AGHT+IFvVd/4Tj+9zSuc4oil7yRkPEU6Fu8P3IA6uuZj2vi0YUV4MnalzcSOuRW/jZfi9TGr5k251w==
X-Received: by 2002:a05:6000:2889:b0:428:3fbb:83fd with SMTP id ffacd0b85a97d-4283fbb8f3dmr6192792f8f.38.1760999148165;
        Mon, 20 Oct 2025 15:25:48 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:2617])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144b5c91sm248850095e9.11.2025.10.20.15.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:25:47 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 03/10] lib: move freader into buildid.h
Date: Mon, 20 Oct 2025 23:25:31 +0100
Message-ID: <20251020222538.932915-4-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020222538.932915-1-mykyta.yatsenko5@gmail.com>
References: <20251020222538.932915-1-mykyta.yatsenko5@gmail.com>
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


