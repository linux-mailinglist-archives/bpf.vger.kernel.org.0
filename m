Return-Path: <bpf+bounces-21273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BFD84AD46
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 05:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61FF21C22B71
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 04:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF7674E01;
	Tue,  6 Feb 2024 04:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="if/30gBx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B0673199
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 04:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707192627; cv=none; b=aJVF7vPCKjfxWNhZf5glqwvY1de/AAuQcWl+4AlEwtngs2t4MqKOV1sVIGci5KWhVO+QX4k9CEp7RjDKi2IOD4Fu1anUdzYKpg2rHNa8iMo81vuBsAq1pPMY713waI+eqSsZxcMOklRmReC5iDSu75WTpgAlQTroNNzooCycaoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707192627; c=relaxed/simple;
	bh=77/Ga4nbbBTrxzxafVQjPTEzpScRCO2UEMhJXlC9PWY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g64wnmYQg3g1o5l9dZ1RdYkbNFojFMKjYOvyRDMobPe9DBH06ixNX6Zp/0TSMd8qj/NdS8G3IhT/iPuSejwYsM/DyGTlhzsep9UP66LkgCu+uOlQpm1ZZWl9Dl83oc3VlXrNq8kGoqENCund/ohK0+M23HlEGjqslDCusO92zKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=if/30gBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66BE4C43390;
	Tue,  6 Feb 2024 04:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707192626;
	bh=77/Ga4nbbBTrxzxafVQjPTEzpScRCO2UEMhJXlC9PWY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=if/30gBxbRMzvl9sLfN8qxY/Azh7eDlrbSlDd7oihxIURgF6bs0JqMlPXODHALCPf
	 E14/A1gf3jBHrCxpqCut/3MthdT6JLkq6eukgQrnoWXfnJpVD+ga+U6SH0rq16f/7c
	 L6Pm7MLYtXvY/RGhaP93dQvKAhSiJl561tX2zR25z3P8ab+dKw2SrgsOTLKdzf+YWg
	 7t8CDGMucydC+OFcv2D4CMv6tVaVb+bwcoLhrPlciiFodSnwN5AO5VixHcYrUk5dn6
	 UvwxJcwaUUF0HEFdnIU7BBa+sT4mz5w5QuDYBOsBG6PVkxrSukyWI5WW2wJGmshxue
	 zRJV4b4j5Waag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C61EE2F2F9;
	Tue,  6 Feb 2024 04:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] Transfer RCU lock state across subprog calls
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170719262630.31872.2248639771567354367.git-patchwork-notify@kernel.org>
Date: Tue, 06 Feb 2024 04:10:26 +0000
References: <20240205055646.1112186-1-memxor@gmail.com>
In-Reply-To: <20240205055646.1112186-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, yonghong.song@linux.dev,
 laoar.shao@gmail.com, void@manifault.com, tj@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  5 Feb 2024 05:56:44 +0000 you wrote:
> David suggested during the discussion in [0] that we should handle RCU
> locks in a similar fashion to spin locks where the verifier understands
> when a lock held in a caller is released in callee, or lock taken in
> callee is released in a caller, or the callee is called within a lock
> critical section. This set extends the same semantics to RCU read locks
> and adds a few selftests to verify correct behavior. This issue has also
> come up for sched-ext programs.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Transfer RCU lock state between subprog calls
    https://git.kernel.org/bpf/bpf-next/c/6fceea0fa59f
  - [bpf-next,v2,2/2] selftests/bpf: Add tests for RCU lock transfer between subprogs
    https://git.kernel.org/bpf/bpf-next/c/8be6a0147af3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



