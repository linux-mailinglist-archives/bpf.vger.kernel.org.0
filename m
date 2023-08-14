Return-Path: <bpf+bounces-7736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B3477BE5D
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 18:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE6E280D60
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 16:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9148CC2D9;
	Mon, 14 Aug 2023 16:50:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5835FC137
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 16:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1D57C433C8;
	Mon, 14 Aug 2023 16:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692031821;
	bh=gSw/rfK9rDCtWo7WJkWyrukDQU0jwq/A2F5w8MfrBus=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O9McTadFqOMin6HMc6AShKjk8QWnWyoSYH7Cw+jVgrkCQxS4LhyRZI/Gtewddlkag
	 HqD3zUmESWc+BL9NiNCDDoZ/LqDDGZoezSK4B9cpzJnOuHtjfj7JX8+ZQ9jF4EaKkM
	 I52kUB4h4zXQQOT6GPhdHqSCmK0mdqnan1utbBa/JhaPnBK7R7Qu6K4In4LkE/l8sn
	 FXOOOgNGUJOP49CMUfq/7eto5vZCdsHLZabeMHA8p0sl0JiyD0s23bjtIVpuVG6h2p
	 U6retJlTW5cVxn3SQ9eKyGtezSp1P2arXo0gjECIOdlyXml/WueaI5OTfTJDpe7GcD
	 +TU6FyDfBoVEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A55F7E93B37;
	Mon, 14 Aug 2023 16:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [bpf-next] selftests/bpf: clean-up fmod_ret in bench_rename test
 script
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169203182167.3806.17645689182437041748.git-patchwork-notify@kernel.org>
Date: Mon, 14 Aug 2023 16:50:21 +0000
References: <20230814030727.3010390-1-zouyipeng@huawei.com>
In-Reply-To: <20230814030727.3010390-1-zouyipeng@huawei.com>
To: Yipeng Zou <zouyipeng@huawei.com>
Cc: ast@kernel.org, daniel@iogearbox.ne, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, toke@redhat.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 14 Aug 2023 11:07:27 +0800 you wrote:
> [root@localhost bpf]# ./benchs/run_bench_rename.sh
> base      :    0.819 ± 0.012M/s
> kprobe    :    0.538 ± 0.009M/s
> kretprobe :    0.503 ± 0.004M/s
> rawtp     :    0.779 ± 0.020M/s
> fentry    :    0.726 ± 0.007M/s
> fexit     :    0.691 ± 0.007M/s
> benchmark 'rename-fmodret' not found
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: clean-up fmod_ret in bench_rename test script
    https://git.kernel.org/bpf/bpf-next/c/83a89c4b6ae9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



