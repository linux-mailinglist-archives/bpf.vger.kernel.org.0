Return-Path: <bpf+bounces-27068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8978A8C4C
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 21:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F56286071
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 19:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21150364BA;
	Wed, 17 Apr 2024 19:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNVdaASX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8F4125DB;
	Wed, 17 Apr 2024 19:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713383321; cv=none; b=VR7ILvMspuB64awdlgzvz5gHE/OHC5HgZG4PtXA5N8aQVD9UY9PWLlnOO5CVwa1SbKmeu3q8ifX9FoL6acR7DUF2ST8UMqBp/ujpvlALHjIkNEtQ/IFjrat8dGiI11Ob8xq3fN2T0/VOK3WvJhUUH6MqLSkrTkPPcYX0kUZ/TmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713383321; c=relaxed/simple;
	bh=1LZ19GrsRzL4nqKN2VxIPU9A/Aloyj4ott6F8ugH6Bg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=M66idv1FCeCJkf9i+TG4jzhSMn8s67qYFf39sVbCFnNNdQqhcllWnvmye/MIPt/C3lk7febr9oW7XK83tcn2YiH5n+u9IiMK3wfEabDN4hH/pJLvLl9vTbKBnLGGYsU+ubqkHzkv3NE0a3IXUF8TWCPtZxMVth8Xy0JBVnnnADw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNVdaASX; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78f0593f45dso4821385a.2;
        Wed, 17 Apr 2024 12:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713383319; x=1713988119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1idUfe7Ux7dDWnZBEsflY2Rpd/cnwAKgfd2vpdjKHc=;
        b=dNVdaASXYqhTsFyFQeV2Ruo5sKllaMI101H0fMURt8NCIHiMUIjHLb1+QBjWtHuRDk
         TIvBXUfiUZnxBz7JkmDhP3q3vtDni+p6le4Z1Eg1awWqz2wfVvPaJQBPV3G2pQgJsHQl
         stDOVoTsSBNxKSJd2vcxSDvXDkVQE7Hdr0aBbkO+1K9BdRxqOj6M2El6L2EHkJh9sGVG
         CbLN1WnZvtkzs3+VwPNWvT1SOgB7psOQNWkVttU4wS91jWobBNbLaixhU7yJiM1l2Yr3
         Bn/+QQhBxgxQEwUeMToDWOHmeanFS8yt3BoG1Es3/zSIDL/lj5piHQFiduy3bjryB/eG
         q4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713383319; x=1713988119;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c1idUfe7Ux7dDWnZBEsflY2Rpd/cnwAKgfd2vpdjKHc=;
        b=qgpEyA2NSMFgFkrwxGL8PG81ljoh0NOCs6b2uPRe7iqjZxRnCYIx/2PXatEZmvkPma
         nhpwPkhxVatFAZZPZkYCAJ/l1XNQHUmw+Qh47/vrNLGzRFYudX0DkNz6p3wlkEBR2bIf
         mEuvyufSnj9J+vTc4fkUwgHqe2y4dfMTN9Zk9UOzIIJ8iq82skv+WhAAt75bb/QfHoc8
         MIeI8vL05jLOOCz9rppq93Cd7vcK/rfs7uWqKvLMwHFb8A55zal0p6nEP5eItwcr59we
         K9GeVLOK8zr0lS/ANMkVbIW0fKb9PYhrqbd6a9BdPxiWJ4sgBlpIY+7Fyj7lQu30tciw
         aTaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpcbO2lqzujOJQZqYxMXZoBrMfoPwiel49LYxSi9QSDgdXzA02YCi5gLVB8hf+ip17anWilbVchLlpj1NcVFaDvo3H5+9chAuo+Qpq92vFMMwR01CxwskOns1Q
X-Gm-Message-State: AOJu0YxovaruQ2n7qyV3kRBhQCQcFbSZxeTm+b0a8UJXPULPRufRdYxx
	OeRybKp8dFZkukLcJBlBqnW3JW6yGGnFss05sihqTsb2YmCCS6Hx
