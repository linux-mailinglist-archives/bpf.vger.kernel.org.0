Return-Path: <bpf+bounces-71386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FDBBF0864
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 12:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4AC7188EEEB
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 10:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29552F5A03;
	Mon, 20 Oct 2025 10:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VshzGVNN"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846C31E9919
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 10:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955937; cv=none; b=tLl5JZ1CMn459+olVnZMbSkgAteQSYAhvkjH3ytABhrLRJT/4wDlsfApEBF3eonTvW3NjI6Iy7geeIQFKj5ueekghgdC70bBd9cWfJZx7/a/wBH/gpipKeB1VnIFV/3Dx7DhSYfvahc3RS+ZMmc+euxl7UdmgDdMAFiGdJsnZSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955937; c=relaxed/simple;
	bh=CwF+yZDak0Elu4utklnJ/uFv7Gi4MxASsza7h+em8FY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ihn+GWOqlImhy6u5m49XOXBcWqHrLOJZdRhikBYc12qOogt3AwjLw9c0X7WC6kOkqdGOHg+iLE66PogmEaZMFaZAYDtnGlD2kzByVntvu+zauu8tevbvGHRzL0S2Fo2w4/L4q+ZbFgn1J6tjUQBoxZF0IJKPVavgQUxBOVNKCBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VshzGVNN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760955934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xHVay0ecEvOk/WYTNlxi8BsqYH5mFIhmM9aH7MtmBnQ=;
	b=VshzGVNNZHdDT4MR6DbFRrV4urweC0wqxl1zTLkfRbnWb57iBKnMl8WYILXI2T/XwrVHXI
	73v4TYA474aKIdL7+FWkLQGSVeQ9HfouV/ERlv7NdGSQ8s5li4rPYXuu7l43iRlXOycvqY
	63LMHquHaR9wEy6p6yzMiGQTut8D4Qs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-ddePUa3yP-KznZwXFQ2ihA-1; Mon, 20 Oct 2025 06:25:33 -0400
X-MC-Unique: ddePUa3yP-KznZwXFQ2ihA-1
X-Mimecast-MFC-AGG-ID: ddePUa3yP-KznZwXFQ2ihA_1760955932
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-63c276d535bso3681966a12.3
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 03:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760955932; x=1761560732;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHVay0ecEvOk/WYTNlxi8BsqYH5mFIhmM9aH7MtmBnQ=;
        b=bg+/+jrQWnkWnD5YgIqLvPvjhmVYTnle2GcRlyZuW0tePaf/ClqiH6Sv+P3XJs7DnB
         3ys1u1kNFvDuhzFE8CUjwIsWwAHWWKRMMOQoRT9bTB7CNtL9u0L+MXHonDYKRb3qa510
         Ronr6VXBs+7tnxurFPt/7YSMT4G1vaqNZqZf9GEtU6WeZ59Qu4m7h6JELgcMvgT+1w6b
         GFoXJ2XZK3DtNbBoK8lV3w3F8aw16c+umQ0jftsZAT3YyD5PgvRd6mNXoUzPKHIKwBr0
         MXG8/YGVjUgtzzFcsynO+bmzdXqHF38tQwb/3ZWkp89puvgGjtTmaBtPX4LM6qrYmjsa
         YExw==
X-Gm-Message-State: AOJu0YywD72yGrCGAnR9yFUWy4wb6ZfCZG1elQ5mGpiLTqIYCBpFTyI1
	hGrMFECWXmrst6WtgzMbKqKnK57jk//DZQj3p7oGQ2toZUz8q3Y1MTw9MS1pPeVE/NUI8LI9uIA
	5ZYSjXuvYVY70Ogwvioek38X/4TdL7aJjGsZ7aVDpTIbSch3j3Ije7g==
X-Gm-Gg: ASbGncv+XrfH+s6b/QlTwb4dK6v9BiLHLN1tML7ezQkDzKjpPLLCjh9PY6tzPRwczaj
	G6ObPdXM1ArshyG888xxpJ9vOzP4EVDKmggAmq/Acca3cPiTc1Sv1QpPoMSxwpg7RUux/VBhb8v
	AaC4c9fkXEQ+GpDIxO38RWOvaFAOcIDapHm9MZXRMJZF0F/4owSI8k7IPdJT/169iN0efp8tmai
	NT//Ik/a/CtcOkkSj0ODrH7dU84j7cylxfmXOFMSDlTw5gL1iPW0Ca/soCmAJrydclHHPYVugIR
	21BBUcB6YrUFhqi15VzClc7G8O0lE1h/8tN+sr/7awRo29EFeH/w5MEuRr2WCi1K3XqEhsovQQt
	pMER/NPNjS1gjADScGONgfbXTRA==
