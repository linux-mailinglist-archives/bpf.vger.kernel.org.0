Return-Path: <bpf+bounces-15006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F397EA115
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 17:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669E91C208C4
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 16:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB6D2232A;
	Mon, 13 Nov 2023 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgytOnSK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F8521A0E;
	Mon, 13 Nov 2023 16:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE521C433C9;
	Mon, 13 Nov 2023 16:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699892156;
	bh=oB+TvMxi4DPxrJsrEqQNrgfa8cu29Qp2KY/zuWRtuo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NgytOnSKcVZq9tDlW1mZGtQn/H00iwOBEOdhWTCmKb5zjDOt/p5JaYHTrvK4q6zUi
	 JX4Qrw1I1fQvSjpcEZc+xWw5OUW9rcAVUlOP1cbEwE2Nrqxod7nD+1223svgHhTD2s
	 6POK8w5ZRyrB5mKTPcB49rtJ0m+TFVzC/TFa1LU+SnzwcEUef2Gk3j/og276F7oCkG
	 yjlZ4J6Li1fi2XlL5xunAXedqbvmpUPJli1/9m/nJc/eLYC3bsnpeNXPl0k8W7nXfa
	 Sq+q6aUFCyarh/uDW7r0ldQqm0iPyM/PeFpXSSnT4xA/39HV58b5m7MIMW0iSulK0V
	 udTF1aJ7gjVIA==
Date: Mon, 13 Nov 2023 16:15:52 +0000
From: Simon Horman <horms@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@kernel.org, kuba@kernel.org, razor@blackwall.org,
	sdf@google.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
	David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH bpf v2 2/8] net: Move {l,t,d}stats allocation to core and
 convert veth & vrf
Message-ID: <20231113161552.GA4482@kernel.org>
References: <20231112203009.26073-1-daniel@iogearbox.net>
 <20231112203009.26073-3-daniel@iogearbox.net>
 <20231113100305.GO705326@kernel.org>
 <cc269865-d3c7-f8e6-9a61-25794f5ae220@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc269865-d3c7-f8e6-9a61-25794f5ae220@iogearbox.net>

On Mon, Nov 13, 2023 at 02:05:36PM +0100, Daniel Borkmann wrote:
> On 11/13/23 11:03 AM, Simon Horman wrote:
> > On Sun, Nov 12, 2023 at 09:30:03PM +0100, Daniel Borkmann wrote:

...

> > > @@ -10469,6 +10513,7 @@ void netdev_run_todo(void)
> > >   		WARN_ON(rcu_access_pointer(dev->ip_ptr));
> > >   		WARN_ON(rcu_access_pointer(dev->ip6_ptr));
> > > +		netdev_do_free_pcpu_stats(dev);
> > >   		if (dev->priv_destructor)
> > >   			dev->priv_destructor(dev);
> > >   		if (dev->needs_free_netdev)
> > 
> > nit: the hunk above seems unnecessary; one blank line is enough.
> 
> I'm not sure which one you mean?

It seems that I was confused for some reason,
please ignore my previous comment.


