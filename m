Return-Path: <bpf+bounces-28458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C258A8B9E94
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 18:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A8A9288F05
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 16:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8009515E80B;
	Thu,  2 May 2024 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrVLCPll"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0258015D5B8
	for <bpf@vger.kernel.org>; Thu,  2 May 2024 16:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667432; cv=none; b=CnVKtDkC8BygdhponqneJiUlV3Ib6EIROXSnNZ8yDVRidP/Uq6SKFhEsmkh4e9FtaOk0Jrt3ZXFbHMNFHS1nVhCM5x5UuXYe/9xnyzrdFaMONd1TH0j5HCQhXZU58AETaZPtkMEamjPEosoaH2U1yPvuyBJtLeV3WnxQjAbMWvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667432; c=relaxed/simple;
	bh=1LC9LgMlfVQiDG8jUR9uuXRC/6zUdHegnX4uzT1QUGY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ffTwe7dVjVmZZYzlrPM9cGXY/LuHYiF3jV2mXIosk2trGImiRJXfCDRBg+z67NYmiwtbppHnefbaCoEiP53j0EiANFPlMY1ScgruUjTzJ74aljDCTpTK/eJNjElH3phUs4hfBpeRKxGgm/RL8LKA5wKgsjHGsBp3+KTUJMZUCBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrVLCPll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94686C4AF14;
	Thu,  2 May 2024 16:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714667431;
	bh=1LC9LgMlfVQiDG8jUR9uuXRC/6zUdHegnX4uzT1QUGY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WrVLCPllEudlRKBB8rfC69pzS6pTGan7sOFu+JC34e+2NOfTorZNosxbfLyYWRniy
	 JpLORoyxo1hgpDwqu6czm2k4S/l9Zy2zWfpeAuxO8BTgLnM9Svx/EllU0AWL5z4RPp
	 9xc5kxc0YvQArAsf2QoPfJdHIIfQDgakyPTDX5Vn0gdSoHeKHVZfR1ttr2mq+OocKM
	 9ydYw/Sg4ifNt2wyUmwOmUH9T74s8o6IIDdc7pkfee3unR3KGnZkvmLMv+1i+XI2iZ
	 5z6kHfY98y0qASrrbkxS14ZWAncwGoeHzylf4ld3+5vf3KnKba+0oUzzmjBj4cxpYf
	 ltZt3XJWzW4Cw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7DE96C4333B;
	Thu,  2 May 2024 16:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] libbpf: Fix error message in
 attach_kprobe_session
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171466743151.8274.48898357137716823.git-patchwork-notify@kernel.org>
Date: Thu, 02 May 2024 16:30:31 +0000
References: <20240502075541.1425761-1-jolsa@kernel.org>
In-Reply-To: <20240502075541.1425761-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
 haoluo@google.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu,  2 May 2024 09:55:40 +0200 you wrote:
> We just failed to retrieve pattern, so we need to print spec instead.
> 
> Fixes: 2ca178f02b2f ("libbpf: Add support for kprobe session attach")
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next,1/2] libbpf: Fix error message in attach_kprobe_session
    https://git.kernel.org/bpf/bpf-next/c/5a3941f84b8f
  - [bpf-next,2/2] libbpf: Fix error message in attach_kprobe_multi
    https://git.kernel.org/bpf/bpf-next/c/7c13ef16e87a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



