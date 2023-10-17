Return-Path: <bpf+bounces-12423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD50E7CC40A
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 15:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CEF4B2107E
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 13:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A268142C14;
	Tue, 17 Oct 2023 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uG8uY7Xn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029653D3AF;
	Tue, 17 Oct 2023 13:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8908BC433C9;
	Tue, 17 Oct 2023 13:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697548223;
	bh=fjqg+d3uN/UZTcuNgFoQC2y2BQt837SnCY8bYVS5auw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uG8uY7XnN2MpCOjZyvuOQyHq1W6KxxtHB4BEZaOq57W9ViltNIMD5SRfoA6uRGtan
	 SAxaMBckNHjtIUCDbtFAHBrMRrKlW6h89G3+FlD/JZzDq2+an7EIzPAEbgHvgoKDgN
	 Hr1KORccf/wwBdQcvJIT9SGs/pjRDJpT+W+Suni5BVSsm/67E/W/Wsdn1ZNk3a07gL
	 2LbBCQWWOQf1vcscz7u8OxJ0cl2W80YnX1XktADzNzkw8/yGCKF/gmpMDomIGfC18L
	 /AR8f5U0S/I5B5PUZpxYip0/CSBLcV6Qig4a8m2CiZSOVLpyIXIjqN7m2TOHjEdumS
	 yQRLWyj5X7A1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C9D1C04E24;
	Tue, 17 Oct 2023 13:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next -v5] net: Add a warning if NAPI cb missed
 xdp_do_flush().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169754822344.726.6139633216361785104.git-patchwork-notify@kernel.org>
Date: Tue, 17 Oct 2023 13:10:23 +0000
References: <20231016125738.Yt79p1uF@linutronix.de>
In-Reply-To: <20231016125738.Yt79p1uF@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, kuba@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 bjorn@kernel.org, ast@kernel.org, andrii@kernel.org, edumazet@google.com,
 haoluo@google.com, hawk@kernel.org, jolsa@kernel.org,
 jonathan.lemon@gmail.com, kpsingh@kernel.org, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com, martin.lau@linux.dev, pabeni@redhat.com,
 song@kernel.org, sdf@google.com, tglx@linutronix.de, yonghong.song@linux.dev,
 toke@redhat.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 16 Oct 2023 14:57:38 +0200 you wrote:
> A few drivers were missing a xdp_do_flush() invocation after
> XDP_REDIRECT.
> 
> Add three helper functions each for one of the per-CPU lists. Return
> true if the per-CPU list is non-empty and flush the list.
> Add xdp_do_check_flushed() which invokes each helper functions and
> creates a warning if one of the functions had a non-empty list.
> Hide everything behind CONFIG_DEBUG_NET.
> 
> [...]

Here is the summary with links:
  - [bpf-next,-v5] net: Add a warning if NAPI cb missed xdp_do_flush().
    https://git.kernel.org/bpf/bpf-next/c/9a675ba55a96

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



