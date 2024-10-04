Return-Path: <bpf+bounces-40974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B498C990A70
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 19:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ED19282268
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 17:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB341CACDC;
	Fri,  4 Oct 2024 17:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTQcjkmP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407B91E3786;
	Fri,  4 Oct 2024 17:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728064433; cv=none; b=cORKMADfZB0pejuwx/hbWU3Mow1eApqEC4t8hKn4cLfpILY2bG0Kf2AqKUNun0qKMgBAUNg7ajDlpwlfaLw+YWMlB3d9CYD3j3bHil/v5w6ynCPTLjaPpsaLcD4G6NFHlhjk4APA+0CB1NztCYo20w088NxfsMnoPyl/hA+00Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728064433; c=relaxed/simple;
	bh=T4/3i2k7UA+waH1WHPZCobZoqtGh90MKJRbHV+0XXlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpwu8wSIKy+GHxlu6lRVRzX1tBAsnHrzI7sQJIMQN2krpHSy9PChiQWZSHr9pw56lEj9tHaBCPfUlWLm1q8xEqwwnKXwRlzktafEhm6i4PgKutcUikf4znDmGZII6HnTdx0vEEwLp02aymO2H5pBh7fbygUe7PUd13qw2qyu7jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTQcjkmP; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e091682cfbso1874856a91.0;
        Fri, 04 Oct 2024 10:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728064431; x=1728669231; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JrHhw1JiaZd1L+/KyXQwcgkVe1bI00CuH0U1t4rxdlI=;
        b=lTQcjkmP6CSQ2MrUbJeHQQIjBctVvTvBPfEI5NHAoPC1sfFJWHpDFXANThRnxpWiRe
         Sx0Q2u4W0UQgmwi43W2xlZH+Lm1i8zW9iDNAiT2ixP2VULrVsY+IxqtsxbstfRO6SLRY
         ekFPzbuBsCgRbZsjNI5UnG5tL4EboAY6F41UsSwHKoocLOtPzYbgLxwQsI8glowe/7Gh
         lZ+S/GUyUUE9iTHojklYLXiXBfoImBSjSLx5L+ehFPC0KOj7jF6ICMfOWDpD9vfYmxUW
         MUrIDSVnx1TXm7jNRfkBVWyL1wRjRHiWzNlDZ8zX5+yacTRAxwgX7J+Qy/ugiJaEaNGj
         C/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728064431; x=1728669231;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JrHhw1JiaZd1L+/KyXQwcgkVe1bI00CuH0U1t4rxdlI=;
        b=h6+jmfDfRwvFAmlxUGmHGRT6uJ8Fggu/akQJl+RY9s8vutSB9CqTD4MTOdzrRjb9Js
         K5l4i0+eKzKjB6Nu8ejKQNOA171n79O+R1bGOiXadMc+SHNcVstUsUG0JF2e5UaKXQpc
         YKjF+bZk8aXYoi1wT+wKOKHvrP4+/LvVjfmi747JEhwof5QOZ1gIkZcXLVne34CvIu8u
         TW7wOJ5xfLh70Tw9xwkrkYXMakMiKCHB4IAk+la61aDtoeFABCku8TqCCv0Rnr7v3sZO
         +TfzRgqhvDs4EB4R05wfklNUveG+np4bP0Asi8TR1HW1LWI4B2GHwBffCYvbGGOyub0V
         aEVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeNZl0CEKa8ej5qny1Kg21CSQd/d/2+sAR0BIsDj196hhGXdNM6wSyml7TLxdQOEPigCSM8K0K@vger.kernel.org, AJvYcCXXRN+Yvip+bj+BQcIleP+RrHG6FFo4fpL7gYfqyrdlTkp08w4KMRyROyzknhk2TZo5eCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhLmYz1VY5CxOb1KpglA8UURxzDOh5ZbHQ14uycWpN30ccEzuf
	5bO+/Q6rF1iu1r+bnvE2b5XH9f2fptnwhm8wV8DMy29kkZxKtgE=
X-Google-Smtp-Source: AGHT+IETxvqfT3O6Nss0LDaANw71BycqWmkZxK4x4rCcdRphpBZeZFc9IQK4yBpYhzzsWPYzF9wmzQ==
X-Received: by 2002:a17:90b:17c8:b0:2c3:2557:3de8 with SMTP id 98e67ed59e1d1-2e1e638d03dmr4260896a91.33.1728064431360;
        Fri, 04 Oct 2024 10:53:51 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20b0f6467sm192816a91.45.2024.10.04.10.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 10:53:50 -0700 (PDT)
Date: Fri, 4 Oct 2024 10:53:50 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Arthur Fabre <afabre@cloudflare.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
	john.fastabend@gmail.com, edumazet@google.com, pabeni@redhat.com,
	sdf@fomichev.me, tariqt@nvidia.com, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org, mst@redhat.com,
	jasowang@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	kernel-team <kernel-team@cloudflare.com>,
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [RFC bpf-next 0/4] Add XDP rx hw hints support performing
 XDP_REDIRECT
Message-ID: <ZwArrsqrYx7IM5tq@mini-arch>
References: <D4KJ7DUXJQC5.2UFST9L3CUOH7@bobby>
 <ZvwNQqN4gez1Ksfn@lore-desk>
 <87zfnnq2hs.fsf@toke.dk>
 <Zv18pxsiTGTZSTyO@mini-arch>
 <87ttdunydz.fsf@toke.dk>
 <Zv3N5G8swr100EXm@mini-arch>
 <D4LYNKGLE7G0.3JAN5MX1ATPTB@bobby>
 <Zv794Ot-kOq1pguM@mini-arch>
 <2fy5vuewgwkh3o3mx5v4bkrzu6josqylraa4ocgzqib6a7ozt4@hwsuhcibtcb6>
 <038fffa3-1e29-4c6d-9e27-8181865dca46@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <038fffa3-1e29-4c6d-9e27-8181865dca46@kernel.org>

