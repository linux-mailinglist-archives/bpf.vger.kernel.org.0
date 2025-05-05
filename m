Return-Path: <bpf+bounces-57369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67599AA9CF2
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 22:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC7F1A80489
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 20:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F1C1C84BB;
	Mon,  5 May 2025 20:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5G7d19k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C1B19C546
	for <bpf@vger.kernel.org>; Mon,  5 May 2025 20:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746475305; cv=none; b=MYTKbkFLxF9qgts5nbu7BXT0HrGK47clFBlr9nw29CHBRdSGZUneTUMtLN5q1jJEU54HctNuBdVkotXhZTqA684MikX0YISQHeuMUhnk/HHicstPYeQNrp2i5ky5fjRY0RPXJbXFA4qeSysuFo7Miowcf4nGqQMjfOV6BEc/SLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746475305; c=relaxed/simple;
	bh=8QI/3dgz8DIggakHprhW9h/+ykI44G36bJy/DUHtUIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9jUjiImIIVtwwqvUySaiB6vreH8vlb95WBr85KZvkHD8rQep8a2E96woZa9fl8JweiQg0NIqUtQr+6xCilhislqhr4OPTXPzG3AEyFc0TzMiSrEXe8MK3qwvBBfxKxz56g/HY7AYHpyUnf1zutQKcaishASRGjYjuXb5gPMi3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5G7d19k; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-441ab63a415so48285395e9.3
        for <bpf@vger.kernel.org>; Mon, 05 May 2025 13:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746475301; x=1747080101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x4aezVgabNl59hwj6ORvsnrBWCYGW2e7Q84gLAXYLac=;
        b=m5G7d19kxX54Np2pL0QmBcl3/4wA0wcT+fCHM3jhOXwKGaRvLB2K2QIJGzrtxcm6tP
         aCye25wq069d/RfSanq/DkptvEHRQ0406mgnBobnmg08f6Ab3eAkZqoq+mTXYDBXo61b
         M+s4NQQHaK0dDeikYt1H2HiSVdegAKXH95uVZNrG9V3nRQagakuQaSQyL+WC/zlM8d1/
         M5x2fA2pRi+fUYPW5/RgVzJJDElJvkKbMFh0x3xCXCvR3PlK2R+1EvaN48ZqDVFYWPlq
         aRCZzcY6CrVOLuaMg2XlgZn+PH2DklkfI5GGtd4utup4Kihiczky/w5h0nxctDf9o4fA
         S2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746475301; x=1747080101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4aezVgabNl59hwj6ORvsnrBWCYGW2e7Q84gLAXYLac=;
        b=dyZH/CdKgg5w5YWNfLeFmSzseQDXqW1Z/TlTnKxYDINIagQb2mpbZFVct2D7M7ETfk
         gp8NWSv/j+ff91viBLhE2btcDkz1V8J84EXnl1p9pql3Td6dKRALHZw2d8pnvLdlqj0d
         kSaTUBFAusFXPH5Wh3m3kttKucyuZnbFN6wNPxDkA5RetL7xuIc6BiFcnX4mhcQfIfPV
         OFjhkPRhNrOb8W0fU2xYOy5FV28WtH2RrhENsBg1i1VdbA94FBGlw5SSaXRRxKq1mD9z
         dKQJcHcMLdmLmYthFsTbdKU4F0c0T5ZNwIoqTnv59XUDi0Q1hOuINOAkk8Yn2huRtZgI
         ejCQ==
X-Gm-Message-State: AOJu0YwRF5koFCX/GJ6S/vjTvtdMKTijSLudBPhycgOxM1+9KnWXLx9l
	7VSnG5poXZmM0b04ycCFzuikE/OLX0OLXvD/F5gDGkKe5XfFq6ul
X-Gm-Gg: ASbGncsPj7Fzjr91+X5bcdTZNZ5QyONPqfTLHWg9NS7HVVIuQK1rkRlOfQl1WpUXW0J
	Yi5LXtP+DHcgZSovyEiZpVdF7adZFFmGuQrC5+3yt4KAlLeKz8Z4SEfzpQuC+N61anib7ADqOJa
	DJwg7XPSerAkNDzP0QPj4rgrP8LEOHs5K1Q6Kfj8gipwjNMH6M8lIvZtccj/1seKi3QzXDW2Vvp
	HX951bk/V2QUG1prUVjhUisn+UEDKKUg5JqTjasFy3BGdjeoJAEyjVHXhIhmIASD1kgRpCfXgyU
	0G8nf9FfiJwaAZ23fzEog1hla6E8o6Z1jaM71E91xOnGoltHzcfUwh3fDjwh0SuZcidIY0cLhqH
	Q6mDB4XfXjN28D2DoTnUiqN3aHBC0Dtm94CeLUw==
