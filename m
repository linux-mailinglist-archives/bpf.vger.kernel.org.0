Return-Path: <bpf+bounces-21008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E9D846B40
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 09:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 208831C20C8D
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 08:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F81605DA;
	Fri,  2 Feb 2024 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GcEW7nTo"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E650D604C1;
	Fri,  2 Feb 2024 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863874; cv=none; b=hxOOagSH9RAwi933Wq5dQ282JH91OhMs9qyzEvKuFbx85x5w2ERBw7pyS4tvMr4nepqUNOtRwC4VxznVPZHOsy5Ql2RH/EArzjiSX0Pr48gw2UJSb0ZDuW6T3VFpj5jFSvHlbJHDC0HVRZy5XXTsEhEN1eUu3Q0JIxkDs5s0q5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863874; c=relaxed/simple;
	bh=rPghlH4fKzDrgFUA2AU5udG4v87gHBMz2GHmtLMD1sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMnnW1XJ4FAnZkgHCCu7AmxtXch9Hww6k3kX97zrbXZnjBqJdyYPFgqI2aI4bpNEa4Juji/F3MJY5EK+kb+49oZ4chZWhYgHCGGHJT/I6oWM0VdSsWbX4QyOKEQNmfeQkvIFhBBkLIamfNTDzMmhfjm8OBVvU7gGUtXHjvCsc/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=GcEW7nTo; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zgcj+wX/L6IDdldqgziNCDsIyAb6c+kW8GcYNwM7sts=; b=GcEW7nToPq2txWV+ViSERXcFwc
	rIIQ4n6+rou3/R+i4yGctXiLFzZv29zF/60F+jjXeE+KHkkI+HTQgFIorTtxr6i5Za45zbgiGpucj
	p8gdiQ/Qz6wt/2SM4aIkw4zlWDE+fNPHZ2ovt3wAkQpvzQJanqF0SAHiMGwRu0K61OLmBUFMvdnzG
	4NT4zFRK50O0q8jV7zYb1G+Dvhf+oOw/OamJj2xAG9XEZD52Lj7vD6df8J9yUZUZ/ULdzDWo6Nirg
	26NrmJqI7PQdR8VJ1T9wQDKxln+BeKE210XOxjyZftyAu6H1aS4itKKLrMYDKPb1xVrgslxsJGmE1
	J7sImYnQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49854)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rVpFx-0005e9-2k;
	Fri, 02 Feb 2024 08:50:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rVpFq-0008Bx-Er; Fri, 02 Feb 2024 08:50:34 +0000
Date: Fri, 2 Feb 2024 08:50:34 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Gross <markgross@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrew Halaney <ahalaney@redhat.com>,
	Simon Horman <simon.horman@corigine.com>,
	Serge Semin <fancer.lancer@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
	bpf@vger.kernel.org, Voon Wei Feng <weifeng.voon@intel.com>,
	Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
	Lai Peter Jun Ann <jun.ann.lai@intel.com>,
	Abdul Rahim Faizal <faizal.abdul.rahim@intel.com>
Subject: Re: [PATCH net-next v4 06/11] net: stmmac: resetup XPCS according to
 the new interface mode
Message-ID: <Zbys2orOUikYxeOm@shell.armlinux.org.uk>
References: <20240129130253.1400707-1-yong.liang.choong@linux.intel.com>
 <20240129130253.1400707-7-yong.liang.choong@linux.intel.com>
 <ZbjNn+C/VHegH2t7@shell.armlinux.org.uk>
 <9e23671e-788c-4191-bdb4-94915ff7da5a@linux.intel.com>
 <ZbtYaXkNf2ZF1prE@shell.armlinux.org.uk>
 <2ad1f55c-f361-4439-9174-6af1bb429d55@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ad1f55c-f361-4439-9174-6af1bb429d55@linux.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Feb 02, 2024 at 11:00:58AM +0800, Choong Yong Liang wrote:
> 
> 
> On 1/2/2024 4:38 pm, Russell King (Oracle) wrote:
> > Note the "This must not modify any state." statement. By reinitialising
> > the PCS in this method, you are violating that statement.
> > 
> > This requirement is because this method will be called by
> > phylink_validate_mac_and_pcs() at various times, potentially for each
> > and every interface that stmmac supports, which will lead to you
> > reinitialising the PCS, killing the link, each time we ask the MAC for
> > a PCS, whether we are going to make use of it in that mode or not.
> > 
> > You can not do this. Sorry. Hard NAK for this approach.
> > 
> Thank you for taking the time to review, got your concerns, and I'll address
> the following concerns before submitting a new patch series:
> 
> 1. Remove allow_switch_interface and have the PHY driver fill in
> phydev->possible_interfaces.

Yes please.

> 2. Rework on the PCS to have similar implementation with the following patch
> "net: macb: use .mac_select_pcs() interface"
> (https://lore.kernel.org/netdev/E1n568J-002SZX-Gr@rmk-PC.armlinux.org.uk/T/).

mac_select_pcs() is about returning to phylink the PCS that the MAC
needs to use for the specified interface mode, or NULL if no PCS is
required, nothing more, nothing less.

Plase do not copy that mac_select_pcs() implementation - changing the
"ops" underneath phylink is no longer permitted.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

