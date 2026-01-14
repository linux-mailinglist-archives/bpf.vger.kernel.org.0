Return-Path: <bpf+bounces-78943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C60D9D20D19
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 19:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DCE530F7C51
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 18:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FAD3358D5;
	Wed, 14 Jan 2026 18:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSft12LW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373D2335575
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 18:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414988; cv=none; b=b7cz230551PFsjikYfXhJYWgg8Ka/bNnF65LztmA+rZPI50ECERcGmjgBfcx44JQ98qu1N1EdArEYj2DikAx9sjKfbWO6xVGCr5LwGYca9pDx14fwjb7PxV7yDpyBB6fOG1QRpJi5mtJR7xqtTnh4NqIcRrkyaNZ+wi8EKIZChQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414988; c=relaxed/simple;
	bh=W3d8gQg0QN0KkE2QIWAGpQFnRGGPBwiA5Z/l+bp9p/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ttUR+/czwGaTfKRKqBh9M+wtMqW1kI4VmcU5UkOR5bYz1lfhKBnwH7hsj90pKQaezbAQOeN5Z3Xg+ZsQezWDEunz6fkQPEQ8OvhKSStEfZAEfkWvxruNMSoEmnhCXbTXje1vQKfsjQaMYRcz++u/rzMjjLkrrVDlJDp0fdwN5uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSft12LW; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso1468005e9.3
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 10:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768414985; x=1769019785; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jwaw836ujBIm0+grtUVR9C4IUA9McWacj0EYjrR1yWM=;
        b=RSft12LWumin7jEAvmjXhj4pYNiCXguBxLf6kIloVujQm1agc7a1/BU119Krf176v/
         opdOqZMyVSpD9lURfvJI5IKRVs8UXQeDabfsLLPQJrXGhLaAPcuZDbGNoLABA3yOwNH5
         Mbg9fo5F04K9sJw0TmVl0Oi/cDf0aOTqPZXbxGoS2QkpFHak2Tgv0bIY8HFVq0cDeAWw
         2Q2WsUhN7a9anBbdJ03yGxCPYrnYvkN626HkwSgqwb/H4V2xQ56dYYSRFeM25Ks1q+em
         bS02s7LH78hJVU6oo3S/mlqYaRw2nFSxp6wgPfq1ElaDEHVkE0w3nhl30g0AzbLuotPG
         Ylmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768414985; x=1769019785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jwaw836ujBIm0+grtUVR9C4IUA9McWacj0EYjrR1yWM=;
        b=mGHlbQBK1E0Y/qkemG4iuBVCgSMHEc06kFbp5JF+xaVnt5tX6ybsG2xrKVS3+dQZoT
         nfKHZJOYQRL1M/M5j4W2FTLtNHSH15b4c+mlnyIKyEGlmq1lMqUKVxljFq0feYDGuR7U
         CMbr73dZx0t0KMnC7R8C8vqBZulYAqlzwBJkCW6OuhhWgZ8/pY9IfR8BQEIFwIAYqvFv
         qj78itkswx+qMmfJYq34VZ6Ukw72sbTU2C3Xr/6e2VWZ2Qeo7fsgJHXlBGtdF9vcaQry
         c98RRzH7vrvZp+9/ZbZ/R4+GtuPY4sJR9Sglw1Pea+dtx+5M9cPvtrAuXgYLwNuMKckE
         iA8g==
X-Gm-Message-State: AOJu0YxDR00d5tMwEEDDfY2AyrRu27aCnAGMOmAXM0GJC06dBR2g+V5R
	dR9irMkNzsZLM57Z/Q/yD/VMqTfnR8Zru10r0UAM6/jGVCWK44b9OvMR
X-Gm-Gg: AY/fxX4bb50cugGN6luCZRrZXeYUApXE1VRZOCfr0HcPAE7Jo9uAoBxdisk9LjkO999
	ExYSN+AkkslzGwGnjPpFDKCGBRbDTqRudaUw0wlr5iy00TcmT2+y84l1FkOU/R1suo/lWPfkarI
	3nLEsK+uTA+/gEx2NhUkYNmoDOWSgGuhemR1Zf3y8Jjq9We4k0gQ9KpAsNlZurjpirNmQOTg0Dq
	fPTgHpAPJZGM+Vj4Gat5IZyO5LVTRMn9L7FZnc/2BsNxK8jD+d+r0VV7JNvVyqZVZcDg3jA/9XI
	1mpeN3ZV7AT8h7td9xVV/P2AELMZmF/tS/Ak3kE6raltLqaL9Syy8+d7YlUYMOCprozvlMNXvmy
	teNzMr9bhBeXL4TWybdnwHNwd6LKL6vlL0m9Q1K9aKN6v+S9pFgYlKgcfD7wDxZFI/OdERmFaLX
	0C+80mHv6ihg==
X-Received: by 2002:a05:600c:8b55:b0:477:9b4a:a82 with SMTP id 5b1f17b1804b1-47ee33a97b1mr41584375e9.35.1768414985463;
        Wed, 14 Jan 2026 10:23:05 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f428e4b38sm4462145e9.13.2026.01.14.10.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 10:23:05 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 14 Jan 2026 18:22:45 +0000
Subject: [PATCH RFC v4 1/8] bpf: Factor out timer deletion helper
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-timer_nolock-v4-1-fa6355f51fa7@meta.com>
References: <20260114-timer_nolock-v4-0-fa6355f51fa7@meta.com>
In-Reply-To: <20260114-timer_nolock-v4-0-fa6355f51fa7@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768414982; l=2070;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=U8hCNFhjA/5IVO1q1LHGJwwFmvLKyRSTweBxRCXwZNo=;
 b=JGUchY4qfChh/++Fq/g+VBy8RRCgklRzE83GUrtJYBv1T9zHIvfcfnjq16FPZB4SKq0EI+27w
 2Veh9cyrfDmBEquZqVViG+8CcWjOrrM69TpAifh4H61JkYu1rQI5m+Q
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
index 9eaa4185e0a79b903c6fc2ccb310f521a4b14a1d..cbacddc7101a82b2f72278034bba4188829fecd6 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1558,18 +1558,10 @@ static struct bpf_async_cb *__bpf_async_cancel_and_free(struct bpf_async_kern *a
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
@@ -1618,6 +1610,21 @@ void bpf_timer_cancel_and_free(void *val)
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


