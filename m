Return-Path: <bpf+bounces-19403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670F782B9B9
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 03:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B5FB1C24CC9
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 02:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD7B139F;
	Fri, 12 Jan 2024 02:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hyk9lYk2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6D5EBD;
	Fri, 12 Jan 2024 02:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7971BC43390;
	Fri, 12 Jan 2024 02:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705027829;
	bh=3odjx/yD9/fQgMq9jz/RyMQs9Xu4ltu9qq8siYucaN8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hyk9lYk2J6u1/dssGHNjc6XwNBET6pSExwv5Ln1q8AmN8onAb6cYHofLglBAcdJhA
	 q67z6Z9l08DeEWrgZnLMikecgX/8LaTe9/K85yqTd+feDheuUy+xgVLc04Kmo13z7b
	 v6W1BMzPbXg6Ei9gEJhrjeydr8VfOuEedV7E8cPow0OerSoVqULl1Az95mcimS+7CQ
	 KgHV9MBrguPLKYt/J6Piw8RowsIUWe6f9t/6wDJWMuAyH69RDvq2EBx4FSJNQ5PO8+
	 hkhlyaitHhjy+RIsUNTx6waX+Jn+AJhFIGFUhbB0SIqgbXqOVChWK+M1FEM/4bZWwe
	 KaXSP8w17bkeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65268D8C96C;
	Fri, 12 Jan 2024 02:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Update LLVM Phabricator links
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170502782940.19866.16464441843592001659.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jan 2024 02:50:29 +0000
References: <20240111-bpf-update-llvm-phabricator-links-v2-1-9a7ae976bd64@kernel.org>
In-Reply-To: <20240111-bpf-update-llvm-phabricator-links-v2-1-9a7ae976bd64@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, mykolal@fb.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, patches@lists.linux.dev,
 llvm@lists.linux.dev, yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 11 Jan 2024 13:16:48 -0700 you wrote:
> reviews.llvm.org was LLVM's Phabricator instances for code review. It
> has been abandoned in favor of GitHub pull requests. While the majority
> of links in the kernel sources still work because of the work Fangrui
> has done turning the dynamic Phabricator instance into a static archive,
> there are some issues with that work, so preemptively convert all the
> links in the kernel sources to point to the commit on GitHub.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: Update LLVM Phabricator links
    https://git.kernel.org/bpf/bpf-next/c/32e14348077c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



