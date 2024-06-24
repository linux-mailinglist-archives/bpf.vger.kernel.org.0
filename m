Return-Path: <bpf+bounces-32883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B14C914721
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 12:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997981C20833
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 10:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156361369A3;
	Mon, 24 Jun 2024 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQdZV42x"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839AA13210F;
	Mon, 24 Jun 2024 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719223828; cv=none; b=NQyBH+ohj5LUdk9pqv3H5z268rcmYi7BEpKOIInuHlQDcbDYMN3Q5lovOKLlAIGSmewH927AZlQpddLHmHbEnKy2HI8GyQ6Dif/fO/uy9OBBlR/8RxXWdZkkGVKNF4AtjGwFV4x2HqyL1vnBoA07wNUBT1imPX5oyo6eX6cqyw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719223828; c=relaxed/simple;
	bh=XhncQClzbgLJqhQOy7cmwhJVz4/rc9f7R84oBySYTV4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=buHFTAE7Zh39ORLEJHuwdgodhHfIo6c7Q+vcVe7VaNtxCPa4crH3K+tBBNn9LU7l3nYOK+H3ssLhIrIpbDkJ/LS06g8XZiX2GpsNyl5ea/eimAkzMsDAlZs8dF9lGIciP18xJaDo+c/bc3OcpwgecIlvA/i8hS+btIbRJ37pGhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQdZV42x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05ED1C32781;
	Mon, 24 Jun 2024 10:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719223828;
	bh=XhncQClzbgLJqhQOy7cmwhJVz4/rc9f7R84oBySYTV4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gQdZV42x/SeU6FEE4HdcRLPKgA5iBKW2TovLtVJptA3fUNzzzorJmpi7Xt/voGIfN
	 CRGQD7GzdwWT1dkykQWMwbJ2XerUJSDdoN1ndN5OGfosEWXMtqj+r+Ts62OODtynIt
	 U5X+0eoq40aousiYeV3KHOQupkN47mJCb8DdqB1Z3pvzGc70rCCD8PCxKURp+EWBp2
	 xzIZ7uEqYPmiGE+/QFrAjYXtYcwDgAwOiFa4oayN4T9YFPdRNVvqIc+mKhGEFZmi2c
	 o/gzxFPj7mAnmAOHWsLl5xMlYx3pP8WTQL/qs7IOwN30Bq+ozBdOlvpXHM2fWVoAW3
	 O8PLwk30r+jfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8ED5C43612;
	Mon, 24 Jun 2024 10:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] xdp: remove WARN() from __xdp_reg_mem_model()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171922382794.32124.7324961008549408200.git-patchwork-notify@kernel.org>
Date: Mon, 24 Jun 2024 10:10:27 +0000
References: <20240624080747.36858-1-d.dulov@aladdin.ru>
In-Reply-To: <20240624080747.36858-1-d.dulov@aladdin.ru>
To: Daniil Dulov <d.dulov@aladdin.ru>
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 24 Jun 2024 11:07:47 +0300 you wrote:
> Syzkaller reports a warning in __xdp_reg_mem_model().
> 
> The warning occurs only if __mem_id_init_hash_table() returns
> an error. It returns the error in two cases:
> 
>   1. memory allocation fails;
>   2. rhashtable_init() fails when some fields of rhashtable_params
>      struct are not initialized properly.
> 
> [...]

Here is the summary with links:
  - [v2] xdp: remove WARN() from __xdp_reg_mem_model()
    https://git.kernel.org/bpf/bpf/c/de081f82e810

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



