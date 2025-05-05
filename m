Return-Path: <bpf+bounces-57379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 161E3AA9E2B
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 23:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7023A5B7C
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 21:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF0F2741C0;
	Mon,  5 May 2025 21:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyliViz5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB53157A48;
	Mon,  5 May 2025 21:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746480591; cv=none; b=nrNLtY6L7W13uawYBY+oScQ1UiOzN9Lsro73pNaCqKT+7D0IvpKwW94GMFo4lYanLcSvjN+1XI5ukVOMJ4x5k/La9hPsa9MjMkxvcEItutARGyeFINoPmnPfG+epzLUE7joZYcp1GpV157l3h83TyU7jAmre4i72q95mXpnQTe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746480591; c=relaxed/simple;
	bh=XIwqPi7eiunKHhtXkr8+q/z08C5YP+xmW68hNjNRPtA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qw+6WD62sRVZHsavYE3Yv7Pp6BODMTtyReQtOAht9huUdiG9UykhAHyevJXoxelvtYlEsWQS/750EKpsnQoz0H6Yc6run2uo5s1tkECd2y1WaBPbJG/HNVfe5t7HMeU3WodxrQ6Hs6o8OjM8eStr1GErTWUePYyOg+BYpm3t02I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyliViz5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F33C4CEE4;
	Mon,  5 May 2025 21:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746480591;
	bh=XIwqPi7eiunKHhtXkr8+q/z08C5YP+xmW68hNjNRPtA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KyliViz5Wi645nbtNZFHvs3j6SOdjzhpv5/uDDkf1xmNsSJBefNAYDi0GIICialug
	 aQ4Vw7FKc9iFoIbAtwEMiZ1cQ/mS30BXqYQr6QKsuwSxCMeKpBSvpEYX7ozsY99zJ4
	 OIFrebS7FeqFizD+cLRb6t4gs/CivS/L+wOKn26wyiTxnBlgq5zHLT3NE2SwDgu+LZ
	 lr0vTSV9zBUlb5XpRx+F9CGhE+pIvd358FdkWxszMA0v8dVqAc8YGlrJDnZ/JUtdOc
	 VHddmH8K9Ed6P8+T82mQeIWq8neFYshalA3woT0mu3owHGrC26JBzkiN5I+Qip46kk
	 WPd0o7JAeTegw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE7C39D60BC;
	Mon,  5 May 2025 21:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: remove sockmap_ktls
 disconnect_after_delete test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174648063050.894801.1036879291071725008.git-patchwork-notify@kernel.org>
Date: Mon, 05 May 2025 21:30:30 +0000
References: <20250502185221.1556192-1-isolodrai@meta.com>
In-Reply-To: <20250502185221.1556192-1-isolodrai@meta.com>
To: Ihor Solodrai <isolodrai@meta.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 kuba@kernel.org, jiayuan.chen@linux.dev, mykolal@fb.com, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 2 May 2025 11:52:21 -0700 you wrote:
> "sockmap_ktls disconnect_after_delete" is effectively moot after
> disconnect has been disabled for TLS [1][2]. Remove the test
> completely.
> 
> [1] https://lore.kernel.org/bpf/20250416170246.2438524-1-ihor.solodrai@linux.dev/
> [2] https://lore.kernel.org/netdev/20250404180334.3224206-1-kuba@kernel.org/
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: remove sockmap_ktls disconnect_after_delete test
    https://git.kernel.org/bpf/bpf-next/c/a28fe3160362

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



