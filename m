Return-Path: <bpf+bounces-782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 994BF706B17
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 16:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5613028122C
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 14:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED5E31128;
	Wed, 17 May 2023 14:30:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E375131EEB
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 14:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97259C4339B;
	Wed, 17 May 2023 14:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684333819;
	bh=XHAHWmKJoD2l+L4WoO71VJFM8hdcGRc7y5ikK/eoFGo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FSRAh9K7dtAVmRi0GRr0bOpx9tdqnlQgoEm1ELJaIrU170pmOjbJlO+JbgM5oxk4T
	 LG+M6JaRNmBmSu2tNW+hXyMW0r/VygPC9YxqNOHgeE5/Ynlp3d18dFKFmGk8Hy0aBb
	 ZiEyjHO208zGWOgSRvIUy802YUQqLvypwTNMT8zxZUfFT0eN/fhipXH4UXBBsacXmA
	 QlnVqyNyis6JqH2qs90iP/65CH1z5ABMIkR8fz1PmpKmy5e+HppMyjRnOZJ/sqd+J+
	 CfXLOs0OnWGxkqSyEJbFWQO6clMOP4LtXpvrkolvwaSKVPE31mXhFeyR8zHE17siY1
	 N54bv8juFLLmw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F909C4166F;
	Wed, 17 May 2023 14:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] Shift operations are defined to use a mask
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168433381951.21875.3211252978555314397.git-patchwork-notify@kernel.org>
Date: Wed, 17 May 2023 14:30:19 +0000
References: <20230509180845.1236-1-dthaler1968@googlemail.com>
In-Reply-To: <20230509180845.1236-1-dthaler1968@googlemail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, dthaler@microsoft.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue,  9 May 2023 18:08:45 +0000 you wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Update the documentation regarding shift operations to explain the
> use of a mask, since otherwise shifting by a value out of range
> (like negative) is undefined.
> 
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] Shift operations are defined to use a mask
    https://git.kernel.org/bpf/bpf-next/c/8819495a754e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



