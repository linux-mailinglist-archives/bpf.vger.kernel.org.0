Return-Path: <bpf+bounces-15607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2DA7F3AB8
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 01:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAA182828D5
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 00:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DA217CB;
	Wed, 22 Nov 2023 00:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afgm2IYh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BDE848A;
	Wed, 22 Nov 2023 00:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 329B8C433C7;
	Wed, 22 Nov 2023 00:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700613038;
	bh=pKoKyJCdtQ9ATSUX6anycivX3LlJ6oj7OwTxAwmox2U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=afgm2IYhJeud4sG9g/VkARk0SXfWm2I0E56TGy0PoKbFOxxgwf+XZsOYvdwDUb1E6
	 fSl2ueEUj3kTCL5UxMa17SwTWbI1HUbGvpP/FXI4xW8T3pk3uJo51p+tIrAZ4/tFy3
	 qEUvbI37gncbXqeGhCFQZ+P7lEz3EZw/GxDjLH29MnubDGT4bXt1I6rf1r/obO8kpi
	 HNKg69fi7HUgyN2u7iFUrdslSjxqUUhY/iUo+TLpLJhhnMF8EYCtxVRCtpCZgP7swB
	 xeHWu4A4wLdIA91UV7i+6cqtMxet3uQ86tQYJ+tGp0OBD96jKw/abBsxsB7ShExSdT
	 8LiF1tZGDjmjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 178E4C595D0;
	Wed, 22 Nov 2023 00:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2023-11-21
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170061303809.32016.10820857803420312469.git-patchwork-notify@kernel.org>
Date: Wed, 22 Nov 2023 00:30:38 +0000
References: <20231121193113.11796-1-daniel@iogearbox.net>
In-Reply-To: <20231121193113.11796-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Nov 2023 20:31:13 +0100 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 19 non-merge commits during the last 4 day(s) which contain
> a total of 18 files changed, 1043 insertions(+), 416 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2023-11-21
    https://git.kernel.org/netdev/net/c/b2d66643dcf2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



