Return-Path: <bpf+bounces-68018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA82CB518F9
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 16:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7627B163AC3
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 14:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03FA322764;
	Wed, 10 Sep 2025 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kG2Y089p"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32165320A23;
	Wed, 10 Sep 2025 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513403; cv=none; b=XdL30xq+Yg0ImhNMT4dWSWksUove0HX1qgExwhcnQnRcE2DIhaF0fwSqV21qfC+8LwIJCdvHtqcabwQh+zu76CULEwA36oRVD4+ZtabAoNxhcey7a5x8dUTnw8uhC93hPs2sY6Mso+itbuyCP+ul+QRMNa9optMP7h7hALc0Gho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513403; c=relaxed/simple;
	bh=JsRAnJpUzBH43lCo12cfeXPuO+IyhIdSkffNT5H9rhQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Buub9PvhiiXB1nBtanVkLSSFXuqd75vkHEIjvWth5YckSQTgRHdxX/W2oOmkbiVSHKU3eerSDMslCTDz6nWYqc54+QrXY1TCk4zUqEJPEnhg/vUA+HCm1+aXaMo5+GisZxaTnYYf5EwtJOWRMYPA6CwGHEbAGdiFJUOpxOaySoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kG2Y089p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E5FC4CEEB;
	Wed, 10 Sep 2025 14:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757513402;
	bh=JsRAnJpUzBH43lCo12cfeXPuO+IyhIdSkffNT5H9rhQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kG2Y089p9owfgdx2+vSICta+5lGkuYIy7+DEp8MdwBPMZZZIx61rJu0MywZxoORnz
	 J5jqIo2bjItRzRYfHt4tY92398f3ER5LGmEBPfRbPB1W61/wfJqJsq26EPagzvwIAm
	 0I1PX3lkhrJmOXe5Iex4ZzPncnLoSFjqVwW8WfqRy0i9oElUWq/ZwrNq2GuHQZReBe
	 XofCaLRiEJuXywaOB5craE5gay6ETVA8o+Ivi0+UmRksnN6L4+k6h3V1V4SqrN9nnV
	 8v1qIFnWp6nI5uXIO0tXKfrKB4F4NHvoLiWk6MN4xsd3r+mUGIRnJUGwWoZ5T+GG7F
	 zRYbBwd7OewAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB08E383BF69;
	Wed, 10 Sep 2025 14:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 bpf] tcp_bpf: Call sk_msg_free() when
 tcp_bpf_send_verdict()
 fails to allocate psock->cork.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175751340576.1437658.9381331742790969125.git-patchwork-notify@kernel.org>
Date: Wed, 10 Sep 2025 14:10:05 +0000
References: <20250909232623.4151337-1-kuniyu@google.com>
In-Reply-To: <20250909232623.4151337-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, ast@kernel.org,
 daniel@iogearbox.net, kuni1840@gmail.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, syzbot+4cabd1d2fa917a456db8@syzkaller.appspotmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue,  9 Sep 2025 23:26:12 +0000 you wrote:
> syzbot reported the splat below. [0]
> 
> The repro does the following:
> 
>   1. Load a sk_msg prog that calls bpf_msg_cork_bytes(msg, cork_bytes)
>   2. Attach the prog to a SOCKMAP
>   3. Add a socket to the SOCKMAP
>   4. Activate fault injection
>   5. Send data less than cork_bytes
> 
> [...]

Here is the summary with links:
  - [v1,bpf] tcp_bpf: Call sk_msg_free() when tcp_bpf_send_verdict() fails to allocate psock->cork.
    https://git.kernel.org/bpf/bpf/c/a3967baad4d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



