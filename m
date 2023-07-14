Return-Path: <bpf+bounces-4983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 747ED753031
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 05:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4A131C214F0
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 03:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A5846B1;
	Fri, 14 Jul 2023 03:53:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C703D71;
	Fri, 14 Jul 2023 03:53:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F456C433C8;
	Fri, 14 Jul 2023 03:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689306808;
	bh=+Fwviehmwgt9m79rlkMZy9sX+Vt3vd0g3UBMQgLjJSE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Oe5GldKdTBTA4XQjk58S0OXHh+EuHdGsss8/xGKrhDOPhwAHK1FI0eq0kJnvMlgXJ
	 zWMyLRPMe7jckoV247ZCMBDzuM54nqWJZmwREKMYtgM8Ll4b2Q4ADi7FMuy7tGSq43
	 TbX4m++CTLhdyMV8oo96GBk00rJqIlohbJy3Yt56nd1V31Yiagil5P/Hs44FhvW3UD
	 9Ej+6w1zkIvRVU1K5UcGyqmBQZq/WNnuEijCEVzBcsxRVTMmsu+4MVnw7CF/vRwasH
	 lAJHnrJ5DLXVqSwkd5V4xIVztAAKZero3ZhbDh3dkiD+vsYGoNPtLK6PIN4t1rz16e
	 aLFT8rQM4LfsQ==
Date: Thu, 13 Jul 2023 20:53:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
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
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: mana: Add page pool for RX buffers
Message-ID: <20230713205326.5f960907@kernel.org>
In-Reply-To: <1689259687-5231-1-git-send-email-haiyangz@microsoft.com>
References: <1689259687-5231-1-git-send-email-haiyangz@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jul 2023 14:48:45 +0000 Haiyang Zhang wrote:
> Add page pool for RX buffers for faster buffer cycle and reduce CPU
> usage.
> 
> Get an extra ref count of a page after allocation, so after upper
> layers put the page, it's still referenced by the pool. We can reuse
> it as RX buffer without alloc a new page.

Please use the real page_pool API from include/net/page_pool.h
We've moved past every driver reinventing the wheel, sorry.
-- 
pw-bot: cr

