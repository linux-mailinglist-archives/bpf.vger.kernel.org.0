Return-Path: <bpf+bounces-55523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 770C6A82433
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 14:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 194654C44C7
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 12:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC40925F784;
	Wed,  9 Apr 2025 12:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Do2eW7o2"
X-Original-To: bpf@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFF325EF8F;
	Wed,  9 Apr 2025 12:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744200287; cv=none; b=ehEN9NpTHp9ywOrwKNPblE3Y6eRDdJ3/mYn8wIzBJvh4On0gIDv9E9/sMdobS9uZofaQk4v2BzKz4jlU63cdINIyX9e6nD0BZE0R17znrbCrYFax/xoceJ61mYW9WMddgsJ0dC/N5WNPPlksd37c71Jn2a9uGaZf8uN9DIQvkNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744200287; c=relaxed/simple;
	bh=3eISLvMZBxP/ooZQeBCga7d69iQG8hNqCRD4i6rUm48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qA2gF5P1H+FUj5Bc0MlR//dDK+GNmOr9dz25pLs7Qct4XVEmyzZZWAs8L7omBAa4SUVZ3Uv7v//nP+n45aD88jde1fwxJe0y1Dx1Q2vm9dpdLgeHJyXr46z6pnDjp46ViQ2oF6IIPgwfLOR4LHI5PpSQ8YnnjxHC9JWiUUxT0os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Do2eW7o2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OAVZ/6PMd5CIYGP1LffsV13Ct6MPa7aS43NNYUi9Muc=; b=Do2eW7o21PD63tUeD1m2JPMF3Y
	GA5PJ2TY9XpQdy9chWaHuYljs1HgVw6p5M9TaxjWcsYXPcY68Nmh+BBlqBEFfjV182S1AM0QCVxcE
	Mg97XRoHA317XEdNLGpJRIrwHtQCfQNRRgkRtx6Y8UULja95mNyri9hyyr5XhP3K1DcA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u2UAX-008X2W-Vg; Wed, 09 Apr 2025 14:04:37 +0200
Date: Wed, 9 Apr 2025 14:04:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Ng, Boon Khai" <boon.khai.ng@altera.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"Gerlach, Matthew" <matthew.gerlach@altera.com>,
	"Ang, Tien Sung" <tien.sung.ang@altera.com>,
	"Tham, Mun Yew" <mun.yew.tham@altera.com>,
	"G Thomas, Rohan" <rohan.g.thomas@altera.com>
Subject: Re: [PATCH net-next v3 2/2] net: stmmac: dwxgmac2: Add support for
 HW-accelerated VLAN stripping
Message-ID: <3eb3bb21-eee9-44b6-b680-4c629df29d34@lunn.ch>
References: <20250408081354.25881-1-boon.khai.ng@altera.com>
 <20250408081354.25881-3-boon.khai.ng@altera.com>
 <c65bfe99-a6e1-4485-90ee-aee0b8e0984d@lunn.ch>
 <BN8PR03MB5073B710F5040EAC06595AE2B4B42@BN8PR03MB5073.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR03MB5073B710F5040EAC06595AE2B4B42@BN8PR03MB5073.namprd03.prod.outlook.com>

On Wed, Apr 09, 2025 at 03:12:53AM +0000, Ng, Boon Khai wrote:
> > This appears to be identical to dwmac4_wrback_get_rx_vlan_tci() ?
> > 
> > Can it be moved into the shared code, or am i missing something?
> > 
> >         Andrew
> 
> Hi Andrew thanks for the quick response.
> 
> For the dwmac4 IP it has the following format at the 
> Receive Normal Descriptor 0 (RDES0)
> 
>            31                                                                                                0
>               ------------------------------------- -----------------------------------
> RDES0 |   Inner VLAN TAG [31:16]   | Outer VLAN TAG [31:16   |
>               ------------------------------------- -----------------------------------
> 
> While for dwxgmac2 IP it has the following format at the RDES0
> Depending on the Tunneled Frame bit (TNP)
> 
> For Non-Tunneled Frame (TNP=0)
>            31                                                                                                0
>               ------------------------------------- -----------------------------------
> RDES0 |   Inner VLAN TAG [31:16 ]  | Outer VLAN TAG [31:16]   |
>               ------------------------------------- -----------------------------------
> 
> For Tunneled Frame (TNP=1)
>            31                                        8 7                          3 2                  0
>               -------------------------------- ----------------------- ----------------
> RDES0 |   VNID/VSID                    |    Reserved         | OL2L3         |
>               -------------------------------- ----------------------- ----------------
> 
> While the logic for handling Tunneled Frame and Non-Tunneled
> Frame is not yet implemented in the 
> dwxgmac2_wrback_get_rx_vlan_tci() function, I believe it is
> prudent to maintain separate functions within their respective
> descriptor driver files, (dwxgmac2_descs.c and dwmac4_descs.c)

Please add a comment, or describe this in the commit message.

	Andrew

