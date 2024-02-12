Return-Path: <bpf+bounces-21725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00526850FFF
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 10:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D811C21D00
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 09:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C07E17BC1;
	Mon, 12 Feb 2024 09:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+fmod6P"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FB9179AD;
	Mon, 12 Feb 2024 09:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707731503; cv=none; b=ToXn3NsRSL8eaC3fx2uEAFA0UJuO3j8j2l6PTX/yBxShV/pUlWtdFLIHpqKM53kg2kRVvmACcu9QPtYOzuhn5AhNPz/MvnOL1jRjz0Pd8M9q26w4bp3edvERcmuYJICQS1aoNj5ydepm/HhCdTG5rZ0VHs/i/4uAm9fsDydidSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707731503; c=relaxed/simple;
	bh=VKJRqZfLWsm+N7pdIsKPtIEQyQNhxJsDk3o8zVSC9fE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eDuYcBtfXAUJay2nmaYLfRvd5xYubbz3sIZmfBeHEvqjlqf67teTxgMtPL37+2Hf/eoFIs2bi83CCEmQg6o+gcTR8+w8vr55sOQqSmIxcsCqfcN4yI10gId8VRXEVMolQB2VD/I20gpemCm78pathMJfmjRvs6vX4sdgkvC5Cu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+fmod6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C06EC433C7;
	Mon, 12 Feb 2024 09:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707731503;
	bh=VKJRqZfLWsm+N7pdIsKPtIEQyQNhxJsDk3o8zVSC9fE=;
	h=From:To:Cc:Subject:Date:From;
	b=b+fmod6PlGlu3Ew1zpSFEFj6Fng1Fx1+EIDaBVoUrp3VhG4iPQxMVJYcHhbwcsLAv
	 XrmHKBovA12Q+WlaCHsGL7FvgBSO5CVrsnZNrSNAt1esCu6y6zfIBMJkj0PQi0hDxy
	 HqsUwAMsgVQ2xWU1orgf8m/BhIvonssDbOdQusavYiUCMCiYqV3o0f++/aB6sE8qXC
	 Y9+r4IcnBdgIFhj7grWLbMgA0GP9NxdcyksMFijPXk9ckVUXfO0zS3y997NYBsO9yH
	 8j7NjcIMF5lYZcxJrQeNpR7yIqIYIq/Jdlij6iG8J8gO6ZOilrpgVDlxh6AlTu2ifD
	 BfuYgxqDbd3bw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
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
Subject: [PATCH v9 net-next 0/4] add multi-buff support for xdp running in generic mode
Date: Mon, 12 Feb 2024 10:50:53 +0100
Message-ID: <cover.1707729884.git.lorenzo@kernel.org>
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

Changes since v8:
- fix veth regression introduce in veth.sh selftest
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
  veth: rely on skb_pp_cow_data utility routine

 drivers/net/tun.c             |   4 +-
 drivers/net/veth.c            |  74 +------------------
 include/linux/netdevice.h     |   2 +-
 include/linux/skbuff.h        |   4 ++
 include/net/page_pool/types.h |   3 +
 net/core/dev.c                | 131 +++++++++++++++++++++++++++-------
 net/core/page_pool.c          |  23 ++++--
 net/core/skbuff.c             |  97 ++++++++++++++++++++++++-
 8 files changed, 231 insertions(+), 107 deletions(-)

-- 
2.43.0


