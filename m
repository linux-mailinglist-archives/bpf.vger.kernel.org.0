Return-Path: <bpf+bounces-9687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE1C79AB1C
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 21:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75195281263
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 19:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1DB15ADB;
	Mon, 11 Sep 2023 19:50:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE23315ACA
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 19:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32EA5C433C9;
	Mon, 11 Sep 2023 19:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694461829;
	bh=1Be3EsTrAUckTvzW4qpOlb8imJWBlDn9/6fluvZpCS8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MJYG2u52I2xI74jBKEadOo40dOBCx0QLUntHjDRRNA17K1/yBGlnnsqtUBAEkZwSx
	 dCNn6lSgNBcE8jP3UMG0zg4NaeUJlf9OKRLvGChA17Z8EL4L4aRAPRss1Ue9IdMMwL
	 ek2/4w4J/KrJZwg3TVgxQGLyQn4k0EBa5QWtCPvQFMPpcluFPv9acxlMLOp7sYJ8Z5
	 w0O4cjL6AV37kaidRr9kn8AU9mGnSUlmP3BR6f0JxJfvRHKv8Z5DTuh0fAe/6SF8H3
	 obkM3MHqA/Om1rbcLTKfKVSSt4X072hWSrexh8BAsz5VAo7Bk8kEjauS5DtuWSJ3zj
	 J9fE3hTsKuMlw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 171A9C00446;
	Mon, 11 Sep 2023 19:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 0/4] Fix the unmatched unit_size of bpf_mem_cache
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169446182908.10545.14547502551008272952.git-patchwork-notify@kernel.org>
Date: Mon, 11 Sep 2023 19:50:29 +0000
References: <20230908133923.2675053-1-houtao@huaweicloud.com>
In-Reply-To: <20230908133923.2675053-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, song@kernel.org, haoluo@google.com,
 yonghong.song@linux.dev, daniel@iogearbox.net, kpsingh@kernel.org,
 sdf@google.com, jolsa@kernel.org, john.fastabend@gmail.com, bjorn@kernel.org,
 houtao1@huawei.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  8 Sep 2023 21:39:19 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The patchset aims to fix the reported warning [0] when the unit_size of
> bpf_mem_cache is mismatched with the object size of underly slab-cache.
> 
> [...]

Here is the summary with links:
  - [bpf,1/4] bpf: Adjust size_index according to the value of KMALLOC_MIN_SIZE
    https://git.kernel.org/bpf/bpf/c/d52b59315bf5
  - [bpf,2/4] bpf: Don't prefill for unused bpf_mem_cache
    https://git.kernel.org/bpf/bpf/c/b1d53958b693
  - [bpf,3/4] bpf: Ensure unit_size is matched with slab cache object size
    https://git.kernel.org/bpf/bpf/c/c93047255202
  - [bpf,4/4] selftests/bpf: Test all valid alloc sizes for bpf mem allocator
    https://git.kernel.org/bpf/bpf/c/f0a42ab5890f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



