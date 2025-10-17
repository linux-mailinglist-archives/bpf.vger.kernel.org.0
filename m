Return-Path: <bpf+bounces-71240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D0020BEB2A0
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 20:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 299B64EC920
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 18:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E5332E13C;
	Fri, 17 Oct 2025 18:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WlyhcpU3"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F2E258EE9
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 18:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760724786; cv=none; b=lERXqRGEyX5A5QHg5/8cjeweWslhrew8C1KEpFV6D2GXGYAqMuxn167fMlaHZorsbL89fQbvvi5s0Q2Bujthta0uPLL6tl29snGpDbAjmgzHvByh3H1EoBqii0A53rIv/ROav74sfmZeJ6I/alLYLXaiDQjBmL5aC1nk8LV4lCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760724786; c=relaxed/simple;
	bh=CCY7VgcibYEz6K3Dr6QZCPUP+jSxg3m4v98zgp3j0W4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oDlJc5h0QgWE9MyiQ+zoazPGNyHrJu+4DkSzX7/q9GMdJKegJiD2jzSHBPCoQbGlppRcPeO6v23hpzzPyK9JFh8Rjc2mwCDtmj6MLJZOr18dIgphTQw7SzI7OAf9zHdxegsQlUO3R/6YakZibqz+/5P9VKmBHz5QSIikrsBn/HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WlyhcpU3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760724783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HcyP3sJ5G5l2WUJS/BGTnYDpK0ZfNfpxNhbf97gDS7k=;
	b=WlyhcpU325E19J8sjIGLPMmjSMiPmvmMOyFXECQAq493a9HgDiE+2Trkj/AMPLtnZyYleI
	5i2mgMrvKbe2bMmWl4IxbM5TJv4KDIu9m613DLQytbBprMY54OW9R2787xbg09C0J8vyO9
	+9pIkOHbKJUsF0QtIEJI2xpW9Qmvx4M=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-DNTdHcAgM0W1PoCleZl-Pw-1; Fri, 17 Oct 2025 14:13:02 -0400
X-MC-Unique: DNTdHcAgM0W1PoCleZl-Pw-1
X-Mimecast-MFC-AGG-ID: DNTdHcAgM0W1PoCleZl-Pw_1760724781
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-634cdb5d528so4273942a12.1
        for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 11:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760724781; x=1761329581;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcyP3sJ5G5l2WUJS/BGTnYDpK0ZfNfpxNhbf97gDS7k=;
        b=vqW/1rROqGJ9sIiWUgNh34WKjcIKENbh5gX3SRhZm8V/amE6T67ybzUanvwXE73p2h
         jVe92+EgmTukV5U0W011BN2BsQvBLNtoZSeh53vVsPDlg4es69WXUCXRlxMUpbJrOgxj
         F+yFu9PCQboAvSO9D4I1qdNfXnOOGRw60coyOX6hehDnmoaPm31XXnhi+2zxUZ4crFH7
         oGMxVwASt7TpM2PTAmXC9Cs0OrbDJ9xJGlalpVIBkB0vgrkS+cNc0M+qP5VBwdKlf30B
         b+f3ycjXcHt28PogGOfeu7Q7rXNP+wFEHrYYNGdP7MIV2h8LNVVE+1ImOvyf/i9eeZSO
         C0Pw==
X-Gm-Message-State: AOJu0YwniS2AuEP3upNu2Wz9V670kzkOvk16ibIrdIVLRtvupkElHD0y
	95BkCXzLKnhO8Gp+VVgdSqBk084NIlzD8HFOQW1CSO9QPlPfySDXy1UFWJ4Egb8vbG0y/1NtKT/
	JBjM7lfWcoaenBykIjHbuX1rT7Hwotk510XjC1Q8kOjRacC1dzpYfNQ==
X-Gm-Gg: ASbGncvntKmZHzPrEDN6GVmMwcF2ENnVmBWCNEZS6V9x0oJzYb9wMof9dBp9GlItvxY
	hNgKx15iaC13IJLWy7qNxGvuMM43gtcLVH2DmoZUVmELDsB0TDZPUdzUP8j/c91nwH027xuiRDl
	MwlFBYu7EWB/V957fgj3zQ9/EZmgvYktwAPSkgwkDSpgvPBTmzYBo5M7Aeygpd4QeRSekVELeN5
	o0l4Sql9zw6U5+YL40xIwMOOv95ls+xxo+tGdiXxAeXf8ZcqznVciFRO0CEogz8zrHQqggngVzb
	oi4r70T+FWYp9uI6mqDn618shiND3RmaYSrAll1UTlUA5UVWyYICmFdoq13QSZFVj2Puf3GtwSH
	saXn7pXuGB7CossmC6srDQUf1uw==
