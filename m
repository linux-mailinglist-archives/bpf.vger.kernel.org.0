Return-Path: <bpf+bounces-31882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329739045E5
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 22:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 324911C23691
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 20:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978A8153565;
	Tue, 11 Jun 2024 20:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0dj3vZld"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C201A1527AC
	for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 20:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718138571; cv=none; b=a6td5zF3/vFAeNeCvLGCHdmx8HRohOAgAyKFS5oLft3pPfAD0QMxRvobOnfWvSBPz0HozQY/udYt04Kz4OH2RexLuzIfTgsRzJCAgIpXy8maZZLfRB1tw2ErY43v+GN5OpXcHgKUsdVL5d2WwI29LINRxx+htginzMCN8cZYQsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718138571; c=relaxed/simple;
	bh=WlznXMtSbdGKu8rLIix8aC6pcrpZ/n+hFKL5oX2CDVE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ouiCQES36qVHE6B/Lm0I0pNveqz5Wn2iAxEYhL9DXu7aY3omRoQqxnJ1KL5Otd98Q4ME5BBWeamCU6ZP6TbReQ3x1CTZW1284YCEk0DVQXhQSBa+u6sqKK4wrQmANPyUoebCbA+JOfDXgs7cRSgcoNHdFumn4PYHzTFjMsEVqZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zhuyifei.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0dj3vZld; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zhuyifei.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2bf8512aa8dso6371880a91.1
        for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 13:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718138569; x=1718743369; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7RdAYUNPI1yDlhBKNejbzxVlP4TF3h6oLfHe0CjscKc=;
        b=0dj3vZldNYGo19ik02IAtStgywPiInVuW11R2izQPsDenialQkMHtaAoEth1NkAWRg
         mJhqvKL0/RFR65eEWxPWeyiYp7wj7dJcEhqKWY+gXfJV02An8ZqhcoQY4kUOvQwXd2Ch
         ddMaV2nkbkWKfCVzDWBtB1LnCTUQrlJTG/SmNwyO0uO2PKKHhlptegQvwQ7kL/E93jPZ
         sTC1Ei5iTxTsfXSVGE6tTpIsyozXMyVKdT/KYxRVj6LT2GIw9Ojt/Dsm4MJS/aeOPmhm
         22q9kJgT5TxO+bzL5Gpd4gtzH3OoSZ7F6T5gWebSXujT/tiBfk+hjEqZ5+UJtNaI1h5j
         g7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718138569; x=1718743369;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7RdAYUNPI1yDlhBKNejbzxVlP4TF3h6oLfHe0CjscKc=;
        b=gdtDvkaeI6mcKUpkZSrOtpRrbepnxhGlI+OlhTWCaFLNqfcQM9T6ZbHOe4taHg4WeI
         ZGzAP3Lynlnso82ltiCWwdAjMVWzyLirOS9Q99PJRWSxTCHQ4Q4llaErOtZltmpJN9Iq
         jGKe33hOW7zfYvdPb9RTm1ljPEHMkXfb82tWioPyE86KZFYQZzG2M/PgRMdIMkt+4qC4
         ChU8LJEQjnyUPSxhm+jZI+Wu9gEjiLi8Q3NhkBViXAHWjdYUvW0c6thsEhteGJfpMgfq
         EXN6ckn+l04Cfm3XMg5XyyOdxEjmQOu0casZrffZS3nGA8FAORdTac2U63FfvKKiOUMo
         lrGg==
X-Forwarded-Encrypted: i=1; AJvYcCWZyBUqyPYRA/GavelQ0itQtudaYTn3bxyOv4SavxpwkNnYCntYCnZCz4G8eQUF2JcR/ju7f4EGQxqKFEppmUWQwHk7
X-Gm-Message-State: AOJu0YwXXMJfGbf1Q+Dvrm//eeZ5HufgcNAbY1ueEx7CVzuplH+Fiji1
	u/p5C6tayVi8sF0OnEtGBqqMu6CVhDPSmJ0AhHkvXA+3tCQz1ArEi//X9mbSz9ReKOqzFC/b02k
	Iluth9nralQ==
