Return-Path: <bpf+bounces-57775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FA7AB0134
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 19:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45E41BA4E3C
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 17:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA62286D60;
	Thu,  8 May 2025 17:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRXbz16J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACDD2857C6
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746724710; cv=none; b=DWAZptFhq0oNvZ80ybC3Ao94Hua6wenqhdJ2mTjG75PC/nX4tHVOQD/s49zlJITMjMg8QV3yPzvNUTVhEb+5Lsfb+vpcyhPgY5O5c9NzzQkUCPWyBC3sdx521mUV2zlgJSFjnGTOhfay8vdhTo0eR7xdUgiCKHnDx7YGTg2RDLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746724710; c=relaxed/simple;
	bh=iO3dkpXs3uWso+WMhG4Ia0xHxAiIF63HXihDwd4Z3YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjXqTOT6SSg+wHml4+5m99u/JTj+hbHinTK+DYlsrmKmGoDpIaq4j3tT0LZO0pB5jHStPkj1IBPtyX6VU0abaBGRkmUXw9qtgjiyS1SCtSBmSex4+xG5WGWCLOQgw0o1B6BQkHdzEE6qU2hJZzCylZd1p6tiFcYDCkTVk5Ix0JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRXbz16J; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso8090025e9.0
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 10:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746724707; x=1747329507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzxivtoutCO22TrB44w34clNR6wY9NwXOLdmHgLHh2A=;
        b=aRXbz16JMAIRcBwwlPrB7zcke1egOJQnScXyeMHvZToqHZEa0iNehLPZTpq91lKG7t
         b2qxexSFXe2nuSYch2eY/IZT915Zk9SbkIMkLfTGfx4T+rIl55nQuYg48sbuVPnIJtue
         rwlPsZCZQhIQjgl7Uh7B/iM3J06qpp2EkcMrB0URZsVe94VkjubhsyoPOGBDuj+sDPSU
         IpgwFJUKduQ+cHmllsFzSfRgb63mnuNHfb0ZGN+11mqmTf8jyfMm3aJ5pia9+u1stXMp
         QIWUvXNRwjcGqRHRUyDZvDh4uCmXdUIa1dd0I4A9vmqTlLhO1zQC7JtGgfQKE3Ko698I
         Gb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746724707; x=1747329507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzxivtoutCO22TrB44w34clNR6wY9NwXOLdmHgLHh2A=;
        b=HI9aCT0vSqDRgZfedK8ac3NKo+Igojdv3FDk2SAc5vQzZ2IqDGCUtboH2oN6HtPUWZ
         eCNbeiYjEsu9ASyJaGwkFZq+bg7thXGG5ebWsitNcFLc64ex9XWsm9tVJlkFhTfeLHN4
         caPshaPemOaGCMDWNkY4+fyuHfdpSEkZln5rbo9mPHMTR3gffOkpveeOQbcU0t2na20T
         ERmjiklE5Nabg4ogTZnA2efuPWMg3njjy8q2knwQ/plbyM9moWyxDCyeVB0q66YWiNuX
         ThbwDqkV7B151eXi4jnHAmxE1YlZDKkc39ZQvmj3vQUJYYPXnnbRFwxb37wIid+G6DCw
         Gczg==
X-Gm-Message-State: AOJu0YwC5LDKe4fGUJ/VpZef98Wa+fJjoEoLMhWX5FxHGDnAyjLf7sKg
	WmVBlI6hbh77K1omZydtl+tDYZi5GCh8QfQ6XBcor41BGsOsrWoixBMugg==
X-Gm-Gg: ASbGncuGGcPSk1L28SJQJqM8/32RdUZFOutQVTVg/Bo7QzSdpFVbm5qEd6Et5gXNjiA
	4xWa7gBVZ3zAP+xx0WoxIfb00d9HJLOswfTjDSYNcPBiL02RsQU0xRs7969mNLP5XFXtoP58XWe
	vHPOUjKsbQmTxe7zzGwxo4oWXA0BOGyJ7zXWD0r317WU5zQM9umBsqMd0OSIeL06TP1yvGbQCyB
	7lcpjcTF3z2+c1YWnhNkJyP3JOTabrwxvKM767EZk7lQL9eQctzCYgoM8ck4/VWGiCH1e6TRtSX
	PvfzygL6g/7C2nwkZgTRfTPs7GJ42X1h/97QzmbkD0JJWG6f7MvbIuROXR0=
X-Google-Smtp-Source: AGHT+IGuZQCzJ9gccG9544tJopiT3wihbPa2kThWQAV8TE2aWauWkj8xcKRfkp3wdk6nJkjkCGPY5A==
X-Received: by 2002:a5d:5885:0:b0:39c:310a:f87e with SMTP id ffacd0b85a97d-3a1f643126bmr307126f8f.16.1746724706958;
        Thu, 08 May 2025 10:18:26 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2d2d3sm528261f8f.63.2025.05.08.10.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 10:18:26 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 1/3] helpers: make few bpf helpers public
Date: Thu,  8 May 2025 18:18:20 +0100
Message-ID: <20250508171822.152266-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508171822.152266-1-mykyta.yatsenko5@gmail.com>
References: <20250508171822.152266-1-mykyta.yatsenko5@gmail.com>
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


