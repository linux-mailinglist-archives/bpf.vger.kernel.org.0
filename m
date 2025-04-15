Return-Path: <bpf+bounces-55925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44326A89576
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 09:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4039F3B4E3A
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 07:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4736227B4F5;
	Tue, 15 Apr 2025 07:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vswq4AgA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9C327A90E;
	Tue, 15 Apr 2025 07:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744703090; cv=none; b=q/xDHW+DmkZsYhaFfqhdPSHlnnUowHTatTUeQ8APVOh6JElflgfLBA7w451pBMogmww8uIdYnz3AFkGvmirBsj4p8XRPOeMtfAJffuGtk+pcgvXevM/pHUd2sbiyE3gwlsjdWhqAJQEu+SOLe3S1W5coy8cV2s5Kl42V9Mw91rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744703090; c=relaxed/simple;
	bh=/FMiH6f5AUMprgPLBbbPPAw7emqARXWFCdmaOPkb+7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uNQz2lEUFX/fmDwMHVehbUoeR/VmGTS6tnjf7dmMDk2XfVGLGLpt9b8E8US8POcpv5Pthk6WEKCTbtRxMTMiok403cBBKD7l4x1h1cYRwp0o5YvbpcFcVHuSLg+b2WGmgmWuOzeGB02nzvCRmDPOGTB3slRMV2M0ce+idF5EreI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vswq4AgA; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-af59c920d32so3828490a12.0;
        Tue, 15 Apr 2025 00:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744703088; x=1745307888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=INveNnza9CWIqZPyYaWqCh5Ba9wSoB725eCjLaHauL4=;
        b=Vswq4AgASRbtXJtavdVePOF8b4KDoxaUTsix7WlNBmLIFCV5wQ30ZKwABG2o6nqBc4
         i/Fo8zhMllX1T/8Hd/HPpSY5TQszFkMvnBBTrLsuVurSTyDyakWom3gc89eKAe2M09kh
         hC5Q6QhnR94NYTBBJjlik61axqsTbkBfglPqS3/B2NAl/JEsbkXu11HbV+aftnPkXvRl
         CKBL5yCsxjHtORj7EiNfUds2izPrgmrComjuzHj9dEpve+SKoMSlf+ATyZGyymuorYht
         oUKL3qYWoCWvxRTn3OFLC1F3xOT2LRbUPgNydACMRsmCnFExmLcIjl68TUHsUmcRAuHi
         HcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744703088; x=1745307888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=INveNnza9CWIqZPyYaWqCh5Ba9wSoB725eCjLaHauL4=;
        b=jsvYIA8Z0/+Vbf1a0wc0bPCz4tH+7O1JssZMmAmxOqZ4azo4S9SUwB9yiZExp9f41d
         n1tLAmBkd4wltCfHnrzCieeaiTpR7E0DhGuIjabeBupy0w3AfZr2YE6LFVzKHHLIdQwt
         4t82D+KryrwasLHC7Mmd1LqsAKxr3uYDoLWaVkdKreaWAOmS1OJL57pX7ZhZqmTGH5Q/
         5G//vdRXXn9cLpD0FRHjcDWa6zHThSLzuZ5pC6ZazcnAn26nqsbUuEXpJkaMPDgj1PVO
         5Fjj8V2hDBKOKocK/Zm/vAXB/YR7NIILVh3E9P1lacjhdy+mo7IBeIOBdt+w3vSa3mgY
         +3GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaWKP/JUVWu/TA4yM5+ET9aGXfk54tKc6v+DK/wWiCy2BInm6l9kjK/78uEGRRrKWOSAQ=@vger.kernel.org, AJvYcCVx+m11jtilEFDiGNuFyYrq50ZkziSp+ik7YjAsqtxbJF0CLPe4aWkBk6UC+F6TKIL4gKDmCX66@vger.kernel.org, AJvYcCXk2NUNnyHee2ApsCXWFLdYbAuGHIE3MBVIqlRdrDSQfGiZp6VvSZnHStDfu2XhzwGJEEj/ykyly3aK3uLq@vger.kernel.org
X-Gm-Message-State: AOJu0Yyaz6d2nsaAkohP5BD+ti8zZ62fAsjMFLfUyW/h5pRKv5bXfnGV
	RLBckLgxPJt36G5i1zDebr73VVvbnnLhGrdbVolfsExWiGk1yO3b
