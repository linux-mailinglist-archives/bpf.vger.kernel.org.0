Return-Path: <bpf+bounces-51686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A0EA37314
	for <lists+bpf@lfdr.de>; Sun, 16 Feb 2025 10:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624A0188D367
	for <lists+bpf@lfdr.de>; Sun, 16 Feb 2025 09:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96618185B67;
	Sun, 16 Feb 2025 09:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WC8dIz7e"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6FB7F9;
	Sun, 16 Feb 2025 09:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739698012; cv=none; b=uUDcsbBFLsKrvX5lBHZLXxZWXuTJeKMCaRqowT+gqvjdkwend2u8XrkYk4EiGuqaV2cFx6ZLX4nGgbEtYDg6iLt1pGS78AA/Z1EYHITtJa6IDP+fwluLhK2ciGDP85J1NFaL9ayxsVjvoio8jamacxDjaQ4k7YFqj6JznWlUIqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739698012; c=relaxed/simple;
	bh=qOKEtCKMyux97ZLVC7VY7mjdb0VsP0z9R+6QKp1pThE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brVG8h+Cuv51znlnXofFgG4YRshrmmUkR61X+fNQlGx34PDLF+/cvMHuAr5Msnw8gfnCWa2rDdRWMlrP2ttVkL8JJVHzKxolmPf0j9KwzeVrAncTd+rZP+MTPb9/AL83s5ndS/UBo4vnI/bsXv9GT99FgiG2bEOHTDYX2bDm2h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WC8dIz7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1E5C4CEDD;
	Sun, 16 Feb 2025 09:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739698011;
	bh=qOKEtCKMyux97ZLVC7VY7mjdb0VsP0z9R+6QKp1pThE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WC8dIz7ex2oAFNaCXgB5ktq8MYAn6ChCVhuclMZvs01XUI9hX/63BW8OA9Rlx4I8M
	 tDUJjmBuN4hWQi5v/ndfIpUmy7HA2FjduJy2OTmhil/t2Kj7QNsGa199PFREqPy4TR
	 ezxIjwovP5p7qL1bUkMMRT67mXC1fskCEpG8vFhaZJuHJ03HxJR4Gh0FkFlN+54aVO
	 gaI95//S3F4PvElYDvX4ftz5ZinoDjiOT4UMD2GyBwd56T/Fn6qFGcOGoleUF2MDpp
	 8QVV2CYL6pY8cydNsYULwDh9EMwji5szZlBzrOogtrugAu+YqSy7P/cPDumWIV1zPT
	 QrYoIUzT57WFA==
Date: Sun, 16 Feb 2025 09:26:46 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Amit Cohen <amcohen@nvidia.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Network Development <netdev@vger.kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf <bpf@vger.kernel.org>, mlxsw <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 00/12] mlxsw: Preparations for XDP support
Message-ID: <20250216092646.GY1615191@kernel.org>
References: <cover.1738665783.git.petrm@nvidia.com>
 <CAADnVQKMN4+Zg9ZG4FpH9pJw4KdmwWmT2d4BiJgHUUQ-Hd7OkQ@mail.gmail.com>
 <BL1PR12MB59225F7D902ACBC6A91511C3CBF42@BL1PR12MB5922.namprd12.prod.outlook.com>
 <CAADnVQLJfd201t_-bgWHRJRDHm4FQDNapbmAQhPd18OEFq_QdA@mail.gmail.com>
 <BL1PR12MB5922564282DA2C2C5CA671C1CBF42@BL1PR12MB5922.namprd12.prod.outlook.com>
 <20250205090958.278ffaff@kernel.org>
 <20250215140252.GP1615191@kernel.org>
 <20250215081043.063e995a@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215081043.063e995a@kernel.org>

On Sat, Feb 15, 2025 at 08:10:43AM -0800, Jakub Kicinski wrote:
> On Sat, 15 Feb 2025 14:02:52 +0000 Simon Horman wrote:
> > > TBH I also feel a little ambivalent about adding advanced software
> > > features to mlxsw. You have a dummy device off which you hang the NAPIs,
> > > the page pools, and now the RXQ objects. That already works poorly with
> > > our APIs. How are you going to handle the XDP side? Program per port, 
> > > I hope? But the basic fact remains that only fallback traffic goes thru
> > > the XDP program which is not the normal Linux model, routing is after
> > > XDP.
> > > 
> > > On one hand it'd be great if upstream switch drivers could benefit from
> > > the advanced features. On the other the HW is clearly not capable of
> > > delivering in line with how NICs work, so we're signing up for a stream
> > > of corner cases, bugs and incompatibility. Dunno.  
> > 
> > FWIIW, I do think that as this driver is actively maintained by the vendor,
> > and this is a grey zone, it is reasonable to allow the vendor to decide if
> > they want the burden of this complexity to gain some performance.
> 
> Yes, I left this series in PW for an extra couple of days expecting
> a discussion but I suppose my email was taken as a final judgment.

Yes, I was trying to spur that discussion.

> The object separation can be faked more accurately, and analyzed
> (in the cover letter) to give us more confidence that the divergence
> won't create problems.
> 
> The "actively maintained" part is true and very much appreciated, but
> it's both something that may easily change, and is hard to objectively
> adjudicate. Reporting results to the upstream CI would be much more
> objective and hopefully easier to maintain, were the folks supporting
> mlxsw to "join a startup", or otherwise disengage.

A good point. Things can change. And that may leave upstream maintainers
caring the can.

