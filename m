Return-Path: <bpf+bounces-8278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DFA784802
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 18:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7257F1C20B45
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 16:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42182B55C;
	Tue, 22 Aug 2023 16:50:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C022B540
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 16:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8AF0C433CA;
	Tue, 22 Aug 2023 16:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692723025;
	bh=EpjlHif/Np4Cw0DpZlSCAxtcSiYcu8sv3LCV2fLWVKA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ACf6Ov+XpF8tLCjZhMPyMiq4D6j+emp/hg91s/YOyO8VlOtSLYM+SgBA4XVwtgFAN
	 S00A4LT4iC+93VP0apNj93dWnbuSZXgKCwRwvqTOqjkEJzZTkQf22yWWCnkQ1dkJDI
	 jkNBltvgCEXGK9o9UKxaJoTuQInKhVN/puFMwo/oVrWc9/3MO296eVNaQLclStVxZf
	 wV/gVFD8M2b4R1X28ohee85WdTYvSfMzmCT+YbS2yI84V288eXv0NnZHSocAscmTs9
	 SBUL4obFDq5lFH6xCFnBAaIFOyA+mNgYnPlfquv1HJ+yBCH/ryfagxjOI2IfS7yAtt
	 wDxM5n1hAac+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA440C3274B;
	Tue, 22 Aug 2023 16:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Fix a bpf_kptr_xchg() issue with local
 kptr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169272302569.2668.18418396223663638103.git-patchwork-notify@kernel.org>
Date: Tue, 22 Aug 2023 16:50:25 +0000
References: <20230822050053.2886960-1-yonghong.song@linux.dev>
In-Reply-To: <20230822050053.2886960-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 21 Aug 2023 22:00:53 -0700 you wrote:
> When reviewing local percpu kptr support, Alexei discovered a bug
> wherea bpf_kptr_xchg() may succeed even if the map value kptr type and
> locally allocated obj type do not match ([1]). Missed struct btf_id
> comparison is the reason for the bug. This patch added such struct btf_id
> comparison and will flag verification failure if types do not match.
> 
>   [1] https://lore.kernel.org/bpf/20230819002907.io3iphmnuk43xblu@macbook-pro-8.dhcp.thefacebook.com/#t
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Fix a bpf_kptr_xchg() issue with local kptr
    https://git.kernel.org/bpf/bpf-next/c/ab6c637ad027
  - [bpf-next,v2,2/2] selftests/bpf: Add a failure test for bpf_kptr_xchg() with local kptr
    https://git.kernel.org/bpf/bpf-next/c/fb3015942643

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



