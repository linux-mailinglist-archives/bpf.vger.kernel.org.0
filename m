Return-Path: <bpf+bounces-30708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5ED8D1857
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 12:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD671B27713
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 10:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAFA16ABE2;
	Tue, 28 May 2024 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPEFKegA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A406015E96;
	Tue, 28 May 2024 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891630; cv=none; b=LizhnNC3oHFvi460WOYAwQlHDr6hewK+QslakA1Ewrt80B7+YZpSqhOl1rOAD6r5q3kTosjNM7eaq48ePjW+6AW3SNmnI2wQUGkwvPhi9a01kzQKmqelLTvM+ECakcGzBmsTXBodXmihkUPETiNDI8OGu3CC714HhauX719MHqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891630; c=relaxed/simple;
	bh=XPE9r6ln1qemfRDv7biBuJ2KZj87/YszG/QpHYmPiNY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ha4ONcm6W2tiblEHb0NEosYGsoKzxMwYmurWswYgRbfHO65LZvapo/o1RYjZJxvy+Y4eqDbQqu3D2DIVqc3WbO53W1XLTVPuUJgS2NMIW9xPibXaVStd/+tV7jbbuGGidV3hBTjebsCvdsfh1NbtyfBA8frOsbXgk8StTup0M/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPEFKegA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1485AC32782;
	Tue, 28 May 2024 10:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716891630;
	bh=XPE9r6ln1qemfRDv7biBuJ2KZj87/YszG/QpHYmPiNY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HPEFKegAwY7IRVEcryFyvVjtAsGYv02kcQvFjCcUAC943Y4fZrRMnIwiz/sK7+xUb
	 4B+SdbwagxDnlsxMsqKRkSrI0+VHCo2YxBT4SbcqzkayRGTHYNdojKCQm3UI2c83Ad
	 fix2n7LJdxM5xvIiAoQwWMUE9hl21noG0j/qk55AjFKUQAHRvZtWdfNxSht+vpA77D
	 hPgy23b/rVYGLgRplIQ/2ho2YYy01yizluFlMMg8U+mh04QUr2uxh6rvm39h4VMzeb
	 fnCdBgp9EJKaDJWvezEx3rlW2KAFWwSZS8TGMwWHoLNeJkH3ZvfM+day0e3hYyMdyF
	 lkVfbEtRJMG5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EEF2CC4361B;
	Tue, 28 May 2024 10:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] sock_map: avoid race between sock_map_close and
 sk_psock_put
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171689162997.24184.10361719946392416490.git-patchwork-notify@kernel.org>
Date: Tue, 28 May 2024 10:20:29 +0000
References: <20240524144702.1178377-1-cascardo@igalia.com>
In-Reply-To: <20240524144702.1178377-1-cascardo@igalia.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: netdev@vger.kernel.org, cong.wang@bytedance.com, jakub@cloudflare.com,
 edumazet@google.com, daniel@iogearbox.net, john.fastabend@gmail.com,
 davem@davemloft.net, kuba@kernel.org, ast@kernel.org, pabeni@redhat.com,
 bpf@vger.kernel.org, kernel-dev@igalia.com,
 syzbot+07a2e4a1a57118ef7355@syzkaller.appspotmail.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 24 May 2024 11:47:02 -0300 you wrote:
> sk_psock_get will return NULL if the refcount of psock has gone to 0, which
> will happen when the last call of sk_psock_put is done. However,
> sk_psock_drop may not have finished yet, so the close callback will still
> point to sock_map_close despite psock being NULL.
> 
> This can be reproduced with a thread deleting an element from the sock map,
> while the second one creates a socket, adds it to the map and closes it.
> 
> [...]

Here is the summary with links:
  - [net,v2] sock_map: avoid race between sock_map_close and sk_psock_put
    https://git.kernel.org/netdev/net/c/4b4647add7d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



