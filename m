Return-Path: <bpf+bounces-49134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EC9A146C0
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 00:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 777A43AB450
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 23:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B058242D71;
	Thu, 16 Jan 2025 23:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c69VbPmM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E365A242D6D
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737070808; cv=none; b=nZ/vjk0ITnoeDHsnmQXNWX9Um4wVfyUh/YRdJjWY7fGT4BLpXiH8Q1cnorlq8dvwuBGM+ZCyr2p0Gv9JOhkRqEiOgngEDf1f33pEj1VXjBUQp0YHgg8v5TPT2Z/YUwqC88NZ8a5sWxJYx83kSOCVaW+oOkzanAjhDTpTdZMLnAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737070808; c=relaxed/simple;
	bh=cYc7ZwH3GdZGcXjIu5v2EbbLF9wqnZgsVR1yOclbShg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NlHaG0mE9Xb0vbfAqfuQIFpxGbn6eON1O1PSA8PiAFJ4XKgtRFxzuY9Uxw5qHQNSmxWTGw8ENHdnG0aozW5FgcNhlE8XfeD2FFfAOYm3ioTyobDFjFdtTQbN4LKSQ6e7uW44tY3c+VMioUeXs/bA6opBnIIxizwC0TeCUMUojfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c69VbPmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5311FC4CED6;
	Thu, 16 Jan 2025 23:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737070807;
	bh=cYc7ZwH3GdZGcXjIu5v2EbbLF9wqnZgsVR1yOclbShg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c69VbPmM6hfor8YnvhJvJaWAcAfFyp3JUx+yDf/EcKgz/r4tDZZjFdNsWm3QOHRvP
	 6FkU9NTQea03UMOJjgBC3xbpIgy79/d3R5LgwR1vzsHxtGlQMx8iafhPpIyJr4qiok
	 FTN1xWaiyohQnsIBxHEopbaiSrBVJGZ9oODcu1XRR3UDi19LkGRJeosAhtOtWbE4pu
	 d+n2rhmE0u9/q/zw60bKNX3kLcAd9wRBI4RfV0fcz5c0MrulQVeysW7DCaCMVJ1aIG
	 OTMb0c0WV8kVhMdTEUGZLRuJXUL8FKD2/Ixve5ObXn8RoXQVhjbPiRQIEwwAmIQ2/z
	 MQuBrVh2CUHjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0AC380AA63;
	Thu, 16 Jan 2025 23:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 1/4] selftests/bpf: Fix btf leak on new btf alloc
 failure in btf_distill test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173707083054.1626468.18195179084369376779.git-patchwork-notify@kernel.org>
Date: Thu, 16 Jan 2025 23:40:30 +0000
References: <20250115100241.4171581-1-pulehui@huaweicloud.com>
In-Reply-To: <20250115100241.4171581-1-pulehui@huaweicloud.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 alan.maguire@oracle.com, pulehui@huawei.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 15 Jan 2025 10:02:38 +0000 you wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> Fix btf leak on new btf alloc failure in btf_distill test.
> 
> Fixes: affdeb50616b ("selftests/bpf: Extend distilled BTF tests to cover BTF relocation")
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/4] selftests/bpf: Fix btf leak on new btf alloc failure in btf_distill test
    https://git.kernel.org/bpf/bpf-next/c/4a04cb326a6c
  - [bpf,v2,2/4] libbpf: Fix return zero when elf_begin failed
    https://git.kernel.org/bpf/bpf-next/c/5436a54332c1
  - [bpf,v2,3/4] libbpf: Fix incorrect traversal end type ID when marking BTF_IS_EMBEDDED
    https://git.kernel.org/bpf/bpf-next/c/5ca681a86ef9
  - [bpf,v2,4/4] selftests/bpf: Add distilled BTF test about marking BTF_IS_EMBEDDED
    https://git.kernel.org/bpf/bpf-next/c/556a39940663

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



