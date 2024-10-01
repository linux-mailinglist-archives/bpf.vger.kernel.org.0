Return-Path: <bpf+bounces-40710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D33C98C647
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 21:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24D181F23F9C
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 19:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927D91CDFAF;
	Tue,  1 Oct 2024 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7zV3oJO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021641B86E6;
	Tue,  1 Oct 2024 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727812228; cv=none; b=nvmcvHoBvGCBF8C+QkO1igb8OAO3c7BBUSKzQiR0ic0NEzFJEWelR4f2YYCGP+Fmhdz4tJAkOoScNfHMkyGPGuNWuEFiSAlT2YSUM6sEeTeRUv4f7/T/ejwY665fe9mc78KQTjKtHaVSMA67l8KnUVzLmunlT8BRhSxBA3aKunU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727812228; c=relaxed/simple;
	bh=Sx3A4Jeys8k4Og3PUtR+rI5Zdg98sWtoyioNaK9nG84=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hBthZxiPjavcZmCPSoQTt+QfQ399fcdXVHTp1VBj0VznpuFbVa/LQeQvB1DiLheaEyDAsY+vFfJQB7ajMnhu32cICFYlDcM7uWVVe9KnIYlSCKtPVbCOlKQLs2aKeA2S0jhHsOZVSHs8Qz6t4hqJYxgsbpxb/Frp/Jyao0FcDGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7zV3oJO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD22DC4CEC6;
	Tue,  1 Oct 2024 19:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727812227;
	bh=Sx3A4Jeys8k4Og3PUtR+rI5Zdg98sWtoyioNaK9nG84=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p7zV3oJOPAF+or90gaWQlUvQgA18kIjGdAvZJB/gtJ+ReMtwJcISQFb287fUU2igG
	 yI3hkjDzR/cbPOFI8ZO8S6sWp0Pbk9Lo3pQGkOW8ThGJtXggfg1CNquHjW1FefZfP6
	 Q2bX+hchchbDO2VZlZHhpK2iatrrE0MAzTo//ErOF9QNfRI0aTox2of71W7sKWYjVe
	 r7rO3WVNomZLtcEhrOuTtHOhleumyP5UvNDMbBEAXAbjBotYXBuRcjUSMfIrBuYiWy
	 sVbGEF1T02nqLJwPmtYvlfzz0zn6vVfI+L6D/4BoKK4IDoj00NdW0OuWhpPUnZY0RY
	 XMmj8RF/ceMpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EB5380DBF7;
	Tue,  1 Oct 2024 19:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Make sure internal and UAPI bpf_redirect flags
 don't overlap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172781223105.541677.17664830432727433314.git-patchwork-notify@kernel.org>
Date: Tue, 01 Oct 2024 19:50:31 +0000
References: <20240920125625.59465-1-toke@redhat.com>
In-Reply-To: <20240920125625.59465-1-toke@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, liuhangbin@gmail.com,
 brouer@redhat.com, syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 20 Sep 2024 14:56:24 +0200 you wrote:
> The bpf_redirect_info is shared between the SKB and XDP redirect paths,
> and the two paths use the same numeric flag values in the ri->flags
> field (specifically, BPF_F_BROADCAST == BPF_F_NEXTHOP). This means that
> if skb bpf_redirect_neigh() is used with a non-NULL params argument and,
> subsequently, an XDP redirect is performed using the same
> bpf_redirect_info struct, the XDP path will get confused and end up
> crashing, which syzbot managed to trigger.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Make sure internal and UAPI bpf_redirect flags don't overlap
    https://git.kernel.org/bpf/bpf/c/09d88791c7cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



