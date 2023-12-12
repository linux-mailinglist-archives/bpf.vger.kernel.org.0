Return-Path: <bpf+bounces-17500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D487580E89B
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 11:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1299D1C20B77
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 10:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F3F59520;
	Tue, 12 Dec 2023 10:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hG9FDney"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B0A59175;
	Tue, 12 Dec 2023 10:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70532C433C7;
	Tue, 12 Dec 2023 10:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702375600;
	bh=h+T9I5BzmOya2sSP/IZWP5pFJANu52Uuc7l94k1vs74=;
	h=From:To:Cc:Subject:Date:From;
	b=hG9FDneyeJ3zvA622waiGWIGQdJ0tzH0OPJgDREIs3bOR9o71z406dy/O3mkA+x+Z
	 ePpteCDmbk/fuMg6e95MbHBAup6I4IUuF0BbZh4E6Rbpn/Qp95KoBTpF6C+EhPj6PQ
	 68rNAreTFuBEa2jZYR1gv+eKftT1TrDMGhLOXZCkEMzIe9sLKnO6B+pIsnd+s2EQtb
	 0e4PuDXHVyGqFdq1ng8EcPs0HqAker5h/hd9KL/Tjk8kc8lDieSi5M8y5GOThfcEk3
	 rejZtG77Du0+E9rbngBYtVOHl8nN7o5I0dBtQwPK009Gx+N0W8OF06VFhPk3CY4gfL
	 EbOQ3FL0DydgQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	bpf@vger.kernel.org,
	hawk@kernel.org,
	toke@redhat.com,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	sdf@google.com
Subject: [PATCH v4 net-next 0/3] add multi-buff support for xdp running in generic mode
Date: Tue, 12 Dec 2023 11:06:12 +0100
Message-ID: <cover.1702375338.git.lorenzo@kernel.org>
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

Changes since v3:
- introduce page_pool in softnet_data structure
- rely on page_pools for xdp_generic code
Changes since v2:
- rely on napi_alloc_frag() and napi_build_skb() to build the new skb
Changes since v1:
- explicitly keep the skb segmented in netif_skb_check_for_generic_xdp() and
  do not rely on pskb_expand_head()

Lorenzo Bianconi (3):
  net: introduce page_pool pointer in softnet_data percpu struct
  xdp: rely on skb pointer reference in do_xdp_generic and
    netif_receive_generic_xdp
  xdp: add multi-buff support for xdp running in generic mode

 drivers/net/tun.c               |   4 +-
 include/linux/netdevice.h       |   3 +-
 include/net/page_pool/helpers.h |   5 +
 include/net/page_pool/types.h   |   2 +-
 net/core/dev.c                  | 165 ++++++++++++++++++++++++++++----
 net/core/skbuff.c               |   5 +-
 6 files changed, 160 insertions(+), 24 deletions(-)

-- 
2.43.0


