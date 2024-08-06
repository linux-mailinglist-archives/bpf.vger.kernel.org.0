Return-Path: <bpf+bounces-36487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB379497C8
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 20:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F68DB220AA
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 18:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31BF7EEFD;
	Tue,  6 Aug 2024 18:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUdXpiVZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312448F77;
	Tue,  6 Aug 2024 18:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722970573; cv=none; b=ER4lE0bLUGZp0Kt8OqcradNLrUA2L6cuALkdhuT3VncjbL24ecE0zLdFrHRMmsbvWwzINmz+ze7rZ1afJF96JsNdh3fVPmUo3gOEGtIC5IU1hF3ix6meG8Hvi8nrJXyLh8D7vTx/5/BQEHXxrlzStSI+2WaGgRcufC+AwEhisR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722970573; c=relaxed/simple;
	bh=THNYFhk/xMl+vqWgBJbr90t5dkzSKwtKiudHlGJQB8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1gJF7H+lT+QnEckNoSSHh2hwLsrkIxHQpPHxQ+f74S+VgwJgdrkty0X8chlTVdjH+G+RYh0906c5DzzSnQhMv1LMODAjt7HP+nxilB5GBxkfanel7ffxCHM+hCCvw0qyQ6IBnakyYH+vMogSgZrErwNBNnNSpN6vE3nx8/PM3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUdXpiVZ; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f032cb782dso9113991fa.3;
        Tue, 06 Aug 2024 11:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722970569; x=1723575369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pf9/0bfQnePOOTaXBk6YMsUHrh8Q8JuFZwwu+99uXH4=;
        b=jUdXpiVZVNN/ya4cntwMQ8mF+eVrSX4OEXX/I48vO/Dd9ADsbBMgfw85osWgTcUajz
         YPhwri5O9lBGrjKn64k5AI2asWqywYnu066pBxraSaO8u8jfBzLhpZooDB327tm479S1
         uuvTu0ucjBKVA7gaFGTkT0Wh7hRMr9GSR8+wWgq87P3hMCtDsdeq1zyi1AaerPJg4C8i
         4xmGumgPTeNbZihl0qZHyYdO1jTyz+7LyqMph4TIlkGlsuAbz4gp9eysJF5wHGTgjmUU
         B5XHO1cRtWBcqO/Z59UmZrXVzkmEczqwoGdz/7r2cgRm/tngBmngo/K2eD6wvMFzi/6M
         ezEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722970569; x=1723575369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pf9/0bfQnePOOTaXBk6YMsUHrh8Q8JuFZwwu+99uXH4=;
        b=MfftDmULGUujuoZLeyUsh3kvKWU41/oSYf2tJxyQjx+nSStwIS4TSeF24pNQiwHo+O
         0Ks565tY37AnOiK0U3o4YZ08otcrJOKBxqwvopHKhSd5bcP8FHb/z2miWKMuuvCCSVuF
         jf9h4RZ0wzpBKRfbkCOUy+FUnDGPa033kuFDmztL2k8fCG17k+cmEth2j4AB1OH/cLps
         kAM4yeqKQD8bB643E4WrAADwa6NF0m9VLoFBaeig7cLDi0nkfAPWf94F+CTb4YNa0dP3
         uWSaExXj95w2jw6UQHHlmvoc4SK3nBhIs2rM994qC4FAcG3OLFa2GFRRdcJIQrPWPwTh
         4qjQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1bG6DH/HJBpuyhKdijlosgmiCeocJnarm02twrXSwXBAyV7MDz1wQxWsy+4VyZIUcsRdyan8E0pqDVE96KJYd2oM6mLTRn+4XQsj2EtgYF9MRimmFlpRHgLXcd0ILuX6Xp0GBXOZyMS3o8axClSxpIF8NInciOa9BqQ==
X-Gm-Message-State: AOJu0YxTRp1JCME2G1Sl4bnqNXoGZQG0FhbqxGCQ9XyDOB+kpN/RfTPr
	gYian136xDx9pk9NBo4OLjUWo789XiUyyfbhPwn+iukJHw3kmu7L
X-Google-Smtp-Source: AGHT+IE4j3d2MbABxSDMFiENvEQ+bNAsQAZt/hODsl/X0IxURgYF6oPEul6YrvfjSgyayvsvcJx8vg==
X-Received: by 2002:a05:651c:218:b0:2ef:2608:2e47 with SMTP id 38308e7fff4ca-2f15aa92e41mr117683181fa.13.1722970568665;
        Tue, 06 Aug 2024 11:56:08 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e187584sm15388571fa.4.2024.08.06.11.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 11:56:07 -0700 (PDT)
Date: Tue, 6 Aug 2024 21:56:04 +0300
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
Message-ID: <rq2wbrm2q3bizgxcnl6kmdiycpldjl6rllsqqgpzfhsfodnd3o@ymdfbxq2gj5j>
References: <ZrCoQZKo74zvKMhT@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrCoQZKo74zvKMhT@shell.armlinux.org.uk>

Hi Russell

