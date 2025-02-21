Return-Path: <bpf+bounces-52218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 267A6A4027C
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 23:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 819EA17EBCA
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 22:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB9F254B09;
	Fri, 21 Feb 2025 22:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aS+njBc9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5EC253F1C
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 22:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740176053; cv=none; b=tbkw51/CD2rVaM7rjzcuR5ZKXyCPVorbXspDPFppJom3eGIVuTe0JbvWZ8x1xeXqAtrsG1Lf50rOYx0D0zJ+3BVySi9Njm22IE8nN3ybT4VZV8AI3vpMR6YCU6c6m+7XneavN0zSMYiy8ih2bRm18R72Ys21HEgugXHvxfdxP2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740176053; c=relaxed/simple;
	bh=Ygwc2D41ymtMAAbVJXhc78CltmObejr+JTpgXxGtkOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRYzfG6H3pWGPR8bN4EpIWYporj9UziOmlM09ILp0KX7LVgMJhBndt6zICiaqbIyPiyvIXMX81cG4CtaFORIeT3oLpg5lLA8dIXc/S0VvA4Vll1+Ana/t0SlZtGVoVkShf+JuPv/tw/AJ1omErxLWgL8g/GIcIMdDncXB3WLBZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aS+njBc9; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so18082475e9.3
        for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 14:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740176049; x=1740780849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fw0wPlPb9YgMeKJoz/JvQyduRzfrBwTB0MVE63lyzHg=;
        b=aS+njBc9/Hur6yLGLn+0CtUTzw+XdI0d7oYxWhYg1DgBl11qCMwOk6r2o18fzSKaDZ
         bUti3mE9jktO/yMacuTxRgodskLx8N+k3uGn8/dd0qTDP3lyeIjbzn2Rla4LQxLgPDpJ
         QpNC+oYz7aAxRgXzGpL58BvwsY3yl0gH1OoJKzKlptoHnanWYlEIZ76gJU3id0iV+OX6
         lAL8l0pHyLZdbCN5UidSC1jpQGLHCOhoSB6pwDPoloLF95jW9B63NBkuzqnm9g4SiGKd
         tg8SYdunhWxuAiE3Ba+UzVi8LNoi0Plb6qzRmzW0y8s4HsmMQRItLUOuevoeEeEorst0
         nu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740176049; x=1740780849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fw0wPlPb9YgMeKJoz/JvQyduRzfrBwTB0MVE63lyzHg=;
        b=FI/W2L8pG+GM+KNpVXQKNh1cmiGoqnaluGnFsm3M1ljbBROmOdZ4aNgDJVN/GqTGCT
         QXr4bfyRDNqZqv3xd75uiI1yPPfYgGGp1XwoHzQ9CsWf2euJMTo30D1Ngsbiy4+IqMqi
         p6sXkFOrb6J+vQhwlBlTSKjnYj7T4Zlz9NTwzM4L9bR1LsojX0guPmfWhhLG7yVTiWY8
         UGMN0juLISaFizukAfXmCQ231TRtfr2DlUhQgSx+htainIn3Nwe49WYIOeCjUt2LImbM
         XtbI3VaMjVzjpwg1laVUgeTrSIMwEX5JGmTqWF2NofRlfsE/XYrrMj58ZXwVNPm1i7nb
         fnGQ==
X-Gm-Message-State: AOJu0Yxvbn0JEzfafPkPa05FW1cfbd1lqmQ2u/aYI+V0rIn2W+JvXozp
	N2ZiLbNJL2zHkYMLE6wTuw22Lp8qERf6h4X1Dabf6Ney7XQeu3+biFtHHw==
X-Gm-Gg: ASbGncv/MsRDQfR1lgG94BLAa2A+D3wWwj3kGLa4l1No9nORiilBI3m0/ZEA5dWN7l5
	iBpOcKT0D46m0cGsW04UO39coOcX9vzKOOKlVRphVjIWTIlYiNWaUn235GLZ2a/ZTWgLaObd8jP
	cqIzGbNpgiqbKRjqsIEPOCY2L0OYwnxFOmQL1WZYL62p0gRtOXJkar6sVCO4cDvXrhAvuD4XzTK
	VHbYoBIHVMdHAH4vjlP7m2fRezfIC9jaUGaBCBda4xzBXcCF3Tb8LUUjFfnGSzsnXgSpEjimPPt
	SI1kd9I/pfVTOLdXJr+3YzHUW3DTjtHNvxH3VB3jdkG5UI9PAF1y0pRTW5NHp/L1Ppld525qCJF
	FWTRATpqnYazG/YcIhpO7VPCmB77eJdg=
