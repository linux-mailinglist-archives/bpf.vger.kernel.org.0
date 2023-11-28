Return-Path: <bpf+bounces-16073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E157FC3B8
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 19:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EFA81C20E1F
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 18:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD363D0D7;
	Tue, 28 Nov 2023 18:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jb1Df+N4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367D93D0C1;
	Tue, 28 Nov 2023 18:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9D6C433C8;
	Tue, 28 Nov 2023 18:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701197506;
	bh=kIe4GvFSNAYwCeG2EmOSFaslB+FMYt6wNJYDozQC/3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jb1Df+N4ZZekGCC7vCjYVZXe+tkCd+e83bfaq+66q57mLPUU1/UofMl5QZYegD9zx
	 o4euMDmAfFGx8BPKQ9kIkH6+gNTStiaavqJK6Fk+sz8wbFvEDH/peBuy3biXIv6Mf/
	 3JXEUMvwRP7s99mMOW3AWtu8heE+vYOx57ENJSwSCtlK9fctUN2l3/PTROZ4FRZSib
	 YV5s1Y+M3OwOubMw10dFKnZc1bgwblR9+YQidwkgE3rU2NBjk2XSZGE7wsKiLryhkd
	 ptYNwyAJrRgqhCOTJ1H5+vErXnsOZx+c3Wx71vTXgLnjqPEdDv+uHPvou6kcoVs4qm
	 qLFHGhDEC1bgw==
Date: Tue, 28 Nov 2023 10:51:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 lorenzo@kernel.org, pabeni@redhat.com, bpf@vger.kernel.org,
 hawk@kernel.org, toke@redhat.com
Subject: Re: [PATCH net-next] xdp: add multi-buff support for xdp running in
 generic mode
Message-ID: <20231128105145.7b39db7d@kernel.org>
In-Reply-To: <ZWYjcNlo7RAX8M0T@lore-desk>
References: <c928f7c698de070b33d38f230081fd4f993f2567.1701128026.git.lorenzo@kernel.org>
	<ZWYjcNlo7RAX8M0T@lore-desk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Nov 2023 18:29:20 +0100 Lorenzo Bianconi wrote:
> @Jakub: iirc we were discussing something similar for veth [0].
> Here pskb_expand_head() reallocates skb paged data (skb_shinfo()->frags[])
> just if the skb is cloned and if it is zero-copied [1] while in skb_cow_data()
> we always reallocate the paged area if skb_shinfo()->nr_frags is set [2].
> Since the eBPF program can theoretically modify paged data, I would say we
> should do the same we did for veth even here, right?

Yes, don't we allow writes to fragments in XDP based on the assumption
that it runs on Rx so that paged data must not be zero copy?
bpf_xdp_store_bytes() doesn't seem to have any checks which would
stop it from writing fragments, as far as I can see.

I don't see how we can ever correctly support this form of mbuf for veth
or generic XDP :(

