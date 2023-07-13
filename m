Return-Path: <bpf+bounces-4892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 541DE7515D4
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 03:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F74B281AD9
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 01:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B89634;
	Thu, 13 Jul 2023 01:30:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13177C;
	Thu, 13 Jul 2023 01:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC0B3C433C8;
	Thu, 13 Jul 2023 01:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689211821;
	bh=NWhZ5/fk8wcIUkzGXqYJ0JDlupiFsYME2/6Wn0FTeNQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oxfUE0RuBhPPCAHklL+6c1xzfizVDef2ZQipUZOv0O+eHF2kQrTLNK/RhyxwwDbmm
	 kderMg65FEmIupB2uBhcnoLTR8JVYhXA+xP5Y3ajIZtkjwCWwqT81lJ8PlfPozELl2
	 69SnCU3qLouQKYsiQAT9dL4hFZW3PQBSGADEZcxY4E79PE4LyuAadz5vuP9PVMUVvI
	 DKaV1Tpt0EwnIdA9wC+G2HZs8nZWTF+yg8vbB+AsBYWbmYzGkZxiRN2nHH15ouB5mH
	 Iujowy3kOvG6s4oyu37qgItup+Iyo/e7FYhPMiYVfdHeNSwDsxlHNTSulQX11aYdZh
	 uQvHlgJUei1vQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90B62E29F44;
	Thu, 13 Jul 2023 01:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2023-07-12
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168921182158.21163.17042877267444059589.git-patchwork-notify@kernel.org>
Date: Thu, 13 Jul 2023 01:30:21 +0000
References: <20230712223045.40182-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20230712223045.40182-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, daniel@iogearbox.net, andrii@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Jul 2023 15:30:45 -0700 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 5 non-merge commits during the last 7 day(s) which contain
> a total of 7 files changed, 93 insertions(+), 28 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2023-07-12
    https://git.kernel.org/netdev/net/c/b0b0ab6f0131

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



