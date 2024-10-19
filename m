Return-Path: <bpf+bounces-42501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE289A4C81
	for <lists+bpf@lfdr.de>; Sat, 19 Oct 2024 11:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 026E4281E65
	for <lists+bpf@lfdr.de>; Sat, 19 Oct 2024 09:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD7A1DEFC2;
	Sat, 19 Oct 2024 09:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAMAzUxE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4145A15D5D9;
	Sat, 19 Oct 2024 09:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729329577; cv=none; b=I8IgplRgB6wsrpYLhVzYfFdEB8dTEbhhAB70ltpTzvBiB9RCbezUKm4Nf+fEg3ChcmvnEJ0EtxRNLUhWvOoQWsc6PN9kUuyJ3JGerZL9CYXp8mJyObqtmv3PDRniAIeT8/rlUOB9SR+4N0566sxG5Jc0+lVAP3Pn2m7WpQ3sXzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729329577; c=relaxed/simple;
	bh=ukAnmrzm5txy+zOC3tzTSzJ2SbJ7TgWf6o+/eiDiXUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5vrFO76wx0VdyNJVRqKpUCbTbmONYp/8QamSlgihXyn/lktlK6r14OFRvtyYOo35hI6NzxvK4tIpvGPOLcUW3WQHhW/7cV9wYw8ahy1M9IgjSfk4W/LD3EByK4wQE+omjQCpeNpkxkDCxfpsj4KoTHQc97nkyaMGrugabNfoHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAMAzUxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD284C4CEC5;
	Sat, 19 Oct 2024 09:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729329577;
	bh=ukAnmrzm5txy+zOC3tzTSzJ2SbJ7TgWf6o+/eiDiXUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gAMAzUxETaSXCQm3fSd84p2fqg1EqfjQ5ec0S7FngFMpyUNvhWf7nJMyVtJ2xRZPA
	 RtBfXfO2U/uisgCIYeCWoJVCKDypfIRuIcVWcC+MN6TrhnTOq+LvvfPTsOFEylD+j6
	 5Z+KoiKs23fZmA+Qpucu0S3pK4D6kH0eYWRGNwEVrW/TEi7+fU6U4Ikp7MguVImM/h
	 Yez2X4+MnAzO3/QHexQGS6Di7jTO8Our/hr8/L14coKx9QC0XgtNulJwGudfX1WQaS
	 lDJIPsVjnBLqlUfhkA5GrkvaGzrM+ZqQXfSDcT5WJrnegVI+GK9EuRbPaVSeLaQOO5
	 feW2a+WdoC2rQ==
Date: Sat, 19 Oct 2024 10:19:30 +0100
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
Message-ID: <20241019091930.GS1697@kernel.org>
References: <20241017020638.6905-1-liuhangbin@gmail.com>
 <20241017020638.6905-3-liuhangbin@gmail.com>
 <878qumzszs.fsf@toke.dk>
 <ZxGv2s4bl5VQV4g-@fedora>
 <20241018094139.GD1697@kernel.org>
 <87o73hy7hh.fsf@toke.dk>
 <20241018142104.GP1697@kernel.org>
 <ZxMCdP1X-h9qyU0u@fedora>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxMCdP1X-h9qyU0u@fedora>

On Sat, Oct 19, 2024 at 12:51:00AM +0000, Hangbin Liu wrote:
> On Fri, Oct 18, 2024 at 03:21:04PM +0100, Simon Horman wrote:
> > On Fri, Oct 18, 2024 at 01:29:30PM +0200, Toke Høiland-Jørgensen wrote:
> > > Simon Horman <horms@kernel.org> writes:
> > > 
> > > > On Fri, Oct 18, 2024 at 12:46:18AM +0000, Hangbin Liu wrote:
> > > >> On Thu, Oct 17, 2024 at 04:47:19PM +0200, Toke Høiland-Jørgensen wrote:
> > > >> > > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> > > >> > > index f0f76b6ac8be..6887a867fe8b 100644
> > > >> > > --- a/drivers/net/bonding/bond_main.c
> > > >> > > +++ b/drivers/net/bonding/bond_main.c
> > > >> > > @@ -5699,7 +5699,7 @@ static int bond_xdp_set(struct net_device *dev, struct bpf_prog *prog,
> > > >> > >  		if (dev_xdp_prog_count(slave_dev) > 0) {
> > > >> > >  			SLAVE_NL_ERR(dev, slave_dev, extack,
> > > >> > >  				     "Slave has XDP program loaded, please unload before enslaving");
> > > >> > > -			err = -EOPNOTSUPP;
> > > >> > > +			err = -EEXIST;
> > > >> > 
> > > >> > Hmm, this has been UAPI since kernel 5.15, so can we really change it
> > > >> > now? What's the purpose of changing it, anyway?
> > > >> 
> > > >> I just think it should return EXIST when the error is "Slave has XDP program
> > > >> loaded". No special reason. If all others think we should not change it, I
> > > >> can drop this patch.
> > > >
> > > > Hi Toke,
> > > >
> > > > Could you add some colour to what extent user's might rely on this error code?
> > > >
> > > > Basically I think that if they do then we shouldn't change this.
> > > 
> > > Well, that's the trouble with UAPI, we don't really know. In libxdp and
> > > xdp-tools we look at the return code to provide a nicer error message,
> > > like:
> > > 
> > > https://github.com/xdp-project/xdp-tools/blob/master/lib/libxdp/libxdp.c#L615
> > > 
> > > and as a signal to fall back to loading the programme without a dispatcher:
> > > 
> > > https://github.com/xdp-project/xdp-tools/blob/master/lib/libxdp/libxdp.c#L1824
> > > 
> > > Both of these cases would be unaffected (or even improved) by this
> > > patch, so in that sense I don't have a concrete objection, just a
> > > general "userspace may react to this". In other words, my concern is
> > > more of a general "we don't know, so this seems risky". If any of you
> > > have more information about how bonding XDP is generally used, that may
> > > help get a better idea of this?
> > 
> > Yes, that is the trouble with the UAPI. I was hoping you might be able to
> > provide the clarity you ask for above. But alas, things are as clear as
> > mud.
> > 
> > In lieu of more information I suggest caution and dropping this change for
> > now.
> 
> OK, I will drop this one.

Thanks.

