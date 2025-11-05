Return-Path: <bpf+bounces-73664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC7AC369BA
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 17:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC6C1A40620
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 15:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7223330D58;
	Wed,  5 Nov 2025 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLG+QolO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CCD31B83D
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358355; cv=none; b=Jt5+50gyXz56ePcZ29rwnooVDZJRZpVyL9rTbI92/5UK4AAoZ/UObLbIrTq/T0Biwn1IWD20zEp9ElROxtKsnGyG4OJwG3SOSuhHQwa6yNRnr/C2mYQHfQrI0PK1UakNFhel1EpmMyqIbwKy+bWoMI/WocybnUjkDuVxGEKI2kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358355; c=relaxed/simple;
	bh=g9IhRo2+KwZcLcy9+GkMLE9z0DJx31msELahchp1Mn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bxhqXKyaIBYTpUzqU3CmdELL07+glc8bGViBjSDUhSAdRddFWhLGR2DmrRLRckfzyt/t3Z6dDCu1Fc+lEwZ1j5PoKOBG22DnFmqMdYbQ/K3/cFYsJw1dkTSaf0Fpev0WFDLZKTar+2Nx0s2vwdW1k998ZfQ7z3A7mqZilFgmDQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLG+QolO; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-429c4c65485so7614f8f.0
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 07:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762358351; x=1762963151; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mvt/wy1k8qiTc6uWMjYP0BT2nKr9eZ2ghB2iSb9VIfM=;
        b=FLG+QolOJ6mQYQRSxoq3s8km4pvmycY1kPJMqSSeedTRoEH9fOl3c3gfnzuAdEa/pz
         A3sVNW11WbDBYK4s3PZBV926bLkgwwVzgUz4BpETjrd2Zl/sMTctK7Ou/uLGdaLkuveZ
         AyZ8jhZuxFiwLYb2IkxQEWITfEwk56GZLZMznjH//ltWC5SKZV0Kl0xTDMhrG+hzyHju
         BuFBwgYz01YmKwMXHL8T52RY2/KzlgUroEz8pp56DSOGp0MmCc71//3V+OAbUYS+rSww
         2T/GtA1PzeWR9BrLd+wjjDq6i6kJkB9B7XJ7nSA5+r8M982HiUUfFn7/JlCw4yx5lN8f
         FyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762358351; x=1762963151;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mvt/wy1k8qiTc6uWMjYP0BT2nKr9eZ2ghB2iSb9VIfM=;
        b=l4kC3+GNoIR34uV0etshg40UWQUqAzAI1LGF4BbCt9UaqFQIsQ1JOV4t7U7OjGDlLz
         20Nx894VDB+ahL8nYnwblsMgljUNLDT4aSYahU68CJtr+EJNFUUQr2btv85csfwoZwx/
         5XOeuXDa2jqQuFPhZ2JAlsgIBq+VjYMi/psvsmZIhAnCaRwgLGVrelJpQYXyNrKMqM8L
         qZ/ICXSn9Fx54WCIVUY+Wuz+NUtXiQTfF1zqjuZL0Dp0sTVI+tV/hzoDBrbN32cy8p5C
         fzH/KWdFh62eq5jUhJ1QDGaoV3FZvhtif4SgCE+iPeMvRcpjeikzGlvolalNlNO+bJD7
         xf2w==
X-Gm-Message-State: AOJu0YyRnWkF+rLFbDGTEWcA0nLAbDt0eTKLhIUKY9UqVdtQb8G+dK1c
	FnW6xRyJOrrCpSSAGXw1Dl6rHOLOZN+bOjdGgiKfm/D+xdRkjgqP5vc5
X-Gm-Gg: ASbGncsspxyVONrlPoWTJmarPgW+7CVbZTHYpWlhzOoFWvnp84Gjq1AALlvQlKHa1r2
	ebZo/BduRR6JyhADpEGV7nWLySfnsiBK5mtKW/L7ID+BhuqOEbTBtpyUyZSGARZJOXPO4DqwBIC
	ITIFfHaCwbFOj6P7bpUZdcNGRJ1KMKPPKrnPgOnuLVFbo4sZTTosw7/AK130Y24f0K+WTI3kqlK
	OXauHVlPKZawyMzYijynAJgAg9u6I7oNbQEFCzm7Ed8IINozkZXxyk8S+BBrNlbbOHeZgTpPZVB
	YJfkyj3Yea6otSy+jhrFrkxeaG7qwK1Auw3cj+iVFWSL1ySt1v4wEAO1plzs+z2j7R/ER3ofWKd
	6S/+J3btDY2Q6EQo3k07Mzx4huxeQFy0zChWYAxHq0m4KK6A9P+2igBf1zcgJ
