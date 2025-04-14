Return-Path: <bpf+bounces-55861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F87A887A3
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 17:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B67E177246
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 15:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603B127B4FF;
	Mon, 14 Apr 2025 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdsk3Va5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E471F92E;
	Mon, 14 Apr 2025 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744645549; cv=none; b=GP5/zRWrVjUs9OU+JUZnN9wH3EAuR43KraFdWWX+iXK70FFQfwN9DY1vwSrL8/KON1VPVf3NVPRqnojQXFrmgpTVcVsyFpaj7KzwMBcobX+fd9XMMBWMpDybRrruTDJZMwW9v+I0pVhnP4PSH8PwYAKurykAVaC1tpGlaUAMGps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744645549; c=relaxed/simple;
	bh=pokkuci9Ua2697BIHe+4ePZZLg3yOyT4w9tf2GwckOs=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=ZgkTvJjz4ezdvydUAXxNogLj1igHo6YJQMvEt+KrmYccA7Lv19X9aCJL8e/6/exvUwek29x2gAusCZzGPHcC4u8JYs8YJku2gCBxm6s2U1lPLt5i1WlZ4ZPQf/gyp7/q+7/AjkQXBTarzysbSiUCzn3M7W7nZcSi0Vxk9Bd2vg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdsk3Va5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF199C4CEE2;
	Mon, 14 Apr 2025 15:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744645549;
	bh=pokkuci9Ua2697BIHe+4ePZZLg3yOyT4w9tf2GwckOs=;
	h=Subject:From:To:Cc:Date:From;
	b=kdsk3Va5Wb9CtxAtoheWOVO+P1tANfVVLYSp+mCrUkSQ6Uz/mR0RPwMrrZ2/X3uyg
	 ZBzwswtnI8jCsXoeDVqQZEsoYspEtD8e24k1ONN+wWu3p8j3VhAHp/X6cys/I++n+Y
	 pDfeg0xFuYjxViGEi/eyjr9pFHJx9XRYNdRD+zrfsLdnddnPlop8C/r4FCmmTHtAu6
	 4Y9b3RCYirNFZdu5e9hFvMj4x6ZMX2565Ce4PnTidZ/+ZKSO7JAVJsqXf83us5ruJR
	 40EIlzuimU8xPGOLctCUQBpH4+F4VvYypBkR6g/io8nlbsQJ1sYGWLunS+XxZ0CHs4
	 ODiv3BtYaT2ZA==
Subject: [PATCH net-next RFC V3 0/2] veth: qdisc backpressure and qdisc check
 refactor
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 tom@herbertland.com, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 dsahern@kernel.org, makita.toshiaki@lab.ntt.co.jp, kernel-team@cloudflare.com
Date: Mon, 14 Apr 2025 17:45:44 +0200
Message-ID: <174464549885.20396.6987653753122223942.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

RFC: As refactor is incorrect - need help/input from qdisc experts

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

This series first introduces a helper to detect no-op qdiscs and then
uses it in the veth driver to conditionally apply qdisc-level
backpressure when a real qdisc is attached. The behavior is off by
default and opt-in, ensuring minimal impact and easy activation.

---
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
      net: sched: generalize check for no-op qdisc on TX queue
      veth: apply qdisc backpressure on full ptr_ring to reduce TX drops


 drivers/net/veth.c        | 49 ++++++++++++++++++++++++++++++++-------
 drivers/net/vrf.c         |  4 +---
 include/net/sch_generic.h |  7 +++++-
 3 files changed, 48 insertions(+), 12 deletions(-)

--


