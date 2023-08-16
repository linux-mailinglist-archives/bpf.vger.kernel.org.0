Return-Path: <bpf+bounces-7920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A231477E776
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 19:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0DA281AE3
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 17:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFAA171CA;
	Wed, 16 Aug 2023 17:20:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9E210949
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 17:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D861C433C9;
	Wed, 16 Aug 2023 17:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692206422;
	bh=Wa0Z0yfgCkf6LN+/xVCk49mDaAkhunozD5JxmXcZ2RE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dGfvfsABmKnEbLUYrI0MRcHO8j31zdC3uhqDIT1Zju8E7FyGq1ky7ZLBz8pokzGR5
	 eMZebqkWgXucWmiOlzqgbNXB7jWSQCtw3s6tAghqzc7667AuHU1N5sa6SqFLPtXf01
	 dq1ILQKqt1wrh7o6nRwOQ0bIl+Z/prWKRHUxhzYNroav0RXS3ZoLeUOL3TE7Y3v/Ac
	 YOn2gfUfIr5lYNlC911BsgDh6mwB0OzWS3zfzNmCp8kuBXti8Dix4cTL3BlRteQQAt
	 WwLgwWquYq3/qI40G0mrZlIqp+VQIO/dibXc5QHipK+d7lwl9O9w78LkicIKTdj74K
	 rIJdY52rZH4CQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37CAAE93B30;
	Wed, 16 Aug 2023 17:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpftool: Implement link show support for tcx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169220642222.4978.1255568633447531671.git-patchwork-notify@kernel.org>
Date: Wed, 16 Aug 2023 17:20:22 +0000
References: <20230816095651.10014-1-daniel@iogearbox.net>
In-Reply-To: <20230816095651.10014-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@linux.dev, bpf@vger.kernel.org, laoar.shao@gmail.com,
 quentin@isovalent.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 16 Aug 2023 11:56:50 +0200 you wrote:
> Add support to dump tcx link information to bpftool. This adds a
> common helper show_link_ifindex_{plain,json}() which can be reused
> also for other link types. The plain text and json device output is
> the same format as in bpftool net dump.
> 
> Below shows an example link dump output along with a cgroup link
> for comparison:
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpftool: Implement link show support for tcx
    https://git.kernel.org/bpf/bpf-next/c/e16e6c6df475
  - [bpf-next,2/2] bpftool: Implement link show support for xdp
    https://git.kernel.org/bpf/bpf-next/c/053bbf9bff58

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



