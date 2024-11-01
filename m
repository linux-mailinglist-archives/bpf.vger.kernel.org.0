Return-Path: <bpf+bounces-43773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 429139B98D5
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 20:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD896B21F6F
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 19:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6801D0DE8;
	Fri,  1 Nov 2024 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyzV6P0o"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8797F1CEAB5
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 19:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730490024; cv=none; b=OIiAe1iV9+92f2dWzog6Z+uXzCEpWYBuEQY0d4pNVnYR/yJEO2MxVKdimbC4X57zlbtzvpJi4/6OI+5opF8tdM/A4YLFHT8weew63yTXRlc/QKG8Riqk/LJVjwPV3yjXhZDk9UFOLLI3hlePVxSsfV29gWswwzSAxzMTAJOd4Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730490024; c=relaxed/simple;
	bh=BFuKXMuP1srUfWrUu4n+CjeB6aoD6lmk9WallWDasxM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D3t9fJByU0BMGe2yElrFU2u0eV5/U4WxZLoTghy6cZ6+rBernxobfx/wY02dfaH/moCQsYJDcQiiBxoCt3jBje83QVY8MMOpBFnee5GVPpjQjhKG8tIe+SVEyELSbtA3jFOYDVMKd7k4z5fkZwSLxQRdKJilgm6zY8euyQ895mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyzV6P0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53156C4CECD;
	Fri,  1 Nov 2024 19:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730490024;
	bh=BFuKXMuP1srUfWrUu4n+CjeB6aoD6lmk9WallWDasxM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qyzV6P0orrxOE/TrWUH+utQxF5TgHM6liLncciLO/mtS55T6xiN1vJ02iEPnQf7Jo
	 aRem3AvLAlWjCDrYbr2AKgqbXwK/xhilrbTtt3YXOBqyvAm818Vk4Md41AzvvlhOEF
	 dpW9427jkjXW4eI73wXIxCcx1GsZksjVsiHJHKeaqeaz5pDmXXUMUkzQOqaiSF8a0k
	 pZfY6WEP/4NugHg875SRGhALUwkQqiykVUnspBldSnXg/KMfsSU0JiwVbQAzn2Ku7n
	 kw/LTBZtXAscl0KUwMsxepjTMg9JOR+h4VEH3fhF1PpEdRpdr0ByxtQ1lLFFmTJHGP
	 n95mGu3lO4ZsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC5A3AB8A94;
	Fri,  1 Nov 2024 19:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3] bpf, bpftool: Fix incorrect disasm pc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173049003251.2825729.1460364100521447911.git-patchwork-notify@kernel.org>
Date: Fri, 01 Nov 2024 19:40:32 +0000
References: <20241031152844.68817-1-leon.hwang@linux.dev>
In-Reply-To: <20241031152844.68817-1-leon.hwang@linux.dev>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, yonghong.song@linux.dev, gray.liang@isovalent.com,
 stfomichev@gmail.com, kernel-patches-bot@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 31 Oct 2024 23:28:44 +0800 you wrote:
> This patch addresses the bpftool issue "Wrong callq address displayed"[0].
> 
> The issue stemmed from an incorrect program counter (PC) value used during
> disassembly with LLVM or libbfd.
> 
> For LLVM: The PC argument must represent the actual address in the kernel
> to compute the correct relative address.
> 
> [...]

Here is the summary with links:
  - [bpf,v3] bpf, bpftool: Fix incorrect disasm pc
    https://git.kernel.org/bpf/bpf-next/c/4d99e509c161

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



