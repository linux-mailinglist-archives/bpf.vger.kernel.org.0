Return-Path: <bpf+bounces-32210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D687890955E
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 03:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62BDC284A8E
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 01:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6412B5256;
	Sat, 15 Jun 2024 01:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJmPutmU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAE01396;
	Sat, 15 Jun 2024 01:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718416232; cv=none; b=hON0Ou3dGVPCZsylG313cgM8L7MIyO3scU3wp8XlIehSNa7ZdH6QKdDMDgh86m1N2upXqXNyhQU4u01+rGLNzQLm3CgaNhouR9rQOboIJuQOz7i714FV9suqWsTOeivqxxyDnt56Mij8U18ChTxP3kLgxUJyLW8PdcXpY7t9rFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718416232; c=relaxed/simple;
	bh=oimMEDP3KlUxDKSZudA/NIUUBekqHfLip7MbA1d5XYk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jzf+P5QDHSBjGQxZqEMVwgIg7ylnSm4KaxqMp4814UDX57rK9rzSyRQsfIjoGcWEU6Glt9T3tcbaB7ioW5IxXTqio7f8V5KF6+7zPWQDrZESSUkd20AiXjqxR7L0f+/y4JMhbmGvpkutEVmhPk1Cod+YjKskY2d0EXkCUJTKpug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJmPutmU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83B2CC32786;
	Sat, 15 Jun 2024 01:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718416231;
	bh=oimMEDP3KlUxDKSZudA/NIUUBekqHfLip7MbA1d5XYk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SJmPutmUW1vTLBCbA3f4F3Me6ZXdp8UWQiIq1hpHX5Bedd5nAfiyJ2zKwmQ4y4Jn7
	 gKkYYcz6StkjZRs71HXWHignp+a1reiSjgsRYVPxEhF9O6Tq03y+n/Z5rzwFPdF3Uk
	 4/ahMCRvL/SAIlMk/iyD7Jx1l53Eare+xi4zqGfsx4vwDUxzjprRgmiyXHutGPVsM1
	 7FBFjDPIF+aGr7tSaHcrN2hlfi9JU5ioqhJfHx+rSopnnUZv+g4fnYWfIKawHIy1lE
	 D4TaDT/tICPAC95Ie3/ami5ZpN40h9qLkv5cKrTcDmSz5MUnvUXwnuhLS3nRpEQawC
	 sttvFbyBtakFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6F31AC43619;
	Sat, 15 Jun 2024 01:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2024-06-14
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171841623144.3120.15362052319177248923.git-patchwork-notify@kernel.org>
Date: Sat, 15 Jun 2024 01:50:31 +0000
References: <20240614203223.26500-1-daniel@iogearbox.net>
In-Reply-To: <20240614203223.26500-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 14 Jun 2024 22:32:23 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 8 non-merge commits during the last 2 day(s) which contain
> a total of 9 files changed, 92 insertions(+), 11 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2024-06-14
    https://git.kernel.org/netdev/net/c/c64da10adb57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



