Return-Path: <bpf+bounces-56105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7ABA91563
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 09:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF64619030AC
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 07:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1253221728;
	Thu, 17 Apr 2025 07:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBzhUSzp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB07F22170F;
	Thu, 17 Apr 2025 07:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744874963; cv=none; b=HW6gVOxiZTsaDsmK0UnA/l/xsqUO3Tyits8ySjTkSkfRhl9f1D3PR9BYMSwfQV1dj+1xM8x1SBmcwqgTNa8DXdJKx6S+M3F6YNoj8JpowC5icJoxo8NQXiVrbdAP9bCB9+Ydx8fXAf708lSoSh6SNvkXF6TgOcQ8LZ5/pwgEtNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744874963; c=relaxed/simple;
	bh=y9TZDQGpXnKwI0UWUN8LOu9Cl+PcOJCJTNXweRk/7W0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cd4WXHcbrvRoKqwH5iIfxpIrHGxBGqvGnr7rcajitOKBI0hl9nLAXoyf3mox4ps7LfcDu+nzXT0EOq2BL1YWIi2ctT2sBpclubK2op6ROcrNWjScLk1njBUaVmgPVoY8SYjIa3IlvjD9vJosWFsOk4nDAPZ9rkZL4lX4Ma2QGzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBzhUSzp; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-73c17c770a7so600799b3a.2;
        Thu, 17 Apr 2025 00:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744874961; x=1745479761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PbhaIlXKAU6n8hzVFN1a+GS8NGL/eiRsd2Kom/nuTD4=;
        b=KBzhUSzpc1F1c848Nx6zaKkbyEHdkTtI13BRbeh9CxuG+tgI1xYrdBRxnmlC6HYjcV
         Ltyd2J6W3rbfgbcnoBj0TPFEW/1nagPVvNQRCZ3fYVqiOjXf//RGz2j7i8wN+Efwa+PV
         FgzN8ODDRJDbFwoJ+dZO7BNPEk2PN1ZlCuEsfEVIxteu9vt8hDjtu+M+lDeuN4yngPZm
         cIfAyynWPN3CkcifVOlqdrgpKoVOiTxohBMXlSenf5/L8ajXzZyROI7PZhZ9ylWza8Fw
         onvsCiARbHvk9NjPt/gh1UWkjKFF5p+e81YszRe5coPa3WO0IJMXfsCAIVZhbCD54nIK
         RRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744874961; x=1745479761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PbhaIlXKAU6n8hzVFN1a+GS8NGL/eiRsd2Kom/nuTD4=;
        b=YM7DNE0+voosOr6xvigOcO1rFzXfXxnBS0qNrT0/08Bmn0N54Woql+Lc1ceqlzsBL4
         sovFEpGV7SeZ372uFxAGi2Es3vSNEAUP2eNqzzwputoy+Zt5rDcYj5UZZl09UdO8rQsq
         NjpdAouU0HNZB+eMKfRpa+rG2IaUx75QaH+0BNZrhJMvfAIS0v3va+6HukQoQDCJUz/4
         oerNHjhss7kFmUXEkAHEdex+oGRdRmKEj8q7udAE7LkkmvL64qymheyQsK3kxiESCl6R
         aB+ZVfcdV12ParhhMoCDtJMM9uPfkM/Yvl0EyiJuB6z3Havmr/OkAXkEjWMYGLPbUnbQ
         FH9A==
X-Forwarded-Encrypted: i=1; AJvYcCVARE+r3ZiMvm+TIjnpmbO29SXdmn62Jrv5ay1jD87XgY3/u3qOlqVPO3MidOYRsBeef14=@vger.kernel.org, AJvYcCWQHvky5y5Si6op6E6/gbcW3nGLgrwH9Fs5BPJr2KjzCLa7UMO+UguL5mOkyRxbpdx4VJD/dTEm@vger.kernel.org, AJvYcCWW+mlXC+FmGLbJnduenanUWo6XdP/RJPuKD1JloMgheittJ/Ii2X8enooHvChHTJJG5PvVOUYs00P4Lni+@vger.kernel.org
X-Gm-Message-State: AOJu0YyIb/jMjwPk5rtMt55unMhUdZSPf1/FfQUq7/Pv9PSaj9VUPfzt
	gF8xgX4L2vpg0imJKcSgLU6ipo9WQeAFxXV/huVTURcmb1KDXcFbH5gAe36H4ow=
X-Gm-Gg: ASbGnctnVzizdGG6WcKYndCfiQzRgtw/BxMpfCZiiM8YuVgXNkSeDWcvKM8Sau7t4L9
	YO1xZlYeRBSbe3OiT3Z6qy1ZwSqw8F6sdEU9tG/VT0JTchR4DPXeFDYVf7p73ePym2v7xNLkG0N
	VWF4zbqz35Jx900MEylYsKI3SdWFFwviJ+NdP7+RQ4LRZxV3C+IO+AtXeH8jNZwEdtj8ZimEAVx
	Zrk3Smbvzu3/FQf3aoCNJ8EGh0CshPGJz1eePLZyGYbOcUGxah/J5VYI4cVVBZ+u/jJwH+WP/6F
	KZhjqVNj6CFTgPtMCdTKpNajCVrQwKwi06yGyoXiG2+cmEvVjmy1O3yyP98cT/l4VUY=
X-Google-Smtp-Source: AGHT+IFzEblk8eZ9i/5b7FlNpqvFEMtawQArN9INdKriryj2jHy81r0kRCXNbZYM8rVezBQJYW1ZKg==
X-Received: by 2002:a05:6a20:43a8:b0:1f5:8e54:9f07 with SMTP id adf61e73a8af0-203b3ecd617mr7221150637.24.1744874960903;
        Thu, 17 Apr 2025 00:29:20 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:ab45:ee9c:5719:f829])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73bd22f0f3fsm11625344b3a.115.2025.04.17.00.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 00:29:20 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
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
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v4 0/4] virtio-net: disable delayed refill when pausing rx
Date: Thu, 17 Apr 2025 14:28:02 +0700
Message-ID: <20250417072806.18660-1-minhquangbui99@gmail.com>
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

Version 4 changes:
- Add force zerocopy mode to xdp_helper
- Make virtio_net selftest use force zerocopy mode
- Move virtio_net selftest to drivers/net/hw

Version 3 changes:
- Patch 1: refactor to avoid code duplication

Version 2 changes:
- Add selftest for deadlock scenario

Thanks,
Quang Minh.

Bui Quang Minh (4):
  virtio-net: disable delayed refill when pausing rx
  selftests: net: move xdp_helper to net/lib
  selftests: net: add flag to force zerocopy mode in xdp_helper
  selftests: net: add a virtio_net deadlock selftest

 drivers/net/virtio_net.c                      | 69 +++++++++++++++----
 tools/testing/selftests/drivers/net/Makefile  |  2 -
 .../testing/selftests/drivers/net/hw/Makefile |  1 +
 .../selftests/drivers/net/hw/virtio_net.py    | 65 +++++++++++++++++
 tools/testing/selftests/drivers/net/queues.py |  4 +-
 tools/testing/selftests/net/lib/.gitignore    |  1 +
 tools/testing/selftests/net/lib/Makefile      |  1 +
 .../{drivers/net => net/lib}/xdp_helper.c     | 13 +++-
 8 files changed, 138 insertions(+), 18 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/virtio_net.py
 rename tools/testing/selftests/{drivers/net => net/lib}/xdp_helper.c (90%)

-- 
2.43.0


