Return-Path: <bpf+bounces-40963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBF2990921
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 18:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 194991C2155C
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 16:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9583A1C8760;
	Fri,  4 Oct 2024 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IObHiwBz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BB815B0FF;
	Fri,  4 Oct 2024 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059270; cv=none; b=DntiQr3z7Clmw/drfHFz/eW8gmM3ftDjhns5VPfQCAd6RVE1Ph4C+aa36l5X4r62OQAPlxxcuvpJMVFVS443wGTPctyjPszI/9VVnAL3ZgW4KIOha6jU/ZOsCw4W+U7Bsubf0VgDV0v04w7kanDqWwn3wjjV4huQx0t70MN+oNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059270; c=relaxed/simple;
	bh=8M9oi+cU1gmqaZroJ1vY16G6zaDiDQWmz4WIWhq/iWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVjgIswZsKvIvQWb3tJBQ7B5dWZHiGoCozYvE38Eg4w0yhkR0S5XtxjVZ1T+r0bjxo3gn3+cOflCTvwjCvA/lBsIvdrRWBPo+CeojRygLTgjcQnk5XFipjDBq6By2YWFDFkVR4uJ+PA2hhUKnP+qsXfDGTUI+ZFgR3Yc19U93YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IObHiwBz; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6e7b121be30so1513954a12.1;
        Fri, 04 Oct 2024 09:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728059268; x=1728664068; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1EwPJ1608FHgcUv1d+P5BWSkWcWPXFoUeUgbMomkXh8=;
        b=IObHiwBzDw9UhSw52eywOCVx20tilppS6iHyK0CxrZN/tMZoquPzW38L/7pGvMaZaB
         QMVmMqWerDHODq0mJyjX1g4/Xsee4frmZ8eYHsHoyhqx80WkdLPZ54H/qa9uN2EiENlh
         CTK5Bgrq08onYEKdqpVr4Bg0P/CqoDBv3qTt06Q/3vGhzwCyOHpxJDLxPmVeS4yeD1By
         TPzt+t1U9uxfXQ6xBFRrdFi2dFdo+9TNocT4UV3rDgNas9epbr0yU1A1isFe4B/LLeYH
         AozsR7YBOQVzhaeq921MEvhyfzqtqrPf7b5lT0ZGUo+0ivdzIlGEK0szhsr+XeMTeKRh
         WmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728059268; x=1728664068;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1EwPJ1608FHgcUv1d+P5BWSkWcWPXFoUeUgbMomkXh8=;
        b=sYYAeVFNvOhOiHGVO3M+0gatmw6w8GP3/3U1g8xlMhjY1jlnpjClcRNAY7hMyfF8al
         YiehGE8uqibmNmr7LsRkhhFF6ABg0LeFbmuyO3Pk7/eonfHKxFZ1vJ6n4DRFcZ/BGsbS
         G0C03lbQYRBrx2AOihTK+0ZdJiPYN4KCc485cVwRs+CLQwp7oEuOwaXPkrgAz3nFt7oy
         q36OirwaozTHNuGxsHFPxR0ohZaWYUDDnBqLIsL8Mj3GoXjdRrKvlBbCSBNYdAnp/0xA
         7DarjDHQRTn/8eL/JDv4tuCoVID3mYtWRoO+lspxjwOivrfZkjOj72CcsipEtThK6VES
         n9DQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEP8k50mOOmjuDkgvO9shZI9UOrw1KVZwb8I6kp1A5YhIkCk/HC5uBHEyYH4FEALdvjy8TmADt@vger.kernel.org, AJvYcCWYLT9fRdZQqPu//ISNhCVe48NcQq/0dByNP8wuaICA3OullqYDa00o3rPPhY+BQTzdz3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiKBspBi1msQ7976CQJFCaKvsJdWkg4eeg1Jr5pbHi7dJlfKcx
	ghb66Lma5g5ygG8DF8Z9qqJ7H9nKRLX09Ap3iW/313iD6Xyb6V4=
