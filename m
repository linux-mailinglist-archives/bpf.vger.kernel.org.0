Return-Path: <bpf+bounces-38220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAB4961A64
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 01:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68B881F21BE4
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 23:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB951D45EB;
	Tue, 27 Aug 2024 23:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVpv5ToD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FB1770F1;
	Tue, 27 Aug 2024 23:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724800828; cv=none; b=QTwr4NzlLEh4O7M7qffDf4OPjv+85nZfV9lTuQvn5OW0uBsJBcdV8dI0neu8PwTURHX7bKnFiDh7UDcer3j4auEDJ9Jxs4dmQqfpvuUIrTnH+BbY4pTsvCDtaFg+w+BQ8ehgMMnghKYD+OYBumpUXXqOeQhR3WOrbl8GH6nKSoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724800828; c=relaxed/simple;
	bh=n9eG3dqNrjcMWSZ8MtKYYEfFVvD6GvS6o1npsvN8ggY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DX/2IJal9SNlU0JXUiUZTmVwwBirr3hBY5W80TrDbilV+xJw8AfqBBg7cGCpLevNttEL7RBk9c3DeoryG87sTzmnjUWJxk6sqs/gc78EiuIw90R/IT6/W4XzH+QhFtm7e3gnE225V0k6Ru+1SIX2DZjv9SKD1uNKf7J0h8FU32o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVpv5ToD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255BBC4AF65;
	Tue, 27 Aug 2024 23:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724800828;
	bh=n9eG3dqNrjcMWSZ8MtKYYEfFVvD6GvS6o1npsvN8ggY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kVpv5ToDFHLRormH+VeWcesDGeaB7mS2793UW1DrNluwgdeyGAn+pMRf7UpkxBaSC
	 i/8SyzM4j4QxCRfBpUBfp02yZTmQHrWNkHLz6NBD5BF+TksYd5KDD+zx1DYF479Hac
	 D3ODe6CJNJIK/gSmRY/tYJlIt2WgVoZ6d7Z0KCk9KOCJe9QM3ZPQbKr3NNQRyhFD1I
	 jC2C3hxlxvt1z4CWzhaI34MORwwU9CUPTc0pC9FGN0JDgzUWtdJ4QCyTXlILcDUf3N
	 tidWrUCUep1ZGq/Sk5bNqqos0clXGKSkURsJZvmXAKu/0mgxnM/W2iXyVcqBBy28bB
	 RBEH/qx7weKgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C333822D6D;
	Tue, 27 Aug 2024 23:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] samples/bpf: tracex4: Fix failed to create kretprobe
 'kmem_cache_alloc_node+0x0'
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172480082826.787068.693535971609017102.git-patchwork-notify@kernel.org>
Date: Tue, 27 Aug 2024 23:20:28 +0000
References: <tencent_34E5BCCAC5ABF3E81222AD81B1D05F16DE06@qq.com>
In-Reply-To: <tencent_34E5BCCAC5ABF3E81222AD81B1D05F16DE06@qq.com>
To: Rong Tao <rtoax@foxmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, rongtao@cestc.cn, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 27 Aug 2024 12:30:30 +0800 you wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> commit 7bd230a26648 ("mm/slab: enable slab allocation tagging for kmalloc
> and friends") [1] swap kmem_cache_alloc_node() to
> kmem_cache_alloc_node_noprof().
> 
>     linux/samples/bpf$ sudo ./tracex4
>     libbpf: prog 'bpf_prog2': failed to create kretprobe
>     'kmem_cache_alloc_node+0x0' perf event: No such file or directory
>     ERROR: bpf_program__attach failed
> 
> [...]

Here is the summary with links:
  - [bpf-next] samples/bpf: tracex4: Fix failed to create kretprobe 'kmem_cache_alloc_node+0x0'
    https://git.kernel.org/bpf/bpf-next/c/d205d4af3a5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



