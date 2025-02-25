Return-Path: <bpf+bounces-52498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C956A43C5C
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 11:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2CF1778DC
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 10:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9332676C9;
	Tue, 25 Feb 2025 10:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b="llW/+8+M"
X-Original-To: bpf@vger.kernel.org
Received: from mx.ssi.bg (mx.ssi.bg [193.238.174.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74113266EFA;
	Tue, 25 Feb 2025 10:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.238.174.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740480976; cv=none; b=ttfdHO+hUiqNcQ12KbTT25DA+vSmJz97AyWynAxrZsKhpxjKwQNN5ph789SoY0p3muW/Ciits19nqv879xVUGyGl5u/Prj8i1D9S9sfJ+8bANXu9uczZgM3wDVnHJGVC3vyoV3GS74J7cWgBKNJUBb+PQbFctBx5+7oyOlCQ0iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740480976; c=relaxed/simple;
	bh=qk5AiaQz6PdkbWGnVQkm4jx/jLxIyHU0t509oubQRbY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TMrnvnLAub4XbYELnE0cYremmnQqDnlhWOUCkk+sFGSE48Q8BR7L+ATjFpRXSfyCTtEfgEKRDhofXBdv7EJ0UYdklChIsDPKUZYGrZaw6k24NfXo5ul+g/6ib5S/Tey6j2aeXToWr3Wvun9Ds/16nESzpwSukG108/8dMucPloI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=llW/+8+M; arc=none smtp.client-ip=193.238.174.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Received: from mx.ssi.bg (localhost [127.0.0.1])
	by mx.ssi.bg (Potsfix) with ESMTP id 4D3D023481;
	Tue, 25 Feb 2025 12:56:04 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ssi.bg; h=cc:cc
	:content-type:content-type:date:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=ssi;
	 bh=TipT1tkO6RZzYUIkmyaB+EXc3EJaKclBzOrQySYWfSE=; b=llW/+8+M/+l1
	+TXSWE8GrBA8ZI1xe5YEwHI8hAT8ywfSUfgmt2cdETi3wH+H+ceCHyQ55stwa2Ks
	xE71Q5YPcKf+T251DYi6puxgn7bTZDgBpjsi1v/P++ItfQHAPqbdBKqXbpfBPQhL
	LeFHH4GCD2jx+AhQAqneSC+zBR4mVaNQqXW4NA/TAsulXmIjzcCH+xoGhUlbjM5q
	08tMYiKspFKUz9kjNk1CasyfMyd/Ffgg4RaZ0UA3Yl6FoufpMlukU/mMd1GHy+mX
	grBZ0THRTC9aB8RvvfZ1nGJXh8d8QzoTjOfmc+AGKI/IEZK0CJ5ELTL7vxb+uK8Q
	zi8+B7r5m0oDK+8gm9d/MJyrj3p0IoawPVQ1aQt7GMUkp77ce/0Cr29APFHeJUlV
	L33fKDQUv00VQb6ejcSGACISXkKgJ2xshIb5YrxTTTU/nw5xlUsrUa/IfgJvoQZC
	zGOkg8xgd887ORdaimnJNBMjMC5zfozklbd7ZeLqWOQKTxL7muWon2zivcFAMcba
	qGThLux1Qk/EyRctBthZ8ibwtGl0pyTg0Jgu6LX428Pjpdggx4UC4uVGgUk90I3B
	wT+YAEZhUMhfIUj6C18J7itG2ksH+dQodILiZqd5+sN/AAr5wgF0vzJqbOSNHCzX
	VZdYr7hrIw6HDkPVNWXOKiVeh50d560=
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
	by mx.ssi.bg (Potsfix) with ESMTPS;
	Tue, 25 Feb 2025 12:56:03 +0200 (EET)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by ink.ssi.bg (Postfix) with ESMTPSA id C2AC11709E;
	Tue, 25 Feb 2025 12:55:52 +0200 (EET)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.18.1/8.17.1) with ESMTP id 51PAte3H025739;
	Tue, 25 Feb 2025 12:55:42 +0200
Date: Tue, 25 Feb 2025 12:55:40 +0200 (EET)
From: Julian Anastasov <ja@ssi.bg>
To: Philo Lu <lulie@linux.alibaba.com>
cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        asml.silence@gmail.com, willemb@google.com, almasrymina@google.com,
        chopps@labn.net, aleksander.lobakin@intel.com,
        nicolas.dichtel@6wind.com, dust.li@linux.alibaba.com,
        hustcat@gmail.com, horms@verge.net.au, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 net] ipvs: Always clear ipvs_property flag in
 skb_scrub_packet()
In-Reply-To: <20250222033518.126087-1-lulie@linux.alibaba.com>
Message-ID: <61a40de5-3b11-e84b-90a5-fefd8da3bb23@ssi.bg>
References: <20250222033518.126087-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


	Hello,

On Sat, 22 Feb 2025, Philo Lu wrote:

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
> Fixes: 2b5ec1a5f973 ("netfilter/ipvs: clear ipvs_property flag when SKB net namespace changed")
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>

	Looks good to me, thanks!

Acked-by: Julian Anastasov <ja@ssi.bg>

	It was safer to reset the flag when netns changes but
it has role only before output device is reached or while
packet is looped over lo device. New tunnel headers should
be safe to reset it because nf ct and dst are dropped too.

> ---
> v1 -> v2:
>  - Add Fixes tag as suggested by Julian Anastasov
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


