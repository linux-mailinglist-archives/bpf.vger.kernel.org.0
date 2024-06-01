Return-Path: <bpf+bounces-31100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 223198D7294
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 00:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DFA281F27
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2024 22:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA4636B17;
	Sat,  1 Jun 2024 22:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNml8Avj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1701CD2F;
	Sat,  1 Jun 2024 22:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717282229; cv=none; b=O+IBH2TL3caNb8ADHQvtNaeM80M8HLJK+MNSZysDQSB9bC3Bn90P5SGYXgHualcuQ93scusy/pkb3mh+tbrTlHohrsGAm70MThyT0T2r787ozH82i9IcoLw/zEuRXmdLSSq9GbfiH4EfNkmfLtTS4sCH/9fDpiepQaZYmW4bBsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717282229; c=relaxed/simple;
	bh=WYIoV3flTPK7thIlJstnff9yvybdKCWv88V6Kfn1pEo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MZmSxWEp8oXruvrPhtOwYLLGuTwFQpfcyordOJHOl5eflI6i6HMffIEq7F5Q3AJLLQwz2+RWVuW+qeb6NuSyVjmUOPsWb707cqK51jgdG026uvC9x8gdy9ISVlDGODYRQ6P5z5vvTYT4noAYygK0nHNOaA5mdLVO9eXPFXP+0aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNml8Avj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0CE80C32786;
	Sat,  1 Jun 2024 22:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717282229;
	bh=WYIoV3flTPK7thIlJstnff9yvybdKCWv88V6Kfn1pEo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HNml8AvjRIqI+R5c4ULQKE6Wwgo81WJsGEjzKd/00pgO4W+yggLLRPEPi0vPBpUM0
	 0lvxHox7r+mmqymXC44OzwLYhlySKGuPkUQuLbByF8BtHvlTnRHkHv8Z3or4EpqMxM
	 uCtCJLvBPPJCfqySVMJUGy3wyX+RTkWO94K3b2AIGBoJc1SYi1f/N0NBiPe5KwrjV6
	 M3DG8IX/CiS2LeGicG0zDjX4eTW68m+FpOST3PkvsudXrST3+tbSrtGrf5nxJ9v+6v
	 2eU8WDgCRGrN9yBHPIACTl28D0s24SGLThAQzv6VKd6xGswNrrx2cSdDhbaR9O8lbO
	 HV78sJKKv9p5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EDF73DEA711;
	Sat,  1 Jun 2024 22:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: validate SO_TXTIME clockid coming from
  userspace
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171728222897.32002.3866556698576505524.git-patchwork-notify@kernel.org>
Date: Sat, 01 Jun 2024 22:50:28 +0000
References: <20240529183130.1717083-1-quic_abchauha@quicinc.com>
In-Reply-To: <20240529183130.1717083-1-quic_abchauha@quicinc.com>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ahalaney@redhat.com, willemdebruijn.kernel@gmail.com, martin.lau@kernel.org,
 martin.lau@linux.dev, daniel@iogearbox.net, bpf@vger.kernel.org,
 kernel@quicinc.com, syzbot+d7b227731ec589e7f4f0@syzkaller.appspotmail.com,
 syzbot+30a35a2e9c5067cc43fa@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 May 2024 11:31:30 -0700 you wrote:
> Currently there are no strict checks while setting SO_TXTIME
> from userspace. With the recent development in skb->tstamp_type
> clockid with unsupported clocks results in warn_on_once, which causes
> unnecessary aborts in some systems which enables panic on warns.
> 
> Add validation in setsockopt to support only CLOCK_REALTIME,
> CLOCK_MONOTONIC and CLOCK_TAI to be set from userspace.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: validate SO_TXTIME clockid coming from userspace
    https://git.kernel.org/netdev/net-next/c/73451e9aaa24

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



