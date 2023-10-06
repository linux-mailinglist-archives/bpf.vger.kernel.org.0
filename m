Return-Path: <bpf+bounces-11557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CD07BBE99
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 20:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91A0F28244A
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 18:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B28B37CAC;
	Fri,  6 Oct 2023 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r83wCW6U"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93B235882
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 18:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35768C433C9;
	Fri,  6 Oct 2023 18:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696616428;
	bh=AdNO4sjiUEB7fsibUiUM1hhmjR9JYPIbZe4EILeZRqE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r83wCW6UmHyNordfnmUCvtDMQCquP2R3vm1fD/J0CQ5N5oT5TUAtF7dR42OMUWhtM
	 SwipLuwk+9F5YTNe04ke9OVjgEqpdnyEGapuLt5ob9ISz8fG3vPY8B6LnHQQpsctTb
	 MY/k7cIWGCVqqJT9DKBar8kNvQnI5wgVMZqHalSn1S/XCgRYHKM+tSfDMaTjMJ3m2j
	 hGBj6KLt8jG1uJ9np5g+H8hgJlX7Ze97VRIBH92R5rAXWnOAJRh6OCu6xVI8BcozUB
	 NBq2K9ZzbwSzdvEbZT59AZM+PRj8cMBtFNvGEWVCPCHFlj9iNboozoxum2LEG5PNZ5
	 vPn0j3P+kSdzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 177B7C64459;
	Fri,  6 Oct 2023 18:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Inherit system settings for CPU security
 mitigations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169661642808.9586.8587357996810184479.git-patchwork-notify@kernel.org>
Date: Fri, 06 Oct 2023 18:20:28 +0000
References: <20231005084123.1338-1-laoar.shao@gmail.com>
In-Reply-To: <20231005084123.1338-1-laoar.shao@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, gerhorst@cs.fau.de

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu,  5 Oct 2023 08:41:23 +0000 you wrote:
> Currently, there exists a system-wide setting related to CPU security
> mitigations, denoted as 'mitigations='. When set to 'mitigations=off', it
> deactivates all optional CPU mitigations. Therefore, if we implement a
> system-wide 'mitigations=off' setting, it should inherently bypass Spectre
> v1 and Spectre v4 in the BPF subsystem.
> 
> Please note that there is also a 'nospectre_v1' setting on x86 and ppc
> architectures, though it is not currently exported. For the time being,
> let's disregard it.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Inherit system settings for CPU security mitigations
    https://git.kernel.org/bpf/bpf-next/c/bc5bc309db45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



