Return-Path: <bpf+bounces-34248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C1A92BD2E
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 16:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CBFA1F25FD8
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 14:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAC319CCED;
	Tue,  9 Jul 2024 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZu8lsHP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9189917F508;
	Tue,  9 Jul 2024 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720536032; cv=none; b=M1pWqD69KddG8aZZhrtogd7Y3ujbP8zoVOJonUs+ZvQaSEGyVm79bEQgtYJw4JQ7n7LAe7bXDG5lpmNuCdmBoRFYCTIFdco0temeCwUtMfbtEfliXO0bZmsMQUm0O4e0XONAFSjIlYED6MnHiajE0xgX9xKZWyrwevuyZN2vxgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720536032; c=relaxed/simple;
	bh=zyyjHcL+5g55pZ+UqSZsC5igOxO5dCqq80oqXvYeiMI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pDv1fbdpDRvsZEXNA1UbxJQKCBlJGH7gZ87NgmZu0VHc8AlOKRbna27NvOfbHVxay6+gVSn05Iv5ZFkfALa0rJGakAAMHRwfydSoRP/D3UJ7MLdMjHLJ+kdpXKturixl4RgUaWg9X3x94a9BGRCL3WAjZ/8JGWRYoPD57xQpSIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZu8lsHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2BAD9C32782;
	Tue,  9 Jul 2024 14:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720536032;
	bh=zyyjHcL+5g55pZ+UqSZsC5igOxO5dCqq80oqXvYeiMI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FZu8lsHP1MSe0X7DXJjzy6YdSugYQeEldK5yrSdU1n2qkneOsInP04wfNzqm/uxFW
	 nJuv69+3EeNmww3dIjpHUzIGpLR3WKHSJ1xCcCx4IX6nQF5wTafyCG8OBRPp1lnEXp
	 JjqdaCBmsFMtRxTztfxqOy02enkyyv6Cw8Vz4Z5h7/fouF1yh0dp9wEbi/ieoKHBJw
	 gEuzEH6/e9IUmGafEwikKPq0Wij6DdEvSeHXUC+R8OVMXLMz3NiTFeOwmCGuse9IRy
	 KR5AxVYK+TGkOvOYsB8iM+M3eqRYAhU3BFQrGb/eQQs+oEACPvxBKPfkJnB/YHTEnB
	 C+wwLm8ONaWmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1851DC4332C;
	Tue,  9 Jul 2024 14:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2024-07-09
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172053603209.3201.3771703484874814174.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jul 2024 14:40:32 +0000
References: <20240709091452.27840-1-daniel@iogearbox.net>
In-Reply-To: <20240709091452.27840-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to bpf/bpf.git (master)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  9 Jul 2024 11:14:52 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 3 non-merge commits during the last 1 day(s) which contain
> a total of 5 files changed, 81 insertions(+), 11 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2024-07-09
    https://git.kernel.org/bpf/bpf/c/528269fe117f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



