Return-Path: <bpf+bounces-73666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F815C36C29
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 17:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B16562546C
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 15:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A8E3321DA;
	Wed,  5 Nov 2025 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bv1KhAku"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EA8320CA7
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358355; cv=none; b=MFYjp4dKDoCRW6SO4knLBmy6pdEGGxg35f21jTZnjjSsTV84GDWldJx7c45N53drz6lbGQRFrlOXNon3pY7xWsCOFDNeEiA4IqZNDuzqrRK6TMNYCiEQhODskpAON++jh+XLmAsbz2GBIVDIP+BjFPTzELC4CH+AFR+ygEH+F88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358355; c=relaxed/simple;
	bh=kzCG/ty3XCVRy6vFklLrG0H5PXeDxbkarAkmXzwEnXI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IisRK5ZxvG0sfi96NsHnl3A9WTEgcqZNyhoXZfzUUXANbFfRLj48k8Fd+JX0pzGF11HiWcpCGwCub2e7K6mFy9Yht+fBjKaZMn1kKzn19IJw7YZIMm7UBlMLF2Io3JJ9jum02AprB+9kjEghHYJ6l1/CWEx3KRN6gx6gXUwTDec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bv1KhAku; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4775a52e045so5656785e9.3
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 07:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762358352; x=1762963152; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v1Z10XCdfDm0DR+TgFdi/ZCo8Vh10gFbtI402OzQUu0=;
        b=bv1KhAkutFA928kFKu4g3C1abA7LWPYOQJEP6M+rfFL53bZ24LLh7aQifxcIeis3G2
         8D1tvbANUrIeMkO0T3ctBx/YzMVNlz8wwPLjIA26e5C2YdoHYL7OG2AaVejLxtiCah0F
         DpPySjTSXMiAc0cbFAHmJakfAlAYSZcpqZb5AAmlqrJXzQCESQD0b4x6hUWhwzDIGD+p
         jm+Axm4iIeqwo99K2I86nDBGNkemkuBeSSvUCGt589Vg7B5EM6eXqOKSRhgis5tzUvxL
         wSsl7+lyscVe1UspWW1y8+J3ngQ0gPgBghLmvr3dxPqmO+P5pfE8W0HAtVpgoJ1v4G5t
         4egw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762358352; x=1762963152;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1Z10XCdfDm0DR+TgFdi/ZCo8Vh10gFbtI402OzQUu0=;
        b=GYGolDnzu9zTiwg3tw894B32KMVXtSFBi8qyuznAYxIQ8/e+AsqLzACE/ZH//Qfgp8
         s+lmlgy+wcfrHVuB8oyXkOeQoZ+y8t3VX1gjozW1ER5K1yQ3BtxTMtF+w2NCGzfAF/jo
         GKNc13snqWYiSIA4cpsxdIh/KREYe23t4yXraco4g0kymtxzI3dXRtFZ13fOz9IsHXgl
         rUjz5ZFs2iOAcRyF/1kAzwui0OZAF82V4stinYQ8uWYhtpodHJCQiMqR1jEEJK6HOWhm
         ycDatnD19xM32o7zlTkWjUUuGSpATzqALjkx3z88G3nwr5QC7h3/HdbQpQVhiK8x/VoT
         0S0A==
X-Gm-Message-State: AOJu0YwYQvw/XbRpODJBad/F+EfGMWCIdnjzfqjjq8yf8PD0Dz5uz2t4
	oRKVITgv4/lqSUL1i2T1Ihs3//ZK5E6Xflp7wbWnzdVsvGaCoZag4ric
X-Gm-Gg: ASbGncu+zmJffMtSQs7CDWeZcSQHKwWJIdMTbdD84RLaVap0ukzSmPpb1HRbx9FLyOo
	f3KFsdbOUd2nb14M0xRsoeGYQmqYSf2bZVLl3PJ9+Q9KhqsDqUArl3cgk0aqsGnpmKzFPuG0/1p
	1rNjlOZEzduE1Em7Ags4QbPv7O69aIllgpEaKdowS0sBqPSlVJVYjk8ciXAPcYTrMYOShN4uDkU
	tKAHLwbCd5XWdoyez42tdb/LAf0VaMuMTtY1ivZahYRo3g4bSQagM488vgWXhxYxjzl7IT+zOZx
	lcPUFwoP6353BgPiK+76JxyvEzuZ8Bo6UzOpo+nfnTB+d2PvvKO7rvnIrZizUCFBO9DXUFOQZdW
	UahffDd78lgdtjKqkcmO1CeTQ6zsuLum842AJAx8XL+47l4UaUUD7lRk7PPtf
