Return-Path: <bpf+bounces-31084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C09D8D6DB5
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2024 05:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B66A1F22F7B
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2024 03:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2758AD48;
	Sat,  1 Jun 2024 03:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="synA3IuM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FE46FB6
	for <bpf@vger.kernel.org>; Sat,  1 Jun 2024 03:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717213234; cv=none; b=EKAY3onNB8lOA2S34WgqSJ5Y4n1BBsR6Ge1bmy1RIic4QuK6gdmuHq65hNXr8Jy/nqzPWolANmJiS3gt8Rin9GkCFmbibsvWlTxYDVQnE0s85KVWAdO8+KWWlr/te5VzBKO8VAHkcaHFIB2wSgA7MrmmX7qXiKdpuw6i8EvlJN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717213234; c=relaxed/simple;
	bh=yXMmNj19ehRJKUfyxK96VG6xck2wHSgNWY3obOdg/xk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JK6uf91Qeg+AZNPFDr7XeQ9MbLCev1QKtQgk0TrqZ0VkjM+LtFKfTHntp85D79iKC2dee+AW7zxI1X9jT+aLIo1DnrGD+iEOOz4UCTqq5oJEAFQfdhDXmhxEzerbrGOhsjbdO4QF4OdEQxGczvTx9l2als9efgiqjVL5Bz1WQCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=synA3IuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8634C32789;
	Sat,  1 Jun 2024 03:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717213233;
	bh=yXMmNj19ehRJKUfyxK96VG6xck2wHSgNWY3obOdg/xk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=synA3IuMN199VeVM+cog5/L1a0GFXBw1xpruZZKHHDtZ4yGGFea6KLGQJysahsuUE
	 rzGgrq+xee/+n3LZdOb5AdxpREX9sp0TbrnWzMqke3EV/EIk0wm7s1nqftwyfBHc2g
	 5cpKJ5FgsoOw2OGAlrlvbxXTMAM2RbJYuKXU/yZe+XLZJQJPpvjxhh/DxDYzn+zlBG
	 g+vCLhref6fi83AjrfjSQNG6LrnZVtdcxmrYOTYakNh/bz5YlBrVNrRjGf5iKJm4aR
	 IU4Hawz8Do+QqxTS0ib0WrL/UuI6AetlXTcXzDhq11I/BYhvpqhzPt4O0yHotm1alM
	 DUd2vaK5Z+WMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 943BBC4361B;
	Sat,  1 Jun 2024 03:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: keep FD_CLOEXEC flag when dup()'ing FD
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171721323360.19521.4139037140945852200.git-patchwork-notify@kernel.org>
Date: Sat, 01 Jun 2024 03:40:33 +0000
References: <20240529223239.504241-1-andrii@kernel.org>
In-Reply-To: <20240529223239.504241-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com, lennart@poettering.net

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 29 May 2024 15:32:39 -0700 you wrote:
> Make sure to preserve and/or enforce FD_CLOEXEC flag on duped FDs.
> Use dup3() with O_CLOEXEC flag for that.
> 
> Without this fix libbpf effectively clears FD_CLOEXEC flag on each of BPF
> map/prog FD, which is definitely not the right or expected behavior.
> 
> Reported-by: Lennart Poettering <lennart@poettering.net>
> Fixes: bc308d011ab8 ("libbpf: call dup2() syscall directly")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: keep FD_CLOEXEC flag when dup()'ing FD
    https://git.kernel.org/bpf/bpf-next/c/531876c80004

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



