Return-Path: <bpf+bounces-468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C53D9701AE9
	for <lists+bpf@lfdr.de>; Sun, 14 May 2023 02:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 755C928187D
	for <lists+bpf@lfdr.de>; Sun, 14 May 2023 00:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537A210E3;
	Sun, 14 May 2023 00:10:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C860EEA1
	for <bpf@vger.kernel.org>; Sun, 14 May 2023 00:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F3D8C4339B;
	Sun, 14 May 2023 00:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684023021;
	bh=jCAxfSITDQtGl5ZXLbu/gRpP5AxQAt1pZgZ60xfm0Q4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uUUTeIJm9gP9yaG0sZK5DI9aG1R7l0Sgdaji48Q5cU/lh9vWDd7AtuCdgmwmkn89P
	 HD3xIU7Kg9d1z03YWwW1vSEWRzUX5H6b5W9TJRDKGwulawvMewqCPb9Q4KII94h0PG
	 V1ZmQk++qw6RbDIlNFbDv5Q9llWM+BXxdyvbH164dnxUO36jQyDoZ29hUl5qnmMbNe
	 RlBVX6PZDUhopIwwJ6VHWhueVHOrLpXN9ui3nwfBLZZ3wkH+vD2Y+xDjCzGKhsxYdM
	 ttsCBDvOcxLqv+yRsN4NYWqv5CtE1J2GzuC7u++43WXmErH7evqE1lkFMVl7t0v2EM
	 9RlN8j5EG8aVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3189EE49F61;
	Sun, 14 May 2023 00:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 0/4] bpf: Don't EFAULT for {g,s}setsockopt with
 wrong optlen
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168402302119.7162.15862761284178303387.git-patchwork-notify@kernel.org>
Date: Sun, 14 May 2023 00:10:21 +0000
References: <20230511170456.1759459-1-sdf@google.com>
In-Reply-To: <20230511170456.1759459-1-sdf@google.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 11 May 2023 10:04:52 -0700 you wrote:
> optval larger than PAGE_SIZE leads to EFAULT if the BPF program
> isn't careful enough. This is often overlooked and might break
> completely unrelated socket options. Instead of EFAULT,
> let's ignore BPF program buffer changes. See the first patch for
> more info.
> 
> In addition, clearly document this corner case and reset optlen
> in our selftests (in case somebody copy-pastes from them).
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/4] bpf: Don't EFAULT for {g,s}setsockopt with wrong optlen
    https://git.kernel.org/bpf/bpf-next/c/29ebbba7d461
  - [bpf-next,v6,2/4] selftests/bpf: Update EFAULT {g,s}etsockopt selftests
    https://git.kernel.org/bpf/bpf-next/c/989a4a7dbff2
  - [bpf-next,v6,3/4] selftests/bpf: Correctly handle optlen > 4096
    https://git.kernel.org/bpf/bpf-next/c/e01b4a72f132
  - [bpf-next,v6,4/4] bpf: Document EFAULT changes for sockopt
    https://git.kernel.org/bpf/bpf-next/c/6b6a23d5d8e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



