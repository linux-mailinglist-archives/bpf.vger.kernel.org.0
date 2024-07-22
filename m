Return-Path: <bpf+bounces-35234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514529390F9
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 16:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFAE51F21F88
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 14:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE6E16DC1D;
	Mon, 22 Jul 2024 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HN8/6I+c"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB81D16B74D;
	Mon, 22 Jul 2024 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721659832; cv=none; b=ZEUS9Ym4YTLNknwrgl5OMaXXWL+nSnVHVmYIS3lS1iXQya2d+GBw+dMOmHmq3djtejW2FmDMsEvQuYhey/2bv5AgoWfqfBcTd9uYFY+KSWsYFmhu0eaBEDtBn20hSDC5OsYNb7Q80hTFDiJIT4eQj8OflHQPXLP73y00I6DiCSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721659832; c=relaxed/simple;
	bh=YGYGBci2u22GJF/LUTU8NgZrC5I0ECCipbmw78J61vA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QCr7TLNgueMlPEwipN5htDedOrzqQFc2Dsm7Ntu1QZqK4gpHEGW7/v7tH9tL89OEkE66YXkY0osnP6vNk9GUQaBAavVIcFPwDsGMJVQEaCZ8i6LaRVi+mJanMiWn72UJFF1kNh6Bm65inlF84yt4FnV4mpsoraAmh5ct1NrjwY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HN8/6I+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78F67C4AF0D;
	Mon, 22 Jul 2024 14:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721659831;
	bh=YGYGBci2u22GJF/LUTU8NgZrC5I0ECCipbmw78J61vA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HN8/6I+cBxftzESKovdbs0oIsT2cloc4bF1Ij21h44FHrSnlZq8lOYAJxvHo2YhNF
	 Q1LlBBnxmOq3ZwgBElVZVAOUhdI2HnwHhXiXz2cNZTZBXVyjBVmpAD8dtnCiWsVALs
	 hIkj6boctwOAjT3PNkl/O+TD00KVwdU6HEqIkvaer7kowIfF97NspzWIVkiaWnyYdl
	 ELt7XmTbAjk/d/mCwQUpUN1tXId1GHj0NsmtMtt+5NFsl4IzEs7ZHtnhFRxNNni/DK
	 at62SpeAPMDZy4vFflWTTcrdW6GRvxxQzlmIzYHN0cn6abqfPCdqz8FU//bpg85LxA
	 nGKXr9+0zco9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6673FC43445;
	Mon, 22 Jul 2024 14:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [v3 PATCH bpf-next 0/4] bpftool: add tcx subcommand in net
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172165983141.18852.5035240081297600904.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jul 2024 14:50:31 +0000
References: <20240721143353.95980-1-chen.dylane@gmail.com>
In-Reply-To: <20240721143353.95980-1-chen.dylane@gmail.com>
To: Tao Chen <chen.dylane@gmail.com>
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sun, 21 Jul 2024 22:33:49 +0800 you wrote:
> XDP prog has already realised with net attach/detach subcommand.
> As Qmonnet said [0], tcx prog may also can be added. So this patch set
> adds tcx subcommand in net attach/detach.
> 
> [0] https://github.com/libbpf/bpftool/issues/124
> 
> Change list:
> - v2 -> v3:
>     - fix return value in patch2
>     - replace tabs with spaces patch2
> - v1 -> v2:
>   - As suggested by Quentin, modification as fellows:
>     - refactor xdp attach/detach type judgment in patch1
>     - err handle fix for xdp in patch2
>     - change command tcx* to tcx_* in patch2
>     - some code modification for readable in patch2
>     - document modification for readable in patch4
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next,1/4] bpftool: refactor xdp attach/detach type judgment
    https://git.kernel.org/bpf/bpf-next/c/f408126f7b33
  - [v3,bpf-next,2/4] bpftool: add net attach/detach command to tcx prog
    https://git.kernel.org/bpf/bpf-next/c/7f1cfa6b64c6
  - [v3,bpf-next,3/4] bpftool: add bash-completion for tcx subcommand
    https://git.kernel.org/bpf/bpf-next/c/0445e0c5c2e1
  - [v3,bpf-next,4/4] bpftool: add document for net attach/detach on tcx subcommand
    https://git.kernel.org/bpf/bpf-next/c/6d5848d4fe98

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



