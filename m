Return-Path: <bpf+bounces-40911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43EA98FC34
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 04:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A658281F5B
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 02:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813961BDC8;
	Fri,  4 Oct 2024 02:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="iGi+3X3V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e3cLK8mr"
X-Original-To: bpf@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8804117547;
	Fri,  4 Oct 2024 02:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728007995; cv=none; b=D3rDckSjsciyzZCOGKnjckzsKHxWFcSa8KMtsROvZXB3enJtvgpAMlmNYYJXHNFEkwBjlIVLrW/2/dcUsh38C1iCeBw1+yaFCU9RVoaNfAkHSrylInqBRGqQFStEMy0O3MPAmNBkx6UBOZVb1BfJdwTP0dUHw1h/tnyTl9CuszU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728007995; c=relaxed/simple;
	bh=3fK7GChpVNnKxwBRh5J9MBnN/QIevOP3WmPmABiTuck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7OgopLDIVsPIrWZo/rzbwLtjiCxb9PSzj3HfFPCcQyCPwjgjIriJfwy/ojTpX6SH8FfIS8z9ix5HBT0yvo9ngYt1IxQH3QDV3D0O7FxT2PKUk90Teq/VqLpvz54jxIdzqdrEWQQmYNHExl1/lmkcyQ+COvOvta3kNZO6TB0JmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=iGi+3X3V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e3cLK8mr; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 883541380141;
	Thu,  3 Oct 2024 22:13:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 03 Oct 2024 22:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728007992;
	 x=1728094392; bh=DNnO7oBJ38aTEcsogdYXkdlehmzDHYXoYjI0FO0UbwQ=; b=
	iGi+3X3VKyVxDp1gyOD/0VT6rGq6iHlqiZpsLLrBmv9NiDIn8aGHSnlwoWeExEfg
	G78XSMTqMyQLD5rqxzhli4zUwxyV+381CAaccud1hLodiHWL3LFm9Kiq147aYPoO
	OwYfIj9ibX5hyz6dN6PTMTvpJOutiq0z0+Hu3MimABO30xgNdfM0Chbe+RrSsknm
	YrywqqT7pm/vnFBeHgudxKZ/WUUcrsZynskUMJ1KBJrPMp1kAaUu8gTP1R5LqPq1
	VQUIe9GtFr99GnzX6c1mRcK5aTxHXWh4li0IgkWlEiFCfQmoal+i00tL13FwtoUL
	cDb8HBqcuSto8Oik4jV0rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728007992; x=
	1728094392; bh=DNnO7oBJ38aTEcsogdYXkdlehmzDHYXoYjI0FO0UbwQ=; b=e
	3cLK8mrPBFO6/X8/vwEwAveCfZA9R74+7BVBOkbxGhgGufa+XkwZxr1x5b5LUgWG
	dZzBFKBoT+tpiy0HvClbWDsR+ZkLU0SoHJwpUpWODid/3/jmh+6BNfLfwIRYvhCo
	Y34fVPA2QgJ0SivyifqyCxlWGpgF5Ypm5KLlYQ7JDZW4JhC6rabtnAU4mBMCGjyr
	j0xb/DGDA5MUEBzaLgXxxRZq4uevxhRW/TGrHON0JcnL20cdFGRzBD1dUB9WDaKw
	RgX0Wtfz39qve4eCazvjsf+aKSV/sETle78SSK7Kds3jSkWTG/cXkvJJKwudTZ/d
	2Rij8JyyJwWPM+stesxoA==
X-ME-Sender: <xms:N0__ZmR-fw1VACOo_U96KG3sJlP2oBJ5rezx8IJvni-dxcMZVJ2hHA>
    <xme:N0__ZrzE_M7ETwTvoem6gF8LuwCMOE1xB0Gv7mvbo3dO9_gBOjg8-0cgh_mAHnSEL
    H4Q8XxoRCEnTYsFXg>
