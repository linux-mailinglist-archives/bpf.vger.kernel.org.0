Return-Path: <bpf+bounces-36526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A8A949C37
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 01:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 772CDB26786
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 23:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE66917966F;
	Tue,  6 Aug 2024 23:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uLs855Xj"
X-Original-To: bpf@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB95178CD6;
	Tue,  6 Aug 2024 23:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722986028; cv=none; b=uNAoxprpE4nwDj2FxWEeoT9WJoz82gv0McmxWcH4zynTMRQzt4COAPAnoG4i5xNtTU/nlSt7XE/+qM1RpPa3aqjGSvXH4tBkDMLE/Gke9n3hSc2mKWlyJDWchSwYiJJ+Ez+Sr42MZsyQ10Shbrwz8pYbCYsTMz9z1DRQW479O9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722986028; c=relaxed/simple;
	bh=u6aRMfvMFHsTGyvM7FoRFPA28jm6Sb8owiG15B5nTI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeFnPVp+BXTn3EozkKcuVCo4t0JzXzlNoLzKpFDLd58WSUdK6lMTeVdXycq6xp1CTiRmd/bL+EcncAJirD+TwHBS+6brVVPVZAzaMDIPs0DXcuziaP1g/Sr/lmt8Mm9c4B0JKB59oAKUPFcyYMvsZqqcQGJAvfDNLO34vIpnp64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uLs855Xj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=iAbyq20dr/x8DIIqscYsYZaTUTmMS9DPb7crcF4AiLE=; b=uL
	s855XjjIZTiEaNprML52m6TpWaRk+3WiFLVjMZTwodWlRB7qBu1zHoVudMrApkP9omrQtnBTmimvy
	ylUL8GQkuq/GuM5GdjmLEx9RZpDaR6c9TuYoRZyzOn1rNk59xhd/Ht+166Ytxa58qmwig7MZ6t2K8
	SVVb2z1z97Kp9XU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sbTMt-0049dj-Ai; Wed, 07 Aug 2024 01:13:27 +0200
Date: Wed, 7 Aug 2024 01:13:27 +0200
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
Subject: Re: [PATCH net-next v3 2/3] net: stmmac: Integrate dwxgmac4 into
 stmmac hwif handling
Message-ID: <e6b4fc20-a861-4f24-9881-f8151fe66351@lunn.ch>
References: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>
 <20240802031822.1862030-3-jitendra.vegiraju@broadcom.com>
 <1e6e6eaa-3fd3-4820-bc1d-b1c722610e2f@lunn.ch>
 <CAMdnO-J-G2mUw=RySEMSUj8QmY7CyFe=Si1-Ez9PAuF+knygWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMdnO-J-G2mUw=RySEMSUj8QmY7CyFe=Si1-Ez9PAuF+knygWQ@mail.gmail.com>

On Mon, Aug 05, 2024 at 05:36:30PM -0700, Jitendra Vegiraju wrote:
> Hi Andrew,
> On Fri, Aug 2, 2024 at 3:59 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > +     user_ver = stmmac_get_user_version(priv, GMAC4_VERSION);
> > > +     if (priv->synopsys_id == DWXGMAC_CORE_4_00 &&
> > > +         user_ver == DWXGMAC_USER_VER_X22)
> > > +             mac->dma = &dwxgmac400_dma_ops;
> >
> > I know nothing about this hardware....
> >
> > Does priv->synopsys_id == DWXGMAC_CORE_4_0 not imply
> > dwxgmac400_dma_ops?
> >
> > Could a user synthesise DWXGMAC_CORE_4_00 without using
> > dwxgmac400_dma_ops? Could dwxgmac500_dma_ops or dwxgmac100_dma_ops be
> > used?
> Yes, the user can choose between Enhanced DMA , Hyper DMA , Normal DMA.
> This SoC support has chosen Hyper DMA for future expandability.

Is there a register which describes the synthesis configuration? It is
much better that the hardware tells us what it is, rather than having
to expand this condition for every new devices which gets added.

Also, what is the definition of user_ver. Can we guarantee this is
unique and can actually be used to determine what DMA variant has been
synthesised?

	Andrew

