Return-Path: <bpf+bounces-10000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0057A027A
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 13:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38692280E6D
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 11:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E016815E96;
	Thu, 14 Sep 2023 11:24:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877EC208A9;
	Thu, 14 Sep 2023 11:24:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44831C433C8;
	Thu, 14 Sep 2023 11:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694690656;
	bh=7cGyC78LHve3osM8Hvu3/twUfNtqcFKheYxSlDSNvcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bd9Xe3mx5JGh3jgZSki6z1tj+/aARC4uKcCns4P3tBfiete1jfzlH2DdaWEfq9X9k
	 gb1AvrzVkQb/qC2jMYlAqD9QCsXBjB83V+ABCVPVvqt4aepydUtxeKjs45Rpo7jiSN
	 OjtlbhMSuiOG0D/MFhxZ8WIMGaJ1gf/AP/ykcN7SzoWosRTP4HA18kbcxY2NsYD7CA
	 qEeb2dn68yyrAafXTeOyMlQWAT5zn50kgnljKtRjckSuEg6TcoUS8RVp6wi5ccZlDD
	 8hI3y3VisnYvoEthO2sfEwDy1cqkhEPvzWcbPoKUkdccjEvU7FZBAq+ClljuY9pSzY
	 mckLxnlYZjO5w==
Date: Thu, 14 Sep 2023 13:24:06 +0200
From: Simon Horman <horms@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	NXP Linux Team <linux-imx@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Samin Guo <samin.guo@starfivetech.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH net-next 1/6] net: stmmac: add platform library
Message-ID: <20230914112406.GA401982@kernel.org>
References: <ZP8yEFWn0Ml3ALWq@shell.armlinux.org.uk>
 <E1qfiqd-007TPL-7K@rmk-PC.armlinux.org.uk>
 <20230912145227.GE401982@kernel.org>
 <ZQDkR/YX2HPMKiF5@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQDkR/YX2HPMKiF5@shell.armlinux.org.uk>

On Tue, Sep 12, 2023 at 11:20:55PM +0100, Russell King (Oracle) wrote:
> On Tue, Sep 12, 2023 at 04:52:27PM +0200, Simon Horman wrote:
> > On Mon, Sep 11, 2023 at 04:29:11PM +0100, Russell King (Oracle) wrote:
> > > +	default:
> > > +		return -ENOTSUPP;
> > 
> > Checkpatch seems to think that EOPNOTSUPP would be more appropriate
> > as "ENOTSUPP is not a SUSV4 error code".
> 
> It needs to be an error code that clk_set_rate() below isn't going to
> return - because if clk_set_rate() does return it, then the users are
> going to end up issuing an incorrect error message to the user. I
> suspect clk_set_rate() could quite legitimately return -EOPNOTSUPP
> or -EINVAL.
> 
> Sadly, the CCF implementation of clk_set_rate() doesn't detail what
> errors it could return, but it looks like -EBUSY, -EINVAL, or something
> from pm_runtime_resume_and_get().

Thanks Russell,

Understood.

In that case perhaps ENOTSUPP is not such a bad choice as:
a) it seems rather unlikely CCF would use it; and
b) the scope of usage is well contained - the helper and any direct callers.

No further objections from my side :)

> 
> Interestingly, while looking at this, pm_runtime_resume_and_get() can
> return '1' if e.g. rpm is disabled and the device is active. It looks
> to me like CCF treats that as an error in multiple locations.

The plot thickens...

