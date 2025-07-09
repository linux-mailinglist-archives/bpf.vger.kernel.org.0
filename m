Return-Path: <bpf+bounces-62726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F331AFDD09
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 03:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4404E2A8F
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 01:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B811A5B8B;
	Wed,  9 Jul 2025 01:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3dEyzX2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A99188A0C;
	Wed,  9 Jul 2025 01:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752025187; cv=none; b=MRQvJDWcUadGL6ndD6+A1oR9c0Syv6fex/VmmaW/HBjSkhR+doAUJxaRB2p9sKFgxObTBEUrAnMFebnOMU58PQpij7Qp/A2PVI0YFXrv8G/9BFz1g2N3sx+9y385RM247uDuRu0ZIcxu253dru8VfF57Btt5wk67F/hrxLyoROo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752025187; c=relaxed/simple;
	bh=6ML5YA4it8grKKhJrb64o2zSVzirfZI3NjKw3KK1E/4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iYtn+qEABs+k4ekO3e/1xwSrn0RaDVe6rkiHIQmFg8ii6hknLutEEjmz2KZ7ToUE6nlEVv+KBCTynql+zYK4OP2Fh/KdsMOmkn2O1ClirgXNJkCXSqAj8pIW2duXo+4uiVDGy6pvVGtx+wCXV4ZKZLVFB1ejRzvrvXUsinReo3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3dEyzX2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9412C4CEEF;
	Wed,  9 Jul 2025 01:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752025186;
	bh=6ML5YA4it8grKKhJrb64o2zSVzirfZI3NjKw3KK1E/4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u3dEyzX2/YB9oPKT7b/HTTaT68xsn2Ieau7yMb57ANF0CKjNc9ivT6eXoIys5s0Xw
	 xR3onpjEEJP46Oq2pK8S2Vu03MOSunsD7sFGOkXMuMqjTmpBA0w20L0Q5o5o61S0Jo
	 3+FmpGGwzmHLvnvyhtyYf7rd2RM/LX39w78dWDFdgXYUSay53t5ndxCo+g+8nek6+5
	 /sZoVqd3mHukcQdIZGtd0wy7Gp8F7CmsIzMDrCGCWgWWqf6lff80B4EHMuLJbgSPWB
	 3zWjemWDc48ddWmB6U81hXURf57eBV/gAysYkT4QdXlnVhF0GJFOk7lbu5LJaraWZ0
	 9jSqoRXwLF84g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E4D4A380DBEE;
	Wed,  9 Jul 2025 01:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/2] net: xsk: update tx queue consumer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175202520876.188489.13890705957887473516.git-patchwork-notify@kernel.org>
Date: Wed, 09 Jul 2025 01:40:08 +0000
References: <20250703141712.33190-1-kerneljasonxing@gmail.com>
In-Reply-To: <20250703141712.33190-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, kernelxing@tencent.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Jul 2025 22:17:10 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Patch 1 makes sure the consumer is updated at the end of generic xmit.
> Patch 2 adds corresponding test.
> 
> Jason Xing (2):
>   net: xsk: update tx queue consumer immediately after transmission
>   selftests/bpf: add a new test to check the consumer update case
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/2] net: xsk: update tx queue consumer immediately after transmission
    https://git.kernel.org/netdev/net-next/c/1eb8b0dac189
  - [net-next,v6,2/2] selftests/bpf: add a new test to check the consumer update case
    https://git.kernel.org/netdev/net-next/c/680acde13ffd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



