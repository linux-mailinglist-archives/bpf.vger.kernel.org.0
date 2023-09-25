Return-Path: <bpf+bounces-10821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C32367AE297
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 01:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id A682A1C203DF
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 23:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14997266B3;
	Mon, 25 Sep 2023 23:50:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41F5266A5
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 23:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1601CC433C9;
	Mon, 25 Sep 2023 23:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695685825;
	bh=pIpv6EWZc2C6mDA+WeCN2aYAf4byB8gyXs9QSOTWn2M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jOsYgMZSTm4fdVE3hXTTB9sylYIDKu1+q5KylPhi7rUJWT6k1t70dDbd0pFReUEQ0
	 E34IIBEq/BOkL2htLs7KWqHaPvV4R6S6dQSmAQ6tjoFK8w4VS3irIO8rmXbKtjVUIC
	 7jTemrwUvWylwG9w5imfT3sX5moj6hhMllJKJjgjeMTorYDzMxLTKMHvpw4vO6ENB9
	 ve+kKTQJJrYPIz1rvKjDVwjn2vDxDeUVtSZZGwt/CzkZVjmaHZzze5ahY1+GxAzAf/
	 La5I10TWLWCQebTDWJ3puAqeIk3rRz43sOcgoDFWw6IaB7dNXLaJFksDjg7NXciL0M
	 fgOLzWQdKtELg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE3D9E29B01;
	Mon, 25 Sep 2023 23:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv3 bpf-next 0/9] bpf: Add missed stats for kprobes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169568582496.5432.15287673565408770014.git-patchwork-notify@kernel.org>
Date: Mon, 25 Sep 2023 23:50:24 +0000
References: <20230920213145.1941596-1-jolsa@kernel.org>
In-Reply-To: <20230920213145.1941596-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
 haoluo@google.com, houtao1@huawei.com, dxu@dxuuu.xyz

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 20 Sep 2023 23:31:36 +0200 you wrote:
> hi,
> at the moment we can't retrieve the number of missed kprobe
> executions and subsequent execution of BPF programs.
> 
> This patchset adds:
>   - counting of missed execution on attach layer for:
>     . kprobes attached through perf link (kprobe/ftrace)
>     . kprobes attached through kprobe.multi link (fprobe)
>   - counting of recursion_misses for BPF kprobe programs
> 
> [...]

Here is the summary with links:
  - [PATCHv3,bpf-next,1/9] bpf: Count stats for kprobe_multi programs
    https://git.kernel.org/bpf/bpf-next/c/f915fcb38553
  - [PATCHv3,bpf-next,2/9] bpf: Add missed value to kprobe_multi link info
    https://git.kernel.org/bpf/bpf-next/c/e2b2cd592adb
  - [PATCHv3,bpf-next,3/9] bpf: Add missed value to kprobe perf link info
    https://git.kernel.org/bpf/bpf-next/c/3acf8ace6823
  - [PATCHv3,bpf-next,4/9] bpf: Count missed stats in trace_call_bpf
    https://git.kernel.org/bpf/bpf-next/c/dd8657894c11
  - [PATCHv3,bpf-next,5/9] bpftool: Display missed count for kprobe_multi link
    https://git.kernel.org/bpf/bpf-next/c/b24fc35521b0
  - [PATCHv3,bpf-next,6/9] bpftool: Display missed count for kprobe perf link
    https://git.kernel.org/bpf/bpf-next/c/b563b9bae8c3
  - [PATCHv3,bpf-next,7/9] selftests/bpf: Add test for missed counts of perf event link kprobe
    https://git.kernel.org/bpf/bpf-next/c/01e4ae474e39
  - [PATCHv3,bpf-next,8/9] selftests/bpf: Add test for recursion counts of perf event link kprobe
    https://git.kernel.org/bpf/bpf-next/c/59e83c0187c5
  - [PATCHv3,bpf-next,9/9] selftests/bpf: Add test for recursion counts of perf event link tracepoint
    https://git.kernel.org/bpf/bpf-next/c/85981e0f9e9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



