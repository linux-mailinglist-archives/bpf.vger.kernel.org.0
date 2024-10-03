Return-Path: <bpf+bounces-40864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB1298F80F
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 22:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7375B226D3
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 20:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DD81AC450;
	Thu,  3 Oct 2024 20:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYpGMY/w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE6212FB0A;
	Thu,  3 Oct 2024 20:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727987172; cv=none; b=j1T9MrDstJRD2Ju31Gz5xk38htZIxzLq/V5nT0yVVNuFkECRM/jm2czPwEg+CksNrXR/Nt3rIWQkGEyePbydTDwQLfiASh0B0n4IY+0of+iycHlzeryWaqKpbUGT9WNW1BPzOOA9+s2Ue1PkfXEH3b4uAn/mkNlLFjG6G8HTVGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727987172; c=relaxed/simple;
	bh=3IjYU0e1z23lsNDCftVBw8XjRsYBCqxD7Sd7elmTEwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toAPC+qqgzUvGqXLJlH8YY9u1GFoF7H13yHgGxm6daS9f5SbC5lhFGmYjjMuTkcdU6QZPGDHPd5fiRHKfB0hPw4VOO6CEX8jCyBajnyhs640yd+XcyXxsVTBBIFLBj8gwkafpDL1t1BjM7OfzDjRduMqkdFEW5n5SYUfqAFYci0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYpGMY/w; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso936571a12.2;
        Thu, 03 Oct 2024 13:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727987170; x=1728591970; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BU1xMELbpkpF4/s4NlC/up6s8YBrxydyalnXVzeU3u0=;
        b=fYpGMY/wy0zxsfA01rKlmkXYn0kqJV1eulbPFpR2GD4mG7hDtqBd0pB1ijw8gVRXDy
         NuhV45O7Mqd5f2KzggH+46GBTQV3kNQ4N6B2EWR5asrtOtPWHQVU5/fKuVeBw8xpuEk4
         4lgWvJIdleaF9jWfhQKy7IRFSJ7yBJrsznNKH0riOB04k02rgU25Dx5V3aSERB5aaDd4
         gOBx1agBICploZ+Ni2y+V8H4ILLCtZwI5kEWigARltPhrIKoFNjaP7duRsgJTXAgJqhG
         UAA2nh0WJCPa6yT8rKyqeSawHcVcJB2sB3HCUZxHkAjKUMNvruIKyScN1ESF4fAQY/NW
         tqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727987170; x=1728591970;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BU1xMELbpkpF4/s4NlC/up6s8YBrxydyalnXVzeU3u0=;
        b=hU71qnrwJldnYNXiGJdjrLevsnFimURo0sNG+4rTgd8JUJG5rjvvEBVbfgNQklgNk4
         7hT+UXN5783gAZBUeSXOMT1A3LVTs5gdEZxKt/WKSwysKz0kgWchW6z0k+IX8ovAOkRJ
         8g1ZYwluogViCG+sbCbgn14o8lPneC+7KqAlBk4WpQ18AtL08RXJrlqHdQfB/gLOastD
         omXN0MZ428CqvGgBzRTOi2pPir6aaUrtEZhakTGFGV5kvtcwJ1De7nA/sv9ngAmVwZeI
         3+YRP9qvB+DTkEAd8L11ly96UqLx7MqK7Hj+Zfbc8XeNax27pppetQjIsoyxTPlr9y/t
         oK6w==
X-Forwarded-Encrypted: i=1; AJvYcCV452FPZ68mdnA7cGgwcglDWZZYGPwQqSFX+3oxHzfh9QOCplg6PTHJLGMDbsIdGiSTaT0=@vger.kernel.org, AJvYcCXNFjf4t5hCMNQlorF6e5GYDrFiNsDWd2Xe54iVeEqL7rJa725i0aHpfl/zuLFcXz13Gklu4uGG@vger.kernel.org
X-Gm-Message-State: AOJu0YwnivsS5nlCAuNdN0TRW43updCi7v6unrSLrR0HeruQbAXe5FT5
	0qcaNjXhv+bqaJ747xidz+u2+5MKjSIOO+L92MOgeEv7DFrM1Hg=
X-Google-Smtp-Source: AGHT+IGVx3Mx2r7F+hBq6PGE0rOLOUJ8qyOHgmPWGYQyAJ9p2GUH4RlZ/e4AkGoFa+Zu3Ty2eAGoIA==
X-Received: by 2002:a05:6a20:9f4e:b0:1cf:44bb:1cc4 with SMTP id adf61e73a8af0-1d6dfabb6admr676679637.40.1727987169527;
        Thu, 03 Oct 2024 13:26:09 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9df0ae6sm1843167b3a.174.2024.10.03.13.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 13:26:08 -0700 (PDT)
