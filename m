Return-Path: <bpf+bounces-55250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D95CA7A890
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 19:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74B787A6B3B
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 17:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C292517A0;
	Thu,  3 Apr 2025 17:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ql4S79QZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B281547C3;
	Thu,  3 Apr 2025 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743701253; cv=none; b=RGwbmwSPvPh7Ki7UWo1ohG92WOCcFBoHE1Cgp2GekrXe6ayJ3Tz21QwTvAaNd3IMXKkMgflt4j2c69lrRsu33ck1d5HNUZM3tcQksr3WrudoyLKTHLhXu71rSlufGdyD1AJ4kab6+VuqL9rFMFMZ7nFj3PDasn0GutsXF5wPygg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743701253; c=relaxed/simple;
	bh=ib5XpHuOj6kL0sxX7V9GhUvNcr7INuZXyyPbobh7uMU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=aenXq9Z9GHuszaMCDS6p9mtnCl0sVjn/5C3SBWKvCNKedeRiRatiPWRGB1lWHzR1Un3BFTDnz9QowUx35FYxmjwiWtAAuS9iOaBUmj3X4fXY6zaMPO4lVzsyAxQ4fCDCjBz7G+trG6u8p2HwG52PIyDvi4tIKT35xTfZrD23778=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ql4S79QZ; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-476805acddaso12743021cf.1;
        Thu, 03 Apr 2025 10:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743701251; x=1744306051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRa6N8ZbW7cTAWXN+Dp/4J0GLXk+qS4mg9kXOp4Nr3M=;
        b=Ql4S79QZmCzZHEXjFujUSirc+KRFGbGnaCb+6DeiY4izpi0+WsIFiIixMtVOsfe2hx
         nikDOMYqHQPWcWFxU9OX7OC6mtBYr0uflaJE1nmKzUVH6sB3s5wktJjO9dcEG/cZg+k1
         sG2XD8LSw2XxBrZBgsQ/bBYF63lonQEFJgw0Idqc1EeIeJ2za71uy149XBgTpKsgXDc2
         emttvolNKLvxBdbAbFwsQgCoNBHMAijpJVO0ZsB7xqMN6z5BOX5wnFf5Z4SNy/Y55KSe
         nrQaBa5ro2NyDsIlO0KtbYbVCHBRgIzrgTRyesAd93Mj8l8/YKwcF/1mS03WKzUqJEnl
         LKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743701251; x=1744306051;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SRa6N8ZbW7cTAWXN+Dp/4J0GLXk+qS4mg9kXOp4Nr3M=;
        b=pPwVIKvcqL4RMFEiqnEMbpotjohkgCA9p1qj1X3aqmsdwYNEodWsMOVHImkcvD4xfM
         AhFdkj9s7zQsvrRfqWeff/7Aux86sKx5oHRB9/jY3BS4yEN2HrVcFDrsxiJ0ijUmMT27
         NlTXol8XPNLSNDkY/A1DNxHrCFzEP9Yt6WM5g6Vx63gGtuHvjuK879iHuCGeaZR3uW9r
         2w7gQicXse94TZFt0xEqdFZXI0p/q4CsVWrhdi9Bk1uK8JUxJjQlMmmB4Vetcs3Lx1Aa
         evZr1R9XpNxEtqFCOXMsAGNlrLumRX/tEXbTWi077GwXHSL2/PQ7z82xAeOAvdRsdkym
         f2dA==
X-Forwarded-Encrypted: i=1; AJvYcCWDMvade0uQVLlXSql8B3NLEhXaXa2E2nwyG+RhWC4uvDrN/kHChCqsGmsgbNWI1KMZrbi6mXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy77NPWjcEaomQKWmUvO6nPf7rHA/vg+FshXyZRmC3mef5EF98A
	yhyhUnGIs4PLN+HY4bAOKg5VbIk+Myy2LUeGDfFYB2aXNLEEaZT5