X-Google-Smtp-Source: AGHT+IGYQX3b1rxCvkiuRTb3FIA3LYlLBUGPXML2aR+lZJP9/vABJ5PL7BSB2uxDT+EbMvDEnz4NfA==
X-Received: by 2002:a05:600c:5007:b0:43d:40b0:5b with SMTP id 5b1f17b1804b1-441d100a8a1mr942015e9.25.1746475301136;
        Mon, 05 May 2025 13:01:41 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0001c990b81d371cc8.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:1c9:90b8:1d37:1cc8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b8a286b9sm142851595e9.28.2025.05.05.13.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 13:01:40 -0700 (PDT)
Date: Mon, 5 May 2025 22:01:38 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf] bpf: Scrub packet on bpf_redirect_peer
Message-ID: <aBkZIoqBaClS71tn@mail.gmail.com>
References: <aBiJdTDs_YP0AYVb@mail.gmail.com>
 <11ea4e28-4653-4061-9226-fbee3d5b9f32@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11ea4e28-4653-4061-9226-fbee3d5b9f32@iogearbox.net>

On Mon, May 05, 2025 at 12:01:30PM +0200, Daniel Borkmann wrote:
> On 5/5/25 11:48 AM, Paul Chaignon wrote:
> > When bpf_redirect_peer is used to redirect packets to a device in
> > another network namespace, the skb isn't scrubbed. That can lead skb
> > information from one namespace to be "misused" in another namespace.
> > 
> > As one example, this is causing Cilium to drop traffic when using
> > bpf_redirect_peer to redirect packets that just went through IPsec
> > decryption to a container namespace. The following pwru trace shows (1)
> > the packet path from the host's XFRM layer to the container's XFRM
> > layer where it's dropped and (2) the number of active skb extensions at
> > each function.
> > 
> >      NETNS       MARK  IFACE  TUPLE                                FUNC
> >      4026533547  d00   eth0   10.244.3.124:35473->10.244.2.158:53  xfrm_rcv_cb
> >                               .active_extensions = (__u8)2,
> >      4026533547  d00   eth0   10.244.3.124:35473->10.244.2.158:53  xfrm4_rcv_cb
> >                               .active_extensions = (__u8)2,
> >      4026533547  d00   eth0   10.244.3.124:35473->10.244.2.158:53  gro_cells_receive
> >                               .active_extensions = (__u8)2,
> >      [...]
> >      4026533547  0     eth0   10.244.3.124:35473->10.244.2.158:53  skb_do_redirect
> >                               .active_extensions = (__u8)2,
> >      4026534999  0     eth0   10.244.3.124:35473->10.244.2.158:53  ip_rcv
> >                               .active_extensions = (__u8)2,
> >      4026534999  0     eth0   10.244.3.124:35473->10.244.2.158:53  ip_rcv_core
> >                               .active_extensions = (__u8)2,
> >      [...]
> >      4026534999  0     eth0   10.244.3.124:35473->10.244.2.158:53  udp_queue_rcv_one_skb
> >                               .active_extensions = (__u8)2,
> >      4026534999  0     eth0   10.244.3.124:35473->10.244.2.158:53  __xfrm_policy_check
> >                               .active_extensions = (__u8)2,
> >      4026534999  0     eth0   10.244.3.124:35473->10.244.2.158:53  __xfrm_decode_session
> >                               .active_extensions = (__u8)2,
> >      4026534999  0     eth0   10.244.3.124:35473->10.244.2.158:53  security_xfrm_decode_session
> >                               .active_extensions = (__u8)2,
> >      4026534999  0     eth0   10.244.3.124:35473->10.244.2.158:53  kfree_skb_reason(SKB_DROP_REASON_XFRM_POLICY)
> >                               .active_extensions = (__u8)2,
> > 
> > In this case, there are no XFRM policies in the container's network
> > namespace so the drop is unexpected. When we decrypt the IPsec packet,
> > the XFRM state used for decryption is set in the skb extensions. This
> > information is preserved across the netns switch. When we reach the
> > XFRM policy check in the container's netns, __xfrm_policy_check drops
> > the packet with LINUX_MIB_XFRMINNOPOLS because a (container-side) XFRM
> > policy can't be found that matches the (host-side) XFRM state used for
> > decryption.
> > 
> > This patch fixes this by scrubbing the packet when using
> > bpf_redirect_peer, as is done on typical netns switches via veth
> > devices.
> > 
> > Fixes: 9aa1206e8f482 ("bpf: Add redirect_peer helper")
> > Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> > ---
> >   net/core/filter.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 79cab4d78dc3..12b6b8dbeb51 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -2509,6 +2509,7 @@ int skb_do_redirect(struct sk_buff *skb)
> >   			goto out_drop;
> >   		skb->dev = dev;
> >   		dev_sw_netstats_rx_add(dev, skb->len);
> > +		skb_scrub_packet(skb, true);
> 
> This should be set to false, and defer the clearing of mark/tstamp
> iff needed to the BPF program in the host given this has been out
> for quite some time to avoid breakage if someone actively has been
> using BPF like that to transfer this information to apps in the
> target namespace.

Thanks for the review! I've sent a v2 with the suggested change and
added a commit to explain in the helper description that those two
fields are not cleared.

> 
> >   		return -EAGAIN;
> >   	}
> >   	return flags & BPF_F_NEIGH ?
> 

