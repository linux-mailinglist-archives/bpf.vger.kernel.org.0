Return-Path: <bpf+bounces-36808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1804D94D998
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 02:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAEA71F21812
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 00:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009581F5FF;
	Sat, 10 Aug 2024 00:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="W5wEvW2B"
X-Original-To: bpf@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8318EEB3;
	Sat, 10 Aug 2024 00:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723251218; cv=none; b=KIF5W8D3VOCbloHRRzhu5x9zcr2g0bvmqdyd7IeHvDvFXzFEM+9pjNIN3uAbdcZgboDx+NJ5q2lsMGvtUzTQhSDAa0VahYH/C827eaoszeahY960aKkYl7lkHocyJu47FpFewMFQOm6wRRv9UobCV6Wj8oUmqQvez2dmrD1VoFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723251218; c=relaxed/simple;
	bh=60YqD4Ya+OdrDLBPCuS+YCa9rMrdQ7FKG1U7djaxP2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRg+Wo8rg2nOu1Qg5vzImRtEZOdbKypm8aXEHkItxVL49UmJjoAJ76sKHqpgHPw+6X49Cmc4sxlWwmjO2bbSTJ5DQmCiSnVRmfiQXAU/YpDhcrB6TPHIioxolImgu9M7zbXlMzBYBWsrJQer+63ZfXuz0TCfTKaazh2nr2kHLPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=W5wEvW2B; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DkpWdwfdYShH0tYvWIL8CwsOc/KFH8bow/K6S4AK+54=; b=W5wEvW2BrijqSSaMjcQLuegg4k
	c1B94zGifDd3mz5I3i6omnBzkzRBW5jDL230SWQcib9Ds4g3gqT+WlVYCk8U//FWdCjKMWzfJn6cP
	1XrolqjD/Ch8Dy9xh1qPVge1BuzG+5C21CvSP52lCEPfpYnJwkYK8ldPGC/3AZmTSmFo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1scaM5-004QHZ-JU; Sat, 10 Aug 2024 02:53:13 +0200
Date: Sat, 10 Aug 2024 02:53:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>,
	netdev@vger.kernel.org, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	bcm-kernel-feedback-list@broadcom.com, richardcochran@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
	linux@armlinux.org.uk, horms@kernel.org
Subject: Re: [PATCH net-next v3 3/3] net: stmmac: Add PCI driver support for
 BCM8958x
Message-ID: <fab4b842-4881-4fa4-aaf6-2deee50a0a39@lunn.ch>
References: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>
 <20240802031822.1862030-4-jitendra.vegiraju@broadcom.com>
 <c2e2f11a-89d8-42fa-a655-972a4ab372da@lunn.ch>
 <CAMdnO-JBznFpExduwCAm929N73Z_p4S4_nzRaowL9SzseqC6LA@mail.gmail.com>
 <de5b4d42-c81d-4687-b244-073142e2967b@lunn.ch>
 <CAMdnO-+_2Fy=uNgGevtnL8PGPvKyWXPvYaxOJwKcUZj+nnfqYg@mail.gmail.com>
 <5ff4a297-bafd-4b33-aae1-5a983f49119a@lunn.ch>
 <2c4a42ee-164b-447f-b51d-07b2585345b3@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c4a42ee-164b-447f-b51d-07b2585345b3@broadcom.com>

> > > Hi Andrew,
> > 
> > So the switch will be left in dumb switch everything to every port
> > mode? Or it will be totally autonomous using the in build firmware?
> > 
> > What you cannot expect is we allow you to manage the switch from Linux
> > using something other than an in kernel driver, probably DSA or pure
> > switchdev.
> 
> This looks reasonable as an advice about to ideally fit within the existing
> Linux subsystems, however that is purely informational and it should not
> impair the review and acceptance of the stmmac drivers.
> 
> Doing otherwise, and rejecting the stmmac changes because now you and other
> reviewers/maintainers know how it gets used in the bigger picture means this
> is starting to be overreaching. Yes silicon vendor companies like to do all
> sorts of proprietary things for random reasons, I think we have worked
> together long enough on DSA that you know my beliefs on that aspect.
> 
> I think the stmmac changes along have their own merit, and I would seriously
> like to see a proper DSA or switchdev driver for the switching silicon that
> is being used, but I don't think we need to treat the latter as a
> prerequisite for merging the former.

I fully agree this patchset should be merged without needing a DSA
driver. We have seen a number of automotive systems recently doing
very similar things, Linux is just a host connected to a switch. Linux
is too unreliable to manage the switch, or Linux takes too long to
boot and configure the switch etc. So something else is in control of
the switch. Linux only view onto the switch is as a typical external
device, it can walk the SNMP MIBs etc.

If you decided Linux can manage this switch, then great, please
sometime in the future submit a DSA or switchdev driver. Otherwise
Linux is just a host with no real knowledge of the switch, and the SPI
interface is not used.

	  Andrew

