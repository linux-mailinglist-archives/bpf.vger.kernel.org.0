Return-Path: <bpf+bounces-13920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D21E7DECC8
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 07:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB71A1C20E63
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 06:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E67525B;
	Thu,  2 Nov 2023 06:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmZx7Iu1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD685227
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 06:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0F75C433C9;
	Thu,  2 Nov 2023 06:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698905424;
	bh=CK2wd29D7sMRJV+1cZRwIoB4gS/1YUiODe3zMqABG5g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AmZx7Iu165OM4j74dWT120lJiD4ZuxHEDejcFoWKXAZpMsTRp2jqmUqo9T9BkHJvP
	 lJI5WWuWs2UHwiVf2u+vBFNHqiE9lPvA+XBI5DJGwG0M5Qs3HwdcQRjeEMsdk/1Wcx
	 imXcIz0PzFhFOZUe91uxrQpup8uH5bk2Z/Z/Gopsezv1F1tgGRmfMcHPGtD6zxcMca
	 oVBnPAVzWSldauI8WovTxvpY15PyPlzfH9BgjR88YqeUpBhZOxEnt+S0mRURk3Vg+n
	 1sfSoKZaRZdPwpjg8PWdlmpZaZYR7+DFybzCWcbtSIPQdK7cILPhHWm5YMKw0H+Q2x
	 so2BztbBvXPVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C294E00092;
	Thu,  2 Nov 2023 06:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/3] Relax allowlist for open-coded css_task iter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169890542463.15699.9328828031519896553.git-patchwork-notify@kernel.org>
Date: Thu, 02 Nov 2023 06:10:24 +0000
References: <20231031050438.93297-1-zhouchuyi@bytedance.com>
In-Reply-To: <20231031050438.93297-1-zhouchuyi@bytedance.com>
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 31 Oct 2023 13:04:35 +0800 you wrote:
> Hi,
> The patchset aims to relax the allowlist for open-coded css_task iter
> suggested by Alexei[1].
> 
> Please see individual patches for more details. And comments are always
> welcome.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/3] bpf: Relax allowlist for css_task iter
    https://git.kernel.org/bpf/bpf/c/3091b667498b
  - [bpf-next,v4,2/3] selftests/bpf: Add tests for css_task iter combining with cgroup iter
    https://git.kernel.org/bpf/bpf/c/f49843afde67
  - [bpf-next,v4,3/3] selftests/bpf: Add test for using css_task iter in sleepable progs
    https://git.kernel.org/bpf/bpf/c/d8234d47c4aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



