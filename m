Return-Path: <bpf+bounces-19398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B81BA82B994
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 03:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04022B26C1A
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 02:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F400915B9;
	Fri, 12 Jan 2024 02:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkj/1/pG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8457713AF4
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 02:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E49C4C43601;
	Fri, 12 Jan 2024 02:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705026628;
	bh=R1eBQnlC7rtxk/uehT4NT7gAnSSB7Sjfkw7hsW/toGY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gkj/1/pGES+CcgJ+Ooj8BW5lJgYTCt5WMl/9Epn/6UyHdIScEUr7A7KUzvGryJU6Z
	 WcNkNWGMAiLVaGFiwsLnmNfV2aG06eUr9hnm/HtwJyszlYNYGp+V+dno1RHUoT6wOl
	 4E4UNiy33vHg/MVhVnDVejwFRuutwCF74r2ZFbcuKraMuNRO27SBvfqJsNzrAFq8XH
	 cQ2HLM5FyzOg8Y/kG7cCcGSNLMEkkbOt0iZ/oYA1MLiIg0UaKwbWcM6AN3FRDhV7O3
	 K55q7YjgWZBoqUQ6pHagX/59atuX9jvMcTd1YCE2iGeBScwlErIWGjfv3Mko7rzUON
	 ymmsKqAZ1f1YA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD449D8C96E;
	Fri, 12 Jan 2024 02:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/3] bpf: inline bpf_kptr_xchg()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170502662783.8539.15888768654431912677.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jan 2024 02:30:27 +0000
References: <20240105104819.3916743-1-houtao@huaweicloud.com>
In-Reply-To: <20240105104819.3916743-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, song@kernel.org, haoluo@google.com,
 yonghong.song@linux.dev, daniel@iogearbox.net, kpsingh@kernel.org,
 sdf@google.com, jolsa@kernel.org, john.fastabend@gmail.com,
 eddyz87@gmail.com, houtao1@huawei.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  5 Jan 2024 18:48:16 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The motivation of inlining bpf_kptr_xchg() comes from the performance
> profiling of bpf memory allocator benchmark [1]. The benchmark uses
> bpf_kptr_xchg() to stash the allocated objects and to pop the stashed
> objects for free. After inling bpf_kptr_xchg(), the performance for
> object free on 8-CPUs VM increases about 2%~10%. However the performance
> gain comes with costs: both the kasan and kcsan checks on the pointer
> will be unavailable. Initially the inline is implemented in do_jit() for
> x86-64 directly, but I think it will more portable to implement the
> inline in verifier.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/3] bpf: Support inlining bpf_kptr_xchg() helper
    https://git.kernel.org/bpf/bpf-next/c/ac780beba187
  - [bpf-next,v3,2/3] selftests/bpf: Factor out get_xlated_program() helper
    https://git.kernel.org/bpf/bpf-next/c/10cdab919df6
  - [bpf-next,v3,3/3] selftests/bpf: Test the inlining of bpf_kptr_xchg()
    https://git.kernel.org/bpf/bpf-next/c/ca8cf57c7754

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



