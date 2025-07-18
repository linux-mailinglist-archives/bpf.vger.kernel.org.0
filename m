Return-Path: <bpf+bounces-63739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9A6B0A7D4
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 17:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B39A8424B
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 15:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B802DFA29;
	Fri, 18 Jul 2025 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NB7wQ72Z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D48D2DFA24;
	Fri, 18 Jul 2025 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752853187; cv=none; b=Iet4nvuoxQXrUcXHOksuvm0P+8iP1H58eR2KTaFV8b5u2644yebFq+OS6I1lgDAh+vm0iRjLsVL5q4OcyTUPNlT/MsUKQKVzihTTF9zaNoBiT+UKtjdp955cPq4u2gJ1ycVy7RXVs2OBs8RvgwR0CvrcFGsVaI0TAEVj+ibgLS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752853187; c=relaxed/simple;
	bh=eHA0H0ZU7L8ygGlTVLTGPDEbDmfk3M/hioSYJC/nwPI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Mc++UuRZGKSzXabh1jZy6SzeXFnb9YlwRo4AAR84OhMY8z0LlSZmqsHQlnYOSXpdDJv9uIfaOlSMv0ya7RZfa1hcuTLGKSC6ycEy357zwZeDlD92AQzPFHo7rDpDJoKNYP+5sC9nOmclTJdCHgVaPoPvoMSLPnvi34sAIlJWmlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NB7wQ72Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82857C4CEEB;
	Fri, 18 Jul 2025 15:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752853186;
	bh=eHA0H0ZU7L8ygGlTVLTGPDEbDmfk3M/hioSYJC/nwPI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NB7wQ72ZL2/g2O3M8FGyvfcKAWm3e/i97fckcMGYSVJHWcRY80rMT/r9Vcq+z31Ye
	 +fYgVg5BX12a/reqLSlmeCfJeP9dlmn15B7A4gZAzal1kUikso1DuXemWPFtJu1i76
	 bOX0lOK706BuvB7x5NURTWcjZvFFoIcVaq/qAB2/51YEAUWYnlOU6BV0QMKg4hbylN
	 hAuj1NCPxvRfMZz7acLGIXRcsjEYM1s8U54jGQcn9fz13ayDtBd7iDH56NTulpoHrp
	 aKtkmRpgWBt1Nx8jRVm/5hV0EOhGgmgiLvRW4ebpgg7DpXu99SsIHzKKvuxf/22dEH
	 pLcfm/rI19uLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B86383BA3C;
	Fri, 18 Jul 2025 15:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: fix warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175285320626.2706765.18311882177801047852.git-patchwork-notify@kernel.org>
Date: Fri, 18 Jul 2025 15:40:06 +0000
References: <20250717200337.49168-1-technoboy85@gmail.com>
In-Reply-To: <20250717200337.49168-1-technoboy85@gmail.com>
To: Matteo Croce <technoboy85@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, teknoraver@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 17 Jul 2025 22:03:37 +0200 you wrote:
> From: Matteo Croce <teknoraver@meta.com>
> 
> When compiling libbpf with some compilers, this warning is triggered:
> 
> libbpf.c: In function ‘bpf_object__gen_loader’:
> libbpf.c:9209:28: error: ‘calloc’ sizes specified with ‘sizeof’ in the earlier argument and not in the later argument [-Werror=calloc-transposed-args]
>  9209 |         gen = calloc(sizeof(*gen), 1);
>       |                            ^
> libbpf.c:9209:28: note: earlier argument should specify number of elements, later size of each element
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: fix warning
    https://git.kernel.org/bpf/bpf-next/c/0ee30d937c14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



