Return-Path: <bpf+bounces-72368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FA8C114E9
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 21:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2129A426A75
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 20:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586DA31E0F7;
	Mon, 27 Oct 2025 20:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXEvNlGu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC7B1CDFAC;
	Mon, 27 Oct 2025 20:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761595532; cv=none; b=YHvIfTOdTJjPnNZPfM07yEuDBaGA5P7z9F/UtHuwcwBfB4icATJNUwaYc0UkX8DJs3ZQGiDO85ngEqAouvFj43UpwJs8b00ThVWrz/0U2wBjIEg+kziBYox1kFk+K3GpUHQoWFR7Eh/+I7d6KKdsXxiy0XBE215HVIG4KrrTkjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761595532; c=relaxed/simple;
	bh=1XlzM+jAXF2KkKQm0DOR3UvVjTCMQIwuND6ijwUR7xY=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=uv7crseSLPvz5hXslla3VNYLQY3GASFmyzwKgpLGH4vKRbXS/MCv3gZvRUF1U4bZK8reWKZfhQTMRzMD9QJbiOD0R+JmJtmkeX8vz5UQwbPHN+yHou2lM/AZ8SYiatncILipsLodTBI8+36TO3WDqoGFr/U0p8suAIIOlZpVmAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXEvNlGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC3CC4CEF1;
	Mon, 27 Oct 2025 20:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761595531;
	bh=1XlzM+jAXF2KkKQm0DOR3UvVjTCMQIwuND6ijwUR7xY=;
	h=Subject:From:To:Cc:Date:From;
	b=EXEvNlGui5KgTr+ppiMJGdRJoLOwgsQlTuA1qHK4sJtKWZ1IotN3MQD7NrWqvRkz7
	 4Lre7J+H82DLsM3RP95GQnA4uChAJ3oEqqkDFMFqs6C7XFzvIuxwVEi5lmqvrTWItU
	 xhOZYUH4Y+6YyIM3mfA7urNlgaU2Ti8pQTxn4cuiVJ72iw2O2gJ3HZml9AdXxkaq+F
	 sdUeV1OwYNIGHdi73T8lC7aLP2fYoSoqng3QRmG1L212L0SU0w4MT/6N83c/oU5p4W
	 W9brh4mTXgzBbyRdxlvnZ2on8xP3H8iunN3r4JT9mDzcu+8dXDyFimPKU49s+DanMM
	 jZr1S+JvDq9gQ==
Subject: [PATCH net V2 0/2] veth: Fix TXQ stall race condition and add
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
Date: Mon, 27 Oct 2025 21:05:25 +0100
Message-ID: <176159549627.5396.15971398227283515867.stgit@firesoul>
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

V2:
 - Drop patch that changed up/down NDOs
 - For race fix add a smb_rmb and improve commit message reasoning for race cases

V1: https://lore.kernel.org/all/176123150256.2281302.7000617032469740443.stgit@firesoul/

---

Jesper Dangaard Brouer (2):
      veth: enable dev_watchdog for detecting stalled TXQs
      veth: more robust handing of race to avoid txq getting stuck


 drivers/net/veth.c | 53 +++++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 19 deletions(-)

--


