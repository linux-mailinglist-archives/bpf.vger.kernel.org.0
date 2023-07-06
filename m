Return-Path: <bpf+bounces-4302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CD974A4FF
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 22:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10F4E1C20E40
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 20:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7ED0BA58;
	Thu,  6 Jul 2023 20:40:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0177363BA
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 20:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48FB9C433C9;
	Thu,  6 Jul 2023 20:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688676022;
	bh=jiZveLdsRXu7MtFOUkz+bjkjSUCOQoIT0Dh2OQ5wKn0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jf0im7xD1iBLakBOS/veqRUIQA6qA3IP5lNsUrhK5yndeOfd+0/LhcizLIlzGkScL
	 +JzbLusGk7rz36zs38HBIQJadhYOI2vcQDvziR7jVR1EfzUHlgY5iwgl49c4NvwT8B
	 8TZlYKC5q/gokX+HKP32XgGXloTUQ01eG1VNUNd7YFQdnV35u/nXhk0CtYU9/lQO+p
	 UN6pbtj+edoR5HR5MTBGlNag5TNl0NlFd1naikXMZHWIakai4cR84GHPEAhbfP2ttm
	 s4hW01FRUjA4A2iB6Ffr+YRut9Sp2WAzxZqdr5gJUJpgCO0ttcyPNeI3Lu31rYErnf
	 P/pNeTiPKDfNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 302A3E5381B;
	Thu,  6 Jul 2023 20:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 bpf-next 0/5] bpf: add percpu stats for bpf_map
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168867602219.32181.840554357942598327.git-patchwork-notify@kernel.org>
Date: Thu, 06 Jul 2023 20:40:22 +0000
References: <20230706133932.45883-1-aspsk@isovalent.com>
In-Reply-To: <20230706133932.45883-1-aspsk@isovalent.com>
To: Anton Protopopov <aspsk@isovalent.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 houtao1@huawei.com, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  6 Jul 2023 13:39:27 +0000 you wrote:
> This series adds a mechanism for maps to populate per-cpu counters on
> insertions/deletions. The sum of these counters can be accessed by a new kfunc
> from map iterator and tracing programs.
> 
> The following patches are present in the series:
> 
>   * Patch 1 adds a generic per-cpu counter to struct bpf_map
>   * Patch 2 adds a new kfunc to access the sum of per-cpu counters
>   * Patch 3 utilizes this mechanism for hash-based maps
>   * Patch 4 extends the preloaded map iterator to dump the sum
>   * Patch 5 adds a self-test for the change
> 
> [...]

Here is the summary with links:
  - [v5,bpf-next,1/5] bpf: add percpu stats for bpf_map elements insertions/deletions
    https://git.kernel.org/bpf/bpf-next/c/25954730461a
  - [v5,bpf-next,2/5] bpf: add a new kfunc to return current bpf_map elements count
    https://git.kernel.org/bpf/bpf-next/c/803370d3d375
  - [v5,bpf-next,3/5] bpf: populate the per-cpu insertions/deletions counters for hashmaps
    https://git.kernel.org/bpf/bpf-next/c/9bc421b6be95
  - [v5,bpf-next,4/5] bpf: make preloaded map iterators to display map elements count
    https://git.kernel.org/bpf/bpf-next/c/515ee52b2224
  - [v5,bpf-next,5/5] selftests/bpf: test map percpu stats
    https://git.kernel.org/bpf/bpf-next/c/6c1b8cb6a70a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



