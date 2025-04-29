Return-Path: <bpf+bounces-56969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B81B1AA1550
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 19:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD775A5222
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 17:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129BE21ADC7;
	Tue, 29 Apr 2025 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fi0Ini96"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896A021ABDB;
	Tue, 29 Apr 2025 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947189; cv=none; b=VTvKZKrKj2cbZ9giqB15N2udlSZJ/NUR+Vemcqn5QTIMAybdfdC7pHkY4d0ZVjuUu3zNMZqe2sBE6upTzEirHzk/stZFSjr4RR9reqMiFBhER8Vx4IPgjDhwN0mEkehdTjASw6GrZm/8jX06wy8NbMngGTT/YiHjqERDWOQxpoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947189; c=relaxed/simple;
	bh=3g2NkuB/whY69K0DL5E2Em/yGyc5WCG665gWx1pWHp8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DCEGjZH1kLBP00J1c68PRPM6CZv1u0yQpXgsyTwz92v405aGU5sa33Q21iiYDWkRsl3iyEUKgZyulen2mYWiNn4+kWpwOBwXmOKi4nMwxJ8dgn4dQzOTxha4KMxrGNVMxgTHDkAaJk1UCd6wmFDrSwa7bqaW23Kp1uzReyP0/SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fi0Ini96; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABF1C4CEE3;
	Tue, 29 Apr 2025 17:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745947189;
	bh=3g2NkuB/whY69K0DL5E2Em/yGyc5WCG665gWx1pWHp8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fi0Ini96L0rh/XsYD70TTL9hZ7JAvVx7WfQdG9+nsa2icJ3w+pA52QNDawt4RfDO1
	 PUDOiRbgY9sIVhDFwGCkL7v4JlXrIwFC18AwRD6VlMguPYH9lul3SsMSlTC8WKWA+P
	 zzzCdJ0B7zRxla1Y8an401QrfZA+1mxRZoRXil5d9+TF3NnjDE/GoiYEFSUoZ4vft5
	 ZqZzXQYgBQ6twkXu85xdocV+32YgERP3EaTb+GkyYj75JMNA97b0cjBeTFKXAJAaXF
	 HtDYqciDRzjxqwg+vAB4/9BTSLqBerseSR4dC3cezfbX4VmrKyvMp6RHYIDV6ejyk5
	 d9Md3nTqrZfBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EBB3822D4A;
	Tue, 29 Apr 2025 17:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: add identical pointer detection to
 btf_dedup_is_equiv()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174594722825.1737547.9973592838963390341.git-patchwork-notify@kernel.org>
Date: Tue, 29 Apr 2025 17:20:28 +0000
References: <20250429161042.2069678-1-alan.maguire@oracle.com>
In-Reply-To: <20250429161042.2069678-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, acme@kernel.org, eddyz87@gmail.com,
 bpf@vger.kernel.org, dwarves@vger.kernel.org, yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 29 Apr 2025 17:10:42 +0100 you wrote:
> Recently as a side-effect of
> 
> commit ac053946f5c4 ("compiler.h: introduce TYPEOF_UNQUAL() macro")
> 
> issues were observed in deduplication between modules and kernel BTF
> such that a large number of kernel types were not deduplicated so
> were found in module BTF (task_struct, bpf_prog etc).  The root cause
> appeared to be a failure to dedup struct types, specifically those
> with members that were pointers with __percpu annotations.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: add identical pointer detection to btf_dedup_is_equiv()
    https://git.kernel.org/bpf/bpf-next/c/8e64c387c942

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



