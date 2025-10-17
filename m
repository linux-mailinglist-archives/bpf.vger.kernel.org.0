Return-Path: <bpf+bounces-71238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1457BEB1F0
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 19:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BCEE742B76
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 17:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C7132C947;
	Fri, 17 Oct 2025 17:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RuwHP5Ix"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB23F32C931
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760723528; cv=none; b=czeWw3ETk7FiOrnataHJt/VZwQ58S+jWyeVdeug3A4tD6iClRAExqxZLg6FVL1fg2CNO2+9F71heygQsq5iWpfYw+rOYJ80ivZxNamTBcxDAozncx9XiqjHokGIhtJWoF2IwSzzOEb/I7V7WUmE2oJJb+7vo3LzbxxGka+xrhjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760723528; c=relaxed/simple;
	bh=dXT0iXfRVPHvfidqKdfkzXW+fTOyMzN41RLUPxx3MuY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GPRusIwnmMSdAEqPmZ2tgIHzIm9W/kYcNA66gqbDM9RsLReMQ13hZgG3neWJ235cze4tp2j1eMXrwfFgtRTEKRYSwDcWGWjCJq3ALfPReeRa5u3fMYNEQIrxa3QUF5WhpxmabHTUFCLbpnKQS4kdckd4M5nBK/Ftmdb7ZFG+peU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RuwHP5Ix; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760723525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/H4CXDFjmdSfJh9MIG/jOrNJbAl5bAflLfgiJZYlR50=;
	b=RuwHP5Ix1M5P3suErDrprQR9gCJ4YYjHyirtJEt8sIUvSdJoPF8NCNbkNewN9TyE06TAuW
	WM5C+1ewjXTNpJUoQipuzhbtz/1s04hdKOrMq0lJoKZiZlEpBBkUM/bYkkddBiMEGlk6Cj
	1IRCWH7Q/GodbKxAqD0Dmf3wceYX28o=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-fDdSH2bYNgGhC00Fja5nWQ-1; Fri, 17 Oct 2025 13:52:02 -0400
X-MC-Unique: fDdSH2bYNgGhC00Fja5nWQ-1
X-Mimecast-MFC-AGG-ID: fDdSH2bYNgGhC00Fja5nWQ_1760723521
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b3cd833e7b5so301359266b.3
        for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 10:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760723521; x=1761328321;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/H4CXDFjmdSfJh9MIG/jOrNJbAl5bAflLfgiJZYlR50=;
        b=ceJYByEdyTANidfRtGcHy717KXK2idVVzeKSUg7gt3aE/z3rvYhbeu853tucNnOaLM
         w07t0WoUmZTbAB8zrLpyYWYQPP1AYuJb78Yt0+mwBboZpye+JPt5IRhFcu1Z5rgmwhLb
         csZGgkEuipnoEsWErnPAmtyiBfTCMtzzqTCgpn9kF8yA5XpZoBf+hiJr3pybD1lJ6aKw
         ADBq066L3aTrpCPDjIenWU/70UkAvsJSW0stcs2Q9TPbF9GX+ElyPTAakIQ583KDZt49
         r858mK3YNa1UcX/00lno8kpT8rNaltacVgIYeTR9ss8l8kgwFOzHNqL4NI2LVrJ5ojzy
         7ThQ==
X-Gm-Message-State: AOJu0YzTAD99FthEM3UDOP+Bc96QOXAi2kuywx30VfSaS67Pk1PFVhAs
	P5ITquBTm4bFSPgbhnbQZMeVvzoiJQzOYHH2GZysgtgA/ATQkCAx6faavwOW1z7vZPFYJfXQosr
	oZGHmuS/9Bs3r5mELJAqaw/2GsMMM9of4dQhMS7/uBfAUwAfVYht9xw==