X-Received: by 2002:a05:6402:f0f:b0:637:e94a:fb56 with SMTP id 4fb4d7f45d1cf-63c1f6da02bmr8502668a12.35.1760955931848;
        Mon, 20 Oct 2025 03:25:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEayzUZ8wlpZv1q9uCinMJ/D3prJbd1R7i0pa57HpUHs6t7Ux8nd9I3AiX4f+8zOHehqIINiw==
X-Received: by 2002:a05:6402:f0f:b0:637:e94a:fb56 with SMTP id 4fb4d7f45d1cf-63c1f6da02bmr8502645a12.35.1760955931347;
        Mon, 20 Oct 2025 03:25:31 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c49430272sm6305091a12.23.2025.10.20.03.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 03:25:30 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B219C2E9E7C; Mon, 20 Oct 2025 12:25:29 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, ilias.apalodimas@linaro.org, lorenzo@kernel.org,
 kuba@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com,
 andrii@kernel.org, stfomichev@gmail.com, aleksander.lobakin@intel.com
Subject: Re: [PATCH v2 bpf 2/2] veth: update mem type in xdp_buff
In-Reply-To: <aPKiC0jZV6kLBvIq@boxer>
References: <20251017143103.2620164-1-maciej.fijalkowski@intel.com>
 <20251017143103.2620164-3-maciej.fijalkowski@intel.com>
 <87a51pij2l.fsf@toke.dk> <aPJ0YqfH+pdSIbVS@boxer> <87347hifgh.fsf@toke.dk>
 <87zf9pgzx2.fsf@toke.dk> <aPKiC0jZV6kLBvIq@boxer>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 20 Oct 2025 12:25:29 +0200
Message-ID: <87wm4phnty.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> On Fri, Oct 17, 2025 at 08:12:57PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>>=20
>> > Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
>> >
>> >> On Fri, Oct 17, 2025 at 06:33:54PM +0200, Toke H=C3=B8iland-J=C3=B8rg=
ensen wrote:
>> >>> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
>> >>>=20
>> >>> > Veth calls skb_pp_cow_data() which makes the underlying memory to
>> >>> > originate from system page_pool. For CONFIG_DEBUG_VM=3Dy and XDP p=
rogram
>> >>> > that uses bpf_xdp_adjust_tail(), following splat was observed:
>> >>> >
>> >>> > [   32.204881] BUG: Bad page state in process test_progs  pfn:11c9=
8b
>> >>> > [   32.207167] page: refcount:0 mapcount:0 mapping:000000000000000=
0 index:0x0 pfn:0x11c98b
>> >>> > [   32.210084] flags: 0x1fffe0000000000(node=3D0|zone=3D1|lastcpup=
id=3D0x7fff)
>> >>> > [   32.212493] raw: 01fffe0000000000 dead000000000040 ff11000123c9=
b000 0000000000000000
>> >>> > [   32.218056] raw: 0000000000000000 0000000000000001 00000000ffff=
ffff 0000000000000000
>> >>> > [   32.220900] page dumped because: page_pool leak
>> >>> > [   32.222636] Modules linked in: bpf_testmod(O) bpf_preload
>> >>> > [   32.224632] CPU: 6 UID: 0 PID: 3612 Comm: test_progs Tainted: G=
 O        6.17.0-rc5-gfec474d29325 #6969 PREEMPT
