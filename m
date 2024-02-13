Return-Path: <bpf+bounces-21900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1803B853E7F
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 23:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68C61F2712B
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 22:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958456215E;
	Tue, 13 Feb 2024 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yb1pr4Av"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C9B60BA6
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707862827; cv=none; b=RillmXqCUZM/UVFef3v6Xwl8fzzYa4tWmljNNaKzz54p4G1tmpCyO7BqjCZ/on9ei5BXL8NqzH+UUjLgbrHjLqgHBJExXcLfDGLhtgLHJiC0sts1ywkvZ1n/AIpi1yzDRZ6fq+xD/uFINlLj4EwKaRQkwDz9t6ddqwS7LOh7SQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707862827; c=relaxed/simple;
	bh=/dEgX25dF5ESEw2ubYSxlrVY095Ksv+wxCbSbxXLiQ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B/9eP37Nys7Z/bdgpqJaVKe3OHi7wx0I4cRXs8m4Ik499HShsrovfxyNaioj4u6+0/pgzWcXvblSh+1Bmce0WgRme/86Uig/hUsTldRH1eSL1faBju15lEWm61KcJTSx5v3wE438+IZTW4XkrmDC0UEXDhUCBaZ6SQPqfTfEMvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yb1pr4Av; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90C96C433C7;
	Tue, 13 Feb 2024 22:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707862826;
	bh=/dEgX25dF5ESEw2ubYSxlrVY095Ksv+wxCbSbxXLiQ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Yb1pr4AvrED1Sj/+0lS7CYI3Rx/xqAblma14NcOs5b/jYygtEsRmIZ5Q9aMlblKAz
	 ZyK9EY1453NZsPJr6ScqCWZeWOI+ZSrQ0hPJsb+Npsic3UqjFQJEc1bQkPTYwKB0m2
	 a9ldVVraOIxIFDciuDUoVa8gxtpjxN77Znx/GPJ8oN2OazuL8hn2QpusSLjWdMHmcH
	 lUsm+UQBOGGirxyVSMR50NypQKuEiANG7PG9Ioxez6A9dBis39O/IAQ/COTO+Kda5+
	 s7pxYvFf/V7qLbPm26ccXRVwKhVFS3b6oMJu9346/XbTI7sRiWZRDAahN75c/289o/
	 qb82o4wvaNNYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75C0AD84BCD;
	Tue, 13 Feb 2024 22:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] xsk: Add truesize to skb_add_rx_frag().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170786282647.9415.14897324858662293485.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 22:20:26 +0000
References: <20240202163221.2488589-1-bigeasy@linutronix.de>
In-Reply-To: <20240202163221.2488589-1-bigeasy@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: bpf@vger.kernel.org, bjorn@kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, tglx@linutronix.de

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri,  2 Feb 2024 17:32:20 +0100 you wrote:
> xsk_build_skb() allocates a page and adds it to the skb via
> skb_add_rx_frag() and specifies 0 for truesize. This leads to a warning
> in skb_add_rx_frag() with CONFIG_DEBUG_NET enabled because size is
> larger than truesize.
> 
> Increasing truesize requires to add the same amount to socket's
> sk_wmem_alloc counter in order not to underflow the counter during
> release in the destructor (sock_wfree()).
> 
> [...]

Here is the summary with links:
  - [bpf] xsk: Add truesize to skb_add_rx_frag().
    https://git.kernel.org/bpf/bpf/c/2127c6043836

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



