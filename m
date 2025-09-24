Return-Path: <bpf+bounces-69530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A868BB99490
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 12:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 975CD1899358
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 10:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562362DAFBE;
	Wed, 24 Sep 2025 10:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wav+nxcF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C313029E10B;
	Wed, 24 Sep 2025 10:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708009; cv=none; b=BNiMs1X3fe5bYxyzWp9QH3uyjGlcKiVonId0vSx7KOWNz8fykGpyQynqAaGZpW+i+wW2b2wuFDJP3Ber/negyEiMO0u1TAexOqG0oHGJPHka/6+0OlRVyD8QR8/JA7PHIGn9vLITA9BnL+2fPbXMAsDcgOASwqKvJvLK8Dd/K94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708009; c=relaxed/simple;
	bh=ObB4V0Yth9X2nQ51kVtGSbY6xRY07L5XmQ7q0uJ5IUM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GAOwVGvDJFXE4BgUfiYlJzuRX5BVSlwDpS5/huDBQD1MgFFdPvANYOLVN5XQpDcXfi4wmrUIK2wEhz/bMElW9bIj05ncoccCcCmKKALcUeo2rguQRaq235kg6N1uf/GgX/stpG2VtOtXL/imyX+sFi9RPKrntilBlBZBU+/J3/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wav+nxcF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5672AC113CF;
	Wed, 24 Sep 2025 10:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758708009;
	bh=ObB4V0Yth9X2nQ51kVtGSbY6xRY07L5XmQ7q0uJ5IUM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Wav+nxcFrnPfK05UHN8fK+aasWGecsWvs+OzBoCGSm9vStTQJEMPIsqqSH/SbADX7
	 4WafuDnGpYMtVF+D3O3wIfyNu1XLTd+792sTm1j2VoacjIOU63zSXrS60S5UojPsHO
	 9p7PSeITdzciWAzmEViGER1oqoiP6BiaycsDasdM9IiCRelL68B9DqgcBfAT8HZ1vR
	 7rhkEPCOoLCJtu+PI8ORZ5eDpl2Tq8PHBCLIhnZDJSL/MPYgMYFC2oeH5dnSifFzm4
	 NvxJldcZJkW4KsJPlC/BNq7Uz7mPFA1XbkTYEpILl7IcdylnuKNz3/TLORZeGlYGG7
	 OeXsx2Mh5/72g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CE739D0C20;
	Wed, 24 Sep 2025 10:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] bpf: Mark kfuncs as __noclone
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175870800601.2118298.17627237253886547261.git-patchwork-notify@kernel.org>
Date: Wed, 24 Sep 2025 10:00:06 +0000
References: <20250924081426.156934-1-arighi@nvidia.com>
In-Reply-To: <20250924081426.156934-1-arighi@nvidia.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, void@manifault.com,
 alan.maguire@oracle.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 24 Sep 2025 10:14:26 +0200 you wrote:
> Some distributions (e.g., CachyOS) support building the kernel with -O3,
> but doing so may break kfuncs, resulting in their symbols not being
> properly exported.
> 
> In fact, with gcc -O3, some kfuncs may be optimized away despite being
> annotated as noinline. This happens because gcc can still clone the
> function during IPA optimizations, e.g., by duplicating or inlining it
> into callers, and then dropping the standalone symbol. This breaks BTF
> ID resolution since resolve_btfids relies on the presence of a global
> symbol for each kfunc.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] bpf: Mark kfuncs as __noclone
    https://git.kernel.org/bpf/bpf-next/c/d4680a11e14c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



