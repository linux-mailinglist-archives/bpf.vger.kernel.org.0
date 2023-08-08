Return-Path: <bpf+bounces-7276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ECA774F8D
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 01:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 384B72819EB
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 23:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754F11C9F6;
	Tue,  8 Aug 2023 23:50:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4A4168D8
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 23:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70B90C433C9;
	Tue,  8 Aug 2023 23:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691538620;
	bh=Ces+s396c5OoSkhXY0IyFMpBrEVGjD0rJpV5tfiX/U4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=opDYAvqQq1PHHHa9oE1yBQ6YlhszQGdq5QIHCAIAACN86OCIGafgXEhtKOkAJTDBb
	 sXABGj0469fZg7+TKVN8WTxXLkW6ZueXaWAczOkwyo9feNnCKy6I3+fL/HC8SIUjVi
	 AckS4t7TVVeb35KJbf4t2KhBrgxBKEXj/ftHx7fOERjGh03Rqgjsl5UV3PFutDrp6C
	 A7P6mXYCSQUoPbVzV5XX0gCFI5oVBV/pNDHNXsHPgZFNHOixXsSzNPg+rvq7FEEVro
	 BvBHPGRljFXqzkFSxT8F+Z8QB6BO4QwljOY1k5r99DPXdJ20zs2F6PVKqSTXPTZM9Y
	 KfTsAi3oCJv5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 579C9C64459;
	Tue,  8 Aug 2023 23:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] bpf,
 docs: Fix small typo and define semantics of sign extension
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169153862035.1266.6072037489780536932.git-patchwork-notify@kernel.org>
Date: Tue, 08 Aug 2023 23:50:20 +0000
References: <20230808212503.197834-1-hawkinsw@obs.cr>
In-Reply-To: <20230808212503.197834-1-hawkinsw@obs.cr>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf@vger.kernel.org, bpf@ietf.org, void@manifault.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue,  8 Aug 2023 17:25:01 -0400 you wrote:
> Add additional precision on the semantics of the sign extension
> operations in BPF. In addition, fix a very minor typo.
> 
> Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
> Acked-by: David Vernet <void@manifault.com>
> 
> 
> [...]

Here is the summary with links:
  - [v2] bpf, docs: Fix small typo and define semantics of sign extension
    https://git.kernel.org/bpf/bpf-next/c/e546a119801f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



