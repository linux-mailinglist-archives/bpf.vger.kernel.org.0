Return-Path: <bpf+bounces-13125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDCA7D4D20
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 12:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3691C2819B8
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 10:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089C0250F2;
	Tue, 24 Oct 2023 10:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/RmK+xz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6790F224EA;
	Tue, 24 Oct 2023 10:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5E41C433C8;
	Tue, 24 Oct 2023 10:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698141623;
	bh=iO4auww4oOgMuGBjwjfmLREbF1ZFa0JkFzcxjMaOb8o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o/RmK+xzUz7nSYvWcTTAJjngQ7ywOnBD65Yc5nJVFueNu3Sb7o853+eeMCYHhYJQN
	 v83WTzm7UKnsoOGtiPK/XKWTqF4edJx7ovt4NWdyxKe4N+QreXzTliESJhTlQ93tjl
	 UBfRNN4PZlZ9AjmYk4EJ/KmSK7A4NIOOQ9kWEACF5b/pOZCSeDCJ7oEc7JPDOp97HC
	 JHwUZzjZv9MUHxQaovD+LJtyaOIBvsCOpG+/I/vaPhuasJBZVopBO9+omT9mQ94cHY
	 b8Cb13yA6MTuB8DYKSpBwJ+W8HCv4JqN2IBsv7aw8yFnbtCTY/iyeE1LJxkLMa0CiB
	 Aj14+aVGkRw5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9B798C00446;
	Tue, 24 Oct 2023 10:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next] xsk: avoid starving the xsk further down the list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169814162363.10002.5808190807858257955.git-patchwork-notify@kernel.org>
Date: Tue, 24 Oct 2023 10:00:23 +0000
References: <20231023125732.82261-1-huangjie.albert@bytedance.com>
In-Reply-To: <20231023125732.82261-1-huangjie.albert@bytedance.com>
To: Albert Huang <huangjie.albert@bytedance.com>
Cc: bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 23 Oct 2023 20:57:31 +0800 you wrote:
> In the previous implementation, when multiple xsk sockets were
> associated with a single xsk_buff_pool, a situation could arise
> where the xsk_tx_list maintained data at the front for one xsk
> socket while starving the xsk sockets at the back of the list.
> This could result in issues such as the inability to transmit packets,
> increased latency, and jitter. To address this problem, we introduce
> a new variable called tx_budget_spent, which limits each xsk to transmit
> a maximum of MAX_PER_SOCKET_BUDGET tx descriptors. This allocation ensures
> equitable opportunities for subsequent xsk sockets to send tx descriptors.
> The value of MAX_PER_SOCKET_BUDGET is set to 32.
> 
> [...]

Here is the summary with links:
  - [v4,net-next] xsk: avoid starving the xsk further down the list
    https://git.kernel.org/bpf/bpf-next/c/99b29a499b5f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



