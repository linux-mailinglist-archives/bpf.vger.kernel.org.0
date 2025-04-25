Return-Path: <bpf+bounces-56698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01382A9CC22
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 16:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CACA97B77E4
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 14:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74825259C9A;
	Fri, 25 Apr 2025 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPuuKYEV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F102594B7;
	Fri, 25 Apr 2025 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745592931; cv=none; b=qMn7kyESrU7yvg1XkJfa6vqWKKlA4+I6J0XE+ZmZPm//1wsl/sFkC/s+q1KXd5/SXfNwU7GP49N8fyeN+lruWJjQRXKlI6wZRZF35B9nFn25HEsr2/KMtWe2JyqBLAWBEL4jRFQG6tZk2mopnn/V6w9UGbauNnpkBe55eHTIqcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745592931; c=relaxed/simple;
	bh=Lr5mCcsmL9kbOt7KXF2Z8uSBQg+PFUBZ+HPfspBmrv8=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=TvFSw3Xb9ISRcsA+S8pOELBu+E6quD63IDATRI/4WLYLL1+1WE9FFW9U1mcMn/kGNYP1OeSd6bmJL3DIXqN5yrTCiliY4Zn9DJGbUk2GvHp1aPoYVuGJSXf1SCtUx3uUJObK0V8WM4l5WLLjXWbRa9S4G0yNWYxyjd0gFpj8ZpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPuuKYEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7E7C4CEE8;
	Fri, 25 Apr 2025 14:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745592930;
	bh=Lr5mCcsmL9kbOt7KXF2Z8uSBQg+PFUBZ+HPfspBmrv8=;
	h=Subject:From:To:Cc:Date:From;
	b=gPuuKYEVR1MIqwG1ScCS9cyY53MFvchClw9fq+G7LR7By/9gMWoNoFPwGyT+kEAc/
	 OqJ3n56GDsuxidpYkNV10HpKh2DH1NzzWcSZHiWR4Fj0GvioENjlCPwrBVH/Lu/cnR
	 KeEDFFZA7RcBL4LDsNL7f5LdtXL/BHzQ8aWl2PvAgl3dBZ1XPH+ugDueVWGMVERQBm
	 ftx2XRQaEKIqggS9d3v9KZAQ/6juSfOvI7J0Nf0rJbV9WYe9oNUIXNo52WH8T1SoN4
	 BaOL6Kxj2N51NQ94d2ZdruF7dZsKRLkHQqpx7Lwj1YHOutnabcvCrqaJlFgi7vqE/m
	 EmAFk0ILJG6Gg==
Subject: [PATCH net-next V7 0/2] veth: qdisc backpressure and qdisc check
 refactor
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 tom@herbertland.com, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 dsahern@kernel.org, makita.toshiaki@lab.ntt.co.jp,
 kernel-team@cloudflare.com, phil@nwl.cc
Date: Fri, 25 Apr 2025 16:55:25 +0200
Message-ID: <174559288731.827981.8748257839971869213.stgit@firesoul>
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
V7:
 - Adjust race handling with smp_mb__after_atomic() for other archs than x86
 - Link to V6: https://lore.kernel.org/all/174549933665.608169.392044991754158047.stgit@firesoul/
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


 drivers/net/veth.c        | 57 ++++++++++++++++++++++++++++++++-------
 drivers/net/vrf.c         |  4 +--
 include/net/sch_generic.h |  8 ++++++
 3 files changed, 56 insertions(+), 13 deletions(-)

--


