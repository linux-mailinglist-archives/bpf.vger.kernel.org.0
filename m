Return-Path: <bpf+bounces-27708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D558B106C
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 19:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF64A1C21443
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 17:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24A316D30D;
	Wed, 24 Apr 2024 17:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffuMAjtv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A12F16C87C
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 17:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713978038; cv=none; b=ihfpYEkpyL3lMg5n3MgTAC9awFsFB+x+ptSNxXGEtNjkmLTaXvTAvMzh34R7OtdR3rjWxD0BPjkaX/SiK+v+GtrkYw6Dch8uKYwpgGAlvhL2gcfwMtG5r8DnzNHIILQmYC/tXz18Exn9BBWHqR3MRQquve/00SaOFxftvVEGI5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713978038; c=relaxed/simple;
	bh=uhhm6KrLQ1YUuWQQKeBUlVnhdkIrwy0TfQakUjxdcWw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VI5ZPU+BihCUpgqhDPnxNCZex2YFBK99zo+B02G6lS4X7rfB3v6R3S2SowRQk8ef7Q9q9JYBN2etqisXMT/OENZf9i1EkesQlCj5JV5D2A/zIDFqTyfsRV9DF6MP0uxtkGqT8Q7/oFyPvd3B7zsuoesCVzDoqQItqmOiftxXw7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffuMAjtv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E61D7C113CD;
	Wed, 24 Apr 2024 17:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713978038;
	bh=uhhm6KrLQ1YUuWQQKeBUlVnhdkIrwy0TfQakUjxdcWw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ffuMAjtvnUi2PTnqch0vnqsTJ+39MAjvqsFXckZBLrgxIBmuRfKcFZjIHV842zoPG
	 LQJIvhs/bc3yipcYJq2Bv5//nwJWNmLsOnOQnEg9bQ/+/NAqJF0F/lUfQK0lZv152q
	 9enW6BNOczWHJRufy4KeB5NWuiPKRDkiQFleR0meNmbB68J7Kct3V79q3HiABB67K4
	 TqMqe8LTZd4q6x7cjFl6Zu2oIK2LU/rpU5jWAYYGOc1Ca2wXQQJve7QT/WNJAnHmRQ
	 ktT59IbjiJlqYHP68Ps5yLlky8Wr1dvWdsHkqUrcZjS8WOQyEtOTtkugu9/i2M4pRA
	 1tC/05xCMJvvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1C2BC595D2;
	Wed, 24 Apr 2024 17:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] Introduce bpf_preempt_{disable,enable}
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171397803785.30408.10925797246940135845.git-patchwork-notify@kernel.org>
Date: Wed, 24 Apr 2024 17:00:37 +0000
References: <20240424031315.2757363-1-memxor@gmail.com>
In-Reply-To: <20240424031315.2757363-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, yonghong.song@linux.dev,
 eddyz87@gmail.com, brho@google.com, void@manifault.com, tj@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 24 Apr 2024 03:13:13 +0000 you wrote:
> This set introduces two kfuncs, bpf_preempt_disable and
> bpf_preempt_enable, which are wrappers around preempt_disable and
> preempt_enable in the kernel. These functions allow a BPF program to
> have code sections where preemption is disabled. There are multiple use
> cases that are served by such a feature, a few are listed below:
> 
> 1. Writing safe per-CPU alogrithms/data structures that work correctly
>    across different contexts.
> 2. Writing safe per-CPU allocators similar to bpf_memalloc on top of
>    array/arena memory blobs.
> 3. Writing locking algorithms in BPF programs natively.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Introduce bpf_preempt_[disable,enable] kfuncs
    https://git.kernel.org/bpf/bpf-next/c/fc7566ad0a82
  - [bpf-next,v2,2/2] selftests/bpf: Add tests for preempt kfuncs
    https://git.kernel.org/bpf/bpf-next/c/3134396f1cba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



