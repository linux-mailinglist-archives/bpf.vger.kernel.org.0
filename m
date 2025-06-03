Return-Path: <bpf+bounces-59519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8B2ACCC5E
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 19:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1263A3481
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 17:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B7B1E0489;
	Tue,  3 Jun 2025 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTcWKgU9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582B917A2EB;
	Tue,  3 Jun 2025 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748972753; cv=none; b=m8h7FRwgsDUsHWE0SQXFOGvB0bQWGGJ4vKPS98iIsW2DGg/9dLk2DXjnW1IMA7fo3B1bCUMfJ0VwuC4WcFxLaimE74yXYxlmuxQMlJEjXyCuNCPu6FhWzMGPPUgT8dzDZlIBoNnArgvYwFD5cAf6s4El0gFCvdW0hMo5QmWpNCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748972753; c=relaxed/simple;
	bh=CCZQDfB3KxzaL+QoSodfB20faAzmo0yq5xayeijfr9c=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=VLxWZIuRYKUMgSSAwA7wZl73e5lA6YM+3s3aWmWslaI2IfgvrJiRlBCbSgSGPx4LcRr3rWvZfkL8wgGNB3iZeqsUN9Cy8Qm8LwNpJVxHbPWpYcY0laE3eqaBaXFZvJgLyQ4nZaLbyVCrfj0jH/w8WZ0D6ShnuslWi15tc93jaGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTcWKgU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8E2C4CEED;
	Tue,  3 Jun 2025 17:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748972753;
	bh=CCZQDfB3KxzaL+QoSodfB20faAzmo0yq5xayeijfr9c=;
	h=Subject:From:To:Cc:Date:From;
	b=rTcWKgU9nbPeCfG8tfVh96LP7vPyNg/9DT1q+U4Y65qAovTsJuO6DASOIQiHgx8YE
	 P32GRAIEFMhbZCuWPBvq6O4ut0UddVOTZ0SdbVGgeD9LX2v8bacR29ecPM9TaC8E1N
	 iPc+pZzymHC5uLbLqB+PnYLeYwhXT0D9oiHLD2Vt3qp3cfZuzwqIK6Nheg9Qvp4gyD
	 qLJc6ooX11cjwUM5HTZcD2VhA6QVABjB84Am9szZD2LLnLvpoE7Yrnv8LBTYiS0ptj
	 356Zvt29ivZ5IOPKRogswrvILTJJyGBCEPmhy4a+grUIeIdEEziPzZ3ia/Fh9dtxu0
	 Fv+CspTluotLw==
Subject: [PATCH bpf-next V1 0/7] xdp: Propagate RX HW hints for XDP_REDIRECTed
 packets via xdp_frame
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, lorenzo@kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <borkmann@iogearbox.net>,
 Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 sdf@fomichev.me, kernel-team@cloudflare.com, arthur@arthurfabre.com,
 jakub@cloudflare.com
Date: Tue, 03 Jun 2025 19:45:47 +0200
Message-ID: <174897271826.1677018.9096866882347745168.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This patch series enables the propagation of NIC hardware RX metadata
offload hints for packets undergoing XDP_REDIRECT. Currently, SKBs
created from `xdp_frame`s after an XDP_REDIRECT (e.g. to cpumap or veth)
lack hardware hints.

While XDP hardware RX metadata can be read by BPF programs bound to the
physical device's ifindex (BPF_F_XDP_DEV_BOUND_ONLY) using kfuncs [1],
there's no mechanism to persist these hints for use after a redirect.
The currently available kfuncs[1] provide rx_hash, rx_vlan_tag and
rx_timestamp.

This series introduces new BPF kfuncs allowing an XDP program to store
existing HW metadata hints (rx_hash, rx_vlan_tag and rx_timestamp) into
the `xdp_frame`. These stored hints are then used in
`__xdp_build_skb_from_frame()` to populate the corresponding fields in
the newly created SKB.

The immediate production motivation is to correctly populate `skb->hash`
(the RX hash). This is important for GRO (Generic Receive Offload)
functionality. For instance, the netstack needs the `skb->hash` to be
set *before* the GRO engine processes the packet (see
`dev_gro_receive()` [0]). Without the correct RX hash, the GRO engine
(e.g., cpumap recently gained GRO support) effectively operates on a
single hash bucket, limiting its ability to aggregate flows.

Populating these fields via a TC ingress hook is not viable as it
executes too late in the packet processing pipeline for uses like GRO.

We considered XDP traits as an alternative to statically adding members
to the end of `struct xdp_frame` area. However, given the immediate need
for this functionality and the current development status of traits, we
believe this approach is a pragmatic solution. We are open to revisiting
this and potentially migrating to a traits-based implementation if/when
they become a generally accepted mechanism for such extensions.

Furthermore, this patchset demonstrates a tangible in-kernel requirement
for such metadata propagation and could serve as an early example or
adopter of the XDP traits mechanism.

[0] https://elixir.bootlin.com/linux/v6.14.7/source/net/core/gro.c#L463
[1] https://docs.kernel.org/networking/xdp-rx-metadata.html

---

Jesper Dangaard Brouer (2):
      selftests/bpf: Adjust test for maximum packet size in xdp_do_redirect
      net: xdp: update documentation for xdp-rx-metadata.rst

Lorenzo Bianconi (5):
      net: xdp: Add xdp_rx_meta structure
      net: xdp: Add kfuncs to store hw metadata in xdp_buff
      net: xdp: Set skb hw metadata from xdp_frame
      net: veth: Read xdp metadata from rx_meta struct if available
      bpf: selftests: Add rx_meta store kfuncs selftest


 Documentation/networking/xdp-rx-metadata.rst  |  74 ++++++--
 drivers/net/veth.c                            |  12 ++
 include/net/xdp.h                             | 134 ++++++++++++--
 net/core/xdp.c                                | 107 ++++++++++-
 net/xdp/xsk_buff_pool.c                       |   4 +-
 .../bpf/prog_tests/xdp_do_redirect.c          |   6 +-
 .../selftests/bpf/prog_tests/xdp_rxmeta.c     | 166 ++++++++++++++++++
 .../selftests/bpf/progs/xdp_rxmeta_receiver.c |  44 +++++
 .../selftests/bpf/progs/xdp_rxmeta_redirect.c |  48 +++++
 9 files changed, 560 insertions(+), 35 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_rxmeta.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_rxmeta_receiver.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_rxmeta_redirect.c

--



