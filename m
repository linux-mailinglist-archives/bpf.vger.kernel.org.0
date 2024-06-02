Return-Path: <bpf+bounces-31167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A17388D791E
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 01:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174CF1F2163A
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 23:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803A07E59A;
	Sun,  2 Jun 2024 23:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbuYVn+f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE22C76EEA;
	Sun,  2 Jun 2024 23:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717370727; cv=none; b=g8H3V8DJdLS5uih1e7SK/o0oFeSFq0bd70hB/sgciP83OYqh9xMiUsZvFTQQRpZd1R9Co+lCZyFwWdPKxIQtVbAIODlIffUvjq+7zUf4RYz2VzOSinnrgjMaVQYPRdSlsfR3/6reLDe7L02gak04MQqCrhW61S5hFDMMhzRtGAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717370727; c=relaxed/simple;
	bh=srZOFvFuhh1jB+7qrg/oRblRSByV+dBeoIqn4qezeYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYi5MjYkjqP/6LMOw3BkQaJ+qCc8Q1NwSYyRe3EQSfw81lIlP2zUo5w6kMXhM0aT50eJWHQpccHOZQrzd3LmByjciBBVIlyTF3DUspm2rWtiooA3pUHygI2uLU3NJrNS6WGyGIDz+0L1SW6ag81gRBh4rr0Ug+LEQmov3APRPWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbuYVn+f; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e724bc466fso43104081fa.3;
        Sun, 02 Jun 2024 16:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717370722; x=1717975522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eCJ3/UMYS40bUTEzpbEGEN5IgufP139pAuhlqfFxKiA=;
        b=kbuYVn+fPy31QX2AiziGhCPxp7kzGCz/zb0+yVuv9WrzVpyf25wJwf/TDQAovuxnEg
         pbCR99kwtfcV56tHURASzoz2eLBgwUdkcjvQ0miQYRg3wZh/yOz4vVSWaaVfDmrJKD/x
         uEo/wuPIbJuOW/TLxUSx/CPzgN5QB3OkNvhh4rhfSPJcx2spUexWEuPUdrpy33L7lziu
         fRfnnJgv705w5rm+jZbjmoasI4f2VH1U5/rWpH+WqLg9rbljroDHzTV46bJbsL7ScIu+
         fQIzGFh91eB+79yz4yEkWMe1Do+6+XDM/zwxYnSU+4OF2vyIJG/wfaI+8lHmF4NPvQ0R
         WmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717370722; x=1717975522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eCJ3/UMYS40bUTEzpbEGEN5IgufP139pAuhlqfFxKiA=;
        b=C7n1IA8FzYwXdFJn9lo6canA2rMkfLKqSuaezsJc1akCU3WUsMi29+IA+zwv7cUqn/
         lDQuszu6fvNDEVjtxmo6TzZUhtN7JEYPujFZ0wTaA2uiMlEUrwHNr4vMT0Mn1ItKZM5O
         CpZrCXQZDZ0aKFHJbjiNGDdHcTbm22+CrUhONiNZ6cELlepMYjv0Ql4eue1/J+cejzIQ
         uMHbMdKqObz4Ixm9F/28CJIXBH4+LxJ2lZ6QhPZfvMIKAfAQkBeVogvxCwi4HKtzFTK2
         +5vzHHa/SlRYCk5/fxxtpEYCL3d5eLoaXWV4csyafVMmvHV5v37dR/ZcI0aDXkNmT0Kt
         UH9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhq6zcsXJxXOYxGJvO+m0ONeJBRsB/MfQ5gbFJDXMHsLHJ1Ib4mCCb9KpFScjAda9aRSN34Ztb7xVqnbyrA/CNk7UwqdN1lrdNFiwATwNbBfeOqQU1Hx8XUXm7AJengpvdXh08gYd/edDS1SF+q+6fG2mG+dQHN+aG
X-Gm-Message-State: AOJu0Ywe5Fn5DwTeJ0B9FiHRkL1DL27iDaLjAR43/a5sMPf5QwIxhSIt
	uKAh1cocBMMpy7tCKbT25+bv7EDlbD91byNcfKhGSVZD5L5I+OJX
X-Google-Smtp-Source: AGHT+IF5EZAbemMtEV8HkFtTrIyv5z9PPS44uvwmLsCuxSCSXDhHTzTDN8jblZzPazJTWVEkkRPdwQ==
X-Received: by 2002:a2e:3517:0:b0:2e7:16c9:2e0c with SMTP id 38308e7fff4ca-2ea9512fc2fmr58077251fa.15.1717370721932;
        Sun, 02 Jun 2024 16:25:21 -0700 (PDT)
