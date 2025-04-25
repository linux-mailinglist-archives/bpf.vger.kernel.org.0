Return-Path: <bpf+bounces-56701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 843A1A9CD8A
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 17:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883201BC6D0C
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 15:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DD928F526;
	Fri, 25 Apr 2025 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWI7xSIm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EE51401B;
	Fri, 25 Apr 2025 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745596004; cv=none; b=pqwjbMh45fxJmTY5p9EV2p8ok0ZIrbNVbD9eUFd2Ar8q0j/L2vGaQoWAZj0YRgpPNZA4WinpB+QqnAfnTX1TpISPio/6T2ST4J3bG7PTdfNrCbTLcS5Lz9rLryUipWRiM6D6znVpiUhjXszlFX3fIuUVaijdLmfzWzrPQJfyCwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745596004; c=relaxed/simple;
	bh=jhP8pFJFcwBKmqgVvkl1aJ2stKtsos/RlAxiW6YqGoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f+SqZ1DsSssg2FCFlCIAMSULg0OUnirEz29zo17MhRpj7pAsGuH1bjC+S7Kx9z/kfDQoBRoYE8QsDD0tgCS6+bwSMW9MmTcgddf8Wj/MRqPhi2LBfyASfBHXaWPS9MCezwK8/0YQF/p7yKlo7spwP7w92gHp/mDiF8LU5xL9g2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWI7xSIm; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-736bfa487c3so2027504b3a.1;
        Fri, 25 Apr 2025 08:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745596001; x=1746200801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O0oyziaAOyLAcOk9gAqKZJBNWc6/cPKz3UDQ0hjmN14=;
        b=PWI7xSImnUPzYSWqXYOkQZaZXBBLisPDepkhFWxU/xS2MH/eyCzYN8tQqd1D0LvNJa
         2WeCe+KeTXtnzBbQPUV09PUqP/CA2ac6OFjDEfoJZ36Zh/YK+N6KjePr/kTzretqmm+w
         Da4h0zbb7g2Fdrr+8PaytOPkkmqyuNSnxxd7Gn9eaOJ4PrC+yRC/SE78VR2w6cjUD5h8
         prvya+Kc5sXhFF6Ghq9N8cSX/PytG+Qi6vhns41alOJXkZgH1m4bSoTAaksB42HxWudt
         N2i6IPgQwaNa+klRUTubUl6QWh8kd0+2eN/y1h0MJ1Gyb2agFD5fK+eWoU8xqn5F+VV2
         wR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745596001; x=1746200801;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O0oyziaAOyLAcOk9gAqKZJBNWc6/cPKz3UDQ0hjmN14=;
        b=ciClwsJcWIRGfP7eKtMOvtcTPFaP0RWzRvciALXx+7eFmGtH7VtsSUdn4HDkOCSrX8
         QLcPca1NK50ge3U+4WcXz1gN+Y3FB14FSrC+6IsuvCRaZ0/Is6SeMmVORBoqfjz9p9sx
         LAQvf/WpMtxOTMK9dIgE5Ukr2cl9CSE250jqFGH59C/2vlSkerjt30fwoytP8DDHSfy4
         6suRI6dFYiRdafCA0G+UICfLlSHbKMaPLWFcWyHomkfGTOJRlwz+JvUCA6C6m9Hy3PsB
         VSo2z9pZHK4Wwn3VL7K0M7QyV96e/RYcZMkmr8s42ADQlyhvgJrvSN0ub5dx6oJeb3h3
         LwnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC/xCDgH+u8BQY3Rejfwua2UW/IaVjSbMcL5AhfOTLo8wijtrfQCkG85HbSspRWdO8QXY/aseg3Dk7pNNy@vger.kernel.org, AJvYcCXip1/78hX+X0DqphPybbHVJ7YuzyO3/A8p1IUnyGrVxZYmY3E223kXWqyjyL34s2n3tFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YywxRVLFdm/V6CLBddL0fRsHdFakSQrJfYa2FMMMnuCmnT2DpLQ
	JnCeLv8AfpcXpejuXa4AvlJlhkgxroH72ttGzugu5RUppIlWYamxClraZqWi
X-Gm-Gg: ASbGnctvLap//qTQEzEKXAlM7SXcfWQd6VCKigtsEZwxOWD6b+0CjTQLRFkYiy3MQzy
	vESN3xJ+S9betWMlOFznng2BQSuSqp3MeMOgapq2JYcLcAs/hif0cNp6TXScTHuxIPPC47An8vp
	C8v3R11Ms0+x6u2FVuP97N0kXVQADGAgxHM1oSmSkZfKBmK9VPvZMWDKqC01Zk2gYmO55JJxNp5
	r41IIJxL1bDvtO/v3YzhPTMN3BGZ9kaNElDxuXg0zcLXQDDoE/AhkWRX/g9xElzRD5fQcGqqVVf
	9f0nr9SRwh+vbtK12nK6rnm8Q6mTdGZyhSxlxDtJFxTFpeDhluJGR86JVgmjzHtcMCOoLq28c7I
	BFiHbE0p+sj/cGGqrMUU=
X-Google-Smtp-Source: AGHT+IG9TW8cW87auP5BlEdU5WIaXA04pqBbguxPDnyixb+I1bwF2Ef/mftKrl1hMR+zWJlnM+W2CQ==
X-Received: by 2002:a05:6a00:2311:b0:736:62a8:e52d with SMTP id d2e1a72fcca58-73fd74be6ffmr3279577b3a.12.1745596001228;
        Fri, 25 Apr 2025 08:46:41 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:8bc6:71ac:67d1:e6ee? ([2001:ee0:4f0e:fb30:8bc6:71ac:67d1:e6ee])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a9a993sm3430521b3a.144.2025.04.25.08.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 08:46:40 -0700 (PDT)
Message-ID: <7a6f896f-fade-47ed-b101-72be264dcf2b@gmail.com>
Date: Fri, 25 Apr 2025 22:46:35 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] xsk: respect the offsets when copying frags
To: netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250423101047.31402-1-minhquangbui99@gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20250423101047.31402-1-minhquangbui99@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/25 17:10, Bui Quang Minh wrote:
> Add the missing offsets when copying frags in xdp_copy_frags_from_zc().
>
> Fixes: 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion")
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>   net/core/xdp.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index f86eedad586a..a723dc301f94 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -697,7 +697,8 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
>   	nr_frags = xinfo->nr_frags;
>   
>   	for (u32 i = 0; i < nr_frags; i++) {
> -		u32 len = skb_frag_size(&xinfo->frags[i]);
> +		const skb_frag_t *frag = &xinfo->frags[i];
> +		u32 len = skb_frag_size(frag);
>   		u32 offset, truesize = len;
>   		netmem_ref netmem;
>   
> @@ -707,8 +708,8 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
>   			return false;
>   		}
>   
> -		memcpy(__netmem_address(netmem),
> -		       __netmem_address(xinfo->frags[i].netmem),
> +		memcpy(__netmem_address(netmem) + offset,
> +		       __netmem_address(frag->netmem) + skb_frag_off(frag),
>   		       LARGEST_ALIGN(len));
>   		__skb_fill_netmem_desc_noacc(sinfo, i, netmem, offset, len);
>   

I know it's very unlikely but do we need to 
kmap_local_page(skb_frag_page(frag) before using 
__netmem_address(frag->netmem) to make sure the frag's page is mapped? 
Or it is impossible that the frag's page to be highmem and unmapped? Thanks,
Quang Minh.