X-Gm-Gg: ASbGncsK+AO9Xp2bVxf05ztj089MRITCPZNpZ5IgLirDJc9pb/yL1T1PetzKYdJV12l
	FA4sHFqQfhwNmlB61ZYItpTDdIUYiErui3TKZZ8tZ39e3vl8OTQ4qc3F8vgbahSq1yCp8r+P34Z
	U/GHG4nIIorNgVcKFclqzNr3W3sSIc9qsw9mKklZlvyI0xPCGE3D6Uf7xgTWm9lkbhGXzeFdoXP
	ltqeaiEdP4XpSxUtHDNC8vZzJG3PIlANNfK0lJXfcE+AgWy9aILVxWoufis9sOqfY2fjZNsgsis
	f7vZTPrDaFPXjRGrdLMYabLovNohoo2cl3mLNTKwaqp12cVAhIzkzEcM
X-Google-Smtp-Source: AGHT+IFe3WANt4aQPrZWoKBiNglIghBIABqDLjBb7Rl9R3Vj+PTaviPvNoVUhpOXPz+mqNiZrIE0qw==
X-Received: by 2002:a17:90b:51c3:b0:2ee:f076:20f1 with SMTP id 98e67ed59e1d1-308235db6f0mr26769695a91.0.1744703088365;
        Tue, 15 Apr 2025 00:44:48 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:2e0b:88f9:a491:c18a])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-306df401ac8sm12299767a91.45.2025.04.15.00.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 00:44:47 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: virtualization@lists.linux.dev
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v3 0/3] virtio-net: disable delayed refill when pausing rx
Date: Tue, 15 Apr 2025 14:43:38 +0700
Message-ID: <20250415074341.12461-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This series tries to fix a deadlock in virtio-net when binding/unbinding
XDP program, XDP socket or resizing the rx queue.

When pausing rx (e.g. set up xdp, xsk pool, rx resize), we call
napi_disable() on the receive queue's napi. In delayed refill_work, it
also calls napi_disable() on the receive queue's napi. When
napi_disable() is called on an already disabled napi, it will sleep in
napi_disable_locked while still holding the netdev_lock. As a result,
later napi_enable gets stuck too as it cannot acquire the netdev_lock.
This leads to refill_work and the pause-then-resume tx are stuck
altogether.

This scenario can be reproducible by binding a XDP socket to virtio-net
interface without setting up the fill ring. As a result, try_fill_recv
will fail until the fill ring is set up and refill_work is scheduled.

This fix adds virtnet_rx_(pause/resume)_all helpers and fixes up the
virtnet_rx_resume to disable future and cancel all inflights delayed
refill_work before calling napi_disable() to pause the rx.

Version 3 changes:
- Patch 1: refactor to avoid code duplication

Version 2 changes:
- Add selftest for deadlock scenario

Thanks,
Quang Minh.

Bui Quang Minh (3):
  virtio-net: disable delayed refill when pausing rx
  selftests: net: move xdp_helper to net/lib
  selftests: net: add a virtio_net deadlock selftest

 drivers/net/virtio_net.c                      | 69 +++++++++++++++----
 tools/testing/selftests/Makefile              |  2 +-
 tools/testing/selftests/drivers/net/Makefile  |  2 -
 tools/testing/selftests/drivers/net/queues.py |  4 +-
 .../selftests/drivers/net/virtio_net/Makefile |  2 +
 .../selftests/drivers/net/virtio_net/config   |  1 +
 .../drivers/net/virtio_net/lib/py/__init__.py | 16 +++++
 .../drivers/net/virtio_net/xsk_pool.py        | 52 ++++++++++++++
 tools/testing/selftests/net/lib/.gitignore    |  1 +
 tools/testing/selftests/net/lib/Makefile      |  1 +
 .../{drivers/net => net/lib}/xdp_helper.c     |  0
 11 files changed, 133 insertions(+), 17 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/lib/py/__init__.py
 create mode 100755 tools/testing/selftests/drivers/net/virtio_net/xsk_pool.py
 rename tools/testing/selftests/{drivers/net => net/lib}/xdp_helper.c (100%)

-- 
2.43.0


