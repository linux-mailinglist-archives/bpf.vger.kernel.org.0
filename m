Return-Path: <bpf+bounces-74535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D77C5EC8D
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 19:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2480F4F6FC3
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 17:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EBE34679D;
	Fri, 14 Nov 2025 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spMzXse3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515D72D5C83
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 17:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763143073; cv=none; b=RwCqqd8j/YEDv/abaUYw2LB1PbSvDGN3cRoxefO1qE4U94b4cAGNcWmt4zTNHA72sd/m2ho5UkoMu2HiueGVJjjdqfqZjtIcsE5JdZS2GocmK1qv27STuiUOoF5mBFENfBT4nwjL4NhvpYFW5x3DpiHiDDkhn1C7nNRDNFgDfDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763143073; c=relaxed/simple;
	bh=hPPDAzJT8NH+jfKmf7kjr1O6gTeH4OKe402tmq4c89M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f5bH09ef3Yfyhkice9/c91y46J4lZz1FQHtwc4UmWCw8eTq81BqcH9QOm1eqLgTnYoceOqd0xbCEyAV4AhzpbowVxG8hiCa+KmEU4jCBiwnZTcG9048fhxlxr8IKjw8mF6SKjAlxRIwcRqX0zDVTgUrexV7kllecsXbtj2EVJ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spMzXse3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB25FC4CEF5;
	Fri, 14 Nov 2025 17:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763143072;
	bh=hPPDAzJT8NH+jfKmf7kjr1O6gTeH4OKe402tmq4c89M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=spMzXse3QQjFZ/u2b7bFgFm97l12pUsrOmd7PmwTJclPUQMxPYoa9xjoVpFMWbamV
	 VKqDIfJydLkT+oAWAyjgAHMznT6tO6ppqA7E60QXfv4Ny+IFpmU8K0lxxfBW1RKbQe
	 rrR9p/sFTpcsx55jd3YVk13RwKTKDCc2IjdNuJtbh4LhnWr7UNKBVc60/IZkERKgFb
	 PHV77N3TuzhRC4y2bgJdEQpawbaxM/l9hGhpaWAYHCacweMYMuuzQLmUuf535hje3V
	 z82l6himV4d+/dxaPvNXm6CZKZ/RpqCAmHWAHfsoyEyPqbyCn3gP+BLu9iUUg4L8hE
	 ph0MuomrsJ9Fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8462C3A7859E;
	Fri, 14 Nov 2025 17:57:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v1 1/2] bpf: account for current allocated stack depth
 in
 widen_imprecise_scalars()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176314304143.1747974.17106695505355310740.git-patchwork-notify@kernel.org>
Date: Fri, 14 Nov 2025 17:57:21 +0000
References: <20251114025730.772723-1-eddyz87@gmail.com>
In-Reply-To: <20251114025730.772723-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, emil@etsalapatis.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 13 Nov 2025 18:57:29 -0800 you wrote:
> The usage pattern for widen_imprecise_scalars() looks as follows:
> 
>     prev_st = find_prev_entry(env, ...);
>     queued_st = push_stack(...);
>     widen_imprecise_scalars(env, prev_st, queued_st);
> 
> Where prev_st is an ancestor of the queued_st in the explored states
> tree. This ancestor is not guaranteed to have same allocated stack
> depth as queued_st. E.g. in the following case:
> 
> [...]

Here is the summary with links:
  - [bpf,v1,1/2] bpf: account for current allocated stack depth in widen_imprecise_scalars()
    https://git.kernel.org/bpf/bpf/c/b0c8e6d3d866
  - [bpf,v1,2/2] selftests/bpf: widen_imprecise_scalars() and different stack depth
    https://git.kernel.org/bpf/bpf/c/6c762611fed7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



