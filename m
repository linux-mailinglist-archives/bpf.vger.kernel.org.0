Return-Path: <bpf+bounces-31067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1ED18D6976
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 21:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E5BE283A0D
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 19:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0B717C7D4;
	Fri, 31 May 2024 19:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+ie3pTd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A5F80C0C;
	Fri, 31 May 2024 19:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717182681; cv=none; b=YbtJqggsjbZ9t4EnzxtCod+nGHKZQNBYZgrA2NevxnxclDEExsJS6lhJgH086UAHmDBPUGQK87wS/ICw0dvYxIt6FwG3AjFrlQc0xnru4jni1LUkQ0EMqa5+1zAbeV9JOuUrdlYuTWLvV+SJRM+tdml/89+IKvbkEgPXIXvS+Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717182681; c=relaxed/simple;
	bh=xcumjKroYJajRLjPl3G3FFFgsaqYtkG6IGqxPPwx9Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2EJLv4GViUleDF+81LA/PP/CMDHKtGdLmiyV9paUxhA3l6NlHAiFa5PIB164bF/MST/ch+Yq4v86iG+bARVCLzTAQCFIQU43NFWrdIXKd8Xloh3GHcTlyVo93415D6+am6hMa2jm9Xq0BZtf26P3Y2kxMFPXYBBn+YZ7WQBUF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+ie3pTd; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52b80e5688aso2975423e87.0;
        Fri, 31 May 2024 12:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717182678; x=1717787478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6kslRM3yfjg/MhSNhtbfqX1X8EhzfkXqhDL01AiRjsM=;
        b=S+ie3pTdqqqS+uPstu5+KPWU6Vr5mpGwYXFLnf1pYNShEnZsGmP/WZDbLfBL7omr7N
         0DlN4LhtW3ocHneeAEyvw9KiuI0eU0LYk3eNwgf68VtYI99j9ZkE8TYo+dpU7Ebdd6+f
         W8pKsQvpNOd6k+cAv/+OlKL/VZBJojO3ENTz2gR04ZiPUWS5GDiv3oWipLmn9y1RoCrY
         DERDpAbJKg1TnEfaYZZbh18sY+aGDT5iCVoq4wt/+ZpiuUUl4omPBAX1+8dAvvL2sqGw
         q4TXTRUtcv7ri+DkfwmLNgo4ryar5rZKYwMm9sHToVuitQLYV0lviqsjE8wv74/peweE
         Onjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717182678; x=1717787478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kslRM3yfjg/MhSNhtbfqX1X8EhzfkXqhDL01AiRjsM=;
        b=WP0gtRiYKMPqMHT0zJ0nQNLpi06hQE+UvY9a71cWdEOpOQMTVc2yWkq4kF5vydbclx
         UJOQsk70KYWbnCbouM7VF8Yic4QeSf76ij+gLPjmFZPVVpUS0AeXA/cX1EpM9yR9TDck
         zb6EHhA7dPWPlU2R/p+31yqHEmtMZlH2nwplbsjR+mkTCDs/9T4Up0yjNbT5AeJszFym
         xPxyekxCMwTuzKCwYNhWINPKNFHIlp6C9krf82RUaoatYgT3PbQYKkRf/gv+59ocBAbg
         tki+bXtFs3xyfiTgrcMeqL2q/+XNV2mTV8r8zLjeBV5dqL7pd0n4s3jgROT1uIr/D9GN
         e1MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM2THC08Tx4MQK2rM4udb5sowT8oKHpIXlq0ruSMMUNrYCaGzVi5/Tork5YG9Mjs7FNwF6PxYdrSX714LHwhpn7d1r1bhAbO4F5ziXBHQvQ+Qw+TdO2WWfbOd4z1uCawsdYFYOzqlAcwCn9lEvWylVR4TtQIAsFPp0
