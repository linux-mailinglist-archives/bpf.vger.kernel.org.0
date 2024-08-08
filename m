Return-Path: <bpf+bounces-36719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C367C94C5E7
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 22:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 456B11F2444D
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 20:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785B315A4B0;
	Thu,  8 Aug 2024 20:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVj1t4LM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EF3149E0E;
	Thu,  8 Aug 2024 20:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723149781; cv=none; b=FERF8o6YupY+DbBUjj1kdXfFfKRxXBvdP49ya8tyP94oAaQz3c+BeC9rhPA+q12aE/T0HrGSQzMlH08MNj9dKp0EpKt1mjovtrOjIxJhK+doboLKXX0uABcoxRiisajBCk6M41upoXD+hptWhgQjFYBXAG3a7Ekv/dT3YDWzNs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723149781; c=relaxed/simple;
	bh=p3vk1a4aJrbiZC6vQDLvpj6hZnEOsEnpg73p95sLIhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncfc0qatTXiz0RnQvh4jii9bpRDvBiy8IYC011wM6fG5xzZ/fF5CnZr+cspoy9ujroPtWMWAoUSSP9W+vrSetbIkuatE7DCPNA9Ik1aBuiouqPUcvkfHppWxhkbqI/yb0qTnc8EaEVoYoxF+5TmTFzLnMvGADeuwNQ7AwHOlS/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVj1t4LM; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52efd08e6d9so1781516e87.1;
        Thu, 08 Aug 2024 13:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723149777; x=1723754577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tGUitiYVYitFcN4JMPacup/eKd8LJWBR2TLhG9ytri8=;
        b=KVj1t4LMP8e8mQNYSWkAUB7GqNVErNB++yFvmqttUYI7nTaxwkTQ6vx/qYVhV3U3+u
         DST2q28Nzah4BcBSaAL1hNB+pToYRPp1aszCQR+J+HTykFfwHoQbW106wgOKG9Xp2cil
         yNxcJYfm4u80+YmZBEZzUKjyQtTRA00L+yX6lgrysgnMVbLY/0aWatmNUguNbKWckJ7n
         6rbHHb6Vs6rGL+diczEN/8ZxxMphLID71OyqBj9k76P5QG7dY+Z7c0ZsGHmt/45R4WPo
         WX6Koa8cl9dp5YuNXjqyzNzT0JzxdHJUpZOLa2VAHOuA4kBl6m84aFDdhrpmh094xi6H
         uDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723149777; x=1723754577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGUitiYVYitFcN4JMPacup/eKd8LJWBR2TLhG9ytri8=;
        b=rezlCXMDISuiWg2AAbMx06eOypTz2Yu4Qlif17nWpp8GjE2sBZagZgvJJo3pWWvkZ+
         PUZjddnKjhGl7T4lt6eX8VgELeS18heSiyL7LjEQ0B1UT6HF0E+BS68NNodtvrB4dGMW
         xvBiDscR6rg/o5J8+m3UU5CaDYp8mTd37XGsQL+ReqN0kW/MqqYPnH8n5zVWzEoC4vM6
         2NQHOSxu6qs1eCTEngJzre04tBO6tXeJatmzpT5eG+0eJD8NR5dtAFp4f6sBxR+N/b/f
         5RRXvMlMMyZyx86PmQxEgukWzy4ELCFpYxe8bAA2eFJqWeV5p7+c9x6hTTfSP3KfAYDc
         8N4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpTv/12BexLRMkdmNuBYhgaR0lqmsjILLUp0H+mO97cg+UWucM/8mfaN/kCbpbB/8/Skbt7rw8ehwkaODqRg5WrFvA+9GFsMOJvMUaW3kGeS4ZcFI6kW7SKb8cuAdL3S0xYhpUd5Gef5236oRxX7qOPfOfV9Bz5tEdXQ==
X-Gm-Message-State: AOJu0YyLRERypBKnGGg2zJLl4j4+Q3qmTKQOKOxLu8ggNGkTfPSbe5T/
	6ryNgryFdrP7srFhawVLCgm9GqubotQhMxQlgIauDdcNuzdMxOjA
