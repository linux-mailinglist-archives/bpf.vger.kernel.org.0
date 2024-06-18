Return-Path: <bpf+bounces-32414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2870490D787
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 17:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B63E285280
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 15:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15594446DE;
	Tue, 18 Jun 2024 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onLjr7VS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9244140851
	for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725228; cv=none; b=j8cA+ra7NN0PNbk+BO4GEfUnb793/yYOKTUq9ytAz9JlwOFXBsiEOoB9Rg+Drz05j61xysKCGvpKx0zfYCI5sr1r9kUwTuJK3m3IqvlLxMtbOLqfNYqw86RMYD0rRVmwF40MjmSESP8SmHkDydaoSdSp0MME7puuzaBVYNH+eg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725228; c=relaxed/simple;
	bh=6ntc1Ac1T69SHihqlN7GHfVbGQ8YFfNBdyYq+yaFsl4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RQQFvGiSbD7QBS0hh3ZhA/Bh217r5MGrJlxDjSDb42h3udz14Sk2DmdxJ798odtv4qANPbUUpUI8d8jwJWIPsNwibVOxBIthClAZh/+2/zHDyWD3cHveUIgXHtt3FL5FzT6GsjDjdKCUAe43QAabLUu7Mybpdxs1EtAVkxZh0LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onLjr7VS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0ABF8C4AF1D;
	Tue, 18 Jun 2024 15:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718725228;
	bh=6ntc1Ac1T69SHihqlN7GHfVbGQ8YFfNBdyYq+yaFsl4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=onLjr7VSiHRZot3lD4v3ZyZua9Uu/ErREFIGkWSyPfzbKDcy0XvAP+IerihHfJVJU
	 U92Wxf5CrwTwdO91RY6EImfdfGCZtub4EtVcxJtIbyel/zb4SZ8gYkZCRB6IqKUy90
	 Hmxg48Yd8UNEpVWuxG4q6h5G80FyTCJjRkr6xHhKFI/Cd61UjMd7efOJstUV0jLKbt
	 1iWWUYetEVASxCCv/5Dd4NbKImJR+sFdeUa75padJioXfnLz4Cw7TKZX8oqdLN2APV
	 h7V0zYIa7AnYF8tY54ATjq9ys8YVM1MklGqCIUgF3SNQ74cuiIn3wNDbt3GgAd3qq5
	 vJRgdtH/DYdsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E23E7C39563;
	Tue, 18 Jun 2024 15:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: update BPF LSM maintainer list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171872522792.16785.4327257486683413795.git-patchwork-notify@kernel.org>
Date: Tue, 18 Jun 2024 15:40:27 +0000
References: <ZnA-1qdtXS1TayD7@google.com>
In-Reply-To: <ZnA-1qdtXS1TayD7@google.com>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, kpsingh@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 17 Jun 2024 13:49:10 +0000 you wrote:
> After catching up with KP recently, we discussed that I will be now be
> responsible for co-maintaining the BPF LSM. Adding myself as
> designated maintainer of the BPF LSM, and specifying more files in
> which the BPF LSM maintenance responsibilities should now extend out
> to. This is at the back of all the BPF kfuncs that have been added
> recently, which are fundamentally restricted to being used only from
> BPF LSM program types.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: update BPF LSM maintainer list
    https://git.kernel.org/bpf/bpf/c/66b586715063

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



