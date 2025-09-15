Return-Path: <bpf+bounces-68419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005B9B584F3
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 20:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7A8E16FBFA
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 18:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9129C27935F;
	Mon, 15 Sep 2025 18:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6d/uISQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0F42773F4
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757962206; cv=none; b=Xpp/Fby6r9YM2wiF2ArAIxggbErz/y7dGLry3O9+CQaCBnuD7AxykZuputK12DVAa2jFU8J99tdnTRKAqKWdfBGlRALy5Z4V67nZH4wUvhQnFGstYzrErC2fGBKQNzhtpP20pLdxfStaLVFTEsu+kLSmfylkxm0tPyLgMkIes5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757962206; c=relaxed/simple;
	bh=W9kgyY7D0U+Lx1C30Jxs2KLmivBNlYIB61Pw7LrbUsk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TxkWcqTAfx9TIWb5qpec83sNPkGIESd23kvQR4i6Dw3paavjce83gaXzpqn2g9l9fjetilTTHm/a9gZS07BusohCcVGkm4XJJRB8SnrbyjETpknlQod9WamVM3CC7u7yzKKrW9+fzNomSVmGvvGQHMOy3c27WhaQWvBSOGkU0VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6d/uISQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEEEC4CEF1;
	Mon, 15 Sep 2025 18:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757962205;
	bh=W9kgyY7D0U+Lx1C30Jxs2KLmivBNlYIB61Pw7LrbUsk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q6d/uISQyzizLdcii1WFfMCP1sQMW6wjExPwODKoASrISxxNKoOLg7HvRYEMF8XHM
	 wJ+cj0Q+Mj6tVs8ulwNh0XpxPFWZdHWyWb+XNIQASdslNG+VjaBIL1VwY7au+6RsJR
	 a4ouIOEbaJEOnEpQ6a5ARhGbN3j9F4QHwsck/W0a/c1JGVxsp3yrv07e5JspF8Zbdz
	 nsIo9ArDrUKVVW8u1Ns+R0X29RpGFspSNcfu2R5NpcJZk1QrHcKPRo1KE6sba7vO5P
	 JtJyOOTGNnXqXajct04tY1Q4nTKafnCPZKfqZYbO9JXkEOiTJgi3Q6I8ZjPa9vGydC
	 OdwCw8aOPDEKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EBA39D0C18;
	Mon, 15 Sep 2025 18:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: more open-coded gettid syscall
 cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175796220701.91733.16220628872714349758.git-patchwork-notify@kernel.org>
Date: Mon, 15 Sep 2025 18:50:07 +0000
References: <20250911163056.543071-1-alan.maguire@oracle.com>
In-Reply-To: <20250911163056.543071-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, brauner@kernel.org,
 bboscaccy@linux.microsoft.com, ameryhung@gmail.com, emil@etsalapatis.com,
 bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 11 Sep 2025 17:30:56 +0100 you wrote:
> commit 0e2fb011a0ba ("selftests/bpf: Clean up open-coded gettid syscall invocations")
> 
> addressed the issue that older libc may not have a gettid()
> function call wrapper for the associated syscall.  A few more
> instances have crept into tests, use sys_gettid() instead,
> and poison raw gettid() usage to avoid future issues.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] selftests/bpf: more open-coded gettid syscall cleanup
    https://git.kernel.org/bpf/bpf-next/c/3ae4c527080c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



