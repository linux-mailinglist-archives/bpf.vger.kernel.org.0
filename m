Return-Path: <bpf+bounces-41300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEA099595C
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 23:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 326DC1C217B3
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 21:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED147215024;
	Tue,  8 Oct 2024 21:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNkmhdfN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7051C2C859
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 21:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728423625; cv=none; b=QBBxCcZeUi7/e7vJzNQL/U9ZMdcVHsrqccP9/lYjqFRR6SMSGq0/vZLRt1gCqsHvkdXth5BF1ErrMPit41Ljn3wdV+BDWyQ7mG6u8VFMGWJIgWAUbX7av+aYlBrxy981fEjVTpSWaawdQIxhMYDQX6YB2QukK2k8qU47jyvygQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728423625; c=relaxed/simple;
	bh=rDvIkzC2xEB1eYc7evIFTFVMlMPRrWpaBz1xbXl1xMs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Srw9d1bhDCRhC8HjoRpfZV8GBxl9etEHc9XXRi+2GA/8GPV92Az7WePNSnJcPQXLLaVIsV7vCzGxKyPabc4PUeANucztRLA8fayKjvClKqN8HMo0eaL1eeGKSSyThuWFVGu6fzgc52JAfjlwYqKNi8GWXaDsi+HnOD2g+Ri9abE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNkmhdfN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25F6C4CEC7;
	Tue,  8 Oct 2024 21:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728423625;
	bh=rDvIkzC2xEB1eYc7evIFTFVMlMPRrWpaBz1xbXl1xMs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DNkmhdfNSlpy8HibP22WjPqTOkWpwc/bgrrqGO9CtjQwAwsBSCRVwKC2m1hjXZkec
	 5qDTVvh8KxMVWOfyoa+6FMtpvilYJ+n22C3fee85UHXQqv/FcMUV6YdfG2v5oLkAnh
	 d/4NUWzA8/PxVp1FRiupBa0Lpjtk8XAaPob4r9mmId7t0bBEGwSL/3pdg4ZaZWd038
	 C+yPNSYqtogkeGhrPqne4GFzfRrTP5uccH2JPY1NOFpyLYLfuWgREQKINFWqSlkqst
	 V7jb60l9YzdVrAUVVj+rfReGycI35X+4S8MyhLsrugdf5ltXssaZaTXs+OzWbi4T90
	 QLCCVtMA3K2MA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D833A8D14D;
	Tue,  8 Oct 2024 21:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add get_netns_cookie helper to tc
 programs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172842362925.691687.14974948057337128688.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 21:40:29 +0000
References: <20241007095958.97442-1-mahe.tardy@gmail.com>
In-Reply-To: <20241007095958.97442-1-mahe.tardy@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net,
 john.fastabend@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon,  7 Oct 2024 09:59:57 +0000 you wrote:
> This is needed in the context of Cilium and Tetragon to retrieve netns
> cookie from hostns when traffic leaves Pod, so that we can correlate
> skb->sk's netns cookie.
> 
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>  net/core/filter.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf: add get_netns_cookie helper to tc programs
    https://git.kernel.org/bpf/bpf-next/c/eb62f49de7ec
  - [bpf-next,v3,2/2] selftests/bpf: add tcx netns cookie tests
    https://git.kernel.org/bpf/bpf-next/c/693fe954d61d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



