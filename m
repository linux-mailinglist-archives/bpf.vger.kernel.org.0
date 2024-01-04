Return-Path: <bpf+bounces-19008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4D3823BBF
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 06:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09A85B24E96
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 05:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F35179BA;
	Thu,  4 Jan 2024 05:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AywMcwKg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9D714F6E
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 05:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27DA2C433C7;
	Thu,  4 Jan 2024 05:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704345632;
	bh=k0+TGski2a9ARajCvzBwDHcLdAqC4GISDDHlZlHr4Zc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AywMcwKgTb7fMEVL111L7vo3zUCK3VBQU1DGip4+QGjJdzi92rqNaQUfsPHkmMA6H
	 U86lQrqpAwnZLrvKN/AuzXIHs9nNOteqFNmIsrxfuAepL5X1XfAV7kH8SRD93Udqyh
	 r/xuxM8XvDoXKSlx434E+et6AEisXytAUHCaPQ/up9xSz029PSLbGo4W0oGrNukmKz
	 zFgBnjGegKTOeuiful4CCq7yT5OmwOupwCXsZZ4IqjYvRIj4guUZIh86Yh30g1qUoo
	 eB52I3/1em/T5kHirha0TIlT6KTPX0rbKItz+U8hN4LZYfWHsOr2SFqiRUhJOBgZiU
	 +dbNofD2hWfsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01D8EDCB6D9;
	Thu,  4 Jan 2024 05:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 0/8] bpf: Reduce memory usage for
 bpf_global_percpu_ma
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170434563200.4563.13003623182272424061.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 05:20:32 +0000
References: <20231222031729.1287957-1-yonghong.song@linux.dev>
In-Reply-To: <20231222031729.1287957-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 21 Dec 2023 19:17:29 -0800 you wrote:
> Currently when a bpf program intends to allocate memory for percpu kptr,
> the verifier will call bpf_mem_alloc_init() to prefill all supported
> unit sizes and this caused memory consumption very big for large number
> of cpus. For example, for 128-cpu system, the total memory consumption
> with initial prefill is ~175MB. Things will become worse for systems
> with even more cpus.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/8] bpf: Avoid unnecessary extra percpu memory allocation
    https://git.kernel.org/bpf/bpf-next/c/9beda16c257d
  - [bpf-next,v6,2/8] bpf: Add objcg to bpf_mem_alloc
    https://git.kernel.org/bpf/bpf-next/c/9fc8e802048a
  - [bpf-next,v6,3/8] bpf: Allow per unit prefill for non-fix-size percpu memory allocator
    https://git.kernel.org/bpf/bpf-next/c/c39aa3b289e9
  - [bpf-next,v6,4/8] bpf: Refill only one percpu element in memalloc
    https://git.kernel.org/bpf/bpf-next/c/5b95e638f134
  - [bpf-next,v6,5/8] bpf: Use smaller low/high marks for percpu allocation
    https://git.kernel.org/bpf/bpf-next/c/0e2ba9f96f9b
  - [bpf-next,v6,6/8] bpf: Limit up to 512 bytes for bpf_global_percpu_ma allocation
    https://git.kernel.org/bpf/bpf-next/c/5c1a37653260
  - [bpf-next,v6,7/8] selftests/bpf: Cope with 512 bytes limit with bpf_global_percpu_ma
    https://git.kernel.org/bpf/bpf-next/c/21f5a801c171
  - [bpf-next,v6,8/8] selftests/bpf: Add a selftest with > 512-byte percpu allocation size
    https://git.kernel.org/bpf/bpf-next/c/adc8c4549d9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



