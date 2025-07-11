Return-Path: <bpf+bounces-63073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C022B0231E
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 19:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5298F1C4827A
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 17:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E972F1997;
	Fri, 11 Jul 2025 17:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdLjjG6T"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E80C2EF2AA
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 17:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752256190; cv=none; b=jrDdMe+jhapoI+KlZ+RtarLkMMtudwJoN6f26uPK+43n/r8eVjS44aZ9KeOMgx0PmCb94pKxIjzDOOz7gMV1DicjZX/13bswuU0yeH+d9RsOaV2cGwwjQl48ykdEEXv9nAfBPun+HPzYicpGjaHZD7kM2Ow2xlF1ujtRgaA/8v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752256190; c=relaxed/simple;
	bh=th6f6o1NGCgdGoryjdGZC+JsgvtwtQxnN8tnBTwtFGQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qQciHIJ1VayFr90LayiCfeVtCn99D655kQVBv9DLdV0nQC3ke4cDztOvC0IbX173KUhb7XCgrLIRfqTLyamP+51tNcw25+jjCvNquxcsWYYdDeCd4kTHNYJMRXGxRueGiAVJeekeFH2QZcpl9lrjEyqa9EqE9kk8l7Z/Lj3/Z7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdLjjG6T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B19C4CEED;
	Fri, 11 Jul 2025 17:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752256189;
	bh=th6f6o1NGCgdGoryjdGZC+JsgvtwtQxnN8tnBTwtFGQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qdLjjG6TudDIuJkxUuW6/zeQVwi/J/XP7X7BpwHS4/I+KG2rZAGguwPYGsBFOKi4O
	 DuSgi7Nls/zp5J/iEw1DjGSIuRVygVMqhOoAY6t4rOWHEo7j9gCH6Q0Q+7TbhzdkU1
	 WWqOKxe6i71PhlzayXfaCkPhwYPHyRyJFK0k6zYUd/oGCPRhE0LXKdNu4iUxOksSGS
	 xOsxntT+G6vQ+sXR5CnQswuPRnO8qfUpVYQPMVcltjGTwCjatufSF21Y0kFzP7CAxF
	 0KjoxFIM2aFC6ksNAFpj26WvucShcwaRdd1a+Mpps/QYYaMT2y2+maWla9/U9fd36E
	 fRttIzQryyxGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AECB3383B275;
	Fri, 11 Jul 2025 17:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Forget ranges when refining tnum
 after
 JSET
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175225621151.2353625.1704874843990005715.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 17:50:11 +0000
References: 
 <9d4fd6432a095d281f815770608fdcd16028ce0b.1752171365.git.paul.chaignon@gmail.com>
In-Reply-To: 
 <9d4fd6432a095d281f815770608fdcd16028ce0b.1752171365.git.paul.chaignon@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 10 Jul 2025 20:20:53 +0200 you wrote:
> Syzbot reported a kernel warning due to a range invariant violation on
> the following BPF program.
> 
>   0: call bpf_get_netns_cookie
>   1: if r0 == 0 goto <exit>
>   2: if r0 & Oxffffffff goto <exit>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Forget ranges when refining tnum after JSET
    https://git.kernel.org/bpf/bpf-next/c/6279846b9b25
  - [bpf-next,v2,2/2] selftests/bpf: Range analysis test case for JSET
    https://git.kernel.org/bpf/bpf-next/c/d81526a6ebff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



