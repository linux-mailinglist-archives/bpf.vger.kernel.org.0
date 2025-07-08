Return-Path: <bpf+bounces-62604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 718CBAFC046
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 04:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 692C03B089A
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 01:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D2C20B7EE;
	Tue,  8 Jul 2025 01:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsAamLvc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA99E3594C;
	Tue,  8 Jul 2025 01:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751939995; cv=none; b=FpG8q/gyxCNYNJ+/umUrNsozNcvCpNYAFTKmxP87b9vQpDunW2+XMHUpAjXjoTl3TjzALdDHZxhnX1y1ZJyaQCDGi12DaZz+keh97YeJ8MeIH6zt8mwhcYQSCE9oxUAhGTPtUnvNi91koc4ybD8K0v4hQyRY7M/j4A4BnzyOzUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751939995; c=relaxed/simple;
	bh=TLhs202vwW3I0YpG4doGK9MRpmuivZxpyIVJScs2RT0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dosWSpKPAanpE1uI2GM7hKUqEi4VTBuwrasl1TszQOTzD9AAFqV1vdWkX4IZ9O/dN1+HIkUL+6jI2qNZNhIwOD2IGcX4/EI3tPUBgvavKk7iEakiLpFK2s1gA/H1G3trw14KyHtrzblamfyAdRXJU8V+LgyN5g1itdEICgC8skA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsAamLvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC140C4CEE3;
	Tue,  8 Jul 2025 01:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751939994;
	bh=TLhs202vwW3I0YpG4doGK9MRpmuivZxpyIVJScs2RT0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZsAamLvcaUMQYGokEQv/ZInSF2PSJ6/kZyz1+rORI37AQ7uvqlRDo8LNCwXG6pcV/
	 gVdMad93iwCbuOKNoPCFL+fVbdq7Hkt+wYOlfMgzGnOzZ3bkGw7payS+OtAjiNGIo8
	 ziRTQVAwyIIMbDA+l7rR4IH1leKyxlNcfmbobA6wZNbFveHbin4svklkqM39o+MMZo
	 L7tUt850Y3676YEK3caR6fwoQVvPVI33Za6lJ9TS9xwOlz453+7f07eg2s/CxSgI0I
	 ITgzKWTi/+ZGscYq4M4+eWOg6tPZt6oaxktLLEnZQAalCuMyfMP9yfj1JHDvJpwx1E
	 zSQpVHepwVr9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD9438111DD;
	Tue,  8 Jul 2025 02:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 1/5] page_pool: rename page_pool_return_page()
 to
 page_pool_return_netmem()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175194001750.3541197.1637775374767479874.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 02:00:17 +0000
References: <20250702053256.4594-2-byungchul@sk.com>
In-Reply-To: <20250702053256.4594-2-byungchul@sk.com>
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org,
 almasrymina@google.com, ilias.apalodimas@linaro.org, harry.yoo@oracle.com,
 hawk@kernel.org, akpm@linux-foundation.org, davem@davemloft.net,
 john.fastabend@gmail.com, andrew+netdev@lunn.ch, asml.silence@gmail.com,
 toke@redhat.com, tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
 jackmanb@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Jul 2025 14:32:52 +0900 you wrote:
> Now that page_pool_return_page() is for returning netmem, not struct
> page, rename it to page_pool_return_netmem() to reflect what it does.
> 
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/5] page_pool: rename page_pool_return_page() to page_pool_return_netmem()
    https://git.kernel.org/netdev/net-next/c/61a332475334
  - [net-next,v8,2/5] page_pool: rename __page_pool_release_page_dma() to __page_pool_release_netmem_dma()
    https://git.kernel.org/netdev/net-next/c/4ad125ae380b
  - [net-next,v8,3/5] page_pool: rename __page_pool_alloc_pages_slow() to __page_pool_alloc_netmems_slow()
    https://git.kernel.org/netdev/net-next/c/b56ce8684622
  - [net-next,v8,4/5] netmem: use _Generic to cover const casting for page_to_netmem()
    https://git.kernel.org/netdev/net-next/c/4369d40da2f2
  - [net-next,v8,5/5] page_pool: make page_pool_get_dma_addr() just wrap page_pool_get_dma_addr_netmem()
    https://git.kernel.org/netdev/net-next/c/d8bf56a0ca10

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



