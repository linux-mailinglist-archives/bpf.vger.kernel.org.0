Return-Path: <bpf+bounces-19048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2E182480F
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 19:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609E91C222E1
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 18:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009AF28DDD;
	Thu,  4 Jan 2024 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8g6F3FZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A38A286AF
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 18:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 172E0C433CA;
	Thu,  4 Jan 2024 18:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704392428;
	bh=TAmqPNZXFxWT+geRrO31Vp41j5+6XGzIDQkVRaW9+wo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P8g6F3FZfTo8+jWPO5Q4eUn53iOczaCwg+6zpJ0t5LXy13hlcK+dj9J3aMa1t9QW2
	 xHnYtlmj8bgbZ7lIXIuY/VgrChcsNV8OIr3IUvwoCBbO9YgUUUCDZWfss24voZVoCY
	 3FIr0t0Q13H9zIqQbEoyAZShhQ27lXIcwgbfskq9aIjdmlqV6XBS5ZWzMO4nqnJfUL
	 IrpbTO4IbpzJjttWaZZseKkAFcwgh81DCkK/akOISepC+MpIDx0hc4s2Y5d/MTt03X
	 leqC++Y6/lpli7HRNzKCzoyQjm8Ck4xLpiq+8PYriEnmDOZH6oD/8x1zvOmt84ZAl7
	 09VswXSJVJ17Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC007DCB6CD;
	Thu,  4 Jan 2024 18:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Remove unnecessary cpu == 0 check in memalloc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170439242795.8177.4752189872307025384.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 18:20:27 +0000
References: <20240104165744.702239-1-yonghong.song@linux.dev>
In-Reply-To: <20240104165744.702239-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  4 Jan 2024 08:57:44 -0800 you wrote:
> After merging the patch set [1] to reduce memory usage
> for bpf_global_percpu_ma, Alexei found a redundant check (cpu == 0)
> in function bpf_mem_alloc_percpu_unit_init() ([2]).
> Indeed, the check is unnecessary since c->unit_size will
> be all NULL or all non-NULL for all cpus before
> for_each_possible_cpu() loop.
> Removing the check makes code less confusing.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Remove unnecessary cpu == 0 check in memalloc
    https://git.kernel.org/bpf/bpf-next/c/9ddf872b47e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



