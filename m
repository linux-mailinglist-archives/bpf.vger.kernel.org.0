Return-Path: <bpf+bounces-56767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFB5A9D7AE
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 07:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39A31BA0FD5
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 05:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA501AA1E0;
	Sat, 26 Apr 2025 05:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJiFvlqW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4882613A244;
	Sat, 26 Apr 2025 05:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745646062; cv=none; b=j6MNkaY4Hd/8IvSScm007oWRJt8jivC0/lBHeAL87C2kSMoU1LDHNqhhl17IYDbf63yZbHAhAuIwQr4HDJdwbPz49J2aCQA5wOTIKLrQxhstdoUZEDRl7djhTAwN1eV41ZrhyORooO4VcPLTQHDvLzXN+LIVPclKzD4OrS6V56g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745646062; c=relaxed/simple;
	bh=HH3A7mhgMlifCWiaK7W/MvoR6SiNymYOgMuSdnRfVrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HHShV1su9J+2N/V99ZMZSslpR104Es1kJmAzTHvPAfwdxCL2Wt/JftMhR2VLLnzZzKAv16nrSv0PWVo/mpQoSG+guxc8+3/vNEWJ3kQ8vrW7zK17mS87m581hevcq8QWoomjNqjTGF+2K2zN+zxDi/zEWQ3dDsSG3Em946z0xaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJiFvlqW; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-af908bb32fdso2673500a12.1;
        Fri, 25 Apr 2025 22:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745646060; x=1746250860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j6M8sMT/t/zz2ZTs7d36Jp6MHx+pTl8jB+zVeFB9UZU=;
        b=BJiFvlqWF0r1PZNZWZw7H5BrS5PeKiNVutOtnZnHli3Hzd9p+pw8+S18SfCCQ+aEr9
         lr8SCYlTVvso+7ogK/638p5uedHlP4MsFm9yfGK4M2YxIEnwYuO/2cpXBGxAKfSe1Y8F
         wti+DAQrKoKWp2m3mWIb+4Ulg3fWDXDU5Dhv8pS6C5Ekj8GsXtc/1/jGi5eivqRDEprS
         g3ydD0Bx0JRp5eJRxee8tstoF9phfflMVKe1xhjrzZVrhKIJy7YNgmrBwGOqm6urxx+Z
         RNHZrT2/uyDk6PaLfgXiWH6apyOjH/g4VxBn4mUCy/v47z82guKhMim/aBvHHcMl8LCD
         dYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745646060; x=1746250860;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j6M8sMT/t/zz2ZTs7d36Jp6MHx+pTl8jB+zVeFB9UZU=;
        b=Wv9IhXhL1dZOvPSfeV2pEF7BEPlyG67UyuLGUjAIhUKh5GoogtKYHs33vNhXsS7d6R
         kp90M+ZOgurp9tIbnP6yYkkOSPYYW3D3np8aSemApig3yxF6rw9JDBBYi3lf0HfOIJMt
         kydMMFKv97MV9FB48jea0RBm+162ACx967z2twQfnTf+2js2KNFTiuQe4DPqZOBoVZsp
         h7jY6tYtCLS7NMPpOTh/wdk3CSGccPq8FLiMBq7xN9JDwvONav98Xzvkg26B0IN9mm/G
         4Kqi7mfQy65o66dPrbK5V6Puq4Ex+OzaLPRhIZeLCOYpo/kIy4te/L+7tO2k/r6RvEZu
         66xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpX4bp5AgqKHQKfNBC94mvSaq/USPId4FeErd55jYCryBTjofYpY2OwGOSF0rKMn8/5cbtG9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUzKEnyyNNPVS+fCT8PlQMn3MKnUr3z5TvzJQ1k0tdd8LO386k
	kB5e6P1sGoeGT5bqP/aqM835iEyczC/apjnJRcqiZ16pvJGLXD62Lihscg==
