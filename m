Return-Path: <bpf+bounces-11096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DA27B2C12
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 07:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 15F922828AE
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 05:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6568BFC;
	Fri, 29 Sep 2023 05:50:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C698F8817;
	Fri, 29 Sep 2023 05:50:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9D2C433C8;
	Fri, 29 Sep 2023 05:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695966637;
	bh=pus409fnjAN68UJYHzl/i9nvZInBE9bOy7rWmKfcZaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YnzzezIDV9y9njBOBu4WEU7VXwGaet+GAqx5L40g+cE4ubMOgW1W9zPamQI6ooo/X
	 1rP88VI7RIAA2LDupyoDY+r1cCAl9GtirC+BaxaEWPC65/Tc8VJ2/19D4JkTzadQl9
	 ITHDQPpGwIvKBufT4z8R0trDM6IStlmmgbnRw0J8JWnFdMQCo3TaBeVsQXTw46gKGw
	 a/By4+Xufq3qX90GtX7dZ1cePifaaxpjgE3I4eGtPdSzUNQPiL4dG+LaSOIx6U7u1S
	 5UV5kWwlfUG3fKkjtbDkpL4CJkduWXuxWVXv8vSseeaZc2EmbhbbsRYj0H6eLccC1I
	 /MLjSnWhO1N0A==
Date: Fri, 29 Sep 2023 07:50:30 +0200
From: Simon Horman <horms@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	decui@microsoft.com, kys@microsoft.com, paulros@microsoft.com,
	olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net,
	wei.liu@kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, leon@kernel.org, longli@microsoft.com,
	ssengar@linux.microsoft.com, linux-rdma@vger.kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com, bpf@vger.kernel.org,
	ast@kernel.org, sharmaajay@microsoft.com, hawk@kernel.org,
	tglx@linutronix.de, shradhagupta@linux.microsoft.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net, 1/3] net: mana: Fix TX CQE error handling
Message-ID: <20230929055030.GS24230@kernel.org>
References: <1695519107-24139-1-git-send-email-haiyangz@microsoft.com>
 <1695519107-24139-2-git-send-email-haiyangz@microsoft.com>
 <20230929054757.GQ24230@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929054757.GQ24230@kernel.org>

On Fri, Sep 29, 2023 at 07:47:57AM +0200, Simon Horman wrote:
> On Sat, Sep 23, 2023 at 06:31:45PM -0700, Haiyang Zhang wrote:
> > For an unknown TX CQE error type (probably from a newer hardware),
> > still free the SKB, update the queue tail, etc., otherwise the
> > accounting will be wrong.
> > 
> > Also, TX errors can be triggered by injecting corrupted packets, so
> > replace the WARN_ONCE to ratelimited error logging, because we don't
> > need stack trace here.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Sorry, one latent question.

The patch replaces WARN_ONCE with a net_ratelimit()'d netdev_err().
But I do wonder if, as a fix, netdev_err_once() would be more appropriate.

