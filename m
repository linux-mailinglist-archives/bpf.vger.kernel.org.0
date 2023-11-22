Return-Path: <bpf+bounces-15625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E66097F3BC9
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 03:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D96A282AD2
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 02:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3797F8826;
	Wed, 22 Nov 2023 02:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+r6AqCx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE96BE4C;
	Wed, 22 Nov 2023 02:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD26DC433C9;
	Wed, 22 Nov 2023 02:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700620234;
	bh=dT3Hg7ulhpf+ge/HvLXxhqm0Tq2nMHZ+Y9IhHaW7Y3Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N+r6AqCx1pHE3wuqOmHWMVK+lKJfeEdbKj5RQWLX8icGZ+a7aRwRhj6YrIrB91Iy/
	 ZY3BfOZuRbmK6AGgUloN/2o685h+1Hw6LYo6zGTa29hzE7lQn7rqBO5yN2YksYhVB+
	 bkOXyrniO/jMqrzN3qcUGM/45QR/GjiRUcXxzBPwsrp+ycgE2Z6dzNatBlNs5P2UcI
	 DffJDPcsytfH54r4aHf5JqgdJH35wGyKJxQoIvneBWMQ/foKqfwxhfq5LfJ2FiL0+Y
	 PpW/pyXKborQjxnldiavf0MssLfk2LkLPqMkUVafe7L4pZJEgNObBQmDcFBsEmO/1M
	 9U7coRujvfAfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B2C82C595D0;
	Wed, 22 Nov 2023 02:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2023-11-21
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170062023472.27760.13951394666874995579.git-patchwork-notify@kernel.org>
Date: Wed, 22 Nov 2023 02:30:34 +0000
References: <20231122000500.28126-1-daniel@iogearbox.net>
In-Reply-To: <20231122000500.28126-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Nov 2023 01:05:00 +0100 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 85 non-merge commits during the last 12 day(s) which contain
> a total of 63 files changed, 4464 insertions(+), 1484 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2023-11-21
    https://git.kernel.org/netdev/net-next/c/53475287dad9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



