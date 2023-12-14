Return-Path: <bpf+bounces-17840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEE0813483
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 16:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 423EB1F222DB
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 15:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC515C916;
	Thu, 14 Dec 2023 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGXmR0qn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57656584C7;
	Thu, 14 Dec 2023 15:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7922C433C9;
	Thu, 14 Dec 2023 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702567224;
	bh=ImQCyqn7m8WefgROQlxmBPQnGqiOC8FwiJes1EMIcYw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PGXmR0qnWlpe1f7tinHwBgezMxwFq2hRIIcLi8K+Yg7bdG/85IlkIwkm0GnRDvRnb
	 vsF8JlIjBgaz1tPxQsuRKqjj54xFC9AOr6AJDlpX5lw5IU4IJx1Sa+bYKcRpngAdTA
	 bUgP5MvQIVuM2zCW062/4xXZP99pS0ANMq6BXYT44k1LmT7SKd1jBhBBXjsBS/kaVk
	 0fn68Ya1HHBKxZwgivq1y+GhnKijl8wOp49S6+FlZDZTvgFWGJmxJvauKKGnX07NLt
	 MU3Qru7mCIrVROkxSyl7xOhiuIaNzldxIitmH9vhIzSDHeO3IVNhRcMxqNUE5Jsi2M
	 3n4d3lKkujIvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ACEC9DD4EFB;
	Thu, 14 Dec 2023 15:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/xsk: fix for SEND_RECEIVE_UNALIGNED
 test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170256722470.32245.14155656821997789860.git-patchwork-notify@kernel.org>
Date: Thu, 14 Dec 2023 15:20:24 +0000
References: <20231214130007.33281-1-tushar.vyavahare@intel.com>
In-Reply-To: <20231214130007.33281-1-tushar.vyavahare@intel.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 tirthendu.sarkar@intel.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 14 Dec 2023 13:00:07 +0000 you wrote:
> Fix test broken by shared umem test and framework enhancement commit.
> 
> Correct the current implementation of pkt_stream_replace_half() by
> ensuring that nb_valid_entries are not set to half, as this is not true
> for all the tests. Ensure that the expected value for valid_entries for
> the SEND_RECEIVE_UNALIGNED test equals the total number of packets sent,
> which is 4096.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/xsk: fix for SEND_RECEIVE_UNALIGNED test
    https://git.kernel.org/bpf/bpf-next/c/2e1d6a04116c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



