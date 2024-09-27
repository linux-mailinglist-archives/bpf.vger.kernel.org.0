Return-Path: <bpf+bounces-40433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68741988B5B
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 22:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98BEF1C22D08
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 20:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419691C32FC;
	Fri, 27 Sep 2024 20:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CV0aJ8FX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DC91C2DB4;
	Fri, 27 Sep 2024 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727469629; cv=none; b=Dp+NurIxldcvcD8AQR80CO3fGLtEn00qtlXPYYbXV3L8usQG92Hv41gDRb32/8CC9bhFWqtkwCWMtyxlYrANH1Z6z8JpM3mN1T8leHDu/7TLgOc61v8zmPjfh9FaaadribDy49zLpy7XUxTo5lJU1nwqt5BZL2vBlV8hpSpFiM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727469629; c=relaxed/simple;
	bh=ragUpbdND72wRR5aBvZiG8qVdGb5jJSZesILBeSdp6Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q5qfy5VMuxU5dT4r/m8Ap59JPsenWOWMHw+klx3pN9YPCYGrVwaq4LMKyeDbD4RMn040dNtlrfeyJtkAOwtySuxECjjUVzbSftikQMcbNtBNEdoor6VBGSQdBOpPgqbJoJYL41UdZw3qI4ocb40A1Q4uxCKpCmAw443NRzUy9Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CV0aJ8FX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8922EC4CEC7;
	Fri, 27 Sep 2024 20:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727469629;
	bh=ragUpbdND72wRR5aBvZiG8qVdGb5jJSZesILBeSdp6Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CV0aJ8FXIAyueCexEhuqaRiIh15gZL1QfZyQdbU2lTAElufrAntkuubEdDyEjYBJm
	 sjsdLW757q6wTYJuVN1JY5UGfYhDjr7fa7LFisly18z4YeR4MwqVKdypJjgVd9KBHk
	 8QD/nEhN7e6kJeZK1RJG7lUvWQtQEteaizSQNUg1JRHICDCw/rY1ORIG6GKxdSxLhK
	 gBp1SvB6VkwM+NSLBtA6Q8HrEszeaHvX4pdGPYXfHTEtwtHtyBavGARj/JP2O+rkAD
	 UcPY7fwpBu5LjLvVqGs0P5Qlepb9Jcbqyj6vK+Bi4zJmFpvN0uLMYLqOTFECAAFN7j
	 kPrvTdyLJZPog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EA13809A80;
	Fri, 27 Sep 2024 20:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: Remove unneeded semicolon
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172746963202.2077014.14892949743322265247.git-patchwork-notify@kernel.org>
Date: Fri, 27 Sep 2024 20:40:32 +0000
References: <20240926023823.3632993-1-nichen@iscas.ac.cn>
In-Reply-To: <20240926023823.3632993-1-nichen@iscas.ac.cn>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 26 Sep 2024 10:38:23 +0800 you wrote:
> Remove unneeded semicolon in zip_archive_open().
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  tools/lib/bpf/zip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] libbpf: Remove unneeded semicolon
    https://git.kernel.org/bpf/bpf-next/c/cf2e7afdb141

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



