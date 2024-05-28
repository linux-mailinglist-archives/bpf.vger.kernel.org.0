Return-Path: <bpf+bounces-30707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E9A8D1829
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 12:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E39B7B26AA9
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 10:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BB116ABEB;
	Tue, 28 May 2024 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rg5ickJh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022A317E8F4;
	Tue, 28 May 2024 10:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891035; cv=none; b=f+zNws0cteDdjaVlv9RdLXePQYTGn93+1jYjMfoN3xrk1vzmTqTBoAMnTiRy3Rr3BE/ypr9ixsAbJtkmRK13WFST/smG+f3GC2SEKxK3D+vXi1BFl+YlDn2rOC6K+WnOjEgR7CHoMU84uqc7tybiha5JUykGvaWJMGDQM9amibc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891035; c=relaxed/simple;
	bh=05aPiNKFD4tFZIrEuAyb4WYu8G/i5Urh30k7lvnUUfg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kxnfl+QpohbGLckgHq+1plloNgsZMSITBdXwBnV0ildOQ05tnzk/s+asu6MFMth+K1ETnV6LlaUZR7qD78Hf6ktyUYBVp85mwMUN0Q1fS2vgHc0EglyfJ2PqDS8j0O7DO9plA+Yr5AJhAQ8lH8VzU7wq2OaV5EyxN4+RYywDSbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rg5ickJh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43010C32781;
	Tue, 28 May 2024 10:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716891034;
	bh=05aPiNKFD4tFZIrEuAyb4WYu8G/i5Urh30k7lvnUUfg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rg5ickJhhL5ppwDl03Aad1ycW6BEuXF6RzlAC4rp7ueBqY8+A/+DYl76sH5LvEbXY
	 OFaJopdDkI4RbKWSywmRyBQa1fGBgLtQyffqQ6Oix2Sw7BtU0LjeL8GosHPc20x67o
	 oh9hTSlB2R5AI7RvaopS4m6+CL8ghD5qCmls1xvxIfBHYGT2U8o2/zqgb+CiztPpch
	 Ne1oyxWIyieEjMKSZBlXOhaO/ra+TOVoWSJIapwhAyjHIWQCQ822TBbiwOleP7D891
	 SvJWNlwRja/IRKHOkmPdqOAiftoXWSTTymVDRawrDpiZ+xaPHmLm+HF9pxY3XtO45n
	 TrqvEFD2q0jNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36155C4361C;
	Tue, 28 May 2024 10:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: filter: use DEV_STAT_INC()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171689103421.16293.16635020515732508425.git-patchwork-notify@kernel.org>
Date: Tue, 28 May 2024 10:10:34 +0000
References: <20240523033520.4029314-1-jiangyunshui@kylinos.cn>
In-Reply-To: <20240523033520.4029314-1-jiangyunshui@kylinos.cn>
To: Yunshui Jiang <jiangyunshui@kylinos.cn>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, daniel@iogearbox.net, john.fastabend@gmail.com,
 edumazet@google.com, syzkaller@googlegroups.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 23 May 2024 11:35:20 +0800 you wrote:
> syzbot/KCSAN reported that races happen when multiple cpus
> updating dev->stats.tx_error concurrently.
> 
> Adopt SMP safe DEV_STATS_INC() to update dev->stats fields.
> 
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: yunshui <jiangyunshui@kylinos.cn>
> 
> [...]

Here is the summary with links:
  - net: filter: use DEV_STAT_INC()
    https://git.kernel.org/bpf/bpf-next/c/d9cbd8343b01

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