On Mon, Aug 05, 2024 at 11:24:01AM +0100, Russell King (Oracle) wrote:
> Hi,
> 
> Changes since version 3:
> - added Andrew's reviewed-bys
> - fixed kernel-doc for dwmac_pcs_isr()
> - updated patch 11 commit message
> - fixed build error reported by Jakub
> - add Sneh Shah to Cc list (for testing 2.5G modes)
> 
> Bartosz - I know you've given your tested-by this morning, I will be
> adding that after posting this series, so please don't think it's been
> lost!

Got this series tested on my DW GMAC v3.73a + Micrel KSZ9031RNX PHY
with the in-band link status management enabled. The same positive result
as before, on v1-v2:
[  294.651324] stmmaceth 1f060000.ethernet eth1: configuring for inband/rgmii-rxid link mode
[  294.582498] stmmaceth 1f060000.ethernet eth1: Register MEM_TYPE_PAGE_POOL RxQ-0
[  294.594308] stmmaceth 1f060000.ethernet eth1: PHY [stmmac-1:03] driver [RTL8211E Gigabit Ethernet] (irq=POLL)
[  294.605453] dwmac1000: Master AXI performs any burst length
[  294.611899] stmmaceth 1f060000.ethernet: invalid port speed
[  294.618229] stmmaceth 1f060000.ethernet eth1: No Safety Features support found
[  294.626412] stmmaceth 1f060000.ethernet eth1: No MAC Management Counters available
[  294.634912] stmmaceth 1f060000.ethernet eth1: IEEE 1588-2008 Advanced Timestamp supported
[  294.644380] stmmaceth 1f060000.ethernet eth1: registered PTP clock
[  294.651324] stmmaceth 1f060000.ethernet eth1: configuring for inband/rgmii-rxid link mode
...
[  298.772917] stmmaceth 1f060000.ethernet eth1: Link is Up - 1Gbps/Full - flow control rx/tx

So feel free to add:
Tested-by: Serge Semin <fancer.lancer@gmail.com>

Please note the warning: "stmmaceth 1f060000.ethernet: invalid port
speed" in the log above. This is a false negative warning since my
network devices isn't of MAC2MAC-type and there is no snps,ps-speed
property in my dts. So having the priv->hw.ps set to zero should be
fine. That said I guess we need to add the warning fix to the 14/14
patch which would permit the plat_stmmacenet_data::mac_port_sel_speed
field being zero.

> 
> Previous cover messages from earlier posts below:
> 
> This is version 3 of the series switching stmmac to use phylink PCS
> isntead of going behind phylink's back.
> 
> Changes since version 2:
> - Adopted some of Serge's feedback.
> - New patch: adding ethqos_pcs_set_inband() for qcom-ethqos so we
>   have one place to modify for AN control rather than many.
> - New patch: pass the stmmac_priv structure into the pcs_set_ane()
>   method.
> - New patch: remove pcs_get_adv_lp() early, as this is only for TBI
>   and RTBI, support for which we dropped in an already merged patch.
> - Provide stmmac_pcs structure to encapsulate the pointer to
>   stmmac_priv, PCS MMIO address pointer and phylink_pcs structure.
> - Restructure dwmac_pcs_config() so we can eventually share code
>   with dwmac_ctrl_ane().
> - New patch: move dwmac_ctrl_ane() into stmmac_pcs.c, and share code.
> - New patch: pass the stmmac_pcs structure into dwmac_pcs_isr().
> - New patch: similar to Serge's patch, rename the PCS registers, but
>   use STMMAC_PCS_ as the prefix rather than just PCS_ which is too
>   generic.
> - New patch: incorporate "net: stmmac: Activate Inband/PCS flag
>   based on the selected iface" from Serge.
> 
> On the subject of whether we should have two PCS instances, I
> experimented with that and have now decided against it. Instead,
> dwmac_pcs_config() now tests whether we need to fiddle with the
> PCS control register or not.
> 

> Note that I prefer not to have multiple layers of indirection, but
> instead prefer a library-style approach, which is why I haven't
> turned the PCS support into something that's self contained with
> a method in the MAC driver to grab the RGSMII status.

I understand the reason of your choice in this case. As a result a
some part of my changes haven't been merged in into your series. But I
deliberately selected the approach with having the simple PCS
HW-interface callbacks utilized for a self-contained internal PCS
implementation. Here is why:
1. Signify that the DW GMAC and DW QoS Eth internal PCSs are the
same.
2. Reduce the amount of code.
3. Collects the entire PCS implementation in a single place which
improves the code readability.
4. The PCS ops initialization is implemented in the same way as the
PTP, MMC and EST (and likely FPE in some time in future), in the
hwif.c and the interface/core callbacks in the dedicated files
(stmmac_ptp.c, mmc_core.c, stmmac_est.c, etc). So the PCS
implementation would be in general unified with what has been done for
PTP/MMC/EST/etc. 
5. ...

