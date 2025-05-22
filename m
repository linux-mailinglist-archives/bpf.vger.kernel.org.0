Return-Path: <bpf+bounces-58729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAD8AC0F36
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 17:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E831C189301F
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 15:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6773028D8E5;
	Thu, 22 May 2025 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldjpVvV4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1F628D8C7;
	Thu, 22 May 2025 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747925995; cv=none; b=klNNGJyrYqh0bWi6F/+5+E/ew7M2FXnDFn6Upmy9o42iFK30DWJzAcXUjhnKq/6p64Nf/aH3+SRD90Fc4T5j5jzh2eTeCFX23x0CgGQKmjLtOM/y0CYUTZ1+8AaRS1XBQ1VY02O54dGBoN/gT7JWAgaJJ4Hcjfs53g+okpo7NOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747925995; c=relaxed/simple;
	bh=kkDawP+n8NSjtw+JF2Qg3klXG6+qdXjQ1svMWguQcCc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=khReay87alJqJ1PaMIdhsMoRIfHHJ2DGkCa6t7akEFCuLqNhBfxfeRx+gSmldL/ccUdq0hgUDKueGIHCdi24ssMRAHT+8UlzZLoobu/rU2qvBimdUIWyX1iIoBnRGbEnBGooxHNgTpYhjb7yNfU/eDVqEONWWwBhDPjFmf6hI6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldjpVvV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A97C4CEF0;
	Thu, 22 May 2025 14:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747925994;
	bh=kkDawP+n8NSjtw+JF2Qg3klXG6+qdXjQ1svMWguQcCc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ldjpVvV4pWqA6NNHCWw/pAKrXmST0qkdxWdNG61LFs1V7uvA99xEt2M7rrAHajwLF
	 5eU6GBt4cmRFvn5FDKGfWyamHYvQY+qZpl1u8skfxXQNWX/V2byjD24mctfw8VILUV
	 yVdMlxa38/y8gmafNGlIcxr4acgHrwe/5KOu+Ha44uu1ptI7hn1W6TPcT10NGz80tD
	 KEUyXs7XHkDGlM5FOWAuJl0Z352/GyOt7fOMt7EsBFLeCaB/LyyjD7PmT/TSHIqHUD
	 yOsrUr1Ool9ipZhR358DkJdVBhQr039mgdwy98FmPAujdMmJhbBGJ43HZAtO39gHS3
	 1KAMmrpTAynCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF8A3805D89;
	Thu, 22 May 2025 15:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Revert "bpf: remove unnecessary rcu_read_{lock,unlock}() in
 multi-uprobe attach logic"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174792602976.2907244.15716912232653968267.git-patchwork-notify@kernel.org>
Date: Thu, 22 May 2025 15:00:29 +0000
References: <20250520054943.5002-1-xuewen.yan@unisoc.com>
In-Reply-To: <20250520054943.5002-1-xuewen.yan@unisoc.com>
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: song@kernel.org, jolsa@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, rostedt@goodmis.org, ast@kernel.org,
 mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, xuewen.yan94@gmail.com,
 di.shen@unisoc.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 20 May 2025 13:49:43 +0800 you wrote:
> From: Di Shen <di.shen@unisoc.com>
> 
> This reverts commit 4a8f635a60540888dab3804992e86410360339c8.
> 
> Althought get_pid_task() internally already calls rcu_read_lock() and
> rcu_read_unlock(), the find_vpid() was not.
> 
> [...]

Here is the summary with links:
  - Revert "bpf: remove unnecessary rcu_read_{lock,unlock}() in multi-uprobe attach logic"
    https://git.kernel.org/bpf/bpf-next/c/4e2e6841ff76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



