Return-Path: <bpf+bounces-48619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B01A0A03A
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 03:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93030188E40B
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 02:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2EB13D51E;
	Sat, 11 Jan 2025 02:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tG4RJXaX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B6713B29F;
	Sat, 11 Jan 2025 02:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736561415; cv=none; b=F5x3pNOhyrQmIOjahd0FDXKX1d8CEUUfPqATEae9t0IE0eaQUA1+c4wD0nVNQ1fa2A94svDmOsN1s2DvS+a7pMYYB/Z+fcEKAQAP25Tx6P9lfLEeC3FZdXbdWp7j7F11Z3f5tq1oM06f07XXKQTNxNL6N0Hm7YjJlO/3oUnSXS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736561415; c=relaxed/simple;
	bh=9Mks8+kJ+Ij4gLE3fa+X6BGGi5dVMNVfe34gyPmH7dU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rQSL2sGKBxvKiUvLIpBZDZ80/iSK8XtP244jSQldzrATC9q9CE8U9n9PMhypuuHRn2aIco3yXNF1JrSwlwvD4Gu5Odba+aWr2R8QdfqtY8Aljw39xf3tvUhNtRFQTLzwuIizH78Mjnek2tSmHXcFHvlVF9QTKG5WcpNG7SYKTTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tG4RJXaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAB2C4CEE0;
	Sat, 11 Jan 2025 02:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736561415;
	bh=9Mks8+kJ+Ij4gLE3fa+X6BGGi5dVMNVfe34gyPmH7dU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tG4RJXaXgzPoBp9QaMad5NMzsZoTZjMy+ki6PjNu/9st9h8s5Q3v8sj2u33Rh/yjy
	 hja0JdYt8KOLKi83u4jZgMGF5oy3H1XH++To962YZzmCNC2fIojAqkxYn0ClC3qc9n
	 viAuHCBqxgQJVkJkJH2q8wVGYZal471hHUhyATi4+DYspLkZQ75KQZjwyZCslKUTOz
	 4fVMZNdEln3xWmeWIXnCuiVMyLJmRtFlHTYTa1pVzB+R1BlLP1hh9Db9RmjxDPPrpY
	 Glfmd0enSsZv70TmX+FQraSrxS3SP8e2iA59UoQ2uprrlwkba8ZxGHHLX4grcx+DJN
	 6GTvOMJ6yBdLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E24380AA57;
	Sat, 11 Jan 2025 02:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Fix bpf_sk_select_reuseport() memory leak
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173656143706.2267647.2275946918157104178.git-patchwork-notify@kernel.org>
Date: Sat, 11 Jan 2025 02:10:37 +0000
References: <20250110-reuseport-memleak-v1-1-fa1ddab0adfe@rbox.co>
In-Reply-To: <20250110-reuseport-memleak-v1-1-fa1ddab0adfe@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jakub@cloudflare.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 Jan 2025 14:21:55 +0100 you wrote:
> As pointed out in the original comment, lookup in sockmap can return a TCP
> ESTABLISHED socket. Such TCP socket may have had SO_ATTACH_REUSEPORT_EBPF
> set before it was ESTABLISHED. In other words, a non-NULL sk_reuseport_cb
> does not imply a non-refcounted socket.
> 
> Drop sk's reference in both error paths.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Fix bpf_sk_select_reuseport() memory leak
    https://git.kernel.org/netdev/net/c/b3af60928ab9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



