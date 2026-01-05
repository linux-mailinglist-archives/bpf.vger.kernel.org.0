Return-Path: <bpf+bounces-77814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B21CF376C
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 13:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 120E230146DE
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 12:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A2A33506B;
	Mon,  5 Jan 2026 12:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="aCcgTHNL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9832532548A
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 12:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615283; cv=none; b=dwfiuQ1RucH+D7i4w+OSR6nOGpl9V6VVYFJDRbbzApcJp0RIPPyawtBBM59/zXa+izi6vr18kuE8jY6tcDRWV1OE4Z7V2x3sMo9ut1mZT5PYmUuppTrMBdEc5HNt63In79qjNKMfl+1ciyEC4tUNkdkBSMwZn/figBRjNEnK1Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615283; c=relaxed/simple;
	bh=t89L8mla94PT57GNi/JJVJpZMdFcAqg5W/5nlx7IOMY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Gnh3kO7PqnDLxELOQHdRD0kANnXKDY0J2bxat9A59mvIecNX4UHI9obt8Q71CFSMA+wmBoXZqEGhW/WC4sw/ghIsdhlLWkLZjekN2dwmLT6TobtixjyGY63AovywDAAdDivEcsPmHKuIH6cwjHfM0gw4qEjrS3YLEcnaJzIN610=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=aCcgTHNL; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64b8b5410a1so16264891a12.2
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 04:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767615280; x=1768220080; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EtYciljO9dPV0CPkYb1yMnJFHgJcHAu3gx/lt8esbk8=;
        b=aCcgTHNLj7uLowyOby8rnNGfx9JK33o94RnBMdWlLifefb9Lj2wk4R7XAdJSx3iplE
         ZOFTIXduGOMm4DhgI6IQBh2HH51aTIP/S1e5xVB+8IX4o6h16HsAeF1/pbAKC4AwmsbR
         6tr07SxVRO5Goy0P4kf3l3jownGU9kaCGssYFzWx6ro8yPeR4kyg8JoiruIzUEtdL962
         JQO+V2AWMV57YeMH020uvYjqKdM2EBTpVOF4Klt6gPKyHtFyt+f06k+PwZ2EytTl+YIi
         vfOjGOA0Zdo1mV9lUifp9HiDQnjOQ8Nv2V9e1HhZVZ5OTOT+J/39qe6S5F9zIshfyQCA
         x54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767615280; x=1768220080;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtYciljO9dPV0CPkYb1yMnJFHgJcHAu3gx/lt8esbk8=;
        b=u1rv1vik/1dVdL88U8xEk1AniKlBv5XsJ7JS3rjVV3BufDXlDGyXKlN0IxQC4cCukS
         /kKJveSArwfvWW/vydHIYxqmsM7nY+qOKdmx3vIU5PyYeYD2fO5Cbc14Bs3zn0LoWjKn
         EjROAtQq8hDXA7h8tEK9cuFT4D31w1Fzk8kHKiI+XfXprglceNq4Pg8DKte9fDCYr3Fk
         CmEdkvgbo6AuZQcvkxWQIDnkmM7NG6dyG6xp9ltOXy0iGhpQZwQpfLJY+B7IbcdScXBf
         qaVngZvhoD5NzgTxni5aqfp4r+1AF++OviNDbP4pMF3kmS6ccZS2kkq1S0LJxnya9pJ4
         0A8A==
X-Gm-Message-State: AOJu0YzHHcGVnorZjMlZpoNCX6YHNq/Jso8+EkzGmthucCEigZtg5/dC
	sAO9shLjFXFcVuj9k74ObLNmq1VEldIg5H1bLg4cS+rQSKFHSXa2LsaEZETw1oQ6nc8=
X-Gm-Gg: AY/fxX7dqCf/MWcWDVdtyBn8MO5Q1F9fWUdE4gjpC5FyyB0kRsgao5pgBSX1ixt4QQE
	eivSv/IuPcJH0SLNR4/C+o7+9mhscqZjjYWgWQxopIPw3uDRxxv5UYzzOBHzQiOsZtrxDkHjskh
	JeqXinzsxPny79dWKMRjFgt9GknT6tAEGm2o8iVEPTpNQe4LGUfcYnnJqvBethmz54cyu4Kpyl+
	iMYfQHBYJ0fHSpuj5H3t+eX9pTEpwT2tG4yI3fIjIuS7MLZNRadYfXyNqZ1vnU9uTUW/e1a2Msc
	E6WV12Siwc3kQOrqaP1RrtFcX2Zk5pi4bGer2G9QLwQnqOocP2v0ga7yjHOqnTm4z75qsKw7/jD
	ynQdk+4Ish3l0kNe7wtVeVwCUuRh6A8D3DLHy7WjsWVJe+mPzlR8PSecAs6GCfhuhWwpIfr4eCl
	xZkUZx0kvujt+dPrq+TumLtDqr+Ld6oqKcAO3DtNNG0DY0G5gp4gOdfWx/zmg=
X-Google-Smtp-Source: AGHT+IGHXTr3U0gxkal66O9rqFZdOp52HAhuUIK7V/soNXVx26kWHmJGkfj3BjIn4bVW713u2DFu2Q==
X-Received: by 2002:a05:6402:1e93:b0:64d:57a8:1ff3 with SMTP id 4fb4d7f45d1cf-64d57a82362mr41534265a12.4.1767615279889;
        Mon, 05 Jan 2026 04:14:39 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b916b82e7sm57707225a12.35.2026.01.05.04.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:14:39 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH bpf-next v2 00/16] Decouple skb metadata tracking from MAC
 header offset