>> >>> > [   32.224638] Tainted: [O]=3DOOT_MODULE
>> >>> > [   32.224639] Hardware name: QEMU Standard PC (i440FX + PIIX, 199=
6), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>> >>> > [   32.224641] Call Trace:
>> >>> > [   32.224644]  <IRQ>
>> >>> > [   32.224646]  dump_stack_lvl+0x4b/0x70
>> >>> > [   32.224653]  bad_page.cold+0xbd/0xe0
>> >>> > [   32.224657]  __free_frozen_pages+0x838/0x10b0
>> >>> > [   32.224660]  ? skb_pp_cow_data+0x782/0xc30
>> >>> > [   32.224665]  bpf_xdp_shrink_data+0x221/0x530
>> >>> > [   32.224668]  ? skb_pp_cow_data+0x6d1/0xc30
>> >>> > [   32.224671]  bpf_xdp_adjust_tail+0x598/0x810
>> >>> > [   32.224673]  ? xsk_destruct_skb+0x321/0x800
>> >>> > [   32.224678]  bpf_prog_004ac6bb21de57a7_xsk_xdp_adjust_tail+0x52=
/0xd6
>> >>> > [   32.224681]  veth_xdp_rcv_skb+0x45d/0x15a0
>> >>> > [   32.224684]  ? get_stack_info_noinstr+0x16/0xe0
>> >>> > [   32.224688]  ? veth_set_channels+0x920/0x920
>> >>> > [   32.224691]  ? get_stack_info+0x2f/0x80
>> >>> > [   32.224693]  ? unwind_next_frame+0x3af/0x1df0
>> >>> > [   32.224697]  veth_xdp_rcv.constprop.0+0x38a/0xbe0
>> >>> > [   32.224700]  ? common_startup_64+0x13e/0x148
>> >>> > [   32.224703]  ? veth_xdp_rcv_one+0xcd0/0xcd0
>> >>> > [   32.224706]  ? stack_trace_save+0x84/0xa0
>> >>> > [   32.224709]  ? stack_depot_save_flags+0x28/0x820
>> >>> > [   32.224713]  ? __resched_curr.constprop.0+0x332/0x3b0
>> >>> > [   32.224716]  ? timerqueue_add+0x217/0x320
>> >>> > [   32.224719]  veth_poll+0x115/0x5e0
>> >>> > [   32.224722]  ? veth_xdp_rcv.constprop.0+0xbe0/0xbe0
>> >>> > [   32.224726]  ? update_load_avg+0x1cb/0x12d0
>> >>> > [   32.224730]  ? update_cfs_group+0x121/0x2c0
>> >>> > [   32.224733]  __napi_poll+0xa0/0x420
>> >>> > [   32.224736]  net_rx_action+0x901/0xe90
>> >>> > [   32.224740]  ? run_backlog_napi+0x50/0x50
>> >>> > [   32.224743]  ? clockevents_program_event+0x1cc/0x280
>> >>> > [   32.224746]  ? hrtimer_interrupt+0x31e/0x7c0
>> >>> > [   32.224749]  handle_softirqs+0x151/0x430
>> >>> > [   32.224752]  do_softirq+0x3f/0x60
>> >>> > [   32.224755]  </IRQ>
>> >>> >
>> >>> > It's because xdp_rxq with mem model set to MEM_TYPE_PAGE_SHARED wa=
s used
>> >>> > when initializing xdp_buff.
>> >>> >
>> >>> > Fix this by using new helper xdp_convert_skb_to_buff() that, besid=
es
>> >>> > init/prepare xdp_buff, will check if page used for linear part of
>> >>> > xdp_buff comes from page_pool. We assume that linear data and frag=
s will
>> >>> > have same memory provider as currently XDP API does not provide us=
 a way
