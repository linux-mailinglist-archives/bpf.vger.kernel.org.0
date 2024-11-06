Return-Path: <bpf+bounces-44137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246D19BF644
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 20:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5610E1C22551
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 19:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC79520969B;
	Wed,  6 Nov 2024 19:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dfe0B7R+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF5B208235;
	Wed,  6 Nov 2024 19:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730920825; cv=none; b=SsZCclQFwGPKaRIw/IvY4D8+M06WnVb9w+vKZNEqlpAfYYvWm9wU7G19q8dN0RutJOqgMRuQ8dvzhjKQIujZcrb0IAAldMH3sgfMFG0Wwn4iPls7t0p2YmHaDMANfbLtqq54dIlSLFx+pW8F3myJ4wWVLlaPk6HzMsD2GMA/1T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730920825; c=relaxed/simple;
	bh=qozOId3Q0EdX6r2H9lzLIWZR1gOwHp8hWjvcEnPNL/Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uNcLeuw74MhEihrs6oQYV3eOk1xIM0AKvRjRfwSW6wd4/nE0FCOTeMVJdeSeCR39J1Wam7ZdRxA77XMrutB1VtnGRyd+IIXvyMIIDzwts9pp60P+ARABylWu0C/Tr50AisrUbgzus7SK+83DktGDmG6DBEKmZ7PmGwDKA+Wruv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dfe0B7R+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE858C4CECD;
	Wed,  6 Nov 2024 19:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730920824;
	bh=qozOId3Q0EdX6r2H9lzLIWZR1gOwHp8hWjvcEnPNL/Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dfe0B7R+2DeGaEecTGgrwVFW8txkU9IAZOK9XH2BlUCcjuG4O+oazhqZUNN1PHUva
	 uuMgq0ma8vqRak/YQMp0oxp0n98G8tMK1nHlXJNGUGTew9CNIwwj2mlLd0BlAsHDJU
	 kFDC25bgjNzr50UE/ZoWPvd4CVERklcaFXtEtZKsAgmUl42pB01TloSmhZBaemfRyy
	 o5ERb70AB6OjpI0uBMBRjr9J02R3TcxKbhVanBBu/U+I68QI5xmsBZTRy3o0P2C+u2
	 XJgFjKSNU98KTNLzYafavh9xakQtFNY2KCPyo7lbeEP+Xyf4oEkng0jrapglRBferk
	 q5ZCZAuc4xkQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0543809A80;
	Wed,  6 Nov 2024 19:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf] bpf: Add sk_is_inet and IS_ICSK check in
 tls_sw_has_ctx_tx/rx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173092083379.1386690.4462289480078199478.git-patchwork-notify@kernel.org>
Date: Wed, 06 Nov 2024 19:20:33 +0000
References: <20241106003742.399240-1-zijianzhang@bytedance.com>
In-Reply-To: <20241106003742.399240-1-zijianzhang@bytedance.com>
To: Zijian Zhang <zijianzhang@bytedance.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, borisp@nvidia.com,
 john.fastabend@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, mst@redhat.com,
 sgarzare@redhat.com, bobby.eshleman@bytedance.com, jakub@cloudflare.com,
 andrii@kernel.org, cong.wang@bytedance.com, jiang.wang@bytedance.com,
 netdev@vger.kernel.org, sdf@fomichev.me

Hello:

This patch was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed,  6 Nov 2024 00:37:42 +0000 you wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> As the introduction of the support for vsock and unix sockets in sockmap,
> tls_sw_has_ctx_tx/rx cannot presume the socket passed in must be IS_ICSK.
> vsock and af_unix sockets have vsock_sock and unix_sock instead of
> inet_connection_sock. For these sockets, tls_get_ctx may return an invalid
> pointer and cause page fault in function tls_sw_ctx_rx.
> 
> [...]

Here is the summary with links:
  - [v3,bpf] bpf: Add sk_is_inet and IS_ICSK check in tls_sw_has_ctx_tx/rx
    https://git.kernel.org/bpf/bpf/c/44d0469f79bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



