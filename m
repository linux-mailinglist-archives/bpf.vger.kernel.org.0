Return-Path: <bpf+bounces-75358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 45945C8190F
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 17:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5F723347657
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 16:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2315B3168EE;
	Mon, 24 Nov 2025 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OfNjbizE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0317B3191CD
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001763; cv=none; b=NQ8iTWG+1wU9PqANH8rTpDJjmFlFAi8WQ5XdYtma68AtTv3Th2UjDonKk7hHlhvQiQMICVLdQ5u8SBWkVTCrP1mSQ4DMkxy2yRJLYoLQw97/CQwqHSeGcY0N39mCEr94xomTV6QkV7J0/W0EsvkzUw/HYNzJpo9rEODwzBdwMhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001763; c=relaxed/simple;
	bh=dBBJNBM9lwB3nIzNG7eIWw8ZLh10JiMWH7jW9NWEH5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YkA7gkITsTYtKmKYrNYAYyFZsmufHfw3BhFuaoqXXgz0TBv9l/MJQ/j4eM60vkhEdyBiTjitnKiGGNSAdUQesPdpKF7AgrPzMFUXIQ6D7efuJA1On5tqlbLuI08b/oA8572HIMUFIj7xHC5rFSlRS+ZpHiFIR4Ece36q/A1LZ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=OfNjbizE; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b7291af7190so660109566b.3
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 08:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1764001760; x=1764606560; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uMmoF1WyxWUVhcv2mNwvbfP/vLAgX/en8ow3WzUaKdc=;
        b=OfNjbizEKJHvkE7XD8bo5XaENtMp6vWAp0W0hCUliDaHvidanJjGbfdqjZ4EcfSWCZ
         dzicXKQE/8SOy82Osn448zJORRDK/nXEEQ05JMhsFKgqVvbmi8Hn6DUCBblU9jR3i9WV
         K29xHNob1u6uqKX/Q3a41wuSzX2oUc7oTyGFs+losNgmO0/+kjB73tuwS2SZ9cPKQ0Lo
         3BRuBJkNtMdXQlia/BvCdDmEYTDj633hn+8hzIMc/UOGi8/yUurClL3cYoKeWXkk7PCl
         JSERZEKsjCgDKdIkAgKQu764CSWmQOYU/PObtRlYriNvD3caf+yTaV8IB/KHt0BOOR9l
         jg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764001760; x=1764606560;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uMmoF1WyxWUVhcv2mNwvbfP/vLAgX/en8ow3WzUaKdc=;
        b=fuuSHYWdg3OKBBxfjUgULs7eElvb22mXrnBsznESMjPov5FEUYXpWiMkrZoFX7QmA+
         rDsEesyl43Rwmge/yj/hgSpn2Rv5KxPjUHIpcQ0XwWwKV8+C0JNGn+BiCds/kEbbuN2G
         Sl7ozipF6Zw3CgiUpM+AgVvh9macsTIXe1K6MhwIS1FMx9bSoPu2RgJQfPiXZsG+1XDQ
         5KBg+vbIRtjgy31POiAWqMjJHeGEE6yMxt+wSDgoIWrxMyPg9tnJun1S5pcI4HxjsVzd
         IC3G1H2nqLzrjHdWbHE6qtZvz3M2nwL9cZrzueaUGbT+0+T336lZrxXIV68Ws5Ntm0Gu
         ceJQ==
X-Gm-Message-State: AOJu0YwOS8JcyWfMhDrq7c6ifyBaNBRmw1Oil4XQHNl9qYIZ5wxfvoJT
	wS772HtMSXKZnaj6baz3J3AAFoz+8qLgYDUFM1mwI9mO35WzmmNmNZMQyHjn1eU5yXaIxumqLpR
	5KXnZ
X-Gm-Gg: ASbGncu2lP2FXe8uOGVsF099cjRdzrE30TDS2QRHbRh7KLocP94dqPJeAylmSkcKt48
	dlpyNmgg5tQ/kCUB4nnTponrk6gc1Xp2KepqELxIbf3Od1fNo4j2oh5tN6hqcipb2L3T3NerwGd
	ZADgLyyVwKKAitCP98BbIzeayVDBbjnSvK5spoq93WU5q2F6fOY2bzJ6JOjQu88A1mlDnXrMvep
	MypY6Y/540M3g2nOaUPn3lzTepxNOWS5tpaQ+SBs1UdxDIGCfRS6dOKhbiWaNuRON62r9ts8N4N
	v80kB5wMjaGgnk2zq5p7jB/rqcK69laBEAfrf2hHXbbs5YBpjBDEvbj3FS6fPQZt5NnX9O+Yipx
	JxD5qV6g08DufdMUiNdT6VxPqnHQcDhJZ80fU9zHCvMHDZbo/DE3xXXVxYkrWNYelIEbVF1lTja
	IMxrAet1jW+2w+PzbNFW+V1kiOfqLFLrmQp9M86uHFT28PmywxiRnbRUM0
X-Google-Smtp-Source: AGHT+IEGHT2H6DgkF2j3zNLW0uQCTluvlrloCK+PiFdA+fvxy/R60b5jESaEnu6z4FC5JiLsxz5B4Q==
X-Received: by 2002:a17:907:96a6:b0:b50:a389:7aa4 with SMTP id a640c23a62f3a-b7671547e0fmr1220083266b.13.1764001759920;
        Mon, 24 Nov 2025 08:29:19 -0800 (PST)
Received: from cloudflare.com (79.184.84.214.ipv4.supernova.orange.pl. [79.184.84.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654ff3962sm1344035566b.50.2025.11.24.08.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 08:29:19 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 24 Nov 2025 17:28:44 +0100
Subject: [PATCH RFC bpf-next 08/15] xsk: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-8-8978f5054417@cloudflare.com>
References: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
In-Reply-To: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: b4 0.15-dev-07fe9

Prepare to track skb metadata location independently of MAC header offset.

Following changes will make skb_metadata_set() record where metadata ends
relative to skb->head. Hence the helper must be called when skb->data
already points past the metadata area.

Adjust AF_XDP to pull from skb->data before calling skb_metadata_set().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/xdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9100e160113a..e86ac1d6ad6d 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -768,8 +768,8 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
 
 	metalen = xdp->data - xdp->data_meta;
 	if (metalen > 0) {
-		skb_metadata_set(skb, metalen);
 		__skb_pull(skb, metalen);
+		skb_metadata_set(skb, metalen);
 	}
 
 	skb_record_rx_queue(skb, rxq->queue_index);

-- 
2.43.0


