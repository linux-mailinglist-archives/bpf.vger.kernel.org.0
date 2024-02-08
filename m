Return-Path: <bpf+bounces-21459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E63384D711
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 01:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EB821F2357C
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 00:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD3FD2FA;
	Thu,  8 Feb 2024 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFbAf3iz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7861E485
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 00:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707351630; cv=none; b=OhYibrjS3kC3a3CnvJLFt3KNbOLwkibxKgbYJbhY57Lw4YjnzC3XwwqHi/wuFm7X7pza4yUwP1UFvn6lt++vrD8kCXRQ4RwZnizYrcgdQpcVTdmGWUZnaa0eJjfsMy3zskfCj02UegUyp9jokW2igE5vHIG/mIzH45NV68m6I7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707351630; c=relaxed/simple;
	bh=PEEVgo/pnw3DvgoGLKC4oDqlsMBxhqyOyrBqlwtpuz8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B0y+w9l1BepvjfwGppTc41ehWUGZGfSz/+Ug0vPHuWhXLLz2oUYaNK48n1E4+TuseUveidVcQBuH8Rkel0Qk2EPrNFYDMa3S8HvC4BEzALXxQgDNyXeFKgw9JYqVG13kGBOTWjNinSq4aRG9+Lovyk/HA1sat1ZxsXoTP5XVFXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFbAf3iz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4FFEEC433C7;
	Thu,  8 Feb 2024 00:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707351630;
	bh=PEEVgo/pnw3DvgoGLKC4oDqlsMBxhqyOyrBqlwtpuz8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sFbAf3izBae2VfN8kINHHPmQvo633SStt3mN7p+c12xagC6uj3U05wxI3nTGIEFZX
	 5fzwsWPQ3s0AIhIF2nXFHlW1A/jgAqV43kPD8D1zka9eJZbyGQFG8dn5Yy5VgJ7qpY
	 dvt0LoCqV8+1oX1RdRcKoLRSWK0MdWX56MIcvjmGsKoR8zIJtPvEqwTUURmJHVk4gS
	 6Hgs2BU3h6q/csO8lUwkGGDHN9266mgohDSevj8jYYiF+xEmAttdLmV1t4PWGO3Tno
	 Nf5U3CD2KrNQcv9XfzawJd9z1rA7HQAMdWRk0fyYnOX4XVwrUZsa/bUPlkS0QuwiTZ
	 wgcctA6r4ad/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30C31E2F2F1;
	Thu,  8 Feb 2024 00:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/2] tools/resolve_btfids: fix cross-compilation
 to non-host endianness
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170735163018.12984.1735440494705168334.git-patchwork-notify@kernel.org>
Date: Thu, 08 Feb 2024 00:20:30 +0000
References: <cover.1707223196.git.vmalik@redhat.com>
In-Reply-To: <cover.1707223196.git.vmalik@redhat.com>
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 akpm@linux-foundation.org, adobriyan@gmail.com, memxor@gmail.com,
 dxu@dxuuu.xyz, chantr4@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  6 Feb 2024 13:46:08 +0100 you wrote:
> The .BTF_ids section is pre-filled with zeroed BTF ID entries during the
> build and afterwards patched by resolve_btfids with correct values.
> Since resolve_btfids always writes in host-native endianness, it relies
> on libelf to do the translation when the target ELF is cross-compiled to
> a different endianness (this was introduced in commit 61e8aeda9398
> ("bpf: Fix libelf endian handling in resolv_btfids")).
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] tools/resolve_btfids: Refactor set sorting with types from btf_ids.h
    https://git.kernel.org/bpf/bpf-next/c/9707ac4fe2f5
  - [bpf-next,v4,2/2] tools/resolve_btfids: fix cross-compilation to non-host endianness
    https://git.kernel.org/bpf/bpf-next/c/903fad439466

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



