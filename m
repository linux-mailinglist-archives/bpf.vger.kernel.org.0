Return-Path: <bpf+bounces-38084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C1295F61E
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 18:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FDAFB20ACF
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 16:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7D719412F;
	Mon, 26 Aug 2024 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMTpCiIf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E18318E057;
	Mon, 26 Aug 2024 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724688629; cv=none; b=VYm7+ZbhzyG+iEPniP5jP/9zgsWB5xE1s/YlyWkz7rmG+QwfOOpArdzI9oMoh7ty2DhJLd4gEMcOyZDrhgtrDYQXQ5OvaDH7PEuczWDN+dDRYkgcuZvkZCOzRSnRCbzdBCE0foX7XVCfL6q4c4JeqSaIJgjSFLccI4IIdZKwJvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724688629; c=relaxed/simple;
	bh=JkUZC9vqWOlLzx35Or41UD2rH5irkJt8CEWji2TjXwg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PQEjPb08QCdu7X1l48Io5yT+n0ZFk33vxg9AYAoLnT79KwJE/ltoRMSnEQxNiEP4gkXSxW15eMUA5Mh634u9AmcIQcAL3Dfqj7mIwcjKAH6lxjdZ7h9d1vkuNGNDOt2ISRCm+hzVb3pbe960kBOQPumeoSEzX5/Pv15grKWCO/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMTpCiIf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91C7C52FC2;
	Mon, 26 Aug 2024 16:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724688628;
	bh=JkUZC9vqWOlLzx35Or41UD2rH5irkJt8CEWji2TjXwg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SMTpCiIfWuIfDPABnWnsIeFLg+UjSPnbVg18HMSicFe2zUIn93FHG3mDyhTiXnlGk
	 UK1T0SKYK5jfNT1pdolq44XOswzj5fK9eFSB+DQ1R/HNoEN5pJ1xzcOcJkGw9w1FS/
	 72Xar0JAWS8mPfl/HZVGy/CP0Q8NJRNAnm/C1yddAJdPFEesvCuWNn1LOXRuDREcMh
	 PAawyIKD8+jXWfxykR1TgPE0gFB9aKSwUZH5BGct6uD17im4Rn7bjJAE/C+wzOBcJv
	 1KekfX0f9XtgU7LetfGeq3LKsXdTgU0yW5FhgqSbwDyryg7EOJrzWRHJBzucy43Fss
	 k4f25EXMaBmRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC863822D6D;
	Mon, 26 Aug 2024 16:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2024-08-23
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172468862851.56156.6858751928241571146.git-patchwork-notify@kernel.org>
Date: Mon, 26 Aug 2024 16:10:28 +0000
References: <20240823134959.1091-1-daniel@iogearbox.net>
In-Reply-To: <20240823134959.1091-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Aug 2024 15:49:59 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 10 non-merge commits during the last 15 day(s) which contain
> a total of 10 files changed, 222 insertions(+), 190 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2024-08-23
    https://git.kernel.org/netdev/net-next/c/e540e3bcf2a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



