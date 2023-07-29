Return-Path: <bpf+bounces-6288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD3D76793F
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 02:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6308228263D
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 00:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171A020FBC;
	Sat, 29 Jul 2023 00:00:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFF7525C
	for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 00:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26103C433C9;
	Sat, 29 Jul 2023 00:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690588824;
	bh=DKZ/JHNEFbnezCIs8YoIX6InKJj6iDWI6Zgki8tf3Qs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FaeexzjCDdA3X/ni9RViZRgDvyJtV8frlpbLu0M5mGV158kjkyeRXV5I/WyoJ7gOw
	 Kwa9JJQ1Ru/FaSUuzaOzZEzLcPJa5NizqehGao0JqkSL0IGO16W7e/CfrX7KXb2ykX
	 GK6VSMBqfTIbkE2bofypxO99AK2bRjbT4SXzv16uW7G+fkGwbcJpkNt+LdAYqLupi9
	 3hYsknUIiqSNLvp6ezWSJgNQ0PYZd4FiWyx38LxRLglb8xHagojDxegAFrpg6/9ws4
	 w1XpNERwhCUu06fdRGCd+pYzPbP0eIxX83CJMMQ8Ezy5m3vU109O+sI0tOgZ5KstmD
	 w1T1zLwwnDNDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F2ED7E21EC9;
	Sat, 29 Jul 2023 00:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] docs/bpf: Improve documentation for cpu=v4
 instructions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169058882398.20221.5653194032118211622.git-patchwork-notify@kernel.org>
Date: Sat, 29 Jul 2023 00:00:23 +0000
References: <20230728225105.919595-1-yonghong.song@linux.dev>
In-Reply-To: <20230728225105.919595-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
 bpf@ietf.org, void@manifault.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 28 Jul 2023 15:51:05 -0700 you wrote:
> Improve documentation for cpu=v4 instructions based on
> David's suggestions.
> 
> Cc: bpf@ietf.org
> Suggested-by: David Vernet <void@manifault.com>
> Acked-by: David Vernet <void@manifault.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] docs/bpf: Improve documentation for cpu=v4 instructions
    https://git.kernel.org/bpf/bpf-next/c/ee932bf940d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



