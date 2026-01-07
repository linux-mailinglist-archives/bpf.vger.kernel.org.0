Return-Path: <bpf+bounces-78042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6595BCFC09C
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 06:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A3BA3037CFB
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 05:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801BF261B71;
	Wed,  7 Jan 2026 05:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYQ+q5NP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F201B257828;
	Wed,  7 Jan 2026 05:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767762221; cv=none; b=LM9mPc4ey3g9XA160GQr/FV1QK8eAYsTlmJRxW+rrurAUKeXgZ9cRSCy5I8B+WgHqspXCfdSw9MavxM6voB+8YMO+pCrl+dzfVZheDNYFVhIPT14zBnaA9a8YKc5pRFLXwdqSTye5BdyySec95v1gYvV3vldNWo+icDcDhKIOL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767762221; c=relaxed/simple;
	bh=Mw/HM2NiutzZ5I+gGaNyr68w91B8BKl1ebFDVbo1zqM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gMfbIzK8v/y9FSjbrnefMcy3Hioy9t/exEPEQRRIEtwtdGJD++gnVmiqO0uY9OOGPlG/A64LKpwpbfTPwwGqt3+Xm2hUp8t8sptbrIXh99wLYP+tR+QU+fWjU/7S/4uOqsbDq6sXSmxy2v6+g4SmR5hapGyPLrRDl8i7pVm15qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYQ+q5NP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9255AC4CEF7;
	Wed,  7 Jan 2026 05:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767762220;
	bh=Mw/HM2NiutzZ5I+gGaNyr68w91B8BKl1ebFDVbo1zqM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hYQ+q5NPFUQq7vpIFuRN1f2LQvYzk7Lq5lkx1nmjevI0iBR9nCnwstskORA7f3c0v
	 q5UksxwM+NVKlYY6mo2lJGiEqShNMsj/YTJkkaH4g5+pYnvmOdO5pHgRYZ51YZ5oeQ
	 qmgiNZJF5zP95UADD1U58kyMzehfReRaoc047Wa3KRe5gzeWULuu/5vxiJ91vJAd+t
	 C8BLJCVLbN7b46RKqGnPtxNRx62aLaMQ06LBGZxDAPtjahy/o5+dm+pehO47vU+dUR
	 dXtwW5oDQphe+wssKCvO8scSEMNOm4d8V924u1BKoAYeHps8kZwZccqJrxK8zNXLEI
	 f40qBMkPUpgFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BA47380CEFA;
	Wed,  7 Jan 2026 05:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] scripts/gen-btf.sh: Ensure initial object in
 gen_btf_o is ELF with correct endianness
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176776201803.2234404.13594705347777050753.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 05:00:18 +0000
References: <20260106-fix-gen-btf-sh-lto-v2-1-01d3e1c241c4@kernel.org>
In-Reply-To: <20260106-fix-gen-btf-sh-lto-v2-1-01d3e1c241c4@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 ihor.solodrai@linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 06 Jan 2026 15:44:20 -0700 you wrote:
> After commit 600605853f87 ("scripts/gen-btf.sh: Fix .btf.o generation
> when compiling for RISCV"), there is an error from llvm-objcopy when
> CONFIG_LTO_CLANG is enabled:
> 
>   llvm-objcopy: error: '.tmp_vmlinux1.btf.o': The file was not recognized as a valid object file
>   Failed to generate BTF for vmlinux
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] scripts/gen-btf.sh: Ensure initial object in gen_btf_o is ELF with correct endianness
    https://git.kernel.org/bpf/bpf-next/c/2421649778dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



