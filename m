Return-Path: <bpf+bounces-49412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF40DA1857D
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 20:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45A2116975C
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 19:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AAB1F755D;
	Tue, 21 Jan 2025 19:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="KE+iFltD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051631AC88B
	for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 19:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737486669; cv=none; b=TsqdstB5TvVNtgLCVoGs5szxyknTo9kg8f2/vlu9qV+P+WzaWFje8yIN12T1kGB46MTcIFMznCatTnA61IcA+w/sAiHQATMUeJFAuLNLG4S71X/aAPQY+WXLqt/v9A3skWYNrMMRtHPk/djlvyig23ZHsCQxU4RBqBi1B46ArJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737486669; c=relaxed/simple;
	bh=+0FsmQUk4wwlNbG2Q/Gp0YW679krx30KK3RM+HGyF8M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d/KZP/37DjOIRsjUguOX6ogfQL1Rb4ONq7aSIXR+aqpWvi2ANXorrAcrmZZ/ELVR/9Oj86j3fyIAQOQh+KcH/fmceviXCZrmghN7X988TrzHRb55sWMy0mL3IJ+RrqNLCOJS4XirBJbpz4wZWJJcB4LCzN990UyXg52K3JliAgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=KE+iFltD; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ef714374c0so142131a91.0
        for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 11:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737486665; x=1738091465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q3Sac5q4L1YHRHONzzVYH+nRWURN24ROJ0RWQrQ27i0=;
        b=KE+iFltD5m4xnOq/0rwt+0jIeDZ9Og5YNghAGyhrx3EQGoPfXtTjzd/0Ubdl0F5rpL
         BdwROMUN4quo17y7CrQCoOKBE1SE7TKK28DHutoyp1wtQwJFZS0O4OyreVNmcwk7G27Y
         AX5HQtj9GykHSJqE/U+o8jj3Zf1JeeCISppeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737486665; x=1738091465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q3Sac5q4L1YHRHONzzVYH+nRWURN24ROJ0RWQrQ27i0=;
        b=B2dG3pbN7xU5ZhSU65O5/pkEVD6/geTyOyNbjRBX16HHk0ZoIjdZEbEekH5xB+Wuxb
         BEs4LeKG2TvUTd0nNbPosHChEWJeBLsqCIwQ5x0OTHJRh+ozddJRfiOTd7MxLi8c5gBr
         G8GCpFcYTp9GP/ZRVuf6NV/i79LkbPFlWvTPRvqolK3bFIqcKuBigBHSNAE+yxbGqHZl
         QdwPIe9iDWkmW3IbulaTNUqgR62INHF3nvpMNEDWC/M9KpLIYoQerqWp9dlj3o6mlzW4
         WkcmRRxXa2+dSVYvJQeH3KsqnLzEZsxg5RHbIx8dj1sPulNTermNBy/I107GKvPvBos+
         l85Q==
X-Forwarded-Encrypted: i=1; AJvYcCWS9++ZPCdAtr8oSqkxBGXbDsb2hKnpA7DAaTrCK7T/qL3H3UujyoFmRQX4LqjFRelDEpU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdk6oyusYn1s+P1jzXXDqfORMBbrNTxJwYhVFmEhs5ozkbN6Q0
	5pGT8wOogh6p0VQ4nz7RKKwBP+dYfGNWbM8syz5fJjH9wrzQ/GU75CeF6VQL5+E=
X-Gm-Gg: ASbGncsqjqONgj7J5NNMzJQX6oNLaBGdi+gNDuahfR3iyGSfdyN3gvoj2DqC8tNJdzW
	dMDVdin7cvsM0ibmsTqOIQuY011uCC1ZGTvLsLlWpXFEoKQw/H/myO/9JRAbTmeyKqjggfapmw0
	BA5tNbHFOCp5k3VpVyK5XDG2qSnHNNVz0LGx+GLGRlQv9LyQ1ememYywKDgr2D3lITI0T9sCn1n
	0ZoKDy8Cpb6ocBStTjNqfH4GZISoJ1TXR0+5brKvMrllEbzpFT51IdukiYpFpkenZG8DyFL7cxe
	Rw==
X-Google-Smtp-Source: AGHT+IESdTWYzrYdfrjHndy1A6eiSq6VjHZhj5JI29tgHseTks5JAkTBUNTjwpCAQiHydlbjVFpE3A==
X-Received: by 2002:a17:90b:53ce:b0:2ee:cbd0:4910 with SMTP id 98e67ed59e1d1-2f782beed8bmr27056092a91.1.1737486665211;
        Tue, 21 Jan 2025 11:11:05 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7db6ab125sm1793440a91.26.2025.01.21.11.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 11:11:04 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	leiyang@redhat.com,
	xuanzhuo@linux.alibaba.com,
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
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	linux-kernel@vger.kernel.org (open list),
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Simon Horman <horms@kernel.org>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS)
Subject: [RFC net-next v3 0/4] virtio_net: Link queues to NAPIs
Date: Tue, 21 Jan 2025 19:10:40 +0000
Message-Id: <20250121191047.269844-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to RFC v3, since net-next is closed. See changelog below.

Recently [1], Jakub mentioned that there were a few drivers that are not
yet mapping queues to NAPIs.

While I don't have any of the other hardware mentioned, I do happen to
have a virtio_net laying around ;)

I've attempted to link queues to NAPIs, using the new locking Jakub
introduced avoiding RTNL.

Note: It seems virtio_net uses TX-only NAPIs which do not have NAPI IDs.
As such, I've left the TX NAPIs unset (as opposed to setting them to 0).

As per the discussion on the v2 [2], all RX queues now have their NAPIs
linked.

See the commit message of patch 3 for an example of how to get the NAPI
to queue mapping information.

See the commit message of patch 4 for an example of how NAPI IDs are
persistent despite queue count changes.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20250109084301.2445a3e3@kernel.org/
[2]: https://lore.kernel.org/netdev/f8fe5618-af94-4f5b-8dbc-e8cae744aedf@engleder-embedded.com/

v3:
  - patch 3:
    - Removed the xdp checks completely, as Gerhard Engleder pointed
      out, they are likely not necessary.

  - patch 4:
    - Added Xuan Zhuo's Reviewed-by.

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

 drivers/net/virtio_net.c      | 38 +++++++++++++++++++++++++++--------
 include/linux/netdevice.h     |  9 +++++++--
 include/net/netdev_rx_queue.h |  2 +-
 net/core/dev.c                | 16 ++++++++++++---
 4 files changed, 51 insertions(+), 14 deletions(-)


base-commit: cf33d96f50903214226b379b3f10d1f262dae018
-- 
2.25.1


