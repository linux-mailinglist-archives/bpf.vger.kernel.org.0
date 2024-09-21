Return-Path: <bpf+bounces-40166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69C197DE9E
	for <lists+bpf@lfdr.de>; Sat, 21 Sep 2024 21:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ABC7282184
	for <lists+bpf@lfdr.de>; Sat, 21 Sep 2024 19:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1882D7581A;
	Sat, 21 Sep 2024 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCp2+m4H"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915382207A;
	Sat, 21 Sep 2024 19:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726947935; cv=none; b=iOdoVhEsWEz+xaiDLotsgY3uMzxDf7RszwBLOHVO9MUKZCxEicUw/QxsHScGNwiHHwRLQqLj3egTbyagBatyqUGh7r53ekUF/T0LrFy/N+rmWANQwpv0UQE5erD35h4oahnZ4GmnFvfSFsFdH71BSluyIIm7h6R+Gu4YMykq4tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726947935; c=relaxed/simple;
	bh=nCqqyCLO0S+UDUkhYsOhcZf34yHao1FK2ajIQUP1tEc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bmg819QWTeWyA8X9N71A2NNRzGKzafDgcy8qAjfY/HEsjD5xFWuHY3glp3uZ7Oc0jWaU1ICH0rTY7b2o/cH151RsRk6ZbRAk5zm2YILY516iDm5lbIqj1Bhg0d/0KXRDwyTizcg1jI1XpeTbp9+cFVVu+wRFKORIULx0UT/CKa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCp2+m4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C02C4CEC2;
	Sat, 21 Sep 2024 19:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726947935;
	bh=nCqqyCLO0S+UDUkhYsOhcZf34yHao1FK2ajIQUP1tEc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pCp2+m4HRiS9pl5qjPJrWNGSCERSFbsXxCsWg5hmiszunYkLcrx/kuzG9zh7i9oko
	 v3mu25eaVw+uUw8vs6IbFXkgkq30C3AQGZBVBDk39trjAe35NH33NWWTa9DTSf18WY
	 J3Sr9mxBvFcNbs2aetGJHIGfKNXuLwet3I1Eo7VgNBKZEBZG5m4mtbAwKfoDESuJ2x
	 8+SLXqhl0eroIS9qPV2oFZ/xbFC7++n8tyVEkhmWj7JbP+ZG+UQqDPpx7dnixJjg6M
	 vcz9EVuLLUMlq2rw+SMciKwHA2SDymh8HcqWlkf8aOOWy5mc8k1fV9YOg0D6Jki5oc
	 vd7GI6rTBYYcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EA03806655;
	Sat, 21 Sep 2024 19:45:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] BPF changes for v6.12
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172694793729.2561812.3449583125426725924.git-patchwork-notify@kernel.org>
Date: Sat, 21 Sep 2024 19:45:37 +0000
References: <20240914155810.15758-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20240914155810.15758-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org

Hello:

This pull request was applied to bpf/bpf-next.git (master)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Sat, 14 Sep 2024 08:58:10 -0700 you wrote:
> Hi Linus,
> 
> The following changes since commit 872cf28b8df9c5c3a1e71a88ee750df7c2513971:
> 
>   Merge tag 'platform-drivers-x86-v6.11-4' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86 (2024-08-22 06:34:27 +0800)
> 
> are available in the Git repository at:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] BPF changes for v6.12
    https://git.kernel.org/bpf/bpf-next/c/440b65232829

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



