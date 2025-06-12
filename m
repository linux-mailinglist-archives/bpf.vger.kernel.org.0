Return-Path: <bpf+bounces-60544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD63AD7EAD
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 01:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2A123A1411
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 23:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F4623771C;
	Thu, 12 Jun 2025 23:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BViO+HbS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC13153BD9
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 23:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749769200; cv=none; b=c6Pgv2S33bXxgPiuG62GNp4Auk/+QGVVFzj3Ed3hFDKCHJodUFr7B1fkN8nlBWPGONt4lr8/YeW8AqzMsk+r6vKmFcuXP2CJtipgWMH0F1+8IZYDd8L2LWXeNs9RheorgZt+P7PqhJ9HeYJjcIdixqED9nHGDUThXTy6EMEAbl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749769200; c=relaxed/simple;
	bh=8uQnFWuA2oLAFOwo+jDbf6oLHIg3h+bSb+Hha1OW+1c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SGV57M2E0gfQ9bbgPNQDFdE9Z3J111xaDzEJcJpFcnnUub901uWp7o/ej/wPN9OEYzH6l4lnCQ3SWUVa4guBxY+3Xfa39SRnH0OQw9zuyB4ZN09+c670YDFNknDjFR0hpUAy1FzofYFK1MgEfn6upKHDHu01lC3ULTJu5ZW35/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BViO+HbS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF60C4CEEA;
	Thu, 12 Jun 2025 23:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749769200;
	bh=8uQnFWuA2oLAFOwo+jDbf6oLHIg3h+bSb+Hha1OW+1c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BViO+HbSPdVveaPFCg4Evxgq/08jZMB6cCwl0CYN7IfGjS8Ry4xLWQjV2ejyz4YVB
	 DeCff5DNn3Z7xhRjE4F/5JxSQ4vIa7qfWwNJFMUL/9vRAZjtpmd7ACx5YugUCSZZPa
	 nCELL1tjsNdwPr2Aox24dD19D14me52yG60ZQ4fFLtM3ZlazF1OQxUszTc5Hb0Z4E3
	 3nkm9ebRO/2CrdZT25fqcsEiyGXVrcCUhrUOtOvHaxPiUvLcWS1Ausrs2ckYFLERC+
	 cgKsf2oovhCb9qxMlKfnfCQlfVZ4vsBmAWX22nCrEClHz2GdfZPnKacHaipdx4psIk
	 LhmPhayAfj/+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BCA3822D43;
	Thu, 12 Jun 2025 23:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Initialize "tmp" in propagate_liveness
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174976923000.142766.15978253610413967881.git-patchwork-notify@kernel.org>
Date: Thu, 12 Jun 2025 23:00:30 +0000
References: <20250612221100.2153401-1-song@kernel.org>
In-Reply-To: <20250612221100.2153401-1-song@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, kernel-team@meta.com, andrii@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 12 Jun 2025 15:11:00 -0700 you wrote:
> With input changed == NULL, a local variable is used for "changed".
> Initialize tmp properly, so that it can be used in the following:
>    *changed |= err > 0;
> 
> Otherwise, UBSAN will complain:
> 
> UBSAN: invalid-load in kernel/bpf/verifier.c:18924:4
> load of value <some random value> is not a valid value for type '_Bool'
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Initialize "tmp" in propagate_liveness
    https://git.kernel.org/bpf/bpf-next/c/de7904f603a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



