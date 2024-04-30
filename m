Return-Path: <bpf+bounces-28220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6F98B66AA
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 02:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A1741F231E9
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 00:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7578438C;
	Tue, 30 Apr 2024 00:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecqz9vCZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5DD161
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714435231; cv=none; b=KAf2vuB5ivEAI7lCgVjaRgUqQwexyoC+58PxeG8vht8Vk0olKlL086AG8vWfHQwVfOzMayyx2qzbM91J7CDXWiF1HWvecJZ2zhUYD5wWdC4TH0IFg+E00xxpoubMfKt6LHYXx3pVnrY637uqwDJyXVIXTUtH9K37EP+MeI6QD/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714435231; c=relaxed/simple;
	bh=zzwYjj6CugGSwnyHeFq80JNtyEf+u9i1piqjXcz65k8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U9sSyILkBZar0xq8EkMm0R57YtMbSQKGCcS7U/bgdy/EcS+x18uO5ZI2bcYPQgdfMQQXBHJVSpW/9yU+Cspq0uMNZcayA9OadMEwPC4frVaUUx5v0nu5TGzNlSZk5L9RfER0NB1Cn5LnTlcsLkcs48OmWNfb1Zo6Pl5gbZ/iZUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecqz9vCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81538C116B1;
	Tue, 30 Apr 2024 00:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714435230;
	bh=zzwYjj6CugGSwnyHeFq80JNtyEf+u9i1piqjXcz65k8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ecqz9vCZSn4StzhGm8ZlgVtsJAoCPf0m4lvhscdUaSxWNM2dqkRp7VDsVftg95wO+
	 E3fEK3V1bueRAFTlKnT9BvNu90xpwIrk8Zb6u+V9F06m1J1xzmztWGRrmjTBIDQ9+0
	 OSTAtADCdA4R/WJvCnvN37RZVqEzpKjpIj5Xxqmz74ezZ/y8gmdBV1ysh64Cj27zUx
	 VdpWr2kK8cNvKZPDVTR8tdYMBwJ/DsVAmcqxngujvrEP0ARYQVkzq2eokVAaXySJdS
	 09OuVD8gzl2GhGXmnse/TMR7BOIKD0ovCPeZmncan8KPpNT5rod4ejZiqntlFwc1gU
	 YifHCwd9QZJ3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 710A3C54BA4;
	Tue, 30 Apr 2024 00:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] libbpf: handle nulled-out program in struct_ops
 correctly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171443523045.23001.15781385933394286282.git-patchwork-notify@kernel.org>
Date: Tue, 30 Apr 2024 00:00:30 +0000
References: <20240428030954.3918764-1-andrii@kernel.org>
In-Reply-To: <20240428030954.3918764-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Sat, 27 Apr 2024 20:09:53 -0700 you wrote:
> If struct_ops has one of program callbacks set declaratively and host
> kernel is old and doesn't support this callback, libbpf will allow to
> load such struct_ops as long as that callback was explicitly nulled-out
> (presumably through skeleton). This is all working correctly, except we
> won't reset corresponding program slot to NULL before bailing out, which
> will lead to libbpf not detecting that BPF program has to be not
> auto-loaded. Fix this by unconditionally resetting corresponding program
> slot to NULL.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] libbpf: handle nulled-out program in struct_ops correctly
    https://git.kernel.org/bpf/bpf-next/c/f973fccd43d3
  - [bpf-next,2/2] selftests/bpf: validate nulled-out struct_ops program is handled properly
    https://git.kernel.org/bpf/bpf-next/c/1bba3b3d373d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



