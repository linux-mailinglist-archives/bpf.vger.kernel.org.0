Return-Path: <bpf+bounces-60745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBE1ADB978
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 21:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6EB174923
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 19:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914B8289E0F;
	Mon, 16 Jun 2025 19:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fBvZbyjH"
X-Original-To: bpf@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069E41C700D;
	Mon, 16 Jun 2025 19:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750101638; cv=none; b=WS+Ghd+Fbm+cVQUEhGTABE1wmnnpRgJ8IearDqjKx/8dlIf7yGsIOvpjN49fsB4TRfRN4C+dRlCvVB8dw2B7aZgY7sXk9mIt90isogi1vJrrQUhMsaZNpogQvMSfQbyZtuus/XZAPmm8whekLPLfaWMPb58B6uxYF7yvNm9dn4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750101638; c=relaxed/simple;
	bh=23wZAAowdpPdcKwMPsuWb/6CEEuQxJRaWZVtAlr/ix4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eX8zQtStUlJze5en802scxR1KJyelMdDXjlWZ01EZFysQpSQrgPDNPd12ZR9vPq4lIIu1dlJeZmuWGrwATu9FNM3aZgk5z4mLwrcPG4h4caernto3UolY7Boeh8ZIgn1K3RhF1zuDiLPgYKAe75abV6bGo00448Ys7asRv1zImw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fBvZbyjH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3J6gfxo8qCIaAtgHmX+eY47QddkWF7XHWWn9I+jS5Go=; b=fBvZbyjHBc4zaZX+HTK0Em56P4
	D8cZ4+dFB3jBs8g9/hGC/DRFuwwDcBj1D+UJmv5LFPAqFmXtj/6O3L1ltR/xF5ui4LCjS3ZgJq0hk
	BMNXZ7Ec+ujPLttYo0M4aFtKBZVrcU5stnwhutw3SzOcKb3YnM6estqHeklToWn8h0TY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uRFNb-00G50l-6O; Mon, 16 Jun 2025 21:20:27 +0200
Date: Mon, 16 Jun 2025 21:20:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Robert Cross <quantumcross@gmail.com>
Cc: bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, olteanv@gmail.com, pabeni@redhat.com
Subject: Re: [PATCH v2] net: dsa: mv88e6xxx: fix external smi for mv88e6176
Message-ID: <c43d06e3-76a2-46d4-a047-3ab647016e22@lunn.ch>
References: <ad17b701-f260-473f-b96f-0668ce052e75@lunn.ch>
 <20250616191214.2295467-1-quantumcross@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616191214.2295467-1-quantumcross@gmail.com>

On Mon, Jun 16, 2025 at 03:12:14PM -0400, Robert Cross wrote:
> > The MV88E6390_G2_SMI_PHY_CMD_FUNC_EXTERNAL bit is reserved on the 6352
> > family.
> 
> Indeed it is...
> 
> > You are not understanding what i'm saying. This family has a single
> > MDIO bus controller. That controller is used by both the internal PHY
> > devices, plus there are two pins on the chip for external PHYs.
> >
> > All the PHYs will appear on that one MDIO bus controller.
> 
> So you're saying that if I removed my hack that apparently just sets
> this reserved bit, and I take my PHY on port 6 and remove it from
> the mdio_ext { compatible = "marvell,mv88e6xxx-mdio-external"; } entry
> and put it in my mdio { } node it will direct requests to address 6 to
> the external phy via the MDC/MDIO_PHY pins just fine?

Yep.

> I'm guessing it will just automatically enable or disable the external
> SMI pins depending on the state of port 5 which shares pins?

I _think_ you will actually see all MDIO transactions on the external
pins. SolidRun got one of their board designs wrong, and put an
external PHY on the same address as an internal PHY. That results in
both not working because they stomp over each other on the bus.

	Andrew

