Return-Path: <bpf+bounces-26483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A47918A066A
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 05:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA8428A24B
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 03:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB2113B789;
	Thu, 11 Apr 2024 03:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uj0d+Jft"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CA013B5A6
	for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 03:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712804430; cv=none; b=MAbLPz/8u2kQQbtgirB6H3wAULHm/3kutm9n9/R49lUPjvPm56zKm+KPk6YqDbuwXthFuiika018AANjNNy/4QNM4LGBtGV15Dk2H4Q33vxj+11cbe07Wp86ZRpzsNr1qkfisLDEYOuzBJGysar1mLGjXHt40BwSeKCl+ABPIXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712804430; c=relaxed/simple;
	bh=66g0Pk5PkdYebx8PH2xYDia2AgOvS6UEzBoPgE9Otc8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pwDce9Rs2IgU55HJUTiP1DI18GYHDKH7vzuSFRArJ/HzFWNWIsOetN2ldI/po+sB5UQWnxBcu+nnNF84pMoA+i+g2UJvx/KYckYBjeqxOtx7us1tm/hrD6CHsfTa3RzXC6BsHWvuW7S683m1lCMDvcSh2RyQKEGF6QSpQeHXs7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uj0d+Jft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AEB5C43390;
	Thu, 11 Apr 2024 03:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712804430;
	bh=66g0Pk5PkdYebx8PH2xYDia2AgOvS6UEzBoPgE9Otc8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uj0d+JftvxlnUXhnZ1xqCWQu3hgPSM7ajcdPYj3JgqwFjHQDBcRhbF2QDY+ya9+nH
	 xnGQXDnSMSol5WoGsSmJneXQM8MeEj6O84VVwRzP+69OBlWKhbwyNqvJYtPBZPI8Xa
	 9rZFNeqI2O7AkYHRyrYU66qX4tIwjziHGcSEhHPjDRvi3ppk4EpR9fQ3fioQ+Q+wLz
	 bH8y+8a3FNJ9BM5GCp1EZaEz3sDjG2/F071G0B+ZOBYMVYJteTWlKqld5vwP2CAAxe
	 VKdnUiBBEtcmV8+0Gxco/CjG/9aTbub8N8O89SO+1ntzumnIO1buev1SK3+M0v+rEs
	 dQQBv6HnVnBKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F03BDD6030E;
	Thu, 11 Apr 2024 03:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7 0/5] bpf: Add bpf_link support for sk_msg and
 sk_skb progs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171280442998.1698.2738854742023755836.git-patchwork-notify@kernel.org>
Date: Thu, 11 Apr 2024 03:00:29 +0000
References: <20240410043522.3736912-1-yonghong.song@linux.dev>
In-Reply-To: <20240410043522.3736912-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, jakub@cloudflare.com, john.fastabend@gmail.com,
 kernel-team@fb.com, martin.lau@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  9 Apr 2024 21:35:22 -0700 you wrote:
> One of our internal services started to use sk_msg program and currently
> it used existing prog attach/detach2 as demonstrated in selftests.
> But attach/detach of all other bpf programs are based on bpf_link.
> Consistent attach/detach APIs for all programs will make things easy to
> undersand and less error prone. So this patch added bpf_link
> support for BPF_PROG_TYPE_SK_MSG. Based on comments from
> previous RFC patch, I added BPF_PROG_TYPE_SK_SKB support as well
> as both program types have similar treatment w.r.t. bpf_link
> handling.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7,1/5] bpf: Add bpf_link support for sk_msg and sk_skb progs
    https://git.kernel.org/bpf/bpf-next/c/699c23f02c65
  - [bpf-next,v7,2/5] libbpf: Add bpf_link support for BPF_PROG_TYPE_SOCKMAP
    https://git.kernel.org/bpf/bpf-next/c/849989af61ad
  - [bpf-next,v7,3/5] bpftool: Add link dump support for BPF_LINK_TYPE_SOCKMAP
    https://git.kernel.org/bpf/bpf-next/c/1f3e2091d25b
  - [bpf-next,v7,4/5] selftests/bpf: Refactor out helper functions for a few tests
    https://git.kernel.org/bpf/bpf-next/c/a15d58b2bc82
  - [bpf-next,v7,5/5] selftests/bpf: Add some tests with new bpf_program__attach_sockmap() APIs
    https://git.kernel.org/bpf/bpf-next/c/8ba218e625f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



