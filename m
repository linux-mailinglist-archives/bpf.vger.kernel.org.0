Return-Path: <bpf+bounces-55252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1BFA7A8AD
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 19:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03CCA1894996
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 17:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FD9252904;
	Thu,  3 Apr 2025 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsexuJt+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5DE251797;
	Thu,  3 Apr 2025 17:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743701749; cv=none; b=Y1E6NN8eQ0lXEJINbCn2fmp5qRAGAhFR0Eo9sNH9VDu399bht8oTzCI8aiW3z35Gh9v4+9yk+ZKdjtVev5iXUFQksuR5rhU12M9QZXGptpCgieLQOFheJvAjyGW2loVrxXjY1L4IHiA3M8YjkVietuP2ds/D/VWDHqLcp0HpVW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743701749; c=relaxed/simple;
	bh=oMk+7lvNEhjiMut8JW/CHwl+QWTL4/BCdip2Xi1Ch9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RftGL9kcXSMHO3O8zoxEZc8zt+LCBeU0g7KN07zR9jFf/woUeWL/nvYJ6ylt2ZyafGc27raVsVB1BoQurrDSsNYfpz7AQnp2gBy/0Pr5ZRm2S3qbMpfcyTd3QFbVKw5k1cWcDLsegDiyYSVDKeuHYCne7JBZePs24WyMVjN3mFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsexuJt+; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-af579e46b5dso826962a12.3;
        Thu, 03 Apr 2025 10:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743701747; x=1744306547; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UVhUfdlP+iQuIUff3BY5YX7mRKL7M5eX9c4KMZsdcdM=;
        b=YsexuJt+zKD1ktCO+CfG+z7+d5DaPQYLGN8ruLg1jWk626FlAbOd20rz7t5saSFUj5
         0iQEnqECj698O/wKEx2Zu3ScIcB7ZJuoT+sJqxQGiX9QKR3/4eU0ItsVZs4w4Ga0CoUg
         5kRPoq6lEKFyNzd68tHny/1bjQQyY8/PS68WitzKe5nmW8cTLKU74hgOOSDWxbk7wDbS
         QD7W/6EPU6+Vb4KxGU98Aw6NBAVwam9Rq3hQNx2n2fKnrz5XusJKP34I2mbDBqYcMg/k
         SAesa2etHShyHPgT/wfpk5pKX+pAgXlOPMmO4Mz874O3W9dyTnabx8UQjjqogh/zwgkI
         KuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743701747; x=1744306547;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UVhUfdlP+iQuIUff3BY5YX7mRKL7M5eX9c4KMZsdcdM=;
        b=GIYEMZS8Wb34SdtS5Zqz1FPFfIT04coVdnY/w8c88v+ktBnI4UsF+wkmrgNibq2XQt
         skMF3hz1T4Kc9xvawby7s96DXDEaFcaahFMSrxiDFttfY4TQ/31geAha4QEqbHAYHt+N
         6G6pBODtUzqYFcWB1htekxvsQwJd1UXDBmyfo5sXKk08n1hyV29l7mtUaZvZOhF6EAAP
         WmamKLPkCikfQ7N5JW8IDi2uRM1lZc6mRxAxmjFqm8ixU/dZEgrJu5r069aSzKuwJRIM
         azuObyC5oRbPxJKPa0JYmo/oSqaMw8RNKe4FTeUkgVrBnU0aUW8j754CMWIZYA0/URyf
         TVzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaKKuPAtF92Cl/9DWXRCeeH+kpk/zIvpAxm5RWM/HDvBbLESA9jL1gbw1Mwp739wghrlLtoYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ecaEBRjVkZ7q6EEYxid+hZhDp56cMzz1OcgfqKWBMWDzovhC
	QqPSbrnNMzqvYzcn5isNEIiKuZZ4gr8/6+0QYmJan3iONXdwedk=
X-Gm-Gg: ASbGncsHb2PhniyXLt5NCgHYWL5xs1czMIccVYHSCmEztmOodp8E5F6/nJbLuODPXon
	twTqJG/Y2IdenEsyJ8tFW1wipEJzlvImMhBVu3qoUjFpmZr7VTd+EA87RJmVSfZ9wcTQZjE5Uh9
	R5C5+0tU1uz8qDEglcvniyoR1XAoWMjkCPAIz5FYbdsyIyut7+jiHyfhV1gzb0C/aHRap4Wq21B
	J9lX0N0TsXhbm/g7jBOLfxMAvSt8cnQKU2FT5+jLSflNW34mjZ6yAB1sVmAW3JeZK0+mMgMpFAb
	rKUyYKc03SvAz96CxfmLlAWGPBCl+3EvGCwuAqcWeEYO
