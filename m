Return-Path: <bpf+bounces-59221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF15AC74FE
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 02:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9CFA43E8D
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 00:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6986D1E521;
	Thu, 29 May 2025 00:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LD4VJ0qS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16A010785;
	Thu, 29 May 2025 00:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748477912; cv=none; b=cCSRLn0qyR/libqpHrcXIxVfTDdUtNDYhp91iVrt/3sjp++by6++Ip2wXL+4gD/GhZrBcjFUi3nl94tuSiIwVz79OOhzvsz7sw4EeD+EuB6Z/UWNQQkvk0QbDyKb/U/UFBnwOx2oPlfQ5qisKxyCzFCfP5JMZJMgG8L5sej+sV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748477912; c=relaxed/simple;
	bh=y73ULMMJo3qah/aEGucNCrDK01R28pUxwV4da1BcAY4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3o/9LlPBDDqJJfuC/nxUPW3T5E7V0OJvPVtjp7l5l9nKY9ySNb1ybq8WyBw9DDjBNHwjOw57zxTA7ypBr1qfrFrwK9XGdHrxSwCyR+n7CE+drnUH9terR9D/TfoXM+mJ0vdTDRYHIP0m872qUXy8zc6Y9BNLMMSpST4SmaM8cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LD4VJ0qS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD323C4CEE3;
	Thu, 29 May 2025 00:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748477911;
	bh=y73ULMMJo3qah/aEGucNCrDK01R28pUxwV4da1BcAY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LD4VJ0qSd6CVSOYP633hIxsrtseVG2i+WufyF8HoDB1Aj5PQKMrZOnL4Ldk+h6lin
	 uGf80FlbL05HY+TusBCVWkBQE/uqjnaFWogu5iGuzB4AGa6sbwRlmosaFhuZIwQB+G
	 zFcAakGtX3doP4uRpupawcigvkpe0WEYKQLugblFZfC1badr+QwKjiG6E0anyneAnm
	 GSemoXN4j+c+5TPbyjAhw86jQG0WYxJySsX6D8Uj36LXxaa3I2+XvwRWXk/LX5FJiZ
	 rZwX+Hi/3bKJsXctqPci1xlgbikA27pJIRTxFwFcpkLiIe0q7T+xiJleoxVFSDsX39
	 IqDY19gToMNcg==
Date: Wed, 28 May 2025 17:18:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
 <netdev@vger.kernel.org>, <maciej.fijalkowski@intel.com>,
 <magnus.karlsson@intel.com>, <michal.kubiak@intel.com>,
 <przemyslaw.kitszel@intel.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <hawk@kernel.org>, <john.fastabend@gmail.com>, <horms@kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 03/16] libeth: xdp: add XDP_TX buffers sending
Message-ID: <20250528171830.5968d18d@kernel.org>
In-Reply-To: <28b075ea-4126-4885-92a6-4633d4573f85@intel.com>
References: <20250520205920.2134829-1-anthony.l.nguyen@intel.com>
	<20250520205920.2134829-4-anthony.l.nguyen@intel.com>
	<20250527190309.156f3047@kernel.org>
	<28b075ea-4126-4885-92a6-4633d4573f85@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 May 2025 16:57:15 +0200 Alexander Lobakin wrote:
> > On Tue, 20 May 2025 13:59:04 -0700 Tony Nguyen wrote:  
> >> +	if (sinfo || !netmem_is_net_iov(netmem)) {
> >> +		const struct page_pool *pp = __netmem_get_pp(netmem);
> >> +
> >> +		dma_sync_single_for_device(pp->p.dev, desc.addr, desc.len,
> >> +					   DMA_BIDIRECTIONAL);
> >> +	}  
> > 
> > How can we get an unreadable netmem into the XDP Tx path?  
> 
> For now, it's not allowed. This is future proof. I have plans to allow
> XDP and devmem to co-exist when the XDP program doesn't want to access
> frags, only headers. In that case, why forbid?

Nonsensical code is harder to maintain. Someone may need to refactor
this later and waste time trying to figure out why the condition is
there.

Plus in patch 1 you remove legit conditions to save branches and here
you seem to happily sprinkle dead code.