Received: from mobilestation ([95.79.124.210])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91b9db52sm10408021fa.26.2024.06.02.16.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 16:25:21 -0700 (PDT)
Date: Mon, 3 Jun 2024 02:25:18 +0300
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
Message-ID: <yk3ohf2cct3mbbk6ajmhnqrzeivimlz3kblayrsyoxsw26ewmg@fpuvru3paq7w>
References: <ZkDuJAx7atDXjf5m@shell.armlinux.org.uk>
 <20240524210304.9164-1-fancer.lancer@gmail.com>
 <20240524210304.9164-2-fancer.lancer@gmail.com>
 <ZlNoLHoHjt3BsFde@shell.armlinux.org.uk>
 <ZlN4tkY8fNM8/D8p@shell.armlinux.org.uk>
 <ukszpirecb3pwnz5bbmy7wl44ujh6t2ewrnodmrye5kjmonsz2@pgf5b2oy5n3p>
 <ZlXmjKtKozXThPFv@shell.armlinux.org.uk>
 <x4snwm24lqebfcu3xqipwnxcexxbxhfijw7ldsukk23tn5k3rc@g3tfmynhvm26>
 <ZlolU6+lUaXQSQID@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlolU6+lUaXQSQID@shell.armlinux.org.uk>

Hi Russel

On Fri, May 31, 2024 at 08:30:27PM +0100, Russell King (Oracle) wrote:
> Hi Serge,
> 
> Thanks for the reply. I've attempted to deal with most of these in my
> v2 posting, but maybe not in the best way yet.

I've got your v2 series. I'll have a look at it and test it out later
on the next week, sometime around Wednesday.

> 
> On Fri, May 31, 2024 at 08:13:49PM +0300, Serge Semin wrote:
> > > Does this
> > > mean it is true that these cores will never be used with an external
> > > PCS?
> > 
> > Sorry, I was wrong to suggest the (priv->plat.has_gmac ||
> > priv->plat.has_gmac4)-based statement. Indeed there is a case of having DW
> > QoS Eth and DW XPCS synthesized together with the SGMII/1000Base-X
> > downstream interface. Not sure why it was needed to implement that way
> > seeing DW QoS Eth IP-core supports optional SGMII PHY interface out of
> > box, but AFAICS Intel mGBE is that case. Anyway the correct way to
> > detect the internal PCS support is to check the PCSSEL flag set in the
> > HWFEATURE register (preserved in the stmmac_priv::dma_cap::pcs field).
> 
> We can only wonder why!
> 
> > > Please can you confirm that if an external PCS (e.g. xpcs, lynx PCS)
> > > is being used, the internal PCS will not have been synthesized, and
> > > thus priv->dma_cap.pcs will be false?
> > 
> > Alas I can't confirm that. priv->dma_cap.pcs only indicates the
> > internal PCS availability. External PCS is an independent entity from
> > the DW *MAC IP-core point of view. So the DW GMAC/QoS Eth/XGMAC
> > controllers aren't aware of its existence. It's the low-level platform
> > driver/code responsibility to somehow detect it being available
> > ("pcs-handle" property, plat->mdio_bus_data->has_xpcs flag, etc).
> > 
> > Regarding the internal PCS, as long as the DW GMAC or DW QoS Eth is
> > synthesized with the SGMII/TBI/RTBI PHY interface support
> > priv->dma_cap.pcs will get to be true. Note the device can be
> > synthesized with several PHY interfaces supported. As long as
> > SGMII/TBI/RTBI PHY interface is any of them, the flag will be set
> > irrespective from the PHY interface activated at runtime. 
> 
> I've been debating about this, and given your response, I'm wondering
> whether we should change stmmac_mac_select_pcs() to instead do:
> 
> static struct phylink_pcs *stmmac_mac_select_pcs(struct phylink_config *config,
> 						 phy_interface_t interface)
> {
> 	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
> 	struct phylink_pcs *pcs;
> 
> 	if (priv->plat->select_pcs) {
> 		pcs = priv->plat->select_pcs(priv, interface);
> 		if (!IS_ERR(pcs))
> 			return pcs;
> 	}
> 
> 	return stmmac_mac_phylink_select_pcs(priv, interface);
> }
> 
> and push the problem of whether to provide a PCS that overrides
> the MAC internal PCS into platform code. That would mean Intel mGBE
> would be able to override with XPCS. rzn1 and socfpga can then do
> their own thing as well.

Well, AFAICS the only device that currently have the DW XPCS
connected to a non DW XGMAC controller is indeed the Intel mGBE with its
DW QoS Eth+DW XPCS weird setup. At the same time the Intel mGBE
controller can also support RGMII interface. Thus there is no internal
SGMII/TBI/RTBI PCS in there.

