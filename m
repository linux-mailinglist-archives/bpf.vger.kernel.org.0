Return-Path: <bpf+bounces-10557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA567A9C1E
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 21:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69528B21ECA
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 19:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8AF41E4A;
	Thu, 21 Sep 2023 18:10:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7059441E37;
	Thu, 21 Sep 2023 18:10:31 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43D4897F0;
	Thu, 21 Sep 2023 10:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=y80U+ROzdWFAGesuJv0fAWCJugjaoZUvkVKbCL8UtRM=; b=J1yh53DeBNARTsqqU8MHBzo9Oa
	t0+dRp/RaWdqEqR/zlkiuTCdTMvV7LfZBpgaPOo9mz3Ar25SG5iPMKXPJ1Pakv7POYEio6eyu3imp
	Jue1paSBhwzjv0GVy6aou42CWQp6vSIlPYV8hlPJ5VHamcRnA8qcdTN4cPrFGpVz1BTCn704A78vE
	WKxVrydWMewhT15+u9bny+bRHgeZaaqgcYNfslcWse8SCYpLZxpj04q12Qq2mZevEQIJk5Ji3lybk
	draQ9SuAvOjf/F8wS4j1zOR8oS4A/59eybSt0kjrpVaKBQ211JZ5hMg5lAiocOJweLC8GJ5sJOtgz
	HfWLrfPQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54404)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qjKIb-0004k2-1O;
	Thu, 21 Sep 2023 15:04:57 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qjKIX-0003an-Lu; Thu, 21 Sep 2023 15:04:53 +0100
Date: Thu, 21 Sep 2023 15:04:53 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Gross <markgross@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Wong Vee Khee <veekhee@apple.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Revanth Kumar Uppala <ruppala@nvidia.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Andrey Konovalov <andrey.konovalov@linaro.org>,
	Jochen Henneberg <jh@henneberg-systemdesign.com>,
	David E Box <david.e.box@intel.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Simon Horman <simon.horman@corigine.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
	bpf@vger.kernel.org, Voon Wei Feng <weifeng.voon@intel.com>,
	Tan Tee Min <tee.min.tan@linux.intel.com>,
	Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
	Lai Peter Jun Ann <jun.ann.lai@intel.com>
Subject: Re: [PATCH net-next v3 3/5] net: phy: update in-band AN mode when
 changing interface by PHY driver
Message-ID: <ZQxNhYcusHfrJvxM@shell.armlinux.org.uk>
References: <20230921121946.3025771-1-yong.liang.choong@linux.intel.com>
 <20230921121946.3025771-4-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921121946.3025771-4-yong.liang.choong@linux.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 21, 2023 at 08:19:44PM +0800, Choong Yong Liang wrote:
> As there is a mechanism in PHY drivers to switch the PHY interface
> between SGMII and 2500BaseX according to link speed. In this case,
> the in-band AN mode should be switching based on the PHY interface
> as well, if the PHY interface has been changed/updated by PHY driver.
> 
> For e.g., disable in-band AN in 2500BaseX mode, or enable in-band AN
> back for SGMII mode (10/100/1000Mbps).
> 
> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>

This approach is *going* to break existing setups, sorry.

> +/**
> + * phylink_interface_change() - update both cfg_link_an_mode and
> + * cur_link_an_mode when there is a change in the interface.
> + * @phydev: pointer to &struct phy_device
> + *
> + * When the PHY interface switches between SGMII and 2500BaseX in
> + * accordance with the link speed, the in-band AN mode should also switch
> + * based on the PHY interface
> + */
> +static void phylink_interface_change(struct phy_device *phydev)
> +{
> +	struct phylink *pl = phydev->phylink;
> +
> +	if (pl->phy_state.interface != phydev->interface) {
> +		/* Fallback to the correct AN mode. */
> +		if (phy_interface_mode_is_8023z(phydev->interface) &&
> +		    pl->cfg_link_an_mode == MLO_AN_INBAND) {
> +			pl->cfg_link_an_mode = MLO_AN_PHY;
> +			pl->cur_link_an_mode = MLO_AN_PHY;

1. Why are you changing both cfg_link_an_mode (configured link AN mode)
and cur_link_an_mode (current link AN mode) ?

The "configured" link AN mode is supposed to be whatever was configured
at phylink creation time, and it's never supposed to change. The
"current" link AN mode can change, but changing that must be followed
by a major reconfiguration to ensure everything is correctly setup.
That will happen only because the change to the current link AN mode
can only happen when pl->phy_state.interface has changed, and the
change of pl->phy_state.interface triggers the reconfiguration.

2. You force this behaviour on everyone, so now everyone with a SFP
module that operates in 802.3z mode will be switched out of inband mode
whether they want that or not. This is likely to cause some breakage.

> +		} else if (pl->config->ovr_an_inband) {
> +			pl->cfg_link_an_mode = MLO_AN_INBAND;
> +			pl->cur_link_an_mode = MLO_AN_INBAND;

Here you force inband when not 802.3z mode and ovr_an_inband is set.
There are SFP modules that do *not* support in-band at all, and this
will break these modules when combined with a driver that sets
ovr_an_inband. So more breakage.

Please enumerate the PHY interface modes that you are trying to support
with this patch set, and indicate whether you want in-band for that
mode or not, and where the restriction for whether in-band can be used
comes from (PHY, PCS or MAC) so that it's possible to better understand
what you're trying to achieve.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