X-Google-Smtp-Source: AGHT+IGico5U4WBIarM0nzdXr8kutGWAKtkpKVg67bXQc00lA6d7n5Xxku6XcJmDICBwSvuaa5bJ6w==
X-Received: by 2002:a05:620a:29c7:b0:78f:182:5a17 with SMTP id s7-20020a05620a29c700b0078f01825a17mr514475qkp.45.1713383318898;
        Wed, 17 Apr 2024 12:48:38 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id v9-20020a05620a0a8900b0078d5e60b52esm8631094qkg.114.2024.04.17.12.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 12:48:38 -0700 (PDT)
Date: Wed, 17 Apr 2024 15:48:38 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>, 
 "maze@google.com" <maze@google.com>, 
 "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
 "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>, 
 "kuba@kernel.org" <kuba@kernel.org>, 
 =?UTF-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?= <Shiming.Cheng@mediatek.com>, 
 "pabeni@redhat.com" <pabeni@redhat.com>, 
 "edumazet@google.com" <edumazet@google.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
 "davem@davemloft.net" <davem@davemloft.net>
Message-ID: <662027965bdb1_c8647294b3@willemb.c.googlers.com.notmuch>
In-Reply-To: <77068ef60212e71b270281b2ccd86c8c28ee6be3.camel@mediatek.com>
References: <20240415150103.23316-1-shiming.cheng@mediatek.com>
 <661d93b4e3ec3_3010129482@willemb.c.googlers.com.notmuch>
 <65e3e88a53d466cf5bad04e5c7bc3f1648b82fd7.camel@mediatek.com>
 <CANP3RGdkxT4TjeSvv1ftXOdFQd5Z4qLK1DbzwATq_t_Dk+V8ig@mail.gmail.com>
 <661eb25eeb09e_6672129490@willemb.c.googlers.com.notmuch>
 <CANP3RGdrRDERiPFVQ1nZYVtopErjqOQ72qQ_+ijGQiL7bTtcLQ@mail.gmail.com>
 <CANP3RGd+Zd-bx6S-NzeGch_crRK2w0-u6xwSVn71M581uCp9cQ@mail.gmail.com>
 <661f066060ab4_7a39f2945d@willemb.c.googlers.com.notmuch>
 <77068ef60212e71b270281b2ccd86c8c28ee6be3.camel@mediatek.com>
Subject: Re: [PATCH net] udp: fix segmentation crash for GRO packet without
 fraglist
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Lena Wang (=E7=8E=8B=E5=A8=9C) wrote:
> On Tue, 2024-04-16 at 19:14 -0400, Willem de Bruijn wrote:
> >  	 =

> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  > > > > Personally, I think bpf_skb_pull_data() should have
> > automatically
> > > > > > (ie. in kernel code) reduced how much it pulls so that it
> > would pull
> > > > > > headers only,
> > > > >
> > > > > That would be a helper that parses headers to discover header
> > length.
> > > >
> > > > Does it actually need to?  Presumably the bpf pull function could=

> > > > notice that it is
> > > > a packet flagged as being of type X (UDP GSO FRAGLIST) and reduce=

> > the pull
> > > > accordingly so that it doesn't pull anything from the non-linear
> > > > fraglist portion???
> > > >
> > > > I know only the generic overview of what udp gso is, not any
> > details, so I am
> > > > assuming here that there's some sort of guarantee to how these
> > packets
> > > > are structured...  But I imagine there must be or we wouldn't be
> > hitting these
> > > > issues deeper in the stack?
> > > =

> > > Perhaps for a packet of this type we're already guaranteed the
> > headers
> > > are in the linear portion,
> > > and the pull should simply be ignored?
> > > =

> > > >
> > > > > Parsing is better left to the BPF program.
> > =

> > I do prefer adding sanity checks to the BPF helpers, over having to
> > add then in the net hot path only to protect against dangerous BPF
> > programs.
> > =

> Is it OK to ignore or decrease pull length for udp gro fraglist packet?=

> It could save the normal packet and sent to user correctly.
> =

