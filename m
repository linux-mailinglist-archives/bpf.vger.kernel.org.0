Return-Path: <bpf+bounces-7272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7781774E08
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 00:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71991C21044
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 22:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EEF1BB21;
	Tue,  8 Aug 2023 22:10:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E117910FF;
	Tue,  8 Aug 2023 22:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77FB2C433C7;
	Tue,  8 Aug 2023 22:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691532626;
	bh=vfOmk/AS3LgqOp5xnus7eud2KRDUgYjXyBTfQfQtKfE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kQ8w+BBVGk81kyk8oRDS3k/goqa0Ze8h6dyEmos/EIYXMJyFq6lzg1xAmeg7OeOXq
	 PabDluCBWognY+qAEM0QAQ4kXhRtdP4kXmm3+K1Q8qmuLkBRb6siY5tbgVLcwPsSTx
	 PmByF98FDT5EiOJW9PVBve/sdzOjMuK0Ox0X5cWjsX88eKr2srcge168GxEsYKlOkH
	 3qrkRqF81HLwHxDgerey/yB4zcWWc8dUZ7jpBvgXhEI6r4jXi5SgZSdSPKvQ0PVMJa
	 vWc030f4hXFk1sk3z1Ed7VilKuBsjtrY0HbtCve31ypm7RQ2BQvqvu8YQhG4UCrh4m
	 mTkurCqg55oxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E514E270C1;
	Tue,  8 Aug 2023 22:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next,v3 0/5] team: do some cleanups in team driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169153262638.13746.11740842045529374068.git-patchwork-notify@kernel.org>
Date: Tue, 08 Aug 2023 22:10:26 +0000
References: <20230807012556.3146071-1-shaozhengchao@huawei.com>
In-Reply-To: <20230807012556.3146071-1-shaozhengchao@huawei.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
 weiyongjun1@huawei.com, yuehaibing@huawei.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 7 Aug 2023 09:25:51 +0800 you wrote:
> Do some cleanups in team driver.
> 
> ---
> v3: add header file back to team_mode_activebackup.c
> v2: combine patch 5/6 and patch 6/6 into patch 5/5
> ---
> Zhengchao Shao (5):
>   team: add __exit modifier to team_nl_fini()
>   team: remove unreferenced header in broadcast and roundrobin files
>   team: change the init function in the team_option structure to void
>   team: change the getter function in the team_option structure to void
>   team: remove unused input parameters in lb_htpm_select_tx_port and
>     lb_hash_select_tx_port
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/5] team: add __exit modifier to team_nl_fini()
    https://git.kernel.org/netdev/net-next/c/8958ef511a01
  - [net-next,v3,2/5] team: remove unreferenced header in broadcast and roundrobin files
    https://git.kernel.org/netdev/net-next/c/adac119421c3
  - [net-next,v3,3/5] team: change the init function in the team_option structure to void
    https://git.kernel.org/netdev/net-next/c/de3ecc4fd8bf
  - [net-next,v3,4/5] team: change the getter function in the team_option structure to void
    https://git.kernel.org/netdev/net-next/c/c3b41f4c7b7c
  - [net-next,v3,5/5] team: remove unused input parameters in lb_htpm_select_tx_port and lb_hash_select_tx_port
    https://git.kernel.org/netdev/net-next/c/7790eaeb688f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



