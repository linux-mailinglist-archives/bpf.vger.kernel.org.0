Return-Path: <bpf+bounces-16378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 638D4800C85
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 14:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00E25B212D5
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 13:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55AC3B792;
	Fri,  1 Dec 2023 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQYdMjrT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE8838DD4;
	Fri,  1 Dec 2023 13:48:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E34EC433C7;
	Fri,  1 Dec 2023 13:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701438537;
	bh=G4rudiM487FuEtqMRKcoK5J651E3SEsKcZ4QuRfCfOg=;
	h=From:To:Cc:Subject:Date:From;
	b=tQYdMjrTSDcAC8d4pfspg/JqEjYIXCwAgEyv88036kFzvNupVbO/1XE83+o9E+wJU
	 G8r3vqLbhk4jpkBl1XwnmfCXQzznm+bQojqi9x0E4w9QEBTM+CVbAP6D6KE2Zwm3N6
	 ChfvxVPvCV+usH97ADbS03Gcf0DjJfo8bC3Bk/jFHuqXLje0bIYFVvoFxsqvqHwNbK
	 HPIk+HmU2B/BCzZg0SEthxnSbh84ZCyevHe4deSXiHKGFuZjTT6MqWvv7QzBFSm8sm
	 QocfY2goTYJg7Tf49cQ0d163v4lWJw5WNP8Wu/1O04KpjGMqhl20XwgKljgeeY9NoA
	 ieyfnFkY2qkTA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	lorenzo.bianconi@redhat.com,
	bpf@vger.kernel.org,
	hawk@kernel.org,
	toke@redhat.com,
	aleksander.lobakin@intel.com,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	sdf@google.com
Subject: [PATCH v3 net-next 0/2] add multi-buff support for xdp running in generic mode
Date: Fri,  1 Dec 2023 14:48:24 +0100
Message-ID: <cover.1701437961.git.lorenzo@kernel.org>
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

Changes since v2:
- rely on napi_alloc_frag() and napi_build_skb() to build the new skb
Changes since v1:
- explicitly keep the skb segmented in netif_skb_check_for_generic_xdp() and
  do not rely on pskb_expand_head()

Lorenzo Bianconi (2):
  xdp: rely on skb pointer reference in do_xdp_generic and
    netif_receive_generic_xdp
  xdp: add multi-buff support for xdp running in generic mode

 drivers/net/tun.c         |   4 +-
 include/linux/netdevice.h |   2 +-
 net/core/dev.c            | 165 +++++++++++++++++++++++++++++++-------
 3 files changed, 137 insertions(+), 34 deletions(-)

-- 
2.43.0


