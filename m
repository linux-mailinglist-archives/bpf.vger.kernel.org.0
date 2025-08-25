Return-Path: <bpf+bounces-66413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BA9B348FF
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 19:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC73188EF15
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 17:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D367308F30;
	Mon, 25 Aug 2025 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIcIdbEx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C01308F2A;
	Mon, 25 Aug 2025 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143299; cv=none; b=mfptOkwcT1l19h08kq/zm4QBxrjOZe3kbLNrV/9kwccu8uFOFGQ/qkAi+GAtZ/ERzIBp7vWbd43dCU4dnN46VE5eAHWvUmS0xZFBQaf7YgemmL3Kc0yGlK8QATl03J0CaKsqaRyxgTVCQkTgRhFPyJmVxJeyk09am1UcMN5yVpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143299; c=relaxed/simple;
	bh=BF4TDhqQMFX1tdUCUnTsWrwYS2QKh698szOx84ZHXrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kh+buXs8+3ziU2+yR5lX02r6unyy4linYdYYeYQw2AkCXQKHLg+vgb7MD678TO8VahaONcAoqF/eIUfXzikRGCZMW+W+vebXGNbdWtpImhK9CWHrkrhS2fBmnxr3Wbju3Bog1dJ4K+Av3jSmZ/WolvJTqtdhAFwIgZAAKOBoq6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIcIdbEx; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77031d4638bso2688336b3a.1;
        Mon, 25 Aug 2025 10:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756143297; x=1756748097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4uw/9uBbQYYP/tm1pCiHdt2MwBK9JCxPJmXEEuez5M8=;
        b=HIcIdbExAtIxGUnCdiuSq6cEJABSaji2UpmlJ8hhwZtC1Yt6D7+wKpT/qauBSMn/0V
         zqlV+JML8tntt4gNJQ71GpxYxHjF05jUTeQ/qdCGAOLBXrP+2SHC3EeAYKMBcXDHwTSh
         qO9UzzOw19sGS8Tabb5Kvg7nNnb2bv4rTylcblKyXOG1n0kG9OCSD1s1hNLenX/WaeV+
         YwMqojQSJVTZNN0CdoUo2IzSVtQVHa+TXWl56UCaTPzFgQuYomQvfl9tQYpdBCjnU6LL
         L0iZa0XMiKpIJhLwEW8NSBV8d1LnrHrvahO7fIaBla1czvMzkL3EHEYQsfGTevctZpU1
         uQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756143297; x=1756748097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uw/9uBbQYYP/tm1pCiHdt2MwBK9JCxPJmXEEuez5M8=;
        b=YlG2dhDIdW+yHZTUVdzMlGW6riFEoTkTIUBCwOMyRki5/iImZ7ybmL6I1JbgZa4zqs
         FX6fAnwbfBh/3CgGVjjt3HJxG4o2oHVGd+f117zlTCLTiaw0wrOcFTD1jwVoRXfHI7ca
         VOe0v1FucHqztIbdKIyLUZzGggX7JyCCOrVmU8jNfWWnrsJg90rWEZw6iGgEqhbL+0W7
         E/o9V4+5wHeO2+07xfiXo3hmS286MpJJXuYOvmizC0vnJpveOyXJCPD4zduuGFVlrAAP
         FFirDODaP5geRqr3j4mydYAIGcT6UUC81WULokTBOe3RmvjivBWudNSRV/dy64ohNCZN
         r3FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUosSXW985yv2hNoFwxdRAmZjYtTKIJXzLu1HA9K+DLwvcSTMJSwDAsSSgZ767p1mSr8uC5jKBQ@vger.kernel.org, AJvYcCW0G2rhreKZJdBukBB45AzVvNum9f1XxhWMw811w6lADD274tQt9qMKQyyTyW3CLoiTNIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY58ByLEp0TLzPX6TuGDRNL3Qd6oiyviD50kO7ra7kPRqkzPp8
	BPwOxfKzqRVxSIQ0nw22piRw3GxWJSojr2w2WEeKBlTZIkoAA5z15N4=
