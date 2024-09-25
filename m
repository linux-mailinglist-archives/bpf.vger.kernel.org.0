Return-Path: <bpf+bounces-40292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B169856EF
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 12:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0A2F1C2132B
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 10:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D096E15C131;
	Wed, 25 Sep 2024 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUviiYOz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D871158557;
	Wed, 25 Sep 2024 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727259028; cv=none; b=pnRjtf36YrZjKc1us43mk3/zpZOjC7+A44lI4FzVSlTnXX+nODNvmvsK/Qz8ut+zcNI/BT+KJkWw/WrjQEMBnVTePLDUbSFapbgk8sAVwhyD9qjuAVrh8l/XSC6xfjcKzBaKbbKkNQDUKJWbeoc+iKkovSjEK3Xq0b2Yr+H4A9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727259028; c=relaxed/simple;
	bh=5MWc9lEZOUa+BT2ywHcnR5rblbZhrjxE+YRVzQ4Mmzk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J8wChI2i0W6tGPSCq9iwdnYOxKs+n7YsT3a01x4Hg0ae15B9pc4EAOG/woORP4HewFmKFH6FxZVbr3bEJjQAqngQW90V0QS9PVTHXk7Wa9KzVpz39hAURoJF826JUYwnFv+RkMBINsnMuji6SyQG25H7RnKyYoaVp7RCw3ZU07U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUviiYOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35AAC4CEC3;
	Wed, 25 Sep 2024 10:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727259027;
	bh=5MWc9lEZOUa+BT2ywHcnR5rblbZhrjxE+YRVzQ4Mmzk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pUviiYOzodxEk/A2gKrCE6xg8cHiXkY0B0l720nCk4euRUvwiDQgCaEyS9pIdPJjp
	 cdA31hOsm3jV15V2yjQ6uQ/NklMkGFJibtSkdcK+z0fgO34YYp+0zAsQ/1UR2Vsotd
	 M2NPWa0je3RjPp12eJ4WWRCINHNPD4nspbOajL5v13/Jh7xbS+YoHz508EI0tiLUFQ
	 Hs/s/dlubEcZGy6ej/ReIKQITsKc2+F0JtI6CqmG7EacCgutM4rVKrPraJmmQheGbK
	 tS8TjJLTEg/zV15NfVuVtoWlOMrPBYLlJ0jFFXBLdLOdqI/RJJsBk+TP0CS2jAovGD
	 xQznNcuu+vRcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710453809A8F;
	Wed, 25 Sep 2024 10:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Constify struct btf_kind_operations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172725903029.525990.1930102956415917557.git-patchwork-notify@kernel.org>
Date: Wed, 25 Sep 2024 10:10:30 +0000
References: <9192ab72b2e9c66aefd6520f359a20297186327f.1726417289.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <9192ab72b2e9c66aefd6520f359a20297186327f.1726417289.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sun, 15 Sep 2024 18:21:54 +0200 you wrote:
> 'struct btf_kind_operations' are not modified in this driver.
> 
> Constifying this structures moves some data to a read-only section, so
> increase overall security, especially when the structure holds some
> function pointers.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>  184320	   7091	    548	 191959	  2edd7	kernel/bpf/btf.o
> 
> [...]

Here is the summary with links:
  - bpf: Constify struct btf_kind_operations
    https://git.kernel.org/bpf/bpf-next/c/5e0965040301

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



