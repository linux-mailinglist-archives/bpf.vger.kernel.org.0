Return-Path: <bpf+bounces-68062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AAEB5245F
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 01:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95BB8583814
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 23:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514D0262FD4;
	Wed, 10 Sep 2025 23:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ehZy0YEK"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C62B1FF1B4;
	Wed, 10 Sep 2025 23:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757545331; cv=none; b=WdplIssKdA2UQ/ddAnMMazfzpgIQQ3NnDuXrJPXs0ccfxbY9HYcA4fOXQUJMFe9yMTDyFwKRSKzvDyXlAA4kSzje1b0XWWrKEK34SF1kiAGTbkyPj227O6+uTZxT5euDgQqBHiza0SQEg5wSCy8NwHSsnCOMcnVSLiutX0rH//8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757545331; c=relaxed/simple;
	bh=fXw0sOIXO190DVV0LITaCvmeQ5uPLWDO3uc8erLTZ4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ampzn1MXdjHF0kU9NRRPTTijop8SvIehK1Vme4jos5JD76YDSAbdqu/Q8TG3yk4sXE8AEZgLJE1J04PEqCFFLi4BOWXIgC8I1nyJpn5Chuc4kY573z/muAiigDrfANc4rAcVGuOOQgPVeKIjsTbkuyqvHy9qGRXv7X6Ue1+6AQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ehZy0YEK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XfBP9bG2tl0NXE5ziSY+fRi8/aEFKp1uutR7MpEd4G0=; b=ehZy0YEK3SoZWMNLnS8hKW++R6
	pi9lEWn+q4alBozXX1FaURdClBIU4Z5Ux1mM46qU7Q+NYXL5Pj+sl0js1xL/1xetnjETmOEYWD/Qf
	qodDqbNGiam30JDn0x1DQu2TwRw+I9IKEfiIKyRHGjHYxiu6TEjJkch4izOOutaDK6F768vBcrBjz
	yK88UxY5COOJzzRn/yty70Dmj2AEHm469DSqzf5nDtUAh9/R6XDv6vF0ITiNv8+zXSebv/nhZnUan
	I5xsrDBuQxLw/zChwYSGWrbK7fLtYxo6bpFvE8h48p9mNX4RfK1tlpIqZgBm7wRRKrKx4/4ZNOJ5B
	C7KeTHFw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56228)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uwTpC-000000002E4-1Vz1;
	Thu, 11 Sep 2025 00:02:02 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uwTp7-000000001lV-0Zix;
	Thu, 11 Sep 2025 00:01:57 +0100
Date: Thu, 11 Sep 2025 00:01:56 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [Linux-stm32] [PATCH net-next 08/11] net: stmmac: rename
 stmmac_init_ptp()
Message-ID: <aMIDZE0mLHAa5pdr@shell.armlinux.org.uk>
References: <aMBaCga5UAXT03Bi@shell.armlinux.org.uk>
 <E1uw1Vk-00000004MCX-38Zs@rmk-PC.armlinux.org.uk>
 <94e20b19-eb89-43c1-9a7c-3a529c60be8b@foss.st.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94e20b19-eb89-43c1-9a7c-3a529c60be8b@foss.st.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Sep 10, 2025 at 04:42:18PM +0200, Gatien CHEVALLIER wrote:
> 
> 
> On 9/9/25 18:48, Russell King (Oracle) wrote:
> > In preparation to cleaning up the (re-)initialisation of timestamping,
> > rename the existing stmmac_init_ptp() to stmmac_init_timestamping()
> > which better reflects its functionality.
> > 
> 
> I agree it's mostly about time stamping but if the ptp_clk_freq_config()
> ops is implemented, then it's not only about timestamping. Wasn't it
> fine as is?

No, if you look at the history, various bits of PTP initialisation
have had to be moved out of stmmac_init_ptp() due to various problems,
and this includes initialisation of the TAI timekeeping block block
(or what we call ptp_clock in the kernel.) It's become less about
initialising the entire PTP subsystem, more about just the time-
stamping part.

So, the rename is justified, even though there's still bits in there
that need to be re-architected.

However, continuing to call it "init_ptp" when it doesn't initialise
all of PTP, especially as the patches after this adds another function
that _does_ to the full initialisation just doesn't make sense - in
fact, it becomes down-right confusing.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

