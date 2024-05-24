Return-Path: <bpf+bounces-30499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8ED8CE790
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 17:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1DE1C21BC3
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 15:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323DF12D218;
	Fri, 24 May 2024 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6kAgCHS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A9F12D1EB;
	Fri, 24 May 2024 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716563430; cv=none; b=qkClVnH4Gd04YPfZUuQInKp5kNgASELD4Dq6k45KSksuzAB+i41Qc3U0mxTFbjxqTHSZfpPPUednmNBql+9fEqlTckVwVE4WmuTVfS6+gI1yXdqCsfUkPynewM0KYzBuQaUJ5kdu2w31amU69mGIrTyr6eT+PpIIcsAAdIXl2eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716563430; c=relaxed/simple;
	bh=n2nVq9uBRW/+tTHmYejkkxsXh3ZAk1u/RyQ33umea+M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cNQBFqdmhbx2C2qAbdfrX5TCa7Rtn/nZqY5YjmZF0E0EhNOm1+M5TlY5VCTtVDqtU8kEjVZ0u17NLGATFQwPtdCb13h8dC+fQ9QOHB5/sYgin+/U4Y3GQyfdvGCgeC3h40X028VjLbnikPKNkeRvH93JlBvQNNFT0MxnQ0oQD0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6kAgCHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61C6EC2BD11;
	Fri, 24 May 2024 15:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716563430;
	bh=n2nVq9uBRW/+tTHmYejkkxsXh3ZAk1u/RyQ33umea+M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c6kAgCHSjKzIy7bgO9Eg9w8pt9KP5pQYhw3CasZlpQzHX9Egpby2xNCKmcpUNjNuA
	 yxBWENANqY43kFmgODCQVri6zQhGxLpIw/U2QF7olGpauTXD1ME3TQl110h3F0m8CX
	 EELATZmmNoqb/2hMhjlaK3tq5q3msfmGoah4xrws5t/fLrry1nF+djiAKdbdiLR6/m
	 Z6M79A8cbzf8LXqaM4NAMwMWhnjLYzukEgVHM4wBU3FpatuN0VmYOl621U4wTkcUb7
	 M1WhxWWoH43rEXNDPIbqZ8Rs/h1XFn7xi4+KM+Q15bCm2OWrqqNp2EG7YHW0Jw+XNK
	 8u3wM+FmxqFqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 49CCBC4332E;
	Fri, 24 May 2024 15:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] riscv, bpf: Optimize zextw insn with Zba extension
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171656343029.3209.10149460674522827250.git-patchwork-notify@kernel.org>
Date: Fri, 24 May 2024 15:10:30 +0000
References: <20240516090430.493122-1-xiao.w.wang@intel.com>
In-Reply-To: <20240516090430.493122-1-xiao.w.wang@intel.com>
To: Wang@codeaurora.org, Xiao W <xiao.w.wang@intel.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 luke.r.nels@gmail.com, xi.wang@gmail.com, bjorn@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, pulehui@huawei.com,
 haicheng.li@intel.com, conor@kernel.org, ben.dooks@codethink.co.uk,
 ajones@ventanamicro.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 16 May 2024 17:04:30 +0800 you wrote:
> The Zba extension provides add.uw insn which can be used to implement
> zext.w with rs2 set as ZERO.
> 
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> ---
> v3:
> * Remove the Kconfig dependencies on TOOLCHAIN_HAS_ZBA and
>   RISCV_ALTERNATIVE. (Andrew)
> v2:
> * Add Zba description in the Kconfig. (Lehui)
> * Reword the Kconfig help message to make it clearer. (Conor)
> 
> [...]

Here is the summary with links:
  - [v3] riscv, bpf: Optimize zextw insn with Zba extension
    https://git.kernel.org/bpf/bpf-next/c/c12603e76ef6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



