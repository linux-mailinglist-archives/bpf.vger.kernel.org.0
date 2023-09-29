Return-Path: <bpf+bounces-11094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5319C7B2BFF
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 07:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 11CC9282A03
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 05:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6088BE2;
	Fri, 29 Sep 2023 05:48:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507A317F2;
	Fri, 29 Sep 2023 05:48:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459E7C433C7;
	Fri, 29 Sep 2023 05:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695966483;
	bh=7ZC2EUS1+5alu8Xvvo5x8YyaDXlFVLmwBFCPCg7iIKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WxhUB415GBUxZOL+xZHYtDTurxK5nBb0W0aJMJpxj5PCUSDRPUTF0nn3N584sqa7p
	 HTMP0xK4e93SxutPiWMu4AoeW/ir8EKCm/H8v8YLINu3OiXnYfxVli01fBE5/9ozEE
	 9RuuLWrVrV+ahXUb3xSEJoSBNJy4u9xgP0ua1rdO6qSjRg5Navb3DFz4E9wSvopkkv
	 leorErorjrd7GVcdU/LBSLpbkK3YPavj8rFTVkRBkcZuWCQgzfz8ABqwtyKI/4V8E6
	 4jYuzUrrKT991vlxRgHrR8rLEC7CaCbROn5/XuTmkIdrUlUcv+GzECH3RQhQ3FBiWM
	 GKTBzpFmVxIpg==
Date: Fri, 29 Sep 2023 07:47:57 +0200
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
Message-ID: <20230929054757.GQ24230@kernel.org>
References: <1695519107-24139-1-git-send-email-haiyangz@microsoft.com>
 <1695519107-24139-2-git-send-email-haiyangz@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695519107-24139-2-git-send-email-haiyangz@microsoft.com>

On Sat, Sep 23, 2023 at 06:31:45PM -0700, Haiyang Zhang wrote:
> For an unknown TX CQE error type (probably from a newer hardware),
> still free the SKB, update the queue tail, etc., otherwise the
> accounting will be wrong.
> 
> Also, TX errors can be triggered by injecting corrupted packets, so
> replace the WARN_ONCE to ratelimited error logging, because we don't
> need stack trace here.
> 
> Cc: stable@vger.kernel.org
> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Reviewed-by: Simon Horman <horms@kernel.org>


