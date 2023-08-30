Return-Path: <bpf+bounces-8972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDFC78D3C9
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 10:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E72D11C20382
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 08:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E801C10;
	Wed, 30 Aug 2023 08:00:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7341871
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 08:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A756EC433CC;
	Wed, 30 Aug 2023 08:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693382423;
	bh=9vX9FiYxKejfspFyMsIR6QJXhjj0XObQ/6JZfkHTIt4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i7b8STv5HY4+gIvpzfRIyz9HC+uactAo2WguPHXouSxNbe0AhHuK57K1eOJghTCIX
	 DbDdgOHIE5vbNt/jc0okdz7Jr4N7KQkdZQfU99EtTCfLZy52MdsVT9H12eCpopPr7N
	 OTGVfEMZqYjEUQSfyxdjaKst4P0mYmhLBs2Crh1+VPpnVNuS+yE1I0Vwwzzn9Via5I
	 EVfAKPi51lBB8UJjmBHjIZfEGeRbmn94jpSeP/2onTKHH7mZeHhSKzS9b4qKrQktSL
	 7mLMKrYrQtgBiZ5FAxXiU89WXwVJmtc5LifSDii74VGUOr410+V0nBKVh3UKMWrfNy
	 y+zhiBbckK42g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 904ADE29F34;
	Wed, 30 Aug 2023 08:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf, docs: Correct source of offset for program-local call
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169338242358.2642.16128611198358903473.git-patchwork-notify@kernel.org>
Date: Wed, 30 Aug 2023 08:00:23 +0000
References: <20230826053258.1860167-1-hawkinsw@obs.cr>
In-Reply-To: <20230826053258.1860167-1-hawkinsw@obs.cr>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf@vger.kernel.org, bpf@ietf.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat, 26 Aug 2023 01:32:54 -0400 you wrote:
> The offset to use when calculating the target of a program-local call is
> in the instruction's imm field, not its offset field.
> 
> Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
> ---
>  Documentation/bpf/standardization/instruction-set.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Here is the summary with links:
  - bpf, docs: Correct source of offset for program-local call
    https://git.kernel.org/bpf/bpf/c/2d71a90f7e0f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



