Return-Path: <bpf+bounces-7279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30886774FD3
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 02:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FB021C210A3
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 00:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED43665E;
	Wed,  9 Aug 2023 00:30:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637C364E
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 00:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE39CC433CA;
	Wed,  9 Aug 2023 00:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691541021;
	bh=edi7eXyaLuXBiTTbZNYXictu8lxqS6U0/aQO9Rz9iHQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JUiz5B/waR+Y5JGtmU3Zwd4qQsaspNbATiayyujN8NztZBOsT9vRx4RT8IH02x+Et
	 o6/+BYynaFdSFqzj0VrXAVYHBXOVzgx+TIeHgIU6oFFzKt7JfO902Ij48O0zS2vMiB
	 3zozl7koSbR6vyoUs9kKFuQHYIi5/NHRogd+UBhDpO81cRwOKkQtRtRPhdcaVKGRar
	 RVAQEo/waPc4rk13v7fLtd7JcAEH9Cg6lq9+zgfmQTjf3lv/o2MEszvzHrglrIJAR0
	 byiSWsCzkXWOsyqbgLPQjWExVcLae3HDIV/mDDGSEuipr9WB1H56MC5bp1a2yl9sxf
	 oirzo/HjVaSJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4148C395C5;
	Wed,  9 Aug 2023 00:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: lru: Remove unused declaration
 bpf_lru_promote()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169154102072.20035.6021926912927051192.git-patchwork-notify@kernel.org>
Date: Wed, 09 Aug 2023 00:30:20 +0000
References: <20230808145531.19692-1-yuehaibing@huawei.com>
In-Reply-To: <20230808145531.19692-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 8 Aug 2023 22:55:31 +0800 you wrote:
> Commit 3a08c2fd7634 ("bpf: LRU List") declared but never implemented this.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  kernel/bpf/bpf_lru_list.h | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [bpf-next] bpf: lru: Remove unused declaration bpf_lru_promote()
    https://git.kernel.org/bpf/bpf-next/c/526bc5ba19e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



