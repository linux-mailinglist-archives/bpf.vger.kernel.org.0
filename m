Return-Path: <bpf+bounces-58723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A892CAC0B0B
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 14:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DFDB169BD7
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 12:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A9828A712;
	Thu, 22 May 2025 12:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKWf7UZr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2711DF965;
	Thu, 22 May 2025 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747915357; cv=none; b=E4WBoE9xMv0itVC0gE/FQ/wjwfT7IiTn21PUSJyz75qlahLrEKsGRY5otmAi9fFBhs2kY4mZB6quOwivag7IPZhfrq9ZsNf8QnE3LsfFKZir8gi2Kco24T6UDgjwXGfgdJnXlliidk2FX3Hw0E9CWeITvr1gOcRAxdtNewM5R88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747915357; c=relaxed/simple;
	bh=3EqVS0mPt9FHYeHpJEN9TOubD2eRleBP0208eEeLR2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ez5Xm7yCNPhzV6kMGu7NT1a6XZFfJeEIjJNo9GyfnfC6Jabn+n3rP56dZsOl9K4y4j/Zn/9S0w2xfM95xX7iy/XtO+RlwyqKYXvFKfqosg9AUduj9XjbbBYnuwHisCCTIQkhQY+PVstt9Neuzht+SwGG/1L6wRBfHE5leUy5Lfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKWf7UZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DEDC4CEE4;
	Thu, 22 May 2025 12:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747915356;
	bh=3EqVS0mPt9FHYeHpJEN9TOubD2eRleBP0208eEeLR2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kKWf7UZrSMObWEDDrmj8yJWq72sycQWbfYl/ymYM0KUSgFVtxmkEpwe/FlC3P/OwE
	 qzXFvINcYYRcrGh3W9CuA9GkAoNONfTY/SHelsuth3KzWoCR2EdwuCJsvYLMi3IaVZ
	 MR3Fusi7rfKC+65QQby5DmodHWCKvm3jsZ/VMu6gOlU2d4S17MiZm1aMXFKJp5gYmE
	 kJ3sMJid/uUoabCzppg6t2zcoFaMb32nRGFA9z5I5Kl9ZkybaaH14v98w1JLm9mkEC
	 drvWNVpQBbCzawLA+U0xgnbmN+33Kvn/rpgi2Tx+aYUSksSfPObedGeRUfmpcXDFcA
	 V6mZid1e6fccw==
Date: Thu, 22 May 2025 13:02:29 +0100
From: Simon Horman <horms@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	KY Srinivasan <kys@microsoft.com>,
	Paul Rosswurm <paulros@microsoft.com>,
	"olaf@aepfle.de" <olaf@aepfle.de>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"leon@kernel.org" <leon@kernel.org>, Long Li <longli@microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"ast@kernel.org" <ast@kernel.org>,
	"hawk@kernel.org" <hawk@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH net-next,v2] net: mana: Add support for
 Multi Vports on Bare metal
Message-ID: <20250522120229.GX365796@horms.kernel.org>
References: <1747671636-5810-1-git-send-email-haiyangz@microsoft.com>
 <20250521140231.GW365796@horms.kernel.org>
 <MN0PR21MB34373B1A0162D8452018ABAACA9EA@MN0PR21MB3437.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR21MB34373B1A0162D8452018ABAACA9EA@MN0PR21MB3437.namprd21.prod.outlook.com>

