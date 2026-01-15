Return-Path: <bpf+bounces-79109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD71D27C15
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E327C31DB519
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB833C1FCC;
	Thu, 15 Jan 2026 18:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glNegpEL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC222D3733
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 18:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768501749; cv=none; b=IZYaEkpIroB0WmjIFPzj/m25qdRI0LRyKNHi5pK4h5vgOqylidA5GIhwOnXfTl13nMkr8VZg1JZajOCLw3LwaAlZVTzaSZoGW0D/Uum2SgmWm1EjHkOMluMjHt5KXIAIx0whB0tHRP1WfiVBmcbJkP7LLwTZEPXpA9DdYzemMOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768501749; c=relaxed/simple;
	bh=W3d8gQg0QN0KkE2QIWAGpQFnRGGPBwiA5Z/l+bp9p/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WVICGzVc5X2E8V+O9jtsDSHaZQUCD/Gtq+8XTujw8iHInwrnjT3yvB0d19OUI/oVSz6Co5beb//DpRPAi4MqHDmwsaKUokLu378QeyV2mW69o2By8ak1BbjL2VqDwbWC3iYmAnNNFYJDGlkozNBbxVoS2E4yu8XZAhVqaOvRupM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glNegpEL; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-430f5ecaa08so642212f8f.3
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 10:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768501746; x=1769106546; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jwaw836ujBIm0+grtUVR9C4IUA9McWacj0EYjrR1yWM=;
        b=glNegpELcuW6FojLZo2WKEh+ZTGFcEKGNiafneXUycfaGlXUcerr7oJbUwDtW47y1e
         sag/9P7eKFTVVCkFvt/iWvrYc6mJY9YvWoYATzWweSAMcETiAz1A4/vVLwUW+tCJp6B0
         5BzbBQzARfnpNpXdaXYRrtS3JoWBJHdn8Hg7dMsR8b8zZt5ghOs7Gy0tW+2tBDsfIu5+
         JdhrHHVPste3udl3bCF0UB0pjzyYu5XeNji459zxqVBfaiVFap2nQbGjX1wAhh95W7hU
         mr4Az8AouRtdEDZuGl2bFyd/bIT3RdZBs349636cuz47quJ8b8xc7FUIZeO24DZjD+ga
         tr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768501746; x=1769106546;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jwaw836ujBIm0+grtUVR9C4IUA9McWacj0EYjrR1yWM=;
        b=BDURWJ1hw8LAFDaWu3umsvJZ3Ho55w6cmPCb0450BurWxgr4HCCpATUxicCheg/vj8
         k5Dd5FkD9mZZt42TKkCNsV8il9RN+9nLwEBEz2u7WXmiBi1XMiVLTne0AUTXxnLcahD9
         knmEknJbkXaLqGoCRvLaGhxnY80xGv03kt0IH9M3yJAJ3BkErVmEBHb1He6Vtvx81xLB
         I2umNwiF4l8N9CWRrdQ3kb/wniXJrY2pElRzG+nvh1ZbL9OaOzW8s+NWrWCQhMrfUGCj
         GJ024wNOg8lE/lKWqGsNSw2rsW5X0qSgsVUlX/3TPqY1NN/d7w8wsr9uivArpePy4yOT
         0AMg==
X-Gm-Message-State: AOJu0Yw5fa/ET/dXuHYPgmap6yJnpTMNIcD7ek6zjXd5G24KwbgroW7D
	w0vLZXbiYr83pH1cMGIy9iUOVaRcHHY/p9/d0DUM2swjeMxsPzMqD30vr+Q1mg==
X-Gm-Gg: AY/fxX7pRZL7/f5/EYJ8mLy4IiGA1rMwxIgQ3TJnXiYYFE0S8SWR4EdShgT9EVl/jGc
	KOEMFJnghFWJhmEVHtF03mZO4cg1wTsfUJCkslPAoQDJl3SGtSReKFF9P3tIsvdtDX7SaFC2rO3
	EWPz0qz1K2Cy64mAK3vBSMhFiigQr1cdgPKluujTFO/RTJvFN6dWd8kSIlDSoQSX6mT8PhC+CZd
	TQ8j6k9wSVOeygXuZ/5coPKlaJfQu2VLPYHXWgpJszXUHWbNfWaBlLR+dDYbwydz244LykUdy1R
	qqJITwFoEzJZfxWBJ4N44JNjuNTmBrGbMuECtkniJqevukLA7p0dJDJyBJ+QLuQiISX+49rJTFv
	ZRo+MN3OT1FGLHxEJl3m8Pil8uqaHhnmdOZiTyysvllaWsKzdsccZA5xBaYyPHcIBtQ==
X-Received: by 2002:a05:6000:3110:b0:42f:bab5:9533 with SMTP id ffacd0b85a97d-4356a029a8bmr270229f8f.17.1768501746097;
        Thu, 15 Jan 2026 10:29:06 -0800 (PST)
Received: from localhost ([2620:10d:c092:400::5:2520])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569927007sm470902f8f.16.2026.01.15.10.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 10:29:05 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 15 Jan 2026 18:27:48 +0000
Subject: [PATCH RFC v5 01/10] bpf: Factor out timer deletion helper
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-timer_nolock-v5-1-15e3aef2703d@meta.com>
References: <20260115-timer_nolock-v5-0-15e3aef2703d@meta.com>
In-Reply-To: <20260115-timer_nolock-v5-0-15e3aef2703d@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768501743; l=2070;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=U8hCNFhjA/5IVO1q1LHGJwwFmvLKyRSTweBxRCXwZNo=;
 b=zw00wjE8kVNUb1iOaN65z5q2isb8llte1abIOptFvN7840RdsM1iqux34i85qMx4Tz8mTP7+P
 n3bKaWx4I+NBHr8nKhCsPDxR0W5kNdDV3hlZc6iiQSzxKeQ3cYCXt5K
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


