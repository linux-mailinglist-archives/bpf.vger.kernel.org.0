Return-Path: <bpf+bounces-49028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE11A132C8
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 06:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4603A11EE
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 05:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F18141987;
	Thu, 16 Jan 2025 05:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ne8D1/Ol"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCB815886C
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 05:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737006804; cv=none; b=RI6oiendDXDXcV/EEQCgWjHRtpqHYSP/GtomyWiItX9B5xORVgwiqmMQVRjKQeFI8M0Ihd/4g+DcOrhzSCUDEIQ2Qgnai4fDuPTrhw1J6BE+fDMU/2O8yErrsAXxodL0QPzC+JKftc9nrTsbP8RoTJqgLj7ZkdPb4Yri1/hI+wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737006804; c=relaxed/simple;
	bh=PxaGUABDfZwGHALMhA6EDFWJE56G41dezvHCy/3MZPI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jDsuhkF0/FffXy2EyNRFF4w8roIyjuD54u9Fxk12e76lzyw/7tGSbxrRXwKxYDsz7Dgtl3bPeokxsIY+lbQPcMcYUV1n7Q9ZYZB4nOK80+ug/0/yoauZhoddJu6RSL9wBvuL7wgvMFSJp85vtC+aeSw+V8BzLR8C6ewV1/Gj9bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ne8D1/Ol; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-216281bc30fso11994255ad.0
        for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 21:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737006802; x=1737611602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1r+E3A1LZoi68KOlSIiDg+UrGp1t+qLs3TwuwgbmtBg=;
        b=ne8D1/Ol2yKux/hfBZNF7GdSMqUOuC++y70Mzrr0rSc9g8GkhFrRPOFwgycdkainC2
         x1p44Dv7XIjHuN00ssbR/cfpVf9kQCP9+i1lKNlh8cLwhsi+7dnaP/Nc0rZt6RltW+xD
         7FRVQkhycaKUYBtGGCEMUB2MvLAQe0H2nsEAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737006802; x=1737611602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1r+E3A1LZoi68KOlSIiDg+UrGp1t+qLs3TwuwgbmtBg=;
        b=GYatUUWq9aBSpyoqIw0MEeyf1wDpOM4Ou14Ed4Vuw+t0nTGiAgPXRa4s6YfYEjt5Yi
         gatc40I/du5PF+M620tewUDo86IEt2msZhWGenWxgjF5H6CMpx0UczKz1KM7kf2Do6Iu
         rBAOpd6G2bJt3nlXejkaAW4Hkhafhk4/ie6JcVyrrX/KKFX9E6BzrvhAFRRT9Bm4Fs7v
         /fDbktXZbvNSHEKqRAd4uCB6972Q3hVPeSIHj8FDx7p7yc3RSkoV9MvMlYMCaaBNrwlU
         Ld/asvCVkuqFX3eNK79WLSec5CukbvdWs2ELIT8GqURJ2yXBAQHN87+4PPGPtEH7j8vp
         3Inw==
X-Forwarded-Encrypted: i=1; AJvYcCU0uyulT9sHpsH6uuYw+hWk+86tjB1EAObEfVQZ5x/Lu1o/3giMoFBhl7dCVScG1XKqFm0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/LBM5ykaVFACxipt4umIMAEcBrc8YhUZiDxodLXfN5jB0Voh+
	U30lGrCNwkSjxv36EQnX4g8iUVeAVAcTU3TfaK7Ec0AypnXYys40OUTTSmE/BhU=
X-Gm-Gg: ASbGncsW7/WAPG7upie3L8lV1eUmF6TnJp2JxSxycvXP6Posar+YjH5RQoBlzLbVxkR
	kL9adrV41jsw00NPRWBP7VFbwGXcNxB+9CDN2oiODLHAwkfNfZYvjXX7I6Y7Ns9SPaK6smFD01v
	u+bD3LsjKKR2D12C2P2cSYS0R/RC+7dyFw/J2I2jnb25rZtEOws9Tr2K2t56f1kbPKOdqJb8bgP
	K8z4Xp/N89z8tBJHXspgWdqNe7u9ehOyX2GtIwtdzL3nObiDSpf3f9vD7vnOgDA
X-Google-Smtp-Source: AGHT+IFNdCXa8QX/05yvf/OWy2KJnL5/tksWkjrm/Z5QSwf5RL8iWi8wxNrXPyaNMxgtOmHTEyqogA==
X-Received: by 2002:a17:902:d482:b0:215:b058:28a5 with SMTP id d9443c01a7336-21a83f52831mr439294615ad.18.1737006802656;
        Wed, 15 Jan 2025 21:53:22 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22c991sm91249655ad.168.2025.01.15.21.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 21:53:22 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	leiyang@redhat.com,
	mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_)),
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Simon Horman <horms@kernel.org>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v2 0/4] virtio_net: Link queues to NAPIs
Date: Thu, 16 Jan 2025 05:52:55 +0000
Message-Id: <20250116055302.14308-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v2.

Recently [1], Jakub mentioned that there were a few drivers that are not
yet mapping queues to NAPIs.

While I don't have any of the other hardware mentioned, I do happen to
have a virtio_net laying around ;)

I've attempted to link queues to NAPIs, using the new locking Jakub
introduced avoiding RTNL.

Note: It seems virtio_net uses TX-only NAPIs which do not have NAPI IDs.
As such, I've left the TX NAPIs unset (as opposed to setting them to 0).

Note: I tried to handle the XDP case correctly (namely XDP queues should
not have NAPIs registered, but AF_XDP/XSK should have NAPIs registered,
IIUC). I would appreciate reviewers familiar with virtio_net double
checking me on that.

See the commit message of patch 3 for an example of how to get the NAPI
to queue mapping information.

See the commit message of patch 4 for an example of how NAPI IDs are
persistent despite queue count changes.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20250109084301.2445a3e3@kernel.org/

v2:
  - patch 1:
    - New in the v2 from Jakub.

  - patch 2:
    - Previously patch 1, unchanged from v1.
    - Added Gerhard Engleder's Reviewed-by.
    - Added Lei Yang's Tested-by.

  - patch 3:
    - Introduced virtnet_napi_disable to eliminate duplicated code
      in virtnet_xdp_set, virtnet_rx_pause, virtnet_disable_queue_pair,
      refill_work as suggested by Jason Wang.
    - As a result of the above refactor, dropped Reviewed-by and
      Tested-by from patch 3.

  - patch 4:
    - New in v2. Adds persistent NAPI configuration. See commit message
      for more details.

Jakub Kicinski (1):
  net: protect queue -> napi linking with netdev_lock()

Joe Damato (3):
  virtio_net: Prepare for NAPI to queue mapping
  virtio_net: Map NAPIs to queues
  virtio_net: Use persistent NAPI config

 drivers/net/virtio_net.c      | 47 +++++++++++++++++++++++++++++------
 include/linux/netdevice.h     |  9 +++++--
 include/net/netdev_rx_queue.h |  2 +-
 net/core/dev.c                | 16 +++++++++---
 4 files changed, 60 insertions(+), 14 deletions(-)


base-commit: 0b21051a4a6208c721615bb0285a035b416a4383
-- 
2.25.1


