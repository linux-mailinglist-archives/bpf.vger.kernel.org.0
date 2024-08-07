Return-Path: <bpf+bounces-36539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1779B94A443
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 11:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1282B29CCB
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 09:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638B21D1738;
	Wed,  7 Aug 2024 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ruz/HlMf"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A1D811E2;
	Wed,  7 Aug 2024 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723022485; cv=none; b=CDdo9awRC1li5wJlPh1YaLQd8cx/4x/gTrwd0MvWJn94s7YKg0bI/FBuL4nPn5ymGjfQxX3ozt5h7o0oGD5wLWyzAt0wAjl8Y/uYuKQA2uwzdw+r1OX/QdjwHbMe9WU0xoLUJhdmXC6cdyi4re1GL/QdzM833ocX8+xYV1qb4aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723022485; c=relaxed/simple;
	bh=1PARSFOj65zj7l+TTRB9rEeci9uaa8EB/eDQlYX4Dbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huTopYgpnQYy+BPloCKwIifVbF4S0aS3Gz4Ys53rRMWqg2EuzUuyyScXBZxT84ol8WvKsCeKA1Y0AfVvR9rUgGM5HCjCTYhkbS1b+CsuPo/35OUuctUoOgIlXx3mInO+wyAxzV7jHui0eFO6p0HiDhGNlyvtIzrqzbym7r3NHCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ruz/HlMf; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/S2HbQbKCvoRKCalpj7tukbXlDtRqceNWh29Ov9kqRk=; b=ruz/HlMfGDxAGOSawPrT7yXv4W
	7+OT/Zhroaw41ZQ+0L/8PWuUHylYAShBLlxvdDIzMT32/00eQTmhogBZslu0y9WcSvg9KWSVf6V1J
	GXJHSC0u23FsYJS8xMihPElo0G9+x5JgPYIi3XJJg6i57akXi2lSLXDw2Chv/Q0E4aOfPB884PMS6
	QyyAyffINECZOlZ08gFB3lRrOV5fwctcsIxIsaCWY+CIR0qpUxaVQdBC6dK9VMka16x2fKXgaKRqh
	5o6NHZp0pMu3SgQ5mcLpo8jFH4MezpsJHN6FL8EAvm3l2leojTLM0jFuo3GQ2/s5ef0J3cvNNDfKm
	kFAUVsGg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51116)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sbcqx-0006km-0V;
	Wed, 07 Aug 2024 10:21:07 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sbcqx-0004Bw-NV; Wed, 07 Aug 2024 10:21:07 +0100
Date: Wed, 7 Aug 2024 10:21:07 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Halaney <ahalaney@redhat.com>, bpf@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sneh Shah <quic_snehshah@quicinc.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH RFC net-next v4 00/14] net: stmmac: convert stmmac "pcs"
 to phylink
Message-ID: <ZrM8g5KoaBi5L00b@shell.armlinux.org.uk>
References: <ZrCoQZKo74zvKMhT@shell.armlinux.org.uk>
 <rq2wbrm2q3bizgxcnl6kmdiycpldjl6rllsqqgpzfhsfodnd3o@ymdfbxq2gj5j>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rq2wbrm2q3bizgxcnl6kmdiycpldjl6rllsqqgpzfhsfodnd3o@ymdfbxq2gj5j>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Aug 06, 2024 at 09:56:04PM +0300, Serge Semin wrote:
> Hi Russell
> 
> Got this series tested on my DW GMAC v3.73a + Micrel KSZ9031RNX PHY
> with the in-band link status management enabled. The same positive result
> as before, on v1-v2:
> [  294.651324] stmmaceth 1f060000.ethernet eth1: configuring for inband/rgmii-rxid link mode
> [  294.582498] stmmaceth 1f060000.ethernet eth1: Register MEM_TYPE_PAGE_POOL RxQ-0
> [  294.594308] stmmaceth 1f060000.ethernet eth1: PHY [stmmac-1:03] driver [RTL8211E Gigabit Ethernet] (irq=POLL)
> [  294.605453] dwmac1000: Master AXI performs any burst length
> [  294.611899] stmmaceth 1f060000.ethernet: invalid port speed
> [  294.618229] stmmaceth 1f060000.ethernet eth1: No Safety Features support found
> [  294.626412] stmmaceth 1f060000.ethernet eth1: No MAC Management Counters available
> [  294.634912] stmmaceth 1f060000.ethernet eth1: IEEE 1588-2008 Advanced Timestamp supported
> [  294.644380] stmmaceth 1f060000.ethernet eth1: registered PTP clock
> [  294.651324] stmmaceth 1f060000.ethernet eth1: configuring for inband/rgmii-rxid link mode
> ...
> [  298.772917] stmmaceth 1f060000.ethernet eth1: Link is Up - 1Gbps/Full - flow control rx/tx
> 
> So feel free to add:
> Tested-by: Serge Semin <fancer.lancer@gmail.com>

