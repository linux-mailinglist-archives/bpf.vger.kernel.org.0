Return-Path: <bpf+bounces-78135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4291CFF88A
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 19:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8504432DF3B0
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 18:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075D4395248;
	Wed,  7 Jan 2026 17:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdy+a3Wq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30013939D3
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 17:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767808184; cv=none; b=NIusSnZa+o2BCqkkg9ETrfw4p5rTc6Sf44Jkzbbb5eRHEnKmpco0LhZaOaRr5Twowsu4OwKPx4NUchq1eUPGDQVyG0aE5qkiQN0SpU0tfwuzs2I5p3uOoznfWzFJA/kRBCH5eNrX3K6TFHVevuc/V1WU7NjAeTeWZbS8g69DrI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767808184; c=relaxed/simple;
	bh=Pc6P/PYjO8KMWDfz1MBVGm6uoKEQEoukksWlkWKB+G8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RDEQ0KKKDCcym8IlCWfW9ltcQjsClHs94cgJJFWDpycWF8AVcZ6MTw2do34DGheBGqpC212ld2SdKb7kFYvqe3tjvK1+I1DVpIXFEznxkBktfpkJsOiyvh3BQX/Tr69MSyR/dHILaZJhjyxIfX9judZil7xCTA7QJE1860CFUYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdy+a3Wq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4775895d69cso11805465e9.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 09:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767808176; x=1768412976; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1g1Sw2AmkZUO2DK2UwhOuTvNWBCihFYVWTXw0+VK0i0=;
        b=bdy+a3WqPjchUIDGF9LV0zBpoUJOeim9U9LVDlwNXXdGLaHcT3TbzH+OMQzct6fG2v
         8SK4NYa2dp+vLkI///wyGxKYv+4NJgJV3MZ9fClIGfsQRoSH9CcMdiXaCCdxf9TnGfdD
         eHtP33CQMR0QdGE4E4nY+D6g7flAcio7ecrkXwwZVykbLwTT+ZoaBU5Sq3sdIMwEoU6G
         kPMxn9bz58HjMr/aX/6z1+YUXg3FSp/X12jiYFgdhbJOzZHwRbQssGQnCsGqaSC/x51+
         /vLCwHsS6g9EKlqfBsRuT1zZa25qpe8CslwBAFW1dnY7lXzILs6B3CbjqJne3P2daMjh
         Iisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767808176; x=1768412976;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1g1Sw2AmkZUO2DK2UwhOuTvNWBCihFYVWTXw0+VK0i0=;
        b=lSTUpkVMezz88fwWhasG2Q4dLeo3+oyoaFthAty+I2mazMxC2YRjBYdceWq/FFW50E
         AvWjrnLchhEL0xQP1O6z7yfYFRcJsZUygEAY/H+L4GRiWMyzDYASZCJsss4fQgMaYkUv
         j1kavT+rdIvPv5/amFVjgraKUdG/P2FkTgDRqHL+I0WE3gOnOMQULLTQgT6xWY3k0L8V
         9dGS/FNxYimtcO5JCltsgqr+QEQH/0/Oz1bUxDaUEBwksX7NQnGRMShhp9ali95CdCWX
         hKx1pvyFV/Oz2TxpSrRaLP5CvWSQv83yqJfVaUW58eHTzXALSNlx7HMKrXxcdSgXlG4f
         ILNA==
X-Gm-Message-State: AOJu0Yw+DiwuYK4VTicDtp7U7QwZTuP45fRUbGYN4hFwBilK8RuDcGi7
	IYRxoiT10EhhjKTg7Rl4ulxJrXWcKvA3feMm80mT14LUJcmzkUmLhuFc
