Return-Path: <bpf+bounces-22414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D8985E2EE
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 17:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F5DA282638
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 16:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60F17CF0F;
	Wed, 21 Feb 2024 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rA7+OsbG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2584F3A1A2;
	Wed, 21 Feb 2024 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532428; cv=none; b=ulhKnmkncVgAw+Yj8Y2Zvr9Uh17zY9vauF7TdOtpOdNYNaNjf60l0A9RaMLthHYuTh6gkY5NCbfIIgeBVlgrJBgZsxEgB3rZjuWVcbGS8UTY+AIcqiBi43pEwUcLO6fCMz+k4Eflv/eT34CnhDYbx1yH4Cbf0PuCV00LFGDj1Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532428; c=relaxed/simple;
	bh=5wr33w/T9kALseOY48dUzIqVMJShfpjkothJ/pxJ2KU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k0UTHMOfMRH1lfDjSi5hNEWDBCIS80PeaZ0JiBmbJJ6PzjYXocfoIjg5v7UytWgK9GO5X4DRw880dnMgNA2klrlfUi14/CIa0OC9BRf50nGiHmSKIShXnVYA0UkNKf98hsz0TjXz+pNXF/LNujocL19gw+VFx/NSxkak7A9vVWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rA7+OsbG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3DA7C433F1;
	Wed, 21 Feb 2024 16:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708532427;
	bh=5wr33w/T9kALseOY48dUzIqVMJShfpjkothJ/pxJ2KU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rA7+OsbGG/z9bYSkjDcT2VFc/YQXK+TZWwnwg49YdmB+Xk+ePYXLBM5XFAf+79Mqq
	 79aHCbu2MRPCQwfZj7YQ70jFP8vwfenn8TDbk7t5ZBE6ceuPvEH+wvet8Yqm8UU+Y/
	 FJ7Ew6UTLsDvDOk6LAChyXnXfYdCZ1mVcpvpfhu6Tjzwe11Z6S1Aix5O45z42YiUGp
	 HGwQmRff62KshotWA/cfDiZlwFDE26K1g8KvkkTy743qYfQqg0nSQlr+mbMrPog0ON
	 8rtILUkjhxM8EnLHu53+558+q/NQ9v5gTDyUTureQ4wO2Zypb8EQ+Tu9d4OMywALR9
	 2a9bUFwNXaa0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A120FD84BB9;
	Wed, 21 Feb 2024 16:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf,
 sockmap: Fix NULL pointer dereference in sk_psock_verdict_data_ready()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170853242765.30674.6721237428334117697.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 16:20:27 +0000
References: <20240218150933.6004-1-syoshida@redhat.com>
In-Reply-To: <20240218150933.6004-1-syoshida@redhat.com>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+fd7b34375c1c8ce29c93@syzkaller.appspotmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 19 Feb 2024 00:09:33 +0900 you wrote:
> syzbot reported the following NULL pointer dereference issue [1]:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> ...
> RIP: 0010:0x0
> ...
> Call Trace:
>  <TASK>
>  sk_psock_verdict_data_ready+0x232/0x340 net/core/skmsg.c:1230
>  unix_stream_sendmsg+0x9b4/0x1230 net/unix/af_unix.c:2293
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:745
>  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
>  ___sys_sendmsg net/socket.c:2638 [inline]
>  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
>  do_syscall_64+0xf9/0x240
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> 
> [...]

Here is the summary with links:
  - [bpf] bpf, sockmap: Fix NULL pointer dereference in sk_psock_verdict_data_ready()
    https://git.kernel.org/bpf/bpf/c/4cd12c6065df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



