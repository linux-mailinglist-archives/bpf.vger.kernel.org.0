Return-Path: <bpf+bounces-42422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C6F9A4100
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 16:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A24289795
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 14:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7662C1EE002;
	Fri, 18 Oct 2024 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzgiulS2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85386BFCA;
	Fri, 18 Oct 2024 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261272; cv=none; b=jo/qCOJ9aUUuWeyCFHK0EGI4qnVfTTA4F/6VGnMIHqqFnQcgXDNSwCBoIeKRpzzE4q1oWhyYkRQqA576i49GbS0oO1ey4CZ9PXkJ6Irz+JorQUn47JcP1njxikoYw98wGUBeuXyFW/q5gMMGYw4JtA1yOEQbnJ7JPQtqg9Jswsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261272; c=relaxed/simple;
	bh=ECioSBta/T4Mm2R7F7k6DzVa2u7XNruvIlcI8+i/QpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZMqT4bjXYd/2DH41AO0E0C+zdQoLA9u/ScUKEcTs5EUyn92sJgZRSA4aGktj6D3JNNqCQrVuiutB0w1UUReG4JVT2+0NBIzkfTDOe5pqGn4vI50MtwbTfxAOeQxvoMcXf3/SeIFKNez/zWBFi1MO5c4QMCaDE5nZ3ZtoRX2EgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzgiulS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13439C4CEC3;
	Fri, 18 Oct 2024 14:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729261271;
	bh=ECioSBta/T4Mm2R7F7k6DzVa2u7XNruvIlcI8+i/QpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DzgiulS2sJiiET79pCk8UL6iUrgtZJKNk5FGkDO/3047qLeVO2618KzPRpD6KtVb5
	 J0XNeo/tcmc6lvSkyRWzfa4w3KGfY7vn/Wn/lncrbFK1Kx/en1kHTQ9TmevfTqOI7l
	 2MT4zu/Omkc06EzF2Z628YPpCiLUdcczFXr+stzg/QoUTMsBtHpCpUmTeua5sM1gRP
	 X9FgZuhtQ8twS2+B+KCEEBDc0pHhO3knrJtUPVkkSliMcfdwCH05Jp7sIbktyFrCN2
	 kbkaPfJnmgPAx/8qjKsBd1CTye84JBGP3HgMyQbm/0+P1iASjnEO8RMkc2XsjxEELD
	 Xip+3Zsd1kVqA==
Date: Fri, 18 Oct 2024 15:21:04 +0100
From: Simon Horman <horms@kernel.org>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
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
Message-ID: <20241018142104.GP1697@kernel.org>
References: <20241017020638.6905-1-liuhangbin@gmail.com>
 <20241017020638.6905-3-liuhangbin@gmail.com>
 <878qumzszs.fsf@toke.dk>
 <ZxGv2s4bl5VQV4g-@fedora>
 <20241018094139.GD1697@kernel.org>
 <87o73hy7hh.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o73hy7hh.fsf@toke.dk>

On Fri, Oct 18, 2024 at 01:29:30PM +0200, Toke Høiland-Jørgensen wrote:
> Simon Horman <horms@kernel.org> writes:
> 
> > On Fri, Oct 18, 2024 at 12:46:18AM +0000, Hangbin Liu wrote:
> >> On Thu, Oct 17, 2024 at 04:47:19PM +0200, Toke Høiland-Jørgensen wrote:
> >> > > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> >> > > index f0f76b6ac8be..6887a867fe8b 100644
> >> > > --- a/drivers/net/bonding/bond_main.c
> >> > > +++ b/drivers/net/bonding/bond_main.c
> >> > > @@ -5699,7 +5699,7 @@ static int bond_xdp_set(struct net_device *dev, struct bpf_prog *prog,
> >> > >  		if (dev_xdp_prog_count(slave_dev) > 0) {
> >> > >  			SLAVE_NL_ERR(dev, slave_dev, extack,
> >> > >  				     "Slave has XDP program loaded, please unload before enslaving");
> >> > > -			err = -EOPNOTSUPP;
> >> > > +			err = -EEXIST;
> >> > 
> >> > Hmm, this has been UAPI since kernel 5.15, so can we really change it
> >> > now? What's the purpose of changing it, anyway?
> >> 
> >> I just think it should return EXIST when the error is "Slave has XDP program
> >> loaded". No special reason. If all others think we should not change it, I
> >> can drop this patch.
> >
> > Hi Toke,
> >
> > Could you add some colour to what extent user's might rely on this error code?
> >
> > Basically I think that if they do then we shouldn't change this.
> 
> Well, that's the trouble with UAPI, we don't really know. In libxdp and
> xdp-tools we look at the return code to provide a nicer error message,
> like:
> 
> https://github.com/xdp-project/xdp-tools/blob/master/lib/libxdp/libxdp.c#L615
> 
> and as a signal to fall back to loading the programme without a dispatcher:
> 
> https://github.com/xdp-project/xdp-tools/blob/master/lib/libxdp/libxdp.c#L1824
> 
> Both of these cases would be unaffected (or even improved) by this
> patch, so in that sense I don't have a concrete objection, just a
> general "userspace may react to this". In other words, my concern is
> more of a general "we don't know, so this seems risky". If any of you
> have more information about how bonding XDP is generally used, that may
> help get a better idea of this?

Yes, that is the trouble with the UAPI. I was hoping you might be able to
provide the clarity you ask for above. But alas, things are as clear as
mud.

In lieu of more information I suggest caution and dropping this change for
now.

-- 
pw-bot: cr

