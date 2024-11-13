Return-Path: <bpf+bounces-44807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6419C7CED
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 21:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76FA8B23D13
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 20:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F091205AB3;
	Wed, 13 Nov 2024 20:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBgCc8CE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19B12AF00;
	Wed, 13 Nov 2024 20:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731529819; cv=none; b=hfcGkEhUXGOP8+qIGZfEb8S3tWcZ0YJZO6KTOYj4qodPbpmnYEihsI0R2RdIwniWFvSOXbsQsEDXTToxZ7r8nUx8Ll5DPNllqjZKPjuFiiPhNsf0HnmY0dto02SAYsKRLLAQkY3lk6GgYlVoJiqcHswPkXrTER+nMu4AYMXNJyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731529819; c=relaxed/simple;
	bh=bckki8DWBbOx4RUrL6DSa/YrYppd01msQl2dTBgFuoM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KYfua9AbSXKLi+LimF1kScoxlXOHQb53WjDZlqzyBvj0AnjocMXKPOBhJJ0TLIFWiiGbEs67XEq7+MH9bKxfIaA4F5F1kE9rBxKIzAf2r9sg5bP1D3xNchuTDx3WMcFh82C1ufktuMHsu1Yh4kgsQRb6exdHvcVnDWIrzC6aMgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBgCc8CE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54031C4CEC3;
	Wed, 13 Nov 2024 20:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731529819;
	bh=bckki8DWBbOx4RUrL6DSa/YrYppd01msQl2dTBgFuoM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DBgCc8CETWl0qosZf4o07cQ6TYJsOVJ3+oX2zkxA2+7KI4hCmn86c81Hpo7nSsC5N
	 +rg+Me5kAAYOjC0B8lT/qrl29DraBLTgZejigmzbG+ePN1IwvMAFZU9L1A8QMqDOyy
	 /grXIm/0a5yA01KLD8W9Wf3W611mrhxAvT4+HpXrh3+A/DH6ml17dQdHiKYljlJCzW
	 MDNjvukKVZvQWrXrzqWY5y8NcEoDEAsEWLK59YPtAv/X7t2bEYbUVF1ft2PzDAgWqV
	 jKbey3CvpLXUEpknzHd/t41jYT+8XDG9rxl8+848cSnjFKANzXj5QOWcBU06uSNHjh
	 14D0Hy795WZwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB4AC3809A80;
	Wed, 13 Nov 2024 20:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] samples: bpf: Remove unused variable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173152982977.1375566.5132572860371360601.git-patchwork-notify@kernel.org>
Date: Wed, 13 Nov 2024 20:30:29 +0000
References: <20241111061514.3257-1-zhujun2@cmss.chinamobile.com>
In-Reply-To: <20241111061514.3257-1-zhujun2@cmss.chinamobile.com>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sun, 10 Nov 2024 22:15:14 -0800 you wrote:
> The variable is never referenced in the code, just remove it.
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>  samples/bpf/xdp2skb_meta_kern.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - samples: bpf: Remove unused variable
    https://git.kernel.org/bpf/bpf-next/c/b41ec3e6053a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



