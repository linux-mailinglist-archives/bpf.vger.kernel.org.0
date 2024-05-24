Return-Path: <bpf+bounces-30551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282318CED0E
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 01:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ACD91C21283
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 23:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5EF15886C;
	Fri, 24 May 2024 23:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyFiXJw2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8DB1292E4;
	Fri, 24 May 2024 23:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716594893; cv=none; b=G42tcfohwhNtAMzWXAN0VIJPIyXScYhLtCkBV/4qpIqYXk7mIuyGo5vDZndkT4G7AbGSHiGtWpcD5WHCwyBWMK2HPIcfM5oyru4Rw3zJAixa0+0s/jv5eQHJ16ZdDvqIJZCKDGlcCDpLpv7dN5uk7q68ptItN6ceIwWpelh5d7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716594893; c=relaxed/simple;
	bh=9DnuW1gDNSGDKpcsuZLDlVt/2NqfQfe1GpK00VwMA8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mbxwbd20uqGZpMhq4mz7WYQPNeds9ETNy0p9IxWoul1axhj2FWWs8u39ydjR0G+smohMFT9IjVuJP4S/YNiGbJd+8zC5WZUo+UX2J4zK5JdpErkSpuVzepZyeOu1J1F0alZLWzsbZr5FykWb/x/J0EUhryX8MByQtLDGmAueLQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RyFiXJw2; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e95a60dfcdso17235511fa.1;
        Fri, 24 May 2024 16:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716594890; x=1717199690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C88HQP5ECIo5q+E9ZVdMutmLc/H0bpLfC6cu4zCL6Cc=;
        b=RyFiXJw2ddj/qwUW8y7QNZr0Y0nppwcrRfVYSg8e4HjJ0HiImnes9sntGDHH9+gEB5
         tsQ+bde4puckeSy70ro8QYQm00Bblssc10e6Kj48YoSAvayWPbIqtAGfoldgjDfQVRNQ
         qnPipqsnmVz/aepwyS8OPaM3lmMMf6lC4dZdRdLtDljeIyZslLC0cfgAQEsWV67LL7Dp
         A5KhBZ/zq5re1jL5ocdWCKZG83cghC83IXyZiobLa9WknmVpFuk39r5yMwK4hGj3YsNf
         JqUN+vBYSRJosCuvYvBOHxy1+8+2zkF44BMue8igE5UokW3NhKbcN3VaLA35VlCsV6q/
         mufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716594890; x=1717199690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C88HQP5ECIo5q+E9ZVdMutmLc/H0bpLfC6cu4zCL6Cc=;
        b=VzoKmSTa2Wlu6BSD0pmz4opgofIFNeARrRADMlI06gIFMHdyBxIIFR28s1a1hk4U6A
         76snWm7OMrjW07i+ziDGRvHXEgmZQ30jQxeJd6y9YVi5SsMY024PExRp9wGMWNz89ZDP
         sKJPWagNz7rXEj/C440JJCXaJlBaqoFWVEJrjTLTBXBGK+2nNFSp3PqShfL0VhmDlj/f
         lKKRd3cJDH5lE0atGul3H5Nc+DmVInR/YPEV96vRdEAVbmc89pHYr3YUQK1BFzWldr46
         Czy2pNJWmWcbupedUwtar72ygJi4ZqjwsWdcLmEtfmjxGgFCUgGmHh4/22Gfiqt46JHZ
         LLxw==
X-Forwarded-Encrypted: i=1; AJvYcCWmFvdeWZPzPOT1Ati3rPI+PcvA7R7Clrh3Eka2OWdyr8T8a39K6rvTB65wx3wWPYQTaFiCWLl/78AQ2SkhrIgB8l2s/xw2ArL3F3/7igjg8vffyiioqND+7exi
X-Gm-Message-State: AOJu0Yy8mvdn0qnObB0oFH+mR5hCL5sabSTCED+wljUsrEWeK7dzgfY6
	7d4FFN++sqDv+ILlUsBWlmgYHvBnRVzhGmoCg2qx9mh8XYrZzEGV
