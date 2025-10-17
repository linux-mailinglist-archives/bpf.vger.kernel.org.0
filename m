Return-Path: <bpf+bounces-71226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDE1BEAD7F
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 18:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7922587223
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 16:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356A929D26C;
	Fri, 17 Oct 2025 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gw/FkZO6"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE40330B1C
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718842; cv=none; b=m8cjnMG1f4W/Lh0UNCgajYAXUnEm0sop+6uWYez6WofBEDhqajRRVvut0Bx6pive7M5p+OVwy3WC40+LDWQcdCWdBQE/zzSXClLZWFMs6+E8rCUYtuuhCUOp3ol+ZzUNKUIJ4fRJbAziuZqhKnEdkDMlilDkxdQhjTmFDEEu1aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718842; c=relaxed/simple;
	bh=8OCmvtNkd7Eow8L2/KW/Fg31hKh2w7x/BItWTOBoXLo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FmQj1h2A2KMCXJUn9lqLrYS2j/a6UVZxJFkID5quNYjygVZPL25MVjv+SOvNU4QjOXDvswpr6q7DX/KiOHdQ/PqutTMKaKKIxKVvDf1LPCsCRydGaNSVj0e0rS/LsJlbD904kKKcTiwJ+/HBenHugpjoSLTLblIxM+i4efgM3S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gw/FkZO6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760718839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+YDWYvS8eBPU3JM3GQnucQBR2NLzws8qvq5TorPP6xY=;
	b=gw/FkZO68PI+nRhmF6Y/eXIJvj3UHCbUX1GwiUMYOMWOXsyz0c460M+0DOatM3g+fTsAt0
	7w+NwyZ3T+VmAnm8EG1ESFrTO8F9sms79VhX2klWh3xe1FCmdslSSrO5HLTdnvLWxbScul
	ynhQH7GlDkATqjF8EvaDLDmASvF24yc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-30QxS3l2NCmPlW52QRSdog-1; Fri, 17 Oct 2025 12:33:58 -0400
X-MC-Unique: 30QxS3l2NCmPlW52QRSdog-1
X-Mimecast-MFC-AGG-ID: 30QxS3l2NCmPlW52QRSdog_1760718837
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6349af0e766so3363661a12.3
        for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 09:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760718837; x=1761323637;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+YDWYvS8eBPU3JM3GQnucQBR2NLzws8qvq5TorPP6xY=;
        b=Eg52ts3A8OUwbOhnHUf2dQqfpjBILSAUyq07EmBEjsTNjk4mNDNEXwUGZ2E/L/rRkg
         MLgrinQeSmt7d6rg+rvWFdAEplabAAG/9kpZQ6W3HGanYAFhk2IKpaiEj6Yw0cWNCTyC
         1NAOeftK1zRvVlM4jUwBgOCdxNj+A0M49Vhz+3Iq0C50jjpMfYYvUHpyuJWBhso9tbKa
         kjR3mhkCSzXVt5V6OYjf2RWjChdBmLKml0IkaW3RT66ukgvmW4ltHq2xZq/ljX1AvIBp
         b1EIYEBn4ymKAh2QvyaPpzR+P3qxJD7V4jyFdZZU7R0crpKm+f81K9DvnNSw8wNalqOR
         LQHA==
X-Forwarded-Encrypted: i=1; AJvYcCUYNiZpSF4qTECKvdvPT8CKeUBCOewN2s1DLbk7Np5sr/4KZJbRLQsOYxd+kHa+ajfKI/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf9xvFMLpuSIeSs/2oYE4r0/uKsPwkFayUdMq37ebdggK8tfSn
	tgeL5HuPjr+1WBynt1j25XZVpkyJgubNv5rbXAxBTJSWk448SlXh8BwydzHaGe0s3xp5MsJA3P4
	8lRtBGaWIjuNHjwmx2iJrzuSGVZ+neVDixGAo1+ZiAH9ARWsjT6TkPw==
X-Gm-Gg: ASbGncu+hOYDORpCo284rzcpAd2fHwnoZE0m7KCKXt/dOncmGxqDsMBSw2ZOLQQk8C9
	9aG+7VZDAOGNm5TTYWlDOuYyD6Q41dd6RWZOY9lpAjpyjVVmmKs4AyqyQP+W9HFvSVvaAyh/ZYq
	8HPD2BdAnJyG9EjlXVNSmWesWH9Umxe0h3b8sVFAC7KZ4SgOzbx6VWmmxAwkc08tTzRBrlfr9E0
	V5mbxN1VNwsqAglzupbUu6YnyxUvjP7+lUvXD86Y+aGLyqxDMWeWZvPVpvdM+0uOzv5rozVqrQQ
	34c9PMY/adRZ1aspqI354sPNNLxfyJiAF6ZjEzgLJFWBv8huzVFKAMhFylmzY/E3WdsWrcP0GCt
	UdmSBE9LeJMZMvZ5C+3xEeHeaoA==
