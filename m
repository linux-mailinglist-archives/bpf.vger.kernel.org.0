Return-Path: <bpf+bounces-78537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7879D12266
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 12:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF865301D97A
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 11:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CE5355806;
	Mon, 12 Jan 2026 11:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EX24A4HL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B6C290D81;
	Mon, 12 Jan 2026 11:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768215953; cv=none; b=hs3TgApt7bysgPRxjwt3yAfTQBxbb//hql47lql4gyObQvnN1V5p/4WEXe978WsQ3Zz+rBewQrxiEU+ujqOpi+/SLK7U5VhU441IJbzh+NpnsBvpcMMTpcYLepqhFgkdT+mFasORnMnGlof1S4VJWNPxEfjzBBFxpIi/P1Bi4dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768215953; c=relaxed/simple;
	bh=12qjxKrKiYt4pXU613mI33pHUAiJdZ2m7E1yNfiSuPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cje6x59DmIeRWEqbn2QFjQ2JwF+uKtuLO/SJHGzoFJOAHrmnrSi6jd7AYfJ8l56zlalTVKkY1oSnGL/gofIX9ffWvozRX0q+XUKs8Vfn0ovLy29E2KOBKH6rpToDDM9/heITpjj2TIiBRwFjXk4k1YnVMXaTq1lzGi75V6z329Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EX24A4HL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843D8C16AAE;
	Mon, 12 Jan 2026 11:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768215953;
	bh=12qjxKrKiYt4pXU613mI33pHUAiJdZ2m7E1yNfiSuPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EX24A4HLwW33KwOVyI65nJHstYeYlNCOy8l6db/DJh9DFOQs0aEF0U/K20I0+P0FE
	 barvLs5OnyoQZ2jdNLayZSc2/enJmFcjDrOuRTlQ/750jnum6WD4RoCUp8YomwbI0M
	 smHtVNCarAd1Llc83edwNfyI+LJafKIH9dz4+aV8=
Date: Mon, 12 Jan 2026 12:05:50 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Cc: stable@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
	borisp@nvidia.com, john.fastabend@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com, yin.ding@broadcom.com,
	tapas.kundu@broadcom.com, Kuniyuki Iwashima <kuniyu@google.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.6.y 2/2] tls: Use __sk_dst_get() and dst_dev_rcu() in
 get_netdev_for_sock().
Message-ID: <2026011223-tarnish-mustiness-a6bf@gregkh>
References: <20260112064554.2969656-1-keerthana.kalyanasundaram@broadcom.com>
 <20260112064554.2969656-3-keerthana.kalyanasundaram@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112064554.2969656-3-keerthana.kalyanasundaram@broadcom.com>

On Mon, Jan 12, 2026 at 06:45:54AM +0000, Keerthana K wrote:
> From: Kuniyuki Iwashima <kuniyu@google.com>
> 
> [ Upstream commit c65f27b9c3be2269918e1cbad6d8884741f835c5 ]
> 
> get_netdev_for_sock() is called during setsockopt(),
> so not under RCU.
> 
> Using sk_dst_get(sk)->dev could trigger UAF.
> 
> Let's use __sk_dst_get() and dst_dev_rcu().
> 
> Note that the only ->ndo_sk_get_lower_dev() user is
> bond_sk_get_lower_dev(), which uses RCU.
> 
> Fixes: e8f69799810c ("net/tls: Add generic NIC offload infrastructure")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
> Link: https://patch.msgid.link/20250916214758.650211-6-kuniyu@google.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> [ Keerthana: Backport to v6.6.y ]
> Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
> ---
>  net/tls/tls_device.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)

This is not in 6.12.y, so we can't take it for 6.6.y yet.  Can you
please send a 6.12.y version and then a new 6.6.y version?

thanks,

greg k-h

