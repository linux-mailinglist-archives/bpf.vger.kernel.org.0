Return-Path: <bpf+bounces-57271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0430AA7A04
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 21:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5BE3B3924
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 19:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0AA1F03D6;
	Fri,  2 May 2025 19:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROy2uLT+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F93A1EF368
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 19:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746212788; cv=none; b=lKdMnU+yByZ47YI0idT/JSx2RjwJMFkaynMvEGViPQb57ZwE1OYtdzCyjRFGzLmgo4t5tAgZL2IPdp4B30EjXg2h1VCsClMcXWSjZE4B5ZFEQIcBYrnVyGGMA6CRG7IvpPDSxmVASRwp2+Kgwi/p+72PtfKQuLy1+KipsI4heqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746212788; c=relaxed/simple;
	bh=9Z28ev1XOUryNIZyVFpT+xDlck2tiX24jQlNvDaLgkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7lPF8piPArm5rgGOwYMFOEzaoeQy879JruUYlSS4gnq0rka25iyQmhrKwCTTdIX+flvaKJhCs2eGxa5fvIhDpePDHi5erbZxTxbiIVCvfEnEvsqg12x+qCkSEyKP3k6PIDEXp+5ClfLTWZWic5ork5PJu2mnXibwUYYSBU8HS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROy2uLT+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2254e0b4b79so37978545ad.2
        for <bpf@vger.kernel.org>; Fri, 02 May 2025 12:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746212786; x=1746817586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srLyhtDjFyOvgs1XLDmNidEP7PjF6DJdiJHKzfM05So=;
        b=ROy2uLT+spj88tNMAdUD+0EjikBJjXlDzWpJVqeEbgTRaaic0bHP9K2a4cCm+rZ2ZB
         GphnbrHw7IZFvmi8nNIvS4UBQwUntuXWtbx9MocSEPCNm1cqmPGvKkdSFlVJX3wlt0Dk
         fvnbj9+xVDYUWARhwb27yMWCvNEYbJk3o8wsnMrkuW2g+6yJrqcSRDnG+fNaoHQmOvOc
         gD63mvbbvZCgGog4+PANNRHhFWpy20iS+IjvOJWFYF2Di9wIUsbD/igttiXxTght1q36
         IIzMrQvdXSBmtPkHHXYB/bTyZx2d8MYkXSyLX51XcY6sVnBWL+pAD1P64+aLULCx2cOz
         38fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746212786; x=1746817586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=srLyhtDjFyOvgs1XLDmNidEP7PjF6DJdiJHKzfM05So=;
        b=UlYwe1JWvEwyT1LuVj4ov6SCQj2p6lqsGijSNTMYizwrRG0i/GA+rwQP8YJMq2QgEi
         fu5Hi2XQ7694Zar4IAO1/2VVWMwRFM1HhiHQxW7JsJWGBL8xEMXxaNZFRNl/ZgtMMjPH
         eQFemtS/yT8I3vk6mt1dTcpzrxCqvChPYEvuq7VPGyGYdrDjsmDVomWkeBBByCWD/9xw
         pgLtxlsrLwQOTgX+FbOj9RepOyslrm0UtoRxWAG4UPuLoSsgAF2RIZvbtYp17MJYh6/s
         LFUAYq2JNSyCXHFHUmfJBI3U76uNJ13raOh+ft0kljY3yfiFErRGiVGAF8kcmaf9vpmO
         s/KA==
X-Gm-Message-State: AOJu0YzHs/9iXwfGW6w2ZINK/7N+VJXlBKstf5HGkoGdL+crXswnPXta
	0WwYHuwB4N8GN/hDsISNrswvil5FRKzxG/XMwrdjHBpR5BS3B2htNmMEgA==
X-Gm-Gg: ASbGncvbthFA7y2+isONaxVrAKZgPUF9UzxjT7a59IkZ2FjxJjtJ1JT4jfsbNtHqvmP
	8vE7i23AWx87dEEVtLraDQDwfykssW9oCerdhoKB37F42YacDifwYfauWjF1MGWMSuYQwyHUDFg
	vUxz77xVPd+MUt5ZQGOzY+aXnjshrHgCVJsSahOp/ekYlW0+LxUD+DqpSuNMhie3zrjC34A8dyE
	cyo7h0uXfzV7Hr+fhL2uQQi2I++xLys1JODSXAMVB+9g5T6Bi2H8p3Zd0zUjTBBfxX/ubm8gFfe
	WzZT7g97PnR3Gz+augz75ils23ZZgtU/JIHJEHtRalm3JRsvcBfrd/8=
X-Google-Smtp-Source: AGHT+IEOK37nuSeX0AgWAuCwquloceE1OovJZtA+mLSdcxFEMZRZkx3XxKrNQ+Xf7rYReqy3M71ADg==
X-Received: by 2002:a17:903:1aec:b0:224:24d5:f20a with SMTP id d9443c01a7336-22e1036a4e2mr78690305ad.48.1746212786464;
        Fri, 02 May 2025 12:06:26 -0700 (PDT)
Received: from msi-laptop.thefacebook.com ([2620:10d:c090:500::6:9b40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e150ebfb1sm11426265ad.11.2025.05.02.12.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 12:06:26 -0700 (PDT)
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
Date: Fri,  2 May 2025 20:06:19 +0100
Message-ID: <20250502190621.41549-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502190621.41549-1-mykyta.yatsenko5@gmail.com>
References: <20250502190621.41549-1-mykyta.yatsenko5@gmail.com>
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
These functions are going to be used from bpf_trace.c in the next
patch of this series.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/bpf.h  | 7 +++++++
 kernel/bpf/helpers.c | 6 +++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3f0cc89c0622..14f219921b4c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1349,6 +1349,13 @@ u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
 const void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 len);
 void *__bpf_dynptr_data_rw(const struct bpf_dynptr_kern *ptr, u32 len);
 bool __bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr);
+int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset,
+		       void *src, u32 len, u64 flags);
+int bpf_dynptr_check_off_len(const struct bpf_dynptr_kern *ptr, u32 offset, u32 len);
+void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr *p, u32 offset,
+			    void *buffer__opt, u32 buffer__szk);
+int bpf_dynptr_check_off_len(const struct bpf_dynptr_kern *ptr,
+			     u32 offset, u32 len);
 
 #ifdef CONFIG_BPF_JIT
 int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e3a2662f4e33..2aad7c57425b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1713,7 +1713,7 @@ void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr)
 	memset(ptr, 0, sizeof(*ptr));
 }
 
-static int bpf_dynptr_check_off_len(const struct bpf_dynptr_kern *ptr, u32 offset, u32 len)
+int bpf_dynptr_check_off_len(const struct bpf_dynptr_kern *ptr, u32 offset, u32 len)
 {
 	u32 size = __bpf_dynptr_size(ptr);
 
@@ -1809,8 +1809,8 @@ static const struct bpf_func_proto bpf_dynptr_read_proto = {
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


