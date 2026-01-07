Return-Path: <bpf+bounces-78043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 678C6CFC0B1
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 06:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98AAB3027E08
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 05:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6441C2561A2;
	Wed,  7 Jan 2026 05:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8S4MJ5m"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC869225402
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 05:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767762811; cv=none; b=B+tVcJ3oVWZgfcV7KMh8eUDsYk+kS5vc/Pp8yEHFqsrbBdJvcG0rMquQer6Xu1MzlDdW2RP3sCCY63pdCZbNdj+WTOHDxwlpTZV3sn5j/qATwgz8m3kW5VX+f3/DyTwsSGE5TpJ5sLy9yZfXFoUzftE34mSSRlVaepNYwBml5z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767762811; c=relaxed/simple;
	bh=tcvx8NrJAa+6WtVycEHMFhl2oFdJskggJ+mp9EMiHIQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k0+3UYU/lh4+3PpW+wKcbrb1GhrvBRf3iJ3wwoGR8k5WAZFL2pazDX5Naok0oHs96SahIEFC2iTT0AiaP8De4bg/wN+DkIZVTUP3/mtBbT2o8424/r5drVJIUoCA4aObVexkod8gQ37XiKIlCho0QHgbgwG3NThXtizccD2MJMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8S4MJ5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF07C4CEF7;
	Wed,  7 Jan 2026 05:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767762811;
	bh=tcvx8NrJAa+6WtVycEHMFhl2oFdJskggJ+mp9EMiHIQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c8S4MJ5m6JK9xd3+vgcXyclo/GtFzvFw/fwcn2mTmqb1xPraoRCb2dSl7K0qG1nGu
	 3QEB7ckr6mGgRX5Ai538r+ZLYUZTvqL7fWPYT/KOB+/MJUho3CONU7ViS6ruV8+ZoG
	 Y0e9CQDO4G8JJ706UQF4y/AP4PkYNNtBQtF1iY8wxfTduIYrSjkuTPcTvFpMfXNqFM
	 tIKhjjWl6DXH1VGPlwVVOjR2VaWUJdIkQgmzTkGF/V0mFafF/E/9UmEuPLI1XUSjFH
	 1DSOrqygyRu+SdVa5MCH0Hh6yKjSHyjckuAcogCda26DCDCFnCtenIOnjOdjlva2cs
	 HJ9bfOYU1wbOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F29AB380CEFA;
	Wed,  7 Jan 2026 05:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] bpf: selftests fixes for GCC-BPF 16
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176776260879.2236065.1916613970347217236.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 05:10:08 +0000
References: <20260106173650.18191-1-jose.marchesi@oracle.com>
In-Reply-To: <20260106173650.18191-1-jose.marchesi@oracle.com>
To: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  6 Jan 2026 18:36:48 +0100 you wrote:
> Hello.
> 
> Just a couple of small fixes to get the BPF selftests build with what
> will become GCC 16 this spring.  One of the regressions is due to a
> change in the behavior of a warning in GCC 16.  The other is due to
> the fact that GCC 16 actually implements btf_decl_tag and
> btf_type_tag.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: adapt selftests to GCC 16 -Wunused-but-set-variable
    https://git.kernel.org/bpf/bpf-next/c/97fb54d86d21
  - [bpf-next,2/2] bpf: GCC requires function attributes before the declarator
    https://git.kernel.org/bpf/bpf-next/c/681600647c59

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



