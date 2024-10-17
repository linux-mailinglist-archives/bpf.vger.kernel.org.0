Return-Path: <bpf+bounces-42303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4279A244F
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 15:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067C91F218DD
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 13:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D751DE3D5;
	Thu, 17 Oct 2024 13:54:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5079B1DD548;
	Thu, 17 Oct 2024 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173244; cv=none; b=kHIQ2lT6a8dcnm4xIsEZDLvggtOJkzzbJQHldh8YyUAJ/CzqD/hGEAPPksSDtMimv6OsYMI0rXmGWmEm19CaDoOu2xONpIorw2X46pJl+H70yHBx4pbhijhNJMnKfnI/abLcNdI0X4dub11FRhcQt6Xo/fFHdMIhO2NZZ86NzNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173244; c=relaxed/simple;
	bh=IH3Uylx1YONf9VtitwIhuesyCxpppdWrAVAobKbN2Ck=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ApjnaSYSbrHEhIeENAC/tHfBz5HUDQZCmIfkq5ybXpJ4htpZQEYkQSzn5occgIYiy2dYei3Xqsu9G2RCYeQZiReu1s7PPkjUdYLkyqB1FCjhW3LRC3x55s4dv/5K3QRHom0D3JgmiuokpzCb0w/v71sa2pK7At8vLTpzMIcDJsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XTq4g71r5zfdCc;
	Thu, 17 Oct 2024 21:51:31 +0800 (CST)
Received: from dggpemf500014.china.huawei.com (unknown [7.185.36.43])
	by mail.maildlp.com (Postfix) with ESMTPS id 8F0961800F2;
	Thu, 17 Oct 2024 21:53:59 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500014.china.huawei.com
 (7.185.36.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 17 Oct
 2024 21:53:58 +0800
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
Subject: [PATCH 0/3] XDP metadata: Rx checksum/GSO hint; Tx GSO offload
Date: Thu, 17 Oct 2024 21:54:27 +0800
Message-ID: <20241017135430.51655-1-tianmuyang@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf500014.china.huawei.com (7.185.36.43)

This series introduce XDP metadata functionality, including Rx checksum/GSO hint
and Tx GSO offload. This is aimed to transfer control fields when processing jumbo
frames between VMs.

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


