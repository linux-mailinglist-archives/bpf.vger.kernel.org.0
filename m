Return-Path: <bpf+bounces-55953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 118F7A89FCB
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 15:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E29D3BBE32
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 13:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D8217A2EE;
	Tue, 15 Apr 2025 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVQ0cT9X"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4377E14B96E;
	Tue, 15 Apr 2025 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744724698; cv=none; b=EPmLZLvzbr7A+IS9QBSSL2d+TRhzKb+64dbOmrMz0NrPzW7L8A02hnK7P8eJHpue6h7bglTpDI1X6gco0Rem3O00xcgox8GutSAnuFZBXb4sTvKKBbQ8WKTaO73bFwoWBi8iU4oeLZI/TeGKSzoMboWKmio7i5OBvYbjg4O/pGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744724698; c=relaxed/simple;
	bh=wvOZ/SKOc7gQNU/q6AtBQ+SEWm/lhwPgfJk6z9WhYr4=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=DTF/UbA474y/N5L5K7ZFiONZXtCF2fdIImHO7DJ6xpmpS75p9VQzm+ZDyyWGyW6FrSCPezlucD9rjRiO4r2jdzUdwxxLwpenvR/lzAG7r9dXRTUSiIZSps5h9oWx5FsNwVb2IOKyCv6hnZeeIg1HgG1dzLrA1jMrXxv3N+shOY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVQ0cT9X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42270C4CEEB;
	Tue, 15 Apr 2025 13:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744724697;
	bh=wvOZ/SKOc7gQNU/q6AtBQ+SEWm/lhwPgfJk6z9WhYr4=;
	h=Subject:From:To:Cc:Date:From;
	b=jVQ0cT9XWaiXBT/gRKFhQOqpzkP/peXvklQV4RsCWHeLj7KwcjMO/nnEeMdgV4YTA
	 1mSgwipePwDb+mRqKsghhb0ams0uUv1OodHsT+cWqHG5tKOl/UNTsZGPkBv96GTZqq
	 DbQ3j8OWIYxynG4ZAmcMcLNYjwmojEXvcsMmNCaslQBz8A8SPL7rZTBWWC/yb2FEVO
	 kDg1ZJU436sNVZhR7tAWK/SxdpK1uxp5Ao5D300T+B9ZQs+fXlYy76rOsl2npoCw0A
	 2B09cNW/1rjInT8w4UxXp0cLwOPtIqGqlI20RG0I2caqyN0Nwby27aRJgbEu3bqdIw
	 ER7BelnowdUaw==
Subject: [PATCH net-next V4 0/2] veth: qdisc backpressure and qdisc check
 refactor
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 tom@herbertland.com, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 dsahern@kernel.org, makita.toshiaki@lab.ntt.co.jp,
 kernel-team@cloudflare.com, phil@nwl.cc
Date: Tue, 15 Apr 2025 15:44:52 +0200
Message-ID: <174472463778.274639.12670590457453196991.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This patch series addresses TX drops seen on veth devices under load,
particularly when using threaded NAPI, which is our setup in production.

The root cause is that the NAPI consumer often runs on a different CPU
than the producer. Combined with scheduling delays or simply slower
consumption, this increases the chance that the ptr_ring fills up before
packets are drained, resulting in drops from veth_xmit() (ndo_start_xmit()).

To make this easier to reproduce, we’ve created a script that sets up a
test scenario using network namespaces. The script inserts 1000 iptables
rules in the consumer namespace to slow down packet processing and
amplify the issue. Reproducer script:

https://github.com/xdp-project/xdp-project/blob/main/areas/core/veth_setup01_NAPI_TX_drops.sh

This series first introduces a helper to detect no-queue qdiscs and then
uses it in the veth driver to conditionally apply qdisc-level
backpressure when a real qdisc is attached. The behavior is off by
default and opt-in, ensuring minimal impact and easy activation.

---
V4:
 - Check against no-queue instead of no-op qdisc
 - Link to V3: https://lore.kernel.org/all/174464549885.20396.6987653753122223942.stgit@firesoul/
V3:
 - Reorder patches, generalize check for no-op qdisc as first patch
   - RFC: As testing show this is incorrect
 - rcu_dereference(priv->peer) in veth_xdp_rcv as this runs in NAPI
   context rcu_read_lock() is implicit.
 - Link to V2: https://lore.kernel.org/all/174412623473.3702169.4235683143719614624.stgit@firesoul/
V2:
 - Generalize check for no-op qdisc
 - Link to RFC-V1: https://lore.kernel.org/all/174377814192.3376479.16481605648460889310.stgit@firesoul/

Jesper Dangaard Brouer (2):
      net: sched: generalize check for no-queue qdisc on TX queue
      veth: apply qdisc backpressure on full ptr_ring to reduce TX drops


 drivers/net/veth.c        | 49 ++++++++++++++++++++++++++++++++-------
 drivers/net/vrf.c         |  4 +---
 include/net/sch_generic.h |  8 +++++++
 3 files changed, 50 insertions(+), 11 deletions(-)

--


