Return-Path: <bpf+bounces-62579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E854BAFBF48
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 02:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D77D1AA8477
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 00:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C7B1C8610;
	Tue,  8 Jul 2025 00:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQjfNYQH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224DC1F949;
	Tue,  8 Jul 2025 00:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751935385; cv=none; b=tpveMR32KG7+nNfw+t4tMDKk2LAjsB7TMAnbUM5Vt1pj4t2WPxsbPridLuoFBoTAAAWi5AWR2W4nDdWZ26bxcXCran3iXMoAy12y4aVTS62SNNmkOAXXH1fPebjNt66OmZWGzQfjZGzIDqqCXcji37C2eS+4rP2IMlIIfG/K0vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751935385; c=relaxed/simple;
	bh=rvRgTtkAbJ5UjetFFgsS85EbuGZzKRardxpRtim0slA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r4pX9LOFHNXCdLfhIDxRJZdLTROtisgMnYgOm91pBCiVYTjfjsDwZUdrO26ine8e5vtZWsWSt23t0tPQyCzw1t2Ur7XN1r3Rmiup9KrhVmQb39OG8TrbeaZHL+QQgu6fKmVvFEQ7N0P263b47d5pl/rgzxJrEmT+JxgEx1Wiy3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQjfNYQH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1EAC4CEF5;
	Tue,  8 Jul 2025 00:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751935385;
	bh=rvRgTtkAbJ5UjetFFgsS85EbuGZzKRardxpRtim0slA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PQjfNYQHNErd2rqBlt4MVVNjPk7wMPMkVKp1BuBT85rsX0CMqcgxQ+cpPdZbdWahK
	 N8hxQc4YxZpC0K9m+svR0zxoM3GgP/onSQI6ONxpGRuNq7fOh8Z4hVqg7W4NUZ/Tme
	 Z8R62IUDx8pOWngQ5p96neKaIYlfHVtfbJEztbZe2v39WvlN1kI50fDkjNhUlKIN9z
	 uD4hJVdmalvvGVnwwkIpbg0Wx+5dZcOX7ni8aNxvnQ7c4KrQ0hqz7KINZ+4KnqCAxs
	 WxU+FghN9bfblv4lJIkQ/z9+/VAzjPyHf4g2OM+3dauz0Ds4FMbe2BRXtr3kl3Tt0s
	 KeY4jFZHtOILg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D32383BA04;
	Tue,  8 Jul 2025 00:43:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vsock: fix `vsock_proto` declaration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175193540775.3455828.16493006355772974081.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 00:43:27 +0000
References: <20250703112329.28365-1-sgarzare@redhat.com>
In-Reply-To: <20250703112329.28365-1-sgarzare@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bobby.eshleman@bytedance.com, kuba@kernel.org, horms@kernel.org,
 pabeni@redhat.com, mst@redhat.com, virtualization@lists.linux.dev,
 bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Jul 2025 13:23:29 +0200 you wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> From commit 634f1a7110b4 ("vsock: support sockmap"), `struct proto
> vsock_proto`, defined in af_vsock.c, is not static anymore, since it's
> used by vsock_bpf.c.
> 
> If CONFIG_BPF_SYSCALL is not defined, `make C=2` will print a warning:
>     $ make O=build C=2 W=1 net/vmw_vsock/
>       ...
>       CC [M]  net/vmw_vsock/af_vsock.o
>       CHECK   ../net/vmw_vsock/af_vsock.c
>     ../net/vmw_vsock/af_vsock.c:123:14: warning: symbol 'vsock_proto' was not declared. Should it be static?
> 
> [...]

Here is the summary with links:
  - [net] vsock: fix `vsock_proto` declaration
    https://git.kernel.org/netdev/net/c/1e3b66e32601

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



