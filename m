Return-Path: <bpf+bounces-54354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E713A68306
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 03:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A49B882CFB
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 02:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6994120DD49;
	Wed, 19 Mar 2025 02:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQ95hWc3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BA41F61C
	for <bpf@vger.kernel.org>; Wed, 19 Mar 2025 02:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742350200; cv=none; b=jZoPJl+CaaI8yNUuVTGny5Rqpk3fGsYlerel4OGijPr2gGA6yaYI7Epwg1aOzbaU0KQ6zglHJ8LXREGSDge/QPMz/jsAawJNYTdj3zMgjYHK3wnApA04sCFQlr9XyL2OX7XYyAt51ft/rDVW2cWMtIf1Hr4iMDun9dq2Bv+Co/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742350200; c=relaxed/simple;
	bh=BMKXVsjs9d5C7HIMhy6mbIS5Bj0G9CYS/LAqg8DGC1A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sb35xFF/KjwlsSnzPwjfTC+q3JUvD0s9/yzloV8dtrMFLCmDGiVPrEitn3TosrsGC6rRKSebGZ+rgGO2q8FAnwF9XaKpxw6Tr4iaV4uiQupMvFnSJB3tk+EnnhhdOnFwGfy1SRfQb3vhQXLPXqeuLsiR5sNnCGCXaGEi5c88e4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQ95hWc3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69577C4CEDD;
	Wed, 19 Mar 2025 02:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742350199;
	bh=BMKXVsjs9d5C7HIMhy6mbIS5Bj0G9CYS/LAqg8DGC1A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JQ95hWc37Sf9XRTT4K/IjWsT+pBttgjWdXjXt3Q8G0OhjF32mepnV56viLB2RBrJf
	 ZXqIUvtM9BRf+WRrGdxDEDTHDRErY3X4FTObv5Dhq9IV55kSw5RfHrUMUns0rg2KPN
	 pryj+9XT2gWnMUGvtFFnnfXaT4Mfzj3W+v+GMOe+/hqs9pB4W9W9uMmXctUFT5rAf+
	 VE/8TA+3l5EMp0oVsRcEl5KTK2KCnprkiPJSq3dfB4FGqPc2AnL70pqNezlQayX2YU
	 1hHS03z5pvqtKlyCMXlncKdu5k88MK4rPFyAciT3Nv2/+hxs/tWHxOP2hiyTGZzY/T
	 O9FD/y6fDUiYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34A75380DBEE;
	Wed, 19 Mar 2025 02:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Only fails the busy counter check in
 bpf_cgrp_storage_get if it creates storage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174235023475.536550.5782919972344813926.git-patchwork-notify@kernel.org>
Date: Wed, 19 Mar 2025 02:10:34 +0000
References: <20250318182759.3676094-1-martin.lau@linux.dev>
In-Reply-To: <20250318182759.3676094-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 18 Mar 2025 11:27:59 -0700 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> The current cgrp storage has a percpu counter, bpf_cgrp_storage_busy,
> to detect potential deadlock at a spin_lock that the local storage
> acquires during new storage creation.
> 
> There are false positives. It turns out to be too noisy in
> production. For example, a bpf prog may be doing a
> bpf_cgrp_storage_get on map_a. An IRQ comes in and triggers
> another bpf_cgrp_storage_get on a different map_b. It will then
> trigger the false positive deadlock check in the percpu counter.
> On top of that, both are doing lookup only and no need to create
> new storage, so practically it does not need to acquire
> the spin_lock.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Only fails the busy counter check in bpf_cgrp_storage_get if it creates storage
    https://git.kernel.org/bpf/bpf-next/c/f4edc66e48a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



