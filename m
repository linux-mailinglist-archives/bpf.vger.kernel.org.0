Return-Path: <bpf+bounces-3795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 404757437A3
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 10:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D3C1C20B8D
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 08:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D93101D3;
	Fri, 30 Jun 2023 08:40:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8F01FB8
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 08:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F28D8C433C9;
	Fri, 30 Jun 2023 08:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688114421;
	bh=+Kh08iQrnvO2eHcVqKsJOrCpEtYiYVstpf7VoOT+slw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e8bCXRJwdgIJpVF4mLcpUfW4fDwC+auDSxyOYHnLlWazph346rN+ua77gn197h44t
	 sGc9WDLDJnuPbdfw6T4HqFf1kWDfBV1drNBBV1lW7lL4YcefCIV0AGv860DQNNHED0
	 pBuikO6kstElgdXW9HYz6ff+jvLKU5v8fe7TiyKXZmWs/+VKEd5fCtAEQ6oShPVhFP
	 D+9LsfIh7SPuC+vB3wUYGd0HXqe+BkPHPo0Jz4eyP5Lhf1/WgvtZ0HIx9bxyCmuU7D
	 tluxSDmBa6PDmT8myNTSr7zOF+2n16DuF8lcR0GoOfxuIkiKVDOM2cdnvB6XZXtzlW
	 K8Omvjv/mCcgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5BDCC40C5E;
	Fri, 30 Jun 2023 08:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: Resolve modifiers when walking structs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168811442087.9995.12715014131569832899.git-patchwork-notify@kernel.org>
Date: Fri, 30 Jun 2023 08:40:20 +0000
References: <20230626212522.2414485-1-sdf@google.com>
In-Reply-To: <20230626212522.2414485-1-sdf@google.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 26 Jun 2023 14:25:21 -0700 you wrote:
> It is impossible to use skb_frag_t in the tracing program.
> Resolve typedefs when walking structs.
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  kernel/bpf/btf.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [bpf-next,1/2] bpf: Resolve modifiers when walking structs
    https://git.kernel.org/bpf/bpf-next/c/819d43428a86
  - [bpf-next,2/2] selftests/bpf: Add test to exercise typedef walking
    https://git.kernel.org/bpf/bpf-next/c/2597a25cb865

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



