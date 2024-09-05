Return-Path: <bpf+bounces-38942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D2896CB7E
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 02:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B750B21734
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 00:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5334CEACE;
	Thu,  5 Sep 2024 00:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiiK6UAW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD424944F
	for <bpf@vger.kernel.org>; Thu,  5 Sep 2024 00:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725494435; cv=none; b=AnRXVVIXC5b36A2YNp213Cs29pcybLVyj5rM/3+2pO9eqqk8L9PWgkcaQ7pDE9rPQxfcqsuwSKLJ8LPHhqKJoI0/R0LJMtLtj4PC/yRT5LLv55sZpoxCSduM2hDyoT773bx19uo0M4mGg7nrc+Dswycl6uRJad1vffsNdp9BzPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725494435; c=relaxed/simple;
	bh=OToYdF5wARfZVVOXxtKcgU6RP4vbqdgW7diRyL0BNmY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SPjebZUvVwGdM8rYyuD6n9Wh3p0R1XU7skf4jAXI4wo0rT0/6UpJCZQuHq/D0bjIGxL4sZ/Jtda3XYjasO27ohmXNND/ytbyeBDo3DPAsC1/QzCG88DRx6WXxWb3tZ60P4lFl8CRfbtB5Z5tY4N92oGDYTuyalJmtqDB5IFk3w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiiK6UAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EFDC4CEC2;
	Thu,  5 Sep 2024 00:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725494435;
	bh=OToYdF5wARfZVVOXxtKcgU6RP4vbqdgW7diRyL0BNmY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BiiK6UAWtqlJ6shE18QD6pb8MV43+NpvUeoSooEb/xb5ou3zSgD/Nyss6XTjh3kPd
	 JQRb+CqmxaTumo4DR05eEG6nSJ0dwVP0idBtV03n5+KfImzA0+npHoGyWWzRuequYy
	 QpveA8uMksrCo3NpO/682NGakCBspBwkU81OFuN+GCDeqbxFujLTuepKKHgRVC4sor
	 gMtr//axLzkR06XiTeCzqdH5Ig5tFZ8Mb6MeUWudDYVKNXuXZOq/F1/SPkKvluxOZQ
	 wmWjZwTe+JD68GDYHBNjDPQjZZp5BEEJBS4PllnWnYZfNwm/TdBN+xmyBhZ6K371wc
	 L3Us0ozluWcqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DB63822D30;
	Thu,  5 Sep 2024 00:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 1/2] bpf, x64: Fix a jit convergence issue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172549443601.1204284.9842696096405416322.git-patchwork-notify@kernel.org>
Date: Thu, 05 Sep 2024 00:00:36 +0000
References: <20240904221251.37109-1-yonghong.song@linux.dev>
In-Reply-To: <20240904221251.37109-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
 hodgesd@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  4 Sep 2024 15:12:51 -0700 you wrote:
> Daniel Hodges reported a jit error when playing with a sched-ext program.
> The error message is:
>   unexpected jmp_cond padding: -4 bytes
> 
> But further investigation shows the error is actual due to failed
> convergence. The following are some analysis:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf, x64: Fix a jit convergence issue
    https://git.kernel.org/bpf/bpf-next/c/c8831bdbfbab
  - [bpf-next,v3,2/2] selftests/bpf: Add a selftest for x86 jit convergence issues
    https://git.kernel.org/bpf/bpf-next/c/eff5b5fffc1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



