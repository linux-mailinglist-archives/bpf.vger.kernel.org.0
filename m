Return-Path: <bpf+bounces-28880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24B38BE6AD
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 16:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F8CD1C2304D
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 14:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E99D160885;
	Tue,  7 May 2024 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEUq8giv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA7415FCF0;
	Tue,  7 May 2024 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093759; cv=none; b=dAZTa9DOKlFyuhL06s1l8DQ1t6tcl7DyJknJSeRosuoHLb45LJItkdGO6dNKux+FmA9fl21mOoYkvVkBp1bU1ZBkEupRrZzwGx/CWSZDKrRxz0+cx67ZcFmOGXXNEd+a7ShAYJThlu686zqzSdCaM8+W4VLRre3xoYNFtaL0ID0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093759; c=relaxed/simple;
	bh=hDoeAt0aCGqvaRLZUhPUSNs/Q6T/LZp1Y/m0zwy/8VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a16QLWM4Kw+jewiYEsmvgn+xeFZKHse80UmdICkCcIYugzSg7SuxmdvzOunDavYptLV6DM5K26QFQ7xNtwnd/j5600A+cC9I3zFUPVVkrkmni3SaCy9PJe0+/a61JOp9eWxI0i9CJ1rBkdE0z/enr247UrRDQgGVCJfiB5LGHaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEUq8giv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7414C2BBFC;
	Tue,  7 May 2024 14:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715093759;
	bh=hDoeAt0aCGqvaRLZUhPUSNs/Q6T/LZp1Y/m0zwy/8VA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QEUq8givoAZQpiA+7kCVzFHDZ7o4/uRf2Ar8D35gCBskdc8ctAAiedeU/2XcNdmDT
	 /jJ4W9KC09jl5eJwW1gWoAcrkfDbCHuF/ztqlKUSN5B07z8NBbUEr8A/F2GuvPAsUD
	 VzzyajXyTrylJteeF95fmW9DZRu9p88ZJe+A4v5sw67LOfTOr/KgAnubAfaJ9VZhJ+
	 VIucFJJmVs9jM0KQ5vMNZz9383IvHLtkceQlByPzxQFXKNG+gwncdHKxoDGqs8QXbs
	 AWNngkoj6WDB2F6S0p3I1G2z1cg9AjAkW8wYzfsuCo+i4vnruH75rqVzsiQgCLLSIt
	 P59VCWQBxvNhQ==
Date: Tue, 7 May 2024 09:55:57 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 10/11] dt-bindings: imx6q-pcie: Add i.MX8Q pcie
 compatible string
Message-ID: <20240507145557.GA461201-robh@kernel.org>
References: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
 <20240402-pci2_upstream-v3-10-803414bdb430@nxp.com>
 <20240429154823.GD1709920-robh@kernel.org>
 <ZjAPy05fGLqX6W1I@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZjAPy05fGLqX6W1I@lizhi-Precision-Tower-5810>

On Mon, Apr 29, 2024 at 05:23:23PM -0400, Frank Li wrote:
> On Mon, Apr 29, 2024 at 10:48:23AM -0500, Rob Herring wrote:
> > On Tue, Apr 02, 2024 at 10:33:46AM -0400, Frank Li wrote:
> > > From: Richard Zhu <hongxing.zhu@nxp.com>
> > > 
> > > Add i.MX8Q PCIe "fsl,imx8q-pcie" compatible strings.
> > > 
> > > Add "fsl,local-address" property for i.MX8Q platforms. fsl,local-address
> > > is address of PCIe module in high speed io (HSIO)subsystem bus fabric. HSIO
> > > bus fabric convert the incoming address base to this local-address. Two
> > > instances of PCI have difference local address.
> > 
> > This is just some intermediate bus address? We really should be able to 
> > describe this with standard ranges properties.
> 
> Yes, Maybe dwc's implement have some problem. After read below doc again
> https://elinux.org/Device_Tree_Usage#PCI_Address_Translation
> 
>                   ┌──────┐  ┌──────────┐                                 
> ┌────┐0x18001000  │      │  │          │                                 
> │CPU ├───────────►│      ├──┤  Others  │                                 
> └────┘            │      │  │          │                                 
>                   │      │  └──────────┘                                 
>                   │      │                                               
>                   │      │   ┌─────────┐                                 
>                   │      │   │         │            ┌───────────┐        
>                   │      ├──►│ HSIO    │ 0xB8001000 ├───────────┤        
>                   │      │   │ Fabric  ├───────────►│Bar0       │ TLP mem 0xB8001000   
>                   │      │   │         │            │0xB8000000 ├───────►
>                   └──────┘   └─────────┘            │           │        

Note the 0xB8xxxxxxx address on the right is a PCI address which could 
be anything though folks often make it 1:1.

>                   Main Fabric                       ├───────────┤        
>                                                     │           │        
>                                                     │           │        
>                                                     │           │        
>                                                     │           │        
>                                                     │           │        
>                                                     │           │        
>                                                     │ DWC       │        
>                                                     │ PCIe      │        
>                                                     │ Controller│        
>                                                     │           │        
>                                                     │           │        
>                                                     └───────────┘        
> 
> 
> dts should be
> 
> ranges = <0x82000000 0 0xB8000000 0x18000000 0 0x07f00000>
> 		       ^^^^

And HSIO needs a node with 

ranges = <0xb8000000 0x18000000 size>;

Rob


