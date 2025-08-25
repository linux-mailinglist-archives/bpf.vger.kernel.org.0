Return-Path: <bpf+bounces-66388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D18B34255
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 15:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9C9207E64
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 13:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0C221ADCB;
	Mon, 25 Aug 2025 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="al9qwRd8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD5E1E9B12;
	Mon, 25 Aug 2025 13:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130052; cv=none; b=MtLA9ETHnb4ArI+TZpCI4BAfyVCTwIhC8nwVLd9MIr/Bh0+qRmU+sTzBtJ+yIkFqdUsgGiVD+kRM3snCXbK45B5dVU7zrzpbUVPTOrNnRtIHGz+V9iIV8rTblkxFdYY0A4THxQvNEGbKZmQisih4yVHpgmFK8Nu6GARxFbyRGWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130052; c=relaxed/simple;
	bh=wMmrfot6wN8TWwRhHlJnTtaN8aYYZ7t0WcF5Hk8+740=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uqiTlsdLK4+ulTrCcKc72t88MOpHtk3kQsUq1kI4Dv69/TZ3dpYxLEYY+ymCKvDCb+LeFuQ4dEGp1cqr2vbyT0Yf6IlRblEvKI/YEGn/g8JdsqWfKXSiiESii/bdBNSzivKfxM0YMtwEXNsnKoku2lXBPFItSsoCoe9NR2IdeEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=al9qwRd8; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-323267bc2eeso3354998a91.1;
        Mon, 25 Aug 2025 06:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756130049; x=1756734849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y5qEMWfHR3mIHQDOt5qmXuyVoAIrVvOwNXNwIRxR9Xw=;
        b=al9qwRd87MWj58EuoJZfIXklAqfF2QAvP0aTtUsxCHsyXLQ5ZOuGCRJOLhtLuhMyKT
         fl+vBU/s5imtkTmgkMEO6pi/v3MZz4SUJ6Mi3UxXxXmtRtpsHRrelUry3imvw+vxr4ap
         SaP3N71EIZ+OiJ+62qyXrL1svIXy9yM8GCPk6kye+gTc3hmIfLn3F7GUpuX2PI+vqTm5
         i2zlyllgjNfi1F9Axi1j8Bsuefd75KrD/pE1jpdtI1O39yeyXMe8+PKcFFXXOQrDAbBn
         4Fy+mDkRYhbkfBPZdvSUAG5F41K5ge09icKxNoNkXCCLHae0A9BwUsuMgCtRuU2eD86I
         xh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756130049; x=1756734849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y5qEMWfHR3mIHQDOt5qmXuyVoAIrVvOwNXNwIRxR9Xw=;
        b=YMXw10TAfs86aChjWiDsHUujzDpgDFKqvpkCA8UvoL0jUHOJ1uumQ4rZCXvFOD3DV3
         gaaahkwH8rp9mLm+wJ0adQV7fC3oN3vWMzTHQv7eCnCCCulBD4XTBTabDNO+lcaM+sRy
         k5zo/eAlBqjNMV2FjljRdszpDnE+xh8b487qsJrz9gex1jQd/GNhF3gPCtjishf7NiFX
         T8P8NfHm9pz9sjq6l4klYRPXS7ocxxIews/xY8CiB1X9Bepk/MlSBRHCbsNFZ+BbIwWz
         uu7RmSwFZ0hnmC8SZRz6xdjaLq38APaG6D1AnNHwaAONtr0orV1gV4Id4pZ+XPJBFs5c
         fUbw==
X-Forwarded-Encrypted: i=1; AJvYcCUYTHHKNeDleynwg9P2MyGDFoZhFgsrnoZbsLMFPzs89Ik0A6RyZVeYaAC+ko6ziOUqBPzSR64=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGV7eutodkiuS7YGySJe1bS3VADwYcILr08Up5EwfLpF7SLkuo
	+f4mc3C1FjYkBhj/VyEN+u58yUuabVAza+/69xYYgx/CU1MY6eBS9+wsGAJzxgi5
