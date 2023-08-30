Return-Path: <bpf+bounces-8977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED6D78D3DC
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 10:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD84B2812CB
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 08:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C441F1C08;
	Wed, 30 Aug 2023 08:10:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF9D1871;
	Wed, 30 Aug 2023 08:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6BC4C433C9;
	Wed, 30 Aug 2023 08:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693383021;
	bh=WXnSBrmalBc3hjjcd0Ga8MsWW7kNYcNpuHqi82xK6Zo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NEe5Oc5bItfW/UYKFSYgP07tXiTJ87TxTwoy0n/0c2v46PBIYN7WJ1FqwBi1wh9sq
	 qS9fo6ORVTiVGSo/fIAwxZLTIVppU+w6Imo/NpnIAFeNu/HreSnOzaY9vnVvoLlmku
	 sdhC7fjjBevxLuYlDoFj1zsxOExvGBuKP6D07YILs7tV+3eaXS7IF7EbQB+qaLd0Uc
	 sConq8krvzRcM9NhMcwtqrmteMWN0TkmLkDUT4t9QAXtn5nTJUXuL4FfO03L1VmOCx
	 FpXksDUwbb78cFBPhx4XsEJLKc+FJFOX0JUcD3gX487NYAnbU0Oz/k9cIm/fhNVeni
	 tBfaGZOPJhj7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ACB6CC595CB;
	Wed, 30 Aug 2023 08:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: sockmap,
 fix preempt_rt splat when using raw_spin_lock_t
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169338302170.9000.3133905629277230133.git-patchwork-notify@kernel.org>
Date: Wed, 30 Aug 2023 08:10:21 +0000
References: <20230830053517.166611-1-john.fastabend@gmail.com>
In-Reply-To: <20230830053517.166611-1-john.fastabend@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, jakub@cloudflare.com, netdev@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 29 Aug 2023 22:35:17 -0700 you wrote:
> Sockmap and sockhash maps are a collection of psocks that are
> objects representing a socket plus a set of metadata needed
> to manage the BPF programs associated with the socket. These
> maps use the stab->lock to protect from concurrent operations
> on the maps, e.g. trying to insert to objects into the array
> at the same time in the same slot. Additionally, a sockhash map
> has a bucket lock to protect iteration and insert/delete into
> the hash entry.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: sockmap, fix preempt_rt splat when using raw_spin_lock_t
    https://git.kernel.org/bpf/bpf/c/35d2b7ffffc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