X-Received: by 2002:a05:6402:34c5:b0:63c:1e15:b9fb with SMTP id 4fb4d7f45d1cf-63c1f6b4d28mr4374155a12.22.1760718837166;
        Fri, 17 Oct 2025 09:33:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNpLqb8nw2QG39h9VMR7dwTaI3xyg+sVDICol+as0GRxDqwZKl5FzHWzdkyc9bYkzcltZa2Q==
X-Received: by 2002:a05:6402:34c5:b0:63c:1e15:b9fb with SMTP id 4fb4d7f45d1cf-63c1f6b4d28mr4374124a12.22.1760718836587;
        Fri, 17 Oct 2025 09:33:56 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4945efebsm94791a12.32.2025.10.17.09.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:33:55 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0DD802E9D1A; Fri, 17 Oct 2025 18:33:54 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 ilias.apalodimas@linaro.org, lorenzo@kernel.org, kuba@kernel.org
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, andrii@kernel.org,
 stfomichev@gmail.com, aleksander.lobakin@intel.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v2 bpf 2/2] veth: update mem type in xdp_buff
In-Reply-To: <20251017143103.2620164-3-maciej.fijalkowski@intel.com>
References: <20251017143103.2620164-1-maciej.fijalkowski@intel.com>
 <20251017143103.2620164-3-maciej.fijalkowski@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 17 Oct 2025 18:33:54 +0200
