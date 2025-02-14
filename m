Return-Path: <bpf+bounces-51507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792E7A35385
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 02:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38AA816CBF7
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 01:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D403A8C1;
	Fri, 14 Feb 2025 01:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clrOKDQI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736B06FC5;
	Fri, 14 Feb 2025 01:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739495409; cv=none; b=OEMOAfT7GQfmlZcNaERw/3jFgBhRxR64Hhxyr3HGYem2ARwscqMaFv8u92oMFLau6p/PklinljK8TgECVh8UfOLVHi9g3/yf1+MnPkTkO8pi6OzZVVq1KPxgkvQSehJk6q18jUTdhx60aWPiIjEKUZWYx9IN7mmdBSCPyEBsxtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739495409; c=relaxed/simple;
	bh=Tvy9ElEUsaUGq325jlvAH+DarQMjL012qqrFIAa8xnk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jZjjcV2+ZQiuwKvQKXCcN/jujcJvps6Q2kIISFdlpi7AEhpVG992N5LJqbLGnaNtwTx0qXlY6kmWWaZjEBU7RjBdGOWiOF3tAt9aO7tw70hPbdwAhcKROvp3j/t1w6pkLGg+sGkgTSFZ1g7AHqCdcMhu+IYrttNUelE+EYTjbs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clrOKDQI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0281C4CED1;
	Fri, 14 Feb 2025 01:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739495408;
	bh=Tvy9ElEUsaUGq325jlvAH+DarQMjL012qqrFIAa8xnk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=clrOKDQIdJQXPIMW+iYiw3whVhrHMg7MbzrvyqtxKfpfBFUlLsDh8i0P8KKJXTPcy
	 hKbCbP0qSAnE2zp2kFgJySQ24m7d4Sz0fCl+tk6XDjAuqHxLhO8G9MYwk+d22cN/iT
	 OpZe2BavKj49rECeTUBO7/zHxu5HWtrhO8+Fp9kEqC3REVF/B4TZsIxuLqh7/ZRAnS
	 tr9ajfFlJ7V/QQ16cy0I4e8jDB33glQma3beItdLOV7ED3HzEe5dA6BcdLdvKR20iN
	 WdqEWskZYr4mHBSkbvQFpWu4vH06fNBB8bDUXFDZSXhk+Vyqb2COXix+GnwKooq3WG
	 zorEnCtMT9DwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E22380CEF4;
	Fri, 14 Feb 2025 01:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Add tracepoints with null-able arguments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173949543826.1451727.12982763105090471727.git-patchwork-notify@kernel.org>
Date: Fri, 14 Feb 2025 01:10:38 +0000
References: <20250210175913.2893549-1-jolsa@kernel.org>
In-Reply-To: <20250210175913.2893549-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, kafai@fb.com,
 songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@chromium.org, sdf@fomichev.me, haoluo@google.com, memxor@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 10 Feb 2025 18:59:13 +0100 you wrote:
> Some of the tracepoints slipped when we did the first scan, adding them now.
> 
> Fixes: 838a10bd2ebf ("bpf: Augment raw_tp arguments with PTR_MAYBE_NULL")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/bpf/btf.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)

Here is the summary with links:
  - [bpf-next] bpf: Add tracepoints with null-able arguments
    https://git.kernel.org/bpf/bpf-next/c/c83e2d970bae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



