Return-Path: <bpf+bounces-29673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE838C49DD
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 01:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B8D5B21765
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 23:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4573384E0A;
	Mon, 13 May 2024 23:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAF05kRD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A47B84D07;
	Mon, 13 May 2024 23:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715641448; cv=none; b=RkLGBojIU6kuFMcp777d9HBAMqSjZaAeNLswqGXi7vzGgh7w2DhuRDK5Ki6ApnonCVObiBnx7kJYnX96VKZTZdgKmu3bqZtfnClYZSaRM7z2uQKXlm1gLJt39AAbSCdPYigIh+I0D2J4nFHiPmND+cKnVsOC9QavepXBDK5X1Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715641448; c=relaxed/simple;
	bh=uYaQZv1nDuiODzrBaiNS3RZ+HBy9W9/OJ+Cp8ybFerE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMNqjQ+8ElLABUv26UzE2ekRAxYMJkrWhhGIpUMCtkTMwDO3SK2sHtJIcdB/u1UgbZf7ICl4nQK1Qc2QtaXFswXvb9434y6eX84YiEtNnurylLJJm+esZmOpAnwsj2aL5euXe3/o8GmQrMd30DKOZsBtQkLX4vLm8369DbQfVxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAF05kRD; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52192578b95so5730029e87.2;
        Mon, 13 May 2024 16:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715641443; x=1716246243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4xY5PD/80plu8Oum5s12UE+ZfuGa9vAHIWvugychSCA=;
        b=PAF05kRDkWP0Xs9Kgwjtw4/t78sUeV1W08fg+AsEqsGFariKCoRNRnEiDgVIL4PhmD
         8mGpscEti1bLySVz8Fzw8GZ/gv9HvS4tjs9w9wmumCOlSHUS4RFGJuUU+oTsYM57JJZ8
         PnIw1VzAaLOC7x9flIz9K4s3DdY9ktLL3y8YPDhIAY2KSDKKO/hLvmg9K6aH5thlRQWg
         6QzYprOHECf/Qm8AadMr+FrTgrDk+tL6R3yEXnRQwsr1H2R/UeT2g9IucfULq9DR4+P2
         QeeDaxeikSW6qb+q2VQc6HfJlZmxegBxX5G3UulWGF0vGTrZmQUgtJzyR0aNgGYrxFzA
         mcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715641443; x=1716246243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xY5PD/80plu8Oum5s12UE+ZfuGa9vAHIWvugychSCA=;
        b=MxU3xZYUQwsdapfeeF8CWWwMcyLUborE9oVuqdjF7VQuw1wkuFOJIbcZkRAY3c2pDc
         zm0/GTwNXnIz/SIbLGQK3lKr/dDDiUZB6lXTDdod5H0ptRP/eZf9+PY7Wnl+kS0om4lc
         EzYZab3ifWwyJFUSnAM3jTxFl9Mc7zFNrXPOWH8qp1WMeQmk0VyEi9fHVDUd84n1M5/a
         WNyKFT3w+Vu59wcHkGLmDzgGcnwl3PCOHB4zvlMynDKG2Le0xk6GfUO4P/GBAjR3HIPh
         58A0OtARhCf8YZX1lNJBQvNNBs6Ma0O9V30oBIXDA0kBVxIuiUsp0I2WI+4KStVMUsSC
         lOew==
X-Forwarded-Encrypted: i=1; AJvYcCXFSIWgfSTwvK6dZZEiCmzU4miPIEwaB9FPWSWD0ju8BVQ0NrplNcs26msMu6j6NXTfvnyEeHyPqSdnF9AInXgd2iq/fM8Hjxa6GNGZ14giF9FDBvfg+TyA3v7j
X-Gm-Message-State: AOJu0YxUdSJBk9wWQfUDb3aCjwZ3dTE2sn1/oEt2XDoomdUvLFiFgWd9
	T5bY8DEid1RvU0wQrqT9TnSYUJoCCIUUIsbE4/ugofLfyi0xoIyY
X-Google-Smtp-Source: AGHT+IFFKhWpRJn2p817fOt+Wl9TNhJclHuyqCuJ0Sy/EIzuYsr2zGns6p+IViThDP2lTqh2clB10g==
X-Received: by 2002:a05:6512:6ce:b0:523:6e01:a701 with SMTP id 2adb3069b0e04-5236e01ab0amr39636e87.64.1715641443201;
        Mon, 13 May 2024 16:04:03 -0700 (PDT)
Received: from mobilestation ([95.79.182.53])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f39d2c43sm1907996e87.248.2024.05.13.16.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 16:04:02 -0700 (PDT)
Date: Tue, 14 May 2024 02:04:00 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jose Abreu <joabreu@synopsys.com>, 
	linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC 0/6] net: stmmac: convert stmmac "pcs" to phylink
Message-ID: <y2iz5uhcj5xh3dtpg3rnxap4qgvmgavzkf6qd7c2vqysmll3yx@drhs7upgpojz>
References: <ZkDuJAx7atDXjf5m@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkDuJAx7atDXjf5m@shell.armlinux.org.uk>

Hi Russell

On Sun, May 12, 2024 at 05:28:20PM +0100, Russell King (Oracle) wrote:
> Hi,
> 

> As I noted recently in a thread (and was ignored)

Sorry about that. I didn't mean to ignore. Your message reached me
right when I caught a cold, which made me AFK for the rest of the
week.(

> As I noted recently in a thread (and was ignored) stmmac sucks.

Can't argue with that. There are much more aspects in what it sucks
than just the netif's. One glimpse at the plat_stmmacenet_data
structure causes million questions aka why, how come, what the hell...
I'll start submitting my cleanup patch sets after my another
networking work (DW XPCS wise) is finally done, re-submitted, reviewed
and merged in.

> (I
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

Thanks for submitting the series, especially for making the RGMII
in-band status well-implemented in the driver. When I was studying the
STMMAC internals I was surprised that it wasn't actually utilized for
something useful. Furthermore at some point afterwards even the
RGSMIIIS IRQ turned to be disabled. So the RGMII-part of the code has
been completely unused after that. But even before that the RGMII
in-band status change IRQ was utilized just to print the link state
into the system log. 

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

I'll give your series a try later on this week on my DW GMAC with the
RGMII interface (alas I don't have an SGMII capable device, so can't
help with the AN-part testing). Today I've made a brief glance on it
and already noted a few places which may require a fix to make the
change working for RGMII (at least the RGSMIIIS IRQ must be got back
enabled). After making the patch set working for my device in what
form would you prefer me to submit the fixes? As incremental patches
in-reply to this thread?

-Serge(y)

> 
> There is still more improvement that's needed here.
> 
> Thanks.
> 
>  drivers/net/ethernet/stmicro/stmmac/Makefile       |   2 +-
>  drivers/net/ethernet/stmicro/stmmac/common.h       |  12 ++-
>  .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   | 113 ++++++++++++---------
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  | 108 ++++++++++++--------
>  .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |   6 --
>  drivers/net/ethernet/stmicro/stmmac/hwif.h         |  27 ++---
>  .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   | 111 +-------------------
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  19 ++--
>  drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c   |  57 +++++++++++
>  drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h   |  84 ++-------------
>  10 files changed, 227 insertions(+), 312 deletions(-)
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

