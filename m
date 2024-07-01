Return-Path: <bpf+bounces-33503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF3591E3E8
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 17:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3590D281ECD
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 15:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFFA16CD3A;
	Mon,  1 Jul 2024 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7Hbbd1v"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287362576F;
	Mon,  1 Jul 2024 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847232; cv=none; b=CBjPpIFVMk9pD9d/D3A8N6LVxOLGdgACDVPZ2pT1ntplCrRLhYHxhoXK8qMPksUOFAmgYRxafjK+tMC7o3wRVrY+oyfW8rV8Z04OEMhlgMvMHc/6H5cLp3t40X8c1wbuMJUivru/PEa9uKd8Whis2mGJhelnEy6R56B3ExqMK/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847232; c=relaxed/simple;
	bh=wxYu3zIRsXfA4tN7GBGojXy29esfx9y9v7Vqne4vjRI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DXLqnRNkvgWZxyp17gu4aBr1OD8HOGCjrDNVJhc+QFSpNARL0mc6KkE4I4DANVE6E7qbhTv+N5RZTHRWwv9OZlpgCV2wi6UT/dynNxMUIazhRL+u7bwMQ69nZKNvaQSVo1KnR5GjtLHyjzAt7Zr8Zoh6oh0xAOf5fiXgx7hen9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7Hbbd1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 918D4C2BD10;
	Mon,  1 Jul 2024 15:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719847230;
	bh=wxYu3zIRsXfA4tN7GBGojXy29esfx9y9v7Vqne4vjRI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S7Hbbd1vhwHZKa9YqOoZSUlJFWJpgZPDu1al4RUr/qVgCCC05hGixcBxq1qU+Xvr3
	 f0FNf1IXL8LLVTNy9HOky1GbeQ99L0NzD6ZtVO+vPyvk/+n4lmNhBhgkM6Ed2xn+Y9
	 QzpgIgDVGClgh5LEHyHA6fvw0fNZQsGfW8heJ2uwD0v7zBdfIh7dPB3Tj2CBf91Bkj
	 xgtKYtD7paXl7kh+QqkTLiR5hF/eRDqXsc6jtPZwvRrFuZ0OSc89/P2jcC1z3vHXSl
	 VhRIFsT3UGHDNnns5g7Xj8fSuYzS8KrG9l+qGAxBW3CPlzAfmlyc73fGTA2ErTjzLj
	 Q6spRSFMLybjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E2E6C43468;
	Mon,  1 Jul 2024 15:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND bpf-next v2 0/3] Use bpf_prog_pack for RV64 bpf
 trampoline
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171984723051.1282.8352301752535739343.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jul 2024 15:20:30 +0000
References: <20240622030437.3973492-1-pulehui@huaweicloud.com>
In-Reply-To: <20240622030437.3973492-1-pulehui@huaweicloud.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 netdev@vger.kernel.org, bjorn@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 puranjay@kernel.org, palmer@dabbelt.com, pulehui@huawei.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat, 22 Jun 2024 03:04:34 +0000 you wrote:
> We used bpf_prog_pack to aggregate bpf programs into huge page to
> relieve the iTLB pressure on the system. We can apply it to bpf
> trampoline, as Song had been implemented it in core and x86 [0]. This
> patch is going to use bpf_prog_pack to RV64 bpf trampoline. Since Song
> and Puranjay have done a lot of work for bpf_prog_pack on RV64,
> implementing this function will be easy. But one thing to mention is
> that emit_call in RV64 will generate the maximum number of instructions
> during dry run, but during real patching it may be optimized to 1
> instruction due to distance. This is no problem as it does not overflow
> the allocated RO image.
> 
> [...]

Here is the summary with links:
  - [RESEND,bpf-next,v2,1/3] bpf: Use precise image size for struct_ops trampoline
    https://git.kernel.org/bpf/bpf-next/c/d1a426171d76
  - [RESEND,bpf-next,v2,2/3] riscv, bpf: Fix out-of-bounds issue when preparing trampoline image
    https://git.kernel.org/bpf/bpf-next/c/9f1e16fb1fc9
  - [RESEND,bpf-next,v2,3/3] riscv, bpf: Use bpf_prog_pack for RV64 bpf trampoline
    https://git.kernel.org/bpf/bpf-next/c/2382a405c581

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



