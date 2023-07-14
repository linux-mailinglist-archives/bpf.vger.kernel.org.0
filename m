Return-Path: <bpf+bounces-5033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4270753EE7
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 17:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17E91C215F4
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 15:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE5714AA1;
	Fri, 14 Jul 2023 15:31:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493BB13715;
	Fri, 14 Jul 2023 15:31:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3456C433C8;
	Fri, 14 Jul 2023 15:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689348715;
	bh=BZibhodv9mYmaldbAkgC6exLTG1CjJoX1GGScEeSuPM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N91TO1CpOC+GYb1J5AVvBZ4SEETH5c6ITsflBdSVxRrRgN5royAaRkjJFJ5WLvSR1
	 yWkBe6A+zdU1O3I48jNA8lyBing3UjX98V0DzZ5yUTFFIG1mopqeLRPTOOY0j5VhC3
	 rJJb/aS9XZ0LIMEsqnRWLhpEDD1PVYaPyvhWjrjCvcGryh4gH0RpdCef8J37/LMH+h
	 3jl4CdBClXEDmz8YEujAVdU3GmjOC+3rmFUCZq8iscRzaJC/gC9rUHkA/OPc7zln29
	 1lH472s0k0wXWEXKI4+wsqrwihiStNk5DrLK6ChTZUkDI2AI2NXBFC3YL3YFeXIn6K
	 IN+0RQXfsh6+g==
Date: Fri, 14 Jul 2023 08:31:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, brouer@redhat.com,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Dexuan Cui
 <decui@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Paul Rosswurm
 <paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "leon@kernel.org" <leon@kernel.org>, Long Li
 <longli@microsoft.com>, "ssengar@linux.microsoft.com"
 <ssengar@linux.microsoft.com>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, "daniel@iogearbox.net"
 <daniel@iogearbox.net>, "john.fastabend@gmail.com"
 <john.fastabend@gmail.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "ast@kernel.org" <ast@kernel.org>, Ajay Sharma <sharmaajay@microsoft.com>,
 "hawk@kernel.org" <hawk@kernel.org>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "shradhagupta@linux.microsoft.com"
 <shradhagupta@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH net-next] net: mana: Add page pool for RX buffers
Message-ID: <20230714083152.3f64d38a@kernel.org>
In-Reply-To: <3b043a95-a4bc-bbaf-c8e0-240e8ddea62f@redhat.com>
References: <1689259687-5231-1-git-send-email-haiyangz@microsoft.com>
	<20230713205326.5f960907@kernel.org>
	<85bfa818-6856-e3ea-ef4d-16646c57d1cc@redhat.com>
	<PH7PR21MB31166EF9DB2F453999D2E92ECA34A@PH7PR21MB3116.namprd21.prod.outlook.com>
	<3b043a95-a4bc-bbaf-c8e0-240e8ddea62f@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Jul 2023 15:13:15 +0200 Jesper Dangaard Brouer wrote:
> > Thank Jakub and Jesper for the reviews.
> > I'm aware of the page_pool.rst doc, and actually tried it before this
> > patch, but I got lower perf. If I understand correctly, we should call
> > page_pool_release_page() before passing the SKB to napi_gro_receive().
> > 
> > I found the page_pool_dev_alloc_pages() goes through the slow path,
> > because the page_pool_release_page() let the page leave the pool.
> > 
> > Do we have to call page_pool_release_page() before passing the SKB
> > to napi_gro_receive()? Any better way to recycle the pages from the
> > upper layer of non-XDP case?
> >   
> 
> Today SKB "upper layers" can recycle page_pool backed packet data/page.
> 
> Just use skb_mark_for_recycle(skb), then you don't need 
> page_pool_release_page().
> 
> I guess, we should update the documentation, mentioning this.

Ah, I should probably send in the few cleanups form the huge page
series. It looks like all users of page_pool_release_page() can
be converted to skb recycling, so we should hide it and remove 
from docs?

