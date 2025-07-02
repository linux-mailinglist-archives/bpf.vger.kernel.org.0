Return-Path: <bpf+bounces-62129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C56AF5C03
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 17:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7071C1C270BB
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 15:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40BB30E820;
	Wed,  2 Jul 2025 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRx1RyqC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D61D30B985
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751468395; cv=none; b=F71yN7gOX9WSaUzUDpe7PeGgEuZSUTXb4IUnb1Td012j8Lerj5BKcDn8JIP1INCllRjuW0Gs2sfqhhwNvkxjJ+tC+XJvpn/QjncMXbrSvOYoKCkaJq2oQ+yFZUQ+iriQbSuF2ZdF21RrgscvCTUNEH5UnRJOFaCtqSw757tiSzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751468395; c=relaxed/simple;
	bh=XJCMg9Nw67aFRnnZnZkyINv5ECnYTHAKniYxUMplGHE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ca76SW9tDDzsWz7V07RZhOuJJ2rFtGKhrYE8xtJV0S+xKb+sRLhbSMG04GcBgAc64ygmqdtAuCeqVBVou4k0CcsXW5vGKs5+5vVUWC8RMLZjU2u1gsUMxejw6BuOm/exWSfcByQi1jfA3rxc4XJPBqg935jhm78CLGBAAr+VVu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRx1RyqC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27464C4CEE7;
	Wed,  2 Jul 2025 14:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751468395;
	bh=XJCMg9Nw67aFRnnZnZkyINv5ECnYTHAKniYxUMplGHE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qRx1RyqCAqq4Ew6RIFuJg23R3y6Z460eudz/1p/0QrWJ9X0ICrbhoK1xX0QGKJCsw
	 YDZUQl4d1eWLjSrll6cQIY6uaoonDvTYktnakhkNEk7KCdKbq3MLBDPTKpCuYyRfyR
	 au8GDfpKDOs6oAA/PvJWJ4B3ur9LzzdAawZrVFMfDogn9+2RKgQz2UhZAjh8b6w/PR
	 rxfIQs/XDl7gsG9lAkh1BVrBCxXcKWRpg194eQ41YlnfrEwMiLJkpPOEODLe3fEU3v
	 rlU9U0UAAxVGdIeMJm909K8db5y/BxDortyX4mEDEKy6CTdMO8ps31nrvrG6/VXrHb
	 Wh5NoMpAlogEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACD8383B273;
	Wed,  2 Jul 2025 15:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 1/2] bpf: avoid jump misprediction for
 PTR_TO_MEM
 | PTR_UNTRUSTED
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175146841979.753088.11975033328524632760.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 15:00:19 +0000
References: <20250702073620.897517-1-eddyz87@gmail.com>
In-Reply-To: <20250702073620.897517-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, alexei.starovoitov@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  2 Jul 2025 00:36:19 -0700 you wrote:
> Commit f2362a57aeff ("bpf: allow void* cast using bpf_rdonly_cast()")
> added a notion of PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED type.
> This simultaneously introduced a bug in jump prediction logic for
> situations like below:
> 
>   p = bpf_rdonly_cast(..., 0);
>   if (p) a(); else b();
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/2] bpf: avoid jump misprediction for PTR_TO_MEM | PTR_UNTRUSTED
    https://git.kernel.org/bpf/bpf-next/c/c8313bad6d24
  - [bpf-next,v1,2/2] selftests/bpf: null checks for rdonly_untrusted_mem should be preserved
    https://git.kernel.org/bpf/bpf-next/c/621af1928153

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



