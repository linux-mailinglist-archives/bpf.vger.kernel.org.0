Return-Path: <bpf+bounces-77533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A71FCEA7EF
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 19:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24952303ADE7
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 18:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3614E32ED44;
	Tue, 30 Dec 2025 18:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcN0ncod"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93733271A7C;
	Tue, 30 Dec 2025 18:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767120204; cv=none; b=Ufs4k4npAX9J41nfM9b3aYDusc6vOdAuLd1577aW/jPvnMzasJ8PdSSOveSQc0X3kEqmV3XR7ECJlug0eIzCGIUyq7mWYIuqYp9sAQZAzO5KO+y/oPNldvAzx3vkPRxlBRQUX9R6NG/kEweYsEl9cm455ag9C8MfX1NwqxvHZQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767120204; c=relaxed/simple;
	bh=WrlGMin2EgRjAkIaWiiWYH94N9NdEkLX6onE7jLgZQU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YcrZdUgHH4zUOvV0Zd/+vTIBPmiJKzetxFrITc/XsfQS9tduR9c4cZytTYmifxny+wh7VFAh9q2uANYT7KigcmSO2v9eaiMY2p00AZRSaNd1X9EpVUej0lQ+zlxgw6J9ii5jvOnMK1lAXK+BNtJmdvGjnTVWqFnBgGJGBF0Jkrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcN0ncod; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17211C4CEFB;
	Tue, 30 Dec 2025 18:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767120204;
	bh=WrlGMin2EgRjAkIaWiiWYH94N9NdEkLX6onE7jLgZQU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FcN0ncod52lcXxeXbXHFxhG0FOF/Envk4veDSFsvm/UOqDxhR23AEanDQ9JFOnhNG
	 LjE2YrnNbY2+xOyP4u1orsSLrQ/Gfo+VMfEOmhDm9cVaY9faDYojaZheAn1yQ/8/YC
	 MFtKSIZ2f8VmYHYUU8yk7LHZnTxIH0wjDC81N0wDewQ/fH0kUyWXjshOr7TYj8VPnK
	 edyhYKwzeKhK7kmSwHI2S+Zjumi12IYy5mRYH4m5r92Gl4y+KRdNjQCMsshQ6T2mP+
	 Xs2aU/nVHpMEtisnr3PxAAz8iQWrCPZIaV/G3S9CKBugxBzHPEt+jPajGihU/vOIBD
	 b1KKtz0EtAnQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B8E33809A0D;
	Tue, 30 Dec 2025 18:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] scripts/gen-btf.sh: Fix .btf.o generation when
 compiling for RISCV
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176712000605.3329931.5334657371123861484.git-patchwork-notify@kernel.org>
Date: Tue, 30 Dec 2025 18:40:06 +0000
References: <20251229202823.569619-1-ihor.solodrai@linux.dev>
In-Reply-To: <20251229202823.569619-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, nathan@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, llvm@lists.linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 29 Dec 2025 12:28:23 -0800 you wrote:
> gen-btf.sh emits a .btf.o file with BTF sections to be linked into
> vmlinux in link-vmlinux.sh
> 
> This .btf.o file is created by compiling an emptystring with ${CC},
> and then adding BTF sections into it with ${OBJCOPY}.
> 
> To ensure the .btf.o is linkable when cross-compiling with LLVM, we
> have to also pass ${KBUILD_FLAGS}, which in particular control the
> target word size.
> 
> [...]

Here is the summary with links:
  - [bpf-next] scripts/gen-btf.sh: Fix .btf.o generation when compiling for RISCV
    https://git.kernel.org/bpf/bpf-next/c/600605853f87

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



