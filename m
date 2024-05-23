Return-Path: <bpf+bounces-30435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D92AF8CDBD4
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 23:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 755D4280CF6
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 21:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A26127E0C;
	Thu, 23 May 2024 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJkYhAS2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C1E14A82;
	Thu, 23 May 2024 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499232; cv=none; b=UBX9Ye9jXmH9qwFzMRq5fwl1VEWokuYhGDvJDenbbzdfWQ9LEtjzp1cYQMv+J5s7K6ChEOpzWP4O3LUqyP/hNWexOnHQR8Rfm7qL052JvLuO9Yp/OnVq6LzHIRkBJ+/+0MfR+XWsopMvbGd85jNVZPxnTI7yj381bKaCDr1vO9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499232; c=relaxed/simple;
	bh=jTjkNKGExpJBKmG7zWy/AKQEUbl8V5IN2OYICFQ6Q0Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hXfVrEZgNgsbQiZCdS64U/Er4WTYCwbwTN5c/UUFoUzZqxODWexEfP/YCu0dfDPn89gWnPB9Jiu2p5LukI68S6mxdlrTd5DBBUxon0nxwIPpEnLGDBt3E2Ddke1OVgYmouoNDESSdVWUyNuOFNAlE0addy9Ef6NqnN8ko+gTiDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJkYhAS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3271AC3277B;
	Thu, 23 May 2024 21:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716499232;
	bh=jTjkNKGExpJBKmG7zWy/AKQEUbl8V5IN2OYICFQ6Q0Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BJkYhAS29VwBfFPZbs/+s1kpFkUB3zhaz6bCnz7AnQEZQ1U/t3HZZl3s5r4csf61N
	 pGeScF+lta/zy1vo3Qb9UI43wkX58JJBEHJy3O/cdqDGLqmq/3E49URpV/fsk21898
	 0iUNpwMBzA3h7zADJrrDkRkDh31S1j0IytUorAH7bSh+xlVSyneBpYd2CqRXXnAP+B
	 N57L704gS9eNh5Ycl5w0eCdPhUZVRBsmkNAA8Wi2eiE7WQBYM/LeddAiHwNaMgS8Ed
	 4bZ0latRcTsXTR9qka1HougXl5pF85U3dfdPXznfxyR78M6mkQBMOVEkEJvOmTqZqb
	 mgoMkMavmDC8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16370C54BB3;
	Thu, 23 May 2024 21:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v8 0/3] Replace mono_delivery_time with tstamp_type
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171649923208.17278.8893614240560861833.git-patchwork-notify@kernel.org>
Date: Thu, 23 May 2024 21:20:32 +0000
References: <20240509211834.3235191-1-quic_abchauha@quicinc.com>
In-Reply-To: <20240509211834.3235191-1-quic_abchauha@quicinc.com>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ahalaney@redhat.com, willemdebruijn.kernel@gmail.com, martin.lau@kernel.org,
 martin.lau@linux.dev, daniel@iogearbox.net, bpf@vger.kernel.org,
 kernel@quicinc.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu,  9 May 2024 14:18:31 -0700 you wrote:
> Patch 1 :- This patch takes care of only renaming the mono delivery
> timestamp to tstamp_type with no change in functionality of
> existing available code in kernel also
> Starts assigning tstamp_type with either mono or real and
> introduces a new enum in the skbuff.h, again no change in functionality
> of the existing available code in kernel , just making the code scalable.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v8,1/3] net: Rename mono_delivery_time to tstamp_type for scalabilty
    https://git.kernel.org/bpf/bpf-next/c/4d25ca2d6801
  - [bpf-next,v8,2/3] net: Add additional bit to support clockid_t timestamp type
    https://git.kernel.org/bpf/bpf-next/c/1693c5db6ab8
  - [bpf-next,v8,3/3] selftests/bpf: Handle forwarding of UDP CLOCK_TAI packets
    https://git.kernel.org/bpf/bpf-next/c/c34e3ab2a76e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



