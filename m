Return-Path: <bpf+bounces-16690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A739D804479
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 03:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3F04B20BE9
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 02:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7B63D7F;
	Tue,  5 Dec 2023 02:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBaXPANA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684C71C15
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 02:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28776C433CA;
	Tue,  5 Dec 2023 02:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701742099;
	bh=Jm/B+Od7jQDtUTIKrNOSTUZV3iOkK4hPjU8Hpu1uh14=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MBaXPANAEAKW+hkEKn1xJaJEVZq4OAW2uCvLGZAkx6lGucj68KRKTGWvAGdvClLH2
	 uXAQs1Hc7YAK94mipgLUe0HyJAKV6Cf8NtMmeC01WN/HahERrLynbtyagv4a53s9Qx
	 EnhUgRHLk65PkCuGLsoadIkphQtd7/lcSY5YlB7N71F5NVyuR/3AT8klpHAm/d0K5z
	 EVOvsEobqtVOq15tVyDWJOfGFiTgAl5KhY0JvgJLzXv/g3/64BZm0fjFSryqecZsD8
	 vP56+eoI6nE58T0TWhz+Iu1+yvuRt0SRorGBz8ZXiF0Gr7tF7ODy/1IgrSQKPMJ55y
	 yQPpDzzDt2oYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0CDFBDD4EF1;
	Tue,  5 Dec 2023 02:08:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v5 0/7] bpf: Fix the release of inner map
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170174209904.18867.7610457582102890894.git-patchwork-notify@kernel.org>
Date: Tue, 05 Dec 2023 02:08:19 +0000
References: <20231204140425.1480317-1-houtao@huaweicloud.com>
In-Reply-To: <20231204140425.1480317-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, song@kernel.org, haoluo@google.com,
 yonghong.song@linux.dev, daniel@iogearbox.net, kpsingh@kernel.org,
 sdf@google.com, jolsa@kernel.org, john.fastabend@gmail.com,
 paulmck@kernel.org, houtao1@huawei.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  4 Dec 2023 22:04:18 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The patchset aims to fix the release of inner map in map array or map
> htab. The release of inner map is different with normal map. For normal
> map, the map is released after the bpf program which uses the map is
> destroyed, because the bpf program tracks the used maps. However bpf
> program can not track the used inner map because these inner map may be
> updated or deleted dynamically, and for now the ref-counter of inner map
> is decreased after the inner map is remove from outer map, so the inner
> map may be freed before the bpf program, which is accessing the inner
> map, exits and there will be use-after-free problem as demonstrated by
> patch #6.
> 
> [...]

Here is the summary with links:
  - [bpf,v5,1/7] bpf: Check rcu_read_lock_trace_held() before calling bpf map helpers
    https://git.kernel.org/bpf/bpf-next/c/169410eba271
  - [bpf,v5,2/7] bpf: Add map and need_defer parameters to .map_fd_put_ptr()
    https://git.kernel.org/bpf/bpf-next/c/20c20bd11a07
  - [bpf,v5,3/7] bpf: Set need_defer as false when clearing fd array during map free
    https://git.kernel.org/bpf/bpf-next/c/79d93b3c6ffd
  - [bpf,v5,4/7] bpf: Defer the free of inner map when necessary
    https://git.kernel.org/bpf/bpf-next/c/876673364161
  - [bpf,v5,5/7] bpf: Optimize the free of inner map
    https://git.kernel.org/bpf/bpf-next/c/af66bfd3c853
  - [bpf,v5,6/7] selftests/bpf: Add test cases for inner map
    https://git.kernel.org/bpf/bpf-next/c/1624918be84a
  - [bpf,v5,7/7] selftests/bpf: Test outer map update operations in syscall program
    https://git.kernel.org/bpf/bpf-next/c/e3dd40828534

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



