Return-Path: <bpf+bounces-39616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282A8975609
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 16:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF05B28AE48
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 14:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542141AB6FD;
	Wed, 11 Sep 2024 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQmszHKU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D7D1A3055;
	Wed, 11 Sep 2024 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066228; cv=none; b=D7RsceZ5dHmlEy0loBGmwAgsDiA10JtPVn15XKK4Aho6BTnxiDfsUQktvUFmTBr1vyIOsT3UPm6/Ybr1maBq21HUmLSRnABnJi3NUnoVhpaZmuZdVRd5cZNEfZ5g0iGN667C70aIVYxUXrcJmjZ99w2PvuYwB3VgxuKhxHmQN5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066228; c=relaxed/simple;
	bh=twrlZi7P1CLHK1G4Ex118u5rZQqKCnk9u0t9jxOh00M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dI7w4vsP6s36ZgH/jXWI4JEyGSqsJi6Z9j4AC3zvkDR0y/cFZGzHFce3tgWVExihBMEs3qcZTOZmZwMj34px4aCnbcpeMn7JEJHNtCi2wX9q0j2hFV2FPXF0cRM9aDjiOsrVg4v6erM4OC73oVMGbm/2Wgwoc/xgEgHDtC+iooA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQmszHKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6B2C4CEC0;
	Wed, 11 Sep 2024 14:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726066228;
	bh=twrlZi7P1CLHK1G4Ex118u5rZQqKCnk9u0t9jxOh00M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TQmszHKUGROY05ZD/Wk6AshdvJE1rlrqL/wXSnruvzu30O44hBmdp0pfxBfZb1R89
	 Taqndafqb0I5CIH9YP1f8glVKPRK3wQlCpFlemQvkBDdjrDtnK0kb97hJEf4XH01+U
	 CK4x8waT/6oM2kDCjnjqDkoOuMOmzRATj8Tojw1C9qOMqXLpZ8usiD612zLCN9mM/0
	 vI20RZbhzjiK387gTh+94k0A27iQ+qMqX6Btf/loXW3dBDAUrk/UeB04Zpyoo1WHhF
	 mDV+wgfd22+xklww/zqlVegxBQLYfHFOwowLxu0MQzVq3xo6NfGQ1MgqjPaDKridCP
	 zWV2WxaIYiyDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1803806656;
	Wed, 11 Sep 2024 14:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: cpumap: Move xdp:xdp_cpumap_kthread tracepoint
 before rcv
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172606622953.943906.17362698555849146465.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 14:50:29 +0000
References: <47615d5b5e302e4bd30220473779e98b492d47cd.1725585718.git.dxu@dxuuu.xyz>
In-Reply-To: <47615d5b5e302e4bd30220473779e98b492d47cd.1725585718.git.dxu@dxuuu.xyz>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: davem@davemloft.net, ast@kernel.org, hawk@kernel.org, kuba@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, lorenzo@kernel.org,
 aleksander.lobakin@intel.com, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (net)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu,  5 Sep 2024 19:22:44 -0600 you wrote:
> cpumap takes RX processing out of softirq and onto a separate kthread.
> Since the kthread needs to be scheduled in order to run (versus softirq
> which does not), we can theoretically experience extra latency if the
> system is under load and the scheduler is being unfair to us.
> 
> Moving the tracepoint to before passing the skb list up the stack allows
> users to more accurately measure enqueue/dequeue latency introduced by
> cpumap via xdp:xdp_cpumap_enqueue and xdp:xdp_cpumap_kthread tracepoints.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: cpumap: Move xdp:xdp_cpumap_kthread tracepoint before rcv
    https://git.kernel.org/bpf/bpf-next/c/23dc9867329c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