Taking that into account I am still convinced that my approach worth
to be implemented. Hope you won't mind, if after your series is merged
in I'll submit another patch set which would introduce some of my
PCS-changes not included into your patch set. Like this:
1. Move the mac_device_info instance to being defined in the
stmmac_priv structure (new patch, so to drop the stmmac_priv pointer
from stmmac_pcs).
2. Introduce stmmac_priv::pcsaddr (to have the PCS CSR base address
defined in the same way as for PTP/MMC/EST/etc).
3. Provide the HWIF ops:
   stmmac_pcs_ops {
        pcs_get_config_reg;
        pcs_enable_irq;
        pcs_disable_irq;
   } for DW GMAC and DW QoS Eth.
4. Move PCS implementation to stmmac_pcs.c
5. Direct using the plat_stmmacenet_data::mac_port_sel_speed field
instead of the mac_device_info::ps.
6. Some more cleanups like converting the struct stmmac_hwif_entry
field from void-pointers to the typed-pointers, ...

-Serge(y)

> 
> -----
> 
> This is version 2 of the series switching stmmac to use phylink PCS
> instead of going behind phylink's back.
> 
> Changes since version 1:
> - Addition of patches from Serge Semin to allow RGMII to use the
>   "PCS" code even if priv->dma_cap.pcs is not set (including tweaks
>   by me.)
> - Restructuring of the patch set to be a more logical split.
> - Leave the pcs_ctrl_ane methods until we've worked out what to do
>   with the qcom-ethqos driver (this series may still end up breaking
>   it, but at least we will now successfully compile.)
> 
> A reminder that what I want to hear from this patch set are the results
> of testing - and thanks to Serge, the RGMII paths were exercised, but
> I have not had any results for the SGMII side of this.
> 
> There are still a bunch of outstanding questions:
> 
> - whether we should be using two separate PCS instances, one for
>   RGMII and another for SGMII. If the PCS hardware is not present,
>   but are using RGMII mode, then we probably don't want to be
>   accessing the registers that would've been there for SGMII.
> - what the three interrupts associated with the PCS code actually
>   mean when they fire.
> - which block's status we're reading in the pcs_get_state() method,
>   and whether we should be reading that for both RGMII and SGMII.
> - whether we need to activate phylink's inband mode in more cases
>   (so that the PCS/MAC status gets read and used for the link.)
> 
> There's probably more questions to be asked... but really the critical
> thing is to shake out any breakage from making this conversion. Bear
> in mind that I have little knowledge of this hardware, so this
> conversion has been done somewhat blind using only what I can observe
> from the current driver.
> 
> ------
> 
> As I noted recently in a thread (and was ignored) stmmac sucks. (I
> won't hide my distain for drivers that make my life as phylink
> maintainer more difficult!)
> 
> One of the contract conditions for using phylink is that the driver
> will _not_ mess with the netif carrier. stmmac developers/maintainers
> clearly didn't read that, because stmmac messes with the netif
> carrier, which destroys phylink's guarantee that it'll make certain
> calls in a particular order (e.g. it won't call mac_link_up() twice
> in a row without an intervening mac_link_down().) This is clearly
> stated in the phylink documentation.
> 
> Thus, this patch set attempts to fix this. Why does it mess with the
> netif carrier? It has its own independent PCS implementation that
> completely bypasses phylink _while_ phylink is still being used.
> This is not acceptable. Either the driver uses phylink, or it doesn't
> use phylink. There is no half-way house about this. Therefore, this
> driver needs to either be fixed, or needs to stop using phylink.
> 
> Since I was ignored when I brought this up, I've hacked together the
> following patch set - and it is hacky at the moment. It's also broken
> because of recentl changes involving dwmac-qcom-ethqos.c - but there
> isn't sufficient information in the driver for me to fix this. The
> driver appears to use SGMII at 2500Mbps, which simply does not exist.
> What interface mode (and neg_mode) does phylink pass to pcs_config()
> in each of the speeds that dwmac-qcom-ethqos.c is interested in.
> Without this information, I can't do that conversion. So for the
> purposes of this, I've just ignored dwmac-qcom-ethqos.c (which means
> it will fail to build.)
> 
> The patch splitup is not ideal, but that's not what I'm interested in
> here. What I want to hear is the results of testing - does this switch
> of the RGMII/SGMII "pcs" stuff to a phylink_pcs work for this driver?
> 
> Please don't review the patches, but you are welcome to send fixes to
> them. Once we know that the overall implementation works, then I'll
> look at how best to split the patches. In the mean time, the present
> form is more convenient for making changes and fixing things.
> 
> There is still more improvement that's needed here.
> 
> Thanks.
> 
>  drivers/net/ethernet/stmicro/stmmac/Makefile       |   2 +-
>  drivers/net/ethernet/stmicro/stmmac/common.h       |  25 ++--
>  .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    |  13 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac1000.h    |  13 +-
>  .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   | 110 +++++++-------
>  drivers/net/ethernet/stmicro/stmmac/dwmac4.h       |  13 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |  99 +++++++------
>  drivers/net/ethernet/stmicro/stmmac/hwif.h         |  24 ++--
>  .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   | 111 +-------------
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  30 +---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c   |  63 ++++++++
>  drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h   | 160 ++++++++++-----------
>  12 files changed, 306 insertions(+), 357 deletions(-)
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

