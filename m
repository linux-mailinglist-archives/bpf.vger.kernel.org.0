Return-Path: <bpf+bounces-36796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED05094D7EB
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 22:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01DC11C22AAD
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 20:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8050D1684B0;
	Fri,  9 Aug 2024 20:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="37MF4qDC"
X-Original-To: bpf@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832FB16631D;
	Fri,  9 Aug 2024 20:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723234355; cv=none; b=VKAsqsDAOAKhJDfx7AjmFl1i+1+tkq34c5gZWzNGzN7P4z2EGH0OUHWJjZL8Wl+Slp+BV0DT562TxcF62msMOjOscJoxOUWJTFnlKwMGI/S97UuutAgTpQyN6QkRSSdCw6jE6MQ+PRLxa70TjuCjNPIb/YxzKCNS6Vq2nKPk9s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723234355; c=relaxed/simple;
	bh=yxz/9Z8hbk/AFx//nlh592Y/HtFW2+wYEcSWLagWHYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxuW56c636w/MZGVj0viWkP47RQrapjej1x4z0tA5wDYrYJm+D4e+nM4tWtOsxhRp89CPLEeod6nB9/tRAI8Q4l9qXt9aYlY/NC4b74brXWlyffxb+c/UI97bvyV+1NxMl9KlZ3hFjOKBCtNXQZKJHQr3igArQNuqPc12vne3iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=37MF4qDC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Z5QS2qEeOwVyIpPcCh3cLZBVfiJJzs6EipXGvtlfdxQ=; b=37
	MF4qDC1Pige+qK5wnT6Q0ZZ8VnI0zkzlzR/NagidfQAazneybO4/jJeaee2cjlCjtIiGlEfBMszqV
	xCkBlwe6iKmJYyJJlGOpzOewLZo31j98RuykJb3eI7tQiadGedLv1wGqzZtnnedsW5cU7Ul0YS3Xh
	IJLuhwfoQIY4f1Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1scVy6-004PWk-1c; Fri, 09 Aug 2024 22:12:10 +0200
Date: Fri, 9 Aug 2024 22:12:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	bcm-kernel-feedback-list@broadcom.com, richardcochran@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
	linux@armlinux.org.uk, horms@kernel.org,
	florian.fainelli@broadcom.com
Subject: Re: [PATCH net-next v3 3/3] net: stmmac: Add PCI driver support for
 BCM8958x
Message-ID: <5ff4a297-bafd-4b33-aae1-5a983f49119a@lunn.ch>
References: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>
 <20240802031822.1862030-4-jitendra.vegiraju@broadcom.com>
 <c2e2f11a-89d8-42fa-a655-972a4ab372da@lunn.ch>
 <CAMdnO-JBznFpExduwCAm929N73Z_p4S4_nzRaowL9SzseqC6LA@mail.gmail.com>
 <de5b4d42-c81d-4687-b244-073142e2967b@lunn.ch>
 <CAMdnO-+_2Fy=uNgGevtnL8PGPvKyWXPvYaxOJwKcUZj+nnfqYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMdnO-+_2Fy=uNgGevtnL8PGPvKyWXPvYaxOJwKcUZj+nnfqYg@mail.gmail.com>

On Thu, Aug 08, 2024 at 06:54:51PM -0700, Jitendra Vegiraju wrote:
> On Tue, Aug 6, 2024 at 4:15 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Mon, Aug 05, 2024 at 05:56:43PM -0700, Jitendra Vegiraju wrote:
> > > On Fri, Aug 2, 2024 at 4:08 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > > >
> > > > > Management of integrated ethernet switch on this SoC is not handled by
> > > > > the PCIe interface.
> > > >
> > > > MDIO? SPI? I2C?
> > > >
> > > The device uses SPI interface. The switch has internal ARM M7 for
> > > controller firmware.
> >
> > Will there be a DSA driver sometime soon talking over SPI to the
> > firmware?
> >
> Hi Andrew,

So the switch will be left in dumb switch everything to every port
mode? Or it will be totally autonomous using the in build firmware?

What you cannot expect is we allow you to manage the switch from Linux
using something other than an in kernel driver, probably DSA or pure
switchdev.

	Andrew

