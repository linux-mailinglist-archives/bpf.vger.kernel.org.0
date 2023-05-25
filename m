Return-Path: <bpf+bounces-1239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D071F711283
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 19:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA5D2815E7
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 17:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B061DDED;
	Thu, 25 May 2023 17:40:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BF5101DA
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 17:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F497C433EF;
	Thu, 25 May 2023 17:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685036420;
	bh=6lR24tYnVSc9VrPHNyM5ebtN5tD6HBQ8KjJNujLwM5g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LsMoHcmy30jJYrE3VfBIZj/PDFEfwjoZnpwlttLTZkhSOwAhTw5lIMVBhH55QDcXA
	 3Xy+UA2Yx1uG+bV0SZ75QejrpNlhWnxrHed32DEsJk0OOw8f8RWTTuHiz8kK+R9B5l
	 RmA/+ErrTrT8P+rG+ysgFfHqOau1ri85iDU8957Nj7LoOqvTjNS2CwouDYgaJ5CB4P
	 Pow7TX95KQ3UU3tkSawQN8zkfClqUKAUXMTA260LWP4ejDUcQHs4guEuJmOUkxciaH
	 GRjP2bKWnUx1jxjFJnTZcz28MKFoJcog7j2uChTtTfGqdAc1tTLmEqPqBHdQLZiuf+
	 B4x4okItZbRaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05271E270C2;
	Thu, 25 May 2023 17:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: change var type in datasec resize func
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168503642001.16498.12431429860493431577.git-patchwork-notify@kernel.org>
Date: Thu, 25 May 2023 17:40:20 +0000
References: <20230525001323.8554-1-inwardvessel@gmail.com>
In-Reply-To: <20230525001323.8554-1-inwardvessel@gmail.com>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 24 May 2023 17:13:23 -0700 you wrote:
> This changes a local variable type that stores a new array id to match
> the return type of btf__add_array().
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [bpf-next] libbpf: change var type in datasec resize func
    https://git.kernel.org/bpf/bpf-next/c/4c857a719bf9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



