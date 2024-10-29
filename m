Return-Path: <bpf+bounces-43366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B716E9B400B
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 03:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EE2F1F233A3
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 02:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6DDFBF0;
	Tue, 29 Oct 2024 02:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tesI8sCA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D266D20DF4;
	Tue, 29 Oct 2024 02:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730167223; cv=none; b=AZcPlzZU1jFE979xSJxf34MN9YUl7iUM9kQl6oGacRaqSpmiL9+BsOcIPmQggcnvyDzVKsyAn+0KEivkqSxLMrwW/NGflvcb764mRLg6hqHNSMvfKLQYqjrCzUJemj+I2i//VCtODvbstxDZBwHb9i+UB/a7C8Z1NhOmDrkGjHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730167223; c=relaxed/simple;
	bh=GoCp+K+udVefo0sh8gu/9ecVv80XDC+dnCdLzJ4dmg0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zct4bXllchp3rXXCBLNvY+IMVcXeWbnCYiBM9CHh98DhMmF+3GgEwYwhsgxa9+Y8KccQege+MvmnYpgClJ3u7I9ufrvqSW6u0LqFR0Npd1lIMriWcWccHYr/kJUy1m8XoR/dVkIGcDI0+oBoSNIFlghRbZ8bYY3M4Ng8ODKptqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tesI8sCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A77EC4CEC3;
	Tue, 29 Oct 2024 02:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730167223;
	bh=GoCp+K+udVefo0sh8gu/9ecVv80XDC+dnCdLzJ4dmg0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tesI8sCAulRWF20ztjYGguvPI3KSdBSO1ZeYKTYdgBSSLBqXW8MhVZrOOwdculUK2
	 zrynba7tkCJ1rNs0w3Z8UeESc7tu1aelAr6d9PTYriodQli6LZHvsexwRfg3/5SrjE
	 KX/nJGXxUortzaDvPHsasO9KPL8HWEgUmvGEIMdH8TCyxZMQE3/mNPNPUqoSSWCB7z
	 esrmQll0mU/wZhM2g5Lzn9lVAy7kCuGrvtkMjmhhbyP1ELaZ06ZlZ1BBIYGBpcL2pT
	 nokem1xfrVNARaLHWAvq8w9KHQlhy4afu9QUC2XE0J7Gn05bbvl5C2H/aFDkGUvLkM
	 OomLlgMlanqxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB063380AC1F;
	Tue, 29 Oct 2024 02:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Patch bpf] sock_map: fix a NULL pointer dereference in
 sock_map_link_update_prog()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173016723076.241400.15764382647149470728.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 02:00:30 +0000
References: <20241026185522.338562-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20241026185522.338562-1-xiyou.wangcong@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, cong.wang@bytedance.com,
 bonan.ruan@u.nus.edu, yonghong.song@linux.dev, john.fastabend@gmail.com,
 jakub@cloudflare.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Sat, 26 Oct 2024 11:55:22 -0700 you wrote:
> From: Cong Wang <cong.wang@bytedance.com>
> 
> The following race condition could trigger a NULL pointer dereference:
> 
> sock_map_link_detach():		sock_map_link_update_prog():
>    mutex_lock(&sockmap_mutex);
>    ...
>    sockmap_link->map = NULL;
>    mutex_unlock(&sockmap_mutex);
>    				   mutex_lock(&sockmap_mutex);
> 				   ...
> 				   sock_map_prog_link_lookup(sockmap_link->map);
> 				   mutex_unlock(&sockmap_mutex);
>    <continue>
> 
> [...]

Here is the summary with links:
  - [bpf] sock_map: fix a NULL pointer dereference in sock_map_link_update_prog()
    https://git.kernel.org/bpf/bpf/c/740be3b9a6d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



