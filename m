Return-Path: <bpf+bounces-11382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F5C7B83D5
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 17:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id ACFE6281C72
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 15:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC1A3FF1;
	Wed,  4 Oct 2023 15:40:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7F51B26B;
	Wed,  4 Oct 2023 15:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80105C433C9;
	Wed,  4 Oct 2023 15:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696434028;
	bh=nkNFy26EseBsFFT7sUMYFpr2rWtycQ0WGNJcGO7xvIQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Pb9aBfSSmoUsV28OYjvpvo4F5XeALMe8vUC1xrjfndoOHP3MkaJDg5donVmEm1hBR
	 sESRH4F4Ql7admSR0B65OytlA6k8nTCRIeN6MzxKELQQGJofsn7bQb5GAAUoypaG9U
	 2pphhNI8Drp21Ms85uKEynouH9kB7YYkt3TMeQAD3C+Fu/emy/NpZ8xU7Uw80eVv1A
	 tq1OhJIYc5a3lBDboqw2AG+zFfpY6YjJfLgP0SIHfhPVfSG8nDQtpQqoOHfuiN6w84
	 rGs2+qtM+7eIyQa1O/EKgTdd2qUf0het0+K3ZPvhclEwMryFcwjFmS1LudatzcSuXW
	 oBshjA8GF+nyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 63B61C595D0;
	Wed,  4 Oct 2023 15:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2023-10-02
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169643402840.27884.3176997465575741287.git-patchwork-notify@kernel.org>
Date: Wed, 04 Oct 2023 15:40:28 +0000
References: <20231002113417.2309-1-daniel@iogearbox.net>
In-Reply-To: <20231002113417.2309-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Oct 2023 13:34:17 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 11 non-merge commits during the last 12 day(s) which contain
> a total of 12 files changed, 176 insertions(+), 41 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2023-10-02
    https://git.kernel.org/netdev/net/c/1eb3dee16a52

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



