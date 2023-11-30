Return-Path: <bpf+bounces-16299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 751D37FF9FA
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 19:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B8C1C21157
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 18:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9B854FAA;
	Thu, 30 Nov 2023 18:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SQShjCmk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3B510D1
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 10:49:14 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2859447a409so1671261a91.2
        for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 10:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701370154; x=1701974954; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XJL3/xZlETlaSZxAbteHfIDjLP0TbdjMEyzT5VAw/Aw=;
        b=SQShjCmkpS3myXcupF1sSNyN4lVv7f8sQbr4z47TNjayUfDnD6UAEU2jFxrQGvf/Zp
         7r1c89jOvf+1Dws2ZI87DOvgNVaIeVcnOn0jvbIpM9GlOZX3DTV6jsgHOgGBM8flnqy5
         wgd6Pin9H+Zzv4Kpw/IltQ3I7n4IY44IkGeGbCZCYwRzZLlDY9UiuJ/HRx8e7phyk8cV
         xcgs9UQaxts6DdFF9aBxfgTgCXS2ImFD/pRnm2EsGhyUHtBD7t2fdDAprhulEvfnyHHr
         sFOuHDEaZ6Ku6g0agsGQeC6v8zwoajfA3e1ltnZb5DKLJ3Fj0+Xfy63tcm1hNykNfyCM
         xs0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701370154; x=1701974954;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJL3/xZlETlaSZxAbteHfIDjLP0TbdjMEyzT5VAw/Aw=;
        b=TTowVVKYcxajiDtM0Me1ScTBZTEY8rnw99CFI64xpTUrC3bpHu8uHYC4odwdNXqMmB
         WyR8747BFxYduYIz6tkybdTuRxWBDJUvFzO6kQnk7FM46ggR2/sQO7qXCyNuWRjC4Y56
         iWXzCrbbGW7oS0uCjBJfbWis20H+smdrYzRTtDTc0ugLdBTNzooxxwMy+1Hax0+Alp4y
         4oVz/jn+LjiBU7C3ZIsHTlZdhXWFrDpg7vCuDR0QmUEdh67WBXtC8NHyzvztbGhbOroX
         sg50hUobNEYCgtsql8mshoDmGNcbdH7+Ox/0ibK2cacfROZ782bT8gMuiFlECKL8c5V+
         /D8w==
X-Gm-Message-State: AOJu0Yy7+ZDOCVzmUC8fEV39qKGEInj8wVxxpADdRO6kMTFs9UR4Dv1m
	JZsPvJwYMmIIfEwh+eAEl+ViYQw=
X-Google-Smtp-Source: AGHT+IGyDyxAMwcoJS6sciBw/5vkzmmMOCxH2ARe2G7kvbgl3cR0YNiiHR7qICXmLsKg3A/6Wj9bU1U=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:e011:b0:286:5274:8cab with SMTP id
 u17-20020a17090ae01100b0028652748cabmr78809pjy.1.1701370154197; Thu, 30 Nov
 2023 10:49:14 -0800 (PST)
Date: Thu, 30 Nov 2023 10:49:12 -0800
In-Reply-To: <ZWhpGWDP6mrM-Y35@lore-desk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1701334869.git.lorenzo@kernel.org> <ce8cc5ce6e25d5e455704aa42fbf633be206ce85.1701334869.git.lorenzo@kernel.org>
 <f41935a3-790b-4d23-870c-a37b757aea99@kernel.org> <ZWhpGWDP6mrM-Y35@lore-desk>
Message-ID: <ZWjZKPYCglmjFJUH@google.com>
Subject: Re: [PATCH v2 net-next 2/2] xdp: add multi-buff support for xdp
 running in generic mode
From: Stanislav Fomichev <sdf@google.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	lorenzo.bianconi@redhat.com, bpf@vger.kernel.org, toke@redhat.com, 
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com, 
	kernel-team <kernel-team@cloudflare.com>, Yan Zhai <yan@cloudflare.com>
Content-Type: text/plain; charset="utf-8"

