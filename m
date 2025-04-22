Return-Path: <bpf+bounces-56391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F69A96C6D
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 15:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7189B7AAE49
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 13:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C957A281528;
	Tue, 22 Apr 2025 13:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="mE+o9NfI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BRFRYenW"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA1828136C;
	Tue, 22 Apr 2025 13:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328235; cv=none; b=X4wrwBrvXIZcUhsBR1AgRupr3udSW9estuSnJRH9ihD5n2qdgDRTRQDI5tlz4ZFb3y2myLaF7t7ZVwGZ54ZrjxDsRM+LVIlsGqtn2z3lPEhSv2h4rnO488Jf0gxenXDdOJALL5sXOpNnVRvNUO/fuR8MQleR18wrFZmX/tL0lC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328235; c=relaxed/simple;
	bh=EW+6cp6GeB4A3T9u70MaBFQ8HcmVCBss5XpBgluP9vA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uy5g4cyPXJVTq1UT6C7P8n+SdMFye6EvPJMrykQXOSXN9Wq3GzK31udgQWgOtKuF1rBSyOig+ZLd0fAj0sa6RTOjmzbu9IcgnECHHs4U1Re85bIXtSCMRqtCKwRFo3a+AnSlzMkss2mRb9Rtgj6rsVs0N0K4FL5yZgjK21ipbSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=mE+o9NfI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BRFRYenW; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 166A825401BC;
	Tue, 22 Apr 2025 09:23:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 22 Apr 2025 09:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm1; t=1745328229; x=
	1745414629; bh=QzoDnp9xFaQH20l9ZtIP4xOte7lwXgT5DtfyCl1DMnM=; b=m
	E+o9NfIAfsh/x8RNvUN8c+dWqc0JUvbCOj2F0YBzkfsAua+6QtM0lxBq+OWive/1
	rJSnJiE7OJ/CkavGOyy7ICIrMCE4iWrnyJm7BVeHmTGtTNMhc6zfcak/qrOJfrww
	/d9BJJ90jORREFQp8eqmP0AXgg5DrIKN9U1gNOzUnNJgT8BWLEwPriHOeX2XLFNv
	zmrZdhtN2+LAbK8t5f9DV4y1TRAI7fIH+AxH+DXIrAvp6xxURvSR3EQDB7cM6avc
	lsX06nx3Env07bhTljG+jTpHFJZGvvHN1AHPuvqi1IuO+kMiKPxoONFRwbqHh7aS
	12A5sQaKbXrx1FKmHqmEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1745328229; x=1745414629; bh=QzoDnp9xFaQH20l9ZtIP4xOte7lw
	XgT5DtfyCl1DMnM=; b=BRFRYenW5ja7gQknyrcq83uPNipuVWiUKNJcnNWdi83m
	oXi3yvrrxhX2mqz/7ll+xIbsAU+SQ3FYbXKLsyCqymrCpqscRuh7fgbnZbXCSUp+
	e0EIk4jQ4wXnYYsSmx2epqlll860zMEnZ88v8bIwnRv9lSEFRKuug0dvTUB0N/v3
	qgfrpILRfsbgBh6A90cSj7n9C/m9SYTnQi0Pph0dQAQ7tfIKqTdRHf2xM//hAycm
	svAGp3Px0rbtlaoT2T1JYdSN/pJFygjHpgWdMIqqzAYtlfg1Ue3FIrUBsfBhgNgC
	ZSLwvFKpOyZnRwwi4vKSVbw/D4Yo7dd7gPwPgFr+fw==
X-ME-Sender: <xms:ZZgHaNRni7T-VET7PwVjYmPI6xthyxTP3dtiOsgNCPh5GnOtux7PMw>
    <xme:ZZgHaGzJCfZl2rzjmoXDzT8XBuzg5elFyBgOhi74qpiyYh8i21IjXbtxnCZa8k6E6
    fDsvKoKY9T_epzMKcE>
