Return-Path: <bpf+bounces-76396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C16CB2397
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 08:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B07030CB008
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 07:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A31E22578D;
	Wed, 10 Dec 2025 07:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfKYm/Iq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC3227380A;
	Wed, 10 Dec 2025 07:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765351993; cv=none; b=H0xXbQjiaVeHxOCZrUICGGHcjyBPrLx8d3rwPm00hczRlptwlt5mclXXHMh+nO/5hPNusnomMAhS2iY22Ks+Na2HxWJAMxg2dK/e4cIMBkbZiFRKi4hQeFkHeS4/88MObAbFAenCdylTetSSkvx/KynSSkhGAD4Mg2qGhrovv0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765351993; c=relaxed/simple;
	bh=4N/IsyF2wkHWFuX49UOWgzr/gEzl5vEuFGz3ZXffjEQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JRGvXqfelHsjZKsbXQK4tJud2oPfFcUweX5QGTxbmVU2WIseUzTIzeJNOmOuDYOInJyGb31MvYMuJmPGhmlXKjBAmYOBAlAGt7fYzGqA6Y6rOT8S8yDptvk5rpojT/cxwKalFckr17k56o3rmWf4B8hqfj/k3SsSKriOOxTSi+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfKYm/Iq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F71C4CEF1;
	Wed, 10 Dec 2025 07:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765351993;
	bh=4N/IsyF2wkHWFuX49UOWgzr/gEzl5vEuFGz3ZXffjEQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nfKYm/Iqbcl7TFDXisM4qiwHdolrFLZfVS7WTlY/9JU8kdMnNOtEWwlmoo0N2s7+x
	 sTtbrEohWsS5vQV6C7INyuRXISMEW0s7Isk6awdgcEaHylix0Z0DfRkB6RBH3kzEg6
	 uPL1EqSQxdZ+rX/ND5ZGPyF2Z5nnorfEE/5z0R9jPwJNZFC+62Q5J2NDsqM6rf+fCP
	 /xytdQcfsA1cXVxcA68F1eYwvCoOkS8B1+qEuvqFXXs1vcZ1L0ZBk/Xu+Ccpkzb3kj
	 APw5DHdWEQeAH4Bdutq9DCF9NXH6w4apPGib4YGgXq7o+4fHLJfl0SP5Zzc74rRf5S
	 XPADkecMvVuug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77E8D3809A18;
	Wed, 10 Dec 2025 07:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] tools/lib/bpf: fix -Wdiscarded-qualifiers under C23
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176535180830.487333.9076600383641931356.git-patchwork-notify@kernel.org>
Date: Wed, 10 Dec 2025 07:30:08 +0000
References: <20251206092825.1471385-1-mikhail.v.gavrilov@gmail.com>
In-Reply-To: <20251206092825.1471385-1-mikhail.v.gavrilov@gmail.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, netdev@vger.kernel.org, fweimer@redhat.com,
 andrii.nakryiko@gmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat,  6 Dec 2025 14:28:25 +0500 you wrote:
> glibc ≥ 2.42 (GCC 15) defaults to -std=gnu23, which promotes
> -Wdiscarded-qualifiers to an error.
> 
> In C23, strstr() and strchr() return "const char *".
> 
> Change variable types to const char * where the pointers are never
> modified (res, sym_sfx, next_path).
> 
> [...]

Here is the summary with links:
  - [v3] tools/lib/bpf: fix -Wdiscarded-qualifiers under C23
    https://git.kernel.org/bpf/bpf/c/d70f79fef658

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



