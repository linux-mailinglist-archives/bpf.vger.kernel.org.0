Return-Path: <bpf+bounces-37858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1305F95B534
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 14:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95E30B22461
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 12:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D57C1C9DDD;
	Thu, 22 Aug 2024 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeCLv+Yj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9A31C9DC0;
	Thu, 22 Aug 2024 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724330428; cv=none; b=gQwyuF5j4NNt+/PZiT7ju/0PsZKNChnkhnFNqZkC/UzZdRTdosq9q/G3cyLXfYSiFpDxTkpcIy4TRFgRpYZdNBOZ1o4TqigQQhOD5aKdPY0cY5LVPjuiw6UOzMBBYmHY5OYq69UJxsljvmpMgtdjEq4A8Rbzk2SZghr5/w3Fyes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724330428; c=relaxed/simple;
	bh=3NME5TdQjQu2vBq31Ff2gB4ShQY+flAvOvLdzFegR1Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VjzrBF6rMHv2fJXPH+r/KCCFKrn3k2yRbFP3Phfcjdp9D8EQ5n1jgHiKihNllQwWkRkz8z1uU3gk+mo6UzqhyDyH9mIzI5QNCQ/Ck7qYI6aEPa6YPY6zQg5s9AU3PeeRbNd+kXCmFNl3NKUS3uG3zeBC0PzNEFP67vGgS1NT3Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeCLv+Yj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DECC32782;
	Thu, 22 Aug 2024 12:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724330428;
	bh=3NME5TdQjQu2vBq31Ff2gB4ShQY+flAvOvLdzFegR1Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WeCLv+Yjhtuo/72vuBK4G0feJIarWS5RKpHioSnBw6o75Bi+UJS5CHFu4pzizxIoV
	 e9N1er8oKQ2NV/AGkUtl/QBEbmvRtjurWw9mMHKpVzvgYk/oMHeslTk15l/pU0FTaa
	 czQvY6TtltsXa8eXYvv4nN4xDaK+3lghTpDSS6Xi/icz4MT2sf2/xu8u1E1OZiPdUh
	 pHma56cyWe5B0GHtMJvP8EylZa6wCscLyDaIN5Qu8EXFZMprmyYxxAYWreTyymfNb7
	 eeq00W7LqxxYQIrnhd2o3ApQofad9Dqn143OB9JHGdUipOk1ugLKFUs+5uU7guC+rf
	 D7W3GsUt4SoBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF483809A80;
	Thu, 22 Aug 2024 12:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] net: filter: Use kmemdup_array instead of kmemdup for
 multiple allocation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172433042779.2310315.2449086837418172334.git-patchwork-notify@kernel.org>
Date: Thu, 22 Aug 2024 12:40:27 +0000
References: <20240821073709.4067177-1-yujiaoliang@vivo.com>
In-Reply-To: <20240821073709.4067177-1-yujiaoliang@vivo.com>
To: =?utf-8?b?5LqO5L286ImvIDx5dWppYW9saWFuZ0B2aXZvLmNvbT4=?=@codeaurora.org
Cc: martin.lau@linux.dev, daniel@iogearbox.net, john.fastabend@gmail.com,
 ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 21 Aug 2024 15:37:08 +0800 you wrote:
> Let the kememdup_array() take care about multiplication and possible
> overflows.
> 
> Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
> ---
>  net/core/filter.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [v1] net: filter: Use kmemdup_array instead of kmemdup for multiple allocation
    https://git.kernel.org/bpf/bpf-next/c/b6ab50902724

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