X-Gm-Gg: AY/fxX5BYvYVkfxq8qwYVfreUM5aWZWUrohbamUncan8n/tZGT1mFchjPaKA3B4lftF
	KMmzkMSA11efj0j4XFeEFa4fppaMa/GlC5BTzy3YxcS8Md0ZIQ4JUPKg0IFjcp9hHOyoX47nUku
	kfx3hGubnED348M8SCYdLOhmul+AJvxfEiRXpR+Yj1taQM0xUhkum/XXVWwHrGBVqG5RTEGPsCL
	jUy/JDEIApFzyxHX8oIP5DgtImDRd8nM6G4raedJi6PigZIZ1PlScarQykqrgD/+AtbFZJElzLc
	wmjQ13RmSXjVUT+j33wDW//4KJ/yXefyxfXWEh3H7ox/La0Vi+pot4ctZ7ytVaYw/lXWXbML+9v
	Wa7SXU1Ng2XwU8G1offJ3hAVeBzWB40pTKgbwruxa9kMTC4ZMdSQo5CSvldb8bChOJVU=
X-Google-Smtp-Source: AGHT+IEjQQu9EwtbUbdvv9ZDvxDg1tJ1xMqUgHqvm0tOpPUUU1P4IaNNdUHLv/sAWIbyXv18iD4SCg==
X-Received: by 2002:a05:600c:3b1f:b0:477:8a29:582c with SMTP id 5b1f17b1804b1-47d84b52b9cmr37902725e9.34.1767808176542;
        Wed, 07 Jan 2026 09:49:36 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::5:d4be])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e180csm11363797f8f.10.2026.01.07.09.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 09:49:36 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 07 Jan 2026 17:49:04 +0000
Subject: [PATCH RFC v3 02/10] bpf: Factor out timer deletion helper
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-timer_nolock-v3-2-740d3ec3e5f9@meta.com>
References: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com>
In-Reply-To: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767808173; l=2070;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=xIm9/fvHIzPEBCpqIutLzyrTDpPbb1GumnGqBTb4NQU=;
 b=DnyWfxXa/43VhLHInMUamILg81phjVnZQGorlzuM4jjcG0b/yjStfsFhKqTf2YvDTRUtaw7jn
 QUx131cR1/WAybTnlW1EpotwL8mdaubX+rQi3CuWQHyNA7Bog+CZEQ9
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Move the timer deletion logic into a dedicated bpf_timer_delete()
helper so it can be reused by later patches.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 954bd61310a6ad3a0d540c1b1ebe8c35a9c0119c..ff3c1e1160db748991f2a71e6a44727fc29424d5 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1539,18 +1539,10 @@ static struct bpf_async_cb *__bpf_async_cancel_and_free(struct bpf_async_kern *a
 	return cb;
 }
 
-/* This function is called by map_delete/update_elem for individual element and
- * by ops->map_release_uref when the user space reference to a map reaches zero.
- */
-void bpf_timer_cancel_and_free(void *val)
+static void bpf_timer_delete(struct bpf_hrtimer *t)
 {
-	struct bpf_hrtimer *t;
-
-	t = (struct bpf_hrtimer *)__bpf_async_cancel_and_free(val);
-
-	if (!t)
-		return;
-	/* We check that bpf_map_delete/update_elem() was called from timer
+	/*
+	 * We check that bpf_map_delete/update_elem() was called from timer
 	 * callback_fn. In such case we don't call hrtimer_cancel() (since it
 	 * will deadlock) and don't call hrtimer_try_to_cancel() (since it will
 	 * just return -1). Though callback_fn is still running on this cpu it's
@@ -1599,6 +1591,21 @@ void bpf_timer_cancel_and_free(void *val)
 	}
 }
 
+/*
+ * This function is called by map_delete/update_elem for individual element and
+ * by ops->map_release_uref when the user space reference to a map reaches zero.
+ */
+void bpf_timer_cancel_and_free(void *val)
+{
+	struct bpf_hrtimer *t;
+
+	t = (struct bpf_hrtimer *)__bpf_async_cancel_and_free(val);
+	if (!t)
+		return;
+
+	bpf_timer_delete(t);
+}
+
 /* This function is called by map_delete/update_elem for individual element and
  * by ops->map_release_uref when the user space reference to a map reaches zero.
  */

-- 
2.52.0


