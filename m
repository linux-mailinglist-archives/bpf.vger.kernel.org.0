Return-Path: <bpf+bounces-75764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AA735C94620
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 18:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE8344E2DCD
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 17:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E374A31065B;
	Sat, 29 Nov 2025 17:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXWNLfE1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513063101D8;
	Sat, 29 Nov 2025 17:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764438812; cv=none; b=YZbkUjQrhWDBdoULWZsk8kNC9RNwZTpP+8td2HyWZh9Av2duq1GDP+hWtKFO/bZlT1dFYXN+jQgoOu4cO2Oz1kAYDN0RYS9iDQhma6ftqn3xf4v5iC4ZtdOmqNm5YdjcWYO01SoQICmszX1IxfjcpnscCfQXKk9IcL9IN8GfT1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764438812; c=relaxed/simple;
	bh=07cWg4rjyv1Qx7IR7edIIpZWcLxcrpThqYEXlJ3voOM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dgSd4FgOtm13vIXhUOTTxbEjKzTwtB2ZqS5kgfoJZ5ojmPzdKJU64ZwrVHz6BAoRQggPed2Q6xdnvRhqfMMiqu9Ptl/ArYfmLRV82vuxgE9Ph4cMCAyDmPPO8IATkI70sW71nelQN7P8GxT/5aSjLPonS/nROcNJKqf6aS89ICw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXWNLfE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF52C4CEF7;
	Sat, 29 Nov 2025 17:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764438812;
	bh=07cWg4rjyv1Qx7IR7edIIpZWcLxcrpThqYEXlJ3voOM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fXWNLfE1CC8kNE3ByagL3XiPuKNa8c0OjSw95rnfj9yEDkJsclRe7RjjB8/9GdPXU
	 eQq0xOJ7FHW04m5accXwnJll7mfNcOAGe1VVwhSCSlhbKR9CY8sGPXMtev6grmCiXQ
	 i3kqO1Q6mr81DyAg94iJo0AkK4oKdJk0GlcXFWIfiWccJ2VAPxz9KzeTd2/y37bG/2
	 dmjvmasZlc5mJSN1nGyBqaNF3MXmVEwuVJaj8PN6X8R1zD9oulY5jn+2QHjaqFy+ea
	 svLB0R4GtgJ3pAJwV3jaO6ccurHZh4d93QfkYQypCwUCeSs+K9ptrrK56A3PQX/WJ+
	 j2cRNHd2zUcPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7879D3806934;
	Sat, 29 Nov 2025 17:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: make kprobe_multi_link_prog_run
 always_inline
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176443863303.1061209.7400628119059736420.git-patchwork-notify@kernel.org>
Date: Sat, 29 Nov 2025 17:50:33 +0000
References: <20251126085246.309942-1-dongml2@chinatelecom.cn>
In-Reply-To: <20251126085246.309942-1-dongml2@chinatelecom.cn>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.or, jolsa@kernel.org, kpsingh@kernel.org,
 mattbobrowski@google.com, song@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com,
 sdf@fomichev.me, haoluo@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, jiang.biao@linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 26 Nov 2025 16:52:46 +0800 you wrote:
> Make kprobe_multi_link_prog_run() always inline to obtain better
> performance. Before this patch, the bench performance is:
> 
> ./bench trig-kprobe-multi
> Setting up benchmark 'trig-kprobe-multi'...
> Benchmark 'trig-kprobe-multi' started.
> Iter   0 ( 95.485us): hits   62.462M/s ( 62.462M/prod), [...]
> Iter   1 (-80.054us): hits   62.486M/s ( 62.486M/prod), [...]
> Iter   2 ( 13.572us): hits   62.287M/s ( 62.287M/prod), [...]
> Iter   3 ( 76.961us): hits   62.293M/s ( 62.293M/prod), [...]
> Iter   4 (-77.698us): hits   62.394M/s ( 62.394M/prod), [...]
> Iter   5 (-13.399us): hits   62.319M/s ( 62.319M/prod), [...]
> Iter   6 ( 77.573us): hits   62.250M/s ( 62.250M/prod), [...]
> Summary: hits   62.338 ± 0.083M/s ( 62.338M/prod)
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: make kprobe_multi_link_prog_run always_inline
    https://git.kernel.org/bpf/bpf-next/c/c1af4465b9b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



