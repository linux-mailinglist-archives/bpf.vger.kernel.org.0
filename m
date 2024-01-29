Return-Path: <bpf+bounces-20627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514658414AA
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 21:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D951B1F258BD
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 20:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5BA157028;
	Mon, 29 Jan 2024 20:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+K5W4jM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121AC153BD1
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 20:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706561425; cv=none; b=D3WovofoutY4SKQzGxYKDFtViyQulC7rlN21f6ZlzxJupJMUXQPkZYZpwh+iQJkkJ44N9q6f7u/lbNAt23inSeiHgSLYG6OwSWAgqOv7WbGl8a+eZQ87SL6Uet/LhbtbnAVZw8HVEqpU4wGD425Einki1Xn8YZydbSKwnD3kFQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706561425; c=relaxed/simple;
	bh=dmhLERZhH3sOgg9GJ/WX1HgpvFjJjrl77ITh1i71uhQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OJUu7LYfUk6YUeIVmqKkF0BPm6s8eAw1zCUfbBTfqBeuw/95GAuZKopKxDsjlz7pzRkx1GEDigHEOU8e0HxfA8/XmYLcdXknnoNa1ZQfDiD669xXQ2X7mhlYqTAiu0cUf/VX+tGh2YMEz/D6bx8zyA8DTmhroF11AOdnGVINBvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+K5W4jM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81B89C43399;
	Mon, 29 Jan 2024 20:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706561424;
	bh=dmhLERZhH3sOgg9GJ/WX1HgpvFjJjrl77ITh1i71uhQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t+K5W4jM7u93AsxWo3Zc9+HxvMvhNtlT3zdR352NuA7OaDlPuPmLpmleFBHJfK+WJ
	 o6pyDJsRPjcUf3Mh6VSFEJtI940MCY4Ot/OyO+ImLuRDJPLLS4V8gyCs0JOonqpGP6
	 K/DTpXOfHnLBJuRYe/kpofTImER8nGmnKwh94ggK/XPc1XfRDCDKHXkhUaR8fo6v21
	 vTeJkiE3KJwravSWcJRJ550KNIMISeBnH9uZWV4GcdBdnP/SxcMpD3cDjqBjD/JpY8
	 WYYMY8TgUW/7DpxIgYB1r/k0QrIC4JJDufmdoU+gowg+fDZTUdQujsJHtFTR8WB0Px
	 ji6nXGgeDv1eQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6AF67C43153;
	Mon, 29 Jan 2024 20:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Remove "&>" usage in the selftests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170656142443.13637.2524765421780876807.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jan 2024 20:50:24 +0000
References: <20240127025017.950825-1-martin.lau@linux.dev>
In-Reply-To: <20240127025017.950825-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 26 Jan 2024 18:50:17 -0800 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> In s390, CI reported that the sock_iter_batch selftest
> hits this error very often:
> 
> 2024-01-26T16:56:49.3091804Z Bind /proc/self/ns/net -> /run/netns/sock_iter_batch_netns failed: No such file or directory
> 2024-01-26T16:56:49.3149524Z Cannot remove namespace file "/run/netns/sock_iter_batch_netns": No such file or directory
> 2024-01-26T16:56:49.3772213Z test_sock_iter_batch:FAIL:ip netns add sock_iter_batch_netns unexpected error: 256 (errno 0)
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Remove "&>" usage in the selftests
    https://git.kernel.org/bpf/bpf-next/c/fbaf59a9f513

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



