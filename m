Return-Path: <bpf+bounces-70148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3170FBB1C7D
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 23:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5AEA1C5FBD
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 21:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85DC30C600;
	Wed,  1 Oct 2025 21:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbvI4qTa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562561EDA0E;
	Wed,  1 Oct 2025 21:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759353017; cv=none; b=XJmfw3ptVnKzz6LZP5L6nqiGrgdR6v3D+4U/bFCY92eu4v1S9wC9Y/LRKdX9j8gNjexeC96EUgWizNUlAvEsaC305tCUFgsJ0X/sy7pmpzt0uc9HbxCQVSGhs4ApX2wTZyppEH/hquuhMzcQRejcrmA0ZCyc62RKbWWOxcn1f5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759353017; c=relaxed/simple;
	bh=XPJvyyg2RsgOHg8XgAcCDjEsY62BQfjmmJQGuT90aNo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cj2t/BkPsG20KV2YFvUHxlpiNvOQOE0jaXqOi5FSr1TaGS0FQsTS4vgiH0sHUOJP2HQ36ypCB97dNSHJ/D2R3nnjJb5yxB3pq2gMrzTgfWlprDw0VJk50swO0vtytpSGMc/57a21vxECF+1tGaYGd7F06KR91lFRBaVwnRGHDnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbvI4qTa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB0DC4CEF1;
	Wed,  1 Oct 2025 21:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759353016;
	bh=XPJvyyg2RsgOHg8XgAcCDjEsY62BQfjmmJQGuT90aNo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UbvI4qTaJ7Jv51s3Ia7AVAscSvIv6/wt+E7JeNGLECacjjAmYUX12MLyNTbso5Dbg
	 BYAhOPCKdQ16dwYTvjFyEqyxbu5hLA29kqU7D336LEYBLFIIcbJ9+wGDbEVf5T/hKY
	 iZu3cPVqpHZHNbnIglmD8JtRqCWqS1+oXqvDdDabwnoCJSV8YmqleKM+t4f1/q1gJH
	 VGFOD/fC+mw0NqXf5lo4q/MZ9MCvQIiMPt0U+DTUaduw2fomti6fd8LWMAMQUJRqT/
	 0cAOyx0iE9k91+qVrkZvsXtMn0Py8nRKpaF3mb1cxUBw8Tt/lHF0N0fuQ15i77pDR1
	 TSRtQn/d0SVaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7146A39D0C3F;
	Wed,  1 Oct 2025 21:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/2] bpf: Fix verifier crash on BPF_NEG with pointer
 register
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175935300926.2619259.6844027797276527455.git-patchwork-notify@kernel.org>
Date: Wed, 01 Oct 2025 21:10:09 +0000
References: <20251001191739.2323644-1-listout@listout.xyz>
In-Reply-To: <20251001191739.2323644-1-listout@listout.xyz>
To: Brahmajit Das <listout@listout.xyz>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
 song@kernel.org, syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  2 Oct 2025 00:47:37 +0530 you wrote:
> This patch fixes a crash in the BPF verifier triggered when the BPF_NEG
> operation is applied to a pointer-typed register. The verifier now
> checks that the destination register is not a pointer before performing
> the operation.
> 
> Tested with syzkaller reproducer and new BPF sefltest.
> Closes: https://syzkaller.appspot.com/bug?extid=d36d5ae81e1b0a53ef58
> 
> [...]

Here is the summary with links:
  - [v4,1/2] bpf: Skip scalar adjustment for BPF_NEG if dst is a pointer
    https://git.kernel.org/bpf/bpf/c/34904582b502
  - [v4,2/2] selftests/bpf: Add test for BPF_NEG alu on CONST_PTR_TO_MAP
    https://git.kernel.org/bpf/bpf/c/8709c1685220

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