X-Gm-Message-State: AOJu0YxgDO8txaR+BOVeQQJkhvD5Uj8xt4eOK0qmPECW6tJ1vadzqrhs
	SgiRGsVTbOnrkPR4w1T/B0x7CXefUJF5Mtnj6Hsb3lobROfjy+bH
X-Google-Smtp-Source: AGHT+IFuZ0H3DDikFSOJ4Di9tHfxiL5Q3qyxR/uNcbMu4/vbma7/yldKy8iUFEdGyAeqEMaBKsc4pw==
X-Received: by 2002:a19:ad49:0:b0:51d:9291:6945 with SMTP id 2adb3069b0e04-52b895a3e24mr2463749e87.44.1717182677389;
        Fri, 31 May 2024 12:11:17 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d8f131sm412753e87.306.2024.05.31.12.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 12:11:16 -0700 (PDT)
Date: Fri, 31 May 2024 22:11:13 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Byungho An <bh74.an@samsung.com>, Giuseppe CAVALLARO <peppe.cavallaro@st.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 2/3] net: stmmac: Activate Inband/PCS flag
 based on the selected iface
Message-ID: <bfa4porldqxhbhbvlwidslzik4mkil22trkxv5ilpk6vobcv6s@2omp37ju4dil>
References: <ZkDuJAx7atDXjf5m@shell.armlinux.org.uk>
 <20240524210304.9164-1-fancer.lancer@gmail.com>
 <20240524210304.9164-2-fancer.lancer@gmail.com>
 <ZlNoLHoHjt3BsFde@shell.armlinux.org.uk>
 <ZlN4tkY8fNM8/D8p@shell.armlinux.org.uk>
 <ukszpirecb3pwnz5bbmy7wl44ujh6t2ewrnodmrye5kjmonsz2@pgf5b2oy5n3p>
 <ZlXmjKtKozXThPFv@shell.armlinux.org.uk>
 <ZlYEmBSw3bNtf7tJ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlYEmBSw3bNtf7tJ@shell.armlinux.org.uk>

On Tue, May 28, 2024 at 05:21:44PM +0100, Russell King (Oracle) wrote:
> On Tue, May 28, 2024 at 03:13:32PM +0100, Russell King (Oracle) wrote:
> > > Alternative solution could be to use the has_gmac/has_gmac4 flags
> > > instead. That will emphasize that the embedded PCS is expected to be
> > > specific for the DW GMAC and DW QoS Eth IP-cores:
> > > 
> > >        if (phy_interface_mode_is_rgmii(interface))
> > >                priv->hw->pcs = STMMAC_PCS_RGMII;
> > >        else if ((priv->plat.has_gmac || priv->plat.has_gmac4) &&
> > > 		interface == PHY_INTERFACE_MODE_SGMII)
> > >                priv->hw->pcs = STMMAC_PCS_SGMII;
> > 
> > which implies that gmac (dwgmac1000_core.c) and gmac4 (dwgmac4_core.c)
> > will always have its internal PCS if we're using SGMII mode. Does this
> > mean it is true that these cores will never be used with an external
> > PCS?
> 

> Sorry to go off on a related tangent, but I've just been looking at
> hw->ps which is related to this.

I was meditating around the hw->ps part for several days on the last
week and just gave up in finding of how that semantics could be
incorporated in the phylink pcs logic...

> 
> As I understand, hw->ps comes from the "snps,ps-speed" property in DT,
> which is used for SGMII and MAC2MAC connections. Presumably for the
> SGMII case, this is used where the port is made to look like the PHY
> end of the SGMII link.

Right. The speed comes from the "snps,ps-speed" property and is
utilized to set the particular port speed in the MAC2MAC case. But
neither DW QoS Eth nor DW GMAC HW-manual explicitly describe that
case. The only SGMII MAC2MAC mention there is GMAC_AN_CTRL_SGMRAL flag
description:

"SGMII RAL Control