X-Google-Smtp-Source: AGHT+IH9N9oxY53zP8QTt5y/XprisO8MFH32Z0u3yvJrevbkHXIKKbuJO+7pbjLm75UmPLEdWjGoQQ==
X-Received: by 2002:a05:6512:3c9e:b0:52e:9619:e26a with SMTP id 2adb3069b0e04-530e5844362mr2507786e87.26.1723149776749;
        Thu, 08 Aug 2024 13:42:56 -0700 (PDT)
Received: from mobilestation ([95.79.225.241])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530de481f4esm751928e87.287.2024.08.08.13.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 13:42:56 -0700 (PDT)
Date: Thu, 8 Aug 2024 23:42:53 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrew Halaney <ahalaney@redhat.com>, bpf@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jose Abreu <joabreu@synopsys.com>, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Sneh Shah <quic_snehshah@quicinc.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH RFC net-next v4 00/14] net: stmmac: convert stmmac "pcs"
 to phylink
Message-ID: <d3yg5ammwevvcgs3zsy2fdvc45pce5ma2yujz7z2wp3vvpaim6@wgh6bb27c5tb>
References: <ZrCoQZKo74zvKMhT@shell.armlinux.org.uk>
 <rq2wbrm2q3bizgxcnl6kmdiycpldjl6rllsqqgpzfhsfodnd3o@ymdfbxq2gj5j>
 <ZrM8g5KoaBi5L00b@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrM8g5KoaBi5L00b@shell.armlinux.org.uk>

On Wed, Aug 07, 2024 at 10:21:07AM +0100, Russell King (Oracle) wrote:
> On Tue, Aug 06, 2024 at 09:56:04PM +0300, Serge Semin wrote:
> > Hi Russell
> > 
> > Got this series tested on my DW GMAC v3.73a + Micrel KSZ9031RNX PHY
> > with the in-band link status management enabled. The same positive result
> > as before, on v1-v2:
> > [  294.651324] stmmaceth 1f060000.ethernet eth1: configuring for inband/rgmii-rxid link mode
> > [  294.582498] stmmaceth 1f060000.ethernet eth1: Register MEM_TYPE_PAGE_POOL RxQ-0
> > [  294.594308] stmmaceth 1f060000.ethernet eth1: PHY [stmmac-1:03] driver [RTL8211E Gigabit Ethernet] (irq=POLL)
> > [  294.605453] dwmac1000: Master AXI performs any burst length
> > [  294.611899] stmmaceth 1f060000.ethernet: invalid port speed
> > [  294.618229] stmmaceth 1f060000.ethernet eth1: No Safety Features support found
> > [  294.626412] stmmaceth 1f060000.ethernet eth1: No MAC Management Counters available
> > [  294.634912] stmmaceth 1f060000.ethernet eth1: IEEE 1588-2008 Advanced Timestamp supported
> > [  294.644380] stmmaceth 1f060000.ethernet eth1: registered PTP clock
> > [  294.651324] stmmaceth 1f060000.ethernet eth1: configuring for inband/rgmii-rxid link mode
> > ...
> > [  298.772917] stmmaceth 1f060000.ethernet eth1: Link is Up - 1Gbps/Full - flow control rx/tx
> > 
> > So feel free to add:
> > Tested-by: Serge Semin <fancer.lancer@gmail.com>
> 
> Thanks.
> 
> > Please note the warning: "stmmaceth 1f060000.ethernet: invalid port
> > speed" in the log above. This is a false negative warning since my
> > network devices isn't of MAC2MAC-type and there is no snps,ps-speed
> > property in my dts. So having the priv->hw.ps set to zero should be
> > fine. That said I guess we need to add the warning fix to the 14/14
> > patch which would permit the plat_stmmacenet_data::mac_port_sel_speed
> > field being zero.
> 

> I think this is a separate issue - one which exists even today with
> the stmmac driver as this code hasn't changed. Maybe it should be a
> separate patch targetting the net tree?

Ok. Tomorrow I'll submit the patch fixing that case.

