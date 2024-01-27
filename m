Return-Path: <bpf+bounces-20459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55ECF83EB49
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 06:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3B6B1F22EFB
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 05:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4281E14294;
	Sat, 27 Jan 2024 05:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wf/RATHE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B515C11CBB;
	Sat, 27 Jan 2024 05:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706333451; cv=none; b=uXFWtLp757QW5EVECjTmid8miSitM2NsDRZ8uMypvt4LSZwhBbaT1uDD9ysCBecB8WMvkkeJUbMqtws+uU9NrvWDaJsGyX+6FFjo1K7AoHL8S/XqQdAr5bRdBrID08YQMuM5jTvQHHmIkLuznHC13CRB+GHwKll+42nykVNI1WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706333451; c=relaxed/simple;
	bh=q2/ahvhEv1173FX0pjJ79EAzXPQvy6pIWitcla6khk0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q/TOjI91/QdZECIMMQXl54FdcfZdDPVFrRKRz6cVl5T7zCPMgyKP3A4G4ZVtFAAkMci+wHiLThxqdxZyjLQB6Kw7j8NgMImM9hfQZtm1UqXHvm3K2N1C0jqPnKH2+aRKZDsDLkMyXujimP0QwwrBt1kJXiFIfPPVVXZl4EYp+KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wf/RATHE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CD84C433F1;
	Sat, 27 Jan 2024 05:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706333451;
	bh=q2/ahvhEv1173FX0pjJ79EAzXPQvy6pIWitcla6khk0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Wf/RATHEVrp72410KUFGbYBVlelknYEK+8lm86F56EIgE9LTjYbC8qxEn0XIk4MbM
	 4+e3+yzsbjHUtD4XNXQlDrPAiTsTQVig/d+ppCNa1H67309eh8+vMp4xojZsdxM1BJ
	 g4HLQ+5gz+XwB5iR81L6/1Md9eUxJgjZA/n3S6dh83vEuEj3V11g7MEIr2VIJiMWF+
	 GqSoKRVNDdFy1jseTl00XKRdSfZpF29sdJGIU56ZHssLFeog+MTw2qVfoeENYMpjhn
	 iW4wNTLCtWIhGkiGaTgjIwKxPX6V6WMNxqLVk14hxnjzE6aQ5uU0+ZPT+bPJtSlaVc
	 ZtzzmfZ4tC+DA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 041D6DFF760;
	Sat, 27 Jan 2024 05:30:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2024-01-26
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170633345101.30319.5253057277440239881.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jan 2024 05:30:51 +0000
References: <20240126215710.19855-1-daniel@iogearbox.net>
In-Reply-To: <20240126215710.19855-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 26 Jan 2024 22:57:10 +0100 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 107 non-merge commits during the last 4 day(s) which contain
> a total of 101 files changed, 6009 insertions(+), 1260 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2024-01-26
    https://git.kernel.org/netdev/net-next/c/92046e83c07b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



