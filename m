Return-Path: <bpf+bounces-35263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD58293943E
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 21:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 434B6282135
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 19:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA8116F26C;
	Mon, 22 Jul 2024 19:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4ctp13e"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7381B179A8
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 19:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676634; cv=none; b=X106yEuQHtSFgByqEYPtIlMJlNIQG7j8RYGt8QGFejyLJhZDPMJIf+hCgquo2U2J2yo7n08w1/rS/H65TQd2itrfsah11U0XAKi4Wf/xKYYTi06+iYvIW8Z4/79WxiTXvfR3+ujteMmJAsZhUR/mXfAuO/fbN7gGNb1743QnKag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676634; c=relaxed/simple;
	bh=09aDeOPxEsSddEabG4/qf6AoqIigJ5ODBdlcQIa/yok=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a7aw3INvggHt0tFSl6XQQEGdC1LuiNQO4cY1MAw2bVKNi1jBzOVp4YFmTBYsNYE9e8w7D/zAxDu3xra7z1oReMe0ct362sxU/tqxTPMxqyg5Mjam+Y7X62djhZMiJC8CT/hYI98jDBwf8C+HW64HG3vKzT9jd3I1vqn4JMcrtw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4ctp13e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0846CC116B1;
	Mon, 22 Jul 2024 19:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721676634;
	bh=09aDeOPxEsSddEabG4/qf6AoqIigJ5ODBdlcQIa/yok=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k4ctp13eIYRdDikRZX7V4vMM1RMuPe/ylz+v1D5thv76FxoAY4fFlbF2LWhN3k8tK
	 ub/1B9m00VH+nTj53mZK3CAIsSo597+K3/nBPCUN3v6gdd1WyBpuxvljYN8BxvacsE
	 TLq+03xk8s3oZ8Hy0EhKEZW9Zev7H1L1XiVB8OYMwgK+ukWi23OZepbFWjmt/gmzh3
	 G8JfMIJx4jD1HXMfbRE7N7bF+gX3OTvdnhBRKiMdltEV12mtWjIYf7N4G1hgkabXKq
	 yaHUYn+JiP3FOWhS6SbdOBMMZFGfSsyzx+YbGO/V/SPbNbg4p5FExBy3C23cBUhANw
	 QrwvhnFDWMIFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0513C43445;
	Mon, 22 Jul 2024 19:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/3] bpf: Retire the unsupported_ops usage in
 struct_ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172167663397.23040.803797217521521772.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jul 2024 19:30:33 +0000
References: <20240722183049.2254692-1-martin.lau@linux.dev>
In-Reply-To: <20240722183049.2254692-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 22 Jul 2024 11:30:44 -0700 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> This series retires the unsupported_ops usage and depends on the
> null-ness check on the cfi_stubs instead.
> 
> Please see individual patches for details.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/3] bpf: Check unsupported ops from the bpf_struct_ops's cfi_stubs
    https://git.kernel.org/bpf/bpf-next/c/50affe28672e
  - [v2,bpf-next,2/3] selftests/bpf: Fix the missing tramp_1 to tramp_40 ops in cfi_stubs
    https://git.kernel.org/bpf/bpf-next/c/b794efaacc95
  - [v2,bpf-next,3/3] selftests/bpf: Ensure the unsupported struct_ops prog cannot be loaded
    https://git.kernel.org/bpf/bpf-next/c/4979996ac0fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



