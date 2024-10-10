Return-Path: <bpf+bounces-41519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C059C997A2C
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 03:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EF05B22B1F
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 01:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABA12D052;
	Thu, 10 Oct 2024 01:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hua9PJVt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4C34C6C;
	Thu, 10 Oct 2024 01:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728523826; cv=none; b=QEbYafIif94y1G629WusFwDZZ2fcfN5CtqLGMtiE8NjZCVARb5Lbyvql9HGi12CnDHZ49HV58rzR8XUgJmDFJQZbYERdonCftrSECAsLr8XNbGhLnmqzOcs2r/hxYqBiA8PDdP5WNLq5WlgQ1GMJNHIXHCUapWluNemrfefBP2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728523826; c=relaxed/simple;
	bh=QLp0IT+USLybtIEn9rosf67rYcbk9sKmf9oRcZt4NGA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tcyYL1YVbURDRgh+6UagxPVNribt04jIti+aq5CEPWV8ljigff9CSiRqygdqjnRPep0OMUzd8VNcZdwsHukKZ8zYxwgr4S5y/fB7pwjvJOek73byzh7tUWuw9H4S1zrwe2WsqwVsbTRdhi7PsJdb0gW98YBZIuwWRCzcMwHEam4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hua9PJVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE64C4CECE;
	Thu, 10 Oct 2024 01:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728523825;
	bh=QLp0IT+USLybtIEn9rosf67rYcbk9sKmf9oRcZt4NGA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hua9PJVtuJX/DNJFfBdnSZv+Hsf74Z0Fo42dgBwfETPvhiV4vfjDSVfvftOF+oJ2S
	 13BEHeb9EDTrHDledEcub+1YY3oMQeuTGC81PvijgO5KJt/cKMQyarT30cjTw3M/TZ
	 nLIXsrGNVhfamLgC6GMuSYUrZofz40J9WDXub7IGn4yXOH8nJDzKpxlb2buqAT0lf0
	 a44m/jxo0NkASm0flaeptTL2lDXuDli05k5iohdJ7g/71WOLwmOIsikbdKzkQDeZSS
	 mnRPC6IAk0OMH4AdNxZNuJi0HfUbEeXldn5m0B5SiQkvhQWr1jJCvuw4WcdgQBUmqd
	 tTRZ8Bc4p9utw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3473806644;
	Thu, 10 Oct 2024 01:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] riscv,
 bpf: Fix possible infinite tailcall when CONFIG_CFI_CLANG is enabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172852382954.1532001.10566819180554959939.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 01:30:29 +0000
References: <20241008124544.171161-1-pulehui@huaweicloud.com>
In-Reply-To: <20241008124544.171161-1-pulehui@huaweicloud.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 netdev@vger.kernel.org, bjorn@kernel.org, puranjay@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, aou@eecs.berkeley.edu

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  8 Oct 2024 12:45:44 +0000 you wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> When CONFIG_CFI_CLANG is enabled, the number of prologue instructions
> skipped by tailcall needs to include the kcfi instruction, otherwise the
> TCC will be initialized every tailcall is called, which may result in
> infinite tailcalls.
> 
> [...]

Here is the summary with links:
  - [bpf] riscv, bpf: Fix possible infinite tailcall when CONFIG_CFI_CLANG is enabled
    https://git.kernel.org/bpf/bpf/c/30a59cc79754

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



