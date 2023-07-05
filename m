Return-Path: <bpf+bounces-4088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94961748B31
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 20:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C46961C20B9B
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 18:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C70214264;
	Wed,  5 Jul 2023 18:00:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B915213AD1;
	Wed,  5 Jul 2023 18:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F817C433C7;
	Wed,  5 Jul 2023 18:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688580023;
	bh=y/6YMs1x6DXBFCu0KRrbxNvaRbujSC9jhs5LzJRBsaw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bVBfXnRCPG+DAbo9duNA6EVaS7IvksF/BylquoOVg1Co6p1+4kuy6xZGHhionncIP
	 +uXQRBrgvoCBm1ec1p2KpXcjb4CjSVNsabvcR7lnQVBsI8kZoBmIeKUBR5ibQPNMIr
	 v4+EX4aBM79UD7VIc/gX6VqK3NXUQkGoIOzT/6+zgLM2mN+h7Sy1pZ+SU3fR3we3Dy
	 MszJ5SOzv0C8l+z1GDsgLIzSk+cLGPPw6dJqXbCl6WKSjYEOqfdfie7Qmzwclu4gnu
	 O4+G2VKSC9yefcSYL8ts/ZnnXz97hL5Mgu0Xa44deYruBCTULCXzs+eMP3/PQXIi2j
	 jC3UpuzeibV6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 10FA0C395C5;
	Wed,  5 Jul 2023 18:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2023-07-05
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168858002306.7518.1447432530903034542.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jul 2023 18:00:23 +0000
References: <20230705171716.6494-1-daniel@iogearbox.net>
In-Reply-To: <20230705171716.6494-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Jul 2023 19:17:16 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 2 non-merge commits during the last 1 day(s) which contain
> a total of 3 files changed, 16 insertions(+), 4 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2023-07-05
    https://git.kernel.org/netdev/net/c/fdaff05b4a67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