On 11/30, Lorenzo Bianconi wrote:
> > 
> > 
> > On 11/30/23 10:11, Lorenzo Bianconi wrote:
> > > Similar to native xdp, do not always linearize the skb in
> > > netif_receive_generic_xdp routine but create a non-linear xdp_buff to be
> > > processed by the eBPF program. This allow to add  multi-buffer support
> > > for xdp running in generic mode.
> > > 
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >   net/core/dev.c | 144 ++++++++++++++++++++++++++++++++++++++++---------
> > >   1 file changed, 119 insertions(+), 25 deletions(-)
> > > 
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index 4df68d7f04a2..0d08e755bb7f 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -4853,6 +4853,12 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
> > >   	xdp_init_buff(xdp, frame_sz, &rxqueue->xdp_rxq);
> > >   	xdp_prepare_buff(xdp, hard_start, skb_headroom(skb) - mac_len,
> > >   			 skb_headlen(skb) + mac_len, true);
> > > +	if (skb_is_nonlinear(skb)) {
> > > +		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
> > > +		xdp_buff_set_frags_flag(xdp);
> > > +	} else {
> > > +		xdp_buff_clear_frags_flag(xdp);
> > > +	}
> > >   	orig_data_end = xdp->data_end;
> > >   	orig_data = xdp->data;
> > > @@ -4882,6 +4888,14 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
> > >   		skb->len += off; /* positive on grow, negative on shrink */
> > >   	}
> > > +	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
> > > +	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
> > > +	 */
> > > +	if (xdp_buff_has_frags(xdp))
> > > +		skb->data_len = skb_shinfo(skb)->xdp_frags_size;
> > > +	else
> > > +		skb->data_len = 0;
> > > +
> > >   	/* check if XDP changed eth hdr such SKB needs update */
> > >   	eth = (struct ethhdr *)xdp->data;
> > >   	if ((orig_eth_type != eth->h_proto) ||
> > > @@ -4915,54 +4929,134 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
> > >   	return act;
> > >   }
> > > -static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
> > > -				     struct xdp_buff *xdp,
> > > -				     struct bpf_prog *xdp_prog)
> > > +static int netif_skb_check_for_generic_xdp(struct sk_buff **pskb,
> > > +					   struct bpf_prog *prog)
> > 
> > I like this is split out into a check function.
> > 
> > >   {
> > >   	struct sk_buff *skb = *pskb;
> > > -	u32 act = XDP_DROP;
> > > -
> > > -	/* Reinjected packets coming from act_mirred or similar should
> > > -	 * not get XDP generic processing.
> > > -	 */
> > > -	if (skb_is_redirected(skb))
> > > -		return XDP_PASS;
> > 
> > (For other reviewers)
> > This reinjected check is moved further down.
> > 
> > > +	int err;
> > > -	/* XDP packets must be linear and must have sufficient headroom
> > > -	 * of XDP_PACKET_HEADROOM bytes. This is the guarantee that also
> > > -	 * native XDP provides, thus we need to do it here as well.
> > > +	/* XDP does not support fraglist so we need to linearize
> > > +	 * the skb.
> > >   	 */
> > > -	if (skb_cloned(skb) || skb_is_nonlinear(skb) ||
> > > -	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
> > > +	if (skb_has_frag_list(skb) || !prog->aux->xdp_has_frags) {
> > >   		int hroom = XDP_PACKET_HEADROOM - skb_headroom(skb);
> > >   		int troom = skb->tail + skb->data_len - skb->end;
> > >   		/* In case we have to go down the path and also linearize,
> > >   		 * then lets do the pskb_expand_head() work just once here.
> > >   		 */
> > > -		if (pskb_expand_head(skb,
> > > -				     hroom > 0 ? ALIGN(hroom, NET_SKB_PAD) : 0,
> > > -				     troom > 0 ? troom + 128 : 0, GFP_ATOMIC))
> > > -			goto do_drop;
> > > -		if (skb_linearize(skb))
> > > -			goto do_drop;
> > > +		err = pskb_expand_head(skb,
> > > +				       hroom > 0 ? ALIGN(hroom, NET_SKB_PAD) : 0,
> > > +				       troom > 0 ? troom + 128 : 0, GFP_ATOMIC);
> > > +		if (err)
> > > +			return err;
> > > +
> > > +		err = skb_linearize(skb);
> > > +		if (err)
> > > +			return err;
> > > +
> > > +		return 0;
> > > +	}
> > > +
> > > +	/* XDP packets must have sufficient headroom of XDP_PACKET_HEADROOM
> > > +	 * bytes. This is the guarantee that also native XDP provides,
> > > +	 * thus we need to do it here as well.
> > > +	 */
> > > +	if (skb_cloned(skb) || skb_shinfo(skb)->nr_frags ||
> > 
> > I though we could allow a SKB with skb_shinfo(skb)->nr_frags (that isn't
> > cloned or shared) to be processed by generic XDP without any reallocation?
> 
> I do not think so, we discussed about it with Jakub here [0]
> 
> [0] https://lore.kernel.org/netdev/20231128105145.7b39db7d@kernel.org/

Can this be done as an optimization later on? If, from the bpf side,
the verifier can attest that the program is not calling
bpf_xdp_{load,store}_bytes on the frags for example.

