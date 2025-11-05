Return-Path: <bpf+bounces-73674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C39C37270
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 18:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 118AD50159E
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 17:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A63833CEA3;
	Wed,  5 Nov 2025 17:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDEqUtVL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38F833BBA8;
	Wed,  5 Nov 2025 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762363692; cv=none; b=ckf6ox51UWMWQ6vq0cShsBIkshH2ZP7aii3aHm4xZpfcbbisyMRVJyqa5zIOUCD6wimjEzjZB7f9wso2CN28Z0HoL+99VKWa4lId5C8N8Xc4qgJEkb8Jk+9qO7neabj6hMwz1Bmhui1nQgBtfPNi+YKg775m5n7fc7bareHm7jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762363692; c=relaxed/simple;
	bh=ERKAY8Ws1C+XCC1klXumtr0c4Gaw9L4lTI2G4NjbIgE=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=WQGjvEXHpgeGWzqIOxiNMAQsc4y0IaGcz0PlL+eeJubOe0Q2myvUB3lv1uC7MPwFoSVhq+Nxq1BZ+Q0X9UzeTFDJSRHpXDB4nsXEW0tUklj0FAk92KSokB4Gubvz+UTa62bz2B64ESAYCoxh0uyQpVGiodq33s66kSjDMAvJWe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDEqUtVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3E6C4CEF5;
	Wed,  5 Nov 2025 17:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762363691;
	bh=ERKAY8Ws1C+XCC1klXumtr0c4Gaw9L4lTI2G4NjbIgE=;
	h=Subject:From:To:Cc:Date:From;
	b=FDEqUtVLgOdOiuHgM+SD/ha3/X2vwQhaWMGHaZ7i7AaCGPjKmM7/ydE42o8gBSKr1
	 DvAXMQDkDAlf1iHhLMQR9guSpM7PDp3BH07YEAVv8oKP8CflS/qPs4xDzO98KD9Fzv
	 QG6IWN7kK6OV28+j45w12tCz91MOCBIXXiE1dUZXMLfPBXp/sqPnfJHJr1rnL+l9RI
	 TAjc/WwXoQ+kwG6ZdaDZUZIRSV92y+j3QvRFW5tRoCIPZIkyWgK2B0TzKjLBd/N9r9
	 7IzdYWlL7SvJkuQlrYVLJCArO/LpSUytfOUsxGHI66DJFC1JPYm/6AKo6lVAiQA/co
	 PrKEsNJ8JriBg==
Subject: [PATCH net V3 0/2] veth: Fix TXQ stall race condition and add
 recovery
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, ihor.solodrai@linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>, makita.toshiaki@lab.ntt.co.jp,
 toshiaki.makita1@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel-team@cloudflare.com
Date: Wed, 05 Nov 2025 18:28:06 +0100
Message-ID: <176236363962.30034.10275956147958212569.stgit@firesoul>
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

The root cause, which is fixed in patch 2, is a racy use of the
__ptr_ring_empty() API from the producer side (veth_xmit). The producer
stops the queue and then checks the ptr_ring consumer's head, but this is
not guaranteed to be correct, when observed from the producer side,
when the NAPI consumer on another CPU has just finished consuming.

This series fixes the bug and make the driver more resilient to recover.
The patches are ordered to first add recovery mechanisms, then fix the
underlying race.

V3:
 - Don't keep NAPI running when detecting race, because end of veth_poll will
   see TXQ is stopped anyway and wake queue, making it responsibility of the
   producer veth_xmit to do a "flush" that restarts NAPI.

V2: https://lore.kernel.org/all/176159549627.5396.15971398227283515867.stgit@firesoul/
 - Drop patch that changed up/down NDOs
 - For race fix add a smb_rmb and improve commit message reasoning for race cases

V1: https://lore.kernel.org/all/176123150256.2281302.7000617032469740443.stgit@firesoul/

---

Jesper Dangaard Brouer (2):
      veth: enable dev_watchdog for detecting stalled TXQs
      veth: more robust handing of race to avoid txq getting stuck


 drivers/net/veth.c | 50 +++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 18 deletions(-)

--


