Return-Path: <bpf+bounces-36527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 245DA949C3B
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 01:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A191F240BF
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 23:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06519176AA6;
	Tue,  6 Aug 2024 23:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="G6owhoGG"
X-Original-To: bpf@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D298016F830;
	Tue,  6 Aug 2024 23:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722986133; cv=none; b=TSM+XtTo+WZmHQf0smwCkbfgywHq9z8f6U7Sb7h9P8ZMW5G0lJYH3F6/gzHNSiJQOS8jxonKotXzuOisuzNicAQPNA5+ubkrt7DDzHN36V03jIJUJGEakFex+bnNbjAjOV9cFGcgcFwkY8qR/gtSoYeBA49vAITVlEoS2IvlNjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722986133; c=relaxed/simple;
	bh=OafAZ7YUyamEa5Gf0ohOCKmyO7o4U7s1SpA0ByTn4hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFbf1D/4R7izJDv4YMkoMjFxjLWDnI8VIswDCIcrMF0OC85tbXOeO3tHsK6D+FPjtMbHxG137gQu1pwZWUm+RFlZ1bTFsf7eabG5vsCo/YW/qOPM4DGMKUnc+q9fyBQV5jHfGFEqopXkxdw6H+ZOopkrBGAZ6b5oZLR7T6xpniI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=G6owhoGG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=XpAy4J2ekuQ40+as300oEbx8urXUUAPYXbeLgo0VO58=; b=G6
	owhoGGliOZBpH/YlnX8eMYRTb67QWtCndkBodQsVuEsiSy0PF5/dy17yNzM2rPrsFB2yCKmG6UR1L
	HQCPwZZ3AzsfQZrPQ1vn84Vbo8gQl0yiJL+V8WOi2Num8vtWb1lNYorf82L3c3j4rkb8hLspZ8UgK
	BONlk4QZ9SKvHBg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sbTOb-0049fR-QC; Wed, 07 Aug 2024 01:15:13 +0200
Date: Wed, 7 Aug 2024 01:15:13 +0200
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
Message-ID: <de5b4d42-c81d-4687-b244-073142e2967b@lunn.ch>
References: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>
 <20240802031822.1862030-4-jitendra.vegiraju@broadcom.com>
 <c2e2f11a-89d8-42fa-a655-972a4ab372da@lunn.ch>
 <CAMdnO-JBznFpExduwCAm929N73Z_p4S4_nzRaowL9SzseqC6LA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMdnO-JBznFpExduwCAm929N73Z_p4S4_nzRaowL9SzseqC6LA@mail.gmail.com>

On Mon, Aug 05, 2024 at 05:56:43PM -0700, Jitendra Vegiraju wrote:
> On Fri, Aug 2, 2024 at 4:08 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > Management of integrated ethernet switch on this SoC is not handled by
> > > the PCIe interface.
> >
> > MDIO? SPI? I2C?
> >
> The device uses SPI interface. The switch has internal ARM M7 for
> controller firmware.

Will there be a DSA driver sometime soon talking over SPI to the
firmware?

	Andrew

