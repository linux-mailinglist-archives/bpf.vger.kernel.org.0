Return-Path: <bpf+bounces-52181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EE1A3FA4B
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 17:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D59719E0E83
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 16:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E98215053;
	Fri, 21 Feb 2025 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b="e2LjwSLl"
X-Original-To: bpf@vger.kernel.org
Received: from mx.ssi.bg (mx.ssi.bg [193.238.174.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BC12144C3
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.238.174.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153575; cv=none; b=iM3brkakzCImRTRX/fCAZT0jYqQB6rxY4rJelxoZWkGQM2Fzyg3QuZpUHiWX4SW/wsv0dFNSgz0OusrHIbKIpRfnsKv8HOmHmETRchzFB8uEjCMvD3JPml3x1XSHMfPvopTMCr/zBSYwOORH1UUuhFqewX0HNou0cXkz+GLqZ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153575; c=relaxed/simple;
	bh=PxWdT8KjTiBPV/g4HJF+n40rUM1VBmqecO5CnMu24IA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cnFrnq2P0tr7VedHdm84poadkqHQpwrpxO4cuUndT9ug2qWCh7IPQ3pmveRr04S4VNut1YA21M226tJY71dlsuZiLAGsXYtGUA182W3dQj4FCBgKEgO0v2sua6sXxdOwV9uui8F6Mp3HTzVYtEqu13fw5xv6WuSFG1sP7Xl9iKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=e2LjwSLl; arc=none smtp.client-ip=193.238.174.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Received: from mx.ssi.bg (localhost [127.0.0.1])
	by mx.ssi.bg (Potsfix) with ESMTP id 51F50229CA;
	Fri, 21 Feb 2025 17:59:26 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ssi.bg; h=cc:cc
	:content-id:content-type:content-type:date:from:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=ssi; bh=l0LitblEbtKMznCE8ElI65Dsh7jKX6yGyHzIVUzjF3Y=; b=e
	2LjwSLl5+EYHomTJoMOTz4DY7QMKP8G/D7yNORzx9ofgBuaUJY71z1vWUOttHiA6
	B5uzFErZBitwS81baLG1h2kMjl4LPv7fjC0KlDqmTIFtTN1Iq9LrPWhl2X8XnhHq
	lqPCucFNdiyaOaKHDVotSjiu1IER+LTTCcyr09JfUf5UYIIFnLEgShjr6umisKuB
	+T4mxnpokBOuGnC0T9YvXK9TUYiM5cl466KtesU0TRtqjftmJHerJzpO0jNk8Ee1
	R+useezaxQRo66xuHnTSC51Q8SZUaqNo+hK76vnIekU/X/MpB9mdCH7r1BRtn+Vi
	XC3a9vXFc6YSyf0x331zt1jhWSW0TmrucAskn9Z4AFxJKO1NRiBv72cDaGGpVd6j
	cWPR2+eQq+pfwJqzYhzdrIF8Ppp/RAZgiS/Q9d9Yrg7lUcYEV5RZx6qUUcaUlbdL
	CMIEFFlA/Ev5UZdhPbzcS4ULnoODALMmuNRCYqcObWRpcI1+MUZ/crpxYK7cdRXy
	HUdXt4NaYvTmf2SksTpSyUdihnp/Wk9zPYZOElhuhfnlfi9r7rUxSsgCvreYySf6
	w3RTIxPyY2gWZ4cZCJHuT1rqSy89gBZopooAZUtoElCYcTMYgJU9MtQYdHocMb9x
	+8C1bZNrMIa0ZCmzh4VLSpYhXskukJWmN7haKKiaC4=
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
	by mx.ssi.bg (Potsfix) with ESMTPS;
	Fri, 21 Feb 2025 17:59:25 +0200 (EET)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by ink.ssi.bg (Postfix) with ESMTPSA id 119DB15EA8;
	Fri, 21 Feb 2025 17:59:17 +0200 (EET)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.18.1/8.17.1) with ESMTP id 51LFxFk5041810;
	Fri, 21 Feb 2025 17:59:16 +0200
Date: Fri, 21 Feb 2025 17:59:15 +0200 (EET)
From: Julian Anastasov <ja@ssi.bg>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
cc: Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, asml.silence@gmail.com,
        willemb@google.com, almasrymina@google.com, chopps@labn.net,
        aleksander.lobakin@intel.com, dust.li@linux.alibaba.com,
        hustcat@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipvs: Always clear ipvs_property flag in
 skb_scrub_packet()
In-Reply-To: <6202010a-412f-4d63-92a5-d78ba216c65e@6wind.com>
Message-ID: <c42296ae-e7ad-7063-f87c-ddf516e72ed0@ssi.bg>
References: <20250221013648.35716-1-lulie@linux.alibaba.com> <6202010a-412f-4d63-92a5-d78ba216c65e@6wind.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463811672-1664573096-1740151264=:14998"
Content-ID: <e8109416-79ae-e910-da52-6d372102b395@ssi.bg>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811672-1664573096-1740151264=:14998
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <4fabcb62-9a35-763a-78d6-a694768e425f@ssi.bg>


	Hello,

On Fri, 21 Feb 2025, Nicolas Dichtel wrote:

> Le 21/02/2025 à 02:36, Philo Lu a écrit :
> > We found an issue when using bpf_redirect with ipvs NAT mode after
> > commit ff70202b2d1a ("dev_forward_skb: do not scrub skb mark within
> > the same name space"). Particularly, we use bpf_redirect to return
> > the skb directly back to the netif it comes from, i.e., xnet is
> > false in skb_scrub_packet(), and then ipvs_property is preserved
> > and SNAT is skipped in the rx path.
> > 
> > ipvs_property has been already cleared when netns is changed in
> > commit 2b5ec1a5f973 ("netfilter/ipvs: clear ipvs_property flag when
> > SKB net namespace changed"). This patch just clears it in spite of
> > netns.
> > 
> > Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> > ---
> > This is in fact a fix patch, and the issue was found after commit
> > ff70202b2d1a ("dev_forward_skb: do not scrub skb mark within
> > the same name space"). But I'm not sure if a "Fixes" tag should be
> > added to that commit.
> > ---
> >  net/core/skbuff.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 7b03b64fdcb2..b1c81687e9d8 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -6033,11 +6033,11 @@ void skb_scrub_packet(struct sk_buff *skb, bool xnet)
> >  	skb->offload_fwd_mark = 0;
> >  	skb->offload_l3_fwd_mark = 0;
> >  #endif
> > +	ipvs_reset(skb);
> >  
> >  	if (!xnet)
> >  		return;
> >  
> > -	ipvs_reset(skb);
> I don't know IPVS, but I wonder if this patch will not introduce a regression
> for other users. skb_scrub_packet() is used by a lot of tunnels, it's not
> specific to bpf_redirect().

	Indeed, now we will start to clear the flag for tunnels
and it can cause IPVS to attempt rerouting for UDP tunnels, i.e.
once the packet is routed by IPVS to tunnel and second time later 
after tunneling again when ip_local_out() is called and we see 
ipvs_property=0 for the outer UDP header. Before such patch
ipvs_property remains 1 and we do not try to balance the UDP
traffic. So, for now, this patch may be can spend more cycles for
the traffic via UDP tunnels but this looks like a rare IPVS setup,
i.e. real servers reachable via UDP tunnels. Note that IPVS
has own support for UDP tunnels where it is set as forwarding
method + tunnel type GUE for the real server. It is not affected
by this patch.

Regards

--
Julian Anastasov <ja@ssi.bg>
---1463811672-1664573096-1740151264=:14998--