X-Gm-Gg: ASbGnctEQBKlScjkUUSkj90mcaJnwU/SlbEintz0zf82MMTpRGEn+JXVckdPS5ihd3H
	rU8rJ+IpsHin9NOU6LTw9krTU++9nSQui/H8C/SsKiZ+IEY1LqSo3IH2ut8jV8LELUqpx/NbaVT
	xstvvb80bPJmr4nbDmRJalFB/9o0A0yHs3Ob95NnF5y9FWjYdSBcZHzbf8eaYmMTYkw2dnUmUou
	4ZH6XUZ0KNWn/WNXpuV4WcRjFgcfd+nz0ZEzDP42zKWLkZDRSXFW8ZX2QrFvqvmbv8fSl99Azi8
	lJLFU9anaIRN1f9aKQJeEJR2bCfIQ7uoGETErEqaFw8FGTLnzNzfBVZXpUAoYL13CGA7YdRDiNV
	/0VZUaiLmlUbdH2EjoHuWFpVBqJ/9ecpDq/kxvF1a6A6ehaTcWsRaiBjAJoBIspoEpuPjgQ==
X-Google-Smtp-Source: AGHT+IGeXTQhGDM/dax/N3ekCxYXIBIlZxxUmkpNn54iyEY2bz8FQAjA9Bt8gWRZxFLvC4AUI2KYfA==
X-Received: by 2002:a17:90b:2ccf:b0:321:1df6:97d3 with SMTP id 98e67ed59e1d1-32515ead940mr15063650a91.4.1756130048373;
        Mon, 25 Aug 2025 06:54:08 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.28.60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4a8b7b301csm3374073a12.35.2025.08.25.06.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 06:54:07 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 0/9] xsk: improvement performance in copy mode
Date: Mon, 25 Aug 2025 21:53:33 +0800
Message-Id: <20250825135342.53110-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Like in VM using virtio_net, there are not that many machines supporting
advanced functions like multi buffer and zerocopy. Using xsk copy mode
becomes a default choice.

Zerocopy mode has a good feature named multi buffer while copy mode
has to transmit skb one by one like normal flows. The latter becomes a
half bypass mechanism to some extent compared to thorough bypass plan
like DPDK. To avoid much consumption in kernel as much as possible,
then bulk/batch xmit plan is proposed. The thought of batch xmit is
to aggregate packets in a certain small group like GSO/GRO and then
read/allocate/build/send them in different loops.

Experiments:
1) Tested on virtio_net on Tencent Cloud.
copy mode:     767,743 pps
batch mode:  1,055,201 pps (+37.4%)
xmit.more:     940,398 pps (+22.4%)
Side note:
1) another interesting test is if we test with another thread
competing the same queue, a 28% increase (from 405,466 pps to 52,1076 pps)
can be observed.
2) xmit 'more' item is built on top of batch mode. The number can slightly
decrease according to different implementations in host.

2) Tested on i40e at 10Gb/sec.
copy mode:   1,109,754 pps
batch mode:  2,393,498 pps (+115.6%)
xmit.more:   3,024,110 pps (+172.5%)
zc mode:    14,879,414 pps

[2]: ./xdpsock -i eth1 -t  -S -s 64

It's worth mentioning batch process might bring high latency in certain
cases like shortage of memroy. So I didn't turn it as the default
feature for copy mode. The recommended value is 32.

---
V2
Link: https://lore.kernel.org/all/20250811131236.56206-1-kerneljasonxing@gmail.com/
1. add xmit.more sub-feature (Jesper)
2. add kmem_cache_alloc_bulk (Jesper and Maciej)

Jason Xing (9):
  xsk: introduce XDP_GENERIC_XMIT_BATCH setsockopt
  xsk: add descs parameter in xskq_cons_read_desc_batch()
  xsk: introduce locked version of xskq_prod_write_addr_batch
  xsk: extend xsk_build_skb() to support passing an already allocated
    skb
  xsk: add xsk_alloc_batch_skb() to build skbs in batch
  xsk: add direct xmit in batch function
  xsk: support batch xmit main logic
  xsk: support generic batch xmit in copy mode
  xsk: support dynamic xmit.more control for batch xmit

 Documentation/networking/af_xdp.rst |  11 ++
 include/linux/netdevice.h           |   3 +
 include/net/xdp_sock.h              |  10 ++
 include/uapi/linux/if_xdp.h         |   1 +
 net/core/dev.c                      |  21 +++
 net/core/skbuff.c                   | 103 ++++++++++++++
 net/xdp/xsk.c                       | 200 ++++++++++++++++++++++++++--
 net/xdp/xsk_queue.h                 |  29 +++-
 tools/include/uapi/linux/if_xdp.h   |   1 +
 9 files changed, 360 insertions(+), 19 deletions(-)

-- 
2.41.3


