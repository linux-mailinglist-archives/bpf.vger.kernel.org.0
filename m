Return-Path: <bpf+bounces-20594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D2E840746
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 14:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 930271C21D0C
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 13:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBB7657B3;
	Mon, 29 Jan 2024 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4toPmIrw"
X-Original-To: bpf@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D76955C3D;
	Mon, 29 Jan 2024 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706535724; cv=none; b=EFjGFRmA7jxxtiq6Rx9H8SqhXBJE93TnMZYvfrmGdpqWjShtjE71uf3VbW/FzOX3QCCuDATkXR7NszDRHMvT/B4JAlhXWOsDiGmnyCYvZvbevbFSjnhN6Tju97/w/23iGEFyaUGTh15N3+2hwcN+vuMw8alFLHr3xcXS6ejCcIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706535724; c=relaxed/simple;
	bh=WdLW7o2nui+iHwt3lAXvXu94QN07TEcZhFQ1B6tqTUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/fHImHdKHDLJeF9YVqbSa3qjE9NZV3DXDI332eckuY035hvbWt/7U5gCbhg1KiTv0qqPkLuIo1V/Pk494wxIvq9+eCAr8AOARKFLTcRnRsrYVqCQ73xMDcRahugsKRiALZ4MlnOyDbqaqd6VKksE1UdNXkQFj+VDxNAt8qqZbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4toPmIrw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=p8iz8UHzQ67utsCq6pzEtf5vnFHnxs2dHAkgKZcozJE=; b=4toPmIrwbTb6LGQNgb70Hp7k57
	EU2YoN7SuDLwqLn8YJyiQ1wp9fpelF/3tZ0Wau7QZWYxLYRPkGawKvnlXdq4gNl/8Rb1E9EERToex
	bnzINlpiQJx9x3gIeUFCChZ2AwLd/BoKGWH/19mW5T2PK6hTROpBhH4O3QNckmNF0ZLM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rURt7-006Nmb-Tt; Mon, 29 Jan 2024 14:41:25 +0100
Date: Mon, 29 Jan 2024 14:41:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Gross <markgross@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
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
Subject: Re: [PATCH net-next v3 4/5] net: stmmac: enable Intel mGbE 1G/2.5G
 auto-negotiation support
Message-ID: <07a4aa8e-800c-4564-81c8-7cfcdddf1379@lunn.ch>
References: <20230921121946.3025771-1-yong.liang.choong@linux.intel.com>
 <20230921121946.3025771-5-yong.liang.choong@linux.intel.com>
 <jmq54bskx4zd75ay4kf5pcdo6wnz72pxzfo5ivevleef4scucr@uw4fkfs64f3c>
 <26568944-563d-4911-8f6f-14c0162db6e9@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26568944-563d-4911-8f6f-14c0162db6e9@linux.intel.com>

On Mon, Jan 29, 2024 at 09:19:58PM +0800, Choong Yong Liang wrote:
> > >   static const struct phylink_mac_ops stmmac_phylink_mac_ops = {
> > >   	.mac_select_pcs = stmmac_mac_select_pcs,
> > >   	.mac_config = stmmac_mac_config,
> > >   	.mac_link_down = stmmac_mac_link_down,
> > >   	.mac_link_up = stmmac_mac_link_up,
> > > +#if IS_ENABLED(CONFIG_INTEL_PMC_IPC)
> > > +	.mac_prepare = stmmac_mac_prepare,
> > > +#endif
> > 
> > Please no for the platform-specific ifdef's in the generic code.
> > STMMAC driver is already overwhelmed with clumsy solutions. Let's not
> > add another one.
> > 
> > -Serge(y)
> > 
> > >   };
> > >   /**
> > > diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> > > index c0079a7574ae..aa7d4d96391c 100644
> > > --- a/include/linux/stmmac.h
> > > +++ b/include/linux/stmmac.h
> > > @@ -275,6 +275,7 @@ struct plat_stmmacenet_data {
> > >   	int (*serdes_powerup)(struct net_device *ndev, void *priv);
> > >   	void (*serdes_powerdown)(struct net_device *ndev, void *priv);
> > >   	void (*speed_mode_2500)(struct net_device *ndev, void *priv);
> > > +	int (*config_serdes)(struct net_device *ndev, void *priv);
> > >   	void (*ptp_clk_freq_config)(struct stmmac_priv *priv);
> > >   	int (*init)(struct platform_device *pdev, void *priv);
> > >   	void (*exit)(struct platform_device *pdev, void *priv);
> > > -- 
> > > 2.25.1
> > > 
> > > 
> Hi Russell and Serge,
> 
> Thank you for pointing that out.
> The ifdef was removed and the config serdes will be implemented in
> mac_link_up in the new patch series.

Hi Choong

Please trim the text when replying. It can be hard to find actually
replies when having to do lots and lots of page downs. Just give the
context needed to understand your reply.

	Andrew

