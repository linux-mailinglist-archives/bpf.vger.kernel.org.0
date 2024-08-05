Return-Path: <bpf+bounces-36394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B878947DAB
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 17:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E02A1C2163B
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 15:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F30414C5AF;
	Mon,  5 Aug 2024 15:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TF1Q4GEu"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4356E13C683
	for <bpf@vger.kernel.org>; Mon,  5 Aug 2024 15:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722870459; cv=none; b=Xegi9LkE4Sf7tfdLVm7VpKOKA9VzETB5Gh/JQ2NrmdZf/t0Vctmgc4TpTRE7uLMEEgEaJwpJOymSzAGH+tCUqKEzvIUg0W/osimLA3+3cUUQJ18MdWL3xXLn7MFiDHNfu7dDzxvGlzhVq20elhu97viqkZZSs0PkWkN4uv0wj2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722870459; c=relaxed/simple;
	bh=0xb13Rbxh+eEDlGrDAAI13sTfjjWJqfDXdmfsixf78s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rV3/HlUdnHCk8dPe5aBMFQM/+Tg4/I9hGjXt0XXtwXbXSQburzM8F4ZfUV39gL/C6ge0PE8kqtLhgVF6FSDzFd2zE3DA6/TAheH83cFUKpge4hwN1n6qtGZ2xwT0xCmFP7qd+PI0HhRsvbd31bOohZzNlE2+JkvzM29yu/i0Eik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TF1Q4GEu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722870457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o4HYh4hoxDN/J50E0Jnd1FVXoMrne/Iur0T/sKC6Q7c=;
	b=TF1Q4GEuPjdGa+mNgFC4Ca/WeSMRgSZ7D0bH0feXHlt0+3mXCNDU7dQwZUO9Em66n6bjZt
	M1/RTL7TN6uSgJ4MrjHEZmVDeA74xUhGajIyt2QvuwWs3vwg3pnoMEjqMy5zbUNuSip3yu
	qysp8B+CeOyCy9UP9G8O/RKb/onyLd8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-ZOm8dVkkNv6FjJClgU5PNw-1; Mon, 05 Aug 2024 11:07:36 -0400
X-MC-Unique: ZOm8dVkkNv6FjJClgU5PNw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7a1d4238d65so1295092885a.0
        for <bpf@vger.kernel.org>; Mon, 05 Aug 2024 08:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722870455; x=1723475255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4HYh4hoxDN/J50E0Jnd1FVXoMrne/Iur0T/sKC6Q7c=;
        b=CPrgmrR37mPa0Dx1cWqEoo25AiOAQJnIBhvhv1aRQ0tQZg9J2P8gMMWp6/DtkNckeN
         fDyvKP9IRlWqyJNukteKHberUU8XWAUtVuCZXRufJQwf6mvtsKXS9zci3yVOxbI25SFj
         vWNs7sr/LY2jlvUOPKUImwLjx5m7/CuRzB1WsjiNgpDC3FOwYTiMsp2FZhaWHBsUXlVA
         IFWvH0CNgk0mFOzBqnLtCoSEBjPZHgVZjE4PEeWzBFa+yQE0zighDcWwG4CGRWvhPjIT
         uvndtE5fGRAZVhJHK7dSFgkYMdQ3cvulaSzSdTh3z0/1vlIu0+Ju4W+J6ofIyHVaMCBG
         QrtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtG/2CsVdCAToOtaE9+jmZayoJpG04aYFA5+GYsSZjj7E95ynLIzmV4ZnXy7bw+8d/Do4/OFS6Yt/19Ob12vtkjcpN
X-Gm-Message-State: AOJu0YxQYuROMg0FZbY0r5L01nY86cY3WnQBrI64jfwfJvy/SJlLxUPJ
	qB8sjU/jAAc2XeIVFr/fnSOv+9zobeVpxn75ErzuQnIY84AT9MtRvcdTe1okaQUatzyFd2eZeZA
	19sv2/XuqHyzoOMyibWRRXA9RTeuxQ/Ts2Ba/j0y2dihfZ7Jl3A==
X-Received: by 2002:a05:620a:29cb:b0:79d:5b8b:7ad0 with SMTP id af79cd13be357-7a34efca052mr1437714385a.65.1722870455369;
        Mon, 05 Aug 2024 08:07:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyKUHpuaat+IlBO9jx6OMHcFHgn9Vn6iJEHthO0hM/eX95XRxJJxYlt4N6aAWmvQ48FL1ypg==
