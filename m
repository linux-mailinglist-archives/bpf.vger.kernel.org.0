Return-Path: <bpf+bounces-13072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BC87D42E4
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 00:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E8A281727
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 22:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC73B2376C;
	Mon, 23 Oct 2023 22:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fp/q4GKV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C38F1A722
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 22:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F502C433C9;
	Mon, 23 Oct 2023 22:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698101422;
	bh=7Dhe4kvHynzZAPO3Ux2XSN9a1PBCH7xgbEh2E0o4IsI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fp/q4GKV7lb6/sSiQton1kzfNMmwsHBampprHspHfV6bHVSrsTJmRi3n00KS1VsCQ
	 XGFrt5ZAqAc4s4a27YeW7nnFfOaHjmQje4MV4XSje/gkDWBNsQsepcOQA1gZeMzkca
	 iH8cWzlKcRMeTLCYnS6k9LMvgaw9Ctg/xKVUsB9hVJDaBVUm3Jgq8d4kvVQBd0G+VH
	 8TdVm2nb0bXCwmAUwuD1axAF9yzvA9YyX2+tnJOn9HiQlknNlrXjgWysqsi8rhRF46
	 1DL+QjCuaqxQNGNKHI8NUrDrnAyHGifKOTLM1wPw4Ifi7QPAgyJDv3yiUOj7Y8ebsF
	 gY7XqBgGc/pwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78470E4CC11;
	Mon, 23 Oct 2023 22:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf, tcx: Get rid of tcx_link_const
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169810142248.24047.4163332356958105235.git-patchwork-notify@kernel.org>
Date: Mon, 23 Oct 2023 22:50:22 +0000
References: <20231023185015.21152-1-daniel@iogearbox.net>
In-Reply-To: <20231023185015.21152-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@linux.dev, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon, 23 Oct 2023 20:50:15 +0200 you wrote:
> Small clean up to get rid of the extra tcx_link_const() and only retain
> the tcx_link().
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  include/net/tcx.h | 7 +------
>  kernel/bpf/tcx.c  | 4 ++--
>  2 files changed, 3 insertions(+), 8 deletions(-)

Here is the summary with links:
  - [bpf-next] bpf, tcx: Get rid of tcx_link_const
    https://git.kernel.org/bpf/bpf-next/c/b63dadd6f975

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



