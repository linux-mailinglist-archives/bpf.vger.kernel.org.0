Return-Path: <bpf+bounces-34079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D411A92A40A
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 15:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F9E1282344
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 13:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A505C13A272;
	Mon,  8 Jul 2024 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dschPgrz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BAA1B970;
	Mon,  8 Jul 2024 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446630; cv=none; b=nilOLRrZvXbMDO+4OhLlj57rB+koTBT1WV8UnYmHbuY6B4V0hSdS0OWNU3t8KXOFkWTefgsMvc6yufkgUo6dDOioS+pcjx+NQPJ6DBYM9bsHgNFfIWwZwrk9k6D+3eadcYsSKPGchByfsqqUY5mSkdsDn4kpHCMAAw5uavE0Dx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446630; c=relaxed/simple;
	bh=WnvZTNr1rDc08yZk/OoeLaabq2dA2AD7qw9cOWofT4U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PUGay/aY1gE0RGMm1q8suJMlNaQB9Jjlg5Wq661TB8J4tl2zFuTLigfe4SFl3slFhdthB4pybPnXcs1vgx1M6IVuiX7+xyRby3ZMy4+XX2pnUAjHb8gN+0Th2oqGESlbkMX4G8l9/NGa+gF3FbDW0yxKCrtZ9HhG4b3BkKA9mnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dschPgrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5484C4AF0A;
	Mon,  8 Jul 2024 13:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720446629;
	bh=WnvZTNr1rDc08yZk/OoeLaabq2dA2AD7qw9cOWofT4U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dschPgrze49j5OHJp2auz1anudegCLHA4Xf5r5CMQ/RMopH12Hv9OJvhxu6Zdp/72
	 pI8whWPGdR9qpZOkDVvb3Mmlbyv27rJ2JUX665HCFvZSOrYT6fpv0/gkuBfeC3vZfT
	 rojxBfey2gA4um/CRZsvgU1ZZl9/5vwdVhqLrfX1BvVsvYDws3YPYIWXubVrgnnHhd
	 K85u7mfqkN8gbLoRZzjOX+2wnemb0EbHROR5KqMWv4fC4EQxDjh+iMwE5CcPt2IeEU
	 SDmpRJNuA0a2InvWwooFQ1iFuL2Xo/wArUhFFQ0pwz5kXzpFx+5s4xdAfHt55IhPE6
	 Z/D17BIh1IAHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F336DF3714;
	Mon,  8 Jul 2024 13:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] riscv, bpf: Optimize stack usage of trampoline
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172044662958.31520.14859964492304138069.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jul 2024 13:50:29 +0000
References: <20240708114758.64414-1-puranjay@kernel.org>
In-Reply-To: <20240708114758.64414-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bjorn@kernel.org,
 pulehui@huawei.com, puranjay12@gmail.com, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon,  8 Jul 2024 11:47:58 +0000 you wrote:
> When BPF_TRAMP_F_CALL_ORIG is not set, stack space for passing arguments
> on stack doesn't need to be reserved because the original function is
> not called.
> 
> Only reserve space for stacked arguments when BPF_TRAMP_F_CALL_ORIG is
> set.
> 
> [...]

Here is the summary with links:
  - [bpf-next] riscv, bpf: Optimize stack usage of trampoline
    https://git.kernel.org/bpf/bpf-next/c/a5912c37faf7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



