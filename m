Return-Path: <bpf+bounces-58050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B807AB45B3
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 22:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19BC317D498
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 20:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40546299951;
	Mon, 12 May 2025 20:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4cjBl4z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BA0298CD4
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 20:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747083237; cv=none; b=kYoYPBDnAj/O5GSfsih7qSm5Nm9ck0jk3V8YDtqEg3lCBlV/uSPhvy35vN1yXJ8hBnzc5gbWHG4KStaOaUgFP4LWgNki1nRZWmevBM/oNoy63LVFtX0qFoKAbLeQM53Mmzv7sLhHMD1NFBUv0TEAPp5cpu2qImR/weem62g97Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747083237; c=relaxed/simple;
	bh=iO3dkpXs3uWso+WMhG4Ia0xHxAiIF63HXihDwd4Z3YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ss7xMjQZsphRGJwPC+zCaDNGPS2okKEEHYtvLgsg1Qid+8xx+9+178CCIJV3F51DLN/8Aol1oE1GziSjZJ/LCqZM51xXON6cCfpqeHirQuNNjs6/FSKlnymK4Gxj3KZ4fzPTJoc0N/5t+0SIBtgt5o+2PEFb6+Xg9GL1pFxAYyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4cjBl4z; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so36245215e9.1
        for <bpf@vger.kernel.org>; Mon, 12 May 2025 13:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747083234; x=1747688034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzxivtoutCO22TrB44w34clNR6wY9NwXOLdmHgLHh2A=;
        b=k4cjBl4zCyNdiwzRG6PSg7GGRlwv33VgWwu2z5o9Q/Xofdl6jlLIJu14Oyd0erWpIb
         7adefx7F2VDbHOmCkyUwqmxLoXBB9RqMFWyLyOcWvi4oRW/r2yDu5GKpqZsn+mU/19U6
         HtdGEq7qUF8cTBnu8jGWHT1dYsBQ6GzHu7Yk8nbLlv780XrGxBb08BoGsPkE/dOpl9Xs
         qLlRUoGR87ecVOV53er5kqrXP0t6p7aFt9sc+CNydAZpxHDxlocZW+JuEyCEKRvzAEDQ
         30vGeQLQlQ9w9QL3r4D2MYvtmuk4hq/UWY+EodmiahiKZy5Pc3+7rD6NOhcc2yb8CtmS
         SfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747083234; x=1747688034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzxivtoutCO22TrB44w34clNR6wY9NwXOLdmHgLHh2A=;
        b=Jaj03X/9uSd7nhKfEjF1aMJm7eEbRVfuu44NkfLCQST152z5KFCoS/hHhJ3WMnEn6M
         qgpyU/KquLrvF41CkWBFUto8wsc+A7QO1GtZfdT5/yMhjbxUyXPuKnLHCIReLDJHISwD
         OogOewVUHbnxEdUgKuRe1ULsfp5a3jsD5VLOksF4uLOyQgi0QFwL3FlBWGo3d+EjUhYZ
         HaNtaTAufDg0ayPW4K3YLnfbzdV3hjXOcrDI1jMsYWm/yNsZUipic9SyoBkpDAIo+DwX
         x0SAkTmFIO8mBXVN9TS7QT3TQVUHjZXaBWHpNWSTHZePfL6OhJEk9eahxycTMI9xkJTX
         ORjQ==
X-Gm-Message-State: AOJu0YyrLssa6y2cDpMfrAnEOouZlv1Kw7XBuaxZcgMe0IH0uIvqcCTh
	sW8QGxUi6Bkdbno9PsWOhQRX1oilZXT+N+mw+R73MWPBgCwg/9rS0/Hgbg==
X-Gm-Gg: ASbGncvAlbB9rAb+i2xw0H9dZgXQUz13vMoOarPTySgHwidkbELCJJ9I5xqXzigioIm
	01ODmhJHqOZmeSY/aySyAmYpRlsFCZQ87fXNZ3ZVUPJFLnrg6sP2/u1dTc/+FgrqEsw0bIrB7zf
	NZFtWnJB4Zxh14OMIvp6XeR9P+UnpQT1tPQiD3YCBal90utCuAKsHPFNlTuraET8L6pwlBy1lPj
	9ozOCU4hD0QgMbDXVZ+0FFXW0P//WC6Ksd+IS0BhfzlM4WtHH7Hiwg9qZNIhMzv44E3tfzGuCU8
	5GLxcE6YRGyH7nxjjQLRV7yfTaSUczdtyKUXP60yblOXmGRj2HMlVKlkM1vk9zhUXDcmug==
X-Google-Smtp-Source: AGHT+IEELH45RZyhABpkvNoBr7tPl45iB3RBMjnjN5pgpROCQce5IlquCFLpAJOGplXKIxna3/eSug==
X-Received: by 2002:a05:600c:8707:b0:43d:8ea:8d7a with SMTP id 5b1f17b1804b1-442d6ddd6eemr86982275e9.28.1747083233898;
        Mon, 12 May 2025 13:53:53 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd3285c7sm182800915e9.3.2025.05.12.13.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 13:53:53 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v5 1/3] helpers: make few bpf helpers public
Date: Mon, 12 May 2025 21:53:46 +0100
Message-ID: <20250512205348.191079-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512205348.191079-1-mykyta.yatsenko5@gmail.com>
References: <20250512205348.191079-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Make bpf_dynptr_slice_rdwr, bpf_dynptr_check_off_len and
__bpf_dynptr_write available outside of the helpers.c by
adding their prototypes into linux/include/bpf.h.
bpf_dynptr_check_off_len() implementation is moved to header and made
inline explicitly, as small function should typically be inlined.

These functions are going to be used from bpf_trace.c in the next
patch of this series.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/bpf.h  | 14 ++++++++++++++
 kernel/bpf/helpers.c | 14 ++------------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3f0cc89c0622..83c56f40842b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1349,6 +1349,20 @@ u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
 const void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 len);
 void *__bpf_dynptr_data_rw(const struct bpf_dynptr_kern *ptr, u32 len);
 bool __bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr);
+int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset,
+		       void *src, u32 len, u64 flags);
+void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr *p, u32 offset,
+			    void *buffer__opt, u32 buffer__szk);
+
+static inline int bpf_dynptr_check_off_len(const struct bpf_dynptr_kern *ptr, u32 offset, u32 len)
+{
+	u32 size = __bpf_dynptr_size(ptr);
+
+	if (len > size || offset > size - len)
+		return -E2BIG;
+
+	return 0;
+}
 
 #ifdef CONFIG_BPF_JIT
 int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e3a2662f4e33..048bd7ac1455 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1713,16 +1713,6 @@ void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr)
 	memset(ptr, 0, sizeof(*ptr));
 }
 
-static int bpf_dynptr_check_off_len(const struct bpf_dynptr_kern *ptr, u32 offset, u32 len)
-{
-	u32 size = __bpf_dynptr_size(ptr);
-
-	if (len > size || offset > size - len)
-		return -E2BIG;
-
-	return 0;
-}
-
 BPF_CALL_4(bpf_dynptr_from_mem, void *, data, u32, size, u64, flags, struct bpf_dynptr_kern *, ptr)
 {
 	int err;
@@ -1809,8 +1799,8 @@ static const struct bpf_func_proto bpf_dynptr_read_proto = {
 	.arg5_type	= ARG_ANYTHING,
 };
 
-static int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset, void *src,
-			      u32 len, u64 flags)
+int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset, void *src,
+		       u32 len, u64 flags)
 {
 	enum bpf_dynptr_type type;
 	int err;
-- 
2.49.0


