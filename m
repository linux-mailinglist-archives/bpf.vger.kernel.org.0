Return-Path: <bpf+bounces-28398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 418A08B90BA
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 22:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 935F2B21D37
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 20:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1651E165FB5;
	Wed,  1 May 2024 20:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rysqtL/L"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889EC165FA0;
	Wed,  1 May 2024 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714596032; cv=none; b=Y1QQwPqzhE0b6hCltXUHR34Hg5AzBU42eX2rWoaTTOUV/cNOqDwlLVWZza3QFhA2NsyylNtM003BeYeiy4aLYAWuEoN2nxhLPZL8hcCEJxQE+1PmUltAhG0+B0oAj90XQYL/m+csXIpva4aJ79VU8vg08lPbnnbzmVtd4ss5JV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714596032; c=relaxed/simple;
	bh=WLfpkoMH/TRe/cJZHLLB+vpQaJU9kPr3Z1605OXVCuc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FcTi6NSAeFRu9J6Rfyy8wxnQwK5qkHJnXZDXLrwIQozsNs6Phk7Lxk0zvyfxcPFHPgwxZbkBr7HB0OmYVOT45nOAtzKnx2QnTbGq9nagwPr6BPf7V5Z8Z88q7mTmpBtAxMYQvVswenTLS+3D57eEqbabn/bfSatHKnxVfGMfGB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rysqtL/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13C26C4AF1A;
	Wed,  1 May 2024 20:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714596032;
	bh=WLfpkoMH/TRe/cJZHLLB+vpQaJU9kPr3Z1605OXVCuc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rysqtL/LVK9n5ZotTGAz+jFuiks8ouuC4LIljCVpd5Jo8HXD9ovat9Eg9FU1YgA8E
	 JxIPPIxijoFx6lttfbPFctja3iaiFGA0QgoXX8WMEkCEs4UKuH7ejCzwliwBTlijvM
	 V8fFuNXd0TK1OOz9plbr2y5/I9Yi3eIyvIwa9YEi8hMStAxGJlgqMf34flGxPHYYKG
	 GQHB8C2PDBBF+tsZU/hNS4gaL8beW3q/fv9Rr7JBVXKSZ3pia0H3Cq68pH9NgzuhOG
	 /ECdmWTd3/744GeLaGId0fWBIGmb6nAZBXQzgFPuZ7ru2B4btYTUX2Tuk52sn+DfKM
	 w9JfBOHIxk+IA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F34DEC433A2;
	Wed,  1 May 2024 20:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: crypto: fix build when CONFIG_CRYPTO=m
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171459603198.27515.15117026972576302125.git-patchwork-notify@kernel.org>
Date: Wed, 01 May 2024 20:40:31 +0000
References: <20240501170130.1682309-1-vadfed@meta.com>
In-Reply-To: <20240501170130.1682309-1-vadfed@meta.com>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: vadim.fedorenko@linux.dev, kuba@kernel.org, martin.lau@linux.dev,
 andrii@kernel.org, ast@kernel.org, mykolal@fb.com,
 herbert@gondor.apana.org.au, netdev@vger.kernel.org,
 linux-crypto@vger.kernel.org, bpf@vger.kernel.org, lkp@intel.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 1 May 2024 10:01:30 -0700 you wrote:
> Crypto subsytem can be build as a module. In this case we still have to
> build BPF crypto framework otherwise the build will fail.
> 
> Fixes: 3e1c6f35409f ("bpf: make common crypto API for TC/XDP programs")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202405011634.4JK40epY-lkp@intel.com/
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: crypto: fix build when CONFIG_CRYPTO=m
    https://git.kernel.org/bpf/bpf-next/c/ac2f438c2a85

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



