Return-Path: <bpf+bounces-71934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5DDC01F59
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 17:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9263B4E62C6
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 14:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663203328F2;
	Thu, 23 Oct 2025 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+ppGgVp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA750331A43;
	Thu, 23 Oct 2025 14:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231570; cv=none; b=AfohWi4eAePnZB7l2RtXB4M7TX4wk18KC9Ir2dZ8KFbKW0zDMLKXGaex6SvqyHUIwxPv0skoNBpOsh1JMHMCiR97URgCQLhsZyuyyAozfOt+ZVZAUfQac23bJOhwd3+1z20eiZKZtY7gSJsHVFjn04kALvnxnq4KnH/OTUoNvxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231570; c=relaxed/simple;
	bh=GPdBabhVMz00PmjPDHJUDEisRq2eynd1CMSKt9Sw9TA=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=mPTqmzO6dKXAeNulO/7XSvKu94F4eDPg4mvmjIsluwxGp0W4RC8GksK0aIis3flnBjMlwAV+3Dwpg/ImkjrJ0yzSH+0/P9rqVLD8PwwD0B/MB0lltBnIKkaJclxpwW2O1barZ6W5/I8rueycC7H7oHxESFH3SXRilVcPnlxQ0S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+ppGgVp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE1AC4CEE7;
	Thu, 23 Oct 2025 14:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761231570;
	bh=GPdBabhVMz00PmjPDHJUDEisRq2eynd1CMSKt9Sw9TA=;
	h=Subject:From:To:Cc:Date:From;
	b=M+ppGgVphmKfECZdCOOPQfYPGmq/JPz6FfeRfP2Bz8vorg294mFTgWW7YG3sAqJJC
	 xUufkWyFPYsFnG3oKONq3swouaevuvb5L6v33YLzTqGE9/Nxjx/VWkgS4uyU79VuyL
	 Ugq3imSvxQBD4xO5WQARzQuukwGAU0dPTh2SWUVskCAzs04fySl80h+z5Y1qEIkuOY
	 hC5OL4wKw7HwOEFchrNh5V46Bx9G4fI+ZDTl6SQM+2WRh9rUUri2/eORCbtiODCwcm
	 9dAPE4llvruXFVhOycDDlqA+jG2fIWz/6eL3H+AsiR/DRJANDSX5nMI0h+Fu8sTaVm
	 /8v2DlEwGLDOw==
Subject: [PATCH net V1 0/3] veth: Fix TXQ stall race condition and add
 recovery
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, makita.toshiaki@lab.ntt.co.jp
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, ihor.solodrai@linux.dev,
 toshiaki.makita1@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Date: Thu, 23 Oct 2025 16:59:24 +0200
Message-ID: <176123150256.2281302.7000617032469740443.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This patchset addresses a race condition introduced in commit dc82a33297fc
("veth: apply qdisc backpressure on full ptr_ring to reduce TX drops"). In
production, this has been observed to cause a permanently stalled transmit
queue (TXQ) on ARM64 (Ampere Altra Max) systems, leading to a "lost wakeup"
scenario where the TXQ remains in the QUEUE_STATE_DRV_XOFF state and traffic
halts.

The root cause, which is fixed in patch 3, is a racy use of the
__ptr_ring_empty() API from the producer side (veth_xmit). The producer
stops the queue and then checks the ptr_ring consumer's head, but this is
not guaranteed to be correct, when observed from the producer side,
when the NAPI consumer on another CPU has just finished consuming.

This series fixes the bug and make the driver more resilient to recover.
The patches are ordered to first add recovery mechanisms, then fix the
underlying race.

---

Jesper Dangaard Brouer (3):
      veth: enable dev_watchdog for detecting stalled TXQs
      veth: stop and start all TX queue in netdev down/up
      veth: more robust handing of race to avoid txq getting stuck


 drivers/net/veth.c | 59 +++++++++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 19 deletions(-)

--


