Return-Path: <bpf+bounces-54005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655B0A603CF
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 23:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2A2420C1A
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 22:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6471F76BD;
	Thu, 13 Mar 2025 22:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsSmmTsL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6BA1F754C;
	Thu, 13 Mar 2025 22:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741903224; cv=none; b=cjhJuXbKUucEKsTc7Il/F2FMXA2YxenTVN8ykdQKKE8vA4T/HcaFPOoHRX2hj97bKmcH3WlokUoINnvx8TULgsm8giBCoanxkbaUjcLF9mRrYeBmC/xh3X4sxoBqsEYHtN6c5W/7dsfH9hbOSGNNK/hOE/cLZ70w9xOtGqUudzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741903224; c=relaxed/simple;
	bh=hdrHTR1mL6tmZplZ1odsZgbWQm+yiq9Gt1ma1cVGaS4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sbOhjBg3R30T5sWYvfvmrPfQEgL4iec2GWIFM75GdrRahMnXJn3jYQ6gwuZ7PspjSUF+G9BSJ/TS+7kXTvURBPTeymhJ/XAwGwNijlVO5i6hfeJ9fR9Wxn8Gww7fh95GjY45y2UCy0z+U42zdaNiXMjRUfGfqXQApaBLlpOK7UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsSmmTsL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61617C4CEEA;
	Thu, 13 Mar 2025 22:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741903223;
	bh=hdrHTR1mL6tmZplZ1odsZgbWQm+yiq9Gt1ma1cVGaS4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AsSmmTsL/avuhvlYe1k9W9fLouGe3miPR7yUX83m5klF1r659wLQG1XcMEBWNUUdf
	 aLfugTttEnporG/wEdmKkXnR6eZGtI6FvvYFvCM5NezvE2or4qSMfjf3bIgO6iTd0x
	 7vh1L4E50Yen+weXKEZ0DbEzXuptaPtXKk1Xi+yaiKNWUm6LC1bc9oyEfUm8LK4TKp
	 PZLkP2xByy9VX2nk4hAOysNLlHmrWVG+QT3LmS0I33h/sDsyVk54G48M3TUqlAicSy
	 RYqhTDdunuUo3HYnmD+velIarwW6ieeqf0OVGOlHQYraSDFghMCXVvSzi2DmNgN/ki
	 xjqVQIyQh8vhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BDE3806651;
	Thu, 13 Mar 2025 22:00:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] block: Name the RQF flags enum
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174190325773.1674705.18381879459653855191.git-patchwork-notify@kernel.org>
Date: Thu, 13 Mar 2025 22:00:57 +0000
References: <20250306-rqf_flags-v1-1-bbd64918b406@debian.org>
In-Reply-To: <20250306-rqf_flags-v1-1-bbd64918b406@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com,
 yonghong.song@linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jens Axboe <axboe@kernel.dk>:

On Thu, 06 Mar 2025 08:27:51 -0800 you wrote:
> Commit 5f89154e8e9e3445f9b59 ("block: Use enum to define RQF_x bit
> indexes") converted the RQF flags to an anonymous enum, which was
> a beneficial change. This patch goes one step further by naming the enum
> as "rqf_flags".
> 
> This naming enables exporting these flags to BPF clients, eliminating
> the need to duplicate these flags in BPF code. Instead, BPF clients can
> now access the same kernel-side values through CO:RE (Compile Once, Run
> Everywhere), as shown in this example:
> 
> [...]

Here is the summary with links:
  - block: Name the RQF flags enum
    https://git.kernel.org/netdev/net/c/e7112524e5e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



