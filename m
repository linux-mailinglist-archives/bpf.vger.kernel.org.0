Return-Path: <bpf+bounces-75636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EB4C8E0BC
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 12:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FB2E4E24FC
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 11:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B9032AACC;
	Thu, 27 Nov 2025 11:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cu7vGoZH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mBmxYoFL"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CF1CA4E
	for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 11:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764242967; cv=none; b=jf749cAQfLVzAY2b/KlXVpWjLX0gyqMPVk1ux9yv3h49voQJsRtNMfTTMRzK6yjUCd2/6nu9YNvvnAEX5KGThUyVobWXfFkEwx8hitA8gKsGkOGw6xy43JPXtlMKRA3tk/8zQSEeCTxOWdFUqhyNZMrbOSCuM/AirZcXpxwtkaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764242967; c=relaxed/simple;
	bh=Xbjo83qVcjekxim+HDA0ZQ+uPHFdYUuQhXzoPjb23RI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAtNX5FZd+texgmE+Z1kKOb0fj0g0lFk+63H/omcjh3mLjpQAjzKas2i+IQx2f2MBo6sy1WMtd8ceN+tpfGsfGco1oVPEqKiVjyO4l8lM1KIQv4IMYAovC2nAXjhKBVO8oXl3CbCZZuUIpGXUWpXburPFavlDuOVSlwMKLGmxuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cu7vGoZH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mBmxYoFL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764242965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q226UxpZ2lcekLX30EL32R6ZYbE5y2RkR278GNgRSlg=;
	b=cu7vGoZHIN1pBQKeT1ilQ3rDSPv9P9Pf9b6EyUloWUqphc0I7UnLNbwNZR8BH5l4qLo0NY
	AzlaVw2MkfUtoBhN57JAdrz7kzclrKgiRFLJrCXYBmMRCkrAQAw/dEPEDE+KuXUgpGQd+8
	2H2V5EV9iCOXaEBkqYEhYBFZv4A+2uo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-BfgxNyMxOyOO-ZXBSyUIEA-1; Thu, 27 Nov 2025 06:29:23 -0500
X-MC-Unique: BfgxNyMxOyOO-ZXBSyUIEA-1
X-Mimecast-MFC-AGG-ID: BfgxNyMxOyOO-ZXBSyUIEA_1764242962
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477c49f273fso5617535e9.3
        for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 03:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764242962; x=1764847762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q226UxpZ2lcekLX30EL32R6ZYbE5y2RkR278GNgRSlg=;
        b=mBmxYoFLYhOoR+NqyMEfbz0XjpEWLPHQAGyNcXETr8LxEezDGaIiL5jdQCMFcT6doE
         oLZT8/VqmX3UBfDAiBcQiSLQ53T3dXjV0VVdbOm+J8W9K0QqBwc8+jxLtQ5rma3W31vc
         Fr/d36zbjcOlMU8Mxysul5EDfLikxD602Hdw7s9LyZyZ1bvNGdG+gNasm1kaCycNhYI4
         LtqSR+IyQ2adS/0URXKDuDAetuyZWNXTWniuRp7boGunavdlntNtD/KCfi0tlF0dUvRw
         gjH2TAL5eNpXatyo+nr0MTIQ5iIaBR0pkkPx9+lD2Jq9FtKKeokWoiATpIrxS0pR0j1X
         wxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764242962; x=1764847762;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q226UxpZ2lcekLX30EL32R6ZYbE5y2RkR278GNgRSlg=;
        b=Elbo6+8Cij3DVrS953qDnhSrsEuTlz4LSjEfc0VQo5oStIbhEWSZVLxPgJzjELE9BR
         jie73WkTyrNDTQX+fqRj/yPv7FamzSVUIyIvC2TNwHAMjY9D9Iw4uww/QJEO/gyVM1XT
         s5LwgWIma+LbAUZbjiH6JQCP8Ru/tlynvBFU/1AQyyYhbbuxAc/4wcM4rKdmUoTbdw1X
         E+5tQxpzP+urkRy8jekeyOis2CpqV76M53HZxQIJIMlutcMCjdAwDYQOHRukrRwGyYNP
         Y6Mj2k3ZDEoYMNeA6AcU4KOJ1yIJvomPn5Pc+cU+wW115f2TB5OpTDo5voYoQg79bphw
         zvcg==
