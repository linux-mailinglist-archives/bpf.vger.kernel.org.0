Return-Path: <bpf+bounces-27879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C56B78B2F10
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 05:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28CB62816E8
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 03:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E696878C65;
	Fri, 26 Apr 2024 03:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="J9+ASLv7"
X-Original-To: bpf@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE0C394;
	Fri, 26 Apr 2024 03:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714102776; cv=none; b=byC7jw72Im46bB5tvCE70jof2hNr5sViYSityCyV352lxq/iPOGEDAyxArTH93Wop1s0Wr8nYgrdY5AQReuiAoC94GC7FyZT43cX1iJz/T0KUyc8NseL1veUc5R+CnZ2xFrwSKLMFoETl6uIfhsdBcpjH6BjYHwRKl88W1DfCxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714102776; c=relaxed/simple;
	bh=/ASHD4Wyz3SZUjAXn/LgSh11JoymE3SKlDvfYthl1Is=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dnWh4geneUUfW4ues6vjINBOP44okY37dojiVxhy60VwKBCGx0xwtolkmFElkJkhS0ude/5BLi8wJBu/GypqBYZPa+BoHQHMwZC8Sw3vAFH1kbFDATki3ovnxZDwyt8Bz7R+nq6VWHAWQuLdwaW5YxeVEn0C/oAcdQEVp1To9jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=J9+ASLv7; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714102770; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=CxlEd6LZH3PpraUX+0MZs/PrnMfei86AI7BjU1vvbt4=;
	b=J9+ASLv7PDFc6pX0crSMS8cknV0kF4e0IYMOWZ9470vWcOnH2Xt+cxpYFi5IsbaJEnMRb0usWT+tGVm2SvphkQmkieIqZ3SSNq1FLamGxrDSiOv2LyjL+Uf/a0u/av2buEf0/rivvNnhc9a53u3CnXlv2JEfPIb0/O0k1LrHbag=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014016;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W5HSYRX_1714102768;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W5HSYRX_1714102768)
          by smtp.aliyun-inc.com;
          Fri, 26 Apr 2024 11:39:29 +0800
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
Subject: [PATCH net-next v7 0/8] virtio-net: support device stats
Date: Fri, 26 Apr 2024 11:39:20 +0800
Message-Id: <20240426033928.77778-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 435b736161fa
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
  virtio_net: introduce ability to get reply info from device
  virtio_net: introduce device stats feature and structures
  virtio_net: remove "_queue" from ethtool -S
  virtio_net: support device stats
  virtio_net: device stats helpers support driver stats
  virtio_net: add the total stats field
  netdev: add queue stats
  virtio-net: support queue stat

 Documentation/netlink/specs/netdev.yaml |  104 +++
 drivers/net/virtio_net.c                | 1010 +++++++++++++++++++++--
 include/net/netdev_queues.h             |   27 +
 include/uapi/linux/netdev.h             |   19 +
 include/uapi/linux/virtio_net.h         |  143 ++++
 net/core/netdev-genl.c                  |   23 +-
 tools/include/uapi/linux/netdev.h       |   19 +
 7 files changed, 1284 insertions(+), 61 deletions(-)

-- 
2.32.0.3.g01195cf9f


