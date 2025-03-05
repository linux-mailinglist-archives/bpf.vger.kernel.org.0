Return-Path: <bpf+bounces-53320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A31FA5020E
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 15:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3B5D7A604D
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 14:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFEE24C077;
	Wed,  5 Mar 2025 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="FgtRPZ6y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P9gF4BIw"
X-Original-To: bpf@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E190A156C74;
	Wed,  5 Mar 2025 14:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185201; cv=none; b=j+zP2xeo9s1HyUUVnehBCsI7cj2xTOJ/EOPIxlw19D4q2ykH25ExAdb3XBo4XLov+uyg8OBkTx2zXh4CNl3x/R+vcOARSMDATiP9oLG+ZNUeRwPW7awVrOGFrf6pownRXiQIN9Qu/t+hIL50hRRHWQPYqlcn2+1DJclNtyKa+Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185201; c=relaxed/simple;
	bh=2z2RNrHb6qG9W3qLpjkGuOq8UXcTOmhPl1pDRLwIRy0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TT1GXkHmMQm5SyVFQe/UOF4PkdgQRHZKqZwQi7OuBh+vK7asFhGN3KvjX+Sbm3DchMa8UzpUt327BE0p1xC4H8W5+POsxXrK89BuYGxIw383MKa9m2ecLTTJ41tlD6fIRrEeMkhoa65tDOuVv0V2q0khnxN/rKCsyMZILMXZ/q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=FgtRPZ6y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P9gF4BIw; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id AED1013814CE;
	Wed,  5 Mar 2025 09:33:17 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 05 Mar 2025 09:33:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm3; t=1741185197; x=
	1741271597; bh=wTjzfegKSik2sCBY6FbFyMGcYgR4HS7Jn7B4D35Q+gQ=; b=F
	gtRPZ6yjpbqTToExXKX3XkVIlr/eUrg6gSq1ONdtNwOcFPSOkEAsnimonA3APzh3
	MtHnKzv481weii5/C5rFZc0DoEY6ECNm1+WSQONhl5v7XvC657rDhWXfTk7jPVf/
	9X3DRLTfG+rppdb71VQGTjpd+C4EHjmUvqEOBhb1TalbsUmyxZOqN+f78xnALEsv
	RtrdhhoPUbCKx4yyMTlWAuA6E4sscioIVDdKJ4N9e9/VWfY1EyX+Keo9MeGxH88X
	vT3iADewH9a+HUTufwMrcaaNAYGlDGB1h0Cs9aF+iAS4TANqtWBCPYO+x5ob8pam
	kJnR/n1YMp7mxN+7k/kVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1741185197; x=1741271597; bh=wTjzfegKSik2sCBY6FbFyMGcYgR4
	HS7Jn7B4D35Q+gQ=; b=P9gF4BIwpNCmnFW104OBLdVy5G1jEySKS+x/8j1Umb1/
	snUPf2Acv4bJMOD5lasL9HK1q0vLhf1MTnKZKTrNEiCTp5zONsEDaLz5+a3LC0A2
	CCdbWhHoWf9+tuAsk5/Zpa86nEZh0RjzBdHir5B//aHrnGAcrxRK7edwcbM/E86S
	vZnIz+0STcDoEj/DQCpuOh4WVZjPXPY+X+TKwqMHarj+Ei4OsBQpDO1/6zmtFl19
	lbefDpF7MfsRSIPY2USB/W4fk3ciJ9gEUePPB17G8QXGFWpLfGPLU9aQBHn3LBzK
	xXj/KL/OxgftoB2PMfr7PJ+QxvmXIWrAZAA7UkMRWQ==
X-ME-Sender: <xms:rWDIZ4novZLh6_CLluJGLFREECKHT75fOf5s-QwzMbTwSs6xNSuajQ>
    <xme:rWDIZ300CY4wrKv1yM2i_Wsp2WzoAkm7Nfits79zIz8lwwUH7DU3eoxFynzODLf3b
    C0YnvIYZVXfaZ3pOs4>
