Return-Path: <bpf+bounces-58064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBBAAB4731
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 00:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938B33A9D8B
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 22:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6728B299AA5;
	Mon, 12 May 2025 22:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irNGJOd8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFD9299A8B
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 22:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747088391; cv=none; b=bF/1+jjxEskm9e6biRwXafKCH4TetiUOqt5Rr6V7s8lDn4uqVOvvPZvNnXTNSH2o30RM6X+3vTqqV5NHWvqyG8aAvM3wlYNNRlyK6gufP5MFvyxHhkfUyFb7RazTiNWHQ083KrWrXEydzAZKAAeMptJwkBJiN4N+1ZaDmmNPWhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747088391; c=relaxed/simple;
	bh=gQTM+CW20oX7hYdRrWdZbWPweaEwLN3n0QLw/N/GOPY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RwHaIfwD/mEC/KtH7eylVbhE51jh5mKHR2UQnzo4WCr25AEGh4hpnZM4iSqI27zxtrzODkwV4Jf+4tR7BTsMHnh2AsSKRjBqYGCaYfDdvTwk1zX2H7gQXAdX0/Hj9Ug4dJkN4ciTb568xDkY6DLIs0rY+ToZQttp7CPip0dEYno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irNGJOd8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EF8C4CEE7;
	Mon, 12 May 2025 22:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747088391;
	bh=gQTM+CW20oX7hYdRrWdZbWPweaEwLN3n0QLw/N/GOPY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=irNGJOd8avCsIqeBv+i3ribR1rKo6bkYBGXqG37BTgdyMgmSyVlb2hb3Am/9Bf0yl
	 o5bcxa66S4kvp9zldSdBUS5U/XAWLuqUc8iEi6sOQIqv94gYvEZN4ChkPVmXN5+d+D
	 nxHxiimPP8SrnVDkJ6+m+s1dF6ShLIakv4P9ZIprV+W7rXcv9nVnb8Ld9wSQeMDEb3
	 iQSAGZoWY99jvmcvoZv9Ztov2W01sfav+zuLU895kpnAQsHe2netPXVbarwS4bJuIt
	 61X3vzzacLVDP/UevPBBHeB8bnSAYcrwXFpWRQJzKLpUhAxzCN7ffjUjegnWy/UDk1
	 4iWqSo8Q+LtAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C1839D654D;
	Mon, 12 May 2025 22:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: allow skipping docs compilation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174708842901.1097084.10542835883940573424.git-patchwork-notify@kernel.org>
Date: Mon, 12 May 2025 22:20:29 +0000
References: <20250510002450.365613-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250510002450.365613-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sat, 10 May 2025 01:24:50 +0100 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Currently rst2man is required to build bpf selftests, as the tool is
> used by Makefile.docs. rst2man may be missing in some build
> environments and is not essential for selftests. It makes sense to
> allow user to skip building docs.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: allow skipping docs compilation
    https://git.kernel.org/bpf/bpf-next/c/3a320ed32548

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



