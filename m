Return-Path: <bpf+bounces-42393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 561FD9A3A44
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 11:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5A01F2886B
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 09:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A0B200B97;
	Fri, 18 Oct 2024 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFNgq6pj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806601FF7CC;
	Fri, 18 Oct 2024 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729244506; cv=none; b=tuM556HL4yXJ/lwebRM3m6XUgKhYxF7DdP9YTGBdwOKxpXWs/OKzsWAgVIiSaS+ryUtiLdJIyTUfqcUNO5WmuVVMQXoF1VthQCh0GpI9tVcZoD1HGXqh+LwByGU8ycnLRsWQXnRMEqt3nvC6UVbPxsGlI07KsTpAbQ/McqHzq3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729244506; c=relaxed/simple;
	bh=STA9085V5QDtl2xh/lrhmVnjJbInSu6992MFdMsW5V8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c93bmo5InMnX7hQS+Rplt4Fy2vODn8CuHxYbaLjcOts01ovwSVG0aZI4/F1fpMTHij31EDlbUvt+adVdKQFFczvR9b5nBSZKOtCMoCN1mpdSR6xFoTxYiMVLFXNWd503W2DgyS89tNAl/GdiOmM6suOYIydXNhSzNkgYrld7O5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFNgq6pj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC53AC4CEC7;
	Fri, 18 Oct 2024 09:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729244506;
	bh=STA9085V5QDtl2xh/lrhmVnjJbInSu6992MFdMsW5V8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RFNgq6pjL40F9seIrECBJiCsY8530WZJuOmpGMM67dVyL2WH+b6Yc48cpUY8vGFy2
	 GhQYOqcEtoH6+crkfQ6rdVtuQ4MZZ/QffMYsR/wKjXEULonaIZqgO2PRys07gIDZzj
	 yZbabElq6NlIx/gNztOnoWjRcQ/nIyigiO4KxWtgjb1FgIXt45DyS/ukztpkr/Ad7u
	 0guZS+f5qK6Dr2dJvZRJg8ERIKl6XtarAzuSYG78n98eXnsbVMrYDWhjBDwPIesrja
	 DabfmUbhcau66NmIs/BA+xBUxEcqZbpufA//0Fn9865QxEiTxq1qfnSkG3CAcvpOUI
	 JCBUIeBHHe+8A==
Date: Fri, 18 Oct 2024 10:41:39 +0100
From: Simon Horman <horms@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrii Nakryiko <andriin@fb.com>, Jussi Maki <joamaki@gmail.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCHv2 net-next 2/3] bonding: use correct return value
Message-ID: <20241018094139.GD1697@kernel.org>
References: <20241017020638.6905-1-liuhangbin@gmail.com>
 <20241017020638.6905-3-liuhangbin@gmail.com>
 <878qumzszs.fsf@toke.dk>
 <ZxGv2s4bl5VQV4g-@fedora>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxGv2s4bl5VQV4g-@fedora>

On Fri, Oct 18, 2024 at 12:46:18AM +0000, Hangbin Liu wrote:
> On Thu, Oct 17, 2024 at 04:47:19PM +0200, Toke Høiland-Jørgensen wrote:
> > > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> > > index f0f76b6ac8be..6887a867fe8b 100644
> > > --- a/drivers/net/bonding/bond_main.c
> > > +++ b/drivers/net/bonding/bond_main.c
> > > @@ -5699,7 +5699,7 @@ static int bond_xdp_set(struct net_device *dev, struct bpf_prog *prog,
> > >  		if (dev_xdp_prog_count(slave_dev) > 0) {
> > >  			SLAVE_NL_ERR(dev, slave_dev, extack,
> > >  				     "Slave has XDP program loaded, please unload before enslaving");
> > > -			err = -EOPNOTSUPP;
> > > +			err = -EEXIST;
> > 
> > Hmm, this has been UAPI since kernel 5.15, so can we really change it
> > now? What's the purpose of changing it, anyway?
> 
> I just think it should return EXIST when the error is "Slave has XDP program
> loaded". No special reason. If all others think we should not change it, I
> can drop this patch.

Hi Toke,

Could you add some colour to what extent user's might rely on this error code?

Basically I think that if they do then we shouldn't change this.