> 
> > > Previous cover messages from earlier posts below:
> > > 
> > > This is version 3 of the series switching stmmac to use phylink PCS
> > > isntead of going behind phylink's back.
> > > 
> > > Changes since version 2:
> > > - Adopted some of Serge's feedback.
> > > - New patch: adding ethqos_pcs_set_inband() for qcom-ethqos so we
> > >   have one place to modify for AN control rather than many.
> > > - New patch: pass the stmmac_priv structure into the pcs_set_ane()
> > >   method.
> > > - New patch: remove pcs_get_adv_lp() early, as this is only for TBI
> > >   and RTBI, support for which we dropped in an already merged patch.
> > > - Provide stmmac_pcs structure to encapsulate the pointer to
> > >   stmmac_priv, PCS MMIO address pointer and phylink_pcs structure.
> > > - Restructure dwmac_pcs_config() so we can eventually share code
> > >   with dwmac_ctrl_ane().
> > > - New patch: move dwmac_ctrl_ane() into stmmac_pcs.c, and share code.
> > > - New patch: pass the stmmac_pcs structure into dwmac_pcs_isr().
> > > - New patch: similar to Serge's patch, rename the PCS registers, but
> > >   use STMMAC_PCS_ as the prefix rather than just PCS_ which is too
> > >   generic.
> > > - New patch: incorporate "net: stmmac: Activate Inband/PCS flag
> > >   based on the selected iface" from Serge.
> > > 
> > > On the subject of whether we should have two PCS instances, I
> > > experimented with that and have now decided against it. Instead,
> > > dwmac_pcs_config() now tests whether we need to fiddle with the
> > > PCS control register or not.
> > > 
> > 
> > > Note that I prefer not to have multiple layers of indirection, but
> > > instead prefer a library-style approach, which is why I haven't
> > > turned the PCS support into something that's self contained with
> > > a method in the MAC driver to grab the RGSMII status.
> > 
> > I understand the reason of your choice in this case. As a result a
> > some part of my changes haven't been merged in into your series. But I
> > deliberately selected the approach with having the simple PCS
> > HW-interface callbacks utilized for a self-contained internal PCS
> > implementation. Here is why:
> > 1. Signify that the DW GMAC and DW QoS Eth internal PCSs are the
> > same.
> > 2. Reduce the amount of code.
> > 3. Collects the entire PCS implementation in a single place which
> > improves the code readability.
> > 4. The PCS ops initialization is implemented in the same way as the
> > PTP, MMC and EST (and likely FPE in some time in future), in the
> > hwif.c and the interface/core callbacks in the dedicated files
> > (stmmac_ptp.c, mmc_core.c, stmmac_est.c, etc). So the PCS
> > implementation would be in general unified with what has been done for
> > PTP/MMC/EST/etc. 
> > 5. ...
> > 
> > Taking that into account I am still convinced that my approach worth
> > to be implemented. Hope you won't mind, if after your series is merged
> > in I'll submit another patch set which would introduce some of my
> > PCS-changes not included into your patch set. Like this:
> > 1. Move the mac_device_info instance to being defined in the
> > stmmac_priv structure (new patch, so to drop the stmmac_priv pointer
> > from stmmac_pcs).
> > 2. Introduce stmmac_priv::pcsaddr (to have the PCS CSR base address
> > defined in the same way as for PTP/MMC/EST/etc).
> > 3. Provide the HWIF ops:
> >    stmmac_pcs_ops {
> >         pcs_get_config_reg;
> >         pcs_enable_irq;
> >         pcs_disable_irq;
> >    } for DW GMAC and DW QoS Eth.
> > 4. Move PCS implementation to stmmac_pcs.c
> > 5. Direct using the plat_stmmacenet_data::mac_port_sel_speed field
> > instead of the mac_device_info::ps.
> > 6. Some more cleanups like converting the struct stmmac_hwif_entry
> > field from void-pointers to the typed-pointers, ...
> 

> I guessed that you would dig your heals in over this, and want to do
> it your own way despite all the points I raised against your patch
> series on my previous posting arguing against much of this.
> 
> So, at this point I give up with this patch series - clearly there is
> no room for discussion about the way forward, and you want to do it
> your way no matter what.

I actually thought that in general the approach implemented in my
patches didn't meet much dislikes from your side. Just several notes
which could be easily fixed in the next revisions.

Anyway thanks for understanding. I'll wait for your series to be
merged in. Then I'll submit my patch set based on top of it (of course
taking into account all the notes raised by you back then).

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

