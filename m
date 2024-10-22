Return-Path: <bpf+bounces-42825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6309AB79F
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 22:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 384E6B22B93
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 20:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F01B1CBE96;
	Tue, 22 Oct 2024 20:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZyGymE9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E836C1442E8
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 20:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729629025; cv=none; b=fq/jEo9UA6mAwb9iQ2c3YNprNexEOTJ4ma52c02jJvI8ZngSO5rDsIqEut69a+atbJbwQecweHtIwt6SZ8OPKhf1eQ20LsplJPhQFACkKo4TD5OqeAw338f5kxx12aCddlP5fbgllG8f9Au9MtOe/rDdCWkYjL5ea3iesmgdRo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729629025; c=relaxed/simple;
	bh=Oyv+y/tlY97sa/IMpOYUXIoW9andh4hC32XPdFhIqIQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bAjx3KgY3Jn/273V1+vS1DfRie1SnoQaI0d/lFTVVwoHJ2xg37ZdbMQSN03svCVHafx1jRXgI3CuyIDf26SYeCWIHZ7jE2OxxaZ1yp68lMDBHqBoPx1KG9NrsdndhAZY+O4MAw7SXRCdaTS+2K784OLR/YRFWnvGTVG6XiyPvbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZyGymE9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7434BC4CEC3;
	Tue, 22 Oct 2024 20:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729629024;
	bh=Oyv+y/tlY97sa/IMpOYUXIoW9andh4hC32XPdFhIqIQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WZyGymE9aFei2FyvkyZsQr3ax0i+c9t8bP1mmn8MUDezvXeBHgSRYDUNquwDRqYyv
	 4ySLDoLqR/j2dLaxtOg42dYZyWvqg4Cffn4Jn9OT8/VdzqQ13L376seobO0e7Gmybi
	 CVRUWofjKDay7Y5U21BSIxH+XF4wOm3k6MXYzhId+adv2755tBjT3CV0T2fxw51Yft
	 +U5JEy9aLSQ9NyjRd8EL8s6Ts++/QOTMFTSphVJnfUKYP51Lii5sNqGXbJaJb95ths
	 vNzqHMVXMzSnx7PwiWUTwnHWf9YvfH5/kaJBT2eMaH+A1tqNEgXo5R4CeUFqhnOAXI
	 Qh/MDq12/n+TA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0093822D22;
	Tue, 22 Oct 2024 20:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3] bpf: Preserve param->string when parsing mount options
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172962903076.1073819.3858873207115875825.git-patchwork-notify@kernel.org>
Date: Tue, 22 Oct 2024 20:30:30 +0000
References: <20241022130133.3798232-1-houtao@huaweicloud.com>
In-Reply-To: <20241022130133.3798232-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, haoluo@google.com,
 yonghong.song@linux.dev, daniel@iogearbox.net, kpsingh@kernel.org,
 sdf@fomichev.me, jolsa@kernel.org, john.fastabend@gmail.com,
 houtao1@huawei.com, xukuohai@huawei.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 22 Oct 2024 21:01:33 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> In bpf_parse_param(), keep the value of param->string intact so it can
> be freed later. Otherwise, the kmalloc area pointed to by param->string
> will be leaked as shown below:
> 
> unreferenced object 0xffff888118c46d20 (size 8):
>   comm "new_name", pid 12109, jiffies 4295580214
>   hex dump (first 8 bytes):
>     61 6e 79 00 38 c9 5c 7e                          any.8.\~
>   backtrace (crc e1b7f876):
>     [<00000000c6848ac7>] kmemleak_alloc+0x4b/0x80
>     [<00000000de9f7d00>] __kmalloc_node_track_caller_noprof+0x36e/0x4a0
>     [<000000003e29b886>] memdup_user+0x32/0xa0
>     [<0000000007248326>] strndup_user+0x46/0x60
>     [<0000000035b3dd29>] __x64_sys_fsconfig+0x368/0x3d0
>     [<0000000018657927>] x64_sys_call+0xff/0x9f0
>     [<00000000c0cabc95>] do_syscall_64+0x3b/0xc0
>     [<000000002f331597>] entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> [...]

Here is the summary with links:
  - [bpf,v3] bpf: Preserve param->string when parsing mount options
    https://git.kernel.org/bpf/bpf/c/1f97c03f43fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



