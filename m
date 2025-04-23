Return-Path: <bpf+bounces-56552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 839FDA99C22
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 01:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29A65A8390
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 23:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE8022F77E;
	Wed, 23 Apr 2025 23:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKuPz+oc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0D1645;
	Wed, 23 Apr 2025 23:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745451931; cv=none; b=WoVTLWF/LDBHvPshu7Oad+VVjoUy/TtB3G/r5iBEz05ks4KAN0HptcCaAbgRkft0cZr4czkvezynSa6iQMW4A7zrkZccIB452l30YNu2NYZw3ksYRdeqe3Hn1PL6luKP04zaGQ3vcXfauzZSDBzChff58237fye+L+Zd+mDiPBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745451931; c=relaxed/simple;
	bh=lsUo/fWRv0v4sn24ChLCCGBcd3jGuEfkjbiFhMYRKu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXqLUTPKMTGR4ZaYUdy3nhnLV9wdpKNSyQcweXuHXaEM+vpHLrOM/ps5/Vt9ZzEmrQ2h7kh4vZNF4/kwH9c4TWNvLkqb8rM6T/ratUxoO2q91etYU3jvxnwGi/J9Uw3WMxHDlcPh9LRgH8nNLxdDa/SN5sHGjjxYx6ZmGCcui4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKuPz+oc; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-30863b48553so1479663a91.0;
        Wed, 23 Apr 2025 16:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745451929; x=1746056729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rd4Ivq0EG97ciT8fUrnEVihqKl+kbekTsPCmJAqV8co=;
        b=MKuPz+ocd/hrze4Jvsvooh6EoJk86OIJ0Fr0myE/OESIjcna1F7DBikGUt3FeHWhUL
         I4o0getN08dWU0bH6Rhx8Rz1M8INOwXEJYCRa4H2yiOptcNfbirVSej/5c0pezTSdpCn
         J/4BTEBrJiYoXc98X4MsP9DTvelKRxIEBYTZ19cfpCfsCRVHJrP19mRtHAwiq61KvQS+
         4U/sBZJMAWTucIdU1ch3T+uw3bezyI2x3QkON77hWPy/SmQ20C44R3cjBYQHOg59JEep
         kXTs0OXCPo3PWxbcfbm/4KbMyw7MA7oKgcOiP/GaUvgJ+Ok1Ol7qW5+PAFkb2cOLi/CZ
         hAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745451929; x=1746056729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rd4Ivq0EG97ciT8fUrnEVihqKl+kbekTsPCmJAqV8co=;
        b=uXha3eIB/yDSSZ8t54/nRorn1r5FkvTJHkfWbp2sEGK5/Sih6EjjX9S/HqOTghpxyi
         tVJoT5DlA2pfcIho7AnCwtCCR94ICI2ow4pukl94RKlr8MS1HIDNnXt0d659zGNZU9DU
         psttDQ/VHk7Qzyy8XKRRm+drR6c2wefILXGOE68vpCkxVYNIT8x76OkDgyjp5utJ6WVZ
         mtQ2BgS9nG/DNz+Dm//cnjGnvF9dqTGH7BA/Pzm/0om5Luq9vtxXOaG0CDdGJqgDITvv
         Cb86HhAveGk7lXUwi0h+9Z0TM9GtAthp6Dr4khbdpSC28Bw/zWOmNghPj4xjeHVX6Aiy
         HI3A==
X-Forwarded-Encrypted: i=1; AJvYcCXNDOOSNP6OZuwTcz8Is7eV5kqPXhfTxOll2BM38nU2tR9Ic92zcZ7lbuY8WzV89hPwVuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWcw6qjIpmUd1TrYfaCPsJufTtR1mb8v0jMAJ28iEbmCPrwLKS
	jqOoURoG1h0VQ+W8Yb0UvZqkfOGmeSRaQ6D7mJOBwy0gX5o+dnw=
X-Gm-Gg: ASbGncvovprTZu1WjoeTpQNGmTb0WD5anJQHMF+gHaDuNGILeqkvdhBBQJ/clxncQFk
	3AugEHzZ86RPTeexG2IP0zUFxpqMtSAbT5mQ51T1Z7gNBTJoS8u+QXb4WRDCke0NZTMnRiJjk2S
	B4Vg/oylYsv3L25Ncw2rW6rbvdVkdb3h8xdSBj0IkLTK+4ZbtS0LNd2IeRIEr2uSJXXO9cMrmMz
	dXI6v/22Zmz1XZrDXTcMAcI1stTTE4956NKw+XENKs52tKJ/Xo5iWVlfu7oanwK3h7opziE2XFD
	t4iVA3ne6LMs1P6WLmEQYmebR5vAQxYdaDhNxLRx