X-Google-Smtp-Source: AGHT+IH6co3BoA6TXvpR16aqzkc3+ox+pDBKiQ0FlqXl6KBOx9VjfDbaw/EgsWMhwyHSNy3vWWxT+w==
X-Received: by 2002:a05:6a20:43a7:b0:1d4:f6c4:8e7a with SMTP id adf61e73a8af0-1d6dfacaf95mr5327190637.31.1728059267540;
        Fri, 04 Oct 2024 09:27:47 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d4665dsm38795b3a.116.2024.10.04.09.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 09:27:47 -0700 (PDT)
Date: Fri, 4 Oct 2024 09:27:46 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Arthur Fabre <afabre@cloudflare.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
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
Message-ID: <ZwAXgm-wV8-WQAqU@mini-arch>
References: <ZvqQOpqnK9hBmXNn@lore-desk>
 <D4KJ7DUXJQC5.2UFST9L3CUOH7@bobby>
 <ZvwNQqN4gez1Ksfn@lore-desk>
 <87zfnnq2hs.fsf@toke.dk>
 <Zv18pxsiTGTZSTyO@mini-arch>
 <87ttdunydz.fsf@toke.dk>
 <Zv3N5G8swr100EXm@mini-arch>
 <D4LYNKGLE7G0.3JAN5MX1ATPTB@bobby>
 <Zv794Ot-kOq1pguM@mini-arch>
 <2fy5vuewgwkh3o3mx5v4bkrzu6josqylraa4ocgzqib6a7ozt4@hwsuhcibtcb6>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2fy5vuewgwkh3o3mx5v4bkrzu6josqylraa4ocgzqib6a7ozt4@hwsuhcibtcb6>