X-ME-Received: <xmr:rWDIZ2r_r38nvEJry67JfW_86vtZ9XNzBCwDs_PzvUJkyJkFwJBCfJOpzl8sG8q-I4Ca81SyXBDNWeSpJSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdej
    necuhfhrohhmpegrrhhthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhenucggtffrrg
    htthgvrhhnpedttddukedtueejtdffleegteffffeuvedtgfetteelfeeijeetjedtffdt
    gfduffenucffohhmrghinheplhhptgdrvghvvghnthhsnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrthhhuhhrsegrrhhthhhurhhfrggs
    rhgvrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehthhhoihhlrghnugesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhgsihgr
    nhgtohhnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehhrgifkheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegrfhgrsghrvgestghlohhuughflhgrrhgvrdgtohhmpdhrtghpthhtohepjhgrkh
    husgestghlohhuughflhgrrhgvrdgtohhmpdhrtghpthhtohephigrnhestghlohhuughf
    lhgrrhgvrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepjhgsrhgrnhguvggsuhhrghestghlohhuughflhgrrhgvrdgt
    ohhm
X-ME-Proxy: <xmx:rWDIZ0loBCQRJhfZVESdeZztipBuVnBIhm_Wj6Zilp4gLWOf_6DtXg>
    <xmx:rWDIZ23BIfnHrk4OgfY04a5tvcDotV-Eyu8sO5tTsamc7vunXjfVVg>
    <xmx:rWDIZ7vlib4WtLpibRRuTrr8iP7Oa660VcapF2jvoj9MxFgE1GZhvQ>
    <xmx:rWDIZyVkHmoGOZDGcFfNip4e2qcCMAg7JjWgiFLkLnQbliyV4BYhbQ>
    <xmx:rWDIZ0wtGOwn6xRCg_k8755V8RgDJRJ2KEM3qo_oSAly-xWG2fuhlivV>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 09:33:15 -0500 (EST)
From: arthur@arthurfabre.com
Subject: [PATCH RFC bpf-next 00/20] traits: Per packet metadata KV store
Date: Wed, 05 Mar 2025 15:31:57 +0100
Message-Id: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF1gyGcC/x3MMQrDMAxA0asYzRUobgJt1kAP0LV0kB250eIE2
 ZRAyN1rOr7h/wOKmEqB0R1g8tWia27oLg7iwvkjqHMzePIDXWlAThxMsBprLUgdoaXokW/Sz0K
 xv1OAFm8mSff/+AXPx+TCljDLXuF9nj+qpN6HdgAAAA==
X-Change-ID: 20250305-afabre-traits-010-rfc2-a8e4de0c490b
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 Arthur Fabre <afabre@cloudflare.com>
X-Mailer: b4 0.14.2

Currently, the only way to attach information to a sk_buff that travels 
through the network stack is by using the mark field. This 32-bit field
is highly versatile - it can be read in firewall rules, drive routing 
decisions, and be accessed by BPF programs.

However, its limited capacity creates competition for bits, restricting 
its practical use.

To remedy this, we propose using part of the packet headroom to store 
metadata. This would allow:
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

A get() / set() / delete() API is exposed to BPF to store and 
retrieve traits. 

Initial benchmarks in XDP are promising, with get() / set() comparable
to an indirect function call. See patch 6: "trait: Replace memmove calls
with inline move" for full results.

We imagine adding first class support for this in netfilter (setting 
/ checking traits in rules) and routing (selecting routing tables 
based on traits) in follow up work.
We also envisage a first class userspace API for storing and
retrieving traits in the future.

To co-exist with the existing XDP metadata area, traits are stored at
the start of the headroom:

| xdp_frame | traits | headroom | XDP metadata | data / packet |

Traits and XDP metadata are not allowed to overlap.

Like XDP metadata, this relies on there being sufficient headroom
available. Piggy backing on top of that work, traits are currently
only supported:
- On ingress.
- By NIC drivers that support XDP metadata.
- When an XDP program is attached.
This limits the applicability of traits. But future work 
guaranteeing sufficient headroom through other means should allow
these restrictions to be lifted.

