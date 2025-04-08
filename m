Return-Path: <bpf+bounces-55468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BBAA81049
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 17:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63CFE8C3719
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 15:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E4422F175;
	Tue,  8 Apr 2025 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fH+P75IH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351EC229B23;
	Tue,  8 Apr 2025 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744126278; cv=none; b=QhZA3vviRvBNZtiflshTfne65qID8gKcWfaJB4TzHMxoiOOjGfHCzSMqDQ0ghWPJkNPfruyo6RBiX3B7+uEanp9tjTq8Jk9MFNE2ZT9AwE8KkP58hIPXDBFPbr91TuTAu56fXjqaTIt0FFstxzbdJIijrZCadUZ+SYNe10MB6uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744126278; c=relaxed/simple;
	bh=gIc64Fn/mEKKOPm/r9X07rUsmYpa1Dp6dSB8roKpclw=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=H86SrbEEwYUZC6tYg5GZkBLIfyzccGfGELQ1/K2nhvqn1dnEbHbj4TP98vuUSD65M05z1KhddhlbDKYPL9wJ7eChBtNFqMTXqqzPqvMj1UOWIim9NC4xDDycfIp6LIAaR20HQXBWC6IlksIhzgJGztbLoXaDWaE2i5N9OpvknOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fH+P75IH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74071C4CEE5;
	Tue,  8 Apr 2025 15:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744126277;
	bh=gIc64Fn/mEKKOPm/r9X07rUsmYpa1Dp6dSB8roKpclw=;
	h=Subject:From:To:Cc:Date:From;
	b=fH+P75IHuJLHANPIxPmxWT24w/v8ef8HgiPKOUXKSh4pkoC/SFsfE4MfSvcjV3XLB
	 nPMCk5waTUcgzpjjkG0e6+9SuYAzcUEaTCg8emRLWFm+TAgypfKXR5VtCutiTXLyuB
	 AbHZpic7N2MgaHOuqVe3wfLhYXYNSQ88pIxOvF6YEKxaUE2b5oCJMzFSIU19uDeMYy
	 71oWgnbAw7erdkJ1fju7o7KEgikD5DJztp+39IXHq7KFF/M3y4eI3GmO356pShIize
	 tsSFr2+xEMETbFSCt1ZJgN5WgTl63gXSv/eXtFI6mJHwduHk2T1RC+gVl13AV5nUAw
	 2Z9jGZpOzTJvQ==
Subject: [PATCH net-next V2 0/2] veth: qdisc backpressure and qdisc check
 refactor
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 tom@herbertland.com, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 dsahern@kernel.org, makita.toshiaki@lab.ntt.co.jp, kernel-team@cloudflare.com
Date: Tue, 08 Apr 2025 17:31:13 +0200
Message-ID: <174412623473.3702169.4235683143719614624.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This series addresses TX drops observed in production when using veth
devices with threaded NAPI, and refactors a common qdisc check into a
shared helper.

In threaded NAPI mode, packet drops can occur when the ptr_ring backing
the veth peer fills up. This is typically due to a combination of
scheduling delays and the consumer (NAPI thread) being slower than the
producer. When the ring overflows, packets are dropped in veth_xmit().

Patch 1 introduces a backpressure mechanism: when the ring is full, the
driver returns NETDEV_TX_BUSY, signaling the qdisc layer to requeue the
packet. This allows Active Queue Management (AQM) - such as fq or sfq -
to spread traffic more fairly across flows and reduce damage from
elephant flows.

To minimize invasiveness, this backpressure behavior is only enabled when
a qdisc is attached. If no qdisc is present, the driver retains its
original behavior (dropping packets on a full ring), avoiding behavior
changes for configurations without a qdisc.

Detecting the presence of a "real" qdisc relies on a check that is
already duplicated across multiple drivers (e.g., veth, vrf). Patch-2
consolidates this logic into a new helper, qdisc_txq_is_noop(), to avoid
duplication and clarify intent.

---

Jesper Dangaard Brouer (2):
      veth: apply qdisc backpressure on full ptr_ring to reduce TX drops
      net: sched: generalize check for no-op qdisc


 drivers/net/veth.c        | 49 ++++++++++++++++++++++++++++++++-------
 drivers/net/vrf.c         |  3 +--
 include/net/sch_generic.h |  7 +++++-
 3 files changed, 48 insertions(+), 11 deletions(-)

--


