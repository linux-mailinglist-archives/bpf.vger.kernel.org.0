Return-Path: <bpf+bounces-52172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BF3A3F339
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 12:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E83D83B763C
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 11:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448B5201036;
	Fri, 21 Feb 2025 11:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b="ymShszHt"
X-Original-To: bpf@vger.kernel.org
Received: from mx.ssi.bg (mx.ssi.bg [193.238.174.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AD620967E
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 11:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.238.174.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740138166; cv=none; b=aRjMMz4CK+lUUvSmrAoLVubg9vuNNDSu9wdV46HksGXCcl4KSkEYclzIWOUu6CuluiQYdyP1YrZzNx3JwPZv/cp10yA1p4h7C6fh8ABSkaX4RMtCMvolY6c8yndmZpiuVhnea9DbbypG/MXL8qq5w/SYntJtBdja5bERVCJ6ruE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740138166; c=relaxed/simple;
	bh=rHO1TE402i+X64ecIGyWE4iQT9eVIwC498+u0VfYSmM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZCajmZRjbt2koXPT9XXBYIIjlnrRSO7qSNWeJJNarrKdBbT7XdkK3jcBFESQlK5wLeGCRlQJiTWZAWG0LpXHX1L8/aKMVuSqpzCaoU3rSlqvJER0MPFcvMTtLfM94emjbOjViV4fb07AUht/Fv4tyIEPoQQRTee+7iYJy9ZU1H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=ymShszHt; arc=none smtp.client-ip=193.238.174.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Received: from mx.ssi.bg (localhost [127.0.0.1])
	by mx.ssi.bg (Potsfix) with ESMTP id B34A4229CA;
	Fri, 21 Feb 2025 13:42:33 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ssi.bg; h=cc:cc
	:content-type:content-type:date:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=ssi;
	 bh=Rvmmn/22ErC/lFdIKwmR7DRAR2odvCfMBz7Z7y4EnLs=; b=ymShszHtW9yj
	NVSoY/HVnCviiGK64bWkr3OF0NU1esvPFv1zwF2SaJgTi/BEkF9jCEG/yy3WF6tQ
	XZ2Bl4LfgNwWIw759/4pYk60BjSLuQ0AsmL+jXFBZlpgScS7dId1Zz5I+IJxswUD
	F+d0D8cZYc6f64Q+XXLjVTQaW3fpOBN5soUTdOGtTezEH9DNXS6tsZ4y4QGrurYP
	chDZZ/kwncjh5sVZiipXNmZFXtNGSkLNt4F26QspBIqYfI4EqfhLj6kT1cOerD/b
	/bYU/L5jKwwfI+P/glvtLHZCphSQnqB2NzEuvkdzZE69zNdKOvZPO7oRO6wct0Hn
	WidWEYmlX4/5buNFASeiqMwPmWsV6MH7dMvhHsadMm7Rplqbl/YB+4tRQtNo4uvC
	7laVojkyBWtETNYxUq0to1Q72sSQvcAYbQsXjUfUKf6U2TWPvddzCmiu74dh1xD6
	hN0zDhPGTcPXddusn3Sek2y/RI0MP7dsPJ9uPsoO799SoWC47kQTW7X+OO10GaeQ
	uC9zYhsRZA/Y9dzunplwUU/kqiM2j2ps+UpnqyTgBimRE9PfLNbkm2flXYF6F/GD
	HiGFFTreSpj48pJTDfdTyLIBrmZsSB06iesRVfT2PQaYBWiLiY17litAe1Qa7PZ1
	+JTmdWuNz/N3U8hUAxNi3XCmstiS4gs=
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
	by mx.ssi.bg (Potsfix) with ESMTPS;
	Fri, 21 Feb 2025 13:42:33 +0200 (EET)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by ink.ssi.bg (Postfix) with ESMTPSA id 93ECD15EA8;
	Fri, 21 Feb 2025 13:42:25 +0200 (EET)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.18.1/8.17.1) with ESMTP id 51LBgGPs027564;
	Fri, 21 Feb 2025 13:42:17 +0200
Date: Fri, 21 Feb 2025 13:42:16 +0200 (EET)
From: Julian Anastasov <ja@ssi.bg>
To: Philo Lu <lulie@linux.alibaba.com>
cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        asml.silence@gmail.com, willemb@google.com, almasrymina@google.com,
        chopps@labn.net, aleksander.lobakin@intel.com,
        nicolas.dichtel@6wind.com, dust.li@linux.alibaba.com,
        hustcat@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipvs: Always clear ipvs_property flag in
 skb_scrub_packet()
In-Reply-To: <20250221013648.35716-1-lulie@linux.alibaba.com>
Message-ID: <610b255c-51e4-0460-05a2-ab9cd8c43295@ssi.bg>
References: <20250221013648.35716-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


	Hello,

On Fri, 21 Feb 2025, Philo Lu wrote:

> We found an issue when using bpf_redirect with ipvs NAT mode after
> commit ff70202b2d1a ("dev_forward_skb: do not scrub skb mark within
> the same name space"). Particularly, we use bpf_redirect to return
> the skb directly back to the netif it comes from, i.e., xnet is
> false in skb_scrub_packet(), and then ipvs_property is preserved
> and SNAT is skipped in the rx path.
> 
> ipvs_property has been already cleared when netns is changed in
> commit 2b5ec1a5f973 ("netfilter/ipvs: clear ipvs_property flag when
> SKB net namespace changed"). This patch just clears it in spite of
> netns.
> 
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> ---
> This is in fact a fix patch, and the issue was found after commit
> ff70202b2d1a ("dev_forward_skb: do not scrub skb mark within
> the same name space"). But I'm not sure if a "Fixes" tag should be
> added to that commit.

	You can add 2b5ec1a5f973 as a Fixes tag in v2 and I'll ack it.

	Nowadays, ipvs_property prevents unneeded connection
lookups while the packet traverses the hooks (different IPVS
hook handlers can see the same packet in same or next hook).
This includes the case where packet can be routed to local server,
eg. via loopback_xmit(), for example:

Packet from device:
	LOCAL_IN: set ipvs_property=1
	Reroute to local server ?
		Then to hit the local server continue the NF hook
	Otherwise, route via device:
		LOCAL_OUT: use ipvs_property to avoid conn lookup
			and rerouting
		LOCAL_OUT:
			Unexpected divert to local server by someone else?
			=> LOCAL_IN: use ipvs_property to avoid conn
			lookup and rerouting

Packet from local client:
	LOCAL_OUT: set ipvs_property=1
	Reroute to local server?
		Then continue via loopback_xmit() without 
			skb_scrub_packet()
		LOCAL_IN: use ipvs_property to avoid conn lookup and
			rerouting
		Hit the local server
	Otherwise, route via device:
		Others at LOCAL_OUT: Unexpected divert to local server by 
			someone else ?
			=> LOCAL_IN: use ipvs_property to avoid conn 
			lookup and rerouting

	So, we need ipvs_property set only during the normal
path where packet is received and sent, possibly to local
server via local route. We do not care if the packet leaves
this path. Currently, ipvs_property was cleared if netns
changes but it is a safe option. What matters is if packet
is routed via local route. Other paths can reset the flag
safely.

> ---
>  net/core/skbuff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 7b03b64fdcb2..b1c81687e9d8 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -6033,11 +6033,11 @@ void skb_scrub_packet(struct sk_buff *skb, bool xnet)
>  	skb->offload_fwd_mark = 0;
>  	skb->offload_l3_fwd_mark = 0;
>  #endif
> +	ipvs_reset(skb);
>  
>  	if (!xnet)
>  		return;
>  
> -	ipvs_reset(skb);
>  	skb->mark = 0;
>  	skb_clear_tstamp(skb);
>  }
> -- 
> 2.32.0.3.g01195cf9f

Regards

--
Julian Anastasov <ja@ssi.bg>