X-Gm-Message-State: AOJu0YzvFgpQWn1BoSa0TY9EEdJtoFKUS3nOVki5HVVUYc08AgCQeTGu
	b8jxiP848jmT5Jdw5YwOWgKcYw35Hib272h8TW8TOltGwKfF3E5GTXHoT2g0p2sXEB6ad01I+Zy
	JBU+6U3RpbAn3u1k7eEIyoeBnqaXLOY+5z/0QYrvrf4DDEECZsD5IQw==
X-Gm-Gg: ASbGncutEV/zXWlqGQSBPsOV2yF2AOK3NCI7yuRoinXURJmJkwgWSD1Zy15M2u1Qbtl
	9LrLv3I4UVXIN60NNtcWqlGAZUZptRvZV1UKKpBFMJ5MvIlvKlI7TOjBqk87hZQlMuOQP+XN7Fm
	EhKm0StedI0U2BTtNr7oFPZmGatMcMOE9v9GIbi8udxAjYlTt4d9h5NfoS8SfYBSLiAyDIS9DkC
	MxgjkCA6ipiCatnLv1r/STfITGhjAqcfHqplns/Xan/pS1bF8Gi/TYbCaz66tG0GUBwjohSvj5z
	TRQjZQyFK11hqPtRJqkAqSFw93HHToP0vgZAJDhDgEjia2Ql1HTy5wsQo1TpTL0uQkwTutahOru
	p+gJGkzoOmp3kHg==
X-Received: by 2002:a05:600c:3110:b0:477:b734:8c52 with SMTP id 5b1f17b1804b1-477c0185bebmr247680725e9.14.1764242962441;
        Thu, 27 Nov 2025 03:29:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGV57wjUglDLQE7qqkiRaOB2mEMR0gTX1X1M1loqMP9QSzYd01vth1pFvUgzo1XoOBJ3gazqg==
X-Received: by 2002:a05:600c:3110:b0:477:b734:8c52 with SMTP id 5b1f17b1804b1-477c0185bebmr247680065e9.14.1764242961747;
        Thu, 27 Nov 2025 03:29:21 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790add60e2sm92649475e9.6.2025.11.27.03.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 03:29:21 -0800 (PST)
Message-ID: <4c645223-8c52-40d3-889b-f3cf7fa09f89@redhat.com>
Date: Thu, 27 Nov 2025 12:29:19 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] xsk: remove spin lock protection of
 cached_prod
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20251125085431.4039-1-kerneljasonxing@gmail.com>
 <20251125085431.4039-4-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251125085431.4039-4-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/25 9:54 AM, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Remove the spin lock protection along with some functions adjusted.
> 
> Now cached_prod is fully converted to atomic, which improves the
> performance by around 5% over different platforms.

I must admit that I'm surprised of the above delta; AFAIK replacing 1to1
spinlock with atomic should not impact performances measurably, as the
thread should still see the same contention, and will use the same
number of atomic operation on the bus.


> @@ -585,11 +574,9 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
>  	spin_unlock_irqrestore(&pool->cq_prod_lock, flags);
>  }
>  
> -static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
> +static void xsk_cq_cached_prod_cancel(struct xsk_buff_pool *pool, u32 n)
>  {
> -	spin_lock(&pool->cq_cached_prod_lock);
>  	atomic_sub(n, &pool->cq->cached_prod_atomic);

It looks like that the spinlock and the protected data are on different
structs.

I wild guess/suspect the real gain comes from avoiding touching an
additional cacheline.
`struct xsk_queue` size is 48 bytes and such struct is allocated via
kmalloc. Adding up to 16 bytes there will not change the slub used and
thus the actual memory usage.

I think that moving the cq_cached* spinlock(s) in xsk_queue should give
the same gain, with much less code churn. Could you please have a look
at such option?

/P