X-Gm-Gg: ASbGnctTT4hd6Z8xaVR/z2XcOczlk8Wt/R+mzi4jtSIpXG3NKG5/hO4JVls83HyZMyk
	lXEz0ChsozhXMZJ7kke9GkB5JDCLNvsFRyPUu8Mnc3sKqqE+jGjVKczA/hEYu1hJ2kxE2K2C0G6
	l476RYyySJXSpA5hcPkmaMU2Lw2A72Lqdbawxaq8MW+n3GrkKyRxYq7dMxVEregYkVqGWzYO4Rv
	/pkKzGxjAuci3uEwK/EKDVl5TQ5K9AKeJhGUwRd1t9CbT0TLkfKp1Gm3z6iIZUMrkBT5+eD+j+f
	rgpmj6zoyCA3xqJmvvdV5oQiRtVjotuTZccK//usKzc5R2yJSgMyhLltFUdhYCBu3uqIc/fihAq
	XnqVCpvugWUFf0utYYikc3WY=
X-Received: by 2002:a17:907:3f04:b0:b3f:a960:e057 with SMTP id a640c23a62f3a-b64749411b1mr560266666b.31.1760723520557;
        Fri, 17 Oct 2025 10:52:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkijthzj0Q/TyM9UrRkccVJhW3e2AjCisrN8s5J8rWS+/7upU0njEVv3isPSWP4K4EIXb+Tg==
X-Received: by 2002:a17:907:3f04:b0:b3f:a960:e057 with SMTP id a640c23a62f3a-b64749411b1mr560262966b.31.1760723520029;
        Fri, 17 Oct 2025 10:52:00 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e83914d0sm30996566b.21.2025.10.17.10.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 10:51:59 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4ADE62E9D4D; Fri, 17 Oct 2025 19:51:58 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, ilias.apalodimas@linaro.org, lorenzo@kernel.org,
 kuba@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com,
 andrii@kernel.org, stfomichev@gmail.com, aleksander.lobakin@intel.com
Subject: Re: [PATCH v2 bpf 2/2] veth: update mem type in xdp_buff
In-Reply-To: <aPJ0YqfH+pdSIbVS@boxer>
References: <20251017143103.2620164-1-maciej.fijalkowski@intel.com>
 <20251017143103.2620164-3-maciej.fijalkowski@intel.com>
 <87a51pij2l.fsf@toke.dk> <aPJ0YqfH+pdSIbVS@boxer>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 17 Oct 2025 19:51:58 +0200
Message-ID: <87347hifgh.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> On Fri, Oct 17, 2025 at 06:33:54PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
>>=20
>> > Veth calls skb_pp_cow_data() which makes the underlying memory to
>> > originate from system page_pool. For CONFIG_DEBUG_VM=3Dy and XDP progr=
am
>> > that uses bpf_xdp_adjust_tail(), following splat was observed:
>> >
>> > [   32.204881] BUG: Bad page state in process test_progs  pfn:11c98b
>> > [   32.207167] page: refcount:0 mapcount:0 mapping:0000000000000000 in=
dex:0x0 pfn:0x11c98b
>> > [   32.210084] flags: 0x1fffe0000000000(node=3D0|zone=3D1|lastcpupid=
=3D0x7fff)
>> > [   32.212493] raw: 01fffe0000000000 dead000000000040 ff11000123c9b000=
 0000000000000000
>> > [   32.218056] raw: 0000000000000000 0000000000000001 00000000ffffffff=
 0000000000000000
>> > [   32.220900] page dumped because: page_pool leak
>> > [   32.222636] Modules linked in: bpf_testmod(O) bpf_preload
>> > [   32.224632] CPU: 6 UID: 0 PID: 3612 Comm: test_progs Tainted: G O  =
      6.17.0-rc5-gfec474d29325 #6969 PREEMPT
