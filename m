Return-Path: <bpf+bounces-10516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB5D7A9234
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 09:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D7CFB207E9
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 07:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03961524E;
	Thu, 21 Sep 2023 07:40:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEAA3D90;
	Thu, 21 Sep 2023 07:40:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6980EC43142;
	Thu, 21 Sep 2023 07:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695282036;
	bh=050Q5WMmZnTiDzRGfQUvp1iyQDTG+GBX9pc9ivL1p/8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZckeWmJnXpAMsas5kgCK6SohB/oAT0PrHQ63kFdXyd7RdNP/NglJ6y8ZqsvLj7/SY
	 1EGbQWeWjhrBUr6mKJUfNJs8iVqo7pDRysYz+MkpPDH9YMSWFi0A/YLVM5popCYhMr
	 TGr4dXdddFXPnG30GqBV9Lyh1DHHGrY2liAzTUzm2G0Sx5lXHmbR0vUMvm6gLPWV40
	 eXl1338jlJSM/eYuAmhZkgmqOCy4qX9XZ9yIBAEEyAu1gTudizkgk9wo9Cy2D4PGlC
	 gEQ/HGpTxg0jhliVQwBlK5GYgZUNMgV+yJm4EVaAqQkOSX9pllyESw+5v+/970w/1+
	 Xx5twF5w77mww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F791C595C4;
	Thu, 21 Sep 2023 07:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/3] Add missing xdp_do_flush() invocations.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169528203632.16376.17350345625835195632.git-patchwork-notify@kernel.org>
Date: Thu, 21 Sep 2023 07:40:36 +0000
References: <20230918153611.165722-1-bigeasy@linutronix.de>
In-Reply-To: <20230918153611.165722-1-bigeasy@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 ast@kernel.org, daniel@iogearbox.net, edumazet@google.com, kuba@kernel.org,
 hawk@kernel.org, john.fastabend@gmail.com, pabeni@redhat.com,
 tglx@linutronix.de

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 18 Sep 2023 17:36:08 +0200 you wrote:
> Hi,
> 
> I've been looking at the drivers/ XDP users and noticed that some
> XDP_REDIRECT user don't invoke xdp_do_flush() at the end.
> 
> v1…v2: https://lore.kernel.org/all/20230908135748.794163-1-bigeasy@linutronix.de
>   - Collected tags.
>   - Dropped the #4 patch which was touching cpu_map_bpf_prog_run()
>     because it is not needed.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] net: ena: Flush XDP packets on error.
    https://git.kernel.org/netdev/net/c/6f411fb5ca94
  - [net,v2,2/3] bnxt_en: Flush XDP for bnxt_poll_nitroa0()'s NAPI
    https://git.kernel.org/netdev/net/c/edc0140cc3b7
  - [net,v2,3/3] octeontx2-pf: Do xdp_do_flush() after redirects.
    https://git.kernel.org/netdev/net/c/70b2b6892645

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



