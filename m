Return-Path: <bpf+bounces-37964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9520795D410
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 19:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 333732839B3
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 17:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A338018C90C;
	Fri, 23 Aug 2024 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ME9QvdB0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27483187332
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724433031; cv=none; b=Rsm2YBRGW9MBl0oedd1XelVZpkR1cKXM3Dc4zYCQ+2HPzvaaI/3My9ky4u9whNg7NV5qLlzcGHcbwasU8zxutsQ1mMk6FLTugfU33G0XYD1e241KwTeKsUsGmGM2YxCNFG/ZXkr3Hz9qdKJOai945q9RQaNIJmNO9gD8qiMLetA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724433031; c=relaxed/simple;
	bh=AIMaf3xOxaMSnYCjxjPadHhBNRqs/8hbkfKft2NS9CM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Co9vbNTCHc0TONRsVZx6EuAi3ET9fiAitWhTikT4+pLRhzYEPwovmaOxF4raw6ngSzeiFkGekS5r1OSp5tZoifvzwoigJwgj573i/Lf/OhwiqOwuRaQquHX2l2PLsPzvaIPUBhcLjos+Fza0pb+C9RkWDm4LkLGlCIE4XH4Ew1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ME9QvdB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8145AC32786;
	Fri, 23 Aug 2024 17:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724433030;
	bh=AIMaf3xOxaMSnYCjxjPadHhBNRqs/8hbkfKft2NS9CM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ME9QvdB0AapFNgrZjRV8+Sw9uIis0JxXFrRo/BykaFM9mE7eVVTgf4uEOCQPjmDpJ
	 mqCc4o7nmvapuGoBsBp9Ha55uof16B3TOua6uwbQePeM5ulNHz4PUY1Bvkzw/QIU6g
	 A5FfsGxAeV85BwBSs0K0Pkl8HRYgIMJY7XZ+dJ1fCJMGuLzbQCURcFWd0H3y2MkQ67
	 Zi9OHBXtY7q9gA88y6w2oJjYznbFSNxZxWxU2ksy4cCDNsGRNulRpp6Ux12aVaKtfL
	 9bF2p2rKOOgj1dua46qK7oHAglSf/lECZ0miiyPF2sWI4vwsIe0yYKfWlSHs0yWuKT
	 6EgTn3zsDAVMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FE13804C86;
	Fri, 23 Aug 2024 17:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: add multi-uprobe benchmarks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172443303029.3033616.16119725205896769026.git-patchwork-notify@kernel.org>
Date: Fri, 23 Aug 2024 17:10:30 +0000
References: <20240806042935.3867862-1-andrii@kernel.org>
In-Reply-To: <20240806042935.3867862-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  5 Aug 2024 21:29:35 -0700 you wrote:
> Add multi-uprobe and multi-uretprobe benchmarks to bench tool.
> Multi- and classic uprobes/uretprobes have different low-level
> triggering code paths, so it's sometimes important to be able to
> benchmark both flavors of uprobes/uretprobes.
> 
> Sample examples from my dev machine below. Single-threaded peformance
> almost doesn't differ, but with more parallel CPUs triggering the same
> uprobe/uretprobe the difference grows. This might be due to [0], but
> given the code is slightly different, there could be other sources of
> slowdown.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: add multi-uprobe benchmarks
    https://git.kernel.org/bpf/bpf-next/c/f727b13dbea1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