X-Gm-Gg: ASbGncsfIYXrLs+FthBzqI4nGX5AGUQh3C/m+gAvejPQ6DMjtJhta8mw3N8JCYr2j+C
	6K0KYxUirs930Yayk4xlJSyFtlEI1EaYn16uHbLOB1KT/WdZm5tX4WZ2LQILrlJe+YLzBb2bY12
	68T/e9FjBeqgx1uxf5j0FCj51VAGLl1uDNq7TzwPWwJ/wWTrkv65Nk95vic4Ft/XU7VIIbv1IEC
	1LQThtyD5GbIb6dLpkrNNEzbhnF2YS2hTS1U4VvykK5+pcvSBHn9uorkGheDutmmx+rvbl+qP9Y
	caxnskKoFKghT2OHhhZsp0Yj+kZCcTWiE0LPq6uO+g4aKDSBl8lyFJ8pyNab8cPBm7Lz6gvVDA0
	z61CdJR/dkXIs5UgVob3pqNbik5zWwck0
X-Google-Smtp-Source: AGHT+IFDWe/19So5bpRzMkkbvyqEdcD5tCLgafw6tpQOqVxNUGta0XOGN8nW6CeSCyGpdA92DnrWPA==
X-Received: by 2002:a05:622a:1b92:b0:477:1f59:2876 with SMTP id d75a77b69052e-47924943dddmr4022141cf.28.1743701250759;
        Thu, 03 Apr 2025 10:27:30 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4791b05895dsm10098031cf.11.2025.04.03.10.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 10:27:30 -0700 (PDT)
Date: Thu, 03 Apr 2025 13:27:29 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 john.fastabend@gmail.com, 
 Willem de Bruijn <willemb@google.com>, 
 Matt Moeller <moeller.matt@gmail.com>, 
 =?UTF-8?B?TWFjaWVqIMW7ZW5jenlrb3dza2k=?= <maze@google.com>
Message-ID: <67eec501d0d58_14b7b229490@willemb.c.googlers.com.notmuch>
In-Reply-To: <Z-7DiZWkOQ_n5aXw@mini-arch>
References: <20250403140846.1268564-1-willemdebruijn.kernel@gmail.com>
 <20250403140846.1268564-2-willemdebruijn.kernel@gmail.com>
 <Z-7DiZWkOQ_n5aXw@mini-arch>
Subject: Re: [PATCH bpf 1/2] bpf: support SKF_NET_OFF and SKF_LL_OFF on skb
 frags
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Stanislav Fomichev wrote:
> On 04/03, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> > =

> > Classic BPF socket filters with SKB_NET_OFF and SKB_LL_OFF fail to
> > read when these offsets extend into frags.
> > =

> > This has been observed with iwlwifi and reproduced with tun with
> > IFF_NAPI_FRAGS. The below straightforward socket filter on UDP port,
> > applied to a RAW socket, will silently miss matching packets.
> > =

> >     const int offset_proto =3D offsetof(struct ip6_hdr, ip6_nxt);
> >     const int offset_dport =3D sizeof(struct ip6_hdr) + offsetof(stru=
ct udphdr, dest);
> >     struct sock_filter filter_code[] =3D {
> >             BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, SKF_AD_OFF + SKF_AD=
_PKTTYPE),
> >             BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, PACKET_HOST, 0, 4),
> >             BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, SKF_NET_OFF + offse=
t_proto),
> >             BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, IPPROTO_UDP, 0, 2),
> >             BPF_STMT(BPF_LD  + BPF_H   + BPF_ABS, SKF_NET_OFF + offse=
t_dport),
> > =

> > This is unexpected behavior. Socket filter programs should be
> > consistent regardless of environment. Silent misses are
> > particularly concerning as hard to detect.
> > =

> > Use skb_copy_bits for offsets outside linear, same as done for
> > non-SKF_(LL|NET) offsets.
> > =

> > Offset is always positive after subtracting the reference threshold
> > SKB_(LL|NET)_OFF, so is always >=3D skb_(mac|network)_offset. The sum=
 of
> > the two is an offset against skb->data, and may be negative, but it
> > cannot point before skb->head, as skb_(mac|network)_offset would too.=

> > =

> > This appears to go back to when frag support was introduced to
> > sk_run_filter in linux-2.4.4, before the introduction of git.
> > =

> > The amount of code change and 8/16/32 bit duplication are unfortunate=
.
> > But any attempt I made to be smarter saved very few LoC while
> > complicating the code.
> > =

> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Link: https://lore.kernel.org/netdev/20250122200402.3461154-1-maze@go=
ogle.com/
> > Link: https://elixir.bootlin.com/linux/2.4.4/source/net/core/filter.c=
#L244
> > Reported-by: Matt Moeller <moeller.matt@gmail.com>
> > Co-developed-by: Maciej =C5=BBenczykowski <maze@google.com>
> > Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > ---
> >  include/linux/filter.h |  3 --
> >  kernel/bpf/core.c      | 21 ------------
> >  net/core/filter.c      | 75 +++++++++++++++++++++++-----------------=
--
> >  3 files changed, 42 insertions(+), 57 deletions(-)
> > =

> > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > index f5cf4d35d83e..708ac7e0cd36 100644
> > --- a/include/linux/filter.h
> > +++ b/include/linux/filter.h
> > @@ -1496,9 +1496,6 @@ static inline u16 bpf_anc_helper(const struct s=
ock_filter *ftest)
> >  	}
> >  }
> >  =

> > -void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *skb=
,
> > -					   int k, unsigned int size);
> > -
> >  static inline int bpf_tell_extensions(void)
> >  {
> >  	return SKF_AD_MAX;
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index ba6b6118cf50..0e836b5ac9a0 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -68,27 +68,6 @@
> >  struct bpf_mem_alloc bpf_global_ma;
> >  bool bpf_global_ma_set;
> >  =

> > -/* No hurry in this branch
> > - *
> > - * Exported for the bpf jit load helper.
> > - */
> > -void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *skb=
, int k, unsigned int size)
> > -{
> > -	u8 *ptr =3D NULL;
> > -
> > -	if (k >=3D SKF_NET_OFF) {
> > -		ptr =3D skb_network_header(skb) + k - SKF_NET_OFF;
> > -	} else if (k >=3D SKF_LL_OFF) {
> > -		if (unlikely(!skb_mac_header_was_set(skb)))
> > -			return NULL;
> > -		ptr =3D skb_mac_header(skb) + k - SKF_LL_OFF;
> > -	}
> > -	if (ptr >=3D skb->head && ptr + size <=3D skb_tail_pointer(skb))
> > -		return ptr;
> > -
> > -	return NULL;
> > -}
> > -
> >  /* tell bpf programs that include vmlinux.h kernel's PAGE_SIZE */
> >  enum page_size_enum {
> >  	__PAGE_SIZE =3D PAGE_SIZE
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index bc6828761a47..b232b70dd10d 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -221,21 +221,24 @@ BPF_CALL_3(bpf_skb_get_nlattr_nest, struct sk_b=
uff *, skb, u32, a, u32, x)
> >  BPF_CALL_4(bpf_skb_load_helper_8, const struct sk_buff *, skb, const=
 void *,
> >  	   data, int, headlen, int, offset)
> >  {
> > -	u8 tmp, *ptr;
> > +	u8 tmp;
> >  	const int len =3D sizeof(tmp);
> >  =

> > -	if (offset >=3D 0) {
> > -		if (headlen - offset >=3D len)
> > -			return *(u8 *)(data + offset);
> > -		if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
> > -			return tmp;
> > -	} else {
> > -		ptr =3D bpf_internal_load_pointer_neg_helper(skb, offset, len);
> > -		if (likely(ptr))
> > -			return *(u8 *)ptr;
> =

> [..]
> =

> > +	if (offset < 0) {
> > +		if (offset >=3D SKF_NET_OFF)
> > +			offset +=3D skb_network_offset(skb) - SKF_NET_OFF;
> > +		else if (offset >=3D SKF_LL_OFF && skb_mac_header_was_set(skb))
> > +			offset +=3D skb_mac_offset(skb) - SKF_LL_OFF;
> > +		else
> > +			return -EFAULT;
> >  	}
> =

> nit: we now repeat the same logic three times, maybe still worth it to =
put it
> into a helper? bpf_resolve_classic_offset or something. =


I definitely tried this in various ways. But since the core logic is
only four lines and there is an early return on error, no helper
really simplifies anything. It just adds a layer of indirection and
more code in the end.

