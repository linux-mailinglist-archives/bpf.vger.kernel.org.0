Return-Path: <bpf+bounces-29611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AF48C397D
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 02:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14F41F213B2
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 00:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE585A0F8;
	Mon, 13 May 2024 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNezXcoA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0A12AD1C;
	Mon, 13 May 2024 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715558430; cv=none; b=RolrzGK/n75+XhFtHi1eo5xFu8gUUPTy+5IT5fiJjNTTRnXUjfIlEYZ4QAncEaLGx8vMvoJUNkSRD1xQU6DLSJi6gt2tU0jTXP7KeiXI/D0UbBF84gso7DdcdlfQgZpykMTfHRFaNdnu2tTjORAtbn2TgATEM0RYU0RuVJ+KYmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715558430; c=relaxed/simple;
	bh=DiRTuxx7jNsBtxssJVhLLs4f7CaGC42GVb0//KHi0+Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oJB+2VGPCXRPL9pT0KVtgpTg3PHIpSAG0ZtUIP1UHDAUrb4U6N+g+gzB1AhU5hK07dVo3iZEvzb5pHHnecobm5nmNXNQHj12w65Vdumw6SQapKmHjf3Id+BPH7FE0OHtnW1L45vPJVYCHIqZRL3s1OkWXYkvIt9jjxptabkv9p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNezXcoA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BAA6C4AF68;
	Mon, 13 May 2024 00:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715558430;
	bh=DiRTuxx7jNsBtxssJVhLLs4f7CaGC42GVb0//KHi0+Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DNezXcoAnZJoDgMjJrPT+jgW4KILzJjpEM9I1RtcUGJaYC+xaKT3GH36QU49ZGauM
	 D6GRY1JhP+lgWjY13ekzLROJQGQrwGpEYG23kSIO8rhVWMFQE85a466uE05fLHh+M0
	 tpUuyxGA90OFXWrZFO6j7SgBHVtj6YySFLgDqa3TckzZcOaOevrl+vCbSmJDS0NG5d
	 dl63CnVVAKaINqsr29kIpxYjbVO8qhLjd1Qmngtjb0gnklBRcPrZnURQKQ+L/9Fs6Y
	 FAn2A7ehdYOaabu2DvDuJ82ZGekpsU0ht20RCfMszzsB+ComXlYHlqrgRkVT7v1mJF
	 xQ0Gps4GxHOyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EB394C43336;
	Mon, 13 May 2024 00:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv, bpf: Fix typo in comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171555842995.18024.4820208884159276915.git-patchwork-notify@kernel.org>
Date: Mon, 13 May 2024 00:00:29 +0000
References: <20240507111618.437121-1-xiao.w.wang@intel.com>
In-Reply-To: <20240507111618.437121-1-xiao.w.wang@intel.com>
To: Xiao Wang <xiao.w.wang@intel.com>
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
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  7 May 2024 19:16:18 +0800 you wrote:
> We can use either "instruction" or "insn" in the comment.
> 
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> ---
>  arch/riscv/net/bpf_jit.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - riscv, bpf: Fix typo in comment
    https://git.kernel.org/bpf/bpf-next/c/80c5a07ae673

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



