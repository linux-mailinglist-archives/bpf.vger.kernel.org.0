Return-Path: <bpf+bounces-7200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEB07732E3
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 00:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B9F6281141
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 22:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F3A17ABA;
	Mon,  7 Aug 2023 22:20:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4008113AE6
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 22:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7CA3C433C8;
	Mon,  7 Aug 2023 22:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691446823;
	bh=Lkc15j215C4ckSP0oPopDCNkI5tescWhs8KR7n6nmLs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uNN88hcSVWpyd6Gqjeo+OIwUcxeLLut0yIFtFft5sFoQn0UM+ZYFfWd6nyya0IbcO
	 tbCl80vgFcFrChKNMubjWKrWg4TL9bgjNe+mmnkal9efn9fLOnyCbfNJPOVqUgoF7m
	 HuoYF9H3D8HSW8Df5QnPMcZCWQwU4Bxa050lbbf0Y/fGMbG82aAR8WiQqi8WXgCRwL
	 Kp3UDVD8FDks2E4ETFdoAx9dILJ/xh/rB8t+pmfQiNHIkKk80wBbTM5eoeo4iHtD+c
	 GiVMDdcGf42GBQA0FMA1loafS590DWEyn7XZBEXyOetUyvkixKxUvtF5lp5f/DZeA8
	 H0swrgZKY5Q5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C613C73FE9;
	Mon,  7 Aug 2023 22:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 1/1] bpf,
 docs: Formalize type notation and function semantics in ISA standard
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169144682363.19305.6996123874040654160.git-patchwork-notify@kernel.org>
Date: Mon, 07 Aug 2023 22:20:23 +0000
References: <20230807140651.122484-1-hawkinsw@obs.cr>
In-Reply-To: <20230807140651.122484-1-hawkinsw@obs.cr>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf@vger.kernel.org, bpf@ietf.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon,  7 Aug 2023 10:06:48 -0400 you wrote:
> Give a single place where the shorthand for types are defined and the
> semantics of helper functions are described.
> 
> Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
> ---
>  .../bpf/standardization/instruction-set.rst   | 82 +++++++++++++++++--
>  1 file changed, 74 insertions(+), 8 deletions(-)
> 
> [...]

Here is the summary with links:
  - [v4,1/1] bpf, docs: Formalize type notation and function semantics in ISA standard
    https://git.kernel.org/bpf/bpf-next/c/2369e52657d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



