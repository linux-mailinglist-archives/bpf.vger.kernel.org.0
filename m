Return-Path: <bpf+bounces-11163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E39A7B4252
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 18:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id A31121C20AAE
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 16:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA4EFBEB;
	Sat, 30 Sep 2023 16:50:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2173C8833
	for <bpf@vger.kernel.org>; Sat, 30 Sep 2023 16:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C749C433C8;
	Sat, 30 Sep 2023 16:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696092623;
	bh=8kFeWR9tN0wXbiZ7gmvgulHRZmixVTMMN+a+x62JpFA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ArZt8wI7dgiRUmlKlSjiMZ1P9rFUyL7/BIqPLz9V+vBA/su5M+nSq1ATcJAzuC6N7
	 qoiFXMdvoZmuBbVbuLRF82kqDMe1NW+1ZosoC//lL1nBZDOzxIj11ITYeBHxmLu1fv
	 NorefkTyUdrqAfnR+UtlgDZn0YJedM2guiKedX0i7mSNvBAm9iSbYaJbs6kjZwWXOY
	 pZxO5lgpAnNpdvJer0qBtFJ+PearEyLBtSrACc6fJhNOdiV4Sua2T5NSIcPg3kBaBW
	 7DwGPYxN5gnXvjeno6hzZxr1qyfMSWpsTQevn2O/21OVRXfscVrDyag8oiL4UIZLyu
	 tYd92/VkzEKmw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4EFE4C395E0;
	Sat, 30 Sep 2023 16:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Use kmalloc_size_roundup() to adjust size_index
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169609262331.12178.12297662355991391436.git-patchwork-notify@kernel.org>
Date: Sat, 30 Sep 2023 16:50:23 +0000
References: <20230928101558.2594068-1-houtao@huaweicloud.com>
In-Reply-To: <20230928101558.2594068-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, song@kernel.org, haoluo@google.com,
 yonghong.song@linux.dev, daniel@iogearbox.net, kpsingh@kernel.org,
 sdf@google.com, jolsa@kernel.org, john.fastabend@gmail.com,
 nathan@kernel.org, linux@roeck-us.net, houtao1@huawei.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 28 Sep 2023 18:15:58 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Commit d52b59315bf5 ("bpf: Adjust size_index according to the value of
> KMALLOC_MIN_SIZE") uses KMALLOC_MIN_SIZE to adjust size_index, but as
> reported by Nathan, the adjustment is not enough, because
> __kmalloc_minalign() also decides the minimal alignment of slab object
> as shown in new_kmalloc_cache() and its value may be greater than
> KMALLOC_MIN_SIZE (e.g., 64 bytes vs 8 bytes under a riscv QEMU VM).
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Use kmalloc_size_roundup() to adjust size_index
    https://git.kernel.org/bpf/bpf/c/9077fc228f09

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