X-ME-Received: <xmr:N0__Zj0EEZcNkuOPC9HaIKdIsrZhLzGPI1NDJERX8094df-SYReXKmV0VsIroKa193TMiNRmvgNBMN09Qsdtfsb3ZJDS7yZ9LbZkik1t3_Qoqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvvddgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhf
    gggtugfgjgestheksfdttddtudenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihuse
    gugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpedufeeitdeiheffueffleffgeeh
    geejkeetkefgtdekfeejheffjedtgfekieetleenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiipdhnsggprhgt
    phhtthhopedvledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtfhhomhhitg
    hhvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghfrggsrhgvsegtlhhouhgufhhl
    rghrvgdrtghomhdprhgtphhtthhopehtohhkvgesrhgvughhrghtrdgtohhmpdhrtghpth
    htoheplhhorhgvnhiioheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhorhgvnhii
    ohdrsghirghntghonhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhrgifkheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrkhhusgestghlohhuughflhgrrhgvrdgt
    ohhmpdhrtghpthhtoheprghlvghkshgrnhguvghrrdhlohgsrghkihhnsehinhhtvghlrd
    gtohhmpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:N0__ZiAILa9QrxONVn0NgRn9Rvb7mnPy3B278mrZhGqrRKY9pI8YeQ>
    <xmx:N0__Zvj5PIVlcGE6uUrJPBjgR6BadsTp-KNJZo4qyKScZf3KgdwMzA>
    <xmx:N0__ZuraEYVvb9TYjden7Ids7dEErKfgc1SpQTert3LAbRJ93nMWkQ>
    <xmx:N0__ZigDnuGw6-9_wFIEX-UT_7aQuNYLFWbGCqUL1sfwHM6rbXwajg>
    <xmx:OE__ZgawQ9m_l61gXPYIbruBogG1yskokX2KrZ5QOrMIaFULc7cMCc6S>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 22:13:08 -0400 (EDT)
Date: Thu, 3 Oct 2024 20:13:06 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Arthur Fabre <afabre@cloudflare.com>, 
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	davem@davemloft.net, kuba@kernel.org, john.fastabend@gmail.com, edumazet@google.com, 
	pabeni@redhat.com, sdf@fomichev.me, tariqt@nvidia.com, saeedm@nvidia.com, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org, 
	mst@redhat.com, jasowang@redhat.com, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, kernel-team <kernel-team@cloudflare.com>, 
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [RFC bpf-next 0/4] Add XDP rx hw hints support performing
 XDP_REDIRECT
Message-ID: <2fy5vuewgwkh3o3mx5v4bkrzu6josqylraa4ocgzqib6a7ozt4@hwsuhcibtcb6>
References: <871q11s91e.fsf@toke.dk>
 <ZvqQOpqnK9hBmXNn@lore-desk>
 <D4KJ7DUXJQC5.2UFST9L3CUOH7@bobby>
 <ZvwNQqN4gez1Ksfn@lore-desk>
 <87zfnnq2hs.fsf@toke.dk>
 <Zv18pxsiTGTZSTyO@mini-arch>
 <87ttdunydz.fsf@toke.dk>
 <Zv3N5G8swr100EXm@mini-arch>
 <D4LYNKGLE7G0.3JAN5MX1ATPTB@bobby>
 <Zv794Ot-kOq1pguM@mini-arch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zv794Ot-kOq1pguM@mini-arch>

Hi Stan,