Qualcomm QoS Eth uses the internal SGMII PCS and by setting up the
STMMAC_FLAG_HAS_INTEGRATED_PCS flag its driver almost completely
disables the STMMAC PCS functionality (except the
stmmac_pcs_ctrl_ane() being called in stmmac_hw_setup()).

So from the perspective of these two devices the PCS selection looks
quiet certain. It's either internal or external one. There is no
device with both of them available.

SoCFPGA... Well, it's another and more complicated story. Based on
what said in a comment in
socfpga_gen5_set_phy_mode()/socfpga_gen10_set_phy_mode() the only
possibility to have some internal interface converted to the external
one is when a "splitter" is available. But IMO the comment is
misleading because the only thing that is then done with the
"splitter" CSR is just the clock divider selection. What is actually
done, if the "splitter" is available or if the SGMII/GMII/MII
_MAC-interface_ is requested, then the internal interface is fixed to
"GMII/MII". It looks weird because based on the "mac-mode" DT-property
semantics it was supposed to indicate the internal interface only. But
EMAC is never tuned to have the SGMII interface (see the values saved
in the "*val" argument of socfpga_set_phy_mode_common()). So all of
that makes me to conclude the next points:

1. "mac-mode" property has never been utilized for the SoG-FPGA GMAC
platform. The plat_stmmacenet_data::mac_interface field has always
defaulted to plat_stmmacenet_data::phy_interface.

2. SoG-FPGA GMAC IP-core itself doesn't support the native/internal
SGMII interface.  It's implemented by means of the so called
"gmii-to-sgmii"-converter, which is the Lynx PCS.

Thus unless I've missed something the SoC-FPGA network controller
structure can be depicted as follows:


                   +---- SYSMGR:PHYSEL
      phy_intf_sel |
+------------------+                     +--------------+ 
|          RMII    |                     |              | Internal Interface
|       +----------+                     |          off +--------------------------+
|          RGMII   | Internal Interface  | SGMII        |                          | External Interface*
| EMAC  +----------+---------------------+              |          +-------+       +--------+-----------
|         GMII/MII |                     | adapter      | GMII/MII | Lynx  | SGMII |        |
|       +----------+                     |           on +----------+       +-------+        |
|                  +--+                  |              |          |  PCS  |                |
+------------------+  |                  +--------------+          +---+---+                |
                      |                                                |                    |
                      |              +------------+                    |                    |
                      +--------------+ Splitter** +--------------------+--------------------+
                                     +-----+------+
                                           |
                                     +-----+------+
                                     | Oscillator |
                                     +------------+

* No idea whether the external interface is represented as a single IO
port or as multiple interface ports handled by the same MAC.

** As I explained above, judging by the SoC-FPGA driver code the
"splitter" is just the reference clock divider responsible for the
clock rate adjustment based on the requested link speed.

Based on the logic depicted on the sketch above, I guess that there is
no internal SGMII/TBI/RTBI PCS in SoC-FPGA GMAC either. The SGMII
interface is implemented by means of the Lynx PCS.

> 
> I'm trying hard not to go down another rabbit hole... I've just
> spotted that socfpga sets mac_interface to PHY_INTERFACE_MODE_SGMII.
> That's another reason for pushing this down into platform drivers -
> if platform drivers are doing weird stuff, then we can contain their
> weirdness in the platform drivers moving it out of the core code.

Oh, that damn "mac-mode" property... First of all as I already
mentioned once AFAICS originally it was introduced for the SoC-FPGA
GMAC, but the property has never been defined in any DT-node so far,
neither in SoC-FPGA nodes nor in the rest of the DW *MAC-based nodes.
Moreover based on my consideration above the SoC-FPGA internal
interface is always determined based on the external one seeing
plat_stmmacenet_data::mac_interface defaults to
plat_stmmacenet_data::phy_interface. Secondly I also have much
certainty that the rest of the glue drivers utilizing
plat_stmmacenet_data::mac_interface field should in fact be using
plat_stmmacenet_data::phy_interface instead. Based on the history of
the mac_interface-related changes it's likely that all of them have
just either been missed during the conversion to utilizing the
phy_interface-field or incorrectly utilized the mac_interface field
instead of phy_interface in the first place.

So to speak before going further it might be worth re-checking once
again the entire history of the "mac-mode" property-related change,
but as an experimental A/B-test patch for net-next it may be a good
idea to either drop the mac_interface field completely, or convert the
driver to forgetting about the internal PCS if the external one is
enabled, or, as a less invasive option, make SoC-FPGA explicitly
setting up the mac_interface field to GMII/MII if it configures the
internal interface to that value. Then, if these changes don't break
any platform (most importantly the SoF-FPGA GMAC case), then we can go
further and carefully convert the rest of the glue-drivers not using
the mac_interface field.

