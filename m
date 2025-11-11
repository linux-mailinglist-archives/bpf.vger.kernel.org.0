Return-Path: <bpf+bounces-74118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B4891C4A96C
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 02:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 816414F83EC
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 01:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E51342CBC;
	Tue, 11 Nov 2025 01:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCH9KdN7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5426342C9E;
	Tue, 11 Nov 2025 01:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824067; cv=none; b=R645TFezq5GDgTFP0fmBGTZU772FdhN9HMJ8za4UiGoP/OhAszOkaFf9B3MmyNb22XTt0Zv5+TQDWLA7U+zL5wEt4LJkSo5g7N68FPJF1QQxNqdCosdZ/SKg6p7JHRgWz3qRVFPKXYvWyJacJACAEnXKTvYJAxealhi96FZacdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824067; c=relaxed/simple;
	bh=FFdV7/cFIweorkOByCrSnPpy45GjXad1Gn8uHcP1V7Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S76UP8IEdH7r+tsCW4EMdsoww2Jmvr58ri3j/AkS3Id/HU586fgsf6C80L9qNa3nB7LaEkVG9DFGvPNHk5I+Db7VCmnwVrF9zIt6rAHEWcB1x4Gjx4L3sq7/kxxBpQ+IfNtNqdvN6cgd3r9uIySpgFjKu7HHhFproipAf4SUtMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCH9KdN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67288C113D0;
	Tue, 11 Nov 2025 01:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762824067;
	bh=FFdV7/cFIweorkOByCrSnPpy45GjXad1Gn8uHcP1V7Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uCH9KdN75Tfe5CwQoOlmgnaVW53VfftRPiKnGCratYOJ0L+DAWfwVojmNe1gFCHVg
	 hq6GbrkiSI3vOKo3zO1GHVytU161sTpW8FX8zMExv2957wLCFpH/K+dTZIZ3RwO1Cu
	 yT9jAawH9kQUYC2fgEUBi067WQbaxenEx/tBZzLZvSES563rKzKoO0c4uf6UNLGqsc
	 sWD1Gu/nyEr3/ufZLybUQMet+dspn8/8D48IYbUcrNN7Ad6dFdM2Hc3QfwSUC6WnzD
	 ySzFoI/QjPTq5IwVJ4/6btKoN6m172/uPX92qoy6WWgN9Y52HYMo5piKHEnywqR3To
	 tBXvCIQZJgvrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D7C380CFD7;
	Tue, 11 Nov 2025 01:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2025-11-10
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176282403774.2838761.9222389956838334643.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 01:20:37 +0000
References: <20251110232427.3929291-1-martin.lau@linux.dev>
In-Reply-To: <20251110232427.3929291-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Nov 2025 15:24:27 -0800 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 19 non-merge commits during the last 3 day(s) which contain
> a total of 22 files changed, 1345 insertions(+), 197 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2025-11-10
    https://git.kernel.org/netdev/net-next/c/7fc2bf8d30be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



