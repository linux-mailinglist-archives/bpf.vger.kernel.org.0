Return-Path: <bpf+bounces-37340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C28D0953DC9
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 01:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5B41F26CED
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 23:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66039157468;
	Thu, 15 Aug 2024 23:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPag1Np9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F2A156C6F;
	Thu, 15 Aug 2024 23:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723762840; cv=none; b=f9vNE0kcl+/yfdoyXs71wgW1ofmEslWaW+N1w5AumW0FJv0fbtJGPmekMCK74LDVFXPplsdfK4zEhAstvQ4U1spZhYzGduUrGg+z6qPm/gW25WeCeLfdOWzAm7FDRQRg4E7dfhlrTJ3vF74UDKe7LgksbY+Xy8XF3e0kBYYgxxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723762840; c=relaxed/simple;
	bh=ClXOneOebma6lnT00NIgNHZTe12DXes5aJiuH7Rj1mQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aL+A1GgbT1uW6cd9NTRdwcBHzOShzY1U2in5R5OH7Xan7/yjx5nOx93wd7VVxD+GqrinbFfen5aet+k+rotPKOxxahcMgP5366rJ1wVlIbfL2Ek0Tk+fhC83CtYWk4Yrwp12Ku0f0tO5DigWGbNFQUBiptIHeBVu56C99xOkwC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPag1Np9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CAFC32786;
	Thu, 15 Aug 2024 23:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723762840;
	bh=ClXOneOebma6lnT00NIgNHZTe12DXes5aJiuH7Rj1mQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FPag1Np9nhtrj/xqdrCriQ5M0kwJTceajxbzCYNmg4aS+YgxjVF8x2TcsxmjxOsiV
	 YDu26vfLJQY4y7v+qFvsWEsj0CLmuEwuylM68Y1OTAR9ozp1vY5HycgeWqaVog8qfF
	 W09k5X+hP9sbdAt5i4Os/7M6SpenhCspZiKX1XpJTBpWUB4vX1A+ZR1R4XbsQzfR3K
	 FahLfrJWJFpF3iN5vXpIgn6EbA13tXgfTN0DCDBaI6galpz+Bf+0owcZtO2duj20ry
	 OsdCE6iPyn9yHstRjL/ueK2YbrQIj30YPAO3urmAWoJbvzyvAppfMt1LdQdg9vC/qD
	 BkQxYaLytFhTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF979382327A;
	Thu, 15 Aug 2024 23:00:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] libbpf: workaround -Wmaybe-uninitialized false positive
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172376283924.3058964.12790981460632106306.git-patchwork-notify@kernel.org>
Date: Thu, 15 Aug 2024 23:00:39 +0000
References: <14ec488a1cac02794c2fa2b83ae0cef1bce2cb36.1723578546.git.sam@gentoo.org>
In-Reply-To: <14ec488a1cac02794c2fa2b83ae0cef1bce2cb36.1723578546.git.sam@gentoo.org>
To: Sam James <sam@gentoo.org>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 jose.marchesi@oracle.com, quic_apinski@quicinc.com,
 kacper.slominski72@gmail.com, arsen@gentoo.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 13 Aug 2024 20:49:06 +0100 you wrote:
> In `elf_close`, we get this with GCC 15 -O3 (at least):
> ```
> In function ‘elf_close’,
>     inlined from ‘elf_close’ at elf.c:53:6,
>     inlined from ‘elf_find_func_offset_from_file’ at elf.c:384:2:
> elf.c:57:9: warning: ‘elf_fd.elf’ may be used uninitialized [-Wmaybe-uninitialized]
>    57 |         elf_end(elf_fd->elf);
>       |         ^~~~~~~~~~~~~~~~~~~~
> elf.c: In function ‘elf_find_func_offset_from_file’:
> elf.c:377:23: note: ‘elf_fd.elf’ was declared here
>   377 |         struct elf_fd elf_fd;
>       |                       ^~~~~~
> In function ‘elf_close’,
>     inlined from ‘elf_close’ at elf.c:53:6,
>     inlined from ‘elf_find_func_offset_from_file’ at elf.c:384:2:
> elf.c:58:9: warning: ‘elf_fd.fd’ may be used uninitialized [-Wmaybe-uninitialized]
>    58 |         close(elf_fd->fd);
>       |         ^~~~~~~~~~~~~~~~~
> elf.c: In function ‘elf_find_func_offset_from_file’:
> elf.c:377:23: note: ‘elf_fd.fd’ was declared here
>   377 |         struct elf_fd elf_fd;
>       |                       ^~~~~~
> ```
> 
> [...]

Here is the summary with links:
  - [v4] libbpf: workaround -Wmaybe-uninitialized false positive
    https://git.kernel.org/bpf/bpf-next/c/fab45b962749

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



