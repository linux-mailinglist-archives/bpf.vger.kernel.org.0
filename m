Return-Path: <bpf+bounces-7050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0FF770B40
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 23:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B875C281F09
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 21:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402FB21D39;
	Fri,  4 Aug 2023 21:50:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124821AA9F
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 21:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88293C433C7;
	Fri,  4 Aug 2023 21:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691185822;
	bh=BAt7X9vluPWqM76lsHaNbWmUW2yUmSbuh/rlyuzC/dg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fQc1e73V2IZju7eJH3nss6Ka4nu2vXSEbiZYk+PluKj1KecMkUpfVFFY7wn3gw4tz
	 8dk3h+oaZ/l0EBrhJZJ3Jc0wM0dkTgwprjr1ibl9DsHOqxhE8TG7/K4sCrBjWPk1qR
	 CbRwFsDKJFlNpdg9TLUHIdnGYoimHyS4QeKT1+TweH3htgysCQEiDxGrstrI1F+/Zl
	 qdc4YhvykUDk0rKu0NWtyFfoT1rkTiltpR9DL9Ov84SkJHquYDC91sRAO0ry7ufpoS
	 /575WzjdUVsJzpWe1jP0/ZYnKXTLX4XNDJ6KYnYGWiGFgpZVLcph4Q/eltRBrVzPMe
	 Xr37Akm03APvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C76EC64458;
	Fri,  4 Aug 2023 21:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: fix inconsistent return types of
 bpf_xdp_copy_buf().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169118582244.10513.12635313687335797910.git-patchwork-notify@kernel.org>
Date: Fri, 04 Aug 2023 21:50:22 +0000
References: <20230804005101.1534505-1-thinker.li@gmail.com>
In-Reply-To: <20230804005101.1534505-1-thinker.li@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 sinquersw@gmail.com, kuifeng@meta.com, alexei.starovoitov@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu,  3 Aug 2023 17:51:01 -0700 you wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Fix inconsistent return types in two implementations of bpf_xdp_copy_buf().
> 
> There are two implementations: one is an empty implementation whose return
> type does not match the actual implementation.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: fix inconsistent return types of bpf_xdp_copy_buf().
    https://git.kernel.org/bpf/bpf-next/c/8a60a041eada

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



