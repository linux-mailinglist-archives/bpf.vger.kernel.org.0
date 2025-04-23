Return-Path: <bpf+bounces-56476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B90CDA97C7F
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 03:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B197E1B618B6
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 01:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895F1265CAE;
	Wed, 23 Apr 2025 01:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMqDL6ga"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1163263F2B;
	Wed, 23 Apr 2025 01:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745372991; cv=none; b=r6tudF9CLgbi9hEw8iE+wH11D4S3hAORNUYZIPuXHJIm07yEFWsVkFd9UIqs2BDoRAD9SgzsDCz/hhtNfyIa0t5lE4evp3c2uEFAznLHVgzg8JCY7YRxHKjmQikvGVXpyd4BTpLi9XhM6QEiTIM3IM6AWQaW6lcs2kjKXa3HFF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745372991; c=relaxed/simple;
	bh=QxEqK4cbT808ELsKax+8p0w2UjvmBOkBNaPB8xPHKI0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FkUmokrMd43VBYmyfgA20UdNPS+Ykyug340Aqv0awR94SxCMy0ckLOVpkA5fHFnzNodPFDvAiSCSIBeS0l9vlmtG19A8R5XlUFUgTCHqGUDYGatj0WnKaQyjV1Wg+VkF8HxVBTFZ/ZzHH/8YhOZJQb2+/UVv8gfHFvBegd2gtjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMqDL6ga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E7AC4CEE9;
	Wed, 23 Apr 2025 01:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745372990;
	bh=QxEqK4cbT808ELsKax+8p0w2UjvmBOkBNaPB8xPHKI0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oMqDL6gaQ1PJBIb8WuncnlC8rKeAuIxBOoptE52dnZSIzFVX2NRF49ZuY2GXBir8q
	 3G+Mnddyg6c2pzc7MB+7oXQBA1N2tPwUHVjkFFxfM5UcRri/E6DDcYxHoKwXvceLWK
	 qDE61VAN5rPNCfA6xTBtHpg/JnD3biqsxRoLZ5uFEArHoXnTiRQvIS/Z8+q1YxbZUW
	 6gVv2nxcoXuB9ACLmK20ieFP2ogZZhSK1oipFZr4BxCrkE1eBVtnInN5fg4nrqCm9M
	 eY86mTyh+xOXXtWWFtKkHy7Z+N5iOWh25DwgFtCkLNWZsPj5GprJKnTgWD8dn81XqC
	 mbOedOKZs3f7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE67380CEF4;
	Wed, 23 Apr 2025 01:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/4] virtio-net: disable delayed refill when pausing rx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174537302875.2111809.8543884098526067319.git-patchwork-notify@kernel.org>
Date: Wed, 23 Apr 2025 01:50:28 +0000
References: <20250417072806.18660-1-minhquangbui99@gmail.com>
In-Reply-To: <20250417072806.18660-1-minhquangbui99@gmail.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, andrew+netdev@lunn.ch, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, eperezma@redhat.com,
 davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Apr 2025 14:28:02 +0700 you wrote:
> Hi everyone,
> 
> This series tries to fix a deadlock in virtio-net when binding/unbinding
> XDP program, XDP socket or resizing the rx queue.
> 
> When pausing rx (e.g. set up xdp, xsk pool, rx resize), we call
> napi_disable() on the receive queue's napi. In delayed refill_work, it
> also calls napi_disable() on the receive queue's napi. When
> napi_disable() is called on an already disabled napi, it will sleep in
> napi_disable_locked while still holding the netdev_lock. As a result,
> later napi_enable gets stuck too as it cannot acquire the netdev_lock.
> This leads to refill_work and the pause-then-resume tx are stuck
> altogether.
> 
> [...]

Here is the summary with links:
  - [v4,1/4] virtio-net: disable delayed refill when pausing rx
    https://git.kernel.org/netdev/net/c/4bc12818b363
  - [v4,2/4] selftests: net: move xdp_helper to net/lib
    (no matching commit)
  - [v4,3/4] selftests: net: add flag to force zerocopy mode in xdp_helper
    (no matching commit)
  - [v4,4/4] selftests: net: add a virtio_net deadlock selftest
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



