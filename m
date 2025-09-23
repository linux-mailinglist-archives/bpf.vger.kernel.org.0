Return-Path: <bpf+bounces-69437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4151AB968B0
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 17:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6801B188301B
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 15:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CD71E491B;
	Tue, 23 Sep 2025 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8TsRMd2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E0942AA9
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758640821; cv=none; b=svPaXK/O9WaCK7G7kQxUhJO35wfMZLSHFWbfHFeP9ki2SIy2NMqFw7MLVv9OScTGqRjwJWa9ldxDomvZP7qR4ByC3zhfP5lFUCdRmiQaOS6RTKu6DXKReXU8CWjqSOAW2rnVX5R0UGjWVf/GTHvK0imILALFce0Hp3tUD+O46sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758640821; c=relaxed/simple;
	bh=tBFbaj25v/m3aJectxvf2jBrMd+IKRd9pKTE6f2WR7U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qik9gIyKL6XSUK7vlz+SLSdxwj5h5wG6J8v7MdTXy0kBGuqzQTbboj+7IXOelKmJA4pnx2HxOiYy5xc0okf8Ra/MdkWikqBBbNSj4CSE0icaZpxjMox448J+vAfCEVi3zYgqcgLhzg+fxnTnabbnPXiOG4jrI61VQGXYAZIsw6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8TsRMd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB55BC4CEF5;
	Tue, 23 Sep 2025 15:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758640820;
	bh=tBFbaj25v/m3aJectxvf2jBrMd+IKRd9pKTE6f2WR7U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j8TsRMd2oTBty5x/yasR8lJgFkuPY4cBNNemN50OMCovcFN6swmxkvdeedD0s78vi
	 gVSbTFOUWNQSZn8lgHNcqlX7UXnZPj6Vz8YUAVbdG4FG218y8rDr53FCXT9wF/6LBR
	 w8/P7Z/ikruUeopHFq28lzx8FLrREJzyBbeTk4adkCWxjQvvjMkoqsxkh554oQoV6q
	 UnIPflAEQNwtVyAtlbpNobOHhBgwdnJofLkvqNdDmR9JNxiJP72Em/7OhxEAisIcZ/
	 pBPbMoUneRDsaJSaJUFexu+4rvE2b2DFp/dgYo1DStGuFnrhYnbRjCMUM6dMz+spy4
	 Nx3+bIy9lcA1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34C0A39D0C20;
	Tue, 23 Sep 2025 15:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v8 0/9] bpf: Introduce deferred task context
 execution
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175864081800.1466288.3242104888617580131.git-patchwork-notify@kernel.org>
Date: Tue, 23 Sep 2025 15:20:18 +0000
References: <20250923112404.668720-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250923112404.668720-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, memxor@gmail.com, yatsenko@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 23 Sep 2025 12:23:55 +0100 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> This patch introduces a new mechanism for BPF programs to schedule
> deferred execution in the context of a specific task using the kernel’s
> task_work infrastructure.
> 
> The new bpf_task_work interface enables BPF use cases that
> require sleepable subprogram execution within task context, for example,
> scheduling sleepable function from the context that does not
> allow sleepable, such as NMI.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v8,1/9] bpf: refactor special field-type detection
    https://git.kernel.org/bpf/bpf-next/c/f90213261681
  - [bpf-next,v8,2/9] bpf: extract generic helper from process_timer_func()
    https://git.kernel.org/bpf/bpf-next/c/5eab266b801f
  - [bpf-next,v8,3/9] bpf: htab: extract helper for freeing special structs
    https://git.kernel.org/bpf/bpf-next/c/acc3a0d2506c
  - [bpf-next,v8,4/9] bpf: verifier: permit non-zero returns from async callbacks
    https://git.kernel.org/bpf/bpf-next/c/d2699bdb6eba
  - [bpf-next,v8,5/9] bpf: bpf task work plumbing
    https://git.kernel.org/bpf/bpf-next/c/5c8fd7e2b5b0
  - [bpf-next,v8,6/9] bpf: extract map key pointer calculation
    https://git.kernel.org/bpf/bpf-next/c/5e8134f50d30
  - [bpf-next,v8,7/9] bpf: task work scheduling kfuncs
    https://git.kernel.org/bpf/bpf-next/c/38aa7003e369
  - [bpf-next,v8,8/9] selftests/bpf: BPF task work scheduling tests
    https://git.kernel.org/bpf/bpf-next/c/39fd74dfd5d2
  - [bpf-next,v8,9/9] selftests/bpf: add bpf task work stress tests
    https://git.kernel.org/bpf/bpf-next/c/c6ae18e0af5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