X-Gm-Gg: ASbGncspGBN1OUFs3tnswYvJHMl2S1TrJ52/H550FxP149b3VC/41KijbmOCxftRthZ
	epXQ0dUUyskWSLm0adHTCQ3CLU2vACzL6VFGvMheGWKbfIiLUX/GSG9Mi35zmv9jTznWHcJkBj3
	EXj3w3e1H8+0pEKnLnZgabr21TGI1VFHruadG1Y/HBsT2lXLb9AopNneOFN2Cb++nQV+sMvRKP9
	MNBi8D0JNu67NIzObWGrzCipGyVrJIkoxH4ZesD1kp8c/6A5+75gKOC9m1/Wpb1qTN6W2AaE8WA
	P0khLWt6SsosjUpiBTopbym76mzYujCtEN2OwdohshJb4mCiM7nKJbyzBCZ32QtxEI7CjRs0dDp
	O8A1Hl5QUZaLTY4xdc7aSK1TfX6FwAlcNf7aohhjpb9I3v1fTDIBB2DmT3ZIYblXiE0tzCUsn5s
	HKTT5PMSpnCqOMfjanIncSAQDptS0dQQvL0XuTPZXJmkVrT6aNzRBcVYL4btvlLIDGa834ZwU3d
	YIG
X-Google-Smtp-Source: AGHT+IHwjdEj2wwT3CsUO4ccxosQQa8SCF4RTlUhjsBv1awtfLMaX9E3sw8/pqIj3XMXYO5tQdCRsw==
X-Received: by 2002:a05:6a00:2d97:b0:770:5031:180b with SMTP id d2e1a72fcca58-77050311f1fmr8053956b3a.21.1756143296649;
        Mon, 25 Aug 2025 10:34:56 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-771ead8f278sm2200781b3a.14.2025.08.25.10.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 10:34:56 -0700 (PDT)
Date: Mon, 25 Aug 2025 10:34:55 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org,
	andrew+netdev@lunn.ch, bpf@vger.kernel.org, netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v2 6/9] xsk: add direct xmit in batch function
Message-ID: <aKyev6DadDuL3Xlo@mini-arch>
References: <20250825135342.53110-1-kerneljasonxing@gmail.com>
 <20250825135342.53110-7-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825135342.53110-7-kerneljasonxing@gmail.com>

On 08/25, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Add batch xmit logic.
> 
> Only grabbing the lock and disable bottom half once and sent all
> the aggregated packets in one loop.
> 
> Since previous patch puts descriptors in xs->skb_cache in a reversed
> order, this patch sends each skb out from start to end when 'start' is
> not smaller than 'end'.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/linux/netdevice.h |  3 +++
>  net/core/dev.c            | 19 +++++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 5e5de4b0a433..8e2688e3f2e4 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3352,6 +3352,9 @@ u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
>  
>  int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev);
>  int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id);
> +int xsk_direct_xmit_batch(struct sk_buff **skbs, struct net_device *dev,
> +			  struct netdev_queue *txq, int *cur,
> +			  int start, int end);
>  
>  static inline int dev_queue_xmit(struct sk_buff *skb)
>  {
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 68dc47d7e700..a5a6b9a199e9 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4742,6 +4742,25 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
>  }
>  EXPORT_SYMBOL(__dev_queue_xmit);
>  
> +int xsk_direct_xmit_batch(struct sk_buff **skbs, struct net_device *dev,
> +			  struct netdev_queue *txq, int *cur,
> +			  int start, int end)
> +{
> +	int ret = NETDEV_TX_BUSY;
> +
> +	local_bh_disable();
> +	HARD_TX_LOCK(dev, txq, smp_processor_id());
> +	for (*cur = start; *cur >= end; (*cur)--) {

skbs support chaining (via list member), any reason not to use that for
batching purposes?

