Return-Path: <bpf+bounces-55249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71B4A7A882
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 19:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E4E116C191
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 17:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC8A2517AE;
	Thu,  3 Apr 2025 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgLh4RGd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939FA250C1F;
	Thu,  3 Apr 2025 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743700878; cv=none; b=avOkBNSew9lIHXK3XjRZfOSh0G2OmWmPpfyb99+CHe6U3GVdB171Q8mtAd5MO6OJlbwohVPMjzAv3s18e/PjGU1xfGEwaZLv2sC+OGoLn93zWSF1hm9o8VlmFkoiB/PhBCVHAYMnMRQKxkffFjLUIeArlfNG5rnpoeNliJenqLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743700878; c=relaxed/simple;
	bh=oNNkfpGAGIC6Rj/xYeHoWwnRfy9RHnR//yCu6fr7RXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UILeAuUj1/ozkLo/TCFyd4r+0NIpbqj9+vdA+SdWUEowipm6AyGcaFbBr2HUG3kurG4hWLumuMLd+rMkSq/jxnyyQFVOqXMRPykKh38+1C3+A5y9DllMwgQ3mTX30F6i57PVPcuBf+c+W0hPEEMEsTVNH74Z+TyhxP3OWUKUc5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgLh4RGd; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-736ad42dfd6so981923b3a.3;
        Thu, 03 Apr 2025 10:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743700875; x=1744305675; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=euhNXLFz4b0ZhIhda+mqm57e9fUemRJmR15xFO1Si/0=;
        b=PgLh4RGd4jsyN0Eq2ELh0inczWmSfLaTKz4vgygK3wRU0f8jWi5t0AVRRjBJOdtHZV
         VLKoXCAWa6imM39K5JtRvt5le/YCo65QSWO7qIkBH58haqXRAQucQFvqqJXN3u/PvkhM
         3YngBFdrGiKc55ESXGAR+bVlkx9ivVwd04g33l9IzYOyPnt70Dj0sNE5SKHrviH4CZYH
         6VDpljhlDZuJQIExRKtG6A9oKbEDL7yNlT7qHVawzXPVW2X9mqZ5ceC+3fGGpmuBsprX
         0C5tOHhplgF1kKzGCs5EniO5SgiQRWlby011SMmV+u5fS62dqfARYSNrmQE7zuLluc1I
         PN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743700875; x=1744305675;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=euhNXLFz4b0ZhIhda+mqm57e9fUemRJmR15xFO1Si/0=;
        b=hPIystpqI+X/a+kp98CW6+35gJ6YmTkd2uuQg52rFb1+1RFFmBFx00tBHADZQtuuM9
         44W6qJHHMp3lFCIaBEq0a/mrNWHcdKh4vm2mfaReeiL2+VSxDo5wMtmWRAXXqj5tke9V
         zgxQgEGD4pi4JTIHNnvzdASuv7PPdhMK4j1hlIbodnC0g7ipLxO9Pjpu5UU8Iq3CUtsr
         LwMkAfh8UPYBDZDO53J4NrbFmqljJAaWA05CDyuHypm+IP7iCdXGKWhgiCag7oAfqyar
         uDi1oquT9dTiLSrOgHnRWRyvo3vgCjKvFCv/b3U7sAMZNIAB8gcShAeWG1zPm50wAH5o
         zj1g==
X-Forwarded-Encrypted: i=1; AJvYcCXduDa3ewSeyhquVS9XV8gbCa4v/dzyhaVBgXU73AliaHSK0DbCg+KopvvFOYdCQyk0uyUkhko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4aw3Hky5o0IRT/N0Ry/L8n49vDFJHDLeYiBjyzX+gRgIkPMe2
	ErHFBJBEKY+eiBaBvelIJTsOJ9rAuDmiiP1+lS1YPNjwmtObwas=
X-Gm-Gg: ASbGncvxCY97Jno8ZKxJKleed1gS/51xV1Dh7m2FLm4bR7MkSKo9YKCc1ViebqIS9xZ
	Q0NlQ59vGECskP/0NAbQfoJKxYN4V66QdDcvTIkDys3wEXAuTLoHrICB67hdX50Vn9m2789ZEg7
	XA4jB1r3McjFzUKlkzmGcxyw9982aJ1FyMEfnk9GSz2l+f4HBw2ohesWBfxMnCz0EN33BmuVF/E
	ehwQ6kY7/Rroa5IuAJ2LuhRUsOlvDyFdA3MobTxZh5Ry+IIh1/VKOdN79mDV/izyjpFo7JX1CPC
	lKMq4wK7mI5t1Jmq0W/EopyLPxDVzviMXAmRg+L1RLAG
X-Google-Smtp-Source: AGHT+IFOac54yi7HzbHiogqYFMaHrIHWswlsiEsK0GFqlFyetTT4/TGUjTa8roOw0oW8AG+IWLB0+Q==
X-Received: by 2002:a17:90a:c88d:b0:2fe:99cf:f566 with SMTP id 98e67ed59e1d1-306a481eeaamr507633a91.13.1743700874671;
        Thu, 03 Apr 2025 10:21:14 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3058494a3dfsm1781230a91.14.2025.04.03.10.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 10:21:14 -0700 (PDT)
Date: Thu, 3 Apr 2025 10:21:13 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com,
	Willem de Bruijn <willemb@google.com>,
	Matt Moeller <moeller.matt@gmail.com>,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Subject: Re: [PATCH bpf 1/2] bpf: support SKF_NET_OFF and SKF_LL_OFF on skb
 frags
