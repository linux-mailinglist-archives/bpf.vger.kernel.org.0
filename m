Return-Path: <bpf+bounces-16021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B24527FB016
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 03:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E463C1C20BE7
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 02:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFB75679;
	Tue, 28 Nov 2023 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zun06cJe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C913A101C1;
	Tue, 28 Nov 2023 02:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25B22C433C7;
	Tue, 28 Nov 2023 02:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701138626;
	bh=r8crOTWaWJVGmeWmi01DxTtqJ1RRSVd7emnIHX8ckak=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Zun06cJekM/LWUbxsvOKL68y7HlC9QyOYWwqKFVT0tQHk9FxAIh85ovWnhlFAx8tk
	 3KGxwjHRVMKv5ws/XNPm2WkD8ae9UHKnXpswuT0kQ4YDcPDDlskBdCDl8wn4KqYqso
	 5qM1m2i+mbhk9q8dl3ealNM/GSONv3DW9ezmeE5PRatEk9C+m++orb4l0R42vLJdyY
	 nYQC5bgb6FliG0WqABDnS191MVZh4XCzSf/1rtAnQJut1rOw+X0bzuRBuqBRITVUuk
	 8n9Q71kSqA+SDAeDvfrHlh6TmMHFr+QkV7+wF+LvYNqrGq7qCPWy4RzfTm1MRXhhJY
	 BsnD0L88lyfqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05525E11F68;
	Tue, 28 Nov 2023 02:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 1/2] bpftool: mark orphaned programs during prog
 show
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170113862601.1467.14103892622059549472.git-patchwork-notify@kernel.org>
Date: Tue, 28 Nov 2023 02:30:26 +0000
References: <20231127182057.1081138-1-sdf@google.com>
In-Reply-To: <20231127182057.1081138-1-sdf@google.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon, 27 Nov 2023 10:20:56 -0800 you wrote:
> Commit ef01f4e25c17 ("bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD
> and PERF_BPF_EVENT_PROG_UNLOAD") stopped removing program's id from
> idr when the offloaded/bound netdev goes away. I was supposed to
> take a look and check in [0], but apparently I did not.
> 
> Martin points out it might be useful to keep it that way for
> observability sake, but we at least need to mark those programs as
> unusable.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpftool: mark orphaned programs during prog show
    https://git.kernel.org/bpf/bpf-next/c/876843ce1e48
  - [bpf-next,v3,2/2] selftests/bpf: update test_offload to use new orphaned property
    https://git.kernel.org/bpf/bpf-next/c/cf9791631027

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



