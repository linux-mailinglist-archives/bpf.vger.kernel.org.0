Return-Path: <bpf+bounces-17834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFEF81331C
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 15:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628FA1C21A68
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 14:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4649359E5B;
	Thu, 14 Dec 2023 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWnf4Lj8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B058259E5F;
	Thu, 14 Dec 2023 14:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5A0C433C8;
	Thu, 14 Dec 2023 14:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702564205;
	bh=+BzpmybH8TpR19WiAZWpvn+GbKvF0cZTnrZKRQbr3qU=;
	h=From:To:Cc:Subject:Date:From;
	b=iWnf4Lj8+4sIZczunm32t3ZMCh4mu7E99b75u5W1XRiBGhzbAPTTBYsg1BcVXhYyR
	 icIwVgxdRwrHA+Yyb1nm1qDdci0FizYivbtjmwFI+YlbzghX5cCisTXzsv4AK64T//
	 dtG8CnXpjCpmK0oS97nR0ERqS6rsXMIw+sGpNwNa09fvszOKYDLm+bMcVSGWgeTpux
	 UMeyzeOCGysbjhNAePFy52WRc6YhTkYpZ11gpgKTExJgEqIj20KnWGnKM0ng8G4Gvp
	 ApHbeVsXplqDOE3hEuq2f8lZHAWqiYx2/UVQCEyI/5eYOtrwJ/cJZ2+Ktz5rQbN1XS
	 vas0N2Iz6tVCQ==
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
Subject: [PATCH v5 net-next 0/3] add multi-buff support for xdp running in generic mode
Date: Thu, 14 Dec 2023 15:29:39 +0100
Message-ID: <cover.1702563810.git.lorenzo@kernel.org>
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

Lorenzo Bianconi (3):
  net: introduce page_pool pointer in softnet_data percpu struct
  xdp: rely on skb pointer reference in do_xdp_generic and
    netif_receive_generic_xdp
  xdp: add multi-buff support for xdp running in generic mode

 drivers/net/tun.c               |   4 +-
 include/linux/netdevice.h       |   3 +-
 include/net/page_pool/helpers.h |   5 +
 include/net/page_pool/types.h   |   1 +
 net/core/dev.c                  | 208 +++++++++++++++++++++++++++-----
 net/core/page_pool.c            |   5 +
 net/core/skbuff.c               |   5 +-
 7 files changed, 199 insertions(+), 32 deletions(-)

-- 
2.43.0