X-Received: by 2002:a17:907:7f27:b0:afa:1d2c:bbd1 with SMTP id a640c23a62f3a-b645f7eadc0mr615319566b.30.1760724779741;
        Fri, 17 Oct 2025 11:12:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5TruL0Ha9Hj+McDk/mWcPeNBPO8c+a/xnFbhmyZud9Ewv6SXVpLFpuXgMIbDppQPmJJ6Clg==
X-Received: by 2002:a17:907:7f27:b0:afa:1d2c:bbd1 with SMTP id a640c23a62f3a-b645f7eadc0mr615316066b.30.1760724779206;
        Fri, 17 Oct 2025 11:12:59 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb03649dsm44178466b.50.2025.10.17.11.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 11:12:58 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8699F2E9D5A; Fri, 17 Oct 2025 20:12:57 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, ilias.apalodimas@linaro.org, lorenzo@kernel.org,
 kuba@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com,
 andrii@kernel.org, stfomichev@gmail.com, aleksander.lobakin@intel.com
Subject: Re: [PATCH v2 bpf 2/2] veth: update mem type in xdp_buff
In-Reply-To: <87347hifgh.fsf@toke.dk>
References: <20251017143103.2620164-1-maciej.fijalkowski@intel.com>
 <20251017143103.2620164-3-maciej.fijalkowski@intel.com>
 <87a51pij2l.fsf@toke.dk> <aPJ0YqfH+pdSIbVS@boxer> <87347hifgh.fsf@toke.dk>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 17 Oct 2025 20:12:57 +0200
Message-ID: <87zf9pgzx2.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
>
>> On Fri, Oct 17, 2025 at 06:33:54PM +0200, Toke H=C3=B8iland-J=C3=B8rgens=
en wrote:
>>> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
>>>=20
>>> > Veth calls skb_pp_cow_data() which makes the underlying memory to
>>> > originate from system page_pool. For CONFIG_DEBUG_VM=3Dy and XDP prog=
ram
>>> > that uses bpf_xdp_adjust_tail(), following splat was observed:
>>> >
>>> > [   32.204881] BUG: Bad page state in process test_progs  pfn:11c98b
>>> > [   32.207167] page: refcount:0 mapcount:0 mapping:0000000000000000 i=
ndex:0x0 pfn:0x11c98b
>>> > [   32.210084] flags: 0x1fffe0000000000(node=3D0|zone=3D1|lastcpupid=
=3D0x7fff)
>>> > [   32.212493] raw: 01fffe0000000000 dead000000000040 ff11000123c9b00=
0 0000000000000000
>>> > [   32.218056] raw: 0000000000000000 0000000000000001 00000000fffffff=
f 0000000000000000
>>> > [   32.220900] page dumped because: page_pool leak
>>> > [   32.222636] Modules linked in: bpf_testmod(O) bpf_preload
>>> > [   32.224632] CPU: 6 UID: 0 PID: 3612 Comm: test_progs Tainted: G O =
       6.17.0-rc5-gfec474d29325 #6969 PREEMPT
>>> > [   32.224638] Tainted: [O]=3DOOT_MODULE
>>> > [   32.224639] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),=
 BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>>> > [   32.224641] Call Trace:
