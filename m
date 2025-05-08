Return-Path: <bpf+bounces-57779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4677AAB016A
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 19:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9B4CB22C31
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 17:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1322798ED;
	Thu,  8 May 2025 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoVYpiyg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8931286D49
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746725195; cv=none; b=TcrAET6m5imTW5Pm0bOTjK8pJ/ldLtVjooXa2fWr+P/vk0TPCtQi7sZwEaO7Bjmclb3Em471R4sTtn/QYyJQLz45aaFPjTogfHa/cvtEIQ8Xs5OJBHKSXF5BNbrdBvqId4euaSJ5YOw3rJR0Wfmkh6SxSgr3FzfjRLM1+Ub7hEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746725195; c=relaxed/simple;
	bh=iO3dkpXs3uWso+WMhG4Ia0xHxAiIF63HXihDwd4Z3YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twNbtojhgQkIwQcHj8yUIIeOb+U3RaoXfKEn5YCSWAk+MZ+nXE/fp2tZNhO/wJYNDUbjLateXaPo7wYbGxKb/g/FyZhmhzmHrbRPn3wIgVLeRskybXroPSd8FFlSHXhVBhI6EspsxH4K0VdzS+E6UZGsZNAlUv6i/JUDg0Fc+A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eoVYpiyg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so8776885e9.1
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 10:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746725190; x=1747329990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzxivtoutCO22TrB44w34clNR6wY9NwXOLdmHgLHh2A=;
        b=eoVYpiyg1z5hj8+NlCVgs+Sc/Gw2zTQDw55Ad5y5VKyDn1IMqOUpTCa2hLQj9+u7lZ
         OFn8/KDoNwALPJm8SdBqANY21DA4UqQnUjEzeAXrHKQ7ol0k4BOtZdpJVRzG5qgE7Dvt
         lzQRFBNXwuzIgpfG3uXLZ59OIne2sAyLcQ8BLVwxegUZmlDL4tcTay5h7wcZ/uRbZdFJ
         qyEUFAn+iHlhCmNaiw9bpqBV4Y+KnxEs88dgYyL6pO+A3yTlaJe1npY/pWSm1M98i1lf
         LBCM4SUxoNNNGjH/mPeApZZ1Uttp/tCjFrtxrXNat+KYyx80uz/SSO04YTu/7QVv399h
         wvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746725190; x=1747329990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzxivtoutCO22TrB44w34clNR6wY9NwXOLdmHgLHh2A=;
        b=Y1bKo4PXgh/OlebduhSJzXNKYHozeve/l+j2oLe+STcl+lZqvt5twbPuQ9PE/K4Ecl
         1KHcJxsNADkOfoWkOH0GIMizFAO3U6hlpFrZ8s88eiZcJUODCSc9DY2lDAXxIbdlg/A4
         zEpg+M+G9QXthTI0SLb3p612KWprkigYk0AmLMY4BPYqdbc9u2wdk82EInhKp8YRQgLU
         ojk9Eb/k5aSHv2Wrrhk4/FtTV5NQVXUEykabnBF2czECxshVtpz9mlB3gxOFMIJSP7xX
         xZqF9emP7Db/MqCyQE+zN4QQNVVUxZmwKxbM9iCZqzrfjy4bZYTmu3+oSj8JFWAGnjVA
         jedQ==
X-Gm-Message-State: AOJu0Yxp2WsRce/lDl0lftIavdQehp3TRG5M5TvqychU7lf615w8d4Zw
	MPi0Rv3iOkdSkpTVuGgAZWz/RuMzoM7uIZANZmMgEsgY3VK9ASpJOKOttw==
X-Gm-Gg: ASbGncuTP56FIcFyZEc+V/QMkgJXNKCiGc+i4OyNUAa59DcOihtPtkrZttzzmIA0zlv
	ykVcr080jGUFOwGPCiC07CSLZ3T9YaaMXpgiFwfLp2n63eWxkCB9npEN+3q1iwTblUPB8VoBH8n
	uQwGVjyOUXNjN3YelDKim1NJRxnPp4gragb/ejYrzC/YCRttH4Q+99yllS0cCc2rrSLF2gvCang
	nvxQLRGcF45coeujJohEfUOp2/UPYbGymp4+9w7bu+RIzwBxNZScrShhLUONq7JGFZPIeecUiIh
	wv3qnL6RETtvy8ggguf6Ig9Xeg0WY6wNqePFj8Saov5m6u/YURfSOIGlVBo=
X-Google-Smtp-Source: AGHT+IGPq0pw+J7FFF9GomQLRsFqIzRyl5h/FSZP2zaNpj2XhR2kelD4zUKf7wrL8XcXX75tK3VOuA==
X-Received: by 2002:a05:600c:a00a:b0:43d:fa58:700d with SMTP id 5b1f17b1804b1-442d6ddd1f0mr885005e9.32.1746725189989;
        Thu, 08 May 2025 10:26:29 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d67ed1c9sm1800415e9.21.2025.05.08.10.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 10:26:28 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 1/3] helpers: make few bpf helpers public
Date: Thu,  8 May 2025 18:26:05 +0100
Message-ID: <20250508172607.158382-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508172607.158382-1-mykyta.yatsenko5@gmail.com>
References: <20250508172607.158382-1-mykyta.yatsenko5@gmail.com>
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


