Return-Path: <bpf+bounces-48986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6860EA12DF0
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 22:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF0A164365
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 21:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB6D1DB37C;
	Wed, 15 Jan 2025 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idSCTLfv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1421D7E50;
	Wed, 15 Jan 2025 21:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736977811; cv=none; b=kTRz186OpbVhRrnR26PcIuYHtU3cvTP5XrBy4yV1pTOqQRqEDZoyFI2VORwxojMkLFvMfS4mtxIHgGwWW0VjU3XeF9GccloWHcxlNpXolSwVPSG1IpE4EO4TPTCKVND7g6rlILYrIl7HKbls9BnPVuekWp96+xGtGUVXomqBKnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736977811; c=relaxed/simple;
	bh=7dDkJ88wOVqK4+qxzqf0k4Rfebg1A7Q2LNbdDt1x58Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lVnAw8uAbFWmXZkti3BJTdPEAssGQTsdkUg7pcibAk7R1iCT9uKER1MeV0gvfvzBdWkBTkkdZBap8kDaT2XVtvi/S+9yoZ8m+2Ud1hJNeUpPTqn2Kjy2kiLkXW/B3zGgqtZiHkverEu+DG04yMghtBx5LZ9z7ZNxQM6AVdcpIw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idSCTLfv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BCFC4CED1;
	Wed, 15 Jan 2025 21:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736977809;
	bh=7dDkJ88wOVqK4+qxzqf0k4Rfebg1A7Q2LNbdDt1x58Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=idSCTLfvMwa3Sgxt2c7b5lQ3oKD9naooPLRsftPiSbEBJl2xzHHjjxqKnCGZ1Gitr
	 pdAz0KJc5n1Drv4WDnrUFxHQ3VqgAJADUc77HHy+S/674NUpc5D3A/DuJjksXiaLoK
	 brjMAK2MLEJ+xTJhkjh5wCxkqeapuH4Mf7PGbXBYopO6Lodh2qxnWIaYgpI2q5IzkI
	 fQengyoi6LrjQqzLwMtEgCq2u8cisEVEcEpggUcxK5RCfjqW6UQ0eQrCw0JzP8Ojnb
	 lSxVmgCz8zJU+jQDSHFedagOGJjOgbAJhAfLbrZN/di/mYjHvXUTHExi1jeHCgO47h
	 1W+BYf5N1Y0kA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0C5380AA5F;
	Wed, 15 Jan 2025 21:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: trace: send signals asynchronously if !preemptible
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173697783222.891083.11459948002866992362.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jan 2025 21:50:32 +0000
References: <20250115103647.38487-1-puranjay@kernel.org>
In-Reply-To: <20250115103647.38487-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: song@kernel.org, jolsa@kernel.org, kpsingh@kernel.org,
 mattbobrowski@google.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 yonghong.song@linux.dev, john.fastabend@gmail.com, sdf@fomichev.me,
 haoluo@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 puranjay12@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 15 Jan 2025 10:36:47 +0000 you wrote:
> BPF programs can execute in all kinds of contexts and when a program
> running in a non-preemptible context uses the bpf_send_signal() kfunc,
> it will cause issues because this kfunc can sleep.
> 
> So change `irqs_disabled()` to `!preemptible()` that covers all edge
> cases: preempt_count() == 0 and irqs_disabled()
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: trace: send signals asynchronously if !preemptible
    https://git.kernel.org/bpf/bpf-next/c/87c544108b61

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



