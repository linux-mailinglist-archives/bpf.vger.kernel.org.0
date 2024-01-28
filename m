Return-Path: <bpf+bounces-20518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD18783F5CD
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 15:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A955A1C2273D
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 14:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528A224208;
	Sun, 28 Jan 2024 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggYNbFJx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC875241E6;
	Sun, 28 Jan 2024 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706451725; cv=none; b=mOlhvbghVsly+LYt5Y2NCeKFP56KacP+K3Yxx0BhuTwUkvTSoeX7qhGCuX6ggrgrkt3NlfqdNNvAFGVjPgXdn92eX4HZW4uhcMDVqD5gO7VtdPJUzw21m4Fbl9bKd05Kmyu3VlcgFoXamfYOiWqTaf+91mQsdOaUYF6WGzQeppU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706451725; c=relaxed/simple;
	bh=ang+nCmFKf2slqyEC4GZF8tTL7zqBTABH6qujY3xQG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K1Cgya/QplmKzAvBzNQCbEalXQIvdGAP5qrAMEftXCLBkqFdOCkF8tJVHUhk5QXrJIzU/Ex8YioI/uVVsvqgmCpIONBJaqGIVuO9AGTB0XndcPZdyPVwrVkHWrS+yICYFz7JRDZLSHNgy4cengm15vBqwoBi/UQRgSJr4HUZSY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggYNbFJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE32FC433F1;
	Sun, 28 Jan 2024 14:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706451725;
	bh=ang+nCmFKf2slqyEC4GZF8tTL7zqBTABH6qujY3xQG8=;
	h=From:To:Cc:Subject:Date:From;
	b=ggYNbFJxe/m+6XXt7OfZ/dP3niD51RrOSYfMUrt+5crfAIoa07bt82Baq6UJb2TNO
	 9i9h6YwLnk6SEofIJSLrbfbx2tK8A6oeHuG1PPtqygy1qU7Z9aoDv8UwJ5vKJM5naW
	 jgqz88ngWV9SY3z31249gVseLUqEL0+n+0QDeii/pTBrr6RelpToXmg9YmjJKFeJLK
	 wiz/VhVN3XcvMC+QcLA4IxTO43D4rxxbB7O8at0klYaBLfA1GxUbTCnLeIF744tpQT
	 FlpuAqhundAe74z2rvHLeysZZ1z+wCNQftCSbUtDceq1HYZ1iJOtiaH4mxLfspMN49
	 5mgCFOAAvzk/g==
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
	ilias.apalodimas@linaro.org
Subject: [PATCH v6 net-next 0/5] add multi-buff support for xdp running in generic mode
Date: Sun, 28 Jan 2024 15:20:36 +0100
Message-ID: <cover.1706451150.git.lorenzo@kernel.org>
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
Introduce page_pool in softnet_data structure

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

Lorenzo Bianconi (5):
  net: add generic per-cpu page_pool allocator
  xdp: rely on skb pointer reference in do_xdp_generic and
    netif_receive_generic_xdp
  xdp: add multi-buff support for xdp running in generic mode
  net: page_pool: make stats available just for global pools
  veth: rely on netif_skb_segment_for_xdp utility routine

 drivers/net/tun.c             |   4 +-
 drivers/net/veth.c            |  79 +------------
 include/linux/netdevice.h     |   6 +-
 include/net/page_pool/types.h |   3 +
 net/core/dev.c                | 208 +++++++++++++++++++++++++++++-----
 net/core/page_pool.c          |  59 +++++++---
 net/core/skbuff.c             |   5 +-
 7 files changed, 241 insertions(+), 123 deletions(-)

-- 
2.43.0


