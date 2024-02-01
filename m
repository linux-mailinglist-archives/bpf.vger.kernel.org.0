Return-Path: <bpf+bounces-20931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAB58452E1
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 09:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D70A1F23FBD
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 08:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACF415A4B9;
	Thu,  1 Feb 2024 08:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vUOaJTXw"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05B7158D8B;
	Thu,  1 Feb 2024 08:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706776719; cv=none; b=jtzKHNT5wO4yn/JZMOLmm55CHhqq3VcS4ljdlKtrWLDrzuryPnzVkEDnPTZ1WyOCX6hZhOvdbHqe8VdxZNOU8pHUvlVseg8S7dcjiysTy7vPbapXKyUnEC2uuXk2arMw3lBQTZ4lyWw8L+Ah8gNYM2VdGtRi//dcatd/CPVjHsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706776719; c=relaxed/simple;
	bh=vKbbomgjgBcY5l3J5iDAD1fwuBRayq3H73ZqACqcsOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHj1RG1clOWttvAAglkQk8jOB+DJjM3G2LEXJKVrcR6ry8L8eGmL9Q5bLzmIVnCewbjmz0rKt4pUBbSLvsc9Bk+zPnBtHCXEEN9lNppLse9fil4tcmEAKqQnPY3+osfWGOd0PXLZpD21KdP78RCIrY1NAXtSF9XFnjAIwiCdBS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vUOaJTXw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rrEM/L5CNb2Siaw0EtzA1uq6MEwvjM+ooAg4sDv+6Ys=; b=vUOaJTXwWrDwPbjOYcQMYs5ISg
	vTGHLnDbiExdxCQU4+KTNPIU0vo8RUyQ92hzTz7icFpYBaS+dkVlGJPjkk0EWKQ3HSrTFCJB++nR2
	7Aqg2M5Ejz5EUOn9yVorOeWvzHkLg8tTSHtgvny4nV3L4Zu1aEsQsALg3kraGBvpB07iF0i2h9Ho2
	BjBcJ9Nr6VKJvSqEu4SvgsXcX67dpfHtE1vY56zz+LBPek48+qvQ38c/NqAo26nxZczitbF9m84Tv
	I9o63J9fpzCon81R3y7mgJvCKpSoiJ9Pqv+yR74mPmdZjG2ujzxls78qpTyAvI1sYV7rCA2INc7Tk
	9YtOja1g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35708)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rVSaG-0004IS-19;
	Thu, 01 Feb 2024 08:38:08 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rVSa9-0007FA-KA; Thu, 01 Feb 2024 08:38:01 +0000
Date: Thu, 1 Feb 2024 08:38:01 +0000
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
Message-ID: <ZbtYaXkNf2ZF1prE@shell.armlinux.org.uk>
References: <20240129130253.1400707-1-yong.liang.choong@linux.intel.com>
 <20240129130253.1400707-7-yong.liang.choong@linux.intel.com>
 <ZbjNn+C/VHegH2t7@shell.armlinux.org.uk>
 <9e23671e-788c-4191-bdb4-94915ff7da5a@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e23671e-788c-4191-bdb4-94915ff7da5a@linux.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 01, 2024 at 01:10:05PM +0800, Choong Yong Liang wrote:
> 
> 
> On 30/1/2024 6:21 pm, Russell King (Oracle) wrote:
> > NAK. Absolutely not. You haven't read the phylink documentation, nor
> > understood how phylink works.
> > 
> > Since you haven't read the phylink documentation, I'm not going to
> > waste any more time reviewing this series since you haven't done your
> > side of the bargin here.
> > 
> Hi Russell,
> 
> Sorry that previously I only studied the phylink based on the `phylink.h`
> itself.

From phylink.h:

/**
 * mac_select_pcs: Select a PCS for the interface mode.
 * @config: a pointer to a &struct phylink_config.
 * @interface: PHY interface mode for PCS
 *
 * Return the &struct phylink_pcs for the specified interface mode, or
 * NULL if none is required, or an error pointer on error.
 *
 * This must not modify any state. It is used to query which PCS should
 * be used. Phylink will use this during validation to ensure that the
 * configuration is valid, and when setting a configuration to internally
 * set the PCS that will be used.
 */

Note the "This must not modify any state." statement. By reinitialising
the PCS in this method, you are violating that statement.

This requirement is because this method will be called by
phylink_validate_mac_and_pcs() at various times, potentially for each
and every interface that stmmac supports, which will lead to you
reinitialising the PCS, killing the link, each time we ask the MAC for
a PCS, whether we are going to make use of it in that mode or not.

You can not do this. Sorry. Hard NAK for this approach.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

