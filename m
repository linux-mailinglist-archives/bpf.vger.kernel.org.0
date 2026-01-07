Return-Path: <bpf+bounces-78097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A994CFE4DA
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 15:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE6FC303DAB2
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 14:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208FF34C820;
	Wed,  7 Jan 2026 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LwmwbkUV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C108634C154
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 14:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796093; cv=none; b=JcTFXFhDb5VL9pU/3qvBdGIFYwgSBeW+PLT1bkGtRw1xdjooZvZs+dlIjiZZcx+78k1+bwRQYhM4patkSPr/+E9HeT66ccpmV8Fo+H/+pC76ieeUXAb2FesJ6HcIOdmKJ0WEe2XVyVRDJ5ylSkAMcH/00GEHcFj1rLsCdl86vtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796093; c=relaxed/simple;
	bh=Eu6ilaH8UuDw7IwCHWdvumqfGOwaK2NCp0A8fqgTDQ8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hcgnqmsLx8AqgPuGpHaXAMCYWW3UHaPGtg8aUw7uBCJzgdCCA3RuXFcfQU9408BIuv/fQLYZqjSMe93aID8WP5c7R/NAhlzVJ/OTynAOeH0GPfljDOgEAeWux1DjB0rJGR82uFkgrZipfuIXuqeGl8h2bPE5AlF5wrsYDRJMvGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=LwmwbkUV; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b83122f9d78so345795366b.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 06:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767796090; x=1768400890; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dXZ/1IRyrkfvpzIX9P5wE04Wi2LMwB98c3ecDlM6NcQ=;
        b=LwmwbkUV8BY/zPjtQZxuyUPZK5xGiLqgdSa6g8wSkpQAQbHSIVVFjzs80AyBNpUMvM
         shG9X+3IhRmk9c1HPC3gAz78mdSuIVwiYXDEdGNtPNBC9Km657BKsJkmC+uJFt65yc1L
         mfcbsykfhNY/Fpc0MeVPmnvOSbIMgifT6ognkDDbPowA+9h7bPMx25TpRVIOPWZsfmb4
         R1LEFayVkGFV7/gE24Bs1ltbkS2+cm5Tf7kFVDrn+8fYNnbVnR9BMAUGLM8q3nUxivrS
         Ad1kXDETzV55irfmEY6M9ufGXyLiTOYAm4/58vHsTo70UA/ZGFa6Xu9AUbsCAvyUmIA5
         Ktew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796090; x=1768400890;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXZ/1IRyrkfvpzIX9P5wE04Wi2LMwB98c3ecDlM6NcQ=;
        b=pilDYOR4uAZFjn1xgF2ReVCWRA2Sz8uDXDEngcfMWmssUrqXQacDKyebaNONTXjgNk
         M6P072k1bcjzVIuPMNttUlb/KP6l8iAaxrTwioFUWwvddCwF3G7hkEwlOTAT3nM+Vg79
         CgLp427/0M5v4ivOgwTSICaqa6Xzux8Y64FPIq1oZHa2+qaoZStdNmma3JVi4Qb3Rmxa
         i04ZQzUktskzFpU15cII5Cjjf4us0l3/9j7A8t7Zc8RfhXk2Ois5hC48+96XjqtW+G/O
         Sgb5cquE26ILAtDWc43hI/vGUxuvn/gUvDjvf+ARqmHDgDgy5LjivGNZpQNUdbUwcWd/
         ipcQ==
X-Gm-Message-State: AOJu0Ywhps3Ew/lvr4qIy2xEvt7lulgLenWxveqA9iryoi4H5j1+OKuy
	ZSaR7BjweGV6rWVIB8hifYWWGy62I/gM0YKw8elVFZ7H0QksAGW+Lv890kgwiCaINZM=
