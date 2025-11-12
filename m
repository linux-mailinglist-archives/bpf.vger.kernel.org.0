Return-Path: <bpf+bounces-74291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 843B3C52785
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 14:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4822042541D
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 13:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE4E2741AC;
	Wed, 12 Nov 2025 13:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHZN+FnV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF4C30C364;
	Wed, 12 Nov 2025 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762953231; cv=none; b=h0qhDvsVPphwu3SUUJmcveRL7mOuq7aRr4FyBmE59YsnmMweYUOMoxhJ+vdnXMFh8CXIQ+LqMGE4C13pSHhUVJBJ+XDExhg6+woX6oLi8ngd6zZYWBqvP3FFjMx2QTrzWF9U39vuQ7oqXY0PGesbUaGFwlRw2ZXRhG5u2DxW1gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762953231; c=relaxed/simple;
	bh=dvz7hRmiuiAhbxgowOiFwTCdoSQOqn4Z/6EIk6czuZs=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=hpn2jV/Y0gI3TaGNvRRx7DSb8hMXvM41J4IqdRcbYwCBd+NFHyF4HUe68cZ7/yoICQXbuQpiBJsyCyuuBcqGmOLw4swgG8KmFu5duY/nTTqV2ZBuNYV4UGypmSDRg+5irAwKbJg57xQUQbJGJcBLTZhS0DliZeq2pLx9Aax5FLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHZN+FnV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47389C4CEF8;
	Wed, 12 Nov 2025 13:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762953231;
	bh=dvz7hRmiuiAhbxgowOiFwTCdoSQOqn4Z/6EIk6czuZs=;
	h=Subject:From:To:Cc:Date:From;
	b=LHZN+FnV1ZxAOGspdw1QFuAH/vbK0L2ttX08AKV1nQ5VBW4DLCFpDgSj7S/smKYI5
	 b1bece4HG6ckAzOjBQAq0m2f/J23jNVKcLFufbnUB+3JKVrrTKVI3eYVtM2UDYZO+/
	 IRL6D1U03rkIoRlgb3hSJ5jXB3gW+i3FpO0V4LP850Bhr+xiVkc+RfBxFf6gM+lx5N
	 K7V4v4OCnZ97azw/uA0XwEzoxhRH73+7KealfQ2yXQ9c17wKPw/Aw0TiOue5yX8AIy
	 bKPYs2kNeZX+bKME+LgA/xFrUP2pSiryuRRtCyJF8FFA9hOjzXUfGLbog4yuxJrxQl
	 qngVtDQrz05vg==
Subject: [PATCH net V4] veth: Fix TXQ stall race condition
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
Date: Wed, 12 Nov 2025 14:13:46 +0100
Message-ID: <176295319819.307447.6162285688886096284.stgit@firesoul>
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

The root cause is a racy use of the__ptr_ring_empty() API from the producer
side (veth_xmit). The producer stops the queue and then checks the ptr_ring
consumer's head, but this is not guaranteed to be correct, when observed from
the producer side, when the NAPI consumer on another CPU has just finished
consuming.

This series fixes the race bug, making the driver more resilient to recover is
postponed to net-next as maintainers don't see this as an actual fix.

V4:
 - Focus on race fix for stable net-tree
 - Watchdog recovery patch is postponed to net-next tree

V3: https://lore.kernel.org/all/176236363962.30034.10275956147958212569.stgit@firesoul/
 - Don't keep NAPI running when detecting race, because end of veth_poll will
   see TXQ is stopped anyway and wake queue, making it responsibility of the
   producer veth_xmit to do a "flush" that restarts NAPI.

V2: https://lore.kernel.org/all/176159549627.5396.15971398227283515867.stgit@firesoul/
 - Drop patch that changed up/down NDOs
 - For race fix add a smb_rmb and improve commit message reasoning for race cases

V1: https://lore.kernel.org/all/176123150256.2281302.7000617032469740443.stgit@firesoul/

---

Jesper Dangaard Brouer (1):
      veth: more robust handing of race to avoid txq getting stuck


 drivers/net/veth.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

--


