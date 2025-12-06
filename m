Return-Path: <bpf+bounces-76203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF4FCA9CC7
	for <lists+bpf@lfdr.de>; Sat, 06 Dec 2025 02:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50E3B31928C1
	for <lists+bpf@lfdr.de>; Sat,  6 Dec 2025 01:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789502236E3;
	Sat,  6 Dec 2025 01:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBRTMXq3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E77199931;
	Sat,  6 Dec 2025 01:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764982935; cv=none; b=UV8APKfRyETMz+jpSsA2FTM56UOQpKFtrlG5z3dniv8jzbrlz/JwajgpGwRgr0sBnoTr8KmFCi/9YYBhVyNYIS2sxOdsr3tMc7aMQ/XIbKvteyUGXDVRIaXfF+YFxYOnmvHxkmGvwvkXug5EaKftdn1EttYxQFQoTzKeQb9t/IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764982935; c=relaxed/simple;
	bh=S/8MzApMJSD1wL3n0bJVecuce1ZAfZJl27a5E+cIE8U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G/ZoRi+GOvr09sT9mRjUtRFXzHQWrKIKRbTkHm5CxDr8kKQ3HOGHjeSwAkWgc4B+K6kLmFgXdYqwDkuxyStwAJwOJL+p3GjByDCP+PP5uYw51sobeYgcXpOUo9MP368JI6VT3nS8IDSpnP7yh4Tzkgvl2WBPZSnkPs5c4NRG/7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBRTMXq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96B6C4CEF1;
	Sat,  6 Dec 2025 01:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764982934;
	bh=S/8MzApMJSD1wL3n0bJVecuce1ZAfZJl27a5E+cIE8U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eBRTMXq3ao//uDbXMj+4ey7ywykhC2xquecDqXaGDFN2auYSYjh2QPk40e9L22CRe
	 aD9sbvyiE+arG6M7BnNUw1PBpl32c3v/i6oMxCbK1ze3LzzyLEwl7j+jsuXIMkDdVT
	 M4UECRD4FNQG2jVWwNnrPIMk0jrDTCi8Oo7hgJVElWSHMxaNFEUjrqCSGlAf4xdkFL
	 chU0qCvqfiHP8h0ZLhsC/go0od/MWI+fn0A2kTEQgZ13GZA00c+8Z0kDB5VcqwSBhN
	 WyTi8W/kxH0ay1aj3fctCsXSG/1t4sd92YwMy2xsZ+Nd87OCCX0zjAxIGbBNCbCYxM
	 DYx3SWRgYf29g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78AFE3808200;
	Sat,  6 Dec 2025 00:59:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v8 0/6] Support associating BPF programs with
 struct_ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176498275203.1878807.11776031951947151435.git-patchwork-notify@kernel.org>
Date: Sat, 06 Dec 2025 00:59:12 +0000
References: <20251203233748.668365-1-ameryhung@gmail.com>
In-Reply-To: <20251203233748.668365-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
 andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  3 Dec 2025 15:37:42 -0800 you wrote:
> Hi,
> 
> This patchset adds a new BPF command BPF_PROG_ASSOC_STRUCT_OPS to
> the bpf() syscall to allow associating a BPF program with a struct_ops.
> The command is introduced to address a emerging need from struct_ops
> users. As the number of subsystems adopting struct_ops grows, more
> users are building their struct_ops-based solution with some help from
> other BPF programs. For example, scx_layer uses a syscall program as
> a user space trigger to refresh layers [0]. It also uses tracing program
> to infer whether a task is using GPU and needs to be prioritized [1]. In
> these use cases, when there are multiple struct_ops instances, the
> struct_ops kfuncs called from different BPF programs, whether struct_ops
> or not needs to be able to refer to a specific one, which currently is
> not possible.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v8,1/6] bpf: Allow verifier to fixup kernel module kfuncs
    https://git.kernel.org/bpf/bpf-next/c/1588c81b9f21
  - [bpf-next,v8,2/6] bpf: Support associating BPF program with struct_ops
    https://git.kernel.org/bpf/bpf-next/c/b5709f6d26d6
  - [bpf-next,v8,3/6] libbpf: Add support for associating BPF program with struct_ops
    https://git.kernel.org/bpf/bpf-next/c/87cd177b149a
  - [bpf-next,v8,4/6] selftests/bpf: Test BPF_PROG_ASSOC_STRUCT_OPS command
    https://git.kernel.org/bpf/bpf-next/c/33a165f9c2c1
  - [bpf-next,v8,5/6] selftests/bpf: Test ambiguous associated struct_ops
    https://git.kernel.org/bpf/bpf-next/c/04fd12df4e05
  - [bpf-next,v8,6/6] selftests/bpf: Test getting associated struct_ops in timer callback
    https://git.kernel.org/bpf/bpf-next/c/0e841d19263a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