X-Google-Smtp-Source: AGHT+IFWBC0DI+AxdQZOaChE3aRZBmqnRWEOS4swjZnzYsP5awSldZq5BuhuVnw8LVIZWlrzrlCuFA==
X-Received: by 2002:a5d:6d82:0:b0:38f:2b49:7bfe with SMTP id ffacd0b85a97d-38f6f0ae7eamr4861682f8f.47.1740176049465;
        Fri, 21 Feb 2025 14:14:09 -0800 (PST)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7fe6sm24070707f8f.86.2025.02.21.14.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 14:14:09 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 2/3] bpf/helpers: introduce bpf_dynptr_copy kfunc
Date: Fri, 21 Feb 2025 22:13:59 +0000
Message-ID: <20250221221400.672980-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221221400.672980-1-mykyta.yatsenko5@gmail.com>
References: <20250221221400.672980-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Introducing bpf_dynptr_copy kfunc allowing copying data from one dynptr to
another. This functionality is useful in scenarios such as capturing XDP
data to a ring buffer.
The implementation consists of 4 branches:
  * A fast branch for contiguous buffer capacity in both source and
destination dynptrs
  * 3 branches utilizing __bpf_dynptr_read and __bpf_dynptr_write to copy
data to/from non-contiguous buffer

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 55 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6600aa4492ec..264afa0effb0 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2770,6 +2770,60 @@ __bpf_kfunc int bpf_dynptr_clone(const struct bpf_dynptr *p,
 	return 0;
 }
 
+/**
+ * bpf_dynptr_copy() - Copy data from one dynptr to another.
+ * @dst_ptr: Destination dynptr - where data should be copied to
+ * @dst_off: Offset into the destination dynptr
+ * @src_ptr: Source dynptr - where data should be copied from
+ * @src_off: Offset into the source dynptr
+ * @size: Length of the data to copy from source to destination
+ *
+ * Copies data from source dynptr to destination dynptr
+ */
+__bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u32 dst_off,
+				struct bpf_dynptr *src_ptr, u32 src_off, u32 size)
+{
+	struct bpf_dynptr_kern *dst = (struct bpf_dynptr_kern *)dst_ptr;
+	struct bpf_dynptr_kern *src = (struct bpf_dynptr_kern *)src_ptr;
+	void *src_slice, *dst_slice;
+	char buf[256];
+	u32 off;
+
+	src_slice = bpf_dynptr_slice(src_ptr, src_off, NULL, size);
+	dst_slice = bpf_dynptr_slice_rdwr(dst_ptr, dst_off, NULL, size);
+
+	if (src_slice && dst_slice) {
+		memmove(dst_slice, src_slice, size);
+		return 0;
+	}
+
+	if (src_slice)
+		return __bpf_dynptr_write(dst, dst_off, src_slice, size, 0);
+
+	if (dst_slice)
+		return __bpf_dynptr_read(dst_slice, size, src, src_off, 0);
+
+	if (bpf_dynptr_check_off_len(dst, dst_off, size) ||
+	    bpf_dynptr_check_off_len(src, src_off, size))
+		return -E2BIG;
+
+	off = 0;
+	while (off < size) {
+		u32 chunk_sz = min_t(u32, sizeof(buf), size - off);
+		int err = 0;
+
+		err = __bpf_dynptr_read(buf, chunk_sz, src, src_off + off, 0);
+		if (err)
+			return err;
+		err = __bpf_dynptr_write(dst, dst_off + off, buf, chunk_sz, 0);
+		if (err)
+			return err;
+
+		off += chunk_sz;
+	}
+	return 0;
+}
+
 __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
 {
 	return obj;
@@ -3218,6 +3272,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
 BTF_ID_FLAGS(func, bpf_dynptr_size)
 BTF_ID_FLAGS(func, bpf_dynptr_clone)
+BTF_ID_FLAGS(func, bpf_dynptr_copy)
 #ifdef CONFIG_NET
 BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
 #endif
-- 
2.48.1