On Wed, May 21, 2025 at 05:28:33PM +0000, Haiyang Zhang wrote:
> 
> 
> > -----Original Message-----
> > From: Simon Horman <horms@kernel.org>
> > Sent: Wednesday, May 21, 2025 10:03 AM
> > To: Haiyang Zhang <haiyangz@microsoft.com>
> > Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; Dexuan Cui
> > <decui@microsoft.com>; stephen@networkplumber.org; KY Srinivasan
> > <kys@microsoft.com>; Paul Rosswurm <paulros@microsoft.com>;
> > olaf@aepfle.de; vkuznets@redhat.com; davem@davemloft.net;
> > wei.liu@kernel.org; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; leon@kernel.org; Long Li <longli@microsoft.com>;
> > ssengar@linux.microsoft.com; linux-rdma@vger.kernel.org;
> > daniel@iogearbox.net; john.fastabend@gmail.com; bpf@vger.kernel.org;
> > ast@kernel.org; hawk@kernel.org; tglx@linutronix.de;
> > shradhagupta@linux.microsoft.com; andrew+netdev@lunn.ch; Konstantin
> > Taranov <kotaranov@microsoft.com>; linux-kernel@vger.kernel.org
> > Subject: [EXTERNAL] Re: [PATCH net-next,v2] net: mana: Add support for
> > Multi Vports on Bare metal
> > 
> > On Mon, May 19, 2025 at 09:20:36AM -0700, Haiyang Zhang wrote:
> > > To support Multi Vports on Bare metal, increase the device config
> > response
> > > version. And, skip the register HW vport, and register filter steps,
> > when
> > > the Bare metal hostmode is set.
> > >
> > > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > > ---
> > > v2:
> > >   Updated comments as suggested by ALOK TIWARI.
> > >   Fixed the version check.
> > >
> > > ---
> > >  drivers/net/ethernet/microsoft/mana/mana_en.c | 24 ++++++++++++-------
> > >  include/net/mana/mana.h                       |  4 +++-
> > >  2 files changed, 19 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > > index 2bac6be8f6a0..9c58d9e0bbb5 100644
> > > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > > @@ -921,7 +921,7 @@ static void mana_pf_deregister_filter(struct
> > mana_port_context *apc)
> > >
> > >  static int mana_query_device_cfg(struct mana_context *ac, u32
> > proto_major_ver,
> > >  				 u32 proto_minor_ver, u32 proto_micro_ver,
> > > -				 u16 *max_num_vports)
> > > +				 u16 *max_num_vports, u8 *bm_hostmode)
> > >  {
> > >  	struct gdma_context *gc = ac->gdma_dev->gdma_context;
> > >  	struct mana_query_device_cfg_resp resp = {};
> > > @@ -932,7 +932,7 @@ static int mana_query_device_cfg(struct mana_context
> > *ac, u32 proto_major_ver,
> > >  	mana_gd_init_req_hdr(&req.hdr, MANA_QUERY_DEV_CONFIG,
> > >  			     sizeof(req), sizeof(resp));
> > >
> > > -	req.hdr.resp.msg_version = GDMA_MESSAGE_V2;
> > > +	req.hdr.resp.msg_version = GDMA_MESSAGE_V3;
> > >
> > >  	req.proto_major_ver = proto_major_ver;
> > >  	req.proto_minor_ver = proto_minor_ver;
> > 
> > > @@ -956,11 +956,16 @@ static int mana_query_device_cfg(struct
> > mana_context *ac, u32 proto_major_ver,
> > >
> > >  	*max_num_vports = resp.max_num_vports;
> > >
> > > -	if (resp.hdr.response.msg_version == GDMA_MESSAGE_V2)
> > > +	if (resp.hdr.response.msg_version >= GDMA_MESSAGE_V2)
> > >  		gc->adapter_mtu = resp.adapter_mtu;
> > >  	else
> > >  		gc->adapter_mtu = ETH_FRAME_LEN;
> > >
> > > +	if (resp.hdr.response.msg_version >= GDMA_MESSAGE_V3)
> > > +		*bm_hostmode = resp.bm_hostmode;
> > > +	else
> > > +		*bm_hostmode = 0;
> > 
> > Hi,
> > 
> > Perhaps not strictly related to this patch, but I see
> > that mana_verify_resp_hdr() is called a few lines above.
> > And that verifies a minimum msg_version. But I do not see
> > any verification of the maximum msg_version supported by the code.
> > 
> > I am concerned about a hypothetical scenario where, say the as yet unknown
> > version 5 is sent as the version, and the above behaviour is used, while
> > not being correct.
> > 
> > Could you shed some light on this?
> > 
> 
> In driver, we specify the expected reply msg version is v3 here:
> req.hdr.resp.msg_version = GDMA_MESSAGE_V3;
> 
> If the HW side is upgraded, it won't send reply msg version higher
> than expected, which may break the driver.

Thanks,

If I understand things correctly the HW side will honour the
req.hdr.resp.msg_version and thus the SW won't receive anything
it doesn't expect. Is that right?