When set, this bit forces the SGMII RAL block to operate in the speed
configured in the Speed and Port Select bits of the MAC Configuration
register. This is useful when the SGMII interface is used in a direct
MAC to MAC connection (without a PHY) and any MAC must reconfigure the
speed.  When reset, the SGMII RAL block operates according to the link
speed status received on SGMII (from the PHY).

This bit is reserved (and RO) if the SGMII PHY interface is not
selected during core configuration."

> 
> I'm guessing MAC2MAC refers to RGMII, or does that also refer to
> SGMII-as-PHY?

I guess that it can be utilized in both cases: RGMII-to-RGMII and
SGMII-to-SGMII MAC2MAC setups. The only difference is that the
GMAC_AN_CTRL_SGMRAL flag setting would be useless for RGMII. But
originally the mac_device_info::ps field was introduced for the SGMII
MAC2MAC config here:
02e57b9d7c8c ("drivers: net: stmmac: add port selection programming")
and the "snps,ps-speed" property can be spotted alongside with 
phy-mode = "sgmii" only, here:
arch/arm64/boot/dts/qcom/sa8775p-ride.dts

Although AFAICS the dwmac1000_core_init()/dwmac4_core_init() methods
lack of the GMAC_CONTROL_TC/GMAC_PHYIF_CTRLSTATUS_TC flags set in the
(hw->ps)-related if-clause. Without that the specified speed setting
won't be in-bend delivered to the other side of the MAC2MAC link and
the internal PCS functionality won't work. Synopsys DW GMAC/Qos Eth
databooks explicitly say that these flags need to be set for the MAC
to be sending its Port speed, Duplex mode and Link Up/Down flag
setting over the RGMII/SGMII in-band signal:

SGMII: "The tx_config_reg[15:0] bits sent by the MAC during
Auto-negotiation depend on whether the Transmit Configuration register
bit is enabled for the SGMII interface."

RGMII: "When the RGMII interface is configured to transmit the
configuration during the IFG, then rgmii_txd[3:0] reflects the Duplex
Mode, Port Select, Speed (encoded as 00 for 10 Mbps, 01 for 100 Mbps
and 10 for 1000 Mbps), and Link Up/Down bits of the MAC Configuration
Register,"

TC flag description:
"Transmit Configuration in RGMII, SGMII, or SMII

When set, this bit enables the transmission of duplex mode, link
speed, and link up or down information to the PHY in the RGMII, SMII,
or SGMII port. When this bit is reset, no such information is driven
to the PHY. This bit is reserved (and RO) if the RGMII, SMII, or SGMII
PHY port is not selected during core configuration."

> 
> I think it would've been nice to have picked SGMII-as-PHY up in the
> driver earlier - we don't tend to use the "normal" PHY interface
> mode names, instead we have the REVxxx modes, so I think this
> _should_ have introduced PHY_INTERFACE_MODE_REVSGMII.

Not sure whether it would be a correct thing to do. RevMII is a real
interface. DW GMAC/QoS Eth can be synthesized with RevMII PHY
interface support. Mac2Mac SGMII/RGMII is a feature of the standard
SGMII/RGMII interfaces.

On the other hand we already have the set of the artificial modes like
"rgmii-id/rgmii-txid/rgmii-rxid" indicating the MAC-side delays but
describing the same interfaces. So I don't have a strong opinion
against have the modes like "rev-rgmii"/"rev-sgmii".

> 
> In any case, moving on... in stmmac_hw_setup(), we have:
> 
>         /* PS and related bits will be programmed according to the speed */
>         if (priv->hw->pcs) {
>                 int speed = priv->plat->mac_port_sel_speed;
> 
>                 if ((speed == SPEED_10) || (speed == SPEED_100) ||
>                     (speed == SPEED_1000)) {
>                         priv->hw->ps = speed;
>                 } else {
>                         dev_warn(priv->device, "invalid port speed\n");
>                         priv->hw->ps = 0;
>                 }
>         }
> 