Date: Thu, 3 Oct 2024 13:26:08 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Arthur Fabre <afabre@cloudflare.com>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
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
Message-ID: <Zv794Ot-kOq1pguM@mini-arch>
References: <ZvbKDT-2xqx2unrx@lore-rh-laptop>
 <871q11s91e.fsf@toke.dk>
 <ZvqQOpqnK9hBmXNn@lore-desk>
 <D4KJ7DUXJQC5.2UFST9L3CUOH7@bobby>
 <ZvwNQqN4gez1Ksfn@lore-desk>
 <87zfnnq2hs.fsf@toke.dk>
 <Zv18pxsiTGTZSTyO@mini-arch>
 <87ttdunydz.fsf@toke.dk>
 <Zv3N5G8swr100EXm@mini-arch>
 <D4LYNKGLE7G0.3JAN5MX1ATPTB@bobby>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D4LYNKGLE7G0.3JAN5MX1ATPTB@bobby>

On 10/03, Arthur Fabre wrote:
> On Thu Oct 3, 2024 at 12:49 AM CEST, Stanislav Fomichev wrote:
> > On 10/02, Toke Høiland-Jørgensen wrote:
> > > Stanislav Fomichev <stfomichev@gmail.com> writes:
> > > 
> > > > On 10/01, Toke Høiland-Jørgensen wrote:
> > > >> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> > > >> 
> > > >> >> On Mon Sep 30, 2024 at 1:49 PM CEST, Lorenzo Bianconi wrote:
> > > >> >> > > Lorenzo Bianconi <lorenzo@kernel.org> writes:
> > > >> >> > > 
> > > >> >> > > >> > We could combine such a registration API with your header format, so
> > > >> >> > > >> > that the registration just becomes a way of allocating one of the keys
> > > >> >> > > >> > from 0-63 (and the registry just becomes a global copy of the header).
> > > >> >> > > >> > This would basically amount to moving the "service config file" into the
> > > >> >> > > >> > kernel, since that seems to be the only common denominator we can rely
> > > >> >> > > >> > on between BPF applications (as all attempts to write a common daemon
> > > >> >> > > >> > for BPF management have shown).
> > > >> >> > > >> 
> > > >> >> > > >> That sounds reasonable. And I guess we'd have set() check the global
> > > >> >> > > >> registry to enforce that the key has been registered beforehand?
> > > >> >> > > >> 
> > > >> >> > > >> >
> > > >> >> > > >> > -Toke
> > > >> >> > > >> 
> > > >> >> > > >> Thanks for all the feedback!
> > > >> >> > > >
> > > >> >> > > > I like this 'fast' KV approach but I guess we should really evaluate its
> > > >> >> > > > impact on performances (especially for xdp) since, based on the kfunc calls
> > > >> >> > > > order in the ebpf program, we can have one or multiple memmove/memcpy for
> > > >> >> > > > each packet, right?
> > > >> >> > > 
> > > >> >> > > Yes, with Arthur's scheme, performance will be ordering dependent. Using
> > > >> >> > > a global registry for offsets would sidestep this, but have the
> > > >> >> > > synchronisation issues we discussed up-thread. So on balance, I think
> > > >> >> > > the memmove() suggestion will probably lead to the least pain.
> > > >> >> > > 
> > > >> >> > > For the HW metadata we could sidestep this by always having a fixed
> > > >> >> > > struct for it (but using the same set/get() API with reserved keys). The
> > > >> >> > > only drawback of doing that is that we statically reserve a bit of
> > > >> >> > > space, but I'm not sure that is such a big issue in practice (at least
> > > >> >> > > not until this becomes to popular that the space starts to be contended;
> > > >> >> > > but surely 256 bytes ought to be enough for everybody, right? :)).
> > > >> >> >
> > > >> >> > I am fine with the proposed approach, but I think we need to verify what is the
> > > >> >> > impact on performances (in the worst case??)
> > > >> >> 
> > > >> >> If drivers are responsible for populating the hardware metadata before
> > > >> >> XDP, we could make sure drivers set the fields in order to avoid any
> > > >> >> memove() (and maybe even provide a helper to ensure this?).
> > > >> >
> > > >> > nope, since the current APIs introduced by Stanislav are consuming NIC
> > > >> > metadata in kfuncs (mainly for af_xdp) and, according to my understanding,
> > > >> > we want to add a kfunc to store the info for each NIC metadata (e.g rx-hash,
> > > >> > timestamping, ..) into the packet (this is what Toke is proposing, right?).
> > > >> > In this case kfunc calling order makes a difference.
> > > >> > We can think even to add single kfunc to store all the info for all the NIC
> > > >> > metadata (maybe via a helping struct) but it seems not scalable to me and we
> > > >> > are losing kfunc versatility.
> > > >> 
> > > >> Yes, I agree we should have separate kfuncs for each metadata field.
> > > >> Which means it makes a lot of sense to just use the same setter API that
> > > >> we use for the user-registered metadata fields, but using reserved keys.
> > > >> So something like:
> > > >> 
> > > >> #define BPF_METADATA_HW_HASH      BIT(60)
> > > >> #define BPF_METADATA_HW_TIMESTAMP BIT(61)
> > > >> #define BPF_METADATA_HW_VLAN      BIT(62)
> > > >> #define BPF_METADATA_RESERVED (0xffff << 48)
> > > >> 
> > > >> bpf_packet_metadata_set(pkt, BPF_METADATA_HW_HASH, hash_value);
> > > >> 
> > > >> 
> > > >> As for the internal representation, we can just have the kfunc do
> > > >> something like:
> > > >> 
> > > >> int bpf_packet_metadata_set(field_id, value) {
> > > >>   switch(field_id) {
> > > >>     case BPF_METADATA_HW_HASH:
> > > >>       pkt->xdp_hw_meta.hash = value;
> > > >>       break;
> > > >>     [...]
> > > >>     default:
> > > >>       /* do the key packing thing */
> > > >>   }
> > > >> }
> > > >> 
> > > >> 
> > > >> that way the order of setting the HW fields doesn't matter, only the
> > > >> user-defined metadata.
> > > >
> > > > Can you expand on why we need the flexibility of picking the metadata fields
> > > > here? Presumably we are talking about the use-cases where the XDP program
> > > > is doing redirect/pass and it doesn't really know who's the final
> > > > consumer is (might be another xdp program or might be the xdp->skb
> > > > kernel case), so the only sensible option here seems to be store everything?
> > > 
> > > For the same reason that we have separate kfuncs for each metadata field
> > > when getting it from the driver: XDP programs should have the
> > > flexibility to decide which pieces of metadata they need, and skip the
> > > overhead of stuff that is not needed.
> > > 
> > > For instance, say an XDP program knows that nothing in the system uses
> > > timestamps; in that case, it can skip both the getter and the setter
> > > call for timestamps.

