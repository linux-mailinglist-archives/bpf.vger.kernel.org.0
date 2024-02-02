Return-Path: <bpf+bounces-21003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCE2846A78
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 09:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B500B21115
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 08:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46803481C4;
	Fri,  2 Feb 2024 08:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+ku33sy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA80481BF;
	Fri,  2 Feb 2024 08:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861629; cv=none; b=tPwj0QhcuA94qOmArrda144pRHYS5KubxWezUw7yzi4ipOzY1OETKGIfCJPvcQE6gtG2ZHyBnQAa4DxWs3pPp5nGCKOF8O2R6CXGiWVJFRknnkTvyXqSYgciSc4w/MElqLEjtgohj/dQB7E+4ZWL5f+KztSva4JxH8RmGXT4HOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861629; c=relaxed/simple;
	bh=XfLzST47VJBNS5ZHyeirZZjPPK8QbQBTpR6GbGj/hmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bd/WZuSnE8+j+Gw5CQSJ1t2Mz4Ge0jiTb0KTx9f0MeYGe+TsSTzPlpTicUCQhxKfaT1f/cJGP/7ivod9MZ3gwrkVSJCKRDvfPG55vHlzyw4c41SPw3W4n/m0tBNUB/XbYyQyMuC/FDcmgpDM7apOP9OI49hYG/WqFbhvvfJiZps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+ku33sy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79CBC433F1;
	Fri,  2 Feb 2024 08:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706861629;
	bh=XfLzST47VJBNS5ZHyeirZZjPPK8QbQBTpR6GbGj/hmo=;
	h=From:To:Cc:Subject:Date:From;
	b=j+ku33syA9Ukq7llRNaK09Ezm0lo9ZKI4uLXx0NRth2803R/4WxOLZS8uh6g4PXLs
	 DcwwVvgYzBc35WYTg1wO5J77DPBWZgkZkgWKtqNmwlsXEJAGjqBdzaeSGKD4yDRLOA
	 OAl3i8jU7EomVNX+K7cRAIyiXZRh+oQO6w1mbbnrHsSzIPQPa6LH2ulSbdDidhSXnX
	 TnSyKd6qkhHiUT2qGfs7a4PGpZiO6BE/61Q9G/0q74dQc0gCQY3w+2jhZAuqcAbAJs
	 RAih3DgkcmF7/lT2dm8FwgkL0JA7o3l7qNbjI1ZiMWM/ZW9N/6U0hYencnPx2RUyXE
	 Byj/G54ArpMTA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	bpf@vger.kernel.org,
	toke@redhat.com,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	sdf@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	linyunsheng@huawei.com
Subject: [PATCH v7 net-next 0/4] add multi-buff support for xdp running in generic mode
Date: Fri,  2 Feb 2024 09:12:43 +0100
Message-ID: <cover.1706861261.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce multi-buffer support for xdp running in generic mode not always
linearizing the skb in netif_receive_generic_xdp routine.
Introduce generic percpu page_pools allocator.

Changes since v6:
- remove patch 4/5 'net: page_pool: make stats available just for global pools'
- rename netif_skb_segment_for_xdp() in
  skb_cow_data_for_xdp()/skb_pp_cow_data()
- rename net_page_pool_alloc() in net_page_pool_create()
- rename page_pool percpu pointer in system_page_pool
- set percpu page_pool memory size
Changes since v5:
- move percpu page_pool pointer out of softnet_data in a dedicated variable
- make page_pool stats available just for global pools
- rely on netif_skb_segment_for_xdp utility routine in veth driver
Changes since v4:
- fix compilation error if page_pools are not enabled
Changes since v3:
- introduce page_pool in softnet_data structure
- rely on page_pools for xdp_generic code
Changes since v2:
- rely on napi_alloc_frag() and napi_build_skb() to build the new skb
Changes since v1:
- explicitly keep the skb segmented in netif_skb_check_for_generic_xdp() and
  do not rely on pskb_expand_head()

Lorenzo Bianconi (4):
  net: add generic percpu page_pool allocator
  xdp: rely on skb pointer reference in do_xdp_generic and
    netif_receive_generic_xdp
  xdp: add multi-buff support for xdp running in generic mode
  veth: rely on skb_cow_data_for_xdp utility routine

 drivers/net/tun.c             |   4 +-
 drivers/net/veth.c            |  79 ++------------------
 include/linux/netdevice.h     |   2 +-
 include/linux/skbuff.h        |   2 +
 include/net/page_pool/types.h |   3 +
 net/core/dev.c                | 131 +++++++++++++++++++++++++++-------
 net/core/page_pool.c          |  23 ++++--
 net/core/skbuff.c             |  96 ++++++++++++++++++++++++-
 8 files changed, 231 insertions(+), 109 deletions(-)

-- 
2.43.0


