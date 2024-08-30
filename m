Return-Path: <bpf+bounces-38504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05019654B4
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 03:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27A91C21613
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 01:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFAA1D131C;
	Fri, 30 Aug 2024 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="il/p61b0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC0E9474
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724981431; cv=none; b=CdiOxGiYInmh0Sz3H/b07UfvKDDgxvOijwHi6mgmniBxeXg85LbAYFgrdbD1vlDusSoO4tPoXSkOpNWSQCV4mdfTIYFZ2FemK14nZps11PzErAkwj6PgxsWddj7ajx+vCCoFi+/Y5k2+QJg7mqiUEC1WNewnT3R3GC3EjvuxQWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724981431; c=relaxed/simple;
	bh=uW9UH6aYNhAlQzZZ/eo32MG1C3kZd2mB5FF6UlGXgNI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NbwhhwcaRmXleTkaRF1Td2kJ/oFG8EN3wjkZBLUI4Q3jXdJyENyu0wXot7UpBMtJo6jFFl4V+/J6FbVblA/EFjsSqpTcxPaZniaymCTnpMo36kmeFe/idqrxAUBgt7xA+6/t6xMyB7NS0LP2nWhtWswh/zcF1dFQ1VMjb8cw4UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=il/p61b0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D794C4CEC3;
	Fri, 30 Aug 2024 01:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724981430;
	bh=uW9UH6aYNhAlQzZZ/eo32MG1C3kZd2mB5FF6UlGXgNI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=il/p61b0ZVkbfjSeDJl5AmWEeCHlyIrD52NBTGWuH5KogVQx8+5CG2dfcbl+SR3GK
	 DErfNyHInRMvvXkrqHU85xCrcroi40woOPOkgVgs3ao1bqYd/lYnC2l8lMikXm81Gj
	 RQgRKnMNdtW9qT2UShXOBXAp3HkQqtDEpJuFk/tDOEkjGYs9ZJ04bK/Wh1TD1Usz2b
	 vVLXQKSq3Mnh5m7RzSjFRFtrC9+FfURQM+mlhOzlwsNmMRHNRucsLTfUlck0Vql1DG
	 wwq6eQFS/iEj1dsPZPByJZWunJHKjhhXMBN1wSUPxSTvzvM65ZGWju38jmaJnDLDiU
	 58YYNjQdElQzQ==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EF3853822D6A;
	Fri, 30 Aug 2024 01:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 bpf-next 0/9] bpf: Add gen_epilogue to bpf_verifier_ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172498143197.2137024.17719572149097207464.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 01:30:31 +0000
References: <20240829210833.388152-1-martin.lau@linux.dev>
In-Reply-To: <20240829210833.388152-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, yonghong.song@linux.dev,
 ameryhung@gmail.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 29 Aug 2024 14:08:22 -0700 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> This set allows the subsystem to patch codes before BPF_EXIT.
> The verifier ops, .gen_epilogue, is added for this purpose.
> One of the use case will be in the bpf qdisc, the bpf qdisc
> subsystem can ensure the skb->dev is in the correct value.
> The bpf qdisc subsystem can either inline fixing it in the
> epilogue or call another kernel function to handle it (e.g. drop)
> in the epilogue. Another use case could be in bpf_tcp_ca.c to
> enforce snd_cwnd has valid value (e.g. positive value).
> 
> [...]

Here is the summary with links:
  - [v5,bpf-next,1/9] bpf: Move insn_buf[16] to bpf_verifier_env
    https://git.kernel.org/bpf/bpf-next/c/6f606ffd6dd7
  - [v5,bpf-next,2/9] bpf: Adjust BPF_JMP that jumps to the 1st insn of the prologue
    https://git.kernel.org/bpf/bpf-next/c/d5c47719f244
  - [v5,bpf-next,3/9] bpf: Add gen_epilogue to bpf_verifier_ops
    https://git.kernel.org/bpf/bpf-next/c/169c31761c8d
  - [v5,bpf-next,4/9] bpf: Export bpf_base_func_proto
    https://git.kernel.org/bpf/bpf-next/c/866d571e6201
  - [v5,bpf-next,5/9] selftests/bpf: attach struct_ops maps before test prog runs
    https://git.kernel.org/bpf/bpf-next/c/a0dbf6d0b21e
  - [v5,bpf-next,6/9] selftests/bpf: Test gen_prologue and gen_epilogue
    https://git.kernel.org/bpf/bpf-next/c/47e69431b57a
  - [v5,bpf-next,7/9] selftests/bpf: Add tailcall epilogue test
    https://git.kernel.org/bpf/bpf-next/c/b191b0fd7400
  - [v5,bpf-next,8/9] selftests/bpf: A pro/epilogue test when the main prog jumps back to the 1st insn
    https://git.kernel.org/bpf/bpf-next/c/42fdbbde6cf4
  - [v5,bpf-next,9/9] selftests/bpf: Test epilogue patching when the main prog has multiple BPF_EXIT
    https://git.kernel.org/bpf/bpf-next/c/cada0bdcc471

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



