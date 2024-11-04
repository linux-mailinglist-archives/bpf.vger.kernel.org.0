Return-Path: <bpf+bounces-43872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5508E9BAC4B
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 07:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95D45B21957
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 06:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F67518BC0D;
	Mon,  4 Nov 2024 06:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSWywyYf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C6A44C7C;
	Mon,  4 Nov 2024 06:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730700198; cv=none; b=XRrWk9zUKzf095doxunt+CaM63Yb6NVB3fkVsgyTX2NI54N1r7SplFqq/1ynuRTPpxosJkghiXmumHioen/RHNsxjtsJRNjDslpGPACgd6qIa/jjxLKolwlcbZ2vtgBOwEe8LRW8tOouXN2HY/UFTLuNbDf+kHLjUBDyc+MZyYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730700198; c=relaxed/simple;
	bh=LYggjXp8GpI7PJACx8O6aW9vqmCc9mul1sf5sv1Dh2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VP0Ji2pRajR8p8WNPZF5FDcWOCZie5/k5Eh6uoCkNIJXTYWEdSwHRANds4gglGI8Q98vhn2026rjZyhSoZKpIaEzJjgQa0fTD6fnfadzpY0OpdwlS8/mNwh0Ocra8dxCuZv4g7mJ6Rz1b+wORFUA8bJvq01lWvHX2MPumWamHrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSWywyYf; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-720d01caa66so2071683b3a.2;
        Sun, 03 Nov 2024 22:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730700196; x=1731304996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KiZG0fOXbzw+JLuxFaDRadC36mZ9plHKuKs+rpTWCms=;
        b=MSWywyYfGBP9SqB9M5D0SwrO5h3NqRJb7oihIvIIRg6/GrSgmcEGVAypDERSAEOpkP
         OmaMvtCpPA5krZVVUBuHA620gfG2FvKCaozDKelzrmDbU6FFJD4mhh2FGQGCaUxLNYBL
         tAuEh0wjr15R9S35DOddKKcppLbySqV7NXOMCc1vOkVsQsPUA/pLp8FViAzBw1bIwnJ9
         /iwAfNHkX5+m0mMRbRwZkleMxgkxRDBe+Kq2SLTyiTK8erNBnGPvy6oWTnOyZJ0gR57X
         9WDM/a6lNyf08Telv3WCwcYtKKqcTVVpyMnLZ6WQFcgdBMedvJfSOqtyCKaNm+tmEvZV
         VhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730700196; x=1731304996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KiZG0fOXbzw+JLuxFaDRadC36mZ9plHKuKs+rpTWCms=;
        b=bff/QoBKUCzytmuexPZjZZis4MA4LrD2VTzaAxOJ93M4d0UYoleLWuSUPbwWlwkIj2
         hbxJvgfwTW3FBJl24PNRDdRMo9fGIXFIJ7Rt2+sjo6eJtlk3Jhrv3m9e6f4+UuJI/uM2
         tC0rRljcolN/9/wpQNVZSzGYj5i1FPsf+pu9WaHziHm7B3cD0zyEyBcKkzMZsSwEPUSz
         oY3E/ZGcJu+Y6bVO/LGuQ655uLbbjJvx3gQKpYsAX6A69AJM9ZJtm4UqRzht73W5YME2
         HGWJS+oOK8eVJrJneN/Wggg3o0Xxg1Wf+2/KjyA7tdR4i/gqpOR5zNG79vsUA+PBeIk/
         JKFg==
X-Forwarded-Encrypted: i=1; AJvYcCV+X/WDLdUFAyZMRIEttbD68eD7w2/LDMPboB066RGJvHS9NrWxXmlA2p52lzrhvpdZetA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr4xvcDCRWQS0Gxufrv9bF0NgJ+06xJ4NTekYFc60VmFCeTaox
	sLeKcXCl6jXC3tXztb12Xseddi6vUvz6h3+am4LxPR9gu6o8BFOqIlIYTQ==
X-Google-Smtp-Source: AGHT+IGf8/Xx+Lw7g03WO/cMC8GgPsRChEnGhXnsp5tnQP765kRwaDjrSb+a3Wd926A0lWJnoctOwQ==
X-Received: by 2002:a05:6a21:3213:b0:1d9:275b:4ee1 with SMTP id adf61e73a8af0-1db91dbb5d5mr19974660637.24.1730700195695;
        Sun, 03 Nov 2024 22:03:15 -0800 (PST)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee459f8f9fsm6149123a12.60.2024.11.03.22.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 22:03:15 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: jolsa@kernel.org,
	haoluo@google.com,
	sdf@fomichev.me,
	kpsingh@kernel.org,
	john.fastabend@gmail.com,
	yonghong.song@linux.dev,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH] include: btf: Guard inline function with CONFIG_BPF_SYSCALL
Date: Mon,  4 Nov 2024 16:03:00 +1000
Message-ID: <20241104060300.421403-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The static inline btf_type_is_struct_ptr() function calls
btf_type_skip_modifiers() which is guarded by CONFIG_BPF_SYSCALL.
btf_type_is_struct_ptr() is also only called by CONFIG_BPF_SYSCALL
ifdef code, so let's only expose btf_type_is_struct_ptr() if
CONFIG_BPF_SYSCALL is defined.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/linux/btf.h | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index b8a583194c4a9..66a816ba4f5d0 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -581,6 +581,16 @@ int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_ty
 bool btf_types_are_same(const struct btf *btf1, u32 id1,
 			const struct btf *btf2, u32 id2);
 int btf_check_iter_arg(struct btf *btf, const struct btf_type *func, int arg_idx);
+
+static inline bool btf_type_is_struct_ptr(struct btf *btf, const struct btf_type *t)
+{
+	if (!btf_type_is_ptr(t))
+		return false;
+
+	t = btf_type_skip_modifiers(btf, t->type, NULL);
+
+	return btf_type_is_struct(t);
+}
 #else
 static inline const struct btf_type *btf_type_by_id(const struct btf *btf,
 						    u32 type_id)
@@ -660,15 +670,4 @@ static inline int btf_check_iter_arg(struct btf *btf, const struct btf_type *fun
 	return -EOPNOTSUPP;
 }
 #endif
-
-static inline bool btf_type_is_struct_ptr(struct btf *btf, const struct btf_type *t)
-{
-	if (!btf_type_is_ptr(t))
-		return false;
-
-	t = btf_type_skip_modifiers(btf, t->type, NULL);
-
-	return btf_type_is_struct(t);
-}
-
 #endif
-- 
2.47.0


