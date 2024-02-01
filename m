Return-Path: <bpf+bounces-20977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3957845EE8
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 18:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AC9D1F2E4BB
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 17:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC617C6E1;
	Thu,  1 Feb 2024 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnIViAT1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4494C5C043;
	Thu,  1 Feb 2024 17:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809825; cv=none; b=GrqP9ByoWPydhuUXrGB/4Zthp/Cd+ZYx3bEF5nQjDSV6KqHFh/lhmv5XXoX+uRKCRwl732/paRgnSllYhuqcPYnidtIkgomXmEooWCScOgp1JOAfTNA7BVdPf9yEIP3kpyvEDJyjBiYewsqE1ltkmtn4x0O9s15q67BGCJPyJ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809825; c=relaxed/simple;
	bh=pCL0FBI2ljUgfD8ndDBA/LzsAGcGUBg9DYTBib+DCcE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jJusLAAfIqILkEFTh9osq/PCxg9KXhcp8kCU5EYY4V2dismYdMsRW5gUCkAM4/X+NUYozzYe/elSuXcGnU5G6tsCACW38942LJfbj2zTLJqxoBC2GYyAlg2LAnzPnYdMkw5sTbUFQYq+EGUFjc5kDeahKRD7yyiTtt37HhKPmlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnIViAT1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB967C43390;
	Thu,  1 Feb 2024 17:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706809824;
	bh=pCL0FBI2ljUgfD8ndDBA/LzsAGcGUBg9DYTBib+DCcE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rnIViAT1k/czkF87RTTI3l3OkOvUMDgKjrgT342e/GJCi5K4mg7FyXrGbc/tr6Xpa
	 Egq80z7tgoifBz57tzK0x1TzBqraa5r7/4ma2vMOijo1ZGvp1fmJLcRJ6EvoV1pBB1
	 /cvROpSqvsYXlO+hCVcxEkB42pWcr9xipqmXNHOwzhgeoal4LwK4l1UStDe8xXHYED
	 tGoH3Lv4hCWKC4c+3Wk3S6qexeHhMdH+lfcTE8oq6ZPNc2QJjm8B4qZDQYFWh0XnJM
	 wp3HZ95fV1o5Q7bifDFSf3oNxlFI/ugNOKPfjEYbryy4q3XzV6/BYYqnut1kfuVCe+
	 3I2luc9qCNd+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91B55C1614E;
	Thu,  1 Feb 2024 17:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: minor clean-up to sleepable_lsm_hooks BTF set
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170680982459.10562.17370954213295414483.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 17:50:24 +0000
References: <Zbt1smz43GDMbVU3@google.com>
In-Reply-To: <Zbt1smz43GDMbVU3@google.com>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: kpsingh@kernel.org, ast@kernel.org, andrii@kernel.org,
 revest@chromium.org, jackmanb@chromium.org, yonghong.song@linux.dev,
 gnoack@google.com, bpf@vger.kernel.org, linux-security-module@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 1 Feb 2024 10:43:40 +0000 you wrote:
> There's already one main CONFIG_SECURITY_NETWORK ifdef block within
> the sleepable_lsm_hooks BTF set. Consolidate this duplicated ifdef
> block as there's no need for it and all things guarded by it should
> remain in one place in this specific context.
> 
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: minor clean-up to sleepable_lsm_hooks BTF set
    https://git.kernel.org/bpf/bpf-next/c/1581e5118e48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



