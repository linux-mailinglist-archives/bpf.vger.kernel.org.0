Return-Path: <bpf+bounces-47951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA9BA02787
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 15:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98C7618816A8
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 14:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BF71DE2B9;
	Mon,  6 Jan 2025 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XA/ZDI2Y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261BE1DD9AD;
	Mon,  6 Jan 2025 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736172610; cv=none; b=hpNWKNT9BLM1SdvXlxDwBVS184YsDoaMpi7uGKj22bxDXyKuQhLe781QEfDN5m+JMJOjqvxaxt6yUk52SnrN3dX6kkQ1CZgXqnvIhitnlNyLjSK4tuG7VuYt/z87FoMRz5tta5egMu5k04GRacC9Dg5XQtSTnwsBryRYybkJwzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736172610; c=relaxed/simple;
	bh=ZI27VG+PTiKbmKRk+qcAFfPCmvXLU/mtbGlmoa/U3g0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jmfreclhGImkZ6jo067aTtEGzTJqiS4MqlQK/wRvL/TnH1nIX+QhAk30HhWF34Tpa42KbizZepRwcjw4lurbyyRChs68Pbd6FjqOLS2HhAxbqNrReD/ZvPitkW/2u9YZg1SKbo3UTlgyaxFLhZ3qzFMrkWWAGB/9JIoNx7E+y1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XA/ZDI2Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB85C4CED2;
	Mon,  6 Jan 2025 14:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736172609;
	bh=ZI27VG+PTiKbmKRk+qcAFfPCmvXLU/mtbGlmoa/U3g0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XA/ZDI2YWTsAzj+sAzm1pMaWvJhyVdksEldPXpdJqS+8cpfdO++U6uZ4GI5nFolR9
	 XCPANZu5744nulR4EXArT4MdF+4ZdmLsaxNR2csLDH13Kp+a/36NmuVuR6NIs7cG2V
	 9qmwkG5SW+sAJyNk+rtYh6S91fWcdc2zI4KPswmUCpr9yG4NrU4K476U2rr/KSkpqs
	 lS2ptbr2Q5eycVgokkgu3nXWuPTdHIKmy97DP1OYyau8zIqzTkqdh8UyMk76ruCHWr
	 6MGoVZbp1R1CIJ9oCf6ljzDfpSMdH84rxCU7jy1afLiT4o6T5qwWeO7ir/Luo+EZ74
	 UQ2VBmcKc8Ojg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF7D380A97D;
	Mon,  6 Jan 2025 14:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: avoid generating untracked files
 when running bpf selftests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173617263051.3505180.15711457709343352794.git-patchwork-notify@kernel.org>
Date: Mon, 06 Jan 2025 14:10:30 +0000
References: <20241224075957.288018-1-mrpre@163.com>
In-Reply-To: <20241224075957.288018-1-mrpre@163.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, ast@kernel.org,
 edumazet@google.com, jakub@cloudflare.com, davem@davemloft.net,
 dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, song@kernel.org, john.fastabend@gmail.com,
 andrii@kernel.org, mhal@rbox.co, yonghong.song@linux.dev,
 daniel@iogearbox.net, xiyou.wangcong@gmail.com, horms@kernel.org,
 eddyz87@gmail.com, mykolal@fb.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, pulehui@huawei.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 24 Dec 2024 15:59:57 +0800 you wrote:
> Currently, when we run the BPF selftests with the following command:
> 'make -C tools/testing/selftests TARGETS=bpf SKIP_TARGETS=""'
> 
> The command generates untracked files and directories with make version
> less than 4.4:
> '''
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
> 	tools/testing/selftests/bpfFEATURE-DUMP.selftests
> 	tools/testing/selftests/bpffeature/
> '''
> We lost slash after word "bpf".
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: avoid generating untracked files when running bpf selftests
    https://git.kernel.org/bpf/bpf-next/c/73b9075f334f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