> In common/net/core/filter.c
> static inline int __bpf_try_make_writable(struct sk_buff *skb,
>               unsigned int write_len)
> { =

> +	if (skb_is_gso(skb) && (skb_shinfo(skb)->gso_type &
> +		(SKB_GSO_UDP  |SKB_GSO_UDP_L4)) {

The issue is not with SKB_GSO_UDP_L4, but with SKB_GSO_FRAGLIST.

> +		return 0;

Failing for any pull is a bit excessive. And would kill a sane
workaround of pulling only as many bytes as needed.
 =

> +	     or if (write_len > skb_headlen(skb))
> +			write_len =3D skb_headlen(skb);

Truncating requests would be a surprising change of behavior
for this function.

Failing for a pull > skb_headlen is arguably reasonable, as
the alternative is that we let it go through but have to drop
the now malformed packets on segmentation.


> +	}
> 	return skb_ensure_writable(skb, write_len);
> }
>  =

> =

> > In this case, it would be detecting this GSO type and failing the
> > operation if exceeding skb_headlen().
> > > > >
> > > > > > and not packet content.
> > > > > > (This is assuming the rest of the code isn't ready to deal
> > with a longer pull,
> > > > > > which I think is the case atm.  Pulling too much, and then
> > crashing or forcing
> > > > > > the stack to drop packets because of them being malformed
> > seems wrong...)
> > > > > >
> > > > > > In general it would be nice if there was a way to just say
> > pull all headers...
> > > > > > (or possibly all L2/L3/L4 headers)
> > > > > > You in general need to pull stuff *before* you've even looked=

> > at the packet,
> > > > > > so that you can look at the packet,
> > > > > > so it's relatively hard/annoying to pull the correct length
> > from bpf
> > > > > > code itself.
> > > > > >
> > > > > > > > > BPF needs to modify a proper length to do pull data.
> > However kernel
> > > > > > > > > should also improve the flow to avoid crash from a bpf
> > function
> > > > > > > > call.
> > > > > > > > > As there is no split flow and app may not decode the
> > merged UDP
> > > > > > > > packet,
> > > > > > > > > we should drop the packet without fraglist in
> > skb_segment_list
> > > > > > > > here.
> > > > > > > > >
> > > > > > > > > Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist
> > chaining.")
> > > > > > > > > Signed-off-by: Shiming Cheng <
> > shiming.cheng@mediatek.com>
> > > > > > > > > Signed-off-by: Lena Wang <lena.wang@mediatek.com>
> > > > > > > > > ---
> > > > > > > > >  net/core/skbuff.c | 3 +++
> > > > > > > > >  1 file changed, 3 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > > > > > > > index b99127712e67..f68f2679b086 100644
> > > > > > > > > --- a/net/core/skbuff.c
> > > > > > > > > +++ b/net/core/skbuff.c
> > > > > > > > > @@ -4504,6 +4504,9 @@ struct sk_buff
> > *skb_segment_list(struct
> > > > > > > > sk_buff *skb,
> > > > > > > > >  if (err)
> > > > > > > > >  goto err_linearize;
> > > > > > > > >
> > > > > > > > > +if (!list_skb)
> > > > > > > > > +goto err_linearize;
> > > > > > > > > +
> > > > >
> > > > > This would catch the case where the entire data frag_list is
> > > > > linearized, but not a pskb_may_pull that only pulls in part of
> > the
> > > > > list.
> > > > >
> > > > > Even with BPF being privileged, the kernel should not crash if
> > BPF
> > > > > pulls a FRAGLIST GSO skb.
> > > > >
> > > > > But the check needs to be refined a bit. For a UDP GSO packet,
> > I
> > > > > think gso_size is still valid, so if the head_skb length does
> > not
> > > > > match gso_size, it has been messed with and should be dropped.
> > > > >
> Is it OK as below? Is it OK to add log to record the error for easy
> checking issue.
> =

> In net/core/skbuff.c skb_segment_list
> +unsigned int mss =3D skb_shinfo(head_skb)->gso_size;
> +bool err_len =3D false;
> =

> +if ( mss !=3D GSO_BY_FRAGS && mss !=3D skb_headlen(head_skb)) {
> +	pr_err("skb is dropped due to messed data. gso size:%d,
> +		hdrlen:%d", mss, skb_headlen(head_skb)

Such logs should always be rate limited. But no need to log cases
where we well understood how we get there.

I would stick with one approach: either in the BPF func or in
segmentation, not both. And then I find BPF preferable, as explained
before.

> +	if (!list_skb)
> +		goto err_linearize;
> +	else
> +		err_len =3D true;
> +}
> =

> ...
> +if (err_len) {
> +	goto err_linearize;
> +}
> =

> skb_get(skb);
> ...=

