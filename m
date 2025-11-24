Return-Path: <bpf+bounces-75357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F119C81902
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 17:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D19E94E7211
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 16:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991A03161A4;
	Mon, 24 Nov 2025 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LK1QSQZt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBAA3168F8
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001762; cv=none; b=KZghJQdnmXUbAqS+cT+v4ARyPhF5ejdZgOojpvhckyMcLzYE24kJco25p4yLsnzClTRwJ7XulvoDlrKUI2LlXmjoTvYQXoerl8WPgbXpIs63QZddw6MFsqp6SsS+QK0Q0d9gLKHJtCTX96ojVgba5JtOHiV5ny41rv4tEAKRUPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001762; c=relaxed/simple;
	bh=2TstOQGZI+t6IG/RQmJzivYCP7vC9451vLQeJGKYZwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UMz/tQoDaHVhbC2BxlzxVwfoTnH7XOGC+CYD6t8Fsn8HtAVNHN7J7HWgReoklz8iOeNXwajnx909L34yqwRotxo+oCa6o0At9MmQ5MFLfQgVL6KDnDeq1EoPPWceRmxfSYjnvE6DyS17DXPawKdgJEGCACJCQjTFzGdxh/Y0B5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=LK1QSQZt; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6417313bddaso6909147a12.3
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 08:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1764001759; x=1764606559; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P7GGD3nxk2ZeIfkq5u+0+t/ac19i5zLpF7Qwyc+ASyo=;
        b=LK1QSQZtW+P8Pf5A9uaQxt34qCmx52sD6/7TG39U3ZcpEKmwdQqZR83shIwV5JllIO
         FifLc6///smgSEERkEqWNOg0eqqEwhijZ2mGU7he6/+TC4dViClZ4G6Hh9BnUpzJLz8F
         qOsMNxk9gpnUD3IS667hH9Dt2xAfLO35MbsZxHaMifAVLA8xV3m/zE3iygpXQZhwKgny
         Anwk9/WoPO9wAvvKVauvEzFhkm/msYjGT86s+Rwz+Ujk9cFpdmuMZqV9GukntW35GJdM
         uWJ1Whm0dQx3+/jAbjJ/z4uc7EmFZ+7/Ix93MVz1xuPenUZeIduh4ddtgorRVHAdqUag
         UNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764001759; x=1764606559;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P7GGD3nxk2ZeIfkq5u+0+t/ac19i5zLpF7Qwyc+ASyo=;
        b=k0wrGhKk398WDo/q9ksIBiDOL12h6TS6GOtKSZZEfQKXDLNGVuPibbd9vLFqATDqPp
         mbjwWkeWQY1k32YKwLzJ+FDK92Apb+rfufy8I7YyOsqGT6ftwyCmwesLPoBAvuaFfo/8
         DXu3oHZ955M5OpRHmrqTKmShHU0oD3E6vIzCiKNp4F/ZIgBh/mn8vUz86oDGm6ew0YhX
         xUvvSY+OjnK8BOymd9rxBvBEFlaJdw2JWTUz7QrpVFGyspFFLK+ckkJ8TK0uXVNdMP36
         7SsnsiLaEY4gq+5cGa9Au6AqZFXiGYPP1j2RmHTrwb1wzPxp2ls5At1qi9+SDVCrxy1l
         FV5g==
X-Gm-Message-State: AOJu0YyrZRCzqOumRGusUdq0JvCJE3bcM7alR0s+9zxZG2016p8cd9dQ
	4kMCRY5ZXm/hNwWJvy4rqGLqfrqYgfmtQQ/JUAt+FIr86zsTK3gx/MLRfzYMvzOeoVADtINGHbb
	wqhjf
X-Gm-Gg: ASbGncs7LIEdxWMnyaSFpVrHCD97npZQPZYtcA0J0NVzY8T46ZD01LrNEeg2Gvg2+ch
	ouPYrSaAvrzSQEYl4nDDFdLNMupM6AO8GzUYys9D+Gzk0v7eDIXv4fgiHE0IL2YkUNRdkt8+K/F
	R13taKHJBJpTGl7aQnFZyVRnb1kfXehEqNMAZaH7uChf418m1gUGWspzMIlgvHdB91n9hPuAU3v
	pR1Lz9N7RcaRPGRUF/+V6ZQ8Cvuaw6wvKNx7xRmfRE2PCdeXQGfJxzB/Wt3/trd5EDiQ3snofDa
	nAPtyVgC/yaTC1jCqVVyx/xbylTg2qD0FXXx42kc/ijPghMCFB4PWvdW7tmxVoDH17w5Lt9vWfm
	XHrhG+aWPaDFFJJf0SB4VcLGtp78ovc9eMPAnwvccDODA5Hx3W9o0Onq8SNP4LF/4iwL0rEhCW0
	9qVhjjALo4CZhGw8hN35lFNEUSGqko7txycsD5YIIjU7jh7KNeYEkpxn4F
X-Google-Smtp-Source: AGHT+IFNU9Sjiy8GyWZ31945ZZveM/PNlMy7b/lYkNZj5BB1SrOutmeZUgFN9nNnopRohbgsWGoPUw==
X-Received: by 2002:a05:6402:50d4:b0:640:9b62:a8bb with SMTP id 4fb4d7f45d1cf-64554677ab5mr10593555a12.22.1764001758617;
        Mon, 24 Nov 2025 08:29:18 -0800 (PST)
Received: from cloudflare.com (79.184.84.214.ipv4.supernova.orange.pl. [79.184.84.214])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-645363b5e97sm12524775a12.9.2025.11.24.08.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 08:29:18 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 24 Nov 2025 17:28:43 +0100
Subject: [PATCH RFC bpf-next 07/15] veth: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-7-8978f5054417@cloudflare.com>
References: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
In-Reply-To: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: b4 0.15-dev-07fe9

Prepare to track skb metadata location independently of MAC header offset.

Following changes will make skb_metadata_set() record where metadata ends
relative to skb->head. Hence the helper must be called when skb->data
points right past the metadata area.

Unlike other drivers, veth calls skb_metadata_set() after eth_type_trans(),
which pulls the Ethernet header and moves skb->data. This violates the
future calling convention.

Adjust the driver to pull the MAC header after calling skb_metadata_set().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 drivers/net/veth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 87a63c4bee77..61f218d83f80 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -876,11 +876,11 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	else
 		skb->data_len = 0;
 
-	skb->protocol = eth_type_trans(skb, rq->dev);
-
 	metalen = xdp->data - xdp->data_meta;
 	if (metalen)
 		skb_metadata_set(skb, metalen);
+
+	skb->protocol = eth_type_trans(skb, rq->dev);
 out:
 	return skb;
 drop:

-- 
2.43.0


