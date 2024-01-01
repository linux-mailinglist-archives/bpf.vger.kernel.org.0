Return-Path: <bpf+bounces-18759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EB3821422
	for <lists+bpf@lfdr.de>; Mon,  1 Jan 2024 15:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 779B11F21730
	for <lists+bpf@lfdr.de>; Mon,  1 Jan 2024 14:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799B9B663;
	Mon,  1 Jan 2024 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDvg1PPz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08945BA32;
	Mon,  1 Jan 2024 14:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 793DEC433C9;
	Mon,  1 Jan 2024 14:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704120628;
	bh=HbcxGgcXlMXuyxE+v86hhSd89k+aAiBh13RG/nYNOJA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fDvg1PPzrFBFDkQG1t6bVUqawEdQyoQ6f7wWwixCFGr58/xQj9qsh1BMVhoE4O/Np
	 xFa20YXyc4KAhX3ogYmwF0pcFXe9CLD4AnyYyi8+gR/nD8lY2Y/VRGZmv24V4WhnNg
	 o9igBO8tfb0IthMHYSXa5xjNQZnTnF3cXZUV3TT2v8Txz2WYHS9jwxwqyk1k+jLThn
	 gnT3wQoJ7kXji+tKZFHfheq36NacYgUTPDBg5QnDBHECi6ihNXwzqM7pidmzTYPJZP
	 IIJNIHsQ5umSm57NpiCwDOOKedK4kuCvvzwCTi5NG0+/g3SvTRCiUj7/MjT2J05noc
	 ydtsIvIyBv++Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6824DDCB6CE;
	Mon,  1 Jan 2024 14:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2023-12-22
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170412062842.26004.12319099416295349301.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jan 2024 14:50:28 +0000
References: <20231222085416.5438-1-daniel@iogearbox.net>
In-Reply-To: <20231222085416.5438-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 22 Dec 2023 09:54:16 +0100 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 22 non-merge commits during the last 3 day(s) which contain
> a total of 23 files changed, 652 insertions(+), 431 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2023-12-22
    https://git.kernel.org/netdev/net-next/c/240436c06ce9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



