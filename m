Return-Path: <bpf+bounces-11255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B124C7B6554
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 11:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9BDAF28185F
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 09:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33155DF5C;
	Tue,  3 Oct 2023 09:20:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83D1DDAC;
	Tue,  3 Oct 2023 09:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABD2C433C7;
	Tue,  3 Oct 2023 09:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696324837;
	bh=kEex/DR+e1njfBDkl+EL3adoifBZXSVht3DKH7tUYRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ArTUptzCqhOST0Uaoi72u5yMW0ydgIc86ROgVjTLFDFWxPTcOPQTUgzsMI141XE4q
	 rIaY6q16ph24Ufu7uVZbwnLNCCDVSPll7IS0axSwfE7h2XK1BzeN+wf5v5R7O04t5D
	 9pVYACvLp2GYijTFvCguAi12ExIc6Lc2aQRNCUXMvvJAvSo/cx9GuFPE+ZGntMMqe+
	 mf4fZqq1o3XzdKLAZsVH4ZgUCttIEBs0Po4wNXHlLe6FDUUD9UCwthviFgnTd5/myj
	 7FHzg+gFe14HmKhB2rqR0+JTr3/PlS0uGCrMaJ9QykqZV4ucJcY3txIGXCS4JqX1D9
	 1YvjRcc/EcOeg==
Date: Tue, 3 Oct 2023 11:20:29 +0200
From: Simon Horman <horms@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	decui@microsoft.com, stephen@networkplumber.org, kys@microsoft.com,
	paulros@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
	davem@davemloft.net, wei.liu@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, leon@kernel.org,
	longli@microsoft.com, ssengar@linux.microsoft.com,
	linux-rdma@vger.kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
	sharmaajay@microsoft.com, hawk@kernel.org, tglx@linutronix.de,
	shradhagupta@linux.microsoft.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net,v2, 3/3] net: mana: Fix oversized sge0 for GSO packets
Message-ID: <ZRvc3fi1Whe+wnJy@kernel.org>
References: <1696020147-14989-1-git-send-email-haiyangz@microsoft.com>
 <1696020147-14989-4-git-send-email-haiyangz@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696020147-14989-4-git-send-email-haiyangz@microsoft.com>

On Fri, Sep 29, 2023 at 01:42:27PM -0700, Haiyang Zhang wrote:
> Handle the case when GSO SKB linear length is too large.
> 
> MANA NIC requires GSO packets to put only the header part to SGE0,
> otherwise the TX queue may stop at the HW level.
> 
> So, use 2 SGEs for the skb linear part which contains more than the
> packet header.
> 
> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
> v2: coding style updates suggested by Simon Horman

Reviewed-by: Simon Horman <horms@kernel.org>