X-Gm-Gg: AY/fxX7imZxtpeE19vLoLtsx/M7f0UrCjY+fInabm7uPTiCC2BRdro7pCskWtOtZsSb
	NJD3LHPIoBMCqUIA5ciiGK+k6IwhQWWpt1BcbbFYITpiQFxDvOZXCEC5cWnUA//woy/D621Fzkg
	mTfoUlrG6R8zkNMsh12AfDj9wrOMzy51kqW0FQAErzcuZp6ZQT4OQUfnI2OKiVs1qckieDYglms
	d67L8Nyg0rjAVtAQMfT+yZaAm+sYpyQqgP9obqg3v+s3p7v67gZOqtkY7cFA+lwiCtWhtA2XRnF
	wGYpvRDvx4FaUNEQpfjpDkbDTSwGjhyOaXmcalolOd9ekfDZHKRHvau0ISml/sgn2yz2v+cKqUO
	s6dfTNKSdaBlm8ok5DWJXlCk5bRvRLjel09RNGk/NuAQa7UlbQNWJLsjpdYpKnoaMVAGX3+nQ7X
	JNuP5YqQ7wp8pUTtKBGbKQcgKA9TYSaBNYvTEWArBKBam1EXynUtEEYdszqLY=
X-Google-Smtp-Source: AGHT+IGoIuvDrbD78kTl/itHNAZl4UA1IKW8Enb2OFYQWSEoOEC/UFEEv9VXia2+Uk2rY/X+EVzxPQ==
X-Received: by 2002:a17:907:1b1d:b0:b79:f984:1557 with SMTP id a640c23a62f3a-b8445378cb2mr279344166b.46.1767796089952;
        Wed, 07 Jan 2026 06:28:09 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a56962esm534525266b.66.2026.01.07.06.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:28:09 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH bpf-next v3 00/17] Decouple skb metadata tracking from MAC
 header offset
Date: Wed, 07 Jan 2026 15:28:00 +0100
Message-Id: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHBtXmkC/42PwU7EIBRFf6VhLQZombaz8j+Mi0d5WGJbOsCQT
 ib9d5EZY4zGuLy5eee8eyUBvcVAjtWVeEw2WLfkUD9UZBhheUVqdc5EMCE5FzUNb4rOGIEGMLh
 65wxdMGpMgfqNumW60NoILZjmEjWQDFo9GrsVyTNR68fBFsnLrfF4OmdrvNczhgDFeqxuTia/n
 NmwQhxpaiijckDFOuhV3aqnYXJnbSbw+Di4ucBHG6LzlzIt8UK/r2j+syLx7Oj6tjOSyabh7W+
 OJD65B/bt0z+4InNBcDy0vZJg4Ad33/d3YU8H2ZgBAAA=
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
Changes in v3:
- Use BPF_EMIT_CALL in gen_prologue (patch 15, 16) (Alexei)
  (Will convert bpf_qdisc/testmod as a follow up.)
- Link to v2: https://lore.kernel.org/r/20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com

Changes in v2:
- Add veth driver fix (patch 7)
- Add selftests for L2 decap paths (patch 16)
- Link to RFC: https://lore.kernel.org/r/20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com

---
Jakub Sitnicki (17):
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
      bpf, verifier: Support direct kernel calls in gen_prologue
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
 include/linux/bpf_verifier.h                       |   8 +-
 include/linux/skbuff.h                             |  37 ++-
 kernel/bpf/cgroup.c                                |   2 +-
 kernel/bpf/verifier.c                              |  54 ++--
 net/core/dev.c                                     |   5 +-
 net/core/filter.c                                  |  62 ++++-
 net/core/skbuff.c                                  |  10 +-
 net/core/xdp.c                                     |   2 +-
 net/sched/bpf_qdisc.c                              |   3 +-
 tools/testing/selftests/bpf/config                 |   6 +-
 .../bpf/prog_tests/xdp_context_test_run.c          | 292 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  |  48 ++--
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |   6 +-
 21 files changed, 466 insertions(+), 89 deletions(-)