>> >>> > to distinguish it (the mem model is registered for *whole* Rx queu=
e and
>> >>> > here we speak about single buffer granularity).
>> >>> >
>> >>> > In order to meet expected skb layout by new helper, pull the mac h=
eader
>> >>> > before conversion from skb to xdp_buff.
>> >>> >
>> >>> > However, that is not enough as before releasing xdp_buff out of ve=
th via
>> >>> > XDP_{TX,REDIRECT}, mem type on xdp_rxq associated with xdp_buff is
>> >>> > restored to its original model. We need to respect previous settin=
g at
>> >>> > least until buff is converted to frame, as frame carries the mem_t=
ype.
>> >>> > Add a page_pool variant of veth_xdp_get() so that we avoid refcount
>> >>> > underflow when draining page frag.
>> >>> >
>> >>> > Fixes: 0ebab78cbcbf ("net: veth: add page_pool for page recycling")
>> >>> > Reported-by: Alexei Starovoitov <ast@kernel.org>
>> >>> > Closes: https://lore.kernel.org/bpf/CAADnVQ+bBofJDfieyOYzSmSujSfJw=
DTQhiz3aJw7hE+4E2_iPA@mail.gmail.com/
>> >>> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>> >>> > ---
>> >>> >  drivers/net/veth.c | 43 +++++++++++++++++++++++++++--------------=
--
>> >>> >  1 file changed, 27 insertions(+), 16 deletions(-)
>> >>> >
>> >>> > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
>> >>> > index a3046142cb8e..eeeee7bba685 100644
>> >>> > --- a/drivers/net/veth.c
>> >>> > +++ b/drivers/net/veth.c
>> >>> > @@ -733,7 +733,7 @@ static void veth_xdp_rcv_bulk_skb(struct veth_=
rq *rq, void **frames,
>> >>> >  	}
>> >>> >  }
>> >>> >=20=20
>> >>> > -static void veth_xdp_get(struct xdp_buff *xdp)
>> >>> > +static void veth_xdp_get_shared(struct xdp_buff *xdp)
>> >>> >  {
>> >>> >  	struct skb_shared_info *sinfo =3D xdp_get_shared_info_from_buff(=
xdp);
>> >>> >  	int i;
>> >>> > @@ -746,12 +746,33 @@ static void veth_xdp_get(struct xdp_buff *xd=
p)
>> >>> >  		__skb_frag_ref(&sinfo->frags[i]);
>> >>> >  }
>> >>> >=20=20
>> >>> > +static void veth_xdp_get_pp(struct xdp_buff *xdp)
>> >>> > +{
>> >>> > +	struct skb_shared_info *sinfo =3D xdp_get_shared_info_from_buff(=
xdp);
>> >>> > +	int i;
>> >>> > +
>> >>> > +	page_pool_ref_page(virt_to_page(xdp->data));
>> >>> > +	if (likely(!xdp_buff_has_frags(xdp)))
>> >>> > +		return;
>> >>> > +
>> >>> > +	for (i =3D 0; i < sinfo->nr_frags; i++) {
>> >>> > +		skb_frag_t *frag =3D &sinfo->frags[i];
>> >>> > +
>> >>> > +		page_pool_ref_page(netmem_to_page(frag->netmem));
>> >>> > +	}
>> >>> > +}
>> >>> > +
>> >>> > +static void veth_xdp_get(struct xdp_buff *xdp)
>> >>> > +{
>> >>> > +	xdp->rxq->mem.type =3D=3D MEM_TYPE_PAGE_POOL ?
>> >>> > +		veth_xdp_get_pp(xdp) : veth_xdp_get_shared(xdp);
>> >>> > +}
>> >>> > +
>> >>> >  static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
>> >>> >  					struct xdp_buff *xdp,
>> >>> >  					struct sk_buff **pskb)
>> >>> >  {
>> >>> >  	struct sk_buff *skb =3D *pskb;
>> >>> > -	u32 frame_sz;
>> >>> >=20=20
>> >>> >  	if (skb_shared(skb) || skb_head_is_locked(skb) ||
>> >>> >  	    skb_shinfo(skb)->nr_frags ||
>> >>> > @@ -762,19 +783,9 @@ static int veth_convert_skb_to_xdp_buff(struc=
t veth_rq *rq,
>> >>> >  		skb =3D *pskb;
>> >>> >  	}
>> >>> >=20=20
>> >>> > -	/* SKB "head" area always have tailroom for skb_shared_info */
>> >>> > -	frame_sz =3D skb_end_pointer(skb) - skb->head;
>> >>> > -	frame_sz +=3D SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>> >>> > -	xdp_init_buff(xdp, frame_sz, &rq->xdp_rxq);
>> >>> > -	xdp_prepare_buff(xdp, skb->head, skb_headroom(skb),
>> >>> > -			 skb_headlen(skb), true);
>> >>> > +	__skb_pull(*pskb, skb->data - skb_mac_header(skb));
>> >>>=20
>> >>> veth_xdp_rcv_skb() does:
>> >>>=20
>> >>> 	__skb_push(skb, skb->data - skb_mac_header(skb));
>> >>> 	if (veth_convert_skb_to_xdp_buff(rq, xdp, &skb))
>> >>>=20
>> >>> so how about just getting rid of that push instead of doing the oppo=
site
>> >>> pull straight after? :)
>> >>
>> >> Hi Toke,
>> >>
>> >> I believe this is done so we get a proper headroom representation whi=
ch is
>> >> needed for XDP_PACKET_HEADROOM comparison. Maybe we could be smarter =
here
>> >> and for example subtract mac header length? However I wanted to prese=
rve
>> >> old behavior.
>> >
>> > Yeah, basically what we want is to check if the mac_header offset is
>> > larger than the headroom. So the check could just be:
>> >
>> >     skb->mac_header < XDP_PACKET_HEADROOM
>> >
>> > however, it may be better to use the helper? Since that makes sure we
>> > keep hitting the DEBUG_NET_WARN_ON_ONCE inside the helper... So:
>> >
>> >     skb_mac_header(skb) - skb->head < XDP_PACKET_HEADROOM
>> >
>> > or, equivalently:
>> >
>> >     skb_headroom(skb) - skb_mac_offset(skb) < XDP_PACKET_HEADROOM
>> >
>> > I think the first one is probably more readable, since skb_mac_offset()
>> > is negative here, so the calculation looks off...
>>=20
>> Wait, veth_xdp_rcv_skb() calls skb_reset_mac_header() further down, so
>> it expects skb->data to point to the mac header. So getting rid of the
>
> Oof. Correct.
>
>> __skb_push() is not a good idea; but neither is doing the __skb_pull() as
>> your patch does currently.
>>=20
>> How about just making xdp_convert_skb_to_buff() agnostic to where
>> skb->data is?
>>=20
>> 	headroom =3D skb_mac_header(skb) - skb->head;
>>         data_len =3D skb->data + skb->len - skb_mac_header(skb);
>
> could we just use skb->tail - skb_mac_header(skb) here?

Yeah, guess so. Tail is a length, though, so that would be
skb_tail_pointer(skb) - skb_mac_header(skb)

> anyways, i'm gonna try out your suggestion on weekend or on monday and
> will send a v3. maybe input from someone else in different time zones will
> land in by tomorrow. thanks again:)

Cool!

-Toke