>>> > [   32.224644]  <IRQ>
>>> > [   32.224646]  dump_stack_lvl+0x4b/0x70
>>> > [   32.224653]  bad_page.cold+0xbd/0xe0
>>> > [   32.224657]  __free_frozen_pages+0x838/0x10b0
>>> > [   32.224660]  ? skb_pp_cow_data+0x782/0xc30
>>> > [   32.224665]  bpf_xdp_shrink_data+0x221/0x530
>>> > [   32.224668]  ? skb_pp_cow_data+0x6d1/0xc30
>>> > [   32.224671]  bpf_xdp_adjust_tail+0x598/0x810
>>> > [   32.224673]  ? xsk_destruct_skb+0x321/0x800
>>> > [   32.224678]  bpf_prog_004ac6bb21de57a7_xsk_xdp_adjust_tail+0x52/0x=
d6
>>> > [   32.224681]  veth_xdp_rcv_skb+0x45d/0x15a0
>>> > [   32.224684]  ? get_stack_info_noinstr+0x16/0xe0
>>> > [   32.224688]  ? veth_set_channels+0x920/0x920
>>> > [   32.224691]  ? get_stack_info+0x2f/0x80
>>> > [   32.224693]  ? unwind_next_frame+0x3af/0x1df0
>>> > [   32.224697]  veth_xdp_rcv.constprop.0+0x38a/0xbe0
>>> > [   32.224700]  ? common_startup_64+0x13e/0x148
>>> > [   32.224703]  ? veth_xdp_rcv_one+0xcd0/0xcd0
>>> > [   32.224706]  ? stack_trace_save+0x84/0xa0
>>> > [   32.224709]  ? stack_depot_save_flags+0x28/0x820
>>> > [   32.224713]  ? __resched_curr.constprop.0+0x332/0x3b0
>>> > [   32.224716]  ? timerqueue_add+0x217/0x320
>>> > [   32.224719]  veth_poll+0x115/0x5e0
>>> > [   32.224722]  ? veth_xdp_rcv.constprop.0+0xbe0/0xbe0
>>> > [   32.224726]  ? update_load_avg+0x1cb/0x12d0
>>> > [   32.224730]  ? update_cfs_group+0x121/0x2c0
>>> > [   32.224733]  __napi_poll+0xa0/0x420
>>> > [   32.224736]  net_rx_action+0x901/0xe90
>>> > [   32.224740]  ? run_backlog_napi+0x50/0x50
>>> > [   32.224743]  ? clockevents_program_event+0x1cc/0x280
>>> > [   32.224746]  ? hrtimer_interrupt+0x31e/0x7c0
>>> > [   32.224749]  handle_softirqs+0x151/0x430
>>> > [   32.224752]  do_softirq+0x3f/0x60
>>> > [   32.224755]  </IRQ>
>>> >
>>> > It's because xdp_rxq with mem model set to MEM_TYPE_PAGE_SHARED was u=
sed
>>> > when initializing xdp_buff.
>>> >
>>> > Fix this by using new helper xdp_convert_skb_to_buff() that, besides
>>> > init/prepare xdp_buff, will check if page used for linear part of
>>> > xdp_buff comes from page_pool. We assume that linear data and frags w=
ill
>>> > have same memory provider as currently XDP API does not provide us a =
way
>>> > to distinguish it (the mem model is registered for *whole* Rx queue a=
nd
>>> > here we speak about single buffer granularity).
>>> >
>>> > In order to meet expected skb layout by new helper, pull the mac head=
er
>>> > before conversion from skb to xdp_buff.
>>> >
>>> > However, that is not enough as before releasing xdp_buff out of veth =
via
>>> > XDP_{TX,REDIRECT}, mem type on xdp_rxq associated with xdp_buff is
>>> > restored to its original model. We need to respect previous setting at
>>> > least until buff is converted to frame, as frame carries the mem_type.
>>> > Add a page_pool variant of veth_xdp_get() so that we avoid refcount
>>> > underflow when draining page frag.
>>> >
>>> > Fixes: 0ebab78cbcbf ("net: veth: add page_pool for page recycling")
>>> > Reported-by: Alexei Starovoitov <ast@kernel.org>
>>> > Closes: https://lore.kernel.org/bpf/CAADnVQ+bBofJDfieyOYzSmSujSfJwDTQ=
hiz3aJw7hE+4E2_iPA@mail.gmail.com/
>>> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>>> > ---
>>> >  drivers/net/veth.c | 43 +++++++++++++++++++++++++++----------------
>>> >  1 file changed, 27 insertions(+), 16 deletions(-)
>>> >
>>> > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
>>> > index a3046142cb8e..eeeee7bba685 100644
>>> > --- a/drivers/net/veth.c
>>> > +++ b/drivers/net/veth.c
>>> > @@ -733,7 +733,7 @@ static void veth_xdp_rcv_bulk_skb(struct veth_rq =
*rq, void **frames,
>>> >  	}
>>> >  }
>>> >=20=20
>>> > -static void veth_xdp_get(struct xdp_buff *xdp)
>>> > +static void veth_xdp_get_shared(struct xdp_buff *xdp)
>>> >  {
>>> >  	struct skb_shared_info *sinfo =3D xdp_get_shared_info_from_buff(xdp=
);
>>> >  	int i;
>>> > @@ -746,12 +746,33 @@ static void veth_xdp_get(struct xdp_buff *xdp)
>>> >  		__skb_frag_ref(&sinfo->frags[i]);
>>> >  }
>>> >=20=20
>>> > +static void veth_xdp_get_pp(struct xdp_buff *xdp)
>>> > +{
>>> > +	struct skb_shared_info *sinfo =3D xdp_get_shared_info_from_buff(xdp=
);
>>> > +	int i;
>>> > +
>>> > +	page_pool_ref_page(virt_to_page(xdp->data));
>>> > +	if (likely(!xdp_buff_has_frags(xdp)))
>>> > +		return;
>>> > +
>>> > +	for (i =3D 0; i < sinfo->nr_frags; i++) {
>>> > +		skb_frag_t *frag =3D &sinfo->frags[i];
>>> > +
>>> > +		page_pool_ref_page(netmem_to_page(frag->netmem));
>>> > +	}
>>> > +}
>>> > +
>>> > +static void veth_xdp_get(struct xdp_buff *xdp)
>>> > +{
>>> > +	xdp->rxq->mem.type =3D=3D MEM_TYPE_PAGE_POOL ?
>>> > +		veth_xdp_get_pp(xdp) : veth_xdp_get_shared(xdp);
>>> > +}
>>> > +
>>> >  static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
>>> >  					struct xdp_buff *xdp,
>>> >  					struct sk_buff **pskb)
>>> >  {
>>> >  	struct sk_buff *skb =3D *pskb;
>>> > -	u32 frame_sz;
>>> >=20=20
>>> >  	if (skb_shared(skb) || skb_head_is_locked(skb) ||
>>> >  	    skb_shinfo(skb)->nr_frags ||
>>> > @@ -762,19 +783,9 @@ static int veth_convert_skb_to_xdp_buff(struct v=
eth_rq *rq,
>>> >  		skb =3D *pskb;
>>> >  	}
>>> >=20=20
>>> > -	/* SKB "head" area always have tailroom for skb_shared_info */
>>> > -	frame_sz =3D skb_end_pointer(skb) - skb->head;
>>> > -	frame_sz +=3D SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>>> > -	xdp_init_buff(xdp, frame_sz, &rq->xdp_rxq);
>>> > -	xdp_prepare_buff(xdp, skb->head, skb_headroom(skb),
>>> > -			 skb_headlen(skb), true);
>>> > +	__skb_pull(*pskb, skb->data - skb_mac_header(skb));
>>>=20
>>> veth_xdp_rcv_skb() does:
>>>=20
>>> 	__skb_push(skb, skb->data - skb_mac_header(skb));
>>> 	if (veth_convert_skb_to_xdp_buff(rq, xdp, &skb))
>>>=20
>>> so how about just getting rid of that push instead of doing the opposite
>>> pull straight after? :)
>>
>> Hi Toke,
>>
>> I believe this is done so we get a proper headroom representation which =
is
>> needed for XDP_PACKET_HEADROOM comparison. Maybe we could be smarter here
>> and for example subtract mac header length? However I wanted to preserve
>> old behavior.
>
> Yeah, basically what we want is to check if the mac_header offset is
> larger than the headroom. So the check could just be:
>
>     skb->mac_header < XDP_PACKET_HEADROOM
>
> however, it may be better to use the helper? Since that makes sure we
> keep hitting the DEBUG_NET_WARN_ON_ONCE inside the helper... So:
>
>     skb_mac_header(skb) - skb->head < XDP_PACKET_HEADROOM
>
> or, equivalently:
>
>     skb_headroom(skb) - skb_mac_offset(skb) < XDP_PACKET_HEADROOM
>
> I think the first one is probably more readable, since skb_mac_offset()
> is negative here, so the calculation looks off...

Wait, veth_xdp_rcv_skb() calls skb_reset_mac_header() further down, so
it expects skb->data to point to the mac header. So getting rid of the
__skb_push() is not a good idea; but neither is doing the __skb_pull() as
your patch does currently.

How about just making xdp_convert_skb_to_buff() agnostic to where
skb->data is?

	headroom =3D skb_mac_header(skb) - skb->head;
        data_len =3D skb->data + skb->len - skb_mac_header(skb);
	xdp_prepare_buff(xdp, skb->head, headroom, data_len, true);

should work in both cases, no?

-Toke


