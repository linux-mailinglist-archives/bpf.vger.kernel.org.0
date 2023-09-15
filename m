Return-Path: <bpf+bounces-10120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B29B7A1272
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 02:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B7A281DA5
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 00:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1525E7F5;
	Fri, 15 Sep 2023 00:40:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944AF7EE
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 00:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16487C433C9;
	Fri, 15 Sep 2023 00:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694738425;
	bh=ZlRU3i3+gHuoiXFWMPuTn7WYrjz/awV5PtxlgG+HNK4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HHSZn8oFip8Nrg6bAR2QRozCE96hEsKrm4SDPqawzLvWcU6ueAekjFat9etHtRPm1
	 Xen6n9+GFlEqLSzaUTolWzMVTk15iR6rslGIAXsP4RYWVTD+Vf0mgEO2ZwDwv+VMhi
	 pvoJyHkF9urujlgpe7BLjd3HGeztX5y4j9qjLYSztMziMovD86aou+Q3Uz3GL/OVwZ
	 f2veuV0ev030Kwnpg0wshFYHf8jCKFtYF3JcX6jpOWEf/pR7SULd8OjII74h9026tc
	 vyJSucS6YhvD3sgCCiIbIV+d2+rxHdePXicc4eZjX1VmGizBfTdMqsIHZjSfGluEIW
	 jx2rqQ8Qe2nRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EB26DE1C280;
	Fri, 15 Sep 2023 00:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] bpf: Charge modmem for struct_ops trampoline
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169473842495.10588.17454969647226569525.git-patchwork-notify@kernel.org>
Date: Fri, 15 Sep 2023 00:40:24 +0000
References: <20230914222542.2986059-1-song@kernel.org>
In-Reply-To: <20230914222542.2986059-1-song@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 14 Sep 2023 15:25:42 -0700 you wrote:
> Current code charges modmem for regular trampoline, but not for struct_ops
> trampoline. Add bpf_jit_[charge|uncharge]_modmem() to struct_ops so the
> trampoline is charged in both cases.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> 
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] bpf: Charge modmem for struct_ops trampoline
    https://git.kernel.org/bpf/bpf-next/c/5c04433daf9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