X-Google-Smtp-Source: AGHT+IHw2NtpN9BqspFhMiqjw9p9WxC9+XoKkCHOl8VlTuRaTYq6GKhidecmpyaGwbTd+9/coAHMHA==
X-Received: by 2002:a05:6000:22ca:b0:427:492:79e6 with SMTP id ffacd0b85a97d-429e32c82d5mr3144185f8f.2.1762358350452;
        Wed, 05 Nov 2025 07:59:10 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::7:64d7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1925a4sm11416055f8f.16.2025.11.05.07.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 07:59:10 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 05 Nov 2025 15:59:03 +0000
Subject: [PATCH RFC v2 1/5] bpf: refactor bpf_async_cb callback update
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-timer_nolock-v2-1-32698db08bfa@meta.com>
References: <20251105-timer_nolock-v2-0-32698db08bfa@meta.com>
In-Reply-To: <20251105-timer_nolock-v2-0-32698db08bfa@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762358348; l=2747;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=3auEGCOx+Dr3i2JupK0Kg8exCAmxDrhqw1y0qa8kkaQ=;
 b=HoF/mg5AFdiykWtsF1M6sVTLyHU8OJwaOBOBpwToVrm7x6lhO4sQOQXmbcUqU277ThR7t/OmH
 uuNxuycsa1MCkACvfGYPtrIzAHvMDAlivi60PvhhR99SD5YJS1L7Ffd
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Move logic for updating callback and prog owning it into a separate
function: bpf_async_update_callback(). This helps to localize data race
and will be reused in the next patches.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 930e132f440fcef15343087d0a0254905b0acca1..e60fea1330d40326459933170023ca3e6ffc5cee 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1351,20 +1351,17 @@ static const struct bpf_func_proto bpf_timer_init_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
-static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback_fn,
-				    struct bpf_prog_aux *aux, unsigned int flags,
-				    enum bpf_async_type type)
+static int bpf_async_update_callback(struct bpf_async_kern *async, void *callback_fn,
+				     struct bpf_prog *prog)
 {
-	struct bpf_prog *prev, *prog = aux->prog;
+	struct bpf_prog *prev;
 	struct bpf_async_cb *cb;
-	int ret = 0;
+	int err = 0;
 
-	if (in_nmi())
-		return -EOPNOTSUPP;
 	__bpf_spin_lock_irqsave(&async->lock);
 	cb = async->cb;
 	if (!cb) {
-		ret = -EINVAL;
+		err = -EINVAL;
 		goto out;
 	}
 	if (!atomic64_read(&cb->map->usercnt)) {
@@ -1373,9 +1370,10 @@ static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback
 		 * running even when bpf prog is detached and user space
 		 * is gone, since map_release_uref won't ever be called.
 		 */
-		ret = -EPERM;
+		err = -EPERM;
 		goto out;
 	}
+
 	prev = cb->prog;
 	if (prev != prog) {
 		/* Bump prog refcnt once. Every bpf_timer_set_callback()
@@ -1383,7 +1381,7 @@ static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback
 		 */
 		prog = bpf_prog_inc_not_zero(prog);
 		if (IS_ERR(prog)) {
-			ret = PTR_ERR(prog);
+			err = PTR_ERR(prog);
 			goto out;
 		}
 		if (prev)
@@ -1394,7 +1392,19 @@ static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback
 	rcu_assign_pointer(cb->callback_fn, callback_fn);
 out:
 	__bpf_spin_unlock_irqrestore(&async->lock);
-	return ret;
+	return err;
+}
+
+static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback_fn,
+				    struct bpf_prog_aux *aux, unsigned int flags,
+				    enum bpf_async_type type)
+{
+	struct bpf_prog *prog = aux->prog;
+
+	if (in_nmi())
+		return -EOPNOTSUPP;
+
+	return bpf_async_update_callback(async, callback_fn, prog);
 }
 
 BPF_CALL_3(bpf_timer_set_callback, struct bpf_async_kern *, timer, void *, callback_fn,

-- 
2.51.1


