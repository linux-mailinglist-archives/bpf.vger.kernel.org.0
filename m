Return-Path: <bpf+bounces-7202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A317977353A
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 01:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C46C61C20D98
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 23:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD78198A6;
	Mon,  7 Aug 2023 23:50:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1456B19893
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 23:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81258C433C9;
	Mon,  7 Aug 2023 23:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691452222;
	bh=3ox8N4UbJkYUVoQM9HDuodTEQzzFPD/IeODnTEvJytI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DhfhyWLG0ru8FLR6yMFqU0mDUby/ZOr5I8eE/bNGh4aBc3zJITkCgyktljbrB1eSh
	 HRTrjnHfc6un1LN1BhAvYDCgwA+CHehmfCqC0RXNcPrmDA/Te7fge2dvS8SCnW/zBH
	 RXTjJf3WpmR22Vyb4SGM3DzZ2SZJ5j1GM9dc21aLbf/HKsqshNPfombpS3FfRRxmss
	 gJk70vneu91GhIewc79jJiBbd7Y6e/qpyyh1EwZg0WS1fVorP7krZSSkuota3bO7uY
	 qwD1saf/e2rah03zDMcb/YwGZeJL8rSWT2VyZUZEHNP7bsvhAYvH6qtgOrku7LZFfV
	 Cd930waSa8FHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 591F4E270C3;
	Mon,  7 Aug 2023 23:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv3 bpf-next 0/3] bpf: Support bpf_get_func_ip helper in uprobes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169145222235.5057.338957706843977029.git-patchwork-notify@kernel.org>
Date: Mon, 07 Aug 2023 23:50:22 +0000
References: <20230807085956.2344866-1-jolsa@kernel.org>
In-Reply-To: <20230807085956.2344866-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
 haoluo@google.com, mhiramat@kernel.org, rostedt@goodmis.org,
 alan.maguire@oracle.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon,  7 Aug 2023 10:59:53 +0200 you wrote:
> hi,
> adding support for bpf_get_func_ip helper for uprobe program to return
> probed address for both uprobe and return uprobe as suggested by Andrii
> in [1].
> 
> We agreed that uprobe can have special use of bpf_get_func_ip helper
> that differs from kprobe.
> 
> [...]

Here is the summary with links:
  - [PATCHv3,bpf-next,1/3] bpf: Add support for bpf_get_func_ip helper for uprobe program
    https://git.kernel.org/bpf/bpf-next/c/a3c485a5d8d4
  - [PATCHv3,bpf-next,2/3] selftests/bpf: Add bpf_get_func_ip tests for uprobe on function entry
    https://git.kernel.org/bpf/bpf-next/c/e43163ed1c0a
  - [PATCHv3,bpf-next,3/3] selftests/bpf: Add bpf_get_func_ip test for uprobe inside function
    https://git.kernel.org/bpf/bpf-next/c/7febf573a58b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



