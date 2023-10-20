Return-Path: <bpf+bounces-12850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAA97D14E4
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 19:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE85928265C
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 17:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416A720325;
	Fri, 20 Oct 2023 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohlO8zYW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BD820322
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 17:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24B13C433C9;
	Fri, 20 Oct 2023 17:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697823025;
	bh=5ut1L1541Y4ftwvkK1hGaiM6h4nfhAd+GjYGCoEpZZk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ohlO8zYWZHYxY3N6tuKOxLxZBC6cHJNqSParfmxNEgHP/wphEX2pAYPtqzzX+wyXd
	 uwd4U8n9mQYMVCF2sgp5IaERUF259btLix7VtKMvopDK6C+J4F7sfDi4ftL8HH/nYj
	 jWP52L46YN7ZoYdJ+AP3HvAS9Qq9S/T0KWPWqotXdu+qm0eeN57ZRe4ZWBWnnEKDqD
	 CXb0O+s3poxYhao58UrGj1fLY6vHdX3RIIaUcDjRa2R4LyNBWE+vB2EVbqNie47Q7x
	 fDGNnuBEoeFp5q1Es1YGcCLBhm+cQqT1mDOwq6cqPZQjFwm9RN8qT9W4cRN9tc14cU
	 ypVX+WF/RI+hQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0624EC595D7;
	Fri, 20 Oct 2023 17:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/7] bpf: Fixes for per-cpu kptr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169782302501.9988.4889931337296268116.git-patchwork-notify@kernel.org>
Date: Fri, 20 Oct 2023 17:30:25 +0000
References: <20231020133202.4043247-1-houtao@huaweicloud.com>
In-Reply-To: <20231020133202.4043247-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, martin.lau@linux.dev,
 alexei.starovoitov@gmail.com, andrii@kernel.org, song@kernel.org,
 haoluo@google.com, yonghong.song@linux.dev, daniel@iogearbox.net,
 kpsingh@kernel.org, sdf@google.com, jolsa@kernel.org,
 john.fastabend@gmail.com, houtao1@huawei.com, dennis@kernel.org,
 tj@kernel.org, cl@linux.com, akpm@linux-foundation.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 20 Oct 2023 21:31:55 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The patchset aims to fix the problems found in the review of per-cpu
> kptr patch-set [0]. Patch #1 moves pcpu_lock after the invocation of
> pcpu_chunk_addr_search() and it is a micro-optimization for
> free_percpu(). The reason includes it in the patch is that the same
> logic is used in newly-added API pcpu_alloc_size(). Patch #2 introduces
> pcpu_alloc_size() for dynamic per-cpu area. Patch #2 and #3 use
> pcpu_alloc_size() to check whether or not unit_size matches with the
> size of underlying per-cpu area and to select a matching bpf_mem_cache.
> Patch #4 fixes the freeing of per-cpu kptr when these kptrs are freed by
> map destruction. The last patch adds test cases for these problems.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/7] mm/percpu.c: don't acquire pcpu_lock for pcpu_chunk_addr_search()
    https://git.kernel.org/bpf/bpf-next/c/394e6869f018
  - [bpf-next,v3,2/7] mm/percpu.c: introduce pcpu_alloc_size()
    https://git.kernel.org/bpf/bpf-next/c/5897c912a66b
  - [bpf-next,v3,3/7] bpf: Re-enable unit_size checking for global per-cpu allocator
    https://git.kernel.org/bpf/bpf-next/c/fd496368ab75
  - [bpf-next,v3,4/7] bpf: Use pcpu_alloc_size() in bpf_mem_free{_rcu}()
    https://git.kernel.org/bpf/bpf-next/c/f6bbb0c00203
  - [bpf-next,v3,5/7] bpf: Move the declaration of __bpf_obj_drop_impl() to bpf.h
    https://git.kernel.org/bpf/bpf-next/c/c999470ea070
  - [bpf-next,v3,6/7] bpf: Use bpf_global_percpu_ma for per-cpu kptr in __bpf_obj_drop_impl()
    https://git.kernel.org/bpf/bpf-next/c/710701945f97
  - [bpf-next,v3,7/7] selftests/bpf: Add more test cases for bpf memory allocator
    https://git.kernel.org/bpf/bpf-next/c/30c44ceada16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



