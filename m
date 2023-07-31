Return-Path: <bpf+bounces-6481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DD276A362
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 23:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12C3F2815E9
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 21:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C371E53F;
	Mon, 31 Jul 2023 21:50:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC921E516;
	Mon, 31 Jul 2023 21:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D5C3C433CC;
	Mon, 31 Jul 2023 21:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690840222;
	bh=gzv7ts2ZRWDtzRjT+JgGh23CRnQOd9tGI4ufOpfWUEQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aczjp8g4e4hplk3hgdRTZ7J6cTmGcdOjV5A9gERhKdMeW05FzQAlPC8WXZ0C+qgwS
	 4zGOeiBfK+EHzpFdCWSh+TTO9juRXFzIEVZzpuddatkZsoy1LDdm7hkHreUp/pK5zP
	 tLl3ho4GeDNR7tXz/A/pZjUUc4bHfdegPlraUZ3c7xLYVZuhLFSavkBiVadedskab4
	 lw2XevHWAk/FHZTygMiclXt2opbeKvsEhHOoktWFeuAJGzB+bnmSOaD4L7a+wnupkq
	 HR2KgsBf258tCgiNazICqbSJQIQMD2ExGK2fC9j6uVEkDx/t2H3CjKV//B1E19skKn
	 sEH1b7ICIpTfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6CC30C595C0;
	Mon, 31 Jul 2023 21:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcx: Fix splat during dev unregister
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169084022244.13504.15898603524054378775.git-patchwork-notify@kernel.org>
Date: Mon, 31 Jul 2023 21:50:22 +0000
References: <222255fe07cb58f15ee662e7ee78328af5b438e4.1690549248.git.daniel@iogearbox.net>
In-Reply-To: <222255fe07cb58f15ee662e7ee78328af5b438e4.1690549248.git.daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 martin.lau@kernel.org, syzbot+376a289e86a0fd02b9ba@syzkaller.appspotmail.com,
 leonro@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Jul 2023 23:47:17 +0200 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> During unregister_netdevice_many_notify(), the ordering of our concerned
> function calls is like this:
> 
>   unregister_netdevice_many_notify
>     dev_shutdown
> 	qdisc_put
>             clsact_destroy
>     tcx_uninstall
> 
> [...]

Here is the summary with links:
  - [net-next] tcx: Fix splat during dev unregister
    https://git.kernel.org/netdev/net-next/c/079082c60aff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



