Return-Path: <bpf+bounces-49703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6855A1BCCE
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 20:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEBED188FB0C
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 19:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A28CA64;
	Fri, 24 Jan 2025 19:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjIBj6//"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06D1224AFF;
	Fri, 24 Jan 2025 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737746407; cv=none; b=oWCS7Tl2DIPkK1i4Ko9vCf/zU8i7wwUIlPgrXVLA3rRbhjKgMKA7Fhn5ex3gZC15nUy6JFX1Gd5CEsMRWkvRkithKVD6o9PbMRbzw6UMOh+o/I6EroCK9HDBSHfJ4ej3vw0OdBUcJ85zPBZVSnpOHKnEyiIk4wPCIbu6Mk6g9m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737746407; c=relaxed/simple;
	bh=t+qfUeQ+fcSOWCUCqtvJkL+qC7XUSBRyTG05+qbxa58=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=imBexi4UNdjKDoug6jEBWB3gyriNxUVQnG2Va5m6KHoFRlKUqwAvnZ6hSbtn8LIGnLihn1Ir0JLU72+H66vZTs3b2mp3/+FO7e1arg1tVwkZd/lmicRyee1vxS7wPVtpT9nEZrdqSEw+MJPLyRIXDtHth2CCZkbtlzBr9YxGT3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjIBj6//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2532FC4CEE0;
	Fri, 24 Jan 2025 19:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737746407;
	bh=t+qfUeQ+fcSOWCUCqtvJkL+qC7XUSBRyTG05+qbxa58=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KjIBj6//CvZtj3ztR1QLFVlqwB5U6w1wJ1ScrqGQR1TA6b2YcbPhCIlHPm7Gi5nEP
	 e2YApPqAH4xvuCT2dCwDkPS46gw571qqVgJofyEa2T+r6LZOlWdFlqPvv+2byFGno7
	 NEgrg/4Xbd9OP0UuGyvjrcfwo1A2e6pDXSkfVP3BzTx/+iOmlXA7+bEKlYpBX3Zv8I
	 zqr5J8Ne85QX44nox8uGyCVrAWTZHGVdckJb0sxTo5W9A+q+XbsTZUXJ8ru6z8OKTJ
	 oKLw9GHmUTCAxskMvCOfi+GbQJrVoxJvk6qK41aodCoizmcIBkkTO0CiaB4VZH1nAV
	 gQESnSbBiI31w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34239380AA79;
	Fri, 24 Jan 2025 19:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 1/2] bpf,
 test_run: Fix use-after-free issue in eth_skb_pkt_type()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173774643202.2141694.5188738493066023591.git-patchwork-notify@kernel.org>
Date: Fri, 24 Jan 2025 19:20:32 +0000
References: <20250121150643.671650-1-syoshida@redhat.com>
In-Reply-To: <20250121150643.671650-1-syoshida@redhat.com>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 hawk@kernel.org, lorenzo@kernel.org, toke@redhat.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, stfomichev@gmail.com, syzkaller@googlegroups.com

Hello:

This series was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 22 Jan 2025 00:06:42 +0900 you wrote:
> KMSAN reported a use-after-free issue in eth_skb_pkt_type()[1]. The
> cause of the issue was that eth_skb_pkt_type() accessed skb's data
> that didn't contain an Ethernet header. This occurs when
> bpf_prog_test_run_xdp() passes an invalid value as the user_data
> argument to bpf_test_init().
> 
> Fix this by returning an error when user_data is less than ETH_HLEN in
> bpf_test_init(). Additionally, remove the check for "if (user_size >
> size)" as it is unnecessary.
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] bpf, test_run: Fix use-after-free issue in eth_skb_pkt_type()
    https://git.kernel.org/bpf/bpf/c/c5e8e573d6e4
  - [bpf,v2,2/2] selftests/bpf: Adjust data size to have ETH_HLEN
    https://git.kernel.org/bpf/bpf/c/f9f03a0a6d2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