On 10/04, Jesper Dangaard Brouer wrote:
> 
> 
> On 04/10/2024 04.13, Daniel Xu wrote:
> > On Thu, Oct 03, 2024 at 01:26:08PM GMT, Stanislav Fomichev wrote:
> > > On 10/03, Arthur Fabre wrote:
> > > > On Thu Oct 3, 2024 at 12:49 AM CEST, Stanislav Fomichev wrote:
> > > > > On 10/02, Toke Høiland-Jørgensen wrote:
> > > > > > Stanislav Fomichev <stfomichev@gmail.com> writes:
> > > > > > 
> > > > > > > On 10/01, Toke Høiland-Jørgensen wrote:
> > > > > > > > Lorenzo Bianconi <lorenzo@kernel.org> writes:
> > > > > > > > 
> > > > > > > > > > On Mon Sep 30, 2024 at 1:49 PM CEST, Lorenzo Bianconi wrote:
> > > > > > > > > > > > Lorenzo Bianconi <lorenzo@kernel.org> writes:
> > > > > > > > > > > > 
> [...]
> > > > > > > > > > > > > 
> > > > > > > > > > > > > I like this 'fast' KV approach but I guess we should really evaluate its
> > > > > > > > > > > > > impact on performances (especially for xdp) since, based on the kfunc calls
> > > > > > > > > > > > > order in the ebpf program, we can have one or multiple memmove/memcpy for
> > > > > > > > > > > > > each packet, right?
> > > > > > > > > > > > 
> > > > > > > > > > > > Yes, with Arthur's scheme, performance will be ordering dependent. Using
> 
> I really like the *compact* Key-Value (KV) store idea from Arthur.
>  - The question is it is fast enough?
> 
> I've promised Arthur to XDP micro-benchmark this, if he codes this up to
> be usable in the XDP code path.  Listening to the LPC recording I heard
> that Alexei also saw potential and other use-case for this kind of
> fast-and-compact KV approach.
> 
> I have high hopes for the performance, as Arthur uses POPCNT instruction
> which is *very* fast[1]. I checked[2] AMD Zen 3 and 4 have Ops/Latency=1
> and Reciprocal throughput 0.25.
> 
>  [1] https://www.agner.org/optimize/blog/read.php?i=853#848
>  [2] https://www.agner.org/optimize/instruction_tables.pdf
> 
> [...]
> > > > There are two different use-cases for the metadata:
> > > > 
> > > > * "Hardware" metadata (like the hash, rx_timestamp...). There are only a
> > > >    few well known fields, and only XDP can access them to set them as
> > > >    metadata, so storing them in a struct somewhere could make sense.
> > > > 
> > > > * Arbitrary metadata used by services. Eg a TC filter could set a field
> > > >    describing which service a packet is for, and that could be reused for
> > > >    iptables, routing, socket dispatch...
> > > >    Similarly we could set a "packet_id" field that uniquely identifies a
> > > >    packet so we can trace it throughout the network stack (through
> > > >    clones, encap, decap, userspace services...).
> > > >    The skb->mark, but with more room, and better support for sharing it.
> > > > 
> > > > We can only know the layout ahead of time for the first one. And they're
> > > > similar enough in their requirements (need to be stored somewhere in the
> > > > SKB, have a way of retrieving each one individually, that it seems to
> > > > make sense to use a common API).
> > > 
> > > Why not have the following layout then?
> > > 
> > > +---------------+-------------------+----------------------------------------+------+
> > > | more headroom | user-defined meta | hw-meta (potentially fixed skb format) | data |
> > > +---------------+-------------------+----------------------------------------+------+
> > >                  ^                                                            ^
> > >              data_meta                                                      data
> > > 
> > > You obviously still have a problem of communicating the layout if you
> > > have some redirects in between, but you, in theory still have this
> > > problem with user-defined metadata anyway (unless I'm missing
> > > something).
> > > 
> 
> Hmm, I think you are missing something... As far as I'm concerned we are
> discussing placing the KV data after the xdp_frame, and not in the XDP
> data_meta area (as your drawing suggests).  The xdp_frame is stored at
> the very top of the headroom.  Lorenzo's patchset is extending struct
> xdp_frame and now we are discussing to we can make a more flexible API
> for extending this. I understand that Toke confirmed this here [3].  Let
> me know if I missed something :-)
> 
>  [3] https://lore.kernel.org/all/874j62u1lb.fsf@toke.dk/
>
> As part of designing this flexible API, we/Toke are trying hard not to
> tie this to a specific data area.  This is a good API design, keeping it
> flexible enough that we can move things around should the need arise.
> 
> I don't think it is viable to store this KV data in XDP data_meta area,
> because existing BPF-prog's already have direct memory (write) access
> and can change size of area, which creates too much headache with
> (existing) BPF-progs creating unintentional breakage for the KV store,
> which would then need extensive checks to handle random corruptions
> (slowing down KV-store code).

Yes, I'm definitely missing the bigger picture. If we want to have a global
metadata registry in the kernel, why can't it be built on top of the existing
area? Have some control api to define the layout and some new api to attach
the layout id to the xdp_frame. And one of those layouts might be
the xdp->skb one (although, for performance sake, still makes more sense
to special case xdp->skb one rather than asking the kernel to parse the kv
layout definition).

But I'm happy to wait for the v2 and re-read the cover letter :-)