X-Google-Smtp-Source: AGHT+IGPDifZXrabnPpbv6zVtd/c3VSXjEPZ2PEC19yup66VheQQcXkaOsrXspa9CrV/nawuWkBEsA==
X-Received: by 2002:a05:651c:222:b0:2e6:f3af:c6aa with SMTP id 38308e7fff4ca-2e95b28aeb0mr24028551fa.40.1716594889276;
        Fri, 24 May 2024 16:54:49 -0700 (PDT)
Received: from mobilestation ([95.79.182.53])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcd7bbcsm4020781fa.32.2024.05.24.16.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 16:54:48 -0700 (PDT)
Date: Sat, 25 May 2024 02:54:46 +0300
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
Message-ID: <5c5xphkjbadimi3y3wzvv2hhlancxiwdtnikgl6pdv6jbbfmqu@tmfnjuxyygud>
References: <ZkDuJAx7atDXjf5m@shell.armlinux.org.uk>
 <y2iz5uhcj5xh3dtpg3rnxap4qgvmgavzkf6qd7c2vqysmll3yx@drhs7upgpojz>
 <ZkKghpox1r6ZqtyB@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkKghpox1r6ZqtyB@shell.armlinux.org.uk>

Hi Russell

On Tue, May 14, 2024 at 12:21:42AM +0100, Russell King (Oracle) wrote:
> On Tue, May 14, 2024 at 02:04:00AM +0300, Serge Semin wrote:
> > Hi Russell
> > 
> > I'll give your series a try later on this week on my DW GMAC with the
> > RGMII interface (alas I don't have an SGMII capable device, so can't
> > help with the AN-part testing).
> 
> Thanks!
> 
> > Today I've made a brief glance on it
> > and already noted a few places which may require a fix to make the
> > change working for RGMII (at least the RGSMIIIS IRQ must be got back
> > enabled). After making the patch set working for my device in what
> > form would you prefer me to submit the fixes? As incremental patches
> > in-reply to this thread?
> 
> I think it depends on where the issues are.
> 
> If they are addressing issues that are also present in the existing
> code, then it would make sense to get those patched as the driver
> stands today, because backporting them to stable would be easier.
> 
> If they are for "new" issues, given that this patch series is more
> or less experimental, I would prefer to roll them into these
> patches. As mentioned, when it comes to submitting these patches,
> the way I've split them wouldn't make much sense, but it does
> make sense for where I am with it. Hence, I'll want to resplit
> the series into something better for submission than it currently
> is. If you want to reply to this thread, that is fine.

I've just submitted the fixes for your series
https://lore.kernel.org/netdev/20240524210304.9164-1-fancer.lancer@gmail.com/
which make it working well on my hardware: DW GMAC v3.73 with RGMII
PHY interface connected to the Micrel KSZ9031RNX PHY. (For a lucky
coincident the PHY happen to support the link status sent in-band up
to the MAC.) So as long as the managed="in-band-status" property is
specified the PCS subsystem gets the link-status by means of the
pcs_get_state() callback. The status change is signaled by means of
the RGSMIIIS IRQ.  For that to work the Patch 2 of my series was
required (and of course Patch 1 which prevents the IRQs flood).

