Return-Path: <bpf+bounces-12164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283A27C8DD7
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 21:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52E181C211F0
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 19:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BCA241FF;
	Fri, 13 Oct 2023 19:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCqtc6Ei"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B116D2376D;
	Fri, 13 Oct 2023 19:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27AF5C4339A;
	Fri, 13 Oct 2023 19:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697226023;
	bh=lI9YMhqSvJP2WrE3g7wkWlJVDKheiRybUb/+yL0/2Tk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eCqtc6Eim4nCDDGxGINFFtyz89pxDsYQK8Gm+abSTI/UT7YKtuqAtIzuJHNuKPZF7
	 f3xmrTemcc7Qx8hHev40KWKHNjeWpScKvQkA8yFz1JT0nLKcc2IpNXOtU8mqvA2W5V
	 7Dvvb35MRV3Lil9m431vp22fvJRDOA0cMl/bf/btt6TUhC4ZRVJrPj537ZaiTTKpaZ
	 mmBV7d/XbDA0Y/IX/CtVxCCFvLr8P8lWfaWcvhL2xXkCeOWxmCHLD8YXZg4SCdfOw5
	 jeJD4YqL7lJE2dwqpdNIzkenXCFP8O47C0JAudy3HG9qs4aSPrAbe0ItSQfgvIwKKM
	 SN9O3beBKzKqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 171A3E1F669;
	Fri, 13 Oct 2023 19:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] net/bpf: Avoid unused "sin_addr_len" warning when
 CONFIG_CGROUP_BPF is not set
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169722602308.5697.7422019493094159101.git-patchwork-notify@kernel.org>
Date: Fri, 13 Oct 2023 19:40:23 +0000
References: <20231013185702.3993710-1-martin.lau@linux.dev>
In-Reply-To: <20231013185702.3993710-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, netdev@vger.kernel.org, kernel-team@meta.com,
 sfr@canb.auug.org.au, daan.j.demeyer@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 13 Oct 2023 11:57:02 -0700 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> It was reported that there is a compiler warning on the unused variable
> "sin_addr_len" in af_inet.c when CONFIG_CGROUP_BPF is not set.
> This patch is to address it similar to the ipv6 counterpart
> in inet6_getname(). It is to "return sin_addr_len;"
> instead of "return sizeof(*sin);".
> 
> [...]

Here is the summary with links:
  - [bpf-next] net/bpf: Avoid unused "sin_addr_len" warning when CONFIG_CGROUP_BPF is not set
    https://git.kernel.org/bpf/bpf-next/c/9c1292eca243

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



