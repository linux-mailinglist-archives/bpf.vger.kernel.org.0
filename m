Return-Path: <bpf+bounces-697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733D8705E2F
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 05:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059C52812DA
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 03:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD966210C;
	Wed, 17 May 2023 03:38:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861D717E0
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 03:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F552C433EF;
	Wed, 17 May 2023 03:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684294682;
	bh=k2sYiGZJ8tu6suYA++WWdioWecKhzsHSuokRkhDK5Hw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eJX/Iw+HqKb1wk7eKhC4tzHVljM6L9SET0IeIy8X4jsH2R2x8F5hgciUbKrfFGGv5
	 rkhMpaJsNpPe7VSy03IyIwozkNmX8La0pSvBFSbrn07w/YNhSO49+kt6vAIeHZB8sb
	 +bPsUreEaByeCI8LJ2rad6hZMxXPDoHj2w34y1E80LWVAQTD3AQyA1y8RFeRNywZn/
	 HAXf1x8amm+gPejlR0vOqFsFerr6c13Nz1mKEq7IbyU1mJk/s+QIHzgDxRx8WlWqXt
	 nsFn8D0Igu23mbFXk962KJ0jHpX67Ns5UWUaoZJpfVvWs95rSedgcVCf+zYAUdjre/
	 JKzgpjdzt+hLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15B78C41672;
	Wed, 17 May 2023 03:38:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: improve netcnt test robustness
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168429468208.3680.3925871135998002940.git-patchwork-notify@kernel.org>
Date: Wed, 17 May 2023 03:38:02 +0000
References: <20230515204833.2832000-1-andrii@kernel.org>
In-Reply-To: <20230515204833.2832000-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com, sdf@google.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 15 May 2023 13:48:33 -0700 you wrote:
> Change netcnt to demand at least 10K packets, as we frequently see some
> stray packet arriving during the test in BPF CI. It seems more important
> to make sure we haven't lost any packet than enforcing exact number of
> packets.
> 
> Cc: Stanislav Fomichev <sdf@google.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: improve netcnt test robustness
    https://git.kernel.org/bpf/bpf-next/c/387912285917

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