Date: Mon, 05 Jan 2026 13:14:25 +0100
Message-Id: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACKrW2kC/43PwW7DIAwG4FepOM8TkKCkO/U9qh0gmAUtCSmmK
 FWVdx+jlXrYZUfL8v/5vzPC6JHYx+HOImZPPixlkG8HNox6+ULwtsxMcqmEkA3Qt4EZkwbSDtc
 YgoMFk8VMEDcIy3SDxkkruRUKrWYlaI3o/FaRMzPr78GW2OdjE/FyLWp6rmck0lUtT1STq5dZh
 FWnEXILHNSAhvf6aJrOnIYpXK2bdMT3Icw1fPSUQrzValnU9GeL9j8tsihGf+x6p7hqW9H9MfZ
 9/wEe+BMDQAEAAA==
X-Change-ID: 20251123-skb-meta-safeproof-netdevs-rx-only-3f2d20d15eda
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

This series continues the effort to provide reliable access to xdp/skb
metadata from BPF context on the receive path. We have recently talked
about it at Plumbers [1].

Currently skb metadata location is tied to the MAC header offset:

  [headroom][metadata][MAC hdr][L3 pkt]
                      ^
                      skb_metadata_end = head + mac_header

This design breaks on L2 decapsulation (VLAN, GRE, etc.) when the MAC
offset is reset. The naive fix is to memmove metadata on every decap path,
but we can avoid this cost by tracking metadata position independently.

Introduce a dedicated meta_end field in skb_shared_info that records where
metadata ends relative to skb->head:

  [headroom][metadata][gap][MAC hdr][L3 pkt]
                     ^
                     skb_metadata_end = head + meta_end
                     
This allows BPF dynptr access (bpf_dynptr_from_skb_meta()) to work without
memmove. For skb->data_meta pointer access, which expects metadata
immediately before skb->data, make the verifier inject realignment code in
TC BPF prologue.

Patches 1-9 enforce the calling convention: skb_metadata_set() must be
called after skb->data points past the metadata area, ensuring meta_end
captures the correct position. Patch 10 implements the core change.
Patches 11-14 extend the verifier to track data_meta usage, and patch 15
adds the realignment logic. Patch 16 adds selftests covering L2 decap
scenarios.

Note: This series does not address moving metadata on L2 encapsulation when
forwarding packets. VLAN and QinQ have already been patched when fixing TC
BPF helpers [2], but other tagging/tunnel code still requires changes.

Note to maintainers: This is not a typical series, in the sense that it
touches both the networking drivers and the BPF verifier. The driver
changes (patches 1-9) can be split out, if it makes patch wrangling easier.

Thanks,
-jkbs

[1] https://lpc.events/event/19/contributions/2269/
[2] https://lore.kernel.org/all/20251105-skb-meta-rx-path-v4-0-5ceb08a9b37b@cloudflare.com/

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Changes in v2:
- Add veth driver fix (patch 7)
- Add selftests for L2 decap paths (patch 16)
- Link to RFC: https://lore.kernel.org/r/20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com

---
Jakub Sitnicki (16):
      bnxt_en: Call skb_metadata_set when skb->data points at metadata end
      i40e: Call skb_metadata_set when skb->data points at metadata end
      igb: Call skb_metadata_set when skb->data points at metadata end
      igc: Call skb_metadata_set when skb->data points at metadata end
      ixgbe: Call skb_metadata_set when skb->data points at metadata end
      net/mlx5e: Call skb_metadata_set when skb->data points at metadata end
      veth: Call skb_metadata_set when skb->data points at metadata end
      xsk: Call skb_metadata_set when skb->data points at metadata end
      xdp: Call skb_metadata_set when skb->data points at metadata end
      net: Track skb metadata end separately from MAC offset
      bpf, verifier: Remove side effects from may_access_direct_pkt_data
      bpf, verifier: Turn seen_direct_write flag into a bitmap
      bpf, verifier: Propagate packet access flags to gen_prologue
      bpf, verifier: Track when data_meta pointer is loaded
      bpf: Realign skb metadata for TC progs using data_meta
      selftests/bpf: Test skb metadata access after L2 decapsulation

 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c         |   2 +-
 drivers/net/ethernet/intel/igb/igb_xsk.c           |   2 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c       |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/rx.c    |   2 +-
 drivers/net/veth.c                                 |   4 +-
 include/linux/bpf.h                                |   2 +-
 include/linux/bpf_verifier.h                       |   7 +-
 include/linux/skbuff.h                             |  37 ++-
 kernel/bpf/cgroup.c                                |   2 +-
 kernel/bpf/verifier.c                              |  42 ++-
 net/core/dev.c                                     |   5 +-
 net/core/filter.c                                  |  66 ++++-
 net/core/skbuff.c                                  |  10 +-
 net/core/xdp.c                                     |   2 +-
 net/sched/bpf_qdisc.c                              |   3 +-
 tools/testing/selftests/bpf/config                 |   6 +-
 .../bpf/prog_tests/xdp_context_test_run.c          | 292 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  |  48 ++--
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |   6 +-
 21 files changed, 459 insertions(+), 87 deletions(-)