Original RFC is talking about XDP -> XDP_REDIRECT -> skb use-case,
right? For this we pretty much know what kind of metadata we want to
preserve, so why not ship it in the existing metadata area and have
a kfunc that the xdp program will call prior to doing xdp_redirect?
This kfunc can do exactly what you're suggesting - skip the timestamp
if we know that the timestamping is off.

Or have we moved to discussing some other use-cases? What am I missing
about the need for some other new mechanism?

> > But doesn't it put us in the same place? Where the first (native) xdp program
> > needs to know which metadata the final consumer wants. At this point
> > why not propagate metadata layout as well?
> >
> > (or maybe I'm still missing what exact use-case we are trying to solve)
> 
> There are two different use-cases for the metadata:
> 
> * "Hardware" metadata (like the hash, rx_timestamp...). There are only a
>   few well known fields, and only XDP can access them to set them as
>   metadata, so storing them in a struct somewhere could make sense.
> 
> * Arbitrary metadata used by services. Eg a TC filter could set a field
>   describing which service a packet is for, and that could be reused for
>   iptables, routing, socket dispatch...
>   Similarly we could set a "packet_id" field that uniquely identifies a
>   packet so we can trace it throughout the network stack (through
>   clones, encap, decap, userspace services...).
>   The skb->mark, but with more room, and better support for sharing it.
> 
> We can only know the layout ahead of time for the first one. And they're
> similar enough in their requirements (need to be stored somewhere in the
> SKB, have a way of retrieving each one individually, that it seems to
> make sense to use a common API).

Why not have the following layout then?

+---------------+-------------------+----------------------------------------+------+
| more headroom | user-defined meta | hw-meta (potentially fixed skb format) | data |
+---------------+-------------------+----------------------------------------+------+
                ^                                                            ^
            data_meta                                                      data

You obviously still have a problem of communicating the layout if you
have some redirects in between, but you, in theory still have this
problem with user-defined metadata anyway (unless I'm missing
something).

> > > I suppose we *could* support just a single call to set the skb meta,
> > > like:
> > > 
> > > bpf_set_skb_meta(struct xdp_md *pkt, struct xdp_hw_meta *data);
> > > 
> > > ...but in that case, we'd need to support some fields being unset
> > > anyway, and the program would have to populate the struct on the stack
> > > before performing the call. So it seems simpler to just have symmetry
> > > between the get (from HW) and set side? :)
> >
> > Why not simply bpf_set_skb_meta(struct xdp_md *pkt) and let it store
> > the metadata somewhere in xdp_md directly? (also presumably by
> > reusing most of the existing kfuncs/xmo_xxx helpers)
> 
> If we store it in xdp_md, the metadata won't be available higher up the
> stack (or am I missing something?). I think one of the goals is to let
> things other than XDP access it (maybe even the network stack itself?).

IIRC, xdp metadata gets copied to skb metadata, so it does propagate.
Although, it might have a detrimental effect on the gro, but I'm
assuming that is something that can be fixed separately.

