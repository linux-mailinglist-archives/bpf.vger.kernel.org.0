Return-Path: <bpf+bounces-39097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A6A96E8F0
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 07:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C06EE1C23701
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 05:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230EF56458;
	Fri,  6 Sep 2024 05:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfpO1HvK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9D91FDD;
	Fri,  6 Sep 2024 05:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725598896; cv=none; b=AjV5mmzjSVgc/B8Zr/qkzQkQPZTz1O/u6wUk7AF+qr1toMHR1dU4Y/pHbphc1fEYOsSVNHlwUpyJyt6An1LRrG8ZF2FKfuR8BmEutWYljfG5/OaKq1RyN7Wj213KjC0YkZZecrsf0w6xdMPVc4P/ynTyJw6VV/szFTgC/KEEgZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725598896; c=relaxed/simple;
	bh=zSAUcqidlL0T8yhgIi0B8P7fQTFhXGM9Q3+Pn11hvzQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hF3UOQclaGKvCVs+5BaxbZLrJbZnoNiao6yXIGxwhX7B5ru60Y01kCVeNYDL4NS0PlN0jVj8uDGEBCLdoQa9HJUFBHD+TvwYrAByZQ2nS1NrJ0xJo2/mJg17APUylFa4/OZV/sZcVcLgOJunsLM4eQRtHThblyp4OvZTmEvPJqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfpO1HvK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE63C4CEC6;
	Fri,  6 Sep 2024 05:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725598896;
	bh=zSAUcqidlL0T8yhgIi0B8P7fQTFhXGM9Q3+Pn11hvzQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pfpO1HvKZJFH7MvxNJXx1r+AydkHS68D2LODwpmj7T6TbMsijz+Ond+8hEwg/P4/p
	 F++rw1w8qHiMfEGQuYPJq5nA+6Q/ph+q1qO+bnCxf0mKr4iRSvToN8JPOyipmskMn9
	 Vb6Vdfezgdnf9MUB9W/eu6a+G89ol7Kzwbf6LrhYztCl2BmeCAVxG3hQZeYKeuXnQs
	 npAgJeHVelJce/IRlRO11WgisHZbFiefEZR5ZDTtUj4dOMYWaBp/LMdte7KproZA+h
	 0QTmeLweS7nY7YTXj7OFcexT3lZV5uJjhAEnCN/GAhniv6wefp1RPsen8qjIKE+JD8
	 i+AGZkQc9H1QA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D453806654;
	Fri,  6 Sep 2024 05:01:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bpf for v6.11-rc7
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172559889700.1937781.10220934036309219719.git-patchwork-notify@kernel.org>
Date: Fri, 06 Sep 2024 05:01:37 +0000
References: <20240906020750.13732-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20240906020750.13732-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org

Hello:

This pull request was applied to bpf/bpf.git (master)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Thu,  5 Sep 2024 19:07:50 -0700 you wrote:
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
  - [GIT,PULL] bpf for v6.11-rc7
    https://git.kernel.org/bpf/bpf/c/b831f83e40a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



