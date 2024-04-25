Return-Path: <bpf+bounces-27861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F171A8B2CE7
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 00:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC32D28276D
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 22:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D709159594;
	Thu, 25 Apr 2024 22:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pj5Bbyc4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EB715664A
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 22:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714083028; cv=none; b=t6tzDJ1sYOz8OxwMbajFI25u2GC70ZtPl/Q+bTTTzP7FahmXVWyErO45MDesJdZwBGPjR74Io+CcK0tym5pZqecvpNBfbDWW7+8fq/W5xPe1lJGy3C3aLD15uMVI5CCmco8xPbgCC+Hv2/PTx5fsa5Gdn0viedY3DBpB3q79ebA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714083028; c=relaxed/simple;
	bh=S+heU3OiEfAbvboymM+i61rI21k0ub9vpjqJ5ebp75k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N+tGzoWiYOglVllkVk1srfeLILFfhpEQUWW0yyOaIWfZRrwBluE68x8Onu04PmQaFwpP61OdcTOyFCR9AK97+KrL5U118hZsiiv2hrazrjGFOvpArkk77Ja4tuvPDXSDFaDSe79WG6vcgcSN5KbVXIostFdm4qKYaG3Apq8bFiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pj5Bbyc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 248E5C113CE;
	Thu, 25 Apr 2024 22:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714083028;
	bh=S+heU3OiEfAbvboymM+i61rI21k0ub9vpjqJ5ebp75k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Pj5Bbyc45Vt2FO2hqqK3NHh8jTod4W67K0fqaFggIkZ/e7JYVD2/B/5B1cwA9gCN4
	 aSr7DEr26aLFt/whhRDRkF6o3PbCGRkAAaHMcE+NqSx7ing6CltBYq32qmEILPiVCF
	 DJymMUWTQPx3Izxu1UlCLKDOjAS9Klq8iebqh4r0u9hWyc+ftdr0l4WkPGnItZyYD2
	 qD9b6eFIuLZYNQs5oytCelOPIxd8HX7D44P7F5SDf8QIxbuIuK79za4TIgXrypzOH3
	 xr90DsxdHPdEoafb+ZgRCMO8g+CmZH8PdysLPO5CcVQXcyLVQEMe4trbnxK4KTKhK5
	 T1/Hh4I+vp88w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 10847C595C5;
	Thu, 25 Apr 2024 22:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 0/2] bpf: add mrtt and srtt as ctx->args for
 BPF_SOCK_OPS_RTT_CB
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171408302806.13115.6832853231734043370.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 22:10:28 +0000
References: <20240425161724.73707-1-lulie@linux.alibaba.com>
In-Reply-To: <20240425161724.73707-1-lulie@linux.alibaba.com>
To: Philo Lu <lulie@linux.alibaba.com>
Cc: bpf@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, dsahern@kernel.org,
 mykolal@fb.com, shuah@kernel.org, laoar.shao@gmail.com,
 fred.cc@alibaba-inc.com, xuanzhuo@linux.alibaba.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri, 26 Apr 2024 00:17:22 +0800 you wrote:
> These provides more information about tcp RTT estimation. The selftest for
> BPF_SOCK_OPS_RTT_CB is extended for the added args.
> 
> changelogs
> -> v1:
> - extend rtt selftest for added args (suggested by Stanislav)
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/2] bpf: add mrtt and srtt as BPF_SOCK_OPS_RTT_CB args
    https://git.kernel.org/bpf/bpf-next/c/48e2cd3e3dcf
  - [bpf-next,v1,2/2] selftests/bpf: extend BPF_SOCK_OPS_RTT_CB test for srtt and mrtt_us
    https://git.kernel.org/bpf/bpf-next/c/7eb4f66b3806

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



