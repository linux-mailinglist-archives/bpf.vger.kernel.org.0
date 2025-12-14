Return-Path: <bpf+bounces-76561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B81ACBB645
	for <lists+bpf@lfdr.de>; Sun, 14 Dec 2025 04:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9AC3D3002174
	for <lists+bpf@lfdr.de>; Sun, 14 Dec 2025 03:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46B212F5A5;
	Sun, 14 Dec 2025 03:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqMmherN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300D33B8D68;
	Sun, 14 Dec 2025 03:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765681426; cv=none; b=tln+bIYNiYG031+NgWSZLTDNva1dpqJ67vQ10qTIEc85ZcfDg8YV8mZwUJFZOCMV4Sqo6nl+1Bsmmwae0HMmLmDg3UPMhfYawjcvEjawL0jn5U+prO5SnBCembO41EpYlTqdKWEiXwTo24lPBLnz+pnfCZbR74GHl3hPYNYb5n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765681426; c=relaxed/simple;
	bh=L5koCSzT7gsrvK20gFO+t0ysGlG2MoMJFRyvlmZGdsg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g1Cs0qp7B5YuMHBM+PYn4CApBmyPi6+cxDrbAoxHgBLxIFK9SWgmA0GW2vfauBckcoGeGWYz8gKrdxJBTzWZYdRRDlqoPllk32HwdLTUmxuax+CHPIYevQLgIDRhqQswbdWL95rumOUc/o0oVaUaUJP523jzb78AjqeLT8g2c7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqMmherN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6BEC116B1;
	Sun, 14 Dec 2025 03:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765681425;
	bh=L5koCSzT7gsrvK20gFO+t0ysGlG2MoMJFRyvlmZGdsg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VqMmherNhPv3aJef43xRDTqS1eLZR5QWBwbYPyLgaOQA9cf7vYxxJ9P/BgND4DcWY
	 Y9hTlFF0uM7SKHYiuEN2+xzqNoYJzq8uv9usFjZRu+BNb43ZZHF+1l0cYk6m1b99sz
	 kmuFNE8mLlhz/hR8n4vJvtmA0HZggiebRmbxdCnjHUBbKnlr1VqlxouyIz/v1KzpDS
	 LDnQVUa3V7C5+clfPR0PBxJhTRu1/aORtgghLt7ZBo1Lg/xY7JTi2tBYLFwXmCrHnJ
	 PrYL//Bitj192ZttGUmM2u5/sABDL+u2mPmgCN7MRRbDKYgkVgvg7XhyVzfxE16vlc
	 aWAw9rpMzg+vw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B749380A95F;
	Sun, 14 Dec 2025 03:00:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Fix bpf_seq_read docs for increased buffer
 size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176568123806.2688211.10410310677933771953.git-patchwork-notify@kernel.org>
Date: Sun, 14 Dec 2025 03:00:38 +0000
References: <20251207091005.2829703-1-tjmercier@google.com>
In-Reply-To: <20251207091005.2829703-1-tjmercier@google.com>
To: T.J. Mercier <tjmercier@google.com>
Cc: menglong.dong@linux.dev, yonghong.song@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun,  7 Dec 2025 01:10:04 -0800 you wrote:
> Commit af65320948b8 ("bpf: Bump iter seq size to support BTF
> representation of large data structures") increased the fixed buffer
> size from PAGE_SIZE to PAGE_SIZE << 3, but the docs for the function
> didn't get updated at the same time. Update them.
> 
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Fix bpf_seq_read docs for increased buffer size
    https://git.kernel.org/bpf/bpf-next/c/6f0b824a61f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



