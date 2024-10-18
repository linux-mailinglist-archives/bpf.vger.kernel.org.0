Return-Path: <bpf+bounces-42387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E649A39A6
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 11:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 655B42818E8
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 09:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2651E2609;
	Fri, 18 Oct 2024 09:14:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D7D192D80;
	Fri, 18 Oct 2024 09:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242863; cv=none; b=rjicACsWzxL+RQOy8OrBxlMnT0YBdfsMg8swVvZ9SdTouiYKSQsLYlj30HtN7r2ioUS2UdrdW3p8VX9wyFeGWJURW43oXyDXzy82fZGDt9aejD/7iI52WeSUkZBIr2oW9XxA9uvXd71h3tA9uU5m+DruKgZD1ATeB3VzJhT2qsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242863; c=relaxed/simple;
	bh=sxJTYdwiUkQgirXxvXiZJib9YBozDbvx+lFRQ/cdd1Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WeVgY4dq+ZcPpY42uxBw5cT+2xOQKwp8jjFLLjdQZ/MyGrkoJwdWjBbCkwkxqTn0V4AhaeD6xKkZN8u7joBqNeVLi0Gs0g2P4OA19+NYzYbrFuuwRVP6LrI94EMsnOxjtA/fg2sFhRPKX3A2edOcDsyuAIWhc98goCOeFosYIys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XVJrf5vGczyTWQ;
	Fri, 18 Oct 2024 17:12:50 +0800 (CST)
Received: from dggpemf500014.china.huawei.com (unknown [7.185.36.43])
	by mail.maildlp.com (Postfix) with ESMTPS id D01D614011A;
	Fri, 18 Oct 2024 17:14:16 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500014.china.huawei.com
 (7.185.36.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 18 Oct
 2024 17:14:15 +0800
From: Muyang Tian <tianmuyang@huawei.com>
To: <bpf@vger.kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>, Magnus Karlsson
	<magnus.karlsson@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<yanan@huawei.com>, <xiesongyang@huawei.com>, <wuchangye@huawei.com>,
	<liuxin350@huawei.com>, <zhangmingyi5@huawei.com>, <liwei883@huawei.com>,
	<tianmuyang@huawei.com>
Subject: [PATCH bpf-next v2 0/3] XDP metadata: Rx checksum/GSO hint; Tx GSO offload
Date: Fri, 18 Oct 2024 17:14:59 +0800
Message-ID: <20241018091502.411513-1-tianmuyang@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf500014.china.huawei.com (7.185.36.43)

This series introduce XDP metadata functionality, including Rx checksum/GSO hint
and Tx GSO offload. This is aimed to transfer control fields when processing jumbo
frames between VMs.

v1:
https://lore.kernel.org/all/20241017135430.51655-1-tianmuyang@huawei.com/

Changes since v1:
- add reference to previous work[1] in patch 1/3

[1] https://lore.kernel.org/bpf/20230811161509.19722-13-larysa.zaremba@intel.com/

Muyang Tian (3):
  xdp: Add Rx checksum hint
  xdp: Add Rx GSO hint
  xsk: Add Tx GSO type and size offload support

 Documentation/netlink/specs/netdev.yaml      | 12 +++++
 Documentation/networking/xdp-rx-metadata.rst |  6 +++
 include/net/xdp.h                            | 50 ++++++++++++++++++++
 include/net/xdp_sock.h                       |  8 ++++
 include/net/xdp_sock_drv.h                   |  1 +
 include/uapi/linux/if_xdp.h                  | 11 +++++
 include/uapi/linux/netdev.h                  |  8 ++++
 net/core/xdp.c                               | 41 ++++++++++++++++
 net/xdp/xsk.c                                |  5 ++
 tools/include/uapi/linux/if_xdp.h            | 11 +++++
 tools/include/uapi/linux/netdev.h            |  8 ++++
 11 files changed, 161 insertions(+)

-- 
2.41.0