>> > [   32.224638] Tainted: [O]=3DOOT_MODULE
>> > [   32.224639] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), =
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>> > [   32.224641] Call Trace:
>> > [   32.224644]  <IRQ>
>> > [   32.224646]  dump_stack_lvl+0x4b/0x70
>> > [   32.224653]  bad_page.cold+0xbd/0xe0
>> > [   32.224657]  __free_frozen_pages+0x838/0x10b0
>> > [   32.224660]  ? skb_pp_cow_data+0x782/0xc30
>> > [   32.224665]  bpf_xdp_shrink_data+0x221/0x530
>> > [   32.224668]  ? skb_pp_cow_data+0x6d1/0xc30
>> > [   32.224671]  bpf_xdp_adjust_tail+0x598/0x810
>> > [   32.224673]  ? xsk_destruct_skb+0x321/0x800
>> > [   32.224678]  bpf_prog_004ac6bb21de57a7_xsk_xdp_adjust_tail+0x52/0xd6
>> > [   32.224681]  veth_xdp_rcv_skb+0x45d/0x15a0
>> > [   32.224684]  ? get_stack_info_noinstr+0x16/0xe0
>> > [   32.224688]  ? veth_set_channels+0x920/0x920
>> > [   32.224691]  ? get_stack_info+0x2f/0x80
>> > [   32.224693]  ? unwind_next_frame+0x3af/0x1df0
>> > [   32.224697]  veth_xdp_rcv.constprop.0+0x38a/0xbe0
>> > [   32.224700]  ? common_startup_64+0x13e/0x148
>> > [   32.224703]  ? veth_xdp_rcv_one+0xcd0/0xcd0
>> > [   32.224706]  ? stack_trace_save+0x84/0xa0
>> > [   32.224709]  ? stack_depot_save_flags+0x28/0x820
>> > [   32.224713]  ? __resched_curr.constprop.0+0x332/0x3b0
>> > [   32.224716]  ? timerqueue_add+0x217/0x320
>> > [   32.224719]  veth_poll+0x115/0x5e0
>> > [   32.224722]  ? veth_xdp_rcv.constprop.0+0xbe0/0xbe0
>> > [   32.224726]  ? update_load_avg+0x1cb/0x12d0
>> > [   32.224730]  ? update_cfs_group+0x121/0x2c0
>> > [   32.224733]  __napi_poll+0xa0/0x420
>> > [   32.224736]  net_rx_action+0x901/0xe90
>> > [   32.224740]  ? run_backlog_napi+0x50/0x50
>> > [   32.224743]  ? clockevents_program_event+0x1cc/0x280
>> > [   32.224746]  ? hrtimer_interrupt+0x31e/0x7c0
>> > [   32.224749]  handle_softirqs+0x151/0x430
>> > [   32.224752]  do_softirq+0x3f/0x60
>> > [   32.224755]  </IRQ>
>> >
>> > It's because xdp_rxq with mem model set to MEM_TYPE_PAGE_SHARED was us=
ed
>> > when initializing xdp_buff.
>> >
>> > Fix this by using new helper xdp_convert_skb_to_buff() that, besides
>> > init/prepare xdp_buff, will check if page used for linear part of
>> > xdp_buff comes from page_pool. We assume that linear data and frags wi=
ll
>> > have same memory provider as currently XDP API does not provide us a w=
ay
>> > to distinguish it (the mem model is registered for *whole* Rx queue and
>> > here we speak about single buffer granularity).
>> >
>> > In order to meet expected skb layout by new helper, pull the mac header
>> > before conversion from skb to xdp_buff.
>> >
>> > However, that is not enough as before releasing xdp_buff out of veth v=
ia
>> > XDP_{TX,REDIRECT}, mem type on xdp_rxq associated with xdp_buff is
>> > restored to its original model. We need to respect previous setting at
>> > least until buff is converted to frame, as frame carries the mem_type.
>> > Add a page_pool variant of veth_xdp_get() so that we avoid refcount
>> > underflow when draining page frag.
>> >
>> > Fixes: 0ebab78cbcbf ("net: veth: add page_pool for page recycling")
>> > Reported-by: Alexei Starovoitov <ast@kernel.org>
>> > Closes: https://lore.kernel.org/bpf/CAADnVQ+bBofJDfieyOYzSmSujSfJwDTQh=
iz3aJw7hE+4E2_iPA@mail.gmail.com/
>> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>> > ---
>> >  drivers/net/veth.c | 43 +++++++++++++++++++++++++++----------------
>> >  1 file changed, 27 insertions(+), 16 deletions(-)
>> >
>> > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
>> > index a3046142cb8e..eeeee7bba685 100644
>> > --- a/drivers/net/veth.c
>> > +++ b/drivers/net/veth.c
>> > @@ -733,7 +733,7 @@ static void veth_xdp_rcv_bulk_skb(struct veth_rq *=
rq, void **frames,
>> >  	}
>> >  }
>> >=20=20
>> > -static void veth_xdp_get(struct xdp_buff *xdp)
>> > +static void veth_xdp_get_shared(struct xdp_buff *xdp)
>> >  {
>> >  	struct skb_shared_info *sinfo =3D xdp_get_shared_info_from_buff(xdp);
>> >  	int i;
>> > @@ -746,12 +746,33 @@ static void veth_xdp_get(struct xdp_buff *xdp)
>> >  		__skb_frag_ref(&sinfo->frags[i]);
>> >  }
>> >=20=20
>> > +static void veth_xdp_get_pp(struct xdp_buff *xdp)
>> > +{
>> > +	struct skb_shared_info *sinfo =3D xdp_get_shared_info_from_buff(xdp);
>> > +	int i;
>> > +
>> > +	page_pool_ref_page(virt_to_page(xdp->data));
>> > +	if (likely(!xdp_buff_has_frags(xdp)))
>> > +		return;
>> > +
>> > +	for (i =3D 0; i < sinfo->nr_frags; i++) {
>> > +		skb_frag_t *frag =3D &sinfo->frags[i];
>> > +
>> > +		page_pool_ref_page(netmem_to_page(frag->netmem));
>> > +	}
>> > +}
>> > +
>> > +static void veth_xdp_get(struct xdp_buff *xdp)
>> > +{
>> > +	xdp->rxq->mem.type =3D=3D MEM_TYPE_PAGE_POOL ?
>> > +		veth_xdp_get_pp(xdp) : veth_xdp_get_shared(xdp);
>> > +}
>> > +
>> >  static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
>> >  					struct xdp_buff *xdp,
>> >  					struct sk_buff **pskb)
>> >  {
>> >  	struct sk_buff *skb =3D *pskb;
>> > -	u32 frame_sz;
>> >=20=20
>> >  	if (skb_shared(skb) || skb_head_is_locked(skb) ||
>> >  	    skb_shinfo(skb)->nr_frags ||
>> > @@ -762,19 +783,9 @@ static int veth_convert_skb_to_xdp_buff(struct ve=
th_rq *rq,
>> >  		skb =3D *pskb;
>> >  	}
>> >=20=20
>> > -	/* SKB "head" area always have tailroom for skb_shared_info */
>> > -	frame_sz =3D skb_end_pointer(skb) - skb->head;
>> > -	frame_sz +=3D SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>> > -	xdp_init_buff(xdp, frame_sz, &rq->xdp_rxq);
>> > -	xdp_prepare_buff(xdp, skb->head, skb_headroom(skb),
>> > -			 skb_headlen(skb), true);
>> > +	__skb_pull(*pskb, skb->data - skb_mac_header(skb));
>>=20
>> veth_xdp_rcv_skb() does:
>>=20
>> 	__skb_push(skb, skb->data - skb_mac_header(skb));
>> 	if (veth_convert_skb_to_xdp_buff(rq, xdp, &skb))
>>=20
>> so how about just getting rid of that push instead of doing the opposite
>> pull straight after? :)
>
> Hi Toke,
>
> I believe this is done so we get a proper headroom representation which is
> needed for XDP_PACKET_HEADROOM comparison. Maybe we could be smarter here
> and for example subtract mac header length? However I wanted to preserve
> old behavior.

Yeah, basically what we want is to check if the mac_header offset is
larger than the headroom. So the check could just be:

    skb->mac_header < XDP_PACKET_HEADROOM

however, it may be better to use the helper? Since that makes sure we
keep hitting the DEBUG_NET_WARN_ON_ONCE inside the helper... So:

    skb_mac_header(skb) - skb->head < XDP_PACKET_HEADROOM

or, equivalently:

    skb_headroom(skb) - skb_mac_offset(skb) < XDP_PACKET_HEADROOM

I think the first one is probably more readable, since skb_mac_offset()
is negative here, so the calculation looks off...

-Toke


