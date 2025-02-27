Return-Path: <bpf+bounces-52781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9172FA486FF
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 18:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A8E165CDB
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 17:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97571E5212;
	Thu, 27 Feb 2025 17:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeNMVd+9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ED61D5CD3
	for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 17:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740678603; cv=none; b=iRMMmPKGb+rIiR6ckmVSjC3WRNX31NHoFD+JNgcbzmde+8g63joy5kY2yQ6RB/eftr+8gOJKWt+sN6cUXL8CRYP5jbGkDbFZ4t8js4dxqXXnhpcPQOlUYQNygZms4R09547lKNDgVGuI7FbVVhr1lDdgSUs8MBlatkC5qOVoRls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740678603; c=relaxed/simple;
	bh=na1DJ8Ftd5eHMfGJYg4H+E5P0y2Min93BjeyjeuCfnY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i/5+PU7b72bwIQ0JfLSSak5ZD8wIH0EaZUCnp7vWfn0S1UP+3KbezH12VLEunNIM8q3YFnTBFNmeu7DwM1Kyou3XUiRl3jOOj5g9vTvbFzE33k/F628fqZdgTTWxXnZ1T5CPCJ77+6utrxyDef+AqjXRc/+UXzngthd1HhlaKnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeNMVd+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9A7C4CEDD;
	Thu, 27 Feb 2025 17:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740678602;
	bh=na1DJ8Ftd5eHMfGJYg4H+E5P0y2Min93BjeyjeuCfnY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HeNMVd+9unngOfy6NMzLavx9iDA7B7pjgH1AkdsQaw+fJI1owojlv+z3FnB2sS5Fi
	 1Yc5JTjqCgQcR4cluInRphaXz01771GpQRc9NWqJj07O57v3GxE4tWNRRxYqxknRit
	 4paL/kWWiri5/GrRkAEhfsFtABryxptLT3Qvs9IHYMNhGyEE+7c/drxVpFUnZyzDBZ
	 Q6rv+PM58/jtv9SeoCUmsRzXA8H1MnkUwwPgA+a7UG0G7OjF9wd6tsymZ/eSX+VY7n
	 HmXHmhc+ac2FlMGDXUODSZz7btqTnSsPqGG2jXULVQfRmeC/W8A7k6X+CQV7K0//0q
	 SOV5VlsHR5Xog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF7F380AACB;
	Thu, 27 Feb 2025 17:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v9 0/6] bpf, mm: Introduce try_alloc_pages()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174067863450.1511239.16498641683130418968.git-patchwork-notify@kernel.org>
Date: Thu, 27 Feb 2025 17:50:34 +0000
References: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, memxor@gmail.com,
 akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz,
 bigeasy@linutronix.de, rostedt@goodmis.org, houtao1@huawei.com,
 hannes@cmpxchg.org, shakeel.butt@linux.dev, mhocko@suse.com,
 willy@infradead.org, tglx@linutronix.de, jannh@google.com, tj@kernel.org,
 linux-mm@kvack.org, kernel-team@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 21 Feb 2025 18:44:21 -0800 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Hi All,
> 
> The main motivation is to make alloc page and slab reentrant and
> remove bpf_mem_alloc.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v9,1/6] locking/local_lock: Introduce localtry_lock_t
    https://git.kernel.org/bpf/bpf-next/c/0aaddfb06882
  - [bpf-next,v9,2/6] mm, bpf: Introduce try_alloc_pages() for opportunistic page allocation
    https://git.kernel.org/bpf/bpf-next/c/97769a53f117
  - [bpf-next,v9,3/6] mm, bpf: Introduce free_pages_nolock()
    https://git.kernel.org/bpf/bpf-next/c/8c57b687e833
  - [bpf-next,v9,4/6] memcg: Use trylock to access memcg stock_lock.
    https://git.kernel.org/bpf/bpf-next/c/01d37228d331
  - [bpf-next,v9,5/6] mm, bpf: Use memcg in try_alloc_pages().
    https://git.kernel.org/bpf/bpf-next/c/e8d78dbd0199
  - [bpf-next,v9,6/6] bpf: Use try_alloc_pages() to allocate pages for bpf needs.
    https://git.kernel.org/bpf/bpf-next/c/c9eb8102e21e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



