Return-Path: <bpf+bounces-41520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0E5997A2D
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 03:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B97E282FD8
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 01:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9023E479;
	Thu, 10 Oct 2024 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swjW/1WO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6221BE6F;
	Thu, 10 Oct 2024 01:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728523828; cv=none; b=EPYQ+nVEfPUzd9KHHpcIu715TFMCVg/YVaTvzNTj20W67V9IXhgQAh8jjXEFHMg218Xm0VPSyg+sChCS/LocIU1JQtRwlj+4JDb0bSkL67KKT6zCRxMnYUe1bJjw7jBXZEdWDxADALM+1/wcwbMQykNhXFSPkMlLNZ11IBuW940=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728523828; c=relaxed/simple;
	bh=iHaOHmLgzUn7hvUZtHAxMmHmT0EQ1LLdTnaX3AtArIc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sC9RMiC1x4TfKdSFfk8prg9VxfgFBDOf9OIqGSD1pmOQmy54JTU4FsrFtpeGYUm1aR8FiWjANGwE01WjwOwroXxrmkoqddrZBmgkQkZcYe94aetWLXzg0mVF0ufu+iCVWQiinetumR0D0hGJ/uEsKYqZSQb+Z47CpjffZLdAL0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swjW/1WO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33471C4CEC3;
	Thu, 10 Oct 2024 01:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728523828;
	bh=iHaOHmLgzUn7hvUZtHAxMmHmT0EQ1LLdTnaX3AtArIc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=swjW/1WO59DEt5TwBvK9FmEX+UrtvJF8VoYMjh5K5HLNau/S2MKTmrWn6Pv+22HXJ
	 Tn7LElQO7M6Fuw/vB/B35FGYbrccWxKcB6eaBL5WyH9/XOGTh32SyU1COR83mmzanV
	 Fq0NUhtOYW3CrsWzhW8M3ioelYlPTsVN85+X4wAdq/Wd/5sx61+gFnKkjb8KG9cOsY
	 K9QB6NIb9RItYTnIjhOuVHwuONwivN3NMuhiDn3ogli0+uBsY44OGwrLK6PQ0ZSjL9
	 /Xr/ZZygPe3XztC8XexCUzrwCzZ1hh6Ah4dOwXXYW8x3HLIE1IP3RhMLF27BxDCKJa
	 Cl4ikgSROJmrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC513806644;
	Thu, 10 Oct 2024 01:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] samples/bpf: Remove unused variables
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172852383248.1532001.6561409067944376157.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 01:30:32 +0000
References: <20241009082138.7971-1-zhujun2@cmss.chinamobile.com>
In-Reply-To: <20241009082138.7971-1-zhujun2@cmss.chinamobile.com>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 ast@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  9 Oct 2024 01:21:38 -0700 you wrote:
> These variables are never referenced in the code, just remove them.
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>  samples/bpf/tc_l2_redirect_kern.c | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - samples/bpf: Remove unused variables
    https://git.kernel.org/bpf/bpf-next/c/965fdf95a327

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



