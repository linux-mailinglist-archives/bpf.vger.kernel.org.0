Return-Path: <bpf+bounces-5385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD7275A2F1
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 01:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DFAD281BAF
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 23:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CEA263B6;
	Wed, 19 Jul 2023 23:50:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8EF1BB27;
	Wed, 19 Jul 2023 23:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37A2AC433C8;
	Wed, 19 Jul 2023 23:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689810620;
	bh=6wsN5ft0umc4WV6oIlZsrq9PINXJlNatsSzfS5bvR+4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F+P/pELrppNqGwIn+mQJ7bz5zLcmbP9lQ0q1J41IURl+VWym1BCaks5Weri74PKX+
	 dtQAN6vDP5H9pDx//7CI6uwnhfWc9r/YaK7K+GXI06iu+UWCFa2KzVjfK/2WyiFSC5
	 WRZGJ9iCo107VFlQ/DCAbdY8sZVCKp8k4J/9V8sO6KC0bTkSo+/7T7IDUAZN75ASAv
	 kmT7MyjLF16+iajbfyV88HqBDTJmTD7CDq4fEnTaN6qXX4twly64o15QJkUX01nBvh
	 wcePp+0gjBGtrfEpTyxqi7Y2ntfWSO26VsYR+QBm11RZ90MB+bugOdIpIG7Ns8q+Sq
	 6ju9/Fx5EWlJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D1EAE21EFA;
	Wed, 19 Jul 2023 23:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2023-07-19
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168981062011.16059.9268032489910910482.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 23:50:20 +0000
References: <20230719174502.74023-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20230719174502.74023-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, daniel@iogearbox.net, andrii@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Jul 2023 10:45:02 -0700 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 4 non-merge commits during the last 1 day(s) which contain
> a total of 3 files changed, 55 insertions(+), 10 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2023-07-19
    https://git.kernel.org/netdev/net/c/e80698b7f8e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



