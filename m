Return-Path: <bpf+bounces-57804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0742AB05CC
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 00:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84D0D188236C
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 22:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED15224AFE;
	Thu,  8 May 2025 22:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLoII1/O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A38F2222BA
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 22:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746741995; cv=none; b=GlGJ9xIdIWUkJ0lZj+CipSXnqnfbUMga9/+srrtxtKnlFxTA07YbVSpSEAmnrBhO4khpWDT/+A5xVUZwK+cnLBsj40Iy3e0g5hFNw62970/Wx1VR1/9mmz6zoi+40PDk8iUhByai7rAoTG3QgcXHx1aUpQFTzu8jSkG3PoWiL6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746741995; c=relaxed/simple;
	bh=iO3dkpXs3uWso+WMhG4Ia0xHxAiIF63HXihDwd4Z3YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMf8lTpC06l+T3I4Sx5nDmkAii5DzMeZMVpBi4ta0rUrIVoQ3856EN/db7AJraYBMmVgAyO4jyJmMkw8IqeZzjkJE5wpECKYwo+MPkqCCHN1nkAxlZxQ5WRanI3ZmxhEjJwfCdbwSQin9jyYfVxA732HVaeA5ZO2qQl8khvndsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLoII1/O; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so7450275e9.2
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 15:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746741991; x=1747346791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzxivtoutCO22TrB44w34clNR6wY9NwXOLdmHgLHh2A=;
        b=WLoII1/OLGIaDkUgaomg+CcWWCEZRyTL4SO3l4Su917N+In+y0J+C0iwFfGFF+E1Nc
         MY3QkMTutaH4JVV1eMWfnBULBFwdLYElERllZ0z6Ev0V3Yk9zJZXSNfUIoZ8NCLpm8r+
         Jt5Hysy+9mhHbIhFfOb/v9cLoJQTqjp1cjyv0XSwFw1oo+ztwvfanhaZMmGwQWUv6+Pe
         vSw5KWrL3WBj6spoeAkWabplHQJJGzl0BQbU2ats04NWyJbxipC/7PF6+mFU2DOkD38j
         3ikwRK7+YQJ+NkRRM8i15NdzMW5baXdGUAqGxgKWZ/1S/0XICsL0BFYxG/bLQMJE9x0r
         u3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746741991; x=1747346791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzxivtoutCO22TrB44w34clNR6wY9NwXOLdmHgLHh2A=;
        b=m8zP9iZH8JaSSXEGKalDpLTeXcuOMVQfsZ2zQQ6aKcxeSu7PWPZXLAZBBIl0DAQLKN
         HRnh123WVVpDf2CGI7G1EITzMbXvhO/3RWP6HYetS0tf3wCvxAw6OD3nJI0U8AqzZaRU
         LvrRs8q3+sJVCvbYXZTJXkZU0gua1Va81ytcStwaeRxetPOL10KrNn8GroTM9DzK+RzF
         l/SyJLxhrXg7F88YA/RobRBRRPKHnXMr+JP05Q4KtnDN375nGJyUUurLa1YNpmPD8p9t
         u5jtKTevG7cC9DQnYPSTocJvHYhYzw8CngVAE6GnFIy+AgPIdDMgiTy3o1oK71DNaqfp
         IiMQ==
X-Gm-Message-State: AOJu0Yw0JN7AbSUonBrwAH+GUq43RC/RZ1lGPFftNDijN5xW+1RKc/TK
	U3XLYxlbf39/ymT/fAUeEczFLLzt2c3WXRNpBGIH8LaRZf7SMR/MTfaqpw==
X-Gm-Gg: ASbGnctAbhPhnoBUtBpY9Qa4EugJw9GAfwSMSYCZ1cKt8MfNhwzlPneGwoatBbNwUlD
	kCCaSIEjScWvq+FhlzMXh4EYZP0Tmxr14iICYH192PyN8VtQPSWuM6XwKBvgAftc8qgZXu8aDhT
	NoDhbWxKvW5607DsKrRLPUj2Y3Z3w7IZn1pLQA39bMA2fjdux03PkdFyn6FwNI8HqYTE3IDW2hx
	U4pmED7Gu9yFaBqE21bEQq0ldAK7ojEVIj/9+kHBcK8ACgcJ/lbdSNxag0GW7zyrMIaUdl6iWZ0
	BUqyU/VOFpTAb2RPj1bOJc17Pg/w0wrCDucr0SEz7kh/R+7XNxdVPBeZJ5lVwXmi23SJfw==
X-Google-Smtp-Source: AGHT+IEgK23OI5DCvtNg/COR1MabyWxJ68Uk0D+8wnYLV1CR8T4UK3l+/2KgF/KKDEzsm/ZgbOLzBw==
X-Received: by 2002:a5d:64e2:0:b0:3a0:b8b0:4418 with SMTP id ffacd0b85a97d-3a1f64a2ba3mr876229f8f.50.1746741991364;
        Thu, 08 May 2025 15:06:31 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ed0a5sm1168830f8f.21.2025.05.08.15.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 15:06:31 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v4 1/3] helpers: make few bpf helpers public
Date: Thu,  8 May 2025 23:06:22 +0100
Message-ID: <20250508220624.255537-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508220624.255537-1-mykyta.yatsenko5@gmail.com>
References: <20250508220624.255537-1-mykyta.yatsenko5@gmail.com>
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