X-Google-Smtp-Source: AGHT+IEUFKbdPsQWtS3x7c+wIeYtZS+JeOHi0wBiPM8xKrd5S42kcYjAFZ/vNE12Xk83i7VaQVjbmg==
X-Received: by 2002:a05:6000:430e:b0:429:cbba:b241 with SMTP id ffacd0b85a97d-429e32e44a1mr3291003f8f.17.1762358351429;
        Wed, 05 Nov 2025 07:59:11 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::7:64d7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f9cdbsm11753771f8f.34.2025.11.05.07.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 07:59:11 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 05 Nov 2025 15:59:04 +0000
Subject: [PATCH RFC v2 2/5] bpf: refactor bpf_async_cb prog swap
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-timer_nolock-v2-2-32698db08bfa@meta.com>
References: <20251105-timer_nolock-v2-0-32698db08bfa@meta.com>
In-Reply-To: <20251105-timer_nolock-v2-0-32698db08bfa@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762358348; l=2232;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=SHxjItg3UIF7UAV9Fv0skYaLz/H+eEoW6QpmPHoLy4c=;
 b=shm/+Ql+n1/58pn1Krm9h6qL9gS4+KBoB9ZjAlx8mSI5iQQY+04vS96AGVc5Fw4ERchYy8QOk
 ZHErUZdJglJDoZUdSiShjFdvDP3M/tID6Ca4cLc+UK6RmQf9NTFIY9A
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Move the logic that swaps the bpf_prog in struct bpf_async_cb into a
dedicated helper to make follow-up patches simpler.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 45 ++++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e60fea1330d40326459933170023ca3e6ffc5cee..d09c2b8989a123d6fd5a3b59efd40018c81d0149 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1351,10 +1351,34 @@ static const struct bpf_func_proto bpf_timer_init_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
+static int bpf_async_swap_prog(struct bpf_async_cb *cb, struct bpf_prog *prog)
+{
+	struct bpf_prog *prev;
+
+	prev = cb->prog;
+	if (prev == prog)
+		return 0;
+
+	if (prog) {
+		/*
+		 * Bump prog refcnt once. Every bpf_timer_set_callback()
+		 * can pick different callback_fn-s within the same prog.
+		 */
+		prog = bpf_prog_inc_not_zero(prog);
+		if (IS_ERR(prog))
+			return PTR_ERR(prog);
+	}
+	if (prev)
+		/* Drop prev prog refcnt when swapping with new prog */
+		bpf_prog_put(prev);
+
+	cb->prog = prog;
+	return 0;
+}
+
 static int bpf_async_update_callback(struct bpf_async_kern *async, void *callback_fn,
 				     struct bpf_prog *prog)
 {
-	struct bpf_prog *prev;
 	struct bpf_async_cb *cb;
 	int err = 0;
 
@@ -1374,22 +1398,9 @@ static int bpf_async_update_callback(struct bpf_async_kern *async, void *callbac
 		goto out;
 	}
 
-	prev = cb->prog;
-	if (prev != prog) {
-		/* Bump prog refcnt once. Every bpf_timer_set_callback()
-		 * can pick different callback_fn-s within the same prog.
-		 */
-		prog = bpf_prog_inc_not_zero(prog);
-		if (IS_ERR(prog)) {
-			err = PTR_ERR(prog);
-			goto out;
-		}
-		if (prev)
-			/* Drop prev prog refcnt when swapping with new prog */
-			bpf_prog_put(prev);
-		cb->prog = prog;
-	}
-	rcu_assign_pointer(cb->callback_fn, callback_fn);
+	err = bpf_async_swap_prog(cb, prog);
+	if (!err)
+		rcu_assign_pointer(cb->callback_fn, callback_fn);
 out:
 	__bpf_spin_unlock_irqrestore(&async->lock);
 	return err;

-- 
2.51.1


