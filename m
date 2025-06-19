Return-Path: <bpf+bounces-61100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76667AE0B99
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 18:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2F7A7A16FE
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 16:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F4228C84B;
	Thu, 19 Jun 2025 16:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXeDNCIK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261C028C2B2;
	Thu, 19 Jun 2025 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750352381; cv=none; b=SXqyK6OSKpuJES3LNt082cuhd59UFfBEmkZpx5F+v3CImqd9KNhrp9sVeI+HCnDyva0TcNDPIIVCwQiMsHh3Dt/MaDHjO8L+vfMBv+lIEGNpxrgkRVxHwfvzUam7ch+EHZNFy5y1ALugZAvU4w1NRAcUO/LnrMXPHOTUg6GIx6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750352381; c=relaxed/simple;
	bh=3sefG8/vtnmM4Y1Up4QxPE41PMrinJ5aNw+R4DyddVM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Yir2/1WMZV0QhVMeuwNMto9I70yFLLHNACa29vyxyGDK0mkujkTEYuhI7BUpsEmfRDYLQ7gqE50JsF09Lf6DpxOVUzBc8oIgbL/P7SDbrqSHs45GMvO13uvzE+GyDKN8WF5zijqNr2tI4U3IoQKwbC82qnjnuySYq1UbXmginew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXeDNCIK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C3DC4CEED;
	Thu, 19 Jun 2025 16:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750352380;
	bh=3sefG8/vtnmM4Y1Up4QxPE41PMrinJ5aNw+R4DyddVM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pXeDNCIKdx455YyLs3gYFYaPJ/ebRE3aH4+hSK1Y8PR3bJBKpjEWfap7jTsepnA7G
	 1WJrbtv2Qgs4tol2mUApEgP04KwWwKyR2jMkk90L+eE7KjoLjvsUqOwoAOHz/jtVix
	 Oi3emfUa4mM9HCxVoodwPFU65o9K+5oC14/Pw/GvodcDokSaYMBnH6doiP/ynAReQY
	 MeDMaidaA4caD/v3ThpXW2lTkwlck8vpyeoYOL18Q9w+81yDbZf+3i/T9g8h0QlFHf
	 tPKhSOpvRHnFVv9UWtf8kbfvMb4emRoxI4A+GNoZzE7Kva5tlWO0ES+iVp8E3g09Sj
	 8fSa9JkCx1BjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF5138111DD;
	Thu, 19 Jun 2025 17:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] powerpc/bpf: Fix warning for unused
 ori31_emitted
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175035240860.927642.9498689393888953478.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 17:00:08 +0000
References: <20250619142647.2157017-1-luis.gerhorst@fau.de>
In-Reply-To: <20250619142647.2157017-1-luis.gerhorst@fau.de>
To: Luis Gerhorst <luis.gerhorst@fau.de>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, hbathini@linux.ibm.com,
 christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, lkp@intel.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 19 Jun 2025 16:26:47 +0200 you wrote:
> Without this, the compiler (clang21) might emit a warning under W=1
> because the variable ori31_emitted is set but never used if
> CONFIG_PPC_BOOK3S_64=n.
> 
> Without this patch:
> 
> $ make -j $(nproc) W=1 ARCH=powerpc SHELL=/bin/bash arch/powerpc/net
>   [...]
>   CC      arch/powerpc/net/bpf_jit_comp.o
>   CC      arch/powerpc/net/bpf_jit_comp64.o
> ../arch/powerpc/net/bpf_jit_comp64.c: In function 'bpf_jit_build_body':
> ../arch/powerpc/net/bpf_jit_comp64.c:417:28: warning: variable 'ori31_emitted' set but not used [-Wunused-but-set-variable]
>   417 |         bool sync_emitted, ori31_emitted;
>       |                            ^~~~~~~~~~~~~
>   AR      arch/powerpc/net/built-in.a
> 
> [...]

Here is the summary with links:
  - [bpf-next] powerpc/bpf: Fix warning for unused ori31_emitted
    https://git.kernel.org/bpf/bpf-next/c/e30329b8a647

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



