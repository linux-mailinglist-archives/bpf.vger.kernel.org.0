Return-Path: <bpf+bounces-47318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5EB9F7B54
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 13:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1176F1893374
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 12:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45280224AEF;
	Thu, 19 Dec 2024 12:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyuqfyu4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6C92248B0;
	Thu, 19 Dec 2024 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611419; cv=none; b=eVpA/cRi4RS9Vnj2JdHgON6AR4VOW7UxyBLT//tsEnTiG7dx8VVnYJ/mq4DoTRmQKkOe+RA3WKb0NH8tCk4MPOlcjlA9Ws70m4cs77ySPcHzYIPK4pfUFXgiNJxRJX292P6HK9c0Iw9bIq9MYwHTLVF4xYTa/OEhbZCn1g+dr3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611419; c=relaxed/simple;
	bh=UI2u7kV9bqp/v4mn+IccDp4Fu/SPmibochW3LeHwkSU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ohnw7s8Y42VhuovCKQMn5ZD33y9VxncY8UNbTVAN50SJQWnBBG0TOM9t8UBr0xXBxy4LNrULj7QKQ0cUrAf4iQkPPnemO4FCmisuqTtra+0ESlwSnvX9i2njiFlEk5OCHHWBtcBnYO51NIYDawbhYR+37JV86wB689qr/tr/NVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyuqfyu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36320C4CED0;
	Thu, 19 Dec 2024 12:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734611416;
	bh=UI2u7kV9bqp/v4mn+IccDp4Fu/SPmibochW3LeHwkSU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uyuqfyu4gUdbt8QJi+cx5fomJBPisxACaMsPL/Sj74PtF/qurU5zD5r33IYgsJx1a
	 sioIGMGPRel9zqwPXx92iwgR3d9RYWZSweOmQM9SaZt7ZL/iM3YjwQTwfKaSZgFejR
	 3k3YfBp0OJuxxU1/T+5B2Bk6p9GDI0cxPJFcvBDq72xTLT/L3VJnyQGfNp1yNesfsc
	 adyxlgGHPuR7nX53On9JFLLsCQzub5X88lg3j3HeKv5XDjCZIJx3cH6/QQHTMIXJVm
	 YKICDAVuk9oDKeyPPA/hcGrYcRzXkFz1PclOpW8ETwDbGzKpO/juj1o+ug5vbO3hZQ
	 s60m8UaruXtyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0906A3806656;
	Thu, 19 Dec 2024 12:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests/bpf: Use asm constraint "m" for LoongArch
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173461143376.2240195.15373574452794250396.git-patchwork-notify@kernel.org>
Date: Thu, 19 Dec 2024 12:30:33 +0000
References: <20241219111506.20643-1-yangtiezhu@loongson.cn>
In-Reply-To: <20241219111506.20643-1-yangtiezhu@loongson.cn>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 nathan@kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 19 Dec 2024 19:15:06 +0800 you wrote:
> Currently, LoongArch LLVM does not support the constraint "o" and no plan
> to support it, it only supports the similar constraint "m", so change the
> constraints from "nor" in the "else" case to arch-specific "nmr" to avoid
> the build error such as "unexpected asm memory constraint" for LoongArch.
> 
> Cc: stable@vger.kernel.org
> Fixes: 630301b0d59d ("selftests/bpf: Add basic USDT selftests")
> Link: https://llvm.org/docs/LangRef.html#supported-constraint-code-list
> Link: https://github.com/llvm/llvm-project/blob/main/llvm/lib/Target/LoongArch/LoongArchISelDAGToDAG.cpp#L172
> Suggested-by: Weining Lu <luweining@loongson.cn>
> Suggested-by: Li Chen <chenli@loongson.cn>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> 
> [...]

Here is the summary with links:
  - [bpf] selftests/bpf: Use asm constraint "m" for LoongArch
    https://git.kernel.org/bpf/bpf/c/29d44cce324d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