On 10/03, Daniel Xu wrote:
> Hi Stan,
> 
> On Thu, Oct 03, 2024 at 01:26:08PM GMT, Stanislav Fomichev wrote:
> > On 10/03, Arthur Fabre wrote:
> > > On Thu Oct 3, 2024 at 12:49 AM CEST, Stanislav Fomichev wrote:
> > > > On 10/02, Toke Høiland-Jørgensen wrote:
> > > > > Stanislav Fomichev <stfomichev@gmail.com> writes:
> > > > > 
> > > > > > On 10/01, Toke Høiland-Jørgensen wrote:
> > > > > >> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> > > > > >> 
> > > > > >> >> On Mon Sep 30, 2024 at 1:49 PM CEST, Lorenzo Bianconi wrote:
> > > > > >> >> > > Lorenzo Bianconi <lorenzo@kernel.org> writes:
> > > > > >> >> > > 
> > > > > >> >> > > >> > We could combine such a registration API with your header format, so
> > > > > >> >> > > >> > that the registration just becomes a way of allocating one of the keys
> > > > > >> >> > > >> > from 0-63 (and the registry just becomes a global copy of the header).
> > > > > >> >> > > >> > This would basically amount to moving the "service config file" into the
> > > > > >> >> > > >> > kernel, since that seems to be the only common denominator we can rely
> > > > > >> >> > > >> > on between BPF applications (as all attempts to write a common daemon
> > > > > >> >> > > >> > for BPF management have shown).
> > > > > >> >> > > >> 
> > > > > >> >> > > >> That sounds reasonable. And I guess we'd have set() check the global
> > > > > >> >> > > >> registry to enforce that the key has been registered beforehand?
> > > > > >> >> > > >> 
> > > > > >> >> > > >> >
> > > > > >> >> > > >> > -Toke
> > > > > >> >> > > >> 
> > > > > >> >> > > >> Thanks for all the feedback!
> > > > > >> >> > > >
> > > > > >> >> > > > I like this 'fast' KV approach but I guess we should really evaluate its
> > > > > >> >> > > > impact on performances (especially for xdp) since, based on the kfunc calls
> > > > > >> >> > > > order in the ebpf program, we can have one or multiple memmove/memcpy for
> > > > > >> >> > > > each packet, right?
> > > > > >> >> > > 
> > > > > >> >> > > Yes, with Arthur's scheme, performance will be ordering dependent. Using
> > > > > >> >> > > a global registry for offsets would sidestep this, but have the
> > > > > >> >> > > synchronisation issues we discussed up-thread. So on balance, I think
> > > > > >> >> > > the memmove() suggestion will probably lead to the least pain.
> > > > > >> >> > > 
> > > > > >> >> > > For the HW metadata we could sidestep this by always having a fixed
> > > > > >> >> > > struct for it (but using the same set/get() API with reserved keys). The
> > > > > >> >> > > only drawback of doing that is that we statically reserve a bit of
> > > > > >> >> > > space, but I'm not sure that is such a big issue in practice (at least
> > > > > >> >> > > not until this becomes to popular that the space starts to be contended;
> > > > > >> >> > > but surely 256 bytes ought to be enough for everybody, right? :)).
> > > > > >> >> >
> > > > > >> >> > I am fine with the proposed approach, but I think we need to verify what is the
> > > > > >> >> > impact on performances (in the worst case??)
> > > > > >> >> 
> > > > > >> >> If drivers are responsible for populating the hardware metadata before
> > > > > >> >> XDP, we could make sure drivers set the fields in order to avoid any
> > > > > >> >> memove() (and maybe even provide a helper to ensure this?).
> > > > > >> >
> > > > > >> > nope, since the current APIs introduced by Stanislav are consuming NIC
> > > > > >> > metadata in kfuncs (mainly for af_xdp) and, according to my understanding,
> > > > > >> > we want to add a kfunc to store the info for each NIC metadata (e.g rx-hash,
> > > > > >> > timestamping, ..) into the packet (this is what Toke is proposing, right?).
> > > > > >> > In this case kfunc calling order makes a difference.
> > > > > >> > We can think even to add single kfunc to store all the info for all the NIC
> > > > > >> > metadata (maybe via a helping struct) but it seems not scalable to me and we
> > > > > >> > are losing kfunc versatility.
> > > > > >> 
> > > > > >> Yes, I agree we should have separate kfuncs for each metadata field.
> > > > > >> Which means it makes a lot of sense to just use the same setter API that
> > > > > >> we use for the user-registered metadata fields, but using reserved keys.
> > > > > >> So something like:
> > > > > >> 
> > > > > >> #define BPF_METADATA_HW_HASH      BIT(60)
> > > > > >> #define BPF_METADATA_HW_TIMESTAMP BIT(61)
> > > > > >> #define BPF_METADATA_HW_VLAN      BIT(62)
> > > > > >> #define BPF_METADATA_RESERVED (0xffff << 48)
> > > > > >> 
> > > > > >> bpf_packet_metadata_set(pkt, BPF_METADATA_HW_HASH, hash_value);
> > > > > >> 
> > > > > >> 
> > > > > >> As for the internal representation, we can just have the kfunc do
> > > > > >> something like:
> > > > > >> 
> > > > > >> int bpf_packet_metadata_set(field_id, value) {
> > > > > >>   switch(field_id) {
> > > > > >>     case BPF_METADATA_HW_HASH:
> > > > > >>       pkt->xdp_hw_meta.hash = value;
> > > > > >>       break;
> > > > > >>     [...]
> > > > > >>     default:
> > > > > >>       /* do the key packing thing */
> > > > > >>   }
> > > > > >> }
> > > > > >> 
> > > > > >> 
> > > > > >> that way the order of setting the HW fields doesn't matter, only the
> > > > > >> user-defined metadata.
> > > > > >
> > > > > > Can you expand on why we need the flexibility of picking the metadata fields
> > > > > > here? Presumably we are talking about the use-cases where the XDP program
> > > > > > is doing redirect/pass and it doesn't really know who's the final
> > > > > > consumer is (might be another xdp program or might be the xdp->skb
> > > > > > kernel case), so the only sensible option here seems to be store everything?
> > > > > 
> > > > > For the same reason that we have separate kfuncs for each metadata field
> > > > > when getting it from the driver: XDP programs should have the
> > > > > flexibility to decide which pieces of metadata they need, and skip the
> > > > > overhead of stuff that is not needed.
> > > > > 
> > > > > For instance, say an XDP program knows that nothing in the system uses
> > > > > timestamps; in that case, it can skip both the getter and the setter
> > > > > call for timestamps.
> > 
> > Original RFC is talking about XDP -> XDP_REDIRECT -> skb use-case,
> > right? For this we pretty much know what kind of metadata we want to
> > preserve, so why not ship it in the existing metadata area and have
> > a kfunc that the xdp program will call prior to doing xdp_redirect?
> > This kfunc can do exactly what you're suggesting - skip the timestamp
> > if we know that the timestamping is off.
> > 
> > Or have we moved to discussing some other use-cases? What am I missing
> > about the need for some other new mechanism?
> > 
> > > > But doesn't it put us in the same place? Where the first (native) xdp program
> > > > needs to know which metadata the final consumer wants. At this point
> > > > why not propagate metadata layout as well?
> > > >
> > > > (or maybe I'm still missing what exact use-case we are trying to solve)
> > > 
> > > There are two different use-cases for the metadata:
> > > 
> > > * "Hardware" metadata (like the hash, rx_timestamp...). There are only a
> > >   few well known fields, and only XDP can access them to set them as
> > >   metadata, so storing them in a struct somewhere could make sense.
> > > 
> > > * Arbitrary metadata used by services. Eg a TC filter could set a field
> > >   describing which service a packet is for, and that could be reused for
> > >   iptables, routing, socket dispatch...
> > >   Similarly we could set a "packet_id" field that uniquely identifies a
> > >   packet so we can trace it throughout the network stack (through
> > >   clones, encap, decap, userspace services...).
> > >   The skb->mark, but with more room, and better support for sharing it.
> > > 
> > > We can only know the layout ahead of time for the first one. And they're
> > > similar enough in their requirements (need to be stored somewhere in the
> > > SKB, have a way of retrieving each one individually, that it seems to
> > > make sense to use a common API).
> > 
> > Why not have the following layout then?
> > 
> > +---------------+-------------------+----------------------------------------+------+
> > | more headroom | user-defined meta | hw-meta (potentially fixed skb format) | data |
> > +---------------+-------------------+----------------------------------------+------+
> >                 ^                                                            ^
> >             data_meta                                                      data
> > 
> > You obviously still have a problem of communicating the layout if you
> > have some redirects in between, but you, in theory still have this
> > problem with user-defined metadata anyway (unless I'm missing
> > something).
> > 
> > > > > I suppose we *could* support just a single call to set the skb meta,
> > > > > like:
> > > > > 
> > > > > bpf_set_skb_meta(struct xdp_md *pkt, struct xdp_hw_meta *data);
> > > > > 
> > > > > ...but in that case, we'd need to support some fields being unset
> > > > > anyway, and the program would have to populate the struct on the stack
> > > > > before performing the call. So it seems simpler to just have symmetry
> > > > > between the get (from HW) and set side? :)
> > > >
> > > > Why not simply bpf_set_skb_meta(struct xdp_md *pkt) and let it store
> > > > the metadata somewhere in xdp_md directly? (also presumably by
> > > > reusing most of the existing kfuncs/xmo_xxx helpers)
> > > 
> > > If we store it in xdp_md, the metadata won't be available higher up the
> > > stack (or am I missing something?). I think one of the goals is to let
> > > things other than XDP access it (maybe even the network stack itself?).
> > 
> > IIRC, xdp metadata gets copied to skb metadata, so it does propagate.
> > Although, it might have a detrimental effect on the gro, but I'm
> > assuming that is something that can be fixed separately.
> 
> I was thinking about this today so I'm glad you brought it up.
> 
> IIUC putting unique data in the metadata area will prevent GRO from
> working. I wonder if as a part of this work there's a cleaner way to
> indicate to XDP or GRO engine that some metadata should be ignored for
> coalescing purposes. Otherwise the final XDP prog before GRO would need
> to memset() all the relevant bytes to 0 (assuming that even works).

I'm assuming it is that way because there has to be a conscious decision
(TBD somewhere) about how to merge the metadata. IOW, there needs to be
some definition of 'ignored for coalescing purposes'. Do we ignore
the old metadata (the one that's already in the gro queue) or the new
metadata (in the skb)? What if there is a timestamp in the metadata?
In this case, depending on what you ignore, you get a different
timestamp.