> 
> > You can extend the priv->dma_cap.pcs flag semantics. So it could
> > be indicating three types of the PCS'es:
> > RGMII, SGMII, XPCS (or TBI/RTBI in future).
> 
> If TBI/RTBI gets supported, then this would have to be extended, but I
> get the impression that this isn't popular.

Irrespective from the TBI/RTBI interface support, using the
priv->dma_cap.pcs field for all possible PCS'es shall also improve the
code readability. Currently we have four versions of the PCS fields:
dma_features::pcs
mac_device_info::pcs
mac_device_info::xpcs
mac_device_info::lynx_pcs
which are being checked here and there in the driver...

> 
> > I guess the DW XPCS implementation might be more preferable. From one
> > side DW XPCS SGMII can support up to 2.5Gbps speed, while the DW
> > GMAC/QoS Eth SGMII can work with up to 1Gbps speed only. On the other
> > hand the DW XPCS might be available over the MDIO-bus, which is slower
> > to access than the internal PCS CSRs available in the DW GMAC/QoS Eth
> > CSRs space. So the more performant link speed seems more useful
> > feature over the faster device setup process.
> 
> I think which should be used would depend on how the hardware is wired
> up. This brings us back to platform specifics again, which points
> towards moving the decision making into platform code as per the above.
> 
> > One thing I am not sure about is that there is a real case of having
> > the DW GMAC/QoS Eth synthesized with the native SGMII/TBI/RTBI PHY
> > interface support and being attached to the DW XPCS controller, which
> > would have the SGMII downstream PHY interface. DW XPCS has only the
> > XGMII or GMII/MII upstream interfaces over which the MAC can be
> > attached.
> 
> That gives us another possibility, but needs platforms to be doing
> the right thing. If mac_interface were set to XGMII or GMII/MII, then
> that would exclude the internal MAC PCS.
> 
> > So DW GMAC/QoS Eth and DW XPCS can be connected via the
> > GMII/MII interface only. Regarding Intel mGBE, it likely is having a
> > setup like this:
> > 
> > +------------+          +---------+
> > |            | GMII/MII |         |   SGMII
> > | DW QoS Eth +----------+ DW XPCS +------------
> > |            |          |         | 1000Base-X
> > +------------+          +---------+
> 
> 
> So as an alternative, 
> 
>      mac_interface            phy_interface
> 
>      XGMII/GMII/MII           SGMII/1000Base-X
> MAC ---------------- DW XPCS ------------------
> 
>      INTERNAL                SGMII/TBI/RTBI
> MAC ---------- Internal PCS ----------------
> 
>      INTERNAL                  RGMII
> MAC ---------- Internal "PCS" --------------

+ SoC-FPGA (presumably)

       GMII/MII                  SGMII
  MAC ---------------- Lynx PCS --------------

Please also note, based on the DW GMAC/QoS Eth hardware manual each
internal interface block is connected to MAC by the GMII/MII
interface. So the internal PCS cases more precisely could be
represented as follows:

       GMII                     SGMII (AN)
  MAC ---------- Internal PCS ------------------

       GMII                     TBI/RTBI (AN)
  MAC ---------- Internal PCS ------------------
  
       GMII                      RGMII (In-band)
  MAC ---------- Internal "PCS" ----------------

       GMII                      RevMII
  MAC ----------  RevMII block  ----------------

       GMII                      GMII
  MAC ------------------------------------------

       MII                       SMII (In-band)
  MAC ---------- Internal "PCS" ----------------

       MII                       RMII
  MAC ----------   RMII block   ----------------

       MII                       MII
  MAC ------------------------------------------

There is a special input signal phy_intf_sel[2:0], which tells to MAC
what interface to activate (grep -i the glue drivers for "intf",
"physel", etc).

> 
> One of the problems here, though, is socfpga. It uses mac_interface
> with RGMII*, MII, GMII, SGMII and RMII. I think it's confusing
> mac_interface for phy_interface, but I haven't read through enough
> of it to be certain.
> 
> So that again leads me back to my proposal above for
> stmmac_mac_select_pcs() as the least likely to break proposition -
> at least given how things are at the moment.

Please see my notes above regarding the internal interface
initialization in the SoC-FPGA glue driver. I guess we could at least
try to A/B-test the SoC-FPGA code in the next net-next by setting
mac_interface to GMII/MII when the internal interface is enabled as
GMII/MII in the glue-driver, and converting the rest of the glue
driver to using phy_interface. If nothing breaks, then SoC-FPGA has
never used the "mac-mode" property and we could mark the property as
deprecated and could carefully covert the rest of the STMMAC platform
driver to using the phy_interface field.

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

