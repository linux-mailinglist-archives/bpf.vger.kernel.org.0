Return-Path: <bpf+bounces-40965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9762E99095E
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 18:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F301B21E22
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 16:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DB41CACE0;
	Fri,  4 Oct 2024 16:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgYGy5+v"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF141C8317;
	Fri,  4 Oct 2024 16:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059803; cv=none; b=RQWdBYU68oUYCoJVkHH5mymvW7l/90PDrlP5G1rxsPMwqSGKL4ZryPRywvN8D6Er7rjz7ne7sExEeSIPfo4uNcaNl5AYaCLO3BBO7ozL7AF1hZH1I6p0soVGdlsBR+WnbmehRsUQxvX88c8v2xh4tU5ZvcQzK0mp/6QR/gI/1Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059803; c=relaxed/simple;
	bh=YCzCIpSyOCkaHHoXJm93ZdZBqFaZugX1OTf4JmTIj9o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WueJjapLJ6w+uSbNCrSpTw/V2JslqB6XXNQQMYzACdtNn8ylv/JfZOG7z4mJBmy18pjRflAWgCj6olYCbd9AL1Y53OBdlPT5dl53JB4fGMdYLHUV4/HEFKm98fJhxjA3z2WwuwmgDnvb+cJWIYaX9aUGo2D+PXJN98h7i4PTUtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgYGy5+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E4DC4CEC6;
	Fri,  4 Oct 2024 16:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728059802;
	bh=YCzCIpSyOCkaHHoXJm93ZdZBqFaZugX1OTf4JmTIj9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BgYGy5+vhGCyluUh+gDSoLENfBCY9njRgbQjsYxD6n+YJlMb8L7+69JiF7hFkC998
	 RkzIHr3KBiDLHbAWKflHuNZCVwv8laizJ31R1kGIeM1AWirZ3kxpYrFY31vjssAVZm
	 iRhpn2gTB8Wrjq1ERqsZxLK5XCgFKNiIZYu6XN0jK9e+y2o9oWwVCEHpDvFNF9Lcon
	 xbiRhZsfHua5e0EsNgjmvMH1MKFgdJUV0Rtoq0fsTb5Kj56elu8ZWq/om2P1La2g7K
	 NjXadUdEDPu+ojH3EzqwP+hJ000UHXTsku+8OmzR7Ftqfe4H50GyuT21oIq1uvRrF1
	 6mbgN5IINbScA==
Date: Fri, 4 Oct 2024 09:36:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: edumazet@google.com, atenart@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, dsahern@kernel.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, dongml2@chinatelecom.cn,
 bigeasy@linutronix.de, toke@redhat.com, idosch@nvidia.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 1/7] net: ip: add drop reason to
 ip_route_input_noref()
Message-ID: <20241004093641.7f68b889@kernel.org>
In-Reply-To: <20241001060005.418231-2-dongml2@chinatelecom.cn>
References: <20241001060005.418231-1-dongml2@chinatelecom.cn>
	<20241001060005.418231-2-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

no longer applies, please respin

On Tue,  1 Oct 2024 13:59:59 +0800 Menglong Dong wrote:
> +	enum skb_drop_reason drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
>  	const struct iphdr *iph = ip_hdr(skb);
> -	int err, drop_reason;
> +	int err;
>  	struct rtable *rt;

reverse xmas tree

>  
> -	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
> -
>  	if (ip_can_use_hint(skb, iph, hint)) {
>  		err = ip_route_use_hint(skb, iph->daddr, iph->saddr, iph->tos,
>  					dev, hint);
> @@ -363,7 +362,7 @@ static int ip_rcv_finish_core(struct net *net, struct sock *sk,
>  	 */
>  	if (!skb_valid_dst(skb)) {
>  		err = ip_route_input_noref(skb, iph->daddr, iph->saddr,
> -					   iph->tos, dev);
> +					   iph->tos, dev, &drop_reason);

I find the extra output argument quite ugly.
I can't apply this now to try to suggest something better, perhaps you
can come up with a better solution..
-- 
pw-bot: cr

