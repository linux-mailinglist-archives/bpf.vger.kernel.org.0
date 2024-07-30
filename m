Return-Path: <bpf+bounces-36099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B269422AA
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 00:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4A5284CA7
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 22:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDCF1917C0;
	Tue, 30 Jul 2024 22:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+4WiCF7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28828157466;
	Tue, 30 Jul 2024 22:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722378032; cv=none; b=gZjL5ChhzQlMYbE10coCdFIlQXJwVnE7sIuCWBsqVPScX9RATlfI9NOo6R6v8p0tboVvaH9c5boOBUK7FrkOLUVzco3gLWXooptaIyCuNRCAfxQSlKeTJIRAxFGpZA+F4Oiki15x4oQ/IaRKuO4UVaWwDtTvgmuk882sF37b+vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722378032; c=relaxed/simple;
	bh=UXmltjffsW5qC4eXcQNxo2kqtSaVud0hlfQkThU5K8I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k+OaYPV4P/cLs/W/Wn1zbIVAml5ayppEUuTHxd0wuuWj5JRyy9+Bvv03A+Yr0B7QaTtn7zuQiA/kpT7y7hKoWHjZto3NY5zsJoLE4FUYEo8EiS9Dem+zHxToU3btIGoy/ZzieO1gpNgWuRl+FtgVz3WTqs27hyDKkU41qlFAcn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+4WiCF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C799C4AF09;
	Tue, 30 Jul 2024 22:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722378031;
	bh=UXmltjffsW5qC4eXcQNxo2kqtSaVud0hlfQkThU5K8I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s+4WiCF76h95Vd1F0hJpfggXhN5aHSznskVIIdKn9RT0mC32P1CBURpzbfDTrMhXA
	 ZeJboZId1l3U8ufZ67HVUDuqEtgfkG2Z/gWLDZJTuQZwyxCgssslhmhZCFIDXY9x18
	 FyxZokAxiEltqHyZEVVY0Y1TV8htt5CkekvD49wcH9pcTaAq/X2gbzWH+oI7b+2OUB
	 Lu+w8jx66yxfmLTZgDWkNY824zJDGcb4rgtxpIHux2FsngHXFLaoRE+zdAsrE62qkh
	 YJcc998JN44AQ7j85JWYK3lsRjUB62f3UkSlujtNdIZwL4xSjE0uzTwHmQGllL6/ba
	 IFG6LpAol2rww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A5D0C43140;
	Tue, 30 Jul 2024 22:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] xsk: Try to make xdp_umem_reg extension a bit more
 future-proof
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172237803156.26065.5548946293304661200.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jul 2024 22:20:31 +0000
References: <20240726222048.1397869-1-sdf@fomichev.me>
In-Reply-To: <20240726222048.1397869-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 haoluo@google.com, jolsa@kernel.org, mail@arctic-alpaca.de,
 magnus.karlsson@gmail.com, maciej.fijalkowski@intel.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri, 26 Jul 2024 15:20:48 -0700 you wrote:
> We recently found out that extending xsk_umem_reg might be a bit
> complicated due to not enforcing padding to be zero [0]. Add
> a couple of things to make it less error-prone:
> 1. Remove xdp_umem_reg_v2 since its sizeof is the same as xdp_umem_reg
> 2. Add BUILD_BUG_ON that checks that the size of xdp_umem_reg_v1 is less
>    than xdp_umem_reg; presumably, when we get to v2, there is gonna
>    be a similar line to enforce that sizeof(v2) > sizeof(v1)
> 3. Add BUILD_BUG_ON to make sure the last field plus its size matches
>    the overall struct size. The intent is to demonstrate that we don't
>    have any lingering padding.
> 
> [...]

Here is the summary with links:
  - [bpf-next] xsk: Try to make xdp_umem_reg extension a bit more future-proof
    https://git.kernel.org/bpf/bpf-next/c/32654bbd6313

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



