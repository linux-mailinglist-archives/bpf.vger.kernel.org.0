Return-Path: <bpf+bounces-19399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB83682B9A5
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 03:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 568FF1F24D2C
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 02:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E432F15B9;
	Fri, 12 Jan 2024 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkiud5YF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74960111A
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 02:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4AEAFC43390;
	Fri, 12 Jan 2024 02:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705027227;
	bh=dX2N45Brhj2IaKmRnoB/v0pecwxPoPVqX0myHV0LCNo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kkiud5YFwtZytcmee9J7uIDKs4LvleZVaeSo0Sgfk+2aLAijNrmODu0vlzyKj1tmJ
	 HM8SOcy0Q507d8qJ9dVVw1UMMeNDwPxK+aEpAIXc11zn6p30o+zcfvTIbmLD7reh+G
	 UoMYoOtGTm7DSnfoPnf47RTqE2ZZnu9+9I6Jm1gFK+DMdNfqbzpGE4VtUbvPhrS0IK
	 PUXM7foJtzA1AFF1KBCTAKfRMKTrBXe8sVBcHb2x1EmDpcRg243zZCax/+I6S/XeM0
	 27Q96Bo0t1j/jUTXU7Zl0NUsPlP7juMU7RNzxI0zaivksfvXucCO64nFvhsFnNLLkv
	 h7KmlS4pBSJ1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34B9CD8C96E;
	Fri, 12 Jan 2024 02:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] Introduce concept of conformance groups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170502722721.15005.17057115900410287868.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jan 2024 02:40:27 +0000
References: <20240108214231.5280-1-dthaler1968@gmail.com>
In-Reply-To: <20240108214231.5280-1-dthaler1968@gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, dthaler1968@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  8 Jan 2024 13:42:31 -0800 you wrote:
> The discussion of what the actual conformance groups should be
> is still in progress, so this is just part 1 which only uses
> "legacy" for deprecated instructions and "basic" for everything
> else.  Subsequent patches will add more groups as discussion
> continues.
> 
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] Introduce concept of conformance groups
    https://git.kernel.org/bpf/bpf-next/c/fd707fb8dc24

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



