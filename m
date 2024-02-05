Return-Path: <bpf+bounces-21212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F398498F2
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 12:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA01D1C215B5
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 11:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB4918C3B;
	Mon,  5 Feb 2024 11:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0QBSRZv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2192618E08;
	Mon,  5 Feb 2024 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707132940; cv=none; b=dxjPfoJb3NyJKJ5ZhytGSA5xE07lATUN9ldUvNuYdlIP+0g1lZbmsEjkYpubB6vLhanGt7W79DaIlpeiPmtV3qRoniqxFVDG8MrTgeWC7PPBCppnkuYMM2myRsLOxBSCapNeAZCj41b5RJrz5IOve4NiE69jg5TDBbaMS4F1cos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707132940; c=relaxed/simple;
	bh=yI2SqIv3nHm+DnnBvwCta43fm8yrJu4XF9CQCyTJaBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j9MP7cQG7zFwSlRE1+U9uYWYVXACUEfEwGy8jyU+39wcBIWCca0H4kMmdNvGLfU9bVxNNYqSYaE9VL1KzfgoS3HMiUBv8P/S0wZ8zn56XC4KZSNUNrbh3dKgJZKgjFLfVP2FwvZhhjLQojJEhzJFhSK4D6KTm0mMyXBlHNfd6Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0QBSRZv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27064C433F1;
	Mon,  5 Feb 2024 11:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707132939;
	bh=yI2SqIv3nHm+DnnBvwCta43fm8yrJu4XF9CQCyTJaBw=;
	h=From:To:Cc:Subject:Date:From;
	b=o0QBSRZvNg0bF+UFm8BiUiYqM4HSkx0G9t+sBPI2iaD+YP5EQp9xc0WwfayY3hZuD
	 yudCfZ2Yuj9gP+JdCdQXq0tcR9sorXZWUqd5uH84B6NsJk34GCxcHEc8ANREDMPlIE
	 z2mN+9wuJ1qQbbYxqw37h2ATJIT7hIzZsjN6WlB3bz+PzTccQxBt/wYQWGTcREKnHO
	 nz1wMR1tS/ETzn/4ibTF5Ng3hKz67mTlv/I2/Tx1b6+tNx6Zs0kH8hgyrWRMaTYS8T
	 MyM5GeYwoSE94xTQ5kWxv1nDzmQTlQgOxqBrUARjGVWE3pxXyFfSNzVnvAGwa82d7s
	 roqSaurVZbKIw==
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
Subject: [PATCH v8 net-next 0/4] add multi-buff support for xdp running in generic mode
Date: Mon,  5 Feb 2024 12:35:11 +0100
Message-ID: <cover.1707132752.git.lorenzo@kernel.org>
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

Changes since v7:
- fix sparse warnings
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


