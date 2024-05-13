Return-Path: <bpf+bounces-29612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 445A38C3996
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 02:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75144281307
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 00:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2681139E;
	Mon, 13 May 2024 00:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5Wtvl+n"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386D6368
	for <bpf@vger.kernel.org>; Mon, 13 May 2024 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715559632; cv=none; b=OiFUgwAgcfjz8j28FItTbWehDyJZTzuSh6dA+B1b/0E/FsykvMEVdYFRusKhDySWiUealxzd3RLSVEJs7mmB24Aai6gmkpr99uitAOtVVUxnP5kRi8DdubR+0bnNxeg9BCOD8nsPp/A1ybRpr9litKkHwar2XgMAS6KsKyyVs+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715559632; c=relaxed/simple;
	bh=B0M8aeR2hQpp7jsq28G2tX54mo9+kK2izID6zRdyfu0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HvqcAMzbgQdou1gzTJbXKHPk8O/1I4QfXbqMceBV3KksGSQ3S47cABqnACbD9+BVo6bYUBn76uluNGWlcfxaVk+iGfSuovLhN+wtCCZDqvf/g5ylb+p+aiYAWjOtgwPKnUL/u1oeLU9swnJGR21SursfSCe2kzrO5PKyfpkPNyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5Wtvl+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8FB6C32782;
	Mon, 13 May 2024 00:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715559631;
	bh=B0M8aeR2hQpp7jsq28G2tX54mo9+kK2izID6zRdyfu0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K5Wtvl+nECtKMmQOhaW/zyIP/828JO7VvoUa9roa88endPVZrRGcG0LowFcVEVf4E
	 kaC2j9Adihx2DLcqPkFo67VybO1tUf9JQGrG+aaZEJ9CGbiB/fJJdjyK3lsuQJtXi+
	 y3eX0BbRrVkxrl6GJGctZ8oo3IG5+dj9rytHMgO4C8/F/B/u/bxqdFaVMTTFoXfasX
	 z9yXgrTnjmu4sJD37AIa4uxp2iak4ZIkQJ/AszaLNDd9StS00J3M4puJgUI5HaxLPK
	 6bHUiLGbXpXWgqEsyzvz9UiV/kCWA+kfHpebvbSfzphzvXW6lZOqDzr9BLdN4OVqF4
	 70M+avXDAPWDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6365C43444;
	Mon, 13 May 2024 00:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: avoid gcc overflow warning in test_xdp_vlan.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171555963167.28854.5804115900768160470.git-patchwork-notify@kernel.org>
Date: Mon, 13 May 2024 00:20:31 +0000
References: <20240508193512.152759-1-david.faust@oracle.com>
In-Reply-To: <20240508193512.152759-1-david.faust@oracle.com>
To: David Faust <david.faust@oracle.com>
Cc: bpf@vger.kernel.org, jose.marchesi@oracle.com,
 cupertino.miranda@oracle.com, eddyz87@gmail.com, yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  8 May 2024 12:35:12 -0700 you wrote:
> This patch fixes an integer overflow warning raised by GCC in
> xdp_prognum1 of progs/test_xdp_vlan.c:
> 
>   GCC-BPF  [test_maps] test_xdp_vlan.bpf.o
> progs/test_xdp_vlan.c: In function 'xdp_prognum1':
> progs/test_xdp_vlan.c:163:25: error: integer overflow in expression
>  '(short int)(((__builtin_constant_p((int)vlan_hdr->h_vlan_TCI)) != 0
>    ? (int)(short unsigned int)((short int)((int)vlan_hdr->h_vlan_TCI
>    << 8 >> 8) << 8 | (short int)((int)vlan_hdr->h_vlan_TCI << 0 >> 8
>    << 0)) & 61440 : (int)__builtin_bswap16(vlan_hdr->h_vlan_TCI)
>    & 61440) << 8 >> 8) << 8' of type 'short int' results in '0' [-Werror=overflow]
>   163 |                         bpf_htons((bpf_ntohs(vlan_hdr->h_vlan_TCI) & 0xf000)
>       |                         ^~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: avoid gcc overflow warning in test_xdp_vlan.c
    https://git.kernel.org/bpf/bpf-next/c/792a04bed41c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



