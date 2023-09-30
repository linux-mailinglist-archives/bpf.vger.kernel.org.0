Return-Path: <bpf+bounces-11164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD7E7B42F0
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 20:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 71DD71C20BDB
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 18:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E2018C04;
	Sat, 30 Sep 2023 18:16:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D010118B0D;
	Sat, 30 Sep 2023 18:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755A5C433C8;
	Sat, 30 Sep 2023 18:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696097790;
	bh=4KxrdWQII7ZMqg05ZoYUeAYx7P3qwGPcbUzEt9FXv8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lJbU2vc+5yly5IaO2oXd/4pi4tBp5Ef08ulv77sXkiMk25ulICEZnnhOmlKpte9Bi
	 QRNhWkE26HfPQzGpdmtyC5pb1nqnKk2Q+XKmopDUD5vaQwdZsPaqYk+YGgkZekdTNZ
	 aSFYvSeG1gMDiG7FEvfsn/hBi5FYVnv3u0bQkL5jJbqyXQ6DiwkpqN5hacO0akhEDc
	 O+MsPjfqEIC6oNtB1O1d5FeB2mlvGFs1FoEgcpefnUrUVlGlp8oBI60Br+ktff4xt3
	 kN/ZU1GnqufKENMcNBtG5uHe07IuxKYlgvyaTc8yS3u/8F4RN4/f4oGpUT1NswVAph
	 i726jlQVEB7zQ==
Date: Sat, 30 Sep 2023 20:16:23 +0200
From: Simon Horman <horms@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Dexuan Cui <decui@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	Paul Rosswurm <paulros@microsoft.com>,
	"olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
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
	Ajay Sharma <sharmaajay@microsoft.com>,
	"hawk@kernel.org" <hawk@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH net, 1/3] net: mana: Fix TX CQE error handling
Message-ID: <20230930181623.GF92317@kernel.org>
References: <1695519107-24139-1-git-send-email-haiyangz@microsoft.com>
 <1695519107-24139-2-git-send-email-haiyangz@microsoft.com>
 <20230929054757.GQ24230@kernel.org>
 <20230929055030.GS24230@kernel.org>
 <PH7PR21MB3116CC4A402211384A28F13DCAC0A@PH7PR21MB3116.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB3116CC4A402211384A28F13DCAC0A@PH7PR21MB3116.namprd21.prod.outlook.com>

On Fri, Sep 29, 2023 at 03:51:48PM +0000, Haiyang Zhang wrote:
> 
> 
> > -----Original Message-----
> > From: Simon Horman <horms@kernel.org>
> > Sent: Friday, September 29, 2023 1:51 AM
> > To: Haiyang Zhang <haiyangz@microsoft.com>
> > Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; Dexuan Cui
> > <decui@microsoft.com>; KY Srinivasan <kys@microsoft.com>; Paul Rosswurm
> > <paulros@microsoft.com>; olaf@aepfle.de; vkuznets
> > <vkuznets@redhat.com>; davem@davemloft.net; wei.liu@kernel.org;
> > edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> > leon@kernel.org; Long Li <longli@microsoft.com>;
> > ssengar@linux.microsoft.com; linux-rdma@vger.kernel.org;
> > daniel@iogearbox.net; john.fastabend@gmail.com; bpf@vger.kernel.org;
> > ast@kernel.org; Ajay Sharma <sharmaajay@microsoft.com>;
> > hawk@kernel.org; tglx@linutronix.de; shradhagupta@linux.microsoft.com;
> > linux-kernel@vger.kernel.org; stable@vger.kernel.org
> > Subject: Re: [PATCH net, 1/3] net: mana: Fix TX CQE error handling
> > 
> > On Fri, Sep 29, 2023 at 07:47:57AM +0200, Simon Horman wrote:
> > > On Sat, Sep 23, 2023 at 06:31:45PM -0700, Haiyang Zhang wrote:
> > > > For an unknown TX CQE error type (probably from a newer hardware),
> > > > still free the SKB, update the queue tail, etc., otherwise the
> > > > accounting will be wrong.
> > > >
> > > > Also, TX errors can be triggered by injecting corrupted packets, so
> > > > replace the WARN_ONCE to ratelimited error logging, because we don't
> > > > need stack trace here.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure
> > Network Adapter (MANA)")
> > > > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > >
> > > Reviewed-by: Simon Horman <horms@kernel.org>
> > 
> > Sorry, one latent question.
> > 
> > The patch replaces WARN_ONCE with a net_ratelimit()'d netdev_err().
> > But I do wonder if, as a fix, netdev_err_once() would be more appropriate.
> 
> This error may happen with different CQE error types, so I use netdev_err() 
> to display them, and added rate limit.

Thanks for the clarification.