On Thu, Oct 03, 2024 at 01:26:08PM GMT, Stanislav Fomichev wrote:
> On 10/03, Arthur Fabre wrote:
> > On Thu Oct 3, 2024 at 12:49 AM CEST, Stanislav Fomichev wrote:
> > > On 10/02, Toke Høiland-Jørgensen wrote:
> > > > Stanislav Fomichev <stfomichev@gmail.com> writes:
> > > > 
> > > > > On 10/01, Toke Høiland-Jørgensen wrote:
> > > > >> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> > > > >> 
> > > > >> >> On Mon Sep 30, 2024 at 1:49 PM CEST, Lorenzo Bianconi wrote:
> > > > >> >> > > Lorenzo Bianconi <lorenzo@kernel.org> writes:
> > > > >> >> > > 
> > > > >> >> > > >> > We could combine such a registration API with your header format, so
> > > > >> >> > > >> > that the registration just becomes a way of allocating one of the keys
> > > > >> >> > > >> > from 0-63 (and the registry just becomes a global copy of the header).
> > > > >> >> > > >> > This would basically amount to moving the "service config file" into the
> > > > >> >> > > >> > kernel, since that seems to be the only common denominator we can rely
> > > > >> >> > > >> > on between BPF applications (as all attempts to write a common daemon
> > > > >> >> > > >> > for BPF management have shown).
> > > > >> >> > > >> 
> > > > >> >> > > >> That sounds reasonable. And I guess we'd have set() check the global
> > > > >> >> > > >> registry to enforce that the key has been registered beforehand?
> > > > >> >> > > >> 
> > > > >> >> > > >> >
> > > > >> >> > > >> > -Toke
> > > > >> >> > > >> 
> > > > >> >> > > >> Thanks for all the feedback!
> > > > >> >> > > >
> > > > >> >> > > > I like this 'fast' KV approach but I guess we should really evaluate its
> > > > >> >> > > > impact on performances (especially for xdp) since, based on the kfunc calls
> > > > >> >> > > > order in the ebpf program, we can have one or multiple memmove/memcpy for
> > > > >> >> > > > each packet, right?
> > > > >> >> > > 
> > > > >> >> > > Yes, with Arthur's scheme, performance will be ordering dependent. Using
> > > > >> >> > > a global registry for offsets would sidestep this, but have the
> > > > >> >> > > synchronisation issues we discussed up-thread. So on balance, I think
> > > > >> >> > > the memmove() suggestion will probably lead to the least pain.
> > > > >> >> > > 
> > > > >> >> > > For the HW metadata we could sidestep this by always having a fixed
> > > > >> >> > > struct for it (but using the same set/get() API with reserved keys). The
> > > > >> >> > > only drawback of doing that is that we statically reserve a bit of
> > > > >> >> > > space, but I'm not sure that is such a big issue in practice (at least
> > > > >> >> > > not until this becomes to popular that the space starts to be contended;
> > > > >> >> > > but surely 256 bytes ought to be enough for everybody, right? :)).
> > > > >> >> >
> > > > >> >> > I am fine with the proposed approach, but I think we need to verify what is the
> > > > >> >> > impact on performances (in the worst case??)
> > > > >> >> 
> > > > >> >> If drivers are responsible for populating the hardware metadata before
> > > > >> >> XDP, we could make sure drivers set the fields in order to avoid any
> > > > >> >> memove() (and maybe even provide a helper to ensure this?).
> > > > >> >
> > > > >> > nope, since the current APIs introduced by Stanislav are consuming NIC
> > > > >> > metadata in kfuncs (mainly for af_xdp) and, according to my understanding,
> > > > >> > we want to add a kfunc to store the info for each NIC metadata (e.g rx-hash,
> > > > >> > timestamping, ..) into the packet (this is what Toke is proposing, right?).
> > > > >> > In this case kfunc calling order makes a difference.
> > > > >> > We can think even to add single kfunc to store all the info for all the NIC
> > > > >> > metadata (maybe via a helping struct) but it seems not scalable to me and we
> > > > >> > are losing kfunc versatility.
> > > > >> 
> > > > >> Yes, I agree we should have separate kfuncs for each metadata field.
> > > > >> Which means it makes a lot of sense to just use the same setter API that
> > > > >> we use for the user-registered metadata fields, but using reserved keys.
> > > > >> So something like:
> > > > >> 
> > > > >> #define BPF_METADATA_HW_HASH      BIT(60)
> > > > >> #define BPF_METADATA_HW_TIMESTAMP BIT(61)
> > > > >> #define BPF_METADATA_HW_VLAN      BIT(62)
> > > > >> #define BPF_METADATA_RESERVED (0xffff << 48)
> > > > >> 
> > > > >> bpf_packet_metadata_set(pkt, BPF_METADATA_HW_HASH, hash_value);
> > > > >> 
> > > > >> 
> > > > >> As for the internal representation, we can just have the kfunc do
> > > > >> something like:
> > > > >> 
> > > > >> int bpf_packet_metadata_set(field_id, value) {
> > > > >>   switch(field_id) {
> > > > >>     case BPF_METADATA_HW_HASH:
> > > > >>       pkt->xdp_hw_meta.hash = value;
> > > > >>       break;
> > > > >>     [...]
> > > > >>     default:
> > > > >>       /* do the key packing thing */
> > > > >>   }
> > > > >> }
> > > > >> 
> > > > >> 
> > > > >> that way the order of setting the HW fields doesn't matter, only the
> > > > >> user-defined metadata.
> > > > >
> > > > > Can you expand on why we need the flexibility of picking the metadata fields
> > > > > here? Presumably we are talking about the use-cases where the XDP program
> > > > > is doing redirect/pass and it doesn't really know who's the final
> > > > > consumer is (might be another xdp program or might be the xdp->skb
> > > > > kernel case), so the only sensible option here seems to be store everything?
> > > > 
> > > > For the same reason that we have separate kfuncs for each metadata field
> > > > when getting it from the driver: XDP programs should have the
> > > > flexibility to decide which pieces of metadata they need, and skip the
> > > > overhead of stuff that is not needed.
> > > > 
> > > > For instance, say an XDP program knows that nothing in the system uses
> > > > timestamps; in that case, it can skip both the getter and the setter
> > > > call for timestamps.
> 
> Original RFC is talking about XDP -> XDP_REDIRECT -> skb use-case,
> right? For this we pretty much know what kind of metadata we want to
> preserve, so why not ship it in the existing metadata area and have
> a kfunc that the xdp program will call prior to doing xdp_redirect?
> This kfunc can do exactly what you're suggesting - skip the timestamp
> if we know that the timestamping is off.
> 
> Or have we moved to discussing some other use-cases? What am I missing
> about the need for some other new mechanism?
> 
> > > But doesn't it put us in the same place? Where the first (native) xdp program
> > > needs to know which metadata the final consumer wants. At this point
> > > why not propagate metadata layout as well?
> > >
> > > (or maybe I'm still missing what exact use-case we are trying to solve)
> > 
> > There are two different use-cases for the metadata:
> > 
> > * "Hardware" metadata (like the hash, rx_timestamp...). There are only a
> >   few well known fields, and only XDP can access them to set them as
> >   metadata, so storing them in a struct somewhere could make sense.
> > 
> > * Arbitrary metadata used by services. Eg a TC filter could set a field
> >   describing which service a packet is for, and that could be reused for
> >   iptables, routing, socket dispatch...
> >   Similarly we could set a "packet_id" field that uniquely identifies a
> >   packet so we can trace it throughout the network stack (through
> >   clones, encap, decap, userspace services...).
> >   The skb->mark, but with more room, and better support for sharing it.
> > 
> > We can only know the layout ahead of time for the first one. And they're
> > similar enough in their requirements (need to be stored somewhere in the
> > SKB, have a way of retrieving each one individually, that it seems to
> > make sense to use a common API).
> 
> Why not have the following layout then?
> 
> +---------------+-------------------+----------------------------------------+------+
> | more headroom | user-defined meta | hw-meta (potentially fixed skb format) | data |
> +---------------+-------------------+----------------------------------------+------+
>                 ^                                                            ^
>             data_meta                                                      data
> 
> You obviously still have a problem of communicating the layout if you
> have some redirects in between, but you, in theory still have this
> problem with user-defined metadata anyway (unless I'm missing
> something).
> 
> > > > I suppose we *could* support just a single call to set the skb meta,
> > > > like:
> > > > 
> > > > bpf_set_skb_meta(struct xdp_md *pkt, struct xdp_hw_meta *data);
> > > > 
> > > > ...but in that case, we'd need to support some fields being unset
> > > > anyway, and the program would have to populate the struct on the stack
> > > > before performing the call. So it seems simpler to just have symmetry
> > > > between the get (from HW) and set side? :)
> > >
> > > Why not simply bpf_set_skb_meta(struct xdp_md *pkt) and let it store
> > > the metadata somewhere in xdp_md directly? (also presumably by
> > > reusing most of the existing kfuncs/xmo_xxx helpers)
> > 
> > If we store it in xdp_md, the metadata won't be available higher up the
> > stack (or am I missing something?). I think one of the goals is to let
> > things other than XDP access it (maybe even the network stack itself?).
> 
> IIRC, xdp metadata gets copied to skb metadata, so it does propagate.
> Although, it might have a detrimental effect on the gro, but I'm
> assuming that is something that can be fixed separately.

I was thinking about this today so I'm glad you brought it up.

IIUC putting unique data in the metadata area will prevent GRO from
working. I wonder if as a part of this work there's a cleaner way to
indicate to XDP or GRO engine that some metadata should be ignored for
coalescing purposes. Otherwise the final XDP prog before GRO would need
to memset() all the relevant bytes to 0 (assuming that even works).

Thanks,
Daniel

