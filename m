Return-Path: <bpf+bounces-3737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 180B07427B7
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 15:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A30280E22
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 13:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBFA125BB;
	Thu, 29 Jun 2023 13:50:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1190AAD28;
	Thu, 29 Jun 2023 13:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DA72C433C9;
	Thu, 29 Jun 2023 13:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688046622;
	bh=tPHOeazIYJqtUaIpapmfwYkwFJ7b2e1P/zfK0tB0644=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HMivQ3lQOzaz7GetenJtuSMJ/kIIS19PNJ2RvbhzIdgO8tM46X00UCM/fxM1zgbyT
	 oGb8sBEoRP4F2UqnmzOuVVIjVfelVOSWw7mS5MjEHrRhYiSFYLxt2GT+2gfUbHMhgl
	 p/A5UpF6LCOGmMCwjisg01qXzNN1WBMzsDYwIatgAUGxeC7mjSe00iufen4f/xCu/c
	 DCIrfnDMi/cf/M/A2Hs1/hf/gopk+I1hnfJE5g9DkYvaJRbJTPr7y7VFYdBl8GwXte
	 J332SKxO/MCfGnzu1B6ME/SwmAHH6tdw/IKVdKp9MQBQKsz+uNr0mo8F90+eilRpKc
	 LrmMTJK3Jd0Eg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F2C6C39563;
	Thu, 29 Jun 2023 13:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] bpf: Replace deprecated -target with --target= for Clang
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168804662232.5062.13182575367358956077.git-patchwork-notify@kernel.org>
Date: Thu, 29 Jun 2023 13:50:22 +0000
References: <20230624001856.1903733-1-maskray@google.com>
In-Reply-To: <20230624001856.1903733-1-maskray@google.com>
To: Fangrui Song <maskray@google.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 quentin@isovalent.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, yhs@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat, 24 Jun 2023 00:18:56 +0000 you wrote:
> -target has been deprecated since Clang 3.4 in 2013. Use the preferred
> --target=bpf form instead. This matches how we use --target= in
> scripts/Makefile.clang.
> 
> Link: https://github.com/llvm/llvm-project/commit/274b6f0c87a6a1798de0a68135afc7f95def6277
> Signed-off-by: Fangrui Song <maskray@google.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> 
> [...]

Here is the summary with links:
  - [v2] bpf: Replace deprecated -target with --target= for Clang
    https://git.kernel.org/bpf/bpf-next/c/bbaf1ff06af4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



