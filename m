Return-Path: <bpf+bounces-22247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AB785A1F7
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 12:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E5B5284575
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 11:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52082C1B4;
	Mon, 19 Feb 2024 11:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLQqGbgM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447B628E39
	for <bpf@vger.kernel.org>; Mon, 19 Feb 2024 11:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342225; cv=none; b=LDav6oG9hoiJd98A8piUmV0DB9cqQDP9I79ynVTkDVNem6Eu9E9a8p+hoEPq7uiYG9W/g8yzBMiElM2J7QNGSrSd3Y4Ji5V99QWS+AYwF22tY10gUSGGzR7vUjbeOKBvisMHPAzNCZVWRgh+r5BPw913jOIglEHklI7F21gjKII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342225; c=relaxed/simple;
	bh=veC/W8pd59pSiyE5RumucZCjBapQMqvN3UhCKtia4hA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q40RiWv6blwez2TCZnCu8+O/rs+QOmKumGpp7192Z8rNkj5iP+1PxxkVXEBGPARQFEfjkhNu8WJZVpdab4/8JJ4WX6IqFG1bY4Y17P3gwVPlAlOgiyxwqtg2NjEQE/c9mfssNMrz03XagXEDWhM8cYYUqcER337ppB+JZKtmdPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLQqGbgM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05A24C43390;
	Mon, 19 Feb 2024 11:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708342225;
	bh=veC/W8pd59pSiyE5RumucZCjBapQMqvN3UhCKtia4hA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vLQqGbgMrz3jnYDXP0BYW9SCIcOI0u/SThqOKuCNylnJUGIlJKdn+w9WZgBpKoJvK
	 0j5rPP3zcvMJUXkAJTd5sNBIb5iVw7w7uRXA1jyZJehul/VcIF6OI7hRsl2C5aP7/9
	 xVeokwlD+FYyuckSd05nbLf8k0Q/t3mypqyxRsaGW6SeGpaWQUz9kIzg/v/xNumM7p
	 eb4YgOuz4p1y8PyhQYeo7VZ9dpNQkNerV8gFwUSRjirN0SEFmvO12yrCODVZ0D2/SX
	 Won36WRDW1ZdQXsFy/HTPvNRyOtC6mGLfzX6X6FK56byQLE+5CAkkS2GgO7rLFNK05
	 ppjfC7Z1MZI4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1306D990D8;
	Mon, 19 Feb 2024 11:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/2] bpf: Fix racing between bpf_timer_cancel_and_free and
 bpf_timer_cancel
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170834222491.2406.2120266673187455106.git-patchwork-notify@kernel.org>
Date: Mon, 19 Feb 2024 11:30:24 +0000
References: <20240215211218.990808-1-martin.lau@linux.dev>
In-Reply-To: <20240215211218.990808-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 15 Feb 2024 13:12:17 -0800 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> The following race is possible between bpf_timer_cancel_and_free
> and bpf_timer_cancel. It will lead a UAF on the timer->timer.
> 
> bpf_timer_cancel();
> 	spin_lock();
> 	t = timer->time;
> 	spin_unlock();
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] bpf: Fix racing between bpf_timer_cancel_and_free and bpf_timer_cancel
    https://git.kernel.org/bpf/bpf/c/0281b919e175
  - [bpf,2/2] selftests/bpf: Test racing between bpf_timer_cancel_and_free and bpf_timer_cancel
    https://git.kernel.org/bpf/bpf/c/3f00e4a9c96f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



