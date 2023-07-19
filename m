Return-Path: <bpf+bounces-5350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60045759CA1
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 19:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1321C21103
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 17:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D9F13FE7;
	Wed, 19 Jul 2023 17:40:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CEC1FB48;
	Wed, 19 Jul 2023 17:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96B95C433C9;
	Wed, 19 Jul 2023 17:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689788427;
	bh=2ftGLtIxSKRCtEP2jtn8t12TNHerfPQXPEuZVdUWc2o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BGwwY/0PB/5q4kxl3YfvQu3/1hIKs9yU4tCIIvypVai9CUT2QQxdcR14DJPjoDNy/
	 AmIJJx285AAh3wuH0+AbaXmUKRefhHpO7D12UYuzrBFZ+CvhARk0X4szLMenraheeN
	 8lMort3C+zZkCNl9LmUoaOstnzC6Y5iwaQeVKGILjYOcRB/5lj/e8Y6UgHLiFjO96c
	 Yjnw9j1PKgJWl59glLus3OvadSBhTVwPlMkW/qNkXSkjPSTEFFnQu1mFc4Vi16Vnw1
	 jtvuzPtwf4GjPhsK/xZ5FtihUYHHzsKn3RSbWOCT4K/ZXAS77cfxDegexM9kHiWyaK
	 zGslw58Fgf5yA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 795FAE21EFA;
	Wed, 19 Jul 2023 17:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf, net: Introduce skb_pointer_if_linear().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168978842749.14916.18363231810709222058.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 17:40:27 +0000
References: <20230718234021.43640-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20230718234021.43640-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, daniel@iogearbox.net, andrii@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 18 Jul 2023 16:40:21 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Network drivers always call skb_header_pointer() with non-null buffer.
> Remove !buffer check to prevent accidental misuse of skb_header_pointer().
> Introduce skb_pointer_if_linear() instead.
> 
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf, net: Introduce skb_pointer_if_linear().
    https://git.kernel.org/bpf/bpf-next/c/6f5a630d7c57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



