Return-Path: <bpf+bounces-16339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13ABA8000E6
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 02:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D242F2815A6
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 01:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD9417D2;
	Fri,  1 Dec 2023 01:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryFmnlIn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E6363A;
	Fri,  1 Dec 2023 01:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17986C433C9;
	Fri,  1 Dec 2023 01:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701393652;
	bh=nFKftdJBJkkXnWh6TstAte2xl9IU8vEIseHhMgB1U74=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ryFmnlIn6mVhS3zoUaGbq7BXFuuYfznL96QsyMgFE+ETrgIx9IcD1UU6v3dzGL+EL
	 5YU49yn8UXW84brJs3psNRB7E0PcMVr3KWi3rYLuZq0nkKaU2FbMd5I2MDQYHsYB2c
	 55Or5KyMIeey5SCxSgcVmG0Rhjhe85QqdRsnh8te0B9+RPioAum2vjWB1+IqVrFiwu
	 bw/+7PkfIhoGSFTaBV8vP3Joo+D8ajE4ZStcFUDSgDw6qlQD/NVuFgkD7ZiXzMee0n
	 jbz2YDWJ9gMRGPcqkrwTv2fZ9OjB6nOFtSwBANXmLulyW/JM/BSoXHt0oNFgloM9OD
	 aKlozyMbzp+IA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0D37DFAA86;
	Fri,  1 Dec 2023 01:20:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2023-11-30
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170139365198.11061.17706181086269150529.git-patchwork-notify@kernel.org>
Date: Fri, 01 Dec 2023 01:20:51 +0000
References: <20231130145708.32573-1-daniel@iogearbox.net>
In-Reply-To: <20231130145708.32573-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Nov 2023 15:57:08 +0100 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 30 non-merge commits during the last 7 day(s) which contain
> a total of 58 files changed, 1598 insertions(+), 154 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2023-11-30
    https://git.kernel.org/netdev/net-next/c/0d47fa5cc91b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



