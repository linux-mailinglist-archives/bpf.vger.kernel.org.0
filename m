Return-Path: <bpf+bounces-56137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 050BFA91EE8
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 15:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF178A31AB
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 13:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2F52505B4;
	Thu, 17 Apr 2025 13:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOdsGfKo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A2624EABC;
	Thu, 17 Apr 2025 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898107; cv=none; b=KgpB2UxK3FM0kXoh3j2jIJ/H1XZJpZsgRBngbVvjdtsxB2LtMqYTIMhYb1dlXpwy+c1ITIJ6uiVoj6n7YSysKSdaUywOiGKP0RziRYXsfAWZGuO4lNSQN1bNlr0l2xBYs7FlseID95n+aLguyf0Ut9M4+NtQlkLX0uhLxhneokk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898107; c=relaxed/simple;
	bh=kikyls/Flbvvf3iZL5T+aAZQiRp9n1HQT7ciNWS5aG4=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=mXcCuHswq7CKTQFiR//nxcgWiwDTRXu4QSfUBbn6+E7e/RsNWj9rcicXEg94H4r72vZ+54kyYSGo6ZOAmLENqrlnsQssBctKe1O2cnabNha1/VYPRHOzlvhJhkXiYGtVy1MmKRpJtRQY93/hquFLktdAVctS5JXGmvnkmaLhtJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOdsGfKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29781C4CEEB;
	Thu, 17 Apr 2025 13:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744898107;
	bh=kikyls/Flbvvf3iZL5T+aAZQiRp9n1HQT7ciNWS5aG4=;
	h=Subject:From:To:Cc:Date:From;
	b=iOdsGfKoABtNFQhGJqce6/BZwC45sVmtLczYZs/tEvnqgiXOkUgkk0KpfiE3ebgR7
	 wO4LFjTXaKV26G+Hm1xw+8YnsEjMRJJxdK+B3RcQYIezP+JoUuRPeuRNariARlj0zO
	 vgWBbKijfZDADuZx3Cnbg8BhCJSDbWNfGYKkSQhxbWQ1TecmmKMIhPx74O3JGyugLQ
	 K+X/dmwBysshOM4Y9J66P2qFJVg+xz4k86ot+JtUNlFF6ry0Bqq4AFMOyU1geOOJf4
	 XdOCQkkzJZBB/v4Gv+gkjnD7h0//0QOxkmW5D46Q06OuOAWgy98Jr4VDa2bAU0E8xj
	 N6/Y6vY9TvPYA==
Subject: [PATCH net-next V5 0/2] veth: qdisc backpressure and qdisc check
 refactor
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 tom@herbertland.com, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 dsahern@kernel.org, makita.toshiaki@lab.ntt.co.jp,
 kernel-team@cloudflare.com, phil@nwl.cc
Date: Thu, 17 Apr 2025 15:55:02 +0200
Message-ID: <174489803410.355490.13216831426556849084.stgit@firesoul>
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

Jesper Dangaard Brouer (2):
      net: sched: generalize check for no-queue qdisc on TX queue
      veth: apply qdisc backpressure on full ptr_ring to reduce TX drops


 drivers/net/veth.c        | 55 ++++++++++++++++++++++++++++++++-------
 drivers/net/vrf.c         |  4 +--
 include/net/sch_generic.h |  8 ++++++
 3 files changed, 54 insertions(+), 13 deletions(-)

--