X-Google-Smtp-Source: AGHT+IEVEQk6y30Cnzs9O7le2rcOssc9YOhcAKdkh7uIo/fmjXuF4j76p728y2wEGL9FdFSB3mebvMjxSzB5ow==
X-Received: from zhuyifei-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edc])
 (user=zhuyifei job=sendgmr) by 2002:a17:90a:ee92:b0:2c2:1b98:94ee with SMTP
 id 98e67ed59e1d1-2c4a7758861mr43a91.8.1718138568861; Tue, 11 Jun 2024
 13:42:48 -0700 (PDT)
Date: Tue, 11 Jun 2024 20:42:44 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <cover.1718138187.git.zhuyifei@google.com>
Subject: [RFC PATCH net-next 0/3] selftests: Add AF_XDP functionality test
From: YiFei Zhu <zhuyifei@google.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: "=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Stanislav Fomichev <sdf@google.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

We have observed that hardware NIC drivers may have faulty AF_XDP
implementations, and there seem to be a lack of a test of various modes
in which AF_XDP could run. This series adds a test to verify that NIC
drivers implements many AF_XDP features by performing a send / receive
of a single UDP packet.

I put the C code of the test under selftests/bpf because I'm not really
sure how I'd build the BPF-related code without the selftests/bpf
build infrastructure.

Tested on Google Cloud, with GVE:

  $ sudo NETIF=ens4 REMOTE_TYPE=ssh \
    REMOTE_ARGS="root@10.138.15.235" \
    LOCAL_V4="10.138.15.234" \
    REMOTE_V4="10.138.15.235" \
    LOCAL_NEXTHOP_MAC="42:01:0a:8a:00:01" \
    REMOTE_NEXTHOP_MAC="42:01:0a:8a:00:01" \
    python3 xsk_hw.py

  KTAP version 1
  1..22
  ok 1 xsk_hw.ipv4_basic
  ok 2 xsk_hw.ipv4_tx_skb_copy
  ok 3 xsk_hw.ipv4_tx_skb_copy_force_attach
  ok 4 xsk_hw.ipv4_rx_skb_copy
  ok 5 xsk_hw.ipv4_tx_drv_copy
  ok 6 xsk_hw.ipv4_tx_drv_copy_force_attach
  ok 7 xsk_hw.ipv4_rx_drv_copy
  [...]
  # Exception| STDERR: b'/tmp/zzfhcqkg/pbgodkgjxsk_hw: recv_pfpacket: Timeout\n'
  not ok 8 xsk_hw.ipv4_tx_drv_zerocopy
  ok 9 xsk_hw.ipv4_tx_drv_zerocopy_force_attach
  ok 10 xsk_hw.ipv4_rx_drv_zerocopy
  [...]
  # Exception| STDERR: b'/tmp/zzfhcqkg/pbgodkgjxsk_hw: connect sync client: max_retries\n'
  [...]
  # Exception| STDERR: b'/linux/tools/testing/selftests/bpf/xsk_hw: open_xsk: Device or resource busy\n'
  not ok 11 xsk_hw.ipv4_rx_drv_zerocopy_fill_after_bind
  ok 12 xsk_hw.ipv6_basic # SKIP Test requires IPv6 connectivity
  [...]
  ok 22 xsk_hw.ipv6_rx_drv_zerocopy_fill_after_bind # SKIP Test requires IPv6 connectivity
  # Totals: pass:9 fail:2 xfail:0 xpass:0 skip:11 error:0

YiFei Zhu (3):
  selftests/bpf: Move rxq_num helper from xdp_hw_metadata to
    network_helpers
  selftests/bpf: Add xsk_hw AF_XDP functionality test
  selftests: drv-net: Add xsk_hw AF_XDP functionality test

 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |   7 +-
 tools/testing/selftests/bpf/network_helpers.c |  27 +
 tools/testing/selftests/bpf/network_helpers.h |  16 +
 tools/testing/selftests/bpf/progs/xsk_hw.c    |  72 ++
 tools/testing/selftests/bpf/xdp_hw_metadata.c |  27 +-
 tools/testing/selftests/bpf/xsk_hw.c          | 844 ++++++++++++++++++
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../selftests/drivers/net/hw/xsk_hw.py        | 133 +++
 9 files changed, 1102 insertions(+), 26 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/xsk_hw.c
 create mode 100644 tools/testing/selftests/bpf/xsk_hw.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/xsk_hw.py

-- 
2.45.2.505.gda0bf45e8d-goog