Thanks.

> Please note the warning: "stmmaceth 1f060000.ethernet: invalid port
> speed" in the log above. This is a false negative warning since my
> network devices isn't of MAC2MAC-type and there is no snps,ps-speed
> property in my dts. So having the priv->hw.ps set to zero should be
> fine. That said I guess we need to add the warning fix to the 14/14
> patch which would permit the plat_stmmacenet_data::mac_port_sel_speed
> field being zero.

I think this is a separate issue - one which exists even today with
the stmmac driver as this code hasn't changed. Maybe it should be a
separate patch targetting the net tree?

> > Previous cover messages from earlier posts below:
> > 
> > This is version 3 of the series switching stmmac to use phylink PCS
> > isntead of going behind phylink's back.
> > 
> > Changes since version 2:
> > - Adopted some of Serge's feedback.
> > - New patch: adding ethqos_pcs_set_inband() for qcom-ethqos so we
> >   have one place to modify for AN control rather than many.
> > - New patch: pass the stmmac_priv structure into the pcs_set_ane()
> >   method.
> > - New patch: remove pcs_get_adv_lp() early, as this is only for TBI
> >   and RTBI, support for which we dropped in an already merged patch.
> > - Provide stmmac_pcs structure to encapsulate the pointer to
> >   stmmac_priv, PCS MMIO address pointer and phylink_pcs structure.
> > - Restructure dwmac_pcs_config() so we can eventually share code
> >   with dwmac_ctrl_ane().
> > - New patch: move dwmac_ctrl_ane() into stmmac_pcs.c, and share code.
> > - New patch: pass the stmmac_pcs structure into dwmac_pcs_isr().
> > - New patch: similar to Serge's patch, rename the PCS registers, but
> >   use STMMAC_PCS_ as the prefix rather than just PCS_ which is too
> >   generic.
> > - New patch: incorporate "net: stmmac: Activate Inband/PCS flag
> >   based on the selected iface" from Serge.
> > 
> > On the subject of whether we should have two PCS instances, I
> > experimented with that and have now decided against it. Instead,
> > dwmac_pcs_config() now tests whether we need to fiddle with the
> > PCS control register or not.
> > 
> 
> > Note that I prefer not to have multiple layers of indirection, but
> > instead prefer a library-style approach, which is why I haven't
> > turned the PCS support into something that's self contained with
> > a method in the MAC driver to grab the RGSMII status.
> 
> I understand the reason of your choice in this case. As a result a
> some part of my changes haven't been merged in into your series. But I
> deliberately selected the approach with having the simple PCS
> HW-interface callbacks utilized for a self-contained internal PCS
> implementation. Here is why:
> 1. Signify that the DW GMAC and DW QoS Eth internal PCSs are the
> same.
> 2. Reduce the amount of code.
> 3. Collects the entire PCS implementation in a single place which
> improves the code readability.
> 4. The PCS ops initialization is implemented in the same way as the
> PTP, MMC and EST (and likely FPE in some time in future), in the
> hwif.c and the interface/core callbacks in the dedicated files
> (stmmac_ptp.c, mmc_core.c, stmmac_est.c, etc). So the PCS
> implementation would be in general unified with what has been done for
> PTP/MMC/EST/etc. 
> 5. ...
> 
> Taking that into account I am still convinced that my approach worth
> to be implemented. Hope you won't mind, if after your series is merged
> in I'll submit another patch set which would introduce some of my
> PCS-changes not included into your patch set. Like this:
> 1. Move the mac_device_info instance to being defined in the
> stmmac_priv structure (new patch, so to drop the stmmac_priv pointer
> from stmmac_pcs).
> 2. Introduce stmmac_priv::pcsaddr (to have the PCS CSR base address
> defined in the same way as for PTP/MMC/EST/etc).
> 3. Provide the HWIF ops:
>    stmmac_pcs_ops {
>         pcs_get_config_reg;
>         pcs_enable_irq;
>         pcs_disable_irq;
>    } for DW GMAC and DW QoS Eth.
> 4. Move PCS implementation to stmmac_pcs.c
> 5. Direct using the plat_stmmacenet_data::mac_port_sel_speed field
> instead of the mac_device_info::ps.
> 6. Some more cleanups like converting the struct stmmac_hwif_entry
> field from void-pointers to the typed-pointers, ...

I guessed that you would dig your heals in over this, and want to do
it your own way despite all the points I raised against your patch
series on my previous posting arguing against much of this.

So, at this point I give up with this patch series - clearly there is
no room for discussion about the way forward, and you want to do it
your way no matter what.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

