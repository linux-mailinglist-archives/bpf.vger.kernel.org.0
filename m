Return-Path: <bpf+bounces-10179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4049B7A2716
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 21:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062471C2093C
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 19:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4E319BBD;
	Fri, 15 Sep 2023 19:20:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF50330CE4
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 19:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CE35C433A9;
	Fri, 15 Sep 2023 19:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694805625;
	bh=RO6qf7qZVjxCXaMK7rcZQigqMsi3RySqErofmju+oFI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lOHoLUBheqJX8Q2vzPkK+4g+JNeAKoWnVV86pnAHUNLb0XeuV+TFXtZ9Y2DEdKOR1
	 1hiaFOwKVQSMuj2KhpnyHiEes07J/92XPufYCIGDx/+fZSba82YfivY12TtYTwQH0J
	 rp4KP8YOaOD3dvbw0gujO87kTFZoI4iYqBamZeYgNBHPRwQjuTJoGTruCwgezPw7ze
	 FFbvUruis89jVnpH/Qnf2ykrM8eu1SLJf7AOipWoYRaHfLBQQA7EePhpn0ynWB/FRo
	 clqNtTuvFlb5QMIh/Ld+3vh6+yXYWAvInZpPzT2+mr/6v2yZxcjA1KhfCiUZPreDGo
	 S/723v6bd/XLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 477EDC04DD9;
	Fri, 15 Sep 2023 19:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: Allow to use kfunc XDP hints and frags
 together
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169480562528.6917.14116492715748764436.git-patchwork-notify@kernel.org>
Date: Fri, 15 Sep 2023 19:20:25 +0000
References: <20230915083914.65538-1-larysa.zaremba@intel.com>
In-Reply-To: <20230915083914.65538-1-larysa.zaremba@intel.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, maciej.fijalkowski@intel.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri, 15 Sep 2023 10:39:10 +0200 you wrote:
> There is no fundamental reason, why multi-buffer XDP and XDP kfunc RX hints
> cannot coexist in a single program.
> 
> Allow those features to be used together by modifying the flags condition
> for dev-bound-only programs, segments are still prohibited for fully
> offloaded programs, hence additional check.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Allow to use kfunc XDP hints and frags together
    https://git.kernel.org/bpf/bpf-next/c/9b2b86332a9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



