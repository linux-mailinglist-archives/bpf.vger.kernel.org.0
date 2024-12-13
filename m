Return-Path: <bpf+bounces-46934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC7B9F1941
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8F018898BA
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 22:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E481A8F7F;
	Fri, 13 Dec 2024 22:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IO3Vau3K"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B362114;
	Fri, 13 Dec 2024 22:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734129613; cv=none; b=oG4KX/fpYQVJLRjQKYfkS3GA8Y6prw/ujkRdUBTyllDOnatiDT41bf0CrGSNt9PwU5Ihz5+dE1+aHVni1HoKajrt1+BQOnJC5T3rW5FdxSvs5NLnAkQ4CoDMuQGFctg6qCpShL8+fzlZC+9EY27oWiyggTjG7ufHeBBVXubT77c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734129613; c=relaxed/simple;
	bh=+MTF8roLSxcuTEqhQmwV2TYDYnxYq8w1J4Ex7OmS5sA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q+d9YjBc0nsmpXFRgcC9fveB34qlFfiDY+BYuqNizwNV1fN3FsJny5ip0biFpRWPxNIMk5E1r5ltI6Ky3+tRYI7tZFKR8/fMeEtcLeMleYPnPAyiWakfqCeZ/v77JXiAfH1uCD7V6cNlRhXPhT9j1gN15gOUqlWOtax41jS9v1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IO3Vau3K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8A0C4CED0;
	Fri, 13 Dec 2024 22:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734129613;
	bh=+MTF8roLSxcuTEqhQmwV2TYDYnxYq8w1J4Ex7OmS5sA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IO3Vau3KhMlfELzOMsG/PaTUkMRfFtGcYEDSTxnoCSC9LG2JVtAuZT3MpjgS1yC1R
	 SLcm796Qch4MwA+jtpvmBY7llAj1AuLj+lgJ6vwvTGTKPrfxhLXYmJzPfQBN+V3G6J
	 IE+NMTxCInhvFoqvr+apiRB+G/G3Tt7VtKBRpAdg23Q0xpJMoCGa8Rxsllzg6oovS+
	 7hD/mGOqIqupWFsKUZ1Ap/TSQgzmMfNJKqn/RynHCteShRlHa4AP9BSF2UEfZiknSy
	 qZeHEHcjh4lB7zcX0wtvgz3gp/qH1j04mZmPPdKWZvATRaZI1z8grZpVjhnJv/9gt0
	 gh2oA6cyxN5Lg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B249380A959;
	Fri, 13 Dec 2024 22:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/4] bpftool: btf: Support dumping a single type
 from file
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173412962995.3181069.4927934757783074209.git-patchwork-notify@kernel.org>
Date: Fri, 13 Dec 2024 22:40:29 +0000
References: <cover.1734119028.git.dxu@dxuuu.xyz>
In-Reply-To: <cover.1734119028.git.dxu@dxuuu.xyz>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 qmo@kernel.org, andrii.nakryiko@gmail.com, antony@phenome.org,
 toke@kernel.org, martin.lau@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 13 Dec 2024 12:44:08 -0700 you wrote:
> Some projects, for example xdp-tools [0], prefer to check in a minimized
> vmlinux.h rather than the complete file which can get rather large.
> 
> However, when you try to add a minimized version of a complex struct (eg
> struct xfrm_state), things can get quite complex if you're trying to
> manually untangle and deduplicate the dependencies.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/4] bpftool: man: Add missing format argument to command description
    https://git.kernel.org/bpf/bpf-next/c/5e3ad22d8223
  - [bpf-next,v5,2/4] bpftool: btf: Validate root_type_ids early
    https://git.kernel.org/bpf/bpf-next/c/7f5819e1ace8
  - [bpf-next,v5,3/4] bpftool: btf: Support dumping a specific types from file
    https://git.kernel.org/bpf/bpf-next/c/a812d92ed2ae
  - [bpf-next,v5,4/4] bpftool: bash: Add bash completion for root_id argument
    https://git.kernel.org/bpf/bpf-next/c/9d294f698678

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



