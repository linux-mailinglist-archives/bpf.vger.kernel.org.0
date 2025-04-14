Return-Path: <bpf+bounces-55837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F125CA87722
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 07:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7431016E8C4
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 05:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B105019E966;
	Mon, 14 Apr 2025 05:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bcp92RhW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DAE1BC3C;
	Mon, 14 Apr 2025 05:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744607347; cv=none; b=IFfmamZYYOAjohOn/5+xeQper6XVWNtO9m2rnMyQG0se3dHC5W3FipmXmNVdR+IBj9T9fhug3EmeDeRf4Og+6j82Bi42KYFiEIE0N2efmhtqaAKn3ZCkE0feXS5fysjyz8TsWGsPVfOY8T/41UaRCqV52L1vfu6p8F8CeWrVzLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744607347; c=relaxed/simple;
	bh=EUELgt4hMnMMJOO/U7NuEFbDX9SHw5BmfrFvM/ORxqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pZd3DShHYvQIqVrzbObDUAQaFa39gpQBVavBxAzSVzXI6OwzgMnSvVO6VCkstn3X5vp391nDkTAr6CG9388EXJp/Pk4NMXbH5KtRLmQLmigQMQFtb+oLtwPkb+Owu47CGD2MOnl+g5/HaEFF82nKcsL0DocDjSjtCAeg8Pbjt1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bcp92RhW; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-af523f4511fso3381749a12.0;
        Sun, 13 Apr 2025 22:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744607345; x=1745212145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Fej5fA5t2ol5BfFTXsvj0x2AUS/N3lMaLna6woIGmM=;
        b=Bcp92RhWcd0/jDkkNmAlqQlUGkp4NTuEM24Ir/jO1SoJJ4wG/qFXanQ6/T6ylpiEmN
         w38Guik4BWwf0aU4BPETOpGZzCVsNo28+gKC2I9jdiDZh+bEj837Kn8ZgtaWvmmumNgD
         S6uHDvmveWqz2aXWRYjmx3SqbZGpzNjYvwLKXL4K7TIT50h5UiG0p7/a6bmXc9Qbf8/A
         UiQCbCSCEledYgnHyFFsw69K8DHBuTS0tjx1GFkzDseKU2REc7n5k0B7TuYJDoY7QX3B
         k0copjxk+EAUKnVocM+7e7ktypdW1VpIvmVYPJ8t2PGA2rtHjZm7M5AkAgEpQVKWG9k9
         Pqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744607345; x=1745212145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Fej5fA5t2ol5BfFTXsvj0x2AUS/N3lMaLna6woIGmM=;
        b=CG98WgRIGi4KBtK3ObXpkOBL0sAxmEV0QJirbUa6brpdKCAAXufAL5Qu0rHJ06V4yT
         JLvJouKLNWLOGgIg3LHkHvYYiYjvR+RYCxbzycofzpoUEfYhtUEITYISJs+MrAxz3QAv
         V5PDrMB70s9OadhxszFdX1ic2Bn+ofLAQUJYfYZNM+LgFZX0ZCm6aheKbCL7/PgArjcg
         REZxF0MyGFQWV1ce1RC0OYxkPxt1Q95uTX6QqIMs/eMHOU06CgHgFuXbC/YYGBLGX4J3
         OtQ/uKwkIaW5AQUOxoqq6aAg1PzBg9IbcTN69efGV4jAbDz6pF9sZAGB5um5hOpeJJPQ
         4tCw==
X-Forwarded-Encrypted: i=1; AJvYcCVujYn1rBeey4A0CrHxQ3hnkYmB7BSZo1n0Qtz5OJza4UkjjH3cOQ69Ok8kgbIquclitmE=@vger.kernel.org, AJvYcCX1ghCtEd1qoVIIhuh3XqkQP+WMGk939sifgIMgiY3vJ28oyGAbgG8zuqk1K80TTP5AmmJQnNSUHb0eY1UC@vger.kernel.org, AJvYcCXarsZGlMzhr4+k5tQUzTzRx+pFvGHyr5JhIGa7jXsCwX3Z/+j0QPU4g2CFFqit1mU6fK28KqAp@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6xuPuUkzDhufOyWKt7xHZl+ZHytMWGF5hIXOOPfQwPK7lailO
	7d3zRCnqKlOvnL2Ag2cAPIegvbYhYfC2Uz1NRRA3IgEd+2f8vCkTM5KyiLxFOpg=
X-Gm-Gg: ASbGncvZ5QXBMUpu+a48zFYKzUrZuqHg+FSLkyTYGSWrwst+SLQ8mcifsPjK4J/77n3
	t78GFusIW1r1bRXHl2y0iskLT/vORUhYaYU3dxGmkPattNZrYfFB3GsbFq6h2W/Mhwqy2B51eLB
	kljGgcffnLoTTPyiRduq4avDjiaONZM01IHsmMtXBGNAh6tMIPxPCFi5dO+H8F5aTRfFo2f70j2
	9CKrEjTqNwae3yVqaMk4ucvSPOJ8rf3OVypmqdS/peosiZgYNBbw4yExj3y1qpmGp6P1HS7O3pa
	LBqfYj7fYOoLxYE3vNTOXMFX3GF+TiQ+DkgDlYV8KtVYRILiX+LwYcHtLa1+TdH2Pw==
X-Google-Smtp-Source: AGHT+IGdtrEP7ucqfNOc8FOWb04RISSfzP7ZCyxG4G1woJVwa1KuxSGZbHjR22opAFd/Nl338AzsgQ==
X-Received: by 2002:a17:902:c951:b0:220:e5be:29c8 with SMTP id d9443c01a7336-22bea4f185dmr178332735ad.32.1744607344881;
        Sun, 13 Apr 2025 22:09:04 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:b80:9edb:557f:f8a7])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22ac7cb5047sm90778665ad.170.2025.04.13.22.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 22:09:04 -0700 (PDT)
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
Subject: [PATCH v2 0/3] virtio-net: disable delayed refill when pausing rx
Date: Mon, 14 Apr 2025 12:08:34 +0700
Message-ID: <20250414050837.31213-1-minhquangbui99@gmail.com>
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

Version 2 changes:
- Add selftest for deadlock scenario

Thanks,
Quang Minh.

Bui Quang Minh (3):
  virtio-net: disable delayed refill when pausing rx
  selftests: net: move xdp_helper to net/lib
  selftests: net: add a virtio_net deadlock selftest

 drivers/net/virtio_net.c                      | 60 ++++++++++++++++---
 tools/testing/selftests/Makefile              |  2 +-
 tools/testing/selftests/drivers/net/Makefile  |  2 -
 tools/testing/selftests/drivers/net/queues.py |  4 +-
 .../selftests/drivers/net/virtio_net/Makefile |  2 +
 .../selftests/drivers/net/virtio_net/config   |  1 +
 .../drivers/net/virtio_net/lib/py/__init__.py | 16 +++++
 .../drivers/net/virtio_net/xsk_pool.py        | 52 ++++++++++++++++
 tools/testing/selftests/net/lib/.gitignore    |  1 +
 tools/testing/selftests/net/lib/Makefile      |  1 +
 .../{drivers/net => net/lib}/xdp_helper.c     |  0
 11 files changed, 127 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/lib/py/__init__.py
 create mode 100755 tools/testing/selftests/drivers/net/virtio_net/xsk_pool.py
 rename tools/testing/selftests/{drivers/net => net/lib}/xdp_helper.c (100%)

-- 
2.43.0


