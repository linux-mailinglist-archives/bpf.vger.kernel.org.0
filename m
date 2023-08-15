Return-Path: <bpf+bounces-7846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E7C77D54E
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 23:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868FA281631
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 21:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA01119889;
	Tue, 15 Aug 2023 21:40:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4B118B16;
	Tue, 15 Aug 2023 21:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6DB2C433CA;
	Tue, 15 Aug 2023 21:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692135624;
	bh=/bWGDQI0tm0gMzYgGACwqNFcJi1YggVNzpHDJbmiBZw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k0ULCpGSHhlcH/jVqQveUbqW3VVAfNchO7aVRfjlWWK2U7FTXozSN35/9DzICKoKR
	 LPS342DeZS4rieCPcMuFWquonoPQXwFyo7bI1Ct26TTgynP8XfLx/4bgZz0QjzmFsd
	 bwBTWCYPoyBaPgHm69yJyWH5brU+qLRgF43vmyWaGrxdSLQEQ3wQKqtglCUrITA0vU
	 wrw+SVtsL0CDcPQjSSpCBTzES+D+49Y0t7KT0Ib2qPCt38aJ7Ho0Oy40L0qG8ZbrTo
	 xSLvBoy+gXNBLuHJhCB4iIUkIUQ8dMPpUH803SySY4H4vNZF9ZOmKzVcG/lGl0HTSn
	 ZqXDIrd6XGseA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD4A6E93B37;
	Tue, 15 Aug 2023 21:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] net: Fix slab-out-of-bounds in
 inet[6]_steal_sock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169213562383.15576.3157581774148181550.git-patchwork-notify@kernel.org>
Date: Tue, 15 Aug 2023 21:40:23 +0000
References: <20230815-bpf-next-v2-1-95126eaa4c1b@isovalent.com>
In-Reply-To: <20230815-bpf-next-v2-1-95126eaa4c1b@isovalent.com>
To: Lorenz Bauer <lmb@isovalent.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, daniel@iogearbox.net, kuniyu@amazon.com,
 martin.lau@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, memxor@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 15 Aug 2023 09:53:41 +0100 you wrote:
> Kumar reported a KASAN splat in tcp_v6_rcv:
> 
>   bash-5.2# ./test_progs -t btf_skc_cls_ingress
>   ...
>   [   51.810085] BUG: KASAN: slab-out-of-bounds in tcp_v6_rcv+0x2d7d/0x3440
>   [   51.810458] Read of size 2 at addr ffff8881053f038c by task test_progs/226
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] net: Fix slab-out-of-bounds in inet[6]_steal_sock
    https://git.kernel.org/bpf/bpf-next/c/8897562f67b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