> Which means that if we're using the integrated PCS, then we basically
> require the "snps,ps-speed" property otherwise we'll issue a warning
> at this point... this seems to imply that reverse mode is the only
> mode supported, which I'm fairly sure is false. So, maybe this
> shouldn't be issuing the warning if mac_port_sel_speed was zero?

Seeing the link state could be delivered over the in-band path, I
guess the "snps,ps-speed" property is supposed to be optional so the
mac_port_sel_speed being zero is a possible case. Thus the warning is
indeed misleading and it is totally ok to have mac_port_sel_speed
being set to zero. If it is, then the link state shall be determined
either over in-band or from the PHY.

> 
> Moving on... hw->ps can only be 10M, 100M or 1G speeds and nothing else
> - which is fine since RGMII and Cisco SGMII only support these speeds.
> 
> dwmac1000 tests for this against these speeds, so it is also fine.
> 
> dwmac4 is basically the same as dwmac1000, so is also fine.
> 
> The core code as it stands today passes this into the pcs_ctrl_ane
> method's rsgmi_ral argument, which sets GMAC_AN_CTRL_SGMRAL. Presumably
> this selects "reverse" mode for both SGMII and RGMII?

No, GMAC_AN_CTRL_SGMRAL flag works for SGMII only, which enables the
fixed link speed (see my second comment in this email message) by
forcing the SGMII RAL (Rate Adaptation Layer) working with the
pre-defined speed. AFAIU RGMII interface doesn't need that flag since
it always works with the pre-defined speed and has no Rate Adaptation
engine.

> 
> Persuing this a bit futher, qcom-ethqos always calls this with rsgmi_ral
> clear. Presumably, qcom-ethqos never specifies "snps,ps-speed" in DT,
> and thus always gets the warning above?

Interesting situation. Actually no. The only DW QoS Eth device for
which "snps,ps-speed = 1000" is specified is "qcom,sa8775p-ethqosi"
(see arch/arm64/boot/dts/qcom/sa8775p-ride.dts), due to that no
warning is printed. But on the other hand the low-level driver
(drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c) also sets
the STMMAC_FLAG_HAS_INTEGRATED_PCS flag exactly for that device, which
effectively disables the entire internal PCS functionality (except the
speed setup performed in dwmac4_core_init()).

Holy mother of ...

> 
> Finally, we get to the core issue, which is dwxgmac2_core.c.
> dwxgmac2 tests this member against 10G, 2.5G and "any other non-zero
> value". Out of all of these, the only possible path through that code
> would be the one which results in:
> 
> 	tx |= hw->link.speed1000;
> 
> Neither of the other two (2.5G and 10G) are possible because those
> aren't legal values for hw->ps. Moreover, it doesn't appear to have
> any kind of PCS, so I'm wondering whether any of this code gets used.

I guess the (hw->ps)-related code snippet has been just dummy-copied from
another dwmac*_core.c file to DW XGMAC. So IMO it can be freely
dropped. After all the bindings define the snps,ps-speed as:

      "Port selection speed that can be passed to the core when PCS
      is supported. For example, this is used in case of SGMII and
      MAC2MAC connection."

I doubt DW XGMAC could be used in the MAC2MAC setup, and it doesn't
have any internal PCS (may have externally connected DW XPCS though).

> 
> 
> So, I suspect some of this is "not quite right" either, and I wonder
> about the implications of changing how hw->pcs is set - whether we
> first need to fix the code above dealing with priv->hw->ps ?
> 
> I'm also wondering what impact this has on my PCS conversion.

My brain got blown up thinking about this one week ago. So I gave up
in looking for a portable way of fixing the MAC2MAC part and sent my
three patches as is to you. I thought after some time I could come up
with some ideas about that. Alas the time-break didn't help.)

I can't say for sure what could be a better way to align the things
around the internal PCS and MAC2MAC case. But IMO seeing the code is
vastly messy and unlikely has been widely used I'd suggest to preserve
the semantics as required by the Qualcomm QoS Eth
(dwmac-qcom-ethqos.c), and free redefining the rest of the
things as you wish.

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

