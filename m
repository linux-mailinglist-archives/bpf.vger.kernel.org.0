Return-Path: <bpf+bounces-60366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120CDAD5F27
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 21:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4E95174BE4
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 19:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F59289804;
	Wed, 11 Jun 2025 19:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YF9OjLPf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8042E6102;
	Wed, 11 Jun 2025 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749670803; cv=none; b=UP76oP1XP9EqXbK1Xubgc1rZCi7xHGRyqnazTwq45LcsDC63FLCnIDyCKyR1xFhpwnrIDuEEFSMUMK1RK4+40Io4mvbn/Nq3it6iJmjSh88THQ1SSfvr82xrO1K0lSq1qDbcanDLgVNbtd5MquuPZ40VCuKKC9XVdJfZLh8l/x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749670803; c=relaxed/simple;
	bh=RdDgB5vv9s6QQrusbmhG137/cXeRQy452urku8EbNjk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G4sVYSqKouPMm1IMmM6RCi8NGuhaiNKvr47zIR1xC6qbpPcVaosI6wB3HIE26cKvAJusl3vTQPHyJjcX9ZAxlFyLfXLnycPJUKDchIPerWlqjHlxT01PzKZ9sV3IlZrZ4Ysb8fIb12VEtgEyzPUrAOPmDHD8NafjQ+Q7pSlXkmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YF9OjLPf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B31FC4CEE3;
	Wed, 11 Jun 2025 19:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749670802;
	bh=RdDgB5vv9s6QQrusbmhG137/cXeRQy452urku8EbNjk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YF9OjLPfQXVV6mc4HCBRKgX4g7WNlwAqZ+APCyFppptHyRYYk679onLas4UaCNF+W
	 iU96jzuCFU/0y5ByYat6Re9t/DocGtAI7adNATnpXhtg95jVmqdeWvRo0lwsqqFL4q
	 JBAB4PiyCQdeODNh6Wn6Eha+c+VvlaGHgJg4UbrCllVUxUrLeFCcsNskPmZo9iJMij
	 MXP+E2zkhL1vRLZ2DI54hwPF2dhR7TqIlOuOoShPIEX7PR8KgNpaJov+1fmOilu4w8
	 aLE/FJ1uYgbYg1X5LLvMkyXCvfQywgV4AH3zHgvblCmeTgxOfFqVbs6HzHlFu07KDA
	 FxRrQEnWUH9zg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCDC380DBE9;
	Wed, 11 Jun 2025 19:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: clear user buf when bpf_d_path failed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174967083249.3454768.8625737393952649664.git-patchwork-notify@kernel.org>
Date: Wed, 11 Jun 2025 19:40:32 +0000
References: <20250611154859.259682-1-chen.dylane@linux.dev>
In-Reply-To: <20250611154859.259682-1-chen.dylane@linux.dev>
To: Tao Chen <chen.dylane@linux.dev>
Cc: kpsingh@kernel.org, mattbobrowski@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, sdf@fomichev.me, haoluo@google.com,
 jolsa@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 11 Jun 2025 23:48:58 +0800 you wrote:
> The bpf_d_path() function may fail. If it does,
> clear the user buf, like bpf_probe_read etc.
> 
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/trace/bpf_trace.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] bpf: clear user buf when bpf_d_path failed
    https://git.kernel.org/bpf/bpf-next/c/3b55a9e6738b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



