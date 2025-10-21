Return-Path: <bpf+bounces-71626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F47BF880F
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 22:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9CE164FA7A3
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 20:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8C2275B1A;
	Tue, 21 Oct 2025 20:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgWBGQ/l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C217A265CDD
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 20:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761077028; cv=none; b=Z9+/M1Wo9FXXYs/Q5RWKNq7tWElx29Wm0K+gNM0StWmnD/AYy/Z9mAU//aSzPbUvXzCfWKwHPNnm20xluxshTDJ1O+6BYFjxKPJzZuAg0t4swbY2veZyPMxr9mq++GPTJE5TRJF1qXET0jhloimpSJ27ET5467hvGpYzWelJUAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761077028; c=relaxed/simple;
	bh=uEftEbXwvp8w9flWvBB+7yaSoLMlfedOsaB9YYBtIiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iSJEAZ7AjsoFYmYlBzQ5P4ABAZaB+uF/KutGsiN3/mLyJxZlMOvPvvzfJeqVJygBLyzVyEtWmpZ5sSj4KML8CeBjAqnofEEfgeg/c9vc8qT1XhFPQ8GJpxpFwQBACOQENmcxfmIKQdOEKBu1HT2/JGhe7rzvdOwf5PjxQStfkyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgWBGQ/l; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e542196c7so1494265e9.0
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 13:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761077025; x=1761681825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1O4jMfEotJt0uEpRkTiHUBTteoE/4zTKfKOJ6aa25R4=;
        b=jgWBGQ/lQV0fLmjqKjmzNhGAhx4jwzOMlmb2CrG0Db7Xm8v0RDCHHJsCKC0m5VZU+K
         4ssDIxQ5idcBF9qnsLWDA2LPHrx9mapF0RP/3USxuGchJe3d9fmZMQfuKBhhYHCuEk1V
         QSL9TqQRUfE9Zs8cEhtu2WHhijC8TMbhrBhcoIQD/L3ufF5oojAT6/D54nRsm0btW0wz
         jIzNpG47fF9Bp8Ac8Kq3toxCACeNPK5oL/BoO2tj8fP8PKlabP3VF7BowHCWf1/XedzF
         hLV36AAl5KbQ13HqiSJmKZIkiw6rBa+Idqukn6srvpGN81d6IOUxWJrV2Qp78zDjaJsC
         9RJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761077025; x=1761681825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1O4jMfEotJt0uEpRkTiHUBTteoE/4zTKfKOJ6aa25R4=;
        b=Bk4BifmgwIl0oI6oBpJltrM31oLENpdyKm0pc5wIg4Z45Oj2olyhR6z84wjpAQ0mJd
         MkORJ9GGKht2dmdCHf9FbH+mEj2XDYlxPvcCEMW9lu+xFltEsqA+FXHq3VezRczgYXJJ
         wJKeHD2HCrOhLd6DfCiVcPRzWg+R+wKtlwGC66/BpMF8smbuy3qbBu0GJGy0OtP/AhiC
         T4yHeCaCMCCoJOW2usD6GpP5hYtKN6yFv9CUInWLNpdz77SLIUVgOmUSd08LCRFprkOo
         cdSv3P1ZK1Oa4i/mPi7NMV2OWAHH74uAyEQ2aEXfuvGs09bKhgRisY++xLA0dRu3qp9K
         +I6Q==
X-Gm-Message-State: AOJu0YwvxWgJoLfz3srAB7y53exaivsUY1y8HN4ayCoAWSja/KTaLym+
	xzEgGJxDYL4OBCZs0ocF5BznIUvdeN7h0OhF/mGwJDkY+TTinQL9NNVe5GgxwA==
X-Gm-Gg: ASbGnctoyv+PmgfRduRUPxceamHMVyOXdCIP4f9G0fmefmZkfoQyfW9I5/npDXbzwcD
	rFiRczOdLejbJjBVZOjwJkW3uUz9Uq6YtT5nQATnJYah0nj5zmIv9obUUsb/zqQWZVtosdsJink
	UUnFSXXjFu+PPwBJrTX+Sfc7Yz+d87BZ+uONVW7+da/mbqyUtAukNL2YR5W91g2g8XCkGMevjx4
	7IsW+VPPNGMuYS2UDtMkFauGx/Apru6XQmp1wJxV3aSazXkNUQIdM8Dn2WEZVGMzpVIrxLB4Lbn
	teFiAhfqKzvA/uAmoRvDGoQnWQ21ImDcR3ddK1uIKLN83GLfcmzUp7dxWWvnrMIpLuielXpgUGW
	znrXeoswPEU8qMxHX6o4vhcUeEM90m0GIm96uRYUJnxB2/+n1XWv9t/qATxEGQxDMI2asjZdrIv
	GQg0JxdQ==
X-Google-Smtp-Source: AGHT+IHzTLnvW67vvLSi/WpB66XyqBYmsz19bS1oVzpWL7RhrtxiIzmD8HX+gN4Ku4ZaMRrO9+Pt7w==
X-Received: by 2002:a05:600c:4c12:b0:46e:33ed:bca4 with SMTP id 5b1f17b1804b1-475c3edfdc2mr4141185e9.15.1761077024999;
        Tue, 21 Oct 2025 13:03:44 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::6:c0ff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428f709sm9831435e9.8.2025.10.21.13.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 13:03:44 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 03/10] lib: move freader into buildid.h
Date: Tue, 21 Oct 2025 21:03:27 +0100
Message-ID: <20251021200334.220542-4-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021200334.220542-1-mykyta.yatsenko5@gmail.com>
References: <20251021200334.220542-1-mykyta.yatsenko5@gmail.com>
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


