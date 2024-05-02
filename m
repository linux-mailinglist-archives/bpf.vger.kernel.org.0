Return-Path: <bpf+bounces-28486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 047648BA428
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 01:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 981271F21BF5
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 23:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564DC156863;
	Thu,  2 May 2024 23:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzJ1QVPC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E8515689E;
	Thu,  2 May 2024 23:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714693230; cv=none; b=gjqG9OpTZu03SUX1GzilE2vNNum1NB1s8R1Z0yTggWCFIEOJ7e8HxlomKPS70CwPhZq6pJmHvesgVINlhdCuvY/92f1AJpxudPRchGcceliWtyxlwXMoz5aqOGtaLOCNfnjiJH72+O1Xv3rjRJ/4hDJfS1uNTdsSD4nXTxdyryM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714693230; c=relaxed/simple;
	bh=bTARC5f2XCsgfxPdClMLWk+PAT6Rftj89iMCX9lwFug=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W6ebanTOMGwzv9i4rN5QCDAdu/jjbmQYFqpKmQ2N/owkuKkFXRsvHxBOFhdYWJ0HNZyktEzLIu979BKg17VT0ggMhZr1zbUU9f9sXuQcXMfPnguMwnz2gRFszYEWtE76HrYNfF8gnxhs9rO/WY7JVLYPfC9GPzgTbFKw3/mHy9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzJ1QVPC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 494A9C32789;
	Thu,  2 May 2024 23:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714693230;
	bh=bTARC5f2XCsgfxPdClMLWk+PAT6Rftj89iMCX9lwFug=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QzJ1QVPCe9NLGUwZc3nsSBcEfGW9sKtSNKGaAmU95WDHNDJL8ee9Jtic69KisWD3A
	 BtsBOvFx98A0LOy9Sp0ZhBLTZatpo8yc2ELJ4jjkUtL2ICokwo19pnYV8MlyrXM7ep
	 btBaTRqos4fh7n49vIOH2Dxb4kdau4RnB+KC4An9h1VYxNOG2R2qgbdQkDfL9j/VC8
	 LvgdHWYRfWM6HMhaSMpGQfmoxYoqBSpORApW1vaayiqfW9iTD+Dtp6bqHDr1V0n2in
	 Nk7rZmr7DUiv64vnTQt4rezMjujwxU8NNbyTFtECmQ9paJCYCAcNNc09UjMeAfvh0A
	 qLB72qCDXW/vA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 39070C43337;
	Thu,  2 May 2024 23:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] Add new args into tcp_congestion_ops'
 cong_control
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171469323022.18467.15980884788609184083.git-patchwork-notify@kernel.org>
Date: Thu, 02 May 2024 23:40:30 +0000
References: <20240502042318.801932-1-miaxu@meta.com>
In-Reply-To: <20240502042318.801932-1-miaxu@meta.com>
To: Miao Xu <miaxu@meta.com>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, kafai@meta.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 1 May 2024 21:23:15 -0700 you wrote:
> This patchset attempts to add two new arguments into the hookpoint
> cong_control in tcp_congestion_ops. The new arguments are inherited
> from the caller tcp_cong_control and can be used by any bpf cc prog
> that implements its own logic inside this hookpoint.
> 
> Please review. Thanks a lot!
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] tcp: Add new args for cong_control in tcp_congestion_ops
    https://git.kernel.org/bpf/bpf-next/c/57bfc7605ca5
  - [net-next,v3,2/3] bpf: tcp: Allow to write tp->snd_cwnd_stamp in bpf_tcp_ca
    https://git.kernel.org/bpf/bpf-next/c/0325cbd21e3c
  - [net-next,v3,3/3] selftests/bpf: Add test for the use of new args in cong_control
    https://git.kernel.org/bpf/bpf-next/c/96c3490d6423

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



