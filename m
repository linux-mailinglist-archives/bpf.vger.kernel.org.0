Return-Path: <bpf+bounces-57301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB673AA7D76
	for <lists+bpf@lfdr.de>; Sat,  3 May 2025 01:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E1CD987486
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 23:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D4C23ED5E;
	Fri,  2 May 2025 23:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/leqgbZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D0120E703;
	Fri,  2 May 2025 23:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746229798; cv=none; b=n2u65c+yUR+QrdSybfKASiFI/0xyCwy6VsJCBl47BnfyzZlZbIKY7dbdC6Fy57vOAnO64WQFWkOKCa0m7lmdfIJaELPsGiY+mN5GQ/F803aMf6Z79a/jRpH4G2kFVmyYBmqz5cMLXSrcdFuStyyqTS/12/9zQdMYiqnu/yh9GMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746229798; c=relaxed/simple;
	bh=yG9LcAGUkC+cOxnXcJ4G8nVqrUCz6qNazF2vIUeNWJs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UCzUhU30R0812gt8bId1JzFMJVqTAB+m6lhxl0lNWGEWMGwi3hLLjAu+UINGJ/udHmCch6Oput0YJh8OguX919BEK/MGEpLTi9pkd5BBWH3uWg+SlgL6/VQ3nY+OuiIzsHQhuBLA5ejkvLV3LE6XIC3bmhmeCtI2LZmzupIi2HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/leqgbZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E91C4CEE4;
	Fri,  2 May 2025 23:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746229798;
	bh=yG9LcAGUkC+cOxnXcJ4G8nVqrUCz6qNazF2vIUeNWJs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U/leqgbZympbLDIuK8XjBV2AX07E0JcObJ/DtD04hmm5LRcbUox1Lw6u4c4DRIIOP
	 gQjZEQm9Ag6blWkWUM1xdL9fYM77jdoK4Q6uJv83eUCBTLyilJA1GJdRe9rfxogtOK
	 iW3sVDRb08p9YWV/bSsj/R1l/QWne4Q0n1pBvdISJFEyC7466S0qfclfFl0OEbEnV1
	 PAp/RcLkKU08LK/tihRIrRs+2Q9hPml3FIM6IQBR+pTkAtbuoou3kY1XxZGR0ubSCS
	 +VpxSgskpcyeyW5trruyvWet6NBOlOQMUM3XKGDVIvU8/XANTUFyzm6XVktxwanceE
	 CR+xsM0ilM1oA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D16380DBE9;
	Fri,  2 May 2025 23:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next/net v2 0/5] Fix bpf qdisc bugs and clean up
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174622983725.3760707.369591195110683703.git-patchwork-notify@kernel.org>
Date: Fri, 02 May 2025 23:50:37 +0000
References: <20250502201624.3663079-1-ameryhung@gmail.com>
In-Reply-To: <20250502201624.3663079-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 xiyou.wangcong@gmail.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri,  2 May 2025 13:16:19 -0700 you wrote:
> This patchset fixes the following bugs in bpf qdisc and clean up the
> selftest.
> 
> - A null-pointer dereference can happen in qdisc_watchdog_cancel() if
>   the timer is not initialized when 1) .init is not defined by user so
>   init prologue is not generated. 2) .init fails and qdisc_create()
>   calls .destroy
> 
> [...]

Here is the summary with links:
  - [bpf-next/net,v2,1/5] bpf: net_sched: Fix bpf qdisc init prologue when set as default qdisc
    https://git.kernel.org/bpf/bpf-next/c/659b3b2c4885
  - [bpf-next/net,v2,2/5] selftests/bpf: Test setting and creating bpf qdisc as default qdisc
    (no matching commit)
  - [bpf-next/net,v2,3/5] bpf: net_sched: Make some Qdisc_ops ops mandatory
    https://git.kernel.org/bpf/bpf-next/c/64d6e3b9df1b
  - [bpf-next/net,v2,4/5] selftests/bpf: Test attaching a bpf qdisc with incomplete operators
    (no matching commit)
  - [bpf-next/net,v2,5/5] selftests/bpf: Cleanup bpf qdisc selftests
    https://git.kernel.org/bpf/bpf-next/c/2f9838e25790

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



