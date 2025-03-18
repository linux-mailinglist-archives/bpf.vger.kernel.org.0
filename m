Return-Path: <bpf+bounces-54335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C70A67AFB
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 18:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898E43B462F
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 17:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D026B211A11;
	Tue, 18 Mar 2025 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMmhxScf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5998C20E6F9
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318996; cv=none; b=uknafiEPVXHlwUX4f/KbRYoOVI+avUrw/Y1lmj7TMjD2xV0zE1SsNgI+JraHlwJ+qaRpyMiB21S7lknzQ5EnFSXbok4OXuHp6RqRfndc6CZnp5EppvKcwi7NKIlJNoc4QrxsJ0/y9iFS9tiJgi2xFy57JEkuNRQBS6gvC/HlBEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318996; c=relaxed/simple;
	bh=UW8x23VaeQ3OywPE3Jfs4TrS7uUeJQLoK+TAvyFRCQY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pVgdn3S0j67Pvr3NpnxD5t1uHa5rQvcRxVwA2qv6eKqTZrT3OvXl+zgakBMHdvGic7WFZF7woZDMiDMe1NTtfOFA0BGyRqB2ffsGPN2TrTLmSg7f8oeUd1qeCHI6gS/ETGeJeSQzpzpQJoaMXVGpXP9Ke81sWVZ4kuFkn+6E8eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMmhxScf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB05EC4CEDD;
	Tue, 18 Mar 2025 17:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742318995;
	bh=UW8x23VaeQ3OywPE3Jfs4TrS7uUeJQLoK+TAvyFRCQY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IMmhxScfRw4mG4Zr2T9HCOlU6BPwco2UReVzTkjOjTgq9CXrLGR1gSWkPU/KcW3tN
	 EXhsXAvsykEsU/rLuBtOe5TSOcEgQ87IjCP2pM/o63Q9WFMjdf6QFFrvULeytl66lA
	 M4nESDwiiqCxVdEHkmovkBg2U7CXh60BP8fn3G7bQgj1Kak2wePx9uOSYXYuzWSC6x
	 jaOlpdDJql5b8DM+/749NgwuEWPxX1jvJF1zHTT0+/ZFyfXPqoJ6ZtmMsESdDrvXHn
	 1xcQGVyFHRPj1DZxoy4ubGPKcmIYBqSidxjYoorpr3RF7j+EVqj9usoxAFPUNeUdVE
	 OZjK/khc3tCRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71D14380DBE8;
	Tue, 18 Mar 2025 17:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: make perf_event_read_output accessible from
 BPF core when available
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174231903126.397836.5846143063081800667.git-patchwork-notify@kernel.org>
Date: Tue, 18 Mar 2025 17:30:31 +0000
References: <20250318030753.10949-1-emil@etsalapatis.com>
In-Reply-To: <20250318030753.10949-1-emil@etsalapatis.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 yonghong.song@linux.dev, tj@kernel.org, memxor@gmail.com, jolsa@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 17 Mar 2025 23:07:53 -0400 you wrote:
> The perf_event_read_event_output helper is currently only available to
> tracing protrams, but is useful for other BPF programs like sched_ext
> schedulers. When the helper is available, provide its bpf_func_proto
> directly from the bpf core.
> 
> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: make perf_event_read_output accessible from BPF core when available
    https://git.kernel.org/bpf/bpf-next/c/ae0a457f5d33

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



