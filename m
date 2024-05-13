Return-Path: <bpf+bounces-29609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2618C397B
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 02:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1AF1F21315
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 00:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE5E59154;
	Mon, 13 May 2024 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzAXZuL2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1292A1AA;
	Mon, 13 May 2024 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715558430; cv=none; b=kPpvEucJGfTjkE/woLD/Cq+GGv+E/NihGPUTF/D6FW/Oz/LEd+9pOzfpnXTAHne1pSfL86oJ/g5nQT3Tv93ibIiLd0pzxuu9zzPJ+/WeDqF3KAxtlCqEQiWEcI4nMclgfPdE8DcF3geooHOpJrgCX8xTtsasooyJXp7q2FT0rqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715558430; c=relaxed/simple;
	bh=e2NpOR2CweEKvqvlaEK0pm/6D2en3jgIpSgJ46eRceA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WH/O8K2C454s0D4mR8+gqcJ4SXzh8xL8znqMuxbVkW+njNbLRk09uGFFufEf2101fWSuI49FUY5xELmHPfJeF+c4ci8QXkAWTdxLsRyeT9fGMpXd9ns2+zrSHPvUx0CJHmuTpp8t1gRtAl4qcJC01ccUz3rUbpZJvPFgVSZN9vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzAXZuL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD42FC4AF08;
	Mon, 13 May 2024 00:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715558429;
	bh=e2NpOR2CweEKvqvlaEK0pm/6D2en3jgIpSgJ46eRceA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YzAXZuL24mQqZ0qK+/OMp07ToKUNqmOycs4b2wBwgP7vFX80wU8v2wXxnQRnH2Sj4
	 e45QZoxmPPjHGl5GwA+KAICSLYQVPKKfG22iKb2qBt/VTRs+ybs3O19PMCYinRzFeG
	 LuAruWUGwELm28J/rVCEAcFioBIV/iTGL3iyurJSVGSl7n2lEetRQE7T0rtWPSgcwu
	 z/prxpV4gNm3PtKqD6rONtXOXpJ9w64BBt9ilE80dCX2HeOJQxVhkYYEVGuB2iDXbm
	 QofhHKbCDcASOT8eSd2NEI4AAy765DtUJz80wRTBOdP1YWraBs9YeL4ACmrBLza+KZ
	 kSyrtKPuQ4Cyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBEF1C43444;
	Mon, 13 May 2024 00:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] riscv, bpf: make some atomic operations fully ordered
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171555842976.18024.13752863594876761911.git-patchwork-notify@kernel.org>
Date: Mon, 13 May 2024 00:00:29 +0000
References: <20240505201633.123115-1-puranjay@kernel.org>
In-Reply-To: <20240505201633.123115-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bjorn@kernel.org,
 pulehui@huawei.com, paulmck@kernel.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 puranjay12@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun,  5 May 2024 20:16:33 +0000 you wrote:
> The BPF atomic operations with the BPF_FETCH modifier along with
> BPF_XCHG and BPF_CMPXCHG are fully ordered but the RISC-V JIT implements
> all atomic operations except BPF_CMPXCHG with relaxed ordering.
> 
> Section 8.1 of the "The RISC-V Instruction Set Manual Volume I:
> Unprivileged ISA" [1], titled, "Specifying Ordering of Atomic
> Instructions" says:
> 
> [...]

Here is the summary with links:
  - [bpf] riscv, bpf: make some atomic operations fully ordered
    https://git.kernel.org/bpf/bpf-next/c/20a759df3bba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



