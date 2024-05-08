Return-Path: <bpf+bounces-29039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 298D48BF7FF
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 10:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9078B20E8A
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 08:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D043FBAF;
	Wed,  8 May 2024 08:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="p86g6H+C"
X-Original-To: bpf@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF9E3D54C;
	Wed,  8 May 2024 08:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715155523; cv=none; b=bluLvx23ltZWD3TTsqFXPI3LT2Q+dBps6fEEzL2ndJUa+tcWZcBff2bA6W0p1CZPKWEqMlPkCpvDe7fSlMwKVxDtdLHKZyISJ4qb+QylnO/0A+AAF7JhgdXdImbwtj7DwPNvVHwx8d3FXQ6nCc8TH7MKluBO/4gxU4G0EkCG+z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715155523; c=relaxed/simple;
	bh=qqR83agXQEbmzafh3HB2HlPzpaNWEvj6q1H708qTSE8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BYSl5rCoyPo/6jkztUqVZpEAQpjBgOemWO1SUNSXOw2n1YRWKDa3/fXmpvz8pebaV0ecTsMwdCWLEXKOxYTiJVmgpTeFbXDFf0Ly2UdIyLhtnVXCMuhL6orjcvS/ZKJRPttN2q5a7yDHo8rP44NecGv72LE0Cp9x1SH2He4+Kgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=p86g6H+C; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715155517; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=PxiVd3BF1kBoCEVSaQqLLnUPkQgw448lFPoX54SUZ0E=;
	b=p86g6H+CfXOTBmlnh2P4iKEkGuIq4uumZdHU4CLpErYCtv5sKFiapkLX4ddsYbN7IePJQ+RMFNlN8tpqx3VxDPKMg7ejS+ETVxSwLYrPq9cG6vSKbH9Iw8r6EMC9YplsMV8BWfF8oboo6gVKHcEY+i22MRyNCqdYwQv3zQs2IJE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W62uyrm_1715155515;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W62uyrm_1715155515)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 16:05:16 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next 0/7] virtnet_net: prepare for af-xdp
Date: Wed,  8 May 2024 16:05:07 +0800
Message-Id: <20240508080514.99458-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 7cdcbabd0b89
Content-Transfer-Encoding: 8bit

This patch set prepares for supporting af-xdp zerocopy.
There is no feature change in this patch set.
I just want to reduce the patch num of the final patch set,
so I split the patch set.

#1-#3 add independent directory for virtio-net
#4-#7 do some refactor, the sub-functions will be used by the subsequent commits

Thanks.

Xuan Zhuo (7):
  virtio_net: independent directory
  virtio_net: move core structures to virtio_net.h
  virtio_net: add prefix virtnet to all struct inside virtio_net.h
  virtio_net: separate virtnet_rx_resize()
  virtio_net: separate virtnet_tx_resize()
  virtio_net: separate receive_mergeable
  virtio_net: separate receive_buf

 MAINTAINERS                                   |   2 +-
 drivers/net/Kconfig                           |   9 +-
 drivers/net/Makefile                          |   2 +-
 drivers/net/virtio/Kconfig                    |  12 +
 drivers/net/virtio/Makefile                   |   8 +
 drivers/net/virtio/virtnet.h                  | 246 ++++++++
 .../{virtio_net.c => virtio/virtnet_main.c}   | 534 ++++++------------
 7 files changed, 452 insertions(+), 361 deletions(-)
 create mode 100644 drivers/net/virtio/Kconfig
 create mode 100644 drivers/net/virtio/Makefile
 create mode 100644 drivers/net/virtio/virtnet.h
 rename drivers/net/{virtio_net.c => virtio/virtnet_main.c} (94%)

--
2.32.0.3.g01195cf9f