X-ME-Received: <xmr:ZZgHaC0jEty2ACQDIqzIgbjinSYgBNDo8dR1mG_92hNDV-HOqmdiN-E8Eaun1uDzMw-xy-9GmtqQ-6SMlTY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhuf
    ffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheptehrthhhuhhrucfhrggsrhgv
    uceorghrthhhuhhrsegrrhhthhhurhhfrggsrhgvrdgtohhmqeenucggtffrrghtthgvrh
    hnpeetjefgjeeiffefiefgfeejkeffudeftdefhedvjeefvdetgeeftdeivdelleelheen
    ucffohhmrghinheplhhptgdrvghvvghnthhspdhkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhthhhurhesrghr
    thhhuhhrfhgrsghrvgdrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    higrnhestghlohhuughflhgrrhgvrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrfihksehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epthhhohhilhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhopehjsghrrghnuggv
    sghurhhgsegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopegsphhfsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ZZgHaFDUsrcQtgzEvoPIOMul2M5uw44ybfLbHQtaYW367_sLqANphg>
    <xmx:ZZgHaGgK6DfHztwiBMERVfY9D2oMx0zEqh0oYvO66cWNbkmFWjzWOA>
    <xmx:ZZgHaJp67I8tDRId4HQ2S9RvV1omR6AaOUervzyWqj7NwfZGHTmQRQ>
    <xmx:ZZgHaBghbMJtvjjT8IxbXkOUIgdm0wmWfN3jpZHcfzI_eEGgOd5pcA>
    <xmx:ZZgHaJVIS-Nd9X2DpLLGRMsYcs-tEucUC2mNL4BhvzNdimU92MwaRigi>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 09:23:48 -0400 (EDT)
From: Arthur Fabre <arthur@arthurfabre.com>
Subject: [PATCH RFC bpf-next v2 00/17] traits: Per packet metadata KV store
Date: Tue, 22 Apr 2025 15:23:29 +0200
Message-Id: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFKYB2gC/4WNTQ6CMBBGr0Jm7ZihgoArExMP4NawaMtUmiAlb
 SUYwt1tuIDLl+/nrRDYWw5wyVbwPNtg3ZhAHDLQvRxfjLZLDIJESScqURqpPGP00saAlBN6owX
 KmouOSRcNKUjjybOxy378hMf9lqnJ4MhLhDalvQ3R+e9unfO9808w50jYEWuj6nNTNdVVD+7Tm
 UF6Pmr3hnbbth/ud41YzwAAAA==
X-Change-ID: 20250305-afabre-traits-010-rfc2-a8e4de0c490b
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 ast@kernel.org, kuba@kernel.org, edumazet@google.com, 
 Arthur Fabre <arthur@arthurfabre.com>
X-Mailer: b4 0.14.2

The only way to attach information to a sk_buff that travels
through the network stack is with the mark. This field can be
read in firewall rules, drive routing decisions, and be
accessed by BPF programs.

However, its small size creates competition for bits, restricting
its practical use.

We propose using part of the packet headroom to store metadata.
This would allow:
- Tracing packets through the network stack and across the kernel-user
  space boundary, by assigning them a unique ID.
- Metadata-driven packet redirection, routing, and socket steering with
  early classification in XDP.
- Extracting information from encapsulation headers and sharing it with
  user space or vice versa.
- Exposing XDP RX Metadata, like the timestamp, to the rest of the
  network stack.

We originally proposed extending XDP metadata - binary blob
storage also in the headroom - to expose it throughout the network
stack. However based on feedback at LPC 2024 [1]:
- sharing a binary blob amongst different applications is hard.
- exposing a binary blob to userspace is awkward.
we've shifted to a limited KV store in the headroom.

To differentiate this from the overloaded "metadata" term, it's
tentatively called "packet traits".

Traits are currently stored at the start of the headroom:

| xdp_frame | traits | headroom | XDP metadata | data / packet |

