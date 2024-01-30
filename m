Return-Path: <bpf+bounces-20695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5316842123
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 11:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD362857C2
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 10:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A1360DC9;
	Tue, 30 Jan 2024 10:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PQtfvQ4H"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CF865BB9;
	Tue, 30 Jan 2024 10:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706610111; cv=none; b=t8DK+EbUIawK/tpheXEUh4DFsUhS7Ty2NUm4CIqbrLasqUOPV6zUJ97E8tudcZEDllhKgasrwxSWFMhNZZBO8MX2IWye3A7pynEMuGWdCrxYS6eOZ3CWmSeNHcG9EflsQvMOpfRdnr3EU0AKmz3cEWQoezAI3S/S9zlntYDDgE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706610111; c=relaxed/simple;
	bh=a2BTL8SBv7QBEt7tWzfKlIFmC4VJGefkz7RX3H6+xX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4+MD4WLSzHymd/K9pYKPqdSMr7tT2kJXyB1AHUGWkmUVzdzFRVQ7Derv3MWU4RKJaJjgQqKATtcbYxDwi8Lfuh66KM4FbQBzVxEbYqE7HiW0ADsk6PQVJS+gmVmXdRLX/Hcm0CTK3i2hVmvulbMdNN55j3aFUHyM4bVcNcifFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PQtfvQ4H; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7X7nyoTob837kWWS4ii2spbXx6qHIsfIrrozaG7eBhw=; b=PQtfvQ4HPrhtLZf/ky6DE1d/mi
	6rP+Gbp9/1EAYGUkkbwtIZhlLo3uejAakSHk6CQ5XHEKMmMyxahazloEQ20EE9kr9pgS1kIexNHZi
	m9iC2HgVg9isgFgr/9myEHDJaLrZk40tsCi4Rj9RRQiNfeLqkRno8n5yAXQD8XWCkUuAnfo+v8QEK
	k6kxpsbXuoYnCAUZf7kkwCD9JUMZ+V6vD9ONzN32HmSYdOnQ4qLmzwn/gQGlh+WajsWlWnOXO6bnK
	gV5Biuqx40A9fITUM64AFjqn4F2CRpCgtR/KsRTT88VIcXwmXeMcaBMdH17IFtp6lg2MRlDscceiD
	8ccWrW5w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50698)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rUlF6-0001dH-2d;
	Tue, 30 Jan 2024 10:21:25 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rUlF1-0005Ql-Cp; Tue, 30 Jan 2024 10:21:19 +0000
Date: Tue, 30 Jan 2024 10:21:19 +0000
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
Message-ID: <ZbjNn+C/VHegH2t7@shell.armlinux.org.uk>
References: <20240129130253.1400707-1-yong.liang.choong@linux.intel.com>
 <20240129130253.1400707-7-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129130253.1400707-7-yong.liang.choong@linux.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 29, 2024 at 09:02:48PM +0800, Choong Yong Liang wrote:
> XPCS creation will map the configuration for the provided interface mode.
> Then XPCS will operate according to the interface mode.
> 
> When the interface mode changes, XPCS is required to map the configuration
> to the new interface mode and destroy the old interface mode where it
> is not in use.
> 
> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 13 +++++++++++--
>  drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c |  7 +++----
>  3 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index f155e4841c62..886efd26991e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -357,7 +357,7 @@ enum stmmac_state {
>  int stmmac_mdio_unregister(struct net_device *ndev);
>  int stmmac_mdio_register(struct net_device *ndev);
>  int stmmac_mdio_reset(struct mii_bus *mii);
> -int stmmac_xpcs_setup(struct mii_bus *mii);
> +int stmmac_xpcs_setup(struct mii_bus *mii, phy_interface_t interface);
>  void stmmac_set_ethtool_ops(struct net_device *netdev);
>  
>  int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags);
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 00af5a4195fd..50429c985441 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -941,8 +941,17 @@ static struct phylink_pcs *stmmac_mac_select_pcs(struct phylink_config *config,
>  {
>  	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
>  
> -	if (priv->hw->xpcs)
> +	if (priv->hw->xpcs) {
> +		if (interface != PHY_INTERFACE_MODE_NA &&
> +		    interface != priv->plat->phy_interface) {
> +			/* When there are major changes, we reconfigure
> +			 * the setup for xpcs according to the interface.
> +			 */
> +			xpcs_destroy(priv->hw->xpcs);
> +			stmmac_xpcs_setup(priv->mii, interface);

NAK. Absolutely not. You haven't read the phylink documentation, nor
understood how phylink works.

Since you haven't read the phylink documentation, I'm not going to
waste any more time reviewing this series since you haven't done your
side of the bargin here.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

