Return-Path: <bpf+bounces-6116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5A57660CF
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 02:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB6C1C216A9
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 00:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3A915A5;
	Fri, 28 Jul 2023 00:40:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9D37C
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 00:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BEE3C433C9;
	Fri, 28 Jul 2023 00:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690504821;
	bh=4rkQY9vryDTHwY/A4VpPnZa8k3xr5fHxREw36cejmeM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KGXdFriUCzMC/8nttZKSM5L8Utw56AxyWaossnnrPgi6zvJ8lZ5DZljqULTkF38eI
	 9u35ZzvbZNvv2zEUYsh/TrlNX3LTkc1bZbKWkt7p78Ibj5YvbPbwrusmeuOx7604On
	 0HXace7neSm/yzdaLY2d2Zte29ih4DhWW7jFvTzSBtOJeS3MtCl55pjxNOzzN2/BnE
	 rOfVatPPEEYXwgW4yeN8A2ynpvKitxnXxaUTWhC3weCCIe9hgyq2cJJqorq+DwOXqj
	 RQJA/mRCa6t4W2ZDP88gXdveRfC7eYYnxenWFzga+nKiNOcZ69ILmC9liuHliO/cB+
	 cEcKgIxPk08og==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19812C40C5E;
	Fri, 28 Jul 2023 00:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf, docs: fix BPF_NEG entry in instruction-set.rst
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169050482109.2373.7142958660402100481.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 00:40:21 +0000
References: <20230726092543.6362-1-jose.marchesi@oracle.com>
In-Reply-To: <20230726092543.6362-1-jose.marchesi@oracle.com>
To: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 26 Jul 2023 11:25:43 +0200 you wrote:
> This patch fixes the documentation of the BPF_NEG instruction to
> denote that it does not use the source register operand.
> 
> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> ---
>  Documentation/bpf/standardization/instruction-set.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - bpf, docs: fix BPF_NEG entry in instruction-set.rst
    https://git.kernel.org/bpf/bpf-next/c/10d78a66a5f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



