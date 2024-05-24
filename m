Return-Path: <bpf+bounces-30502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A968CE7BB
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 17:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEB391F21243
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 15:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3537130484;
	Fri, 24 May 2024 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kE7q2jvU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764B212FF87;
	Fri, 24 May 2024 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716564029; cv=none; b=WdC2syA6UuWwqrizs1rdjzZqKpois3taI/TyZDbYWyTNuSzUoom2nppar2AnC/oadPbKXWFGdI7rUTqygFm3N0jHVsftAGff9puEQVxNxPZdQ4hDa13bLBTWXmYFjJ809XXjHN5WdtZUMTW0itOvqyhcTAcR9cSBx+44B+A53jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716564029; c=relaxed/simple;
	bh=vR6kWNcmgmnay1FzN1W6NB9KmF3ExsMOtwMXfEfWinc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Omi5SZjL+9/hNq/1pqFh5TLfNNpCjXF8okW1iWMzjW5AiGE7svincAv9TvE1CvnKiV/NMzXLl0hzu/0QxP8ApSsIWdPsb1DnYDJeB7OCh3ciQIGZUJZrr3/gQUs1c+225RNGcgTt+mUIWtw7LCom02+lovU7LH3aJ8izA01C51Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kE7q2jvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47A0CC4AF0B;
	Fri, 24 May 2024 15:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716564029;
	bh=vR6kWNcmgmnay1FzN1W6NB9KmF3ExsMOtwMXfEfWinc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kE7q2jvU+AwS13D4A/A6X4lIq1dK30k/TnG66TxqzNlTiOfhW2TwhrkqPVtf/ZcSy
	 60b2nvKje6jHsVi4yM2OLsM25HtVKtBaGAE0cr4mned5IW3G/IwBIT/AXRmJfa/zh6
	 NI+dQZpqatkcP1IIFNwox+RtpXPI+OwCh3PBl2Em+oyS9RvXnM9wP6LlLFX7Sx/w8I
	 0Zr7GjSjllNouXPd67zDpUAQGRUow1m0WnFOXcV85KdrSQWkJs/Q3TWFueBpDN7AZ1
	 qVehSycK0vfYmEw4Hdep1bwi5LAEtPymVrzVdryDI2axKA4xpBZRsw9ksZnIMM4OFI
	 FkiItw3Tn0rgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 38948C32766;
	Fri, 24 May 2024 15:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv, bpf: Use STACK_ALIGN macro for size rounding up
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171656402922.10818.170029478847606118.git-patchwork-notify@kernel.org>
Date: Fri, 24 May 2024 15:20:29 +0000
References: <20240523031835.3977713-1-xiao.w.wang@intel.com>
In-Reply-To: <20240523031835.3977713-1-xiao.w.wang@intel.com>
To: Wang@codeaurora.org, Xiao W <xiao.w.wang@intel.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 luke.r.nels@gmail.com, xi.wang@gmail.com, bjorn@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, pulehui@huawei.com,
 haicheng.li@intel.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 23 May 2024 11:18:35 +0800 you wrote:
> Use the macro STACK_ALIGN that is defined in asm/processor.h for stack size
> rounding up, just like bpf_jit_comp32.c does.
> 
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> Reviewed-by: Pu Lehui <pulehui@huawei.com>
> ---
> v2:
> * The patch targets bpf-next tree, rather than riscv-next. (Lehui)
> 
> [...]

Here is the summary with links:
  - [v2] riscv, bpf: Use STACK_ALIGN macro for size rounding up
    https://git.kernel.org/bpf/bpf-next/c/e944fc815274

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