Message-ID: <87a51pij2l.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> Veth calls skb_pp_cow_data() which makes the underlying memory to
> originate from system page_pool. For CONFIG_DEBUG_VM=y and XDP program
> that uses bpf_xdp_adjust_tail(), following splat was observed:
>
> [   32.204881] BUG: Bad page state in process test_progs  pfn:11c98b
> [   32.207167] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11c98b
> [   32.210084] flags: 0x1fffe0000000000(node=0|zone=1|lastcpupid=0x7fff)
> [   32.212493] raw: 01fffe0000000000 dead000000000040 ff11000123c9b000 0000000000000000
> [   32.218056] raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
> [   32.220900] page dumped because: page_pool leak
> [   32.222636] Modules linked in: bpf_testmod(O) bpf_preload
> [   32.224632] CPU: 6 UID: 0 PID: 3612 Comm: test_progs Tainted: G O        6.17.0-rc5-gfec474d29325 #6969 PREEMPT
> [   32.224638] Tainted: [O]=OOT_MODULE
> [   32.224639] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [   32.224641] Call Trace:
> [   32.224644]  <IRQ>
> [   32.224646]  dump_stack_lvl+0x4b/0x70
> [   32.224653]  bad_page.cold+0xbd/0xe0
> [   32.224657]  __free_frozen_pages+0x838/0x10b0
> [   32.224660]  ? skb_pp_cow_data+0x782/0xc30
> [   32.224665]  bpf_xdp_shrink_data+0x221/0x530
> [   32.224668]  ? skb_pp_cow_data+0x6d1/0xc30
> [   32.224671]  bpf_xdp_adjust_tail+0x598/0x810
> [   32.224673]  ? xsk_destruct_skb+0x321/0x800
> [   32.224678]  bpf_prog_004ac6bb21de57a7_xsk_xdp_adjust_tail+0x52/0xd6
> [   32.224681]  veth_xdp_rcv_skb+0x45d/0x15a0
> [   32.224684]  ? get_stack_info_noinstr+0x16/0xe0
> [   32.224688]  ? veth_set_channels+0x920/0x920
> [   32.224691]  ? get_stack_info+0x2f/0x80
> [   32.224693]  ? unwind_next_frame+0x3af/0x1df0
> [   32.224697]  veth_xdp_rcv.constprop.0+0x38a/0xbe0
> [   32.224700]  ? common_startup_64+0x13e/0x148
> [   32.224703]  ? veth_xdp_rcv_one+0xcd0/0xcd0
> [   32.224706]  ? stack_trace_save+0x84/0xa0
> [   32.224709]  ? stack_depot_save_flags+0x28/0x820
> [   32.224713]  ? __resched_curr.constprop.0+0x332/0x3b0
> [   32.224716]  ? timerqueue_add+0x217/0x320
> [   32.224719]  veth_poll+0x115/0x5e0
> [   32.224722]  ? veth_xdp_rcv.constprop.0+0xbe0/0xbe0
> [   32.224726]  ? update_load_avg+0x1cb/0x12d0
> [   32.224730]  ? update_cfs_group+0x121/0x2c0
> [   32.224733]  __napi_poll+0xa0/0x420
> [   32.224736]  net_rx_action+0x901/0xe90
> [   32.224740]  ? run_backlog_napi+0x50/0x50
> [   32.224743]  ? clockevents_program_event+0x1cc/0x280
> [   32.224746]  ? hrtimer_interrupt+0x31e/0x7c0
> [   32.224749]  handle_softirqs+0x151/0x430
> [   32.224752]  do_softirq+0x3f/0x60
> [   32.224755]  </IRQ>
>
> It's because xdp_rxq with mem model set to MEM_TYPE_PAGE_SHARED was used
> when initializing xdp_buff.
>
> Fix this by using new helper xdp_convert_skb_to_buff() that, besides
> init/prepare xdp_buff, will check if page used for linear part of
> xdp_buff comes from page_pool. We assume that linear data and frags will
> have same memory provider as currently XDP API does not provide us a way
> to distinguish it (the mem model is registered for *whole* Rx queue and
> here we speak about single buffer granularity).
>
> In order to meet expected skb layout by new helper, pull the mac header
> before conversion from skb to xdp_buff.
>
> However, that is not enough as before releasing xdp_buff out of veth via
> XDP_{TX,REDIRECT}, mem type on xdp_rxq associated with xdp_buff is
> restored to its original model. We need to respect previous setting at
> least until buff is converted to frame, as frame carries the mem_type.
> Add a page_pool variant of veth_xdp_get() so that we avoid refcount
> underflow when draining page frag.
>
> Fixes: 0ebab78cbcbf ("net: veth: add page_pool for page recycling")
> Reported-by: Alexei Starovoitov <ast@kernel.org>
> Closes: https://lore.kernel.org/bpf/CAADnVQ+bBofJDfieyOYzSmSujSfJwDTQhiz3aJw7hE+4E2_iPA@mail.gmail.com/
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/veth.c | 43 +++++++++++++++++++++++++++----------------
>  1 file changed, 27 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index a3046142cb8e..eeeee7bba685 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -733,7 +733,7 @@ static void veth_xdp_rcv_bulk_skb(struct veth_rq *rq, void **frames,
>  	}
>  }
>  
> -static void veth_xdp_get(struct xdp_buff *xdp)
> +static void veth_xdp_get_shared(struct xdp_buff *xdp)
>  {
>  	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
>  	int i;
> @@ -746,12 +746,33 @@ static void veth_xdp_get(struct xdp_buff *xdp)
>  		__skb_frag_ref(&sinfo->frags[i]);
>  }
>  
> +static void veth_xdp_get_pp(struct xdp_buff *xdp)
> +{
> +	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> +	int i;
> +
> +	page_pool_ref_page(virt_to_page(xdp->data));
> +	if (likely(!xdp_buff_has_frags(xdp)))
> +		return;
> +
> +	for (i = 0; i < sinfo->nr_frags; i++) {
> +		skb_frag_t *frag = &sinfo->frags[i];
> +
> +		page_pool_ref_page(netmem_to_page(frag->netmem));
> +	}
> +}
> +
> +static void veth_xdp_get(struct xdp_buff *xdp)
> +{
> +	xdp->rxq->mem.type == MEM_TYPE_PAGE_POOL ?
> +		veth_xdp_get_pp(xdp) : veth_xdp_get_shared(xdp);
> +}
> +
>  static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
>  					struct xdp_buff *xdp,
>  					struct sk_buff **pskb)
>  {
>  	struct sk_buff *skb = *pskb;
> -	u32 frame_sz;
>  
>  	if (skb_shared(skb) || skb_head_is_locked(skb) ||
>  	    skb_shinfo(skb)->nr_frags ||
> @@ -762,19 +783,9 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
>  		skb = *pskb;
>  	}
>  
> -	/* SKB "head" area always have tailroom for skb_shared_info */
> -	frame_sz = skb_end_pointer(skb) - skb->head;
> -	frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> -	xdp_init_buff(xdp, frame_sz, &rq->xdp_rxq);
> -	xdp_prepare_buff(xdp, skb->head, skb_headroom(skb),
> -			 skb_headlen(skb), true);
> +	__skb_pull(*pskb, skb->data - skb_mac_header(skb));

veth_xdp_rcv_skb() does:

	__skb_push(skb, skb->data - skb_mac_header(skb));
	if (veth_convert_skb_to_xdp_buff(rq, xdp, &skb))

so how about just getting rid of that push instead of doing the opposite
pull straight after? :)

-Toke


