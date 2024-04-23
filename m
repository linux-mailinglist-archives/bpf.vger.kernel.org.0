Return-Path: <bpf+bounces-27532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC148AE3F9
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 13:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27023287C4D
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 11:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FC382C60;
	Tue, 23 Apr 2024 11:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XtA9mcPP"
X-Original-To: bpf@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EB47FBCF;
	Tue, 23 Apr 2024 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871913; cv=none; b=bYMhoas48sFh9n794LdMllfkfuHjmIzFdyIPeXOHLhlGAljf/GHvaMIvolQ29Qjjq586GolWEKtZPYtvr8tWyrDA5Athvzx3r5U0AeqTHVH2dXdOnD6LOqG6sr43z9kQuOzT/z2tKamMUf//X7Kt5X57uJfL4EF8JDpsf76bf3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871913; c=relaxed/simple;
	bh=1lPiGQ5shC4C7UOa4YIACl3pZn+ENy7c7yEhkeTIp38=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=akgm8K2MmzzmiZYZG+0g1GQ7k507GiZPyI8twEfs0pH1mW4YpzcyNSaHUv6z5gjLvnBysVwdfanlt7tY5CfsfrDU53SbwG6qSfYs5IAX/RHdQP9i9DsEtdkv+Dq5FN8Q0Hwl6h8kr9owV+Lw5r8ZQFp0EMGlt8yd1mXYHY6WHkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XtA9mcPP; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713871903; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=xoJ9YNLWXu7XQFYT7mcYJIil9lkfTlWRr3vGzICttBY=;
	b=XtA9mcPPFen/FB3BSDqiXtnxMOeK2FuWs0jeHjOuqgkXtdG8jZ9GFmbg+zOwCHODLiOnEm9zRuwPm1u/F2VRccX9trcWByOAYwZFfbEk2xPlE1QPpgGUo6YGQSxqhJxp0062uhobGRKQBB6dvEdaWQ1CXJx2KAP0VA6TVncN93w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W596LXQ_1713871901;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W596LXQ_1713871901)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 19:31:42 +0800
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
	Stanislav Fomichev <sdf@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v6 0/8] virtio-net: support device stats
Date: Tue, 23 Apr 2024 19:31:33 +0800
Message-Id: <20240423113141.1752-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 75c95ace5f2d
Content-Transfer-Encoding: 8bit

As the spec:

https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82

The virtio net supports to get device stats.

Please review.

Thanks.

v6:
    1. remove 'maps'. check stats by if-else.

v5:
    1. Fix some small problems in last version
    2. Not report stats that will be reported by netlink
    3. remove "_queue" from  ethtool -S

v4:
    1. Support per-queue statistics API
    2. Fix some small problems in last version

v3:
    1. rebase net-next

v2:
    1. fix the usage of the leXX_to_cpu()
    2. add comment to the structure virtnet_stats_map

v1:
    1. fix some definitions of the marco and the struct







Xuan Zhuo (8):
  virtio_net: introduce device stats feature and structures
  virtio_net: remove "_queue" from ethtool -S
  virtio_net: support device stats
  virtio_net: device stats helpers support driver stats
  virtio_net: add the total stats field
  virtio_net: rename stat tx_timeout to timeout
  netdev: add queue stats
  virtio-net: support queue stat

 Documentation/netlink/specs/netdev.yaml | 104 +++
 drivers/net/virtio_net.c                | 969 ++++++++++++++++++++++--
 include/net/netdev_queues.h             |  27 +
 include/uapi/linux/netdev.h             |  19 +
 include/uapi/linux/virtio_net.h         | 143 ++++
 net/core/netdev-genl.c                  |  23 +-
 tools/include/uapi/linux/netdev.h       |  19 +
 7 files changed, 1247 insertions(+), 57 deletions(-)

--
2.32.0.3.g01195cf9f