X-Received: by 2002:a05:620a:29cb:b0:79d:5b8b:7ad0 with SMTP id af79cd13be357-7a34efca052mr1437711685a.65.1722870455002;
        Mon, 05 Aug 2024 08:07:35 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::13])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f78adadsm360064485a.123.2024.08.05.08.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 08:07:34 -0700 (PDT)
Date: Mon, 5 Aug 2024 10:07:32 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jose Abreu <joabreu@synopsys.com>, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH net-next 13/14] net: stmmac: remove obsolete pcs methods
 and associated code
Message-ID: <hrvupeqc2pgoqa7ecg5rtg657eyxwpe4eg7xl4o3ij4upqxyvt@iwplq3uo72kt>
References: <Zqy4wY0Of8noDqxt@shell.armlinux.org.uk>
 <E1sZpoq-000eHy-GR@rmk-PC.armlinux.org.uk>
 <ij562xfhvgxmvpgh2l6rhsvcpi43yvvkvef4wgpjupwusi6uwy@cpnkopeu7cpc>
 <Zq0yAjzrpIEhcHBZ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zq0yAjzrpIEhcHBZ@shell.armlinux.org.uk>

On Fri, Aug 02, 2024 at 08:22:42PM GMT, Russell King (Oracle) wrote:
> On Fri, Aug 02, 2024 at 02:02:25PM -0500, Andrew Halaney wrote:
> > On Fri, Aug 02, 2024 at 11:47:32AM GMT, Russell King (Oracle) wrote:
> > > The pcs_ctrl_ane() method is no longer required as this will be handled
> > > by the mac_pcs phylink_pcs instance. Remove these methods, their common
> > > implementation, the pcs_link, pcs_duplex and pcs_speed members of
> > > struct stmmac_extra_stats, and stmmac_has_mac_phylink_select_pcs().
> > >
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> >
> > ...
> >
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > > index 3c8ae3753205..799af80024d2 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > > @@ -321,48 +321,6 @@ static int stmmac_ethtool_get_link_ksettings(struct net_device *dev,
> > >  {
> > >  	struct stmmac_priv *priv = netdev_priv(dev);
> > >
> > > -	if (!(priv->plat->flags & STMMAC_FLAG_HAS_INTEGRATED_PCS) &&
> >
> > This change effectively makes the INTEGRATED_PCS flag useless, I think
> > we should remove it entirely.
>
> I'm hoping the ethqos folk are going to test this patch series and tell
> me whether it works for them - specifically Sneh Shah who added
>
> 	net: stmmac: dwmac-qcom-ethqos: Add support for 2.5G SGMII
>
> which directly configures the PCS bypassing phylink. Specifically,
> if this in stmmac_check_pcs_mode():
>
> 	priv->dma_cap.pcs && interface == PHY_INTERFACE_MODE_SGMII
>
> is true for this device, then we may be in for problems. Since
> priv->dma_cap.pcs comes from hardware, it's impossible to tell
> unless one has that hardware.

Hopefully we get a response there. For what its worth I have a
access to the sa8775p-ride.dts board in a remote lab and
dma_cap.pcs is definitely set for this integration of the IP
on sa8775p. The only upstream described boards are:

    1) sa8775p-ride
    2) sa8775p-ride-r3

The difference is that "r3" is the latest spin of the board, with some
Aquantia phys attached to the 2 stmmac MACs on the board instead of the
Marvell 88EA1512 phys on the former. My understanding is that's to
evaluate 2500 Mbps speeds (the 88EA1512 only goes up to 1000 Mbps).

The "r3" board's Aquantia aqr115c's are capable of 2500 Mbps, but are
"overclock SGMII". The "r3" describes the phy interface as 2500base-x,
with no in-band signalling (since the "OCSGMII" is hacked up and doesn't
really do the in-band signalling you've described in the past). That's
all based on Bart's commit message adding support for that in:

    0ebc581f8a4b7 net: phy: aquantia: add support for aqr115c

I think Sneh also had access to a board with the sa8775p in a fixed-link
configuration doing 2500 Mbps, but that's not described upstream at the
moment. I believe that was the board that originally motivated the patch
you highlighted from him.

At the very least Bartosz and I tested this and things didn't break
noticeably for the 2 boards I listed above... so that's good :)

Hope that helps,
Andrew