Message-ID: <Z-7DiZWkOQ_n5aXw@mini-arch>
References: <20250403140846.1268564-1-willemdebruijn.kernel@gmail.com>
 <20250403140846.1268564-2-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250403140846.1268564-2-willemdebruijn.kernel@gmail.com>

On 04/03, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Classic BPF socket filters with SKB_NET_OFF and SKB_LL_OFF fail to
> read when these offsets extend into frags.
> 
> This has been observed with iwlwifi and reproduced with tun with
> IFF_NAPI_FRAGS. The below straightforward socket filter on UDP port,
> applied to a RAW socket, will silently miss matching packets.
> 
>     const int offset_proto = offsetof(struct ip6_hdr, ip6_nxt);
>     const int offset_dport = sizeof(struct ip6_hdr) + offsetof(struct udphdr, dest);
>     struct sock_filter filter_code[] = {
>             BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, SKF_AD_OFF + SKF_AD_PKTTYPE),
>             BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, PACKET_HOST, 0, 4),
>             BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, SKF_NET_OFF + offset_proto),
>             BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, IPPROTO_UDP, 0, 2),
>             BPF_STMT(BPF_LD  + BPF_H   + BPF_ABS, SKF_NET_OFF + offset_dport),
> 
> This is unexpected behavior. Socket filter programs should be
> consistent regardless of environment. Silent misses are
> particularly concerning as hard to detect.
> 
> Use skb_copy_bits for offsets outside linear, same as done for
> non-SKF_(LL|NET) offsets.
> 
> Offset is always positive after subtracting the reference threshold
> SKB_(LL|NET)_OFF, so is always >= skb_(mac|network)_offset. The sum of
> the two is an offset against skb->data, and may be negative, but it
> cannot point before skb->head, as skb_(mac|network)_offset would too.
> 
> This appears to go back to when frag support was introduced to
> sk_run_filter in linux-2.4.4, before the introduction of git.
> 
> The amount of code change and 8/16/32 bit duplication are unfortunate.
> But any attempt I made to be smarter saved very few LoC while
> complicating the code.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Link: https://lore.kernel.org/netdev/20250122200402.3461154-1-maze@google.com/
> Link: https://elixir.bootlin.com/linux/2.4.4/source/net/core/filter.c#L244
> Reported-by: Matt Moeller <moeller.matt@gmail.com>
> Co-developed-by: Maciej Żenczykowski <maze@google.com>
> Signed-off-by: Maciej Żenczykowski <maze@google.com>
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> ---
>  include/linux/filter.h |  3 --
>  kernel/bpf/core.c      | 21 ------------
>  net/core/filter.c      | 75 +++++++++++++++++++++++-------------------
>  3 files changed, 42 insertions(+), 57 deletions(-)
> 
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index f5cf4d35d83e..708ac7e0cd36 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1496,9 +1496,6 @@ static inline u16 bpf_anc_helper(const struct sock_filter *ftest)
>  	}
>  }
>  
> -void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *skb,
> -					   int k, unsigned int size);
> -
>  static inline int bpf_tell_extensions(void)
>  {
>  	return SKF_AD_MAX;
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index ba6b6118cf50..0e836b5ac9a0 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -68,27 +68,6 @@
>  struct bpf_mem_alloc bpf_global_ma;
>  bool bpf_global_ma_set;
>  
> -/* No hurry in this branch
> - *
> - * Exported for the bpf jit load helper.
> - */
> -void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *skb, int k, unsigned int size)
> -{
> -	u8 *ptr = NULL;
> -
> -	if (k >= SKF_NET_OFF) {
> -		ptr = skb_network_header(skb) + k - SKF_NET_OFF;
> -	} else if (k >= SKF_LL_OFF) {
> -		if (unlikely(!skb_mac_header_was_set(skb)))
> -			return NULL;
> -		ptr = skb_mac_header(skb) + k - SKF_LL_OFF;
> -	}
> -	if (ptr >= skb->head && ptr + size <= skb_tail_pointer(skb))
> -		return ptr;
> -
> -	return NULL;
> -}
> -
>  /* tell bpf programs that include vmlinux.h kernel's PAGE_SIZE */
>  enum page_size_enum {
>  	__PAGE_SIZE = PAGE_SIZE
> diff --git a/net/core/filter.c b/net/core/filter.c
> index bc6828761a47..b232b70dd10d 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -221,21 +221,24 @@ BPF_CALL_3(bpf_skb_get_nlattr_nest, struct sk_buff *, skb, u32, a, u32, x)
>  BPF_CALL_4(bpf_skb_load_helper_8, const struct sk_buff *, skb, const void *,
>  	   data, int, headlen, int, offset)
>  {
> -	u8 tmp, *ptr;
> +	u8 tmp;
>  	const int len = sizeof(tmp);
>  
> -	if (offset >= 0) {
> -		if (headlen - offset >= len)
> -			return *(u8 *)(data + offset);
> -		if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
> -			return tmp;
> -	} else {
> -		ptr = bpf_internal_load_pointer_neg_helper(skb, offset, len);
> -		if (likely(ptr))
> -			return *(u8 *)ptr;

[..]

> +	if (offset < 0) {
> +		if (offset >= SKF_NET_OFF)
> +			offset += skb_network_offset(skb) - SKF_NET_OFF;
> +		else if (offset >= SKF_LL_OFF && skb_mac_header_was_set(skb))
> +			offset += skb_mac_offset(skb) - SKF_LL_OFF;
> +		else
> +			return -EFAULT;
>  	}

nit: we now repeat the same logic three times, maybe still worth it to put it
into a helper? bpf_resolve_classic_offset or something. 