I'm sorry for submitting the series only today. First I had to dig
deeper into the way the RGMII In-band/PCS-block of the controller
works. Then I needed some time to study the STMMAC PCS-code and to
debug the problems fixed in my series. So I finished testing your
patchset on this Monday. Then I decided to spend sometime for making
the PCS implementation looking more optimized based on the knowledge I
gained during the debugging. But as it's normal for the STMMAC driver
(which sucks indeed) a few days wasn't enough for that, because due to
the driver being overwhelmed with duty hacks any more-or-less invasive
refactoring may lead to regressions here or there. So I stuck right at
the first step of getting the "snps,ps-speed" and the MAC2MAC mode
well implemented...(

Anyway here is the key points regarding the RGMII In-band and
PCS-interface implemented in the DW GMAC and DW QoS Eth
controllers/drivers:

1. Intermediate PCS for which the plat_stmmacenet_data::mac_interface
field and the "mac-mode" property was introduced isn't the case of the
PCS embedded into the DW GMAC and DW QoS Eth IP-cores by Synopsys.
That was some another PCS likely specific for the Altera SoC FPGA
platform (dwmac-socfpga.c).

2. RGMII: There is no any PCS-block utilized in case of the RGMII PHY
interface (that's why HWFEATURE.PCSSEL flag isn't set). The networking
controller provides a way to pick up the RGMII In-band status
delivered from the attached PHY. The in-band status is updated in the
GMAC_RGSMIIIS (DW GMAC) and in the GMAC_PHYIF_CTRLSTATUS (DW QoS Eth)
registers and signalled via the RGSMIIIS MAC IRQ.

3. SGMII: The interface implementation has a PCS-block so the
HWFEATURE.PCSSEL flag is set. But the auto-negotiation procedure
complies to the SGMII specification: no ability advertisement. SGMII
PHY sends the control information back to the MAC by means of the
tx_config_Reg[15:0] register. MAC either acknowledges the update or
not. The control information retrieved from the PHY is reflected in
the GMAC_RGSMIIIS (DW GMAC) and in the GMAC_PHYIF_CTRLSTATUS (DW QoS
Eth) registers. The only AN-related CSR available for the SGMII
interface are GMAC_AN_CTRL(x) and GMAC_AN_STATUS(x) since no
advertisement implied by the specification.

4. RGMII/SGMII/SMII: Note CSR-wise the tx_config_Reg[15:0] register
mapping is the same for all of these interfaces. It's available in the
GMAC_RGSMIIIS (DW GMAC) and in the GMAC_PHYIF_CTRLSTATUS (DW QoS Eth)
CSRs: in case of the DW GMAC it's GMAC_RGSMIIIS[0:15] bits, but in
case of DW QoS Eth it's GMAC_PHYIF_CTRLSTATUS[16:31]. (This info can
be useful to create a common dwmac_inband_pcs_get_state() method
implementation in the stmmac_pcs.c module.)

5. TBI/RTBI: It has a traditional auto-negotiation procedure fully
complying to the IEEE 802.3z C37 specification with the link abilities
advertisement. RBI/RTBI don't imply any in-band link status detection
so the GMAC_RGSMIIIS (DW GMAC) and in the GMAC_PHYIF_CTRLSTATUS (DW
QoS Eth) CSRs aren't available for these interfaces.

6. RGMII/SGMII/SMII: In order to have the Link Speed
(GMAC_CONTROL.{PS,FES}), Duplex mode (GMAC_CONTROL.DM) and Link
Up/Down bit (GMAC_CONTROL.LUD or GMAC_PHYIF_CTRLSTATUS.LUD)
transferred from MAC to the attached PHY or to another MAC via
tx_config_Reg[15:0], the GMAC_CONTROL.TC (DW GMAC) or
GMAC_PHYIF_CTRLSTATUS.TC (DW QoS Eth) flags must be set. Just a note
seeing the current PCS implementation doesn't do that even in case of
the fixed Port-select speed setup (when snps,ps-speed property is
specified).


Based on the info above I was going to extend your stmmac_pcs.c module
with the inband link status (retrieved via the tx_config_Reg[15:0])
parsing method; create more basic PCS-ops in the framework of the
dwmac1000_core.c and dwmac4_core.c modules, and the common
phylink_pcs_ops in the stmmac_main.c module using those basic PCS-ops.
But as I mentioned before I was stuck on the fixed Port-select speed
implementation. It's activated via the "snps,ps-speed" property. If
it's specified the AN_Control.SGMRAL flag will be set which makes the
SGMII interface working with a fixed speed pre-initialized in the
MAC_CONFIG.{PS,FES} fields. First of all I wasn't sure whether the
MAC2MAC functionality it's utilized for, can be applicable for
non-SGMII interface. Secondly the port speed fixing is performed
behind the phylink back. It's possible to have the speed setting being
updated later in framework of the mac_link_up() callback. So I have
some doubts that the current "snps,ps-speed"-based fixed port speed
implementation is fully correct.

That's the stage at which I decided to stop further researches and
sent my series of fixes to you.

-Serge(y)

> 
> There's still a few netif_carrier_off()/netif_carrier_on()s left
> in the driver even after this patch series, but I think they're in
> more obscure paths, but I will also want to address those as well.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

