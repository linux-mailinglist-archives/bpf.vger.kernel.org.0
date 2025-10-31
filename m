Return-Path: <bpf+bounces-73207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6C2C27168
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 22:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B6194E58B6
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 21:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB5032ABE8;
	Fri, 31 Oct 2025 21:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzxYDSDK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF83832A3DA
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 21:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761947942; cv=none; b=YNNWq2kvHeM3zqtsNFh/3Cq7+185Td3fuN/zl6sd+EvZb49MXfrbPi11G0syb4jJMaCyU1RiQuN1GqAF7iPsvg+djC+3AORit5BGIeFCUlUHyAXk/2CY5AaoHL4SjfzXuHDTme+BHJs0DEX+CF3GtucoUIyPbh32C9IlXdGI92U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761947942; c=relaxed/simple;
	bh=hpnYnwT53+kC4iUAXYVSCc/q+mz2z3ND2ziJ7znVoVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgWnzonMKPjxAA8nsrsohS/tDXhirg4zHVdGCKuDcaVRhX06rHmOzqFpVFhst7xhx6lIQGMMinZtxrHWiWVZmmZ34v+aXSy+GHMAD2HRYd5Usw/sDFZaS/u8UAsRtSAYC+/wkfThUz1N9vZIwtYzC2gmKQN1W1TVLtI3XZotKOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzxYDSDK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47118259fd8so20821545e9.3
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 14:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761947939; x=1762552739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWJVJgWRVRekcWc/DDDaSbAR9tZvKBTXr0eRRPAQt0A=;
        b=HzxYDSDK+Qz3evC1YX5Ki3j76FDGT8JonSvka4rhVao/BqBQIy51eKl6I8+bmrbwNV
         41Gt0Dp9G6LyS29n1CSTPmc9ekacW7wGaOr6ZsAcZm95sbd2+UXB4FLYDrB0/ABZmj3h
         XR4HX3QacNm/raPngcQJDuHmapbLjWgk4nCyJexzS4OXObsRZfXkX1L42B1oSvxP3/Vl
         3XFlgX0CPY4FbUdl4S3Z2c0F2P9YR+Oq7MvHU2PJvusTH5WMoReZre3e4Vq4jjht0iJU
         Gx1sCMKcKkwrPs467T5FauyokEcGOkh3I3SMGW15GoPvEniX/4NvxlFBa+MWpSdlTkH1
         /nDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761947939; x=1762552739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWJVJgWRVRekcWc/DDDaSbAR9tZvKBTXr0eRRPAQt0A=;
        b=mGDkSBDafMxZs6Xsm1c0UKtu06L8iIpGtgzi88aLaGDBKXPeS9UfQQ2FCrXHUwsYUm
         s/LtDqhwmW1yuJhXMGu3cI7gHKLzUJJrT451/pcUdKN2fR7Xj36qIg0SIz/8RzkdgBzj
         XPCD5nwa/VjGFm6Px9BmUoP7zxUXqekBkL+/UBUS+8gEJPXIcu3Li/oH4mvVRGpFM1Ww
         c+u3lBpJK9WOe0cG4iBTinRZ9ua46MpdQvIL7eQRliKiEkP6NQn/f2QtwgOTACv9YbT6
         2XRR/VWqUxDZInNyZl2QJfPfn8o72tp7Uk4EqyzFBwFfV7G3LwQCcfBUSVYhL2xkOaFG
         CMaw==
X-Gm-Message-State: AOJu0YzzGTffYm63l8cH0OhUnPwFLZT5dAuqCczcinVH7+D2iVmLxvsw
	pvUm+UatQ+74Q9STB3l3TnxsJfSTuiB8j0wM/RLSPc+NZA9x0ueSsGoPoJAPmg==
X-Gm-Gg: ASbGnct+xHYjwcuihFftS7HwZvrXV28am/Js2g56E+1IeODyllGKNt67bJO04gnbUCV
	dUzYFtkpk4OEcESBHJeljR36p7ANNDY3eVV09LKWunzGSgx4s2Cv79VHDOUgI2iOeAWYf5UmhD+
	fnsBAdvN++9KpGooXpXIfuunJDjRsc2thls0RffHwJunmGHmpfU5tSsnN8+oykW7jcV0md3HUlv
	17Xe6YG0yKtrdsAamP46kG/gdVWuw7nEZSNINw7OKSqsjzvRquH99vewtDrmWs5x3IMD72OAo/n
	qYFgjCMExdVLDGqCYgZhgtUGgN7vKneCu5kDsiaaS0JIK2UqN9hNo5YtKlraXFyxIjsP29wRxV9
	s3Bn9tdpqg14orhcRtqw8M36G9tJkkDlD7Cr1+tr1hUq2qL20sbuH/vGaBzaJB7sYx1cv7zV6LT
	QCIjA/W0rLWtkkwg==
X-Google-Smtp-Source: AGHT+IFhYsa1GRQqlAsEDSODpRrtns3aI6bYmrxBspMXrXe+JqDPR5BL+5c/v33FWly1koULv8PNwA==
X-Received: by 2002:a05:600c:4f82:b0:471:6f4:601f with SMTP id 5b1f17b1804b1-477308a15b3mr57631935e9.19.1761947939102;
        Fri, 31 Oct 2025 14:58:59 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13e0311sm5310549f8f.30.2025.10.31.14.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 14:58:58 -0700 (PDT)
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
Subject: [PATCH RFC v1 2/5] bpf: refactor bpf_async_cb prog swap
Date: Fri, 31 Oct 2025 21:58:32 +0000
Message-ID: <20251031-timer_nolock-v1-2-bf8266d2fb20@meta.com>
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

Move the logic that swaps the bpf_prog in struct bpf_async_cb into a
dedicated helper to make follow-up patches simpler.

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

