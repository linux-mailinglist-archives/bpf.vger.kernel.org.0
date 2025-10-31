Return-Path: <bpf+bounces-73208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD08C2716B
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 22:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708A91B2404D
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 21:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C49C32ABF9;
	Fri, 31 Oct 2025 21:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1UEbhei"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D909232AAA6
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 21:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761947943; cv=none; b=agH/zOv7kT5GPtWRVJBc/Jb4cCbqpZt920AQjDng3cwfyXcFyICOsfsK0NbVPRXqe4OeeszqPO8C3+AhiWZQzYD3Dc98Ppeyyc3RZjHtBn/RlVSsVwmLn31wTxX8rpl+cd8YAJmGDtfcBdPhGMo97e5y/t2gc/R/Hji+yX0oNas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761947943; c=relaxed/simple;
	bh=6xulWjOAicjBM8JMwfZG4T6pkeBpVxEIkT1wNXR230E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uX7P6JmtSdXGVyl3zQQ+p67Tq8ROhDT0M/8UiBsG/khUjyUggHtV6VXwDkmH7v+MxRDS0YsPWDFXcbAID4NHi0i5JcSKjeqakwLPyiW5+D1OaMxoYDCf6qjYLYz1hFJpCnPUx1eKZH2OD81JS26+EvebnIYhmxrkg2M3VcLyYdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1UEbhei; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4710a1f9e4cso22074215e9.0
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 14:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761947940; x=1762552740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvbV3ii+reSwTfkoOLfaeSn0ednMjaQgeinqgNOj9To=;
        b=c1UEbheidG31Ny38dgHXDVAoOwst1YGEjKgFSE7nDXGJm2SYETXDbsEcBOUgImLYms
         MhIczvRvRgKcnEYhAOpdyOAZ03Y9KiSzLfS+y+DeMQBKCBP6GX1V4f1XVCJBXXSKahSB
         dhXdcCN2co0QARGlQFn189IfB8gRW1zza9cS1QETQDqLeOTfOiTIpDtaaqzxNgZ693wg
         q7oE+1+fj3TMTRo6Ej9BX8a615S7Ta0I8tVwX8jytHw10ht/w7Vd0TdYEhX5QOM4w/0s
         aiF9eORFoOtE1KV2D0G3oZ8uXtOi4SjJreQniqtwAsaD/LXZqfuMQ2s6uLNFEZCiVlrN
         UunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761947940; x=1762552740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvbV3ii+reSwTfkoOLfaeSn0ednMjaQgeinqgNOj9To=;
        b=G+FOQ6PvSDMKPkqCPPAEVdYjjb+D1vgHw8J2BXONSGGWMTN6mx+gKzq7EuhX4l77Zj
         hLCyHlKvl83qvzAz9rzE5rorQaMLPOQ+cgzZ2yFK/A7ov5IacfSaTC2yYcvBbKn2OMma
         dQQ3SQ8ByIae61JEI8CjTMnOgQKtb8o1cwCQ7J7s6A3Kw7Mmv9m/H5PNs5wK+1nu4lj6
         wWeJwpW0Z+PPXYnJHdC9if5yke3u+gC+/erp4MJRIY4vz/D4fAP+kR2QNa9S6JHDRLDN
         Toco5/p9ZJ6sYGTIpRqsSTZT7FU/dNVG13l6RshD+n3gPzxjSDScSbWbyHtMpSIx0h3K
         UTpg==
X-Gm-Message-State: AOJu0Ywh0G3C56FWnt7iDZ7nGuWQrVp7jV91ggNisBdUrStLSTephR+o
	VPvepTIDfGQEpk01Avp99Tk7LvGEmQ/jpC8uuLfvdkPAbFZEYvp2/Lbmq7397w==
X-Gm-Gg: ASbGnctIeqmJe9PM0EDUOtsp6q5ksQslz6aADDDtqcWHtY+TQSthJNMrsK/MHX9GTqw
	MgRhXyH1fUncZr1vPC3KU8BeYTmvv2Px98oCYUEriPkudR6E1WncFHRHaL+Qac9E7R8JrH5/ju/
	RRiFd58APNB4y1g3PjFDC0rkHUd73GEilLye7mYQ7QDR3lkqYI+68AMNOYiXc5sHkUqHndOClTs
	IMrfzGTmYy4xGPJU2vAIb9eH11hPNMbmuxLMElbzZ36F84sZ+mLEZ0tJfqGmHhGQLAJW6vPHyjM
	9UmPEmlMuHRqkNKU4kxONzf8vNdy/ShE4TXZIqtXrQyPdGCoMy0ASzI7XRm90r5dcFv/caL0qYL
	TZdU0jJ6i6354KPFf5noz/X4/1Sft7iUCSFzPT4GQV7HEg6EXWpkBvL/sy0wqPeIULj2V3DcI+H
	sSUfImpjebjUPaQHmBEm24j/Du
X-Google-Smtp-Source: AGHT+IFiNvQaqKXuF4nZjcNKdgI738CQvdYQtSOl+YOYouKq3GpmGzng1uCDv4xxQyPIAWihYimRBw==
X-Received: by 2002:a05:600c:5026:b0:477:e66:4082 with SMTP id 5b1f17b1804b1-477308cd668mr52823185e9.29.1761947940028;
        Fri, 31 Oct 2025 14:59:00 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c2e674csm16616115e9.4.2025.10.31.14.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 14:58:59 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH RFC v1 3/5] bpf: factor out timer deletion helper
Date: Fri, 31 Oct 2025 21:58:33 +0000
Message-ID: <20251031-timer_nolock-v1-3-bf8266d2fb20@meta.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251031-timer_nolock-v1-0-bf8266d2fb20@meta.com>
References: <20251031-timer_nolock-v1-0-bf8266d2fb20@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Move the timer deletion logic into a dedicated bpf_timer_delete()
helper so it can be reused by later patches.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index d09c2b8989a123d6fd5a3b59efd40018c81d0149..2eb2369cae3ad34fd218387aa237140003cc1853 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1153,6 +1153,8 @@ enum bpf_async_type {
 
 static DEFINE_PER_CPU(struct bpf_hrtimer *, hrtimer_running);
 
+static void bpf_timer_delete(struct bpf_hrtimer *t);
+
 static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
 {
 	struct bpf_hrtimer *t = container_of(hrtimer, struct bpf_hrtimer, timer);
@@ -1576,18 +1578,10 @@ static struct bpf_async_cb *__bpf_async_cancel_and_free(struct bpf_async_kern *a
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
@@ -1636,6 +1630,21 @@ void bpf_timer_cancel_and_free(void *val)
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
2.51.1