X-Google-Smtp-Source: AGHT+IHlHUbJTc+JV3ZzF0uBTgtlOhaF0wMNvqfAQsMoChnkk++quFl8sokZ0xoByNTxhWxcW3/jlw==
X-Received: by 2002:a17:90b:2e0f:b0:2fa:42f3:e3e4 with SMTP id 98e67ed59e1d1-309ee367d8amr352883a91.3.1745451928774;
        Wed, 23 Apr 2025 16:45:28 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-309df9ef918sm2277406a91.7.2025.04.23.16.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 16:45:28 -0700 (PDT)
Date: Wed, 23 Apr 2025 16:45:27 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Arthur Fabre <arthur@arthurfabre.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, jakub@cloudflare.com,
	hawk@kernel.org, yan@cloudflare.com, jbrandeburg@cloudflare.com,
	thoiland@redhat.com, lbiancon@redhat.com, ast@kernel.org,
	kuba@kernel.org, edumazet@google.com
Subject: Re: [PATCH RFC bpf-next v2 10/17] bnxt: Propagate trait presence to
 skb
Message-ID: <aAl7lz88_8QohyxK@mini-arch>
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
 <20250422-afabre-traits-010-rfc2-v2-10-92bcc6b146c9@arthurfabre.com>
 <aAkW--LAm5L2oNNn@mini-arch>
 <D9EBFOPVB4WH.1MCWD4B4VGXGO@arthurfabre.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D9EBFOPVB4WH.1MCWD4B4VGXGO@arthurfabre.com>

On 04/23, Arthur Fabre wrote:
> On Wed Apr 23, 2025 at 6:36 PM CEST, Stanislav Fomichev wrote:
> > On 04/22, Arthur Fabre wrote:
> > > Call the common xdp_buff_update_skb() helper.
> > > 
> > > Signed-off-by: Arthur Fabre <arthur@arthurfabre.com>
> > > ---
> > >  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > > index c8e3468eee612ad622bfbecfd7cc1ae3396061fd..0eba3e307a3edbc5fe1abf2fa45e6256d98574c2 100644
> > > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > > @@ -2297,6 +2297,10 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
> > >  			}
> > >  		}
> > >  	}
> > > +
> > > +	if (xdp_active)
> > > +		xdp_buff_update_skb(&xdp, skb);
> >
> > For me, the preference for reusing existing metadata area was
> > because of the patches 10-16: we now need to care about two types of
> > metadata explicitly.
> 
> Having to update all the drivers is definitely not ideal. Motivation is:
> 
> 1. Avoid trait_set() and xdp_adjust_meta() from corrupting each other's
>    data. 
>    But that's not a problem if we disallow trait_set() and
>    xdp_adjust_meta() to be used at the same time, so maybe not a good
>    reason anymore (except for maybe 3.)
> 
> 2. Not have the traits at the "end" of the headroom (ie right next to
>    actual packet data).
>    If it's at the "end", we need to move all of it to make room for
>    every xdp_adjust_head() call.
>    It seems more intrusive to the current SKB API: several funcs assume
>    that there is headroom directly before the packet.

[..]

> 3. I'm not sure how this should be exposed with AF_XDP yet. Either:
>    * Expose raw trait storage, and having it at the "end" of the
>      headroom is nice. But userspace would need to know how to parse the
> 	 header.
>    * Require the XDP program to copy the traits it wants into the XDP
>      metadata area, which is already exposed to userspace. That would
> 	 need traits and XDP metadata to coexist.
 
By keeping the traits at the tail we can just expose raw trait storage
and let userspace deal with it. But anyway, my main point is to avoid
having drivers to deal with two separate cases. As long as we can hide
everything behind a common call, we can change the placement later.

> > If you insist on placing it into the headroom, can we at least have some
> > common helper to finish xdp->skb conversion? It can call skb_ext_from_headroom
> > and/or skb_metadata_set:
> >
> > xdp_buff_done(*xdp, *skb) {
> > 	if (have traits) {
> > 		skb_ext_from_headroom
> > 		return
> > 	}
> >
> > 	metasize = xdp->data - xdp->data_meta;
> > 	if (metasize)
> > 		skb_metadata_set
> > }
> >
> > And then we'll have some common rules for the drivers: call xdp_buff_done
> > when you're done with the xdp_buff to take care of metadata/traits. And
> > it might be easier to review: you're gonna (mostly) change existing
> > calls to skb_metadata_set to your new helper. Maybe we can even
> > eventually fold all xdp_update_skb_shared_info stuff into that as
> > well...
> 
> Yes! This is what I was going for with xdp_buff_update_skb() - it would be
> nice for it handle all the SKB updating, including skb_metadata_set().
> 
> Should I do that first, and submit it as separate series()?

Up to you, will be happy to review regardless :-)

