Return-Path: <bpf+bounces-16733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AF38056DD
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 15:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C551281D18
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 14:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5F861FDC;
	Tue,  5 Dec 2023 14:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNEYduDC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1064059E34;
	Tue,  5 Dec 2023 14:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD1FBC433CA;
	Tue,  5 Dec 2023 14:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701785423;
	bh=7NxOE4XOSsJwsLX360QCyIS9FPk81p4w1w2koa9zPqY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uNEYduDCMaoUKBjaM/MIDaTSph8F06NofWOwrvWsc88c1q/LDQWOdB0ZaY4x8ffCX
	 Lkhps45ys1DG3G4/p+nW6CiAKruSK0Apl4ga9yFaMkGmBsvVtcx50EEYNmi1J5XFQQ
	 EPe61eJzz8QyJ9ctCHYWu+0o3QDenRQNXWgzoTbQZHl3Q8Mm4EzoRMd2uirfzxdP19
	 Bi28PzwkUVS4kEiqVaG8jlpIaJyq+xTVuYO5gga3OiJmvFAWnZUcb53tzP7LluTOHl
	 DOVBuG0JUz/CYatkosM9Pojsd5mK4g6uqzYS5Lzolnil/1IVCk8jzDL7ly6gdO3kj3
	 KrsuTHFumLssA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B488AC43170;
	Tue,  5 Dec 2023 14:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] xsk: Add missing SPDX to AF_XDP TX metadata
 documentation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170178542373.14907.18386599751711362084.git-patchwork-notify@kernel.org>
Date: Tue, 05 Dec 2023 14:10:23 +0000
References: <20231204174231.3457705-1-sdf@google.com>
In-Reply-To: <20231204174231.3457705-1-sdf@google.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, netdev@vger.kernel.org, horms@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon,  4 Dec 2023 09:42:31 -0800 you wrote:
> Not sure how I missed that. I even acknowledged it explicitly
> in the changelog [0]. Add the tag for real now.
> 
> [0]: https://lore.kernel.org/bpf/20231127190319.1190813-1-sdf@google.com/
> 
> Cc: netdev@vger.kernel.org
> Cc: Simon Horman <horms@kernel.org>
> Fixes: 11614723af26 ("xsk: Add option to calculate TX checksum in SW")
> Suggested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] xsk: Add missing SPDX to AF_XDP TX metadata documentation
    https://git.kernel.org/bpf/bpf-next/c/5c399ae080ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



