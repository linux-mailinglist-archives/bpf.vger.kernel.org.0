Return-Path: <bpf+bounces-56598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D89A9AE0E
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 14:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD6E1B65AC2
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 12:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438DB27B51C;
	Thu, 24 Apr 2025 12:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVmbfga6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DF12701AA;
	Thu, 24 Apr 2025 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499402; cv=none; b=WSgv7+BYyy8NvT0C/R/9w6VwfYxYT7nRDBPFd4WOfSKNyQp79tVDBuu8f7wuCMMOI8DW/rx4H9zbo2KalmRqLiQ6Sv+8RDkrDju+16gZP/tJzo5uWh8OofNo3j592fGrBB2k7iH9VYVeZxBu3Lhz5hs3L8+/Jby1eMxOd0Xu57A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499402; c=relaxed/simple;
	bh=RWmH8wRKsLF9s3sl2NicF4BvAZMdu1HgMiqbSAOsRxw=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=WvDLhUW6TBRmKLFiRU9FbYhzmhKJIXNuIJpsNL1tdPq58w8zt2uyr3fek6v2Anrul4ykapVEhRn/Pmcoz6qCIr7VjD5XNE1Jaj2OntXGQw4pKs5s3fgjXar8epGzhAaNFgWzQoC8N/pCA7jSKxWQ2LGvs6SugdahRenXfPLyVHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVmbfga6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25E6C4CEE3;
	Thu, 24 Apr 2025 12:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745499402;
	bh=RWmH8wRKsLF9s3sl2NicF4BvAZMdu1HgMiqbSAOsRxw=;
	h=Subject:From:To:Cc:Date:From;
	b=PVmbfga6LPC2iTe4XzIQgU6/mD35HeOqDFVLfINcUkVIOa9zoEr65jQ0ZCX4NaoOP
	 bcV0/gyMZSzjmJCIftpjeTGi2bF4wxQonH+HI7VRItvUjeOThPwG8swgPCiQTtabID
	 Gtd4Nph5s3VnjoERv44Bz1GskJqfWyTmLs9ULaM8mJ3jgV7w87phalBxs4l6YvTPUe
	 PvZvY8kZ0/dRQv0oMONVdLDI6UfV+0THjvZsnDW/hVf9jHwIVgAWG3NS83/UXaNz/H
	 MmseRbobYtdH+/CsKNVgpwh+7PVHLsDIoETOckX0n6bj3wDAgswj9Omji53XKrWX/l
	 t6pc0cHM+X/rQ==
Subject: [PATCH net-next V6 0/2] veth: qdisc backpressure and qdisc check
 refactor
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 tom@herbertland.com, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 dsahern@kernel.org, makita.toshiaki@lab.ntt.co.jp,
 kernel-team@cloudflare.com, phil@nwl.cc
Date: Thu, 24 Apr 2025 14:56:37 +0200
Message-ID: <174549933665.608169.392044991754158047.stgit@firesoul>
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
V6:
 - Remove __veth_xdp_flush() and handle race via __ptr_ring_empty instead
 - Link to V5: https://lore.kernel.org/all/174489803410.355490.13216831426556849084.stgit@firesoul/
V5:
 - use rcu_dereference_check to signal that NAPI is a RCU section
 - whitespace fixes reported by checkpatch.pl
 - handle unlikely race
 - Link to V4 https://lore.kernel.org/all/174472463778.274639.12670590457453196991.stgit@firesoul/
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
---

Jesper Dangaard Brouer (2):
      net: sched: generalize check for no-queue qdisc on TX queue
      veth: apply qdisc backpressure on full ptr_ring to reduce TX drops


 drivers/net/veth.c        | 56 ++++++++++++++++++++++++++++++++-------
 drivers/net/vrf.c         |  4 +--
 include/net/sch_generic.h |  8 ++++++
 3 files changed, 55 insertions(+), 13 deletions(-)

--