X-Google-Smtp-Source: AGHT+IHDKVmJx7brFP049dEEyF/n2ioenODN4zQp915MODzp2Khj+XwI/zA02NT3HWtYAFMyQjZsRw==
X-Received: by 2002:a17:90b:2d45:b0:2fe:b937:2a51 with SMTP id 98e67ed59e1d1-306a499055dmr424462a91.33.1743701746825;
        Thu, 03 Apr 2025 10:35:46 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2297866e90dsm17230895ad.196.2025.04.03.10.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 10:35:46 -0700 (PDT)
Date: Thu, 3 Apr 2025 10:35:45 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com,
	Willem de Bruijn <willemb@google.com>,
	Matt Moeller <moeller.matt@gmail.com>,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Subject: Re: [PATCH bpf 1/2] bpf: support SKF_NET_OFF and SKF_LL_OFF on skb
 frags
Message-ID: <Z-7G8cBIW7-dVeH8@mini-arch>
References: <20250403140846.1268564-1-willemdebruijn.kernel@gmail.com>
 <20250403140846.1268564-2-willemdebruijn.kernel@gmail.com>
 <Z-7DiZWkOQ_n5aXw@mini-arch>
 <67eec501d0d58_14b7b229490@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67eec501d0d58_14b7b229490@willemb.c.googlers.com.notmuch>

