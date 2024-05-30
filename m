Return-Path: <bpf+bounces-30907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 788A48D45FD
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 09:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA8151C219D1
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 07:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C8879F2;
	Thu, 30 May 2024 07:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qE7bQ3gK"
X-Original-To: bpf@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2E6142E7C;
	Thu, 30 May 2024 07:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717054016; cv=none; b=P1MK9e/HEI3HRA7AJzN/xuhtXw9pSIU2NMFMPe1L8x6WREmBDNY/UzLVfhrmGoeb+A3kiOWw846QsyXjPZm8lSZOmMYJBjauTVl324crU0QAHYEkuoLshG3ZqXbW2UkuaibqaOAGuR80JIYcdA5w45RIRFD7cAfcBQJFf3OAvaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717054016; c=relaxed/simple;
	bh=eYFKnVeN/MPK8jO98yxwGONYZm55s9y/1x4YFrzPaqM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m1dYHUW6HTZ/3pKZJzOyaVQFrBXozgVxDM2aNh2CiDk5TTALdOinr9zoM8/qIPYt+GOdgYz9wICZ2KEAsHL3AYvY8vHtpKC4X5Ud5xblNUfnvVDZAxlGHoknQFo1CYKVBvF2IGr2773oM/jMp5FUDEdD4/+mgv8bL9httq8ieMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qE7bQ3gK; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717054010; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=/i+MUL3pDEawjH7fkUL8OQTa2XOF8nBBeIXATV5rGL4=;
	b=qE7bQ3gK4coWBlEye+TqgFhcdjW/cmxLs4U8h5lqH7SMjLZzKXQsG1faREdaWgQbgM5ZAbSHrzBE2zHjfGe4hjFy8fdUiZtXm9yP6q3inLvLLmJZL2jUOTMbMRTc9A4+toOzCsRCn71wZ4gky4Bg4+J8w6zfaftqLpDXCIVxD0c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W7WBAvV_1717054009;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W7WBAvV_1717054009)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 15:26:49 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v1 0/7] virtnet_net: prepare for af-xdp
Date: Thu, 30 May 2024 15:26:42 +0800
Message-Id: <20240530072649.102437-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 12be1d34ab2c
Content-Transfer-Encoding: 8bit

This patch set prepares for supporting af-xdp zerocopy.
There is no feature change in this patch set.
I just want to reduce the patch num of the final patch set,
so I split the patch set.

#1-#3 add independent directory for virtio-net
#4-#7 do some refactor, the sub-functions will be used by the subsequent commits

Thanks.

v1:
    1. resend for the new net-next merge window


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
 drivers/net/virtio/virtnet.h                  | 248 ++++++++
 .../{virtio_net.c => virtio/virtnet_main.c}   | 536 ++++++------------
 7 files changed, 454 insertions(+), 363 deletions(-)
 create mode 100644 drivers/net/virtio/Kconfig
 create mode 100644 drivers/net/virtio/Makefile
 create mode 100644 drivers/net/virtio/virtnet.h
 rename drivers/net/{virtio_net.c => virtio/virtnet_main.c} (94%)

--
2.32.0.3.g01195cf9f