There are still a number of open questions:
- What sizes of values should be allowed? See patch 1 "trait: limited KV
  store for packet metadata".
- How should we handle skb clones? See patch 16 "trait: Support sk_buffs".
- How should trait keys be allocated? See patch 18 "trait: registration
  API".
- How should traits work with GRO? Could an API let us specify policies 
  for how traits should be merged? See patch 18 "trait: registration
  API".

[1] https://lpc.events/event/18/contributions/1935/

Cc: jakub@cloudflare.com
Cc: hawk@kernel.org
Cc: yan@cloudflare.com
Cc: jbrandeburg@cloudflare.com
Cc: thoiland@redhat.com
Cc: lbiancon@redhat.com

To: netdev@vger.kernel.org
To: bpf@vger.kernel.org

Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
---
Arthur Fabre (19):
      trait: limited KV store for packet metadata
      trait: XDP support
      trait: basic XDP selftest
      trait: basic XDP benchmark
      trait: Replace memcpy calls with inline copies
      trait: Replace memmove calls with inline move
      xdp: Track if metadata is supported in xdp_frame <> xdp_buff conversions
      trait: Propagate presence of traits to sk_buff
      bnxt: Propagate trait presence to skb
      ice: Propagate trait presence to skb
      veth: Propagate trait presence to skb
      virtio_net: Propagate trait presence to skb
      mlx5: Propagate trait presence to skb
      xdp generic: Propagate trait presence to skb
      trait: Support sk_buffs
      trait: Allow socket filters to access traits
      trait: registration API
      trait: Sync linux/bpf.h to tools/ for trait registration
      trait: register traits in benchmarks and tests

Jesper Dangaard Brouer (1):
      mlx5: move xdp_buff scope one level up

 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   4 +
 drivers/net/ethernet/intel/ice/ice_txrx.c          |   4 +
 drivers/net/ethernet/intel/ice/ice_xsk.c           |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   6 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/rx.c    |   6 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/rx.h    |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    | 114 ++++----
 drivers/net/veth.c                                 |   4 +
 drivers/net/virtio_net.c                           |   8 +-
 include/linux/bpf-netns.h                          |  12 +
 include/linux/skbuff.h                             |  33 ++-
 include/net/net_namespace.h                        |   6 +
 include/net/netns/trait.h                          |  22 ++
 include/net/trait.h                                | 288 +++++++++++++++++++++
 include/net/xdp.h                                  |  42 ++-
 include/uapi/linux/bpf.h                           |  26 ++
 kernel/bpf/net_namespace.c                         |  54 ++++
 kernel/bpf/syscall.c                               |  26 ++
 kernel/bpf/verifier.c                              |  39 ++-
 net/core/dev.c                                     |   1 +
 net/core/filter.c                                  |  43 ++-
 net/core/skbuff.c                                  |  25 +-
 net/core/xdp.c                                     |  50 ++++
 tools/include/uapi/linux/bpf.h                     |  26 ++
 tools/testing/selftests/bpf/Makefile               |   2 +
 tools/testing/selftests/bpf/bench.c                |  11 +
 tools/testing/selftests/bpf/bench.h                |   1 +
 .../selftests/bpf/benchs/bench_xdp_traits.c        | 191 ++++++++++++++
 .../testing/selftests/bpf/prog_tests/xdp_traits.c  |  51 ++++
 .../testing/selftests/bpf/progs/bench_xdp_traits.c | 131 ++++++++++
 .../testing/selftests/bpf/progs/test_xdp_traits.c  |  94 +++++++
 31 files changed, 1259 insertions(+), 69 deletions(-)
---
base-commit: 42ba8a49d085e0c2ad50fb9a8ec954c9762b6e01
change-id: 20250305-afabre-traits-010-rfc2-a8e4de0c490b

Best regards,
-- 
Arthur Fabre <afabre@cloudflare.com>


