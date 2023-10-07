Return-Path: <bpf+bounces-11597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756B47BC4CA
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 07:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747CF1C20A3C
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 05:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399D85687;
	Sat,  7 Oct 2023 05:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4I72RF6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D84839D
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 05:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5E08C433C8;
	Sat,  7 Oct 2023 05:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696656026;
	bh=tZ1wj6xRN1MHfZo0sZRwJJNUT8N8Etn4/d1hSxRazPo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m4I72RF67rGE2k6XsWPzO/Z1kLIWc2WN09Z1HnlF8zzqXL+62/azDVwYXstJpXp1s
	 OTNMGnPkV6omVvhbv15BNu/RFIL8k3teHDfDdr4BaHHQ0Gtgdz2CkyQfA8L3iIbMny
	 bKZAICmkSucMkx1r2YINgxwGGxys+Pf185P+KkCY1nI90aIUyvY2Cp//50crLDluiC
	 43QRwJbLLsU8ITke6S5079pg+k1rT5RI+xnwso+2AN5j5Fe8CMJ0v5bpq0V1Jv+Bd8
	 dtf36c9ED3i2h0ZpVajjb/D1/e/eeBWYpugcL5+0GFnQWImLXJvlSlv8sESi57VQoM
	 le2qJNbwtuyXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CAB40C41671;
	Sat,  7 Oct 2023 05:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/7] bpf: Fix BPF_PROG_QUERY last field check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169665602582.13048.6728171586658800570.git-patchwork-notify@kernel.org>
Date: Sat, 07 Oct 2023 05:20:25 +0000
References: <20231006220655.1653-1-daniel@iogearbox.net>
In-Reply-To: <20231006220655.1653-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, lmb@isovalent.com, martin.lau@kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Sat,  7 Oct 2023 00:06:49 +0200 you wrote:
> While working on the ebpf-go [0] library integration for bpf_mprog and tcx,
> Lorenz noticed that two subsequent BPF_PROG_QUERY requests currently fail. A
> typical workflow is to first gather the bpf_mprog count without passing program/
> link arrays, followed by the second request which contains the actual array
> pointers.
> 
> The initial call populates count and revision fields. The second call gets
> rejected due to a BPF_PROG_QUERY_LAST_FIELD bug which should point to
> query.revision instead of query.link_attach_flags since the former is really
> the last member.
> 
> [...]

Here is the summary with links:
  - [bpf,1/7] bpf: Fix BPF_PROG_QUERY last field check
    https://git.kernel.org/bpf/bpf/c/a4fe78386afb
  - [bpf,2/7] bpf: Handle bpf_mprog_query with NULL entry
    https://git.kernel.org/bpf/bpf/c/edfa9af0a73e
  - [bpf,3/7] bpf: Refuse unused attributes in bpf_prog_{attach,detach}
    https://git.kernel.org/bpf/bpf/c/ba62d61128bd
  - [bpf,4/7] selftests/bpf: Test bpf_mprog query API via libbpf and raw syscall
    https://git.kernel.org/bpf/bpf/c/f9b08790fa69
  - [bpf,5/7] selftests/bpf: Adapt assert_mprog_count to always expect 0 count
    https://git.kernel.org/bpf/bpf/c/b77368269dda
  - [bpf,6/7] selftests/bpf: Test query on empty mprog and pass revision into attach
    https://git.kernel.org/bpf/bpf/c/685446b0629b
  - [bpf,7/7] selftests/bpf: Make seen_tc* variable tests more robust
    https://git.kernel.org/bpf/bpf/c/37345b8535b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



