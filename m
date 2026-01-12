Return-Path: <bpf+bounces-78620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89346D1559B
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 22:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFB863045CD3
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 21:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A75E340D86;
	Mon, 12 Jan 2026 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgkcLwAs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0276A333427;
	Mon, 12 Jan 2026 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768251620; cv=none; b=RGLpVaPH9dflsjJFtIRuCDxo/BgjiQRZeKED0eDyi4yrQbBip6EiPQKOxBD7VViRj8llfF65K3Hh+zA+fQW4+CfD6I7nCoWikpfCatLian22yUAxwt56jRt776sNUWZWwXKgk8gGWoaAw8IjJHTcKBocRfjidhemkBqJLQPKupA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768251620; c=relaxed/simple;
	bh=6MvNfPDEFcfkquy8gkIp2qFI3WAKNMNlg7aMEqc5UPQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ERtHecbpFTVvUQgoq3mKiP8eIaz9kHj/5fxQKXiHsqsv8ctGXjxn88VXglqXaimvyjX1QOq4TBY6lGUgTQykhVsClf6SFc9HUIaNTKlvxFf951EUK6TvvsMO1SOt+iLThXmKpjAqx8u1KA0Jc/HLs84ZKW4hkOgZ1Vs4XF/ptMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgkcLwAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E83C19421;
	Mon, 12 Jan 2026 21:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768251619;
	bh=6MvNfPDEFcfkquy8gkIp2qFI3WAKNMNlg7aMEqc5UPQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LgkcLwAsPnG17Go3if3ARUaYuY6re3WqdWam724Cf73tWVhHlbqqCgvwrF++2XyXy
	 kOKhDWMIqvR5mU1NtNU17VXiLcVjpbvyTFtMS3RWsvxmXwmmL9/9eDNU7cIrqRcbHk
	 jqMuQ3inTaS3LMDX5R1JgacNIdUvO1cz/iD21E2hvoMuMgMjYHp49zV1XtsTDB09+W
	 hJw6WXswv3FzQQsIrvwpSlxXw84bdcAm6qGrqCYqB+3WUenRoxILEkAm7D17yYI+k9
	 68nNnbFdp7FPPgsEylEuftWqYjRsrajx/KluUEcpzmTHYh7mMtD4uMcIJi0/7hMql5
	 a9Av7ANHpOfhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2CF0380CFD5;
	Mon, 12 Jan 2026 20:56:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/3] virtio-net: fix the deadlock when disabling rx
 NAPI
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176825141377.1092878.9401605106447575333.git-patchwork-notify@kernel.org>
Date: Mon, 12 Jan 2026 20:56:53 +0000
References: <20260106150438.7425-1-minhquangbui99@gmail.com>
In-Reply-To: <20260106150438.7425-1-minhquangbui99@gmail.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 Jan 2026 22:04:35 +0700 you wrote:
> Calling napi_disable() on an already disabled napi can cause the
> deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
> when pausing rx"), to avoid the deadlock, when pausing the RX in
> virtnet_rx_pause[_all](), we disable and cancel the delayed refill work.
> However, in the virtnet_rx_resume_all(), we enable the delayed refill
> work too early before enabling all the receive queue napis.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/3] virtio-net: don't schedule delayed refill worker
    https://git.kernel.org/netdev/net/c/fcdef3bcbb2c
  - [net,v3,2/3] virtio-net: remove unused delayed refill worker
    https://git.kernel.org/netdev/net/c/1e7b90aa7988
  - [net,v3,3/3] virtio-net: clean up __virtnet_rx_pause/resume
    https://git.kernel.org/netdev/net/c/a0c159647e66

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



