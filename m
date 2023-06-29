Return-Path: <bpf+bounces-3738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 148C77427DA
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 16:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDBAE280CA8
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 14:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4F8125C3;
	Thu, 29 Jun 2023 14:00:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121EC125B9
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 14:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CA05C433C0;
	Thu, 29 Jun 2023 14:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688047221;
	bh=M+wOumlsIYYjwRFBCl1BaHXSYklSi6MnMM2TewZZC1c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VoZvZLQO5rGI6m+s62J2KSqB9FgezaBdt3TUZwP/EvDFL3eLdD5UQcirmpnfY9+j5
	 4VrJbDOkhbr+cgq1eFc9S9GexgtHnn8fru1t6uewd8KPigCHEAyfBPMYwrQo8Ll470
	 bmmNjAZuL+wCo75A+CDXZc3mNzsbVBPtKqcytq9yD7bw2RaviuftjVFidLhGiXBB2f
	 tyrqpefw9sM9wfLfzbAQTzV0t+LGJndCPzZ80jbNtho81p0RFA03qtuWd4R8gxQZ40
	 9ORbf8RdsXmJgpr4aXb4gyq6HSCrBps7LUHKPEMlaeaPnP/3shqFjNc2oF//F14ZpL
	 K4vHGWnxjayhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61DFFC43158;
	Thu, 29 Jun 2023 14:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] Fix definition of BPF_NEG operation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168804722139.10009.5397270654906532825.git-patchwork-notify@kernel.org>
Date: Thu, 29 Jun 2023 14:00:21 +0000
References: <20230627213912.951-1-dthaler1968@googlemail.com>
In-Reply-To: <20230627213912.951-1-dthaler1968@googlemail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, dthaler@microsoft.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 27 Jun 2023 21:39:12 +0000 you wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Instruction is an arithmetic negative, not a bitwise inverse.
> 
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> ---
>  Documentation/bpf/instruction-set.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] Fix definition of BPF_NEG operation
    https://git.kernel.org/bpf/bpf-next/c/85b0c6d4905e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



