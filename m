Return-Path: <bpf+bounces-5893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CE27627B1
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 02:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76531C21034
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 00:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D95BA42;
	Wed, 26 Jul 2023 00:20:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33BC197
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 00:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3866C433C9;
	Wed, 26 Jul 2023 00:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690330822;
	bh=7wcN4rUePmmLlJk1tTMTnNhwadU28Arz2I7w3ZgklI8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=esGnh82foDyE3qC/MotoFMUx4XIIfLUebZJcW/MLKwIU/FJ6HkBNDe36sqW2n0pwF
	 WxG2o+oBANZTjZhbhMtW5+YX5HffU6mL6CAW5wuspiWbinCP9wKweaELMlVZaYlMQM
	 ZQqpESAwAmdCGvuUIVGWNM/T1zzXvwB6eZRRMe2dYSR1brJ9wKDoZEU//x6COhkP++
	 2g7YFGFSbts9xMR9Ugk25GOMBXY5vq1R+3KqaPwAir2C12J7B9aX03BZ0M0HFtkuqU
	 Q0XyhXNPX+3oYwwre1bM4E+IXAhkopoFYIih8I62n2nLGn7DNIYjMj/JYqe2QfC3I4
	 Zbuk/bsjMFQHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D2FA2C59A4C;
	Wed, 26 Jul 2023 00:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] [v2] bpf: work around -Wuninitialized warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169033082185.1972.9106498740194967439.git-patchwork-notify@kernel.org>
Date: Wed, 26 Jul 2023 00:20:21 +0000
References: <20230725202653.2905259-1-arnd@kernel.org>
In-Reply-To: <20230725202653.2905259-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 houtao1@huawei.com, arnd@arndb.de, alexei.starovoitov@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 memxor@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 25 Jul 2023 22:26:40 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Splitting these out into separate helper functions means that we
> actually pass an uninitialized variable into another function call
> if dec_active() happens to not be inlined, and CONFIG_PREEMPT_RT
> is disabled:
> 
> [...]

Here is the summary with links:
  - [v2] bpf: work around -Wuninitialized warning
    https://git.kernel.org/bpf/bpf-next/c/63e2da3b7f7f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



