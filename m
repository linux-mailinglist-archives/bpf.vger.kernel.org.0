Return-Path: <bpf+bounces-39059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D0696E3C0
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 22:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 915A1B246A3
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 20:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D972C1A42D6;
	Thu,  5 Sep 2024 20:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4fzAj6i"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5831A3AAB;
	Thu,  5 Sep 2024 20:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567035; cv=none; b=Am5KYjLXKFQG0RH8t/WbPHuXx7mt4zbUvYad3VmXdgc3V1o2kNSffCF42XLIUNIAohgy9DqVnHsECwh5a8PPScvZnWAGm0zkVPmdTnEaujJNpQz41be4xv0MouP9cSqDcW4nK38SaAAzxtdG/ZxIFw81ziPNvE3ujpF4QsIFGkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567035; c=relaxed/simple;
	bh=g0zSgLf6QLnK/WBkJ4tVQPV6L2/i/L2pNDvdQAEkZFQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hPDB7hY3EwurNq803LF0FEbMW3xtYtoI/F5x4Z2XjRJMDabj1Blrvx9cU9nl+xfVuXUyHD6d1YcjNFdPlcMfXRYNshzoAcHJDWlJECh5FzDj4GoRlzPpOGWmVqTVHIB0HSPXCdQNqukKZl8bJmj4B8Lpfmz9IxB/iOHTOAL2ECA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4fzAj6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB267C4CEC9;
	Thu,  5 Sep 2024 20:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725567034;
	bh=g0zSgLf6QLnK/WBkJ4tVQPV6L2/i/L2pNDvdQAEkZFQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k4fzAj6iJ8Ypd3SZjxLqZ5OaLoFz0lImkqGJK1qxSyU1MpXXehqO3RoglzWtXfQgZ
	 K4l+IYd6lTI61m6leUGtVXsFeRrdop6KFaE6NFMykREESwzVhUft2mEqre9lRCiNnM
	 ukvxmjgdvwlTVIyuzconFm6KIdDsTgYfpSCW7qa1GLVZtLyGZby0SBhSuQAFaVMqF8
	 eoHLsNfofbS09tFVSnoO8vWH3P6ShCGXm+p3QhJExE98awvdEyaADFeKZCEjuscNcM
	 qFXfWJQG+ao425Epj9r6/BavtpjeV1NHZ6TvT+GUOshdzbwEOWH9Jbs20gc8ut2cMk
	 G7rMmlsjzoqzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB4033806651;
	Thu,  5 Sep 2024 20:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 bpf-next 0/4] selftests/bpf: Add uprobe multi pid filter
 test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172556703579.1814248.14807551869731691476.git-patchwork-notify@kernel.org>
Date: Thu, 05 Sep 2024 20:10:35 +0000
References: <20240905115124.1503998-1-jolsa@kernel.org>
In-Reply-To: <20240905115124.1503998-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: oleg@redhat.com, peterz@infradead.org, andrii@kernel.org,
 i.pear@outlook.com, mhiramat@kernel.org, bpf@vger.kernel.org,
 rostedt@goodmis.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu,  5 Sep 2024 14:51:20 +0300 you wrote:
> hi,
> sending fix for uprobe multi pid filtering together with tests. The first
> version included tests for standard uprobes, but as we still do not have
> fix for that, sending just uprobe multi changes.
> 
> thanks,
> jirka
> 
> [...]

Here is the summary with links:
  - [PATCHv2,bpf-next,1/4] bpf: Fix uprobe multi pid filter check
    https://git.kernel.org/bpf/bpf-next/c/900f362e2062
  - [PATCHv2,bpf-next,2/4] selftests/bpf: Add child argument to spawn_child function
    https://git.kernel.org/bpf/bpf-next/c/0b0bb453716f
  - [PATCHv2,bpf-next,3/4] selftests/bpf: Add uprobe multi pid filter test for fork-ed processes
    https://git.kernel.org/bpf/bpf-next/c/8df43e859454
  - [PATCHv2,bpf-next,4/4] selftests/bpf: Add uprobe multi pid filter test for clone-ed processes
    https://git.kernel.org/bpf/bpf-next/c/d2520bdb1932

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



