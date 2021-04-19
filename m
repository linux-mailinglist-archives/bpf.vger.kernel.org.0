Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CDB364678
	for <lists+bpf@lfdr.de>; Mon, 19 Apr 2021 16:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbhDSOyx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Apr 2021 10:54:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50298 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239229AbhDSOxz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 19 Apr 2021 10:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618844005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pn3336x63l0LR8xuMuvbCKXge7xJwNvJuPpzzHWEsYA=;
        b=XknwQHmmH9EQ5guJg4g57nJ/30s44JA9MngX4RgX3qnSfLBJRIVHwbGfaGI0rck98o4ph5
        9c0y9n0oEd7S/l029REnctc/0GEh9yN100ec8m17Hup1mnXYIBkofKlM2ZAV21Q34FlXol
        YOEr2kcq9W7SYstWkyaR//vS3Yqu1U0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-tGiDcwe0PRu9QQpZFUg-eA-1; Mon, 19 Apr 2021 10:53:23 -0400
X-MC-Unique: tGiDcwe0PRu9QQpZFUg-eA-1
Received: by mail-ed1-f72.google.com with SMTP id n18-20020a0564020612b02903853320059eso2306534edv.0
        for <bpf@vger.kernel.org>; Mon, 19 Apr 2021 07:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Pn3336x63l0LR8xuMuvbCKXge7xJwNvJuPpzzHWEsYA=;
        b=YrESNxbB7LQFFyqwdCk1JVMbA9QbZxQ8zB/FOLYmCBO1E4OPceCjELRA8n0RoG7xWD
         O0R7ApiC6Z7rFiQbg8uL9NWSGENlLu6BKtHIe9ccopY6Ly8f8TFUuQAvtq+fJLYsFfA4
         SNH6VMTUzoX9uz2glwUO7TXFOJID3c6Rb2g0IBbbrNX7dXq007KweTVl0jzCSs2RkUKa
         GbP/IWAP8NXJyQm8/muRrriXpjcab30cSBuj3lFxN+eN7Op27F47H2aYzhidX49wmi9L
         W2xQpmR5UbDtY9JjGz4zQsbfW6pHOuNEMNE64zRcsHPzRNLQBx/k6M4Ox2S2XFMP/EzP
         al5A==
X-Gm-Message-State: AOAM531NOzUYtd0+uZLfnyx+XhEMBO1QmwNjimnW7y1ne6TcmOmEmIyg
        korAFWLdsMpJg3DRv/WtelSLSHOT/qUZHbPAhQyS41QcZFzqStwxRh+354jRaEaNW0Kdk745FMf
        m0I8CcHZDuuV6
X-Received: by 2002:a05:6402:3592:: with SMTP id y18mr25635921edc.360.1618844002129;
        Mon, 19 Apr 2021 07:53:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywpLk/0lBgi0qd0BQfZDWVWRLaHKwitjNdCJSwgxQ+G+VnXMmEmGrOLYhxAFFqbBSBfzE+ng==
X-Received: by 2002:a05:6402:3592:: with SMTP id y18mr25635884edc.360.1618844001691;
        Mon, 19 Apr 2021 07:53:21 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id k12sm12844689edo.50.2021.04.19.07.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 07:53:21 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 881CC180002; Mon, 19 Apr 2021 16:53:20 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Martin Willi <martin@strongswan.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next] net: xdp: Update pkt_type if generic XDP
 changes unicast MAC
In-Reply-To: <20210419141559.8611-1-martin@strongswan.org>
References: <20210419141559.8611-1-martin@strongswan.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 19 Apr 2021 16:53:20 +0200
Message-ID: <87tuo2gwbj.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin Willi <martin@strongswan.org> writes:

> If a generic XDP program changes the destination MAC address from/to
> multicast/broadcast, the skb->pkt_type is updated to properly handle
> the packet when passed up the stack. When changing the MAC from/to
> the NICs MAC, PACKET_HOST/OTHERHOST is not updated, though, making
> the behavior different from that of native XDP.
>
> Remember the PACKET_HOST/OTHERHOST state before calling the program
> in generic XDP, and update pkt_type accordingly if the destination
> MAC address has changed. As eth_type_trans() assumes a default
> pkt_type of PACKET_HOST, restore that before calling it.
>
> The use case for this is when a XDP program wants to push received
> packets up the stack by rewriting the MAC to the NICs MAC, for
> example by cluster nodes sharing MAC addresses.
>
> Fixes: 297249569932 ("net: fix generic XDP to handle if eth header was mangled")
> Signed-off-by: Martin Willi <martin@strongswan.org>
> ---
>  net/core/dev.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index d9bf63dbe4fd..eed028aec6a4 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4723,10 +4723,10 @@ static u32 netif_receive_generic_xdp(struct sk_buff *skb,
>  	void *orig_data, *orig_data_end, *hard_start;
>  	struct netdev_rx_queue *rxqueue;
>  	u32 metalen, act = XDP_DROP;
> +	bool orig_bcast, orig_host;
>  	u32 mac_len, frame_sz;
>  	__be16 orig_eth_type;
>  	struct ethhdr *eth;
> -	bool orig_bcast;
>  	int off;
>  
>  	/* Reinjected packets coming from act_mirred or similar should
> @@ -4773,6 +4773,7 @@ static u32 netif_receive_generic_xdp(struct sk_buff *skb,
>  	orig_data_end = xdp->data_end;
>  	orig_data = xdp->data;
>  	eth = (struct ethhdr *)xdp->data;
> +	orig_host = ether_addr_equal_64bits(eth->h_dest, skb->dev->dev_addr);

ether_addr_equal_64bits() seems to assume that the addresses passed to
it are padded to be 8 bytes long, which is not the case for eth->h_dest.
AFAICT the only reason the _64bits variant works for multicast is that
it happens to be only checking the top-most bit, but unless I'm missing
something you'll have to use the boring old ether_addr_equal() here, no?

>  	orig_bcast = is_multicast_ether_addr_64bits(eth->h_dest);
>  	orig_eth_type = eth->h_proto;
>  
> @@ -4800,8 +4801,11 @@ static u32 netif_receive_generic_xdp(struct sk_buff *skb,
>  	/* check if XDP changed eth hdr such SKB needs update */
>  	eth = (struct ethhdr *)xdp->data;
>  	if ((orig_eth_type != eth->h_proto) ||
> +	    (orig_host != ether_addr_equal_64bits(eth->h_dest,
> +						  skb->dev->dev_addr)) ||
>  	    (orig_bcast != is_multicast_ether_addr_64bits(eth->h_dest))) {
>  		__skb_push(skb, ETH_HLEN);
> +		skb->pkt_type = PACKET_HOST;
>  		skb->protocol = eth_type_trans(skb, skb->dev);
>  	}

Okay, so this was a bit confusing to me at fist glance: eth_type_trans()
will reset the type, but not back to PACKET_HOST. So this works, just a
bit confusing :)

-Toke

