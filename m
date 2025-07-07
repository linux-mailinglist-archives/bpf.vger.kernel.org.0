Return-Path: <bpf+bounces-62510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C81AFB794
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 17:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237D3189BFB4
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 15:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DE51E1E0B;
	Mon,  7 Jul 2025 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1haWCAl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48E119D880
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751902787; cv=none; b=L9FmtJqRVKeX2R0icZv5NH/4/sHwkGLlhnuE1qoJ5RSWL9zRJtv7OQy7b3rJ9GdCUlyksKateNiBAv0ClU2YAUscVEHJGGPFR/GvSiAxlrqgiS+OxGp6gWfSKoj6qfR5jDrC4iInCTPERTvHbtk+Qx3sIAATgxgVMWvQd6xTWAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751902787; c=relaxed/simple;
	bh=sH0pm5SzV7p/IaMopmpWsRENWtdRvm4lj1pDF0DYsSU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=klSmkKk984oOtKdRzwDIuvqGMroH/5jnwm/UKrILnGPkbkExgMoBsKQqQQChma3/WvGMkF969FoyABI/1PYjGHClc+3sI4GjfYr3WHE74AfpLVelZjdTOv2B3iamG1sTyy7FNaKSbEUKZJTK8rwKGdt0PhmzIQvy25YJaOOPWcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1haWCAl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FCFC4CEF1;
	Mon,  7 Jul 2025 15:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751902787;
	bh=sH0pm5SzV7p/IaMopmpWsRENWtdRvm4lj1pDF0DYsSU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z1haWCAlCcaYPz5M9h65Ir/Ntc/Q7iP5gnl27wGb4uH2hUCUYftPLxLp4RHNWjPQO
	 WwrsJvScf8aAAKmTOm/HTk6w6x4KyOdHhpPwbOE1W5LrhIYJDIhtoLktax4LNCP2fy
	 xZGNYmfYhi9kUE4UEbCxkfRg7PhlnjCtfTomFVue4RUGIQT6qVFmE9Avk/dDNAHvIJ
	 jXFcaoJpsuaViPpXNqwh2CLqCKVzhufGWVEttB3Npj/u/UkmU2dIP5WDsnpqePfr2h
	 2+tipBhHcNKXzrJTbGIrZTUWmrWFUHEK8GkiAnw76hyjjl7gV23rydqF/dZ86sHdeB
	 Xa66HiNty35ig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD9E383BA25;
	Mon,  7 Jul 2025 15:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 0/2] BPF Streams - Fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175190281051.3336255.14071882846814298814.git-patchwork-notify@kernel.org>
Date: Mon, 07 Jul 2025 15:40:10 +0000
References: <20250705053035.3020320-1-memxor@gmail.com>
In-Reply-To: <20250705053035.3020320-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com, kkd@meta.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  4 Jul 2025 22:30:33 -0700 you wrote:
> This set contains some fixes for recently reported issues for BPF
> streams. Please check individual patches for details.
> 
> Kumar Kartikeya Dwivedi (2):
>   bpf: Fix bounds for bpf_prog_get_file_line linfo loop
>   bpf: Fix improper int-to-ptr cast in dump_stack_cb
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/2] bpf: Fix bounds for bpf_prog_get_file_line linfo loop
    https://git.kernel.org/bpf/bpf-next/c/116c8f474722
  - [bpf-next,v1,2/2] bpf: Fix improper int-to-ptr cast in dump_stack_cb
    https://git.kernel.org/bpf/bpf-next/c/bfa2bb9abd99

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