This makes adding encap headers to a packet easier: the traits don't
have to be moved out of the way first.

But to let us change this in the future, XDP metadata and traits
aren't allowed to be used together.

A get() / set() / delete() API is exposed to BPF to store and
retrieve traits.

Initial benchmarks in XDP are promising, with get() / set() comparable
to an indirect function call. See patch 7: "trait: Replace memmove calls
with inline move" for full results.

We imagine adding first class support for this in netfilter (setting
/ checking traits in rules) and routing (selecting routing tables
based on traits) in follow up work.
We also envisage a first class userspace API for storing and
retrieving traits in the future.

Like XDP metadata, this relies on there being sufficient headroom
available. Piggy backing on top of that work, traits are currently
only supported:
- On ingress.
- By NIC drivers that support XDP metadata.
- When an XDP program is attached.
This limits the applicability of traits. But future work
guaranteeing sufficient headroom through other means should allow
these restrictions to be lifted.

[1] https://lpc.events/event/18/contributions/1935/

---
Changes in v2:
- Support sizes 0 (for flags), 4, and 8. 16 will be supported in the
  future with a batch API, to set two consecutive 8 byte KVs at once.
- Prevent traits and XDP metadata from being used at the same time.
  This will let us move trait storage where XDP metadata is today if
  we want to.
- Use SKB extensions to store the traits in skbs.
- Drop registration API.
- Link to v1: https://lore.kernel.org/r/20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com

---
Arthur Fabre (16):
      trait: limited KV store for packet metadata
      xdp: Track if metadata is supported in xdp_frame <> xdp_buff conversions
      trait: XDP support
      trait: XDP selftest
      trait: XDP benchmark
      trait: Replace memcpy calls with inline copies
      trait: Replace memmove calls with inline move
      skb: Extension header in packet headroom
      trait: Store traits in sk_buff extension
      bnxt: Propagate trait presence to skb
      ice: Propagate trait presence to skb
      veth: Propagate trait presence to skb
      virtio_net: Propagate trait presence to skb
      mlx5: Propagate trait presence to skb
      xdp generic: Propagate trait presence to skb
      trait: Allow socket filters to access traits

Jesper Dangaard Brouer (1):
      mlx5: move xdp_buff scope one level up

 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   4 +
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |   5 -
 drivers/net/ethernet/intel/ice/ice_txrx.c          |   4 +
 drivers/net/ethernet/intel/ice/ice_xsk.c           |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   6 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/rx.c    |   6 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/rx.h    |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    | 114 ++++----
 drivers/net/veth.c                                 |   4 +
 drivers/net/virtio_net.c                           |   8 +-
 include/linux/skbuff.h                             |  42 +++
 include/net/trait.h                                | 302 +++++++++++++++++++++
 include/net/xdp.h                                  |  56 +++-
 net/core/dev.c                                     |   1 +
 net/core/filter.c                                  |  10 +-
 net/core/skbuff.c                                  | 231 ++++++++++++++--
 net/core/xdp.c                                     |  69 ++++-
 net/xdp/xsk.c                                      |  11 +-
 tools/testing/selftests/bpf/Makefile               |   2 +
 tools/testing/selftests/bpf/bench.c                |   8 +
 .../selftests/bpf/benchs/bench_xdp_traits.c        | 160 +++++++++++
 .../testing/selftests/bpf/prog_tests/xdp_traits.c  |  33 +++
 .../testing/selftests/bpf/progs/bench_xdp_traits.c | 128 +++++++++
 .../testing/selftests/bpf/progs/test_xdp_traits.c  | 206 ++++++++++++++
 24 files changed, 1319 insertions(+), 99 deletions(-)
---
base-commit: 5709be4c35ba760b001733939e20069de033a697
change-id: 20250305-afabre-traits-010-rfc2-a8e4de0c490b

Best regards,
-- 
Arthur Fabre <arthur@arthurfabre.com>


