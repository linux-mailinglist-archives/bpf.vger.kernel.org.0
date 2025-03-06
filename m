Return-Path: <bpf+bounces-53456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA6EA542C7
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 07:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1336816BA1B
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 06:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7E81A239D;
	Thu,  6 Mar 2025 06:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFYB4qQN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17150192590
	for <bpf@vger.kernel.org>; Thu,  6 Mar 2025 06:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741242597; cv=none; b=cldzGuchOaNtL2dk+/aH0yzG58U378nXJo+DAgfzeZnlGBnWbyGFjJEh9N0kii9ig5cqJ26Gl4UM/tcdtYrOqPcYnvPhqDavsu2Z2IS/cu5At1WLOymGDTBjqZ8+zohnEL0sECFdGs2scKEjEgZ7fbpVAswmKfosYk+QP/rHjOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741242597; c=relaxed/simple;
	bh=vmgKZt2clJplOKeiWvdB8m0HggP6kTl7FOavuZBsRCQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UBoobqMv+GLfDMLKIOBGsQj+C1uOWisQGGrqDq7WknurBCs7s1uc/i3nLmPXwXs5SiVkqlO/b0CEfVt55S5UT4Ffqc7Mnm4KB+UMOSepba5bRYPky7eLBG/6WHOXZ/+J2hjySKgyD7Kiox9j7E7eFY8nhLcaXI23xdZ1K5rcpek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFYB4qQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CCBDC4CEE4;
	Thu,  6 Mar 2025 06:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741242596;
	bh=vmgKZt2clJplOKeiWvdB8m0HggP6kTl7FOavuZBsRCQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eFYB4qQNsh7V0FIKqC0lCqh7SGs+RyuXzNG2OxA86Z/V7askVWlqxQbvpDGBtMEpN
	 /RfvODapeKew74ifUC7CHnFIxYLu4DxAccKp2y/+HQR9Q2gjxati6TGDhSgOnfousQ
	 +81yIJbTmJhYpNrbUzzHv0/KRMagI3Oq/If0p5JWyNk8wKw8GOYj/N+NrejGZdorpA
	 iVvNLB0UEu8UeTMRpYq3/TVd3EoYiin3xYrFQtuS4RQCCwmF6EOFD+QYwL7OstD2+u
	 Iy5IuV/+DnB3Uelced05nM1uRqZGkSK9vCD4nZ1dHdvkOfA5WC6ZjwZJHKPWLmIaVt
	 aiyR3n4CWM/cg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADD9380CFF3;
	Thu,  6 Mar 2025 06:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/3] Arena Spin Lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174124262975.1146202.289521712611397459.git-patchwork-notify@kernel.org>
Date: Thu, 06 Mar 2025 06:30:29 +0000
References: <20250306035431.2186189-1-memxor@gmail.com>
In-Reply-To: <20250306035431.2186189-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 tj@kernel.org, emil@etsalapatis.com, brho@google.com, joshdon@google.com,
 dohyunkim@google.com, kkd@meta.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  5 Mar 2025 19:54:28 -0800 you wrote:
> This set provides an implementation of queued spin lock for arena.
> There is no support for resiliency and recovering from deadlocks yet.
> We will wait for the rqspinlock patch set to land before incorporating
> support.
> 
> One minor change compared to the qspinlock algorithm in the kernel is
> that we don't have the trylock fallback when nesting count exceeds 4.
> The maximum number of supported CPUs is 1024, but this can be increased
> in the future if necessary.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/3] selftests/bpf: Introduce cond_break_label
    https://git.kernel.org/bpf/bpf-next/c/994fd3eae1b5
  - [bpf-next,v5,2/3] selftests/bpf: Introduce arena spin lock
    https://git.kernel.org/bpf/bpf-next/c/0201027a026c
  - [bpf-next,v5,3/3] selftests/bpf: Add tests for arena spin lock
    https://git.kernel.org/bpf/bpf-next/c/313149fd0a07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