On 04/03, Willem de Bruijn wrote:
> Stanislav Fomichev wrote:
> > On 04/03, Willem de Bruijn wrote:
> > > From: Willem de Bruijn <willemb@google.com>
> > > 
> > > Classic BPF socket filters with SKB_NET_OFF and SKB_LL_OFF fail to
> > > read when these offsets extend into frags.
> > > 
> > > This has been observed with iwlwifi and reproduced with tun with
> > > IFF_NAPI_FRAGS. The below straightforward socket filter on UDP port,
> > > applied to a RAW socket, will silently miss matching packets.
> > > 
> > >     const int offset_proto = offsetof(struct ip6_hdr, ip6_nxt);
> > >     const int offset_dport = sizeof(struct ip6_hdr) + offsetof(struct udphdr, dest);
> > >     struct sock_filter filter_code[] = {
> > >             BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, SKF_AD_OFF + SKF_AD_PKTTYPE),
> > >             BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, PACKET_HOST, 0, 4),
> > >             BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, SKF_NET_OFF + offset_proto),
> > >             BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, IPPROTO_UDP, 0, 2),
> > >             BPF_STMT(BPF_LD  + BPF_H   + BPF_ABS, SKF_NET_OFF + offset_dport),
> > > 
> > > This is unexpected behavior. Socket filter programs should be
> > > consistent regardless of environment. Silent misses are
> > > particularly concerning as hard to detect.
> > > 
> > > Use skb_copy_bits for offsets outside linear, same as done for
> > > non-SKF_(LL|NET) offsets.
> > > 
> > > Offset is always positive after subtracting the reference threshold
> > > SKB_(LL|NET)_OFF, so is always >= skb_(mac|network)_offset. The sum of
> > > the two is an offset against skb->data, and may be negative, but it
> > > cannot point before skb->head, as skb_(mac|network)_offset would too.
> > > 
> > > This appears to go back to when frag support was introduced to
> > > sk_run_filter in linux-2.4.4, before the introduction of git.
> > > 
> > > The amount of code change and 8/16/32 bit duplication are unfortunate.
> > > But any attempt I made to be smarter saved very few LoC while
> > > complicating the code.
> > > 
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Link: https://lore.kernel.org/netdev/20250122200402.3461154-1-maze@google.com/
> > > Link: https://elixir.bootlin.com/linux/2.4.4/source/net/core/filter.c#L244
> > > Reported-by: Matt Moeller <moeller.matt@gmail.com>
> > > Co-developed-by: Maciej Żenczykowski <maze@google.com>
> > > Signed-off-by: Maciej Żenczykowski <maze@google.com>
> > > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > ---
> > >  include/linux/filter.h |  3 --
> > >  kernel/bpf/core.c      | 21 ------------
> > >  net/core/filter.c      | 75 +++++++++++++++++++++++-------------------
> > >  3 files changed, 42 insertions(+), 57 deletions(-)
> > > 
> > > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > > index f5cf4d35d83e..708ac7e0cd36 100644
> > > --- a/include/linux/filter.h
> > > +++ b/include/linux/filter.h
> > > @@ -1496,9 +1496,6 @@ static inline u16 bpf_anc_helper(const struct sock_filter *ftest)
> > >  	}
> > >  }
> > >  
> > > -void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *skb,
> > > -					   int k, unsigned int size);
> > > -
> > >  static inline int bpf_tell_extensions(void)
> > >  {
> > >  	return SKF_AD_MAX;
> > > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > > index ba6b6118cf50..0e836b5ac9a0 100644
> > > --- a/kernel/bpf/core.c
> > > +++ b/kernel/bpf/core.c
> > > @@ -68,27 +68,6 @@
> > >  struct bpf_mem_alloc bpf_global_ma;
> > >  bool bpf_global_ma_set;
> > >  
> > > -/* No hurry in this branch
> > > - *
> > > - * Exported for the bpf jit load helper.
> > > - */
> > > -void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *skb, int k, unsigned int size)
> > > -{
> > > -	u8 *ptr = NULL;
> > > -
> > > -	if (k >= SKF_NET_OFF) {
> > > -		ptr = skb_network_header(skb) + k - SKF_NET_OFF;
> > > -	} else if (k >= SKF_LL_OFF) {
> > > -		if (unlikely(!skb_mac_header_was_set(skb)))
> > > -			return NULL;
> > > -		ptr = skb_mac_header(skb) + k - SKF_LL_OFF;
> > > -	}
> > > -	if (ptr >= skb->head && ptr + size <= skb_tail_pointer(skb))
> > > -		return ptr;
> > > -
> > > -	return NULL;
> > > -}
> > > -
> > >  /* tell bpf programs that include vmlinux.h kernel's PAGE_SIZE */
> > >  enum page_size_enum {
> > >  	__PAGE_SIZE = PAGE_SIZE
> > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > index bc6828761a47..b232b70dd10d 100644
> > > --- a/net/core/filter.c
> > > +++ b/net/core/filter.c
> > > @@ -221,21 +221,24 @@ BPF_CALL_3(bpf_skb_get_nlattr_nest, struct sk_buff *, skb, u32, a, u32, x)
> > >  BPF_CALL_4(bpf_skb_load_helper_8, const struct sk_buff *, skb, const void *,
> > >  	   data, int, headlen, int, offset)
> > >  {
> > > -	u8 tmp, *ptr;
> > > +	u8 tmp;
> > >  	const int len = sizeof(tmp);
> > >  
> > > -	if (offset >= 0) {
> > > -		if (headlen - offset >= len)
> > > -			return *(u8 *)(data + offset);
> > > -		if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
> > > -			return tmp;
> > > -	} else {
> > > -		ptr = bpf_internal_load_pointer_neg_helper(skb, offset, len);
> > > -		if (likely(ptr))
> > > -			return *(u8 *)ptr;
> > 
> > [..]
> > 
> > > +	if (offset < 0) {
> > > +		if (offset >= SKF_NET_OFF)
> > > +			offset += skb_network_offset(skb) - SKF_NET_OFF;
> > > +		else if (offset >= SKF_LL_OFF && skb_mac_header_was_set(skb))
> > > +			offset += skb_mac_offset(skb) - SKF_LL_OFF;
> > > +		else
> > > +			return -EFAULT;
> > >  	}
> > 
> > nit: we now repeat the same logic three times, maybe still worth it to put it
> > into a helper? bpf_resolve_classic_offset or something. 
> 
> I definitely tried this in various ways. But since the core logic is
> only four lines and there is an early return on error, no helper
> really simplifies anything. It just adds a layer of indirection and
> more code in the end.

More code, but at least it de-duplicates the logic of translating
SKF_XXX_OFF? Something like the following below, but yeah, a matter
of preference, up to you.

static int bpf_skb_resolve_offset(skb, offset) {
	if (offset >= 0)
		return offset;

	if (offset >= SKF_NET_OFF)
		offset += skb_network_offset(skb) - SKF_NET_OFF;
	else if (offset >= SKF_LL_OFF && skb_mac_header_was_set(skb))
		offset += skb_mac_offset(skb) - SKF_LL_OFF;

	return -1;
}

BPF_CALL_4(bpf_skb_load_helper_8, const struct sk_buff *, skb, const void *,
           data, int, headlen, int, offset)
{
	offset = bpf_skb_resolve_offset(skb, offset);
	if (offset < 0)
		return -EFAULT;

	...
}

