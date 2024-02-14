Return-Path: <bpf+bounces-22020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDCF8550C2
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 18:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A334F1F22A5E
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 17:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AA3127B4F;
	Wed, 14 Feb 2024 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zw1bE9yc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92A71272C4
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933028; cv=none; b=rSmfva9stYFaHbWYolTXuc6Z5oSJjj69xXhWocGwcN7veBejPsUGpOlD7M0fkdvHmmtt4OlA91edAT+q/mVJFEIQlKmuvS/MDvSlQ3PyBN8X1wRbxAwA7wPvk7ZkW1Z7rrA1FaTrjCaSidDNk6Az2sa1qihDIvvfsQgWeY95BwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933028; c=relaxed/simple;
	bh=OyUSwIMMiu373xTok3n1rNj+9p1+q+OsamIGCCveDJI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ivHvT5fHYQUr65k+xwWBCoUEmc9JOmEYVU5JjySUm2tsZDL4M6gOec7aGO4xDF7X6tR4DkKQsPEIWb1QJfL6eIZcmbn1w0UQD1zQodvBs4PExpjqeCIa2SHC+SVQBBu6crvYi+lopifMHq9b5fl48h675la0UXo6O2jZl6WS+8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zw1bE9yc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47F8FC433C7;
	Wed, 14 Feb 2024 17:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707933028;
	bh=OyUSwIMMiu373xTok3n1rNj+9p1+q+OsamIGCCveDJI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Zw1bE9yconErHKO6DIvYQhRDBBgorryeZp/FDdzjqAdss6Xw9cXyos2jIduVHk5sT
	 slznWsVbogrwbHHEkX8BQjRYe3woD8QN2Lg2fjpBHgA36bMQifoXcUJ2cdtEoBTBVl
	 dQiwdMEtCae2lQ7blNmcxJ4DXKxBxU8AkOaSF0mfCUAeWhVC74riEih0lWG4yuiYuh
	 VR7TYz0wOCNSnhAvC1uMpyNinuHAaIEJVhzS82Rl9nlz5Uhrhq/VwUy2CW6VHi6Ztd
	 W6DBW9bZn2qIIHz/u2c4s1B9GA5C2wMd2e7BgynfqVVV7m3L7hPanisl4XxpxZcglx
	 3eNy0/sVoyLkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A317D8C96A;
	Wed, 14 Feb 2024 17:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next] libbpf: make remark about zero-initializing
 bpf_*_info structs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170793302815.936.15245367121810467021.git-patchwork-notify@kernel.org>
Date: Wed, 14 Feb 2024 17:50:28 +0000
References: <ZcyEb8x4VbhieWsL@google.com>
In-Reply-To: <ZcyEb8x4VbhieWsL@google.com>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, olsajiri@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 14 Feb 2024 09:14:23 +0000 you wrote:
> In some situations, if you fail to zero-initialize the
> bpf_{prog,map,btf,link}_info structs supplied to the set of LIBBPF
> helpers bpf_{prog,map,btf,link}_get_info_by_fd(), you can expect the
> helper to return an error. This can possibly leave people in a
> situation where they're scratching their heads for an unnnecessary
> amount of time. Make an explicit remark about the requirement of
> zero-initializing the supplied bpf_{prog,map,btf,link}_info structs
> for the respective LIBBPF helpers.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next] libbpf: make remark about zero-initializing bpf_*_info structs
    https://git.kernel.org/bpf/bpf-next/c/1159d2785220

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



