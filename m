Return-Path: <bpf+bounces-16241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7CB7FEB8F
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 10:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DF7281FD1
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 09:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2496336AF0;
	Thu, 30 Nov 2023 09:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhPLe7+y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8819E2F86F;
	Thu, 30 Nov 2023 09:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F20BC433C8;
	Thu, 30 Nov 2023 09:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701335524;
	bh=Qg61lpLbgqDeoofePJmkszRcZdvneo2mvpoD+dzpgAA=;
	h=From:To:Cc:Subject:Date:From;
	b=WhPLe7+ynS3+Fu8ilfb3vYWnml4KeNblJTGW8uu6XV3dyI81omq2U7ZJc1rcZL9+9
	 MGF9e2F2XUz8QfdqSd4ZxZWBXhwkIRCra8EKoKP6Kf8sa4idLqYEqD7IJ3xqul2oXo
	 Efjp/fYZXiFOtm2bXh0YcEEWHPoYnS/kRP4pP7/CctOFerXXew+e/Jb/G7hCzWmEkV
	 iiXkQRqwHmDYVs1nFjZneulfKxrUDDNE/446Jt/J4JKrkk0teasWsaNZQ9WJM5HpxU
	 pRzuQsNXUhSnDXuNlQVqH91ZfNBFxqQ5H7r58EKahHGTJlWVQC6jNVfWPTiscyNdeR
	 /uOUyCrn0kdYQ==
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
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com
Subject: [PATCH v2 net-next 0/2] add multi-buff support for xdp running in generic mode
Date: Thu, 30 Nov 2023 10:11:47 +0100
Message-ID: <cover.1701334869.git.lorenzo@kernel.org>
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

Changes since v1:
- explictly keep the skb segmented in netif_skb_check_for_generic_xdp() and
  do not rely on pskb_expand_head()

Lorenzo Bianconi (2):
  xdp: rely on skb pointer reference in do_xdp_generic and
    netif_receive_generic_xdp
  xdp: add multi-buff support for xdp running in generic mode

 drivers/net/tun.c         |   4 +-
 include/linux/netdevice.h |   2 +-
 net/core/dev.c            | 158 ++++++++++++++++++++++++++++++--------
 3 files changed, 130 insertions(+), 34 deletions(-)

-- 
2.43.0