X-Gm-Gg: ASbGncuHitc0l0+ccaH6vJaAu/4HjscX27cHZ6E3fjxmnk/s/pkQXirc8BDbhArNyDu
	GevjUwRoMXMl9Hy27z2tItoF24+dtriA2uYc1sT0r/ITIPD7SJq4d8BCZjmFRoQphS9At3+lOKy
	KFm53FkwooNQTtTUUluXo2e+kltuBqv9RALmx8KOF+vzAZeW6p89t2aItN2gRDb+WQVl0Ym3DNd
	DuP4Mx2JFUa7kT/QhJ5G0HdgFAJz/dP6HN0ZdBUVQjPMcZhlw9SS/rKEXMPRIO13xaA1T5s6Xcf
	hLDLs20Hm9EIpZAs1KSOKmcRrn6Rx6UcIhfuIM5fHhH16JIthTwVogOWNtksVDL2Zzqzz1JsVh8
	YFDFIoJ2Fa37ReibfQg0Od+LDjWuiYg==
X-Google-Smtp-Source: AGHT+IEHNwsRURSvYAbOHEpd/47BldiPls+IGwQEVqteHy87D0s71BxFT1vuHRvBs1gsshcSwtG2aA==
X-Received: by 2002:a17:90a:fc46:b0:302:fc48:4f0a with SMTP id 98e67ed59e1d1-309f8786e57mr7306071a91.0.1745646060331;
        Fri, 25 Apr 2025 22:41:00 -0700 (PDT)
Received: from [192.168.99.14] (i60-34-11-52.s41.a013.ap.plala.or.jp. [60.34.11.52])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22db51050b8sm42226335ad.202.2025.04.25.22.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 22:40:59 -0700 (PDT)
Message-ID: <c3cdf4bc-f880-4eb4-8a4f-5eef2d670501@gmail.com>
Date: Sat, 26 Apr 2025 14:40:54 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V7 2/2] veth: apply qdisc backpressure on full
 ptr_ring to reduce TX drops
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: bpf@vger.kernel.org, tom@herbertland.com,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 dsahern@kernel.org, makita.toshiaki@lab.ntt.co.jp,
 kernel-team@cloudflare.com, phil@nwl.cc, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
References: <174559288731.827981.8748257839971869213.stgit@firesoul>
 <174559294022.827981.1282809941662942189.stgit@firesoul>
Content-Language: en-US
From: Toshiaki Makita <toshiaki.makita1@gmail.com>
In-Reply-To: <174559294022.827981.1282809941662942189.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/04/25 23:55, Jesper Dangaard Brouer wrote:
> In production, we're seeing TX drops on veth devices when the ptr_ring
> fills up. This can occur when NAPI mode is enabled, though it's
> relatively rare. However, with threaded NAPI - which we use in
> production - the drops become significantly more frequent.
> 
> The underlying issue is that with threaded NAPI, the consumer often runs
> on a different CPU than the producer. This increases the likelihood of
> the ring filling up before the consumer gets scheduled, especially under
> load, leading to drops in veth_xmit() (ndo_start_xmit()).
> 
> This patch introduces backpressure by returning NETDEV_TX_BUSY when the
> ring is full, signaling the qdisc layer to requeue the packet. The txq
> (netdev queue) is stopped in this condition and restarted once
> veth_poll() drains entries from the ring, ensuring coordination between
> NAPI and qdisc.
> 
> Backpressure is only enabled when a qdisc is attached. Without a qdisc,
> the driver retains its original behavior - dropping packets immediately
> when the ring is full. This avoids unexpected behavior changes in setups
> without a configured qdisc.
> 
> With a qdisc in place (e.g. fq, sfq) this allows Active Queue Management
> (AQM) to fairly schedule packets across flows and reduce collateral
> damage from elephant flows.
> 
> A known limitation of this approach is that the full ring sits in front
> of the qdisc layer, effectively forming a FIFO buffer that introduces
> base latency. While AQM still improves fairness and mitigates flow
> dominance, the latency impact is measurable.
> 
> In hardware drivers, this issue is typically addressed using BQL (Byte
> Queue Limits), which tracks in-flight bytes needed based on physical link
> rate. However, for virtual drivers like veth, there is no fixed bandwidth
> constraint - the bottleneck is CPU availability and the scheduler's ability
> to run the NAPI thread. It is unclear how effective BQL would be in this
> context.
> 
> This patch serves as a first step toward addressing TX drops. Future work
> may explore adapting a BQL-like mechanism to better suit virtual devices
> like veth.
> 
> Reported-by: Yan Zhai <yan@cloudflare.com>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

Reviewed-by: Toshiaki Makita <toshiaki.makita1@gmail.com>


