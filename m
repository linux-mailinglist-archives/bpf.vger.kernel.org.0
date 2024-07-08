Return-Path: <bpf+bounces-34084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F77E92A4E6
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 16:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 157E6B22B48
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 14:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCB713212E;
	Mon,  8 Jul 2024 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4SVsuPm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2889C1C06
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449633; cv=none; b=REvRo6Gtt+dv1dWGDx+m0JVwKyd99OgwRgNTz6tuieMnV1PVQMvGtqTG5M1Ztjxu5CqDRV8xcNEmuaemd+Zh92gacvQg6tYwhf0ovztzj0BKDyV3k2UPPLBxPgXfWIXCYvsHAIaD3N8uDXRoCzn2d/wKt75AzPB1I2fb3ZLmpJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449633; c=relaxed/simple;
	bh=IX0XCPvAIo3Kgd9CzDHoj+81f98ZyYYBQT8XiXrr+ns=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OLSb5XyFYa3rwse6fFc39MuEH+FgJHO2gWvzVWk6BA4t2TS/EMZustnvE2ANz8yr3DyJlhOpYkgVgFSipsZnGbVhJJpQbsF8D5LZrsD7vjGyc6maCcg23MrPRe9M8qJ8ymWBx0dunXqNylgh5XCuJGGL+XOiCTdXdzs+wHUIcRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4SVsuPm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BFE2C32786;
	Mon,  8 Jul 2024 14:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720449632;
	bh=IX0XCPvAIo3Kgd9CzDHoj+81f98ZyYYBQT8XiXrr+ns=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h4SVsuPmYuCVCRO/GoSz72859eDVi4sY7uYiEGgXvIo/pSZpLrG+us4gbhmyjgM50
	 IX9c/EhUUDezNPGXE6kafWzH03nGezCc9yxGob9DQJ+zQ/2pK4UnXlhl5GVn/xgGp8
	 6DQcngYTLjrt2Kan8mzw9so4lU9v8KDihocf+Nai3m5pJPU8BBshriJPJsZfnuvZyb
	 4HGkQ9qeoLt5iSEqaKtF3h+6zBGzJCNGu2cCMe6vP2mS1EvyvBQ/jNepKwnwBe1Yo4
	 TVeO2JSKkSiYDVjhLCT8Ganl8+DxbwNF1IGGSnH4oRegEBN20UDZnc0HIjjxITOC02
	 wHa3TX4OjorsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90B8EDF3714;
	Mon,  8 Jul 2024 14:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] s390/bpf: Implement exceptions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172044963258.30506.1782849757962443355.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jul 2024 14:40:32 +0000
References: <20240703005047.40915-1-iii@linux.ibm.com>
In-Reply-To: <20240703005047.40915-1-iii@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed,  3 Jul 2024 02:48:46 +0200 you wrote:
> Hi,
> 
> this series implements exceptions in the s390x JIT. Patch 1 is a small
> refactoring, patch 2 is the implementation, and patch 3 enables the
> tests in the CI.
> 
> Best regards,
> Ilya
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] s390/bpf: Change seen_reg to a mask
    https://git.kernel.org/bpf/bpf-next/c/7ba4f43e16de
  - [bpf-next,2/3] s390/bpf: Implement exceptions
    https://git.kernel.org/bpf/bpf-next/c/fa7bd4b000a7
  - [bpf-next,3/3] selftests/bpf: Remove exceptions tests from DENYLIST.s390x
    https://git.kernel.org/bpf/bpf-next/c/02480fe8a6a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



