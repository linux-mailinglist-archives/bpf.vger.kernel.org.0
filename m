Return-Path: <bpf+bounces-12638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F161B7CED7A
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 03:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A43BB20F6A
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 01:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28DF15AE;
	Thu, 19 Oct 2023 01:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDVbdYx0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7D4642;
	Thu, 19 Oct 2023 01:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C84E6C433CA;
	Thu, 19 Oct 2023 01:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697678424;
	bh=C54e0EHjIdmAtJezDx02TQI4F+oCNKxLB5pVdsRSu9k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BDVbdYx0ME2eifnXLZgmBnKxNhMmEXaTogVRvupA80TFgFhX/roQOBbgie5+4nPo6
	 B15TKEdmT3PVWV125yPcbobLvr8mf//dsCFwWhJXKawU26IpqLeH5O174KuHVp7Fh2
	 UYE6H006MZ14da1hkp8y4+wFyYLiFc3z7627kxpiIZYDK94T/ql/T0Xd0Qo+pZDLpO
	 h0TwUoQuId857Z9MXwEYXFUcfixi8lGRC12tcSiGFqg3f67j5sQTZPOilvIfQHrwLl
	 gK7/AgWXfLRtdOOtGnlYfaT54MfunbkoD7mj2/dk8yHAgJj+cezaKKORJfzEdwyYdi
	 2OcEgxyG4u77A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE7F3E00082;
	Thu, 19 Oct 2023 01:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp_bpf: properly release resources on error paths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169767842471.18183.10678870196810764634.git-patchwork-notify@kernel.org>
Date: Thu, 19 Oct 2023 01:20:24 +0000
References: <8f99194c698bcef12666f0a9a999c58f8b1cb52c.1697557782.git.pabeni@redhat.com>
In-Reply-To: <8f99194c698bcef12666f0a9a999c58f8b1cb52c.1697557782.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, john.fastabend@gmail.com, jakub@cloudflare.com,
 edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Oct 2023 17:49:51 +0200 you wrote:
> In the blamed commit below, I completely forgot to release the acquired
> resources before erroring out in the TCP BPF code, as reported by Dan.
> 
> Address the issues by replacing the bogus return with a jump to the
> relevant cleanup code.
> 
> Fixes: 419ce133ab92 ("tcp: allow again tcp_disconnect() when threads are waiting")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net] tcp_bpf: properly release resources on error paths
    https://git.kernel.org/netdev/net/c/68b54aeff804

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



