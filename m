Return-Path: <bpf+bounces-71573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E17BF6B4A
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 15:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 470334254B9
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 13:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BC0337BA7;
	Tue, 21 Oct 2025 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gi1JkRra"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2F3334C19
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052380; cv=none; b=OMwhI6nuZLKX89q04YUkDK3yVJFbzSvas70kXQLq8f8SLV1ZsTe+V2GqzEu8/oFfZoyMPuUhJ+WdHj5hMsFaMK8pziDzd1ADWUVp5oJcWvHb3CNmGxX33hpcfcc+XWKk2OkkkQd10mbCUTqSItUIT05FyFH42yn0l6ayLdNSf/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052380; c=relaxed/simple;
	bh=3vA2quocWxoPw35Q0g5YPXiKaeWvWJs/40Scose6BW0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PzMUyNAqboRqdo+FwbYSrw4YLBMpyZSVy9/8QxpNBvgE7t5jyOcDgn9WvLPJw2DyJQmKjj5fA3xpAEu7GYS5/k/+5TxTZ6tleKsKdo+thawWUfqARA3S3KNI36h5TupdLLSi+h1slCpf7a4Xy4DAQdkYkDmzhWdDQt4wGhFULag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gi1JkRra; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b633b54d05dso3833921a12.2
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 06:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761052378; x=1761657178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0J9AlILf7V4D1Au1RXOMSOZ2C2qDTTD0ax0CV2Rs+R8=;
        b=Gi1JkRra8pX14OjAHVSKor8cxThHXe97BfJAHQonQ/QIAxRXZ6aMEHv6/Qxzppf6Jk
         J1789cUusuDkIeJIoSVadUEZN8eg+PX/bw2JbybtGVlHE5JcRbZhq9UL4pEb3fuVzwrx
         u7WPKeJySfCTfenTiZjT9+SlDPXYdbQwZRPZIOP1sHqZ0bNFK6hXJK8ZgSHS712rXgRg
         3DbFxhzy/zLfob1kRZIvzhWeaPG8wzDvpoKxnBYSxJharvjWeOD4y4dy80RtMk80SBxK
         66gI7u4RnHEhjU4j4iyJG9r3hCOIEv3mSWMoXKOBCh80ds49b2l4bBMXeC9r+nj26Ib+
         wuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761052378; x=1761657178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0J9AlILf7V4D1Au1RXOMSOZ2C2qDTTD0ax0CV2Rs+R8=;
        b=clxp+/YPWnunqPimYhGDZ0xw/67zN+e218x+LacaxkgxA7c1INDA/09RBuMT9/nqix
         IDo7fTnFViixXpujyZ8zph73wcBDz4VK2qPwuU0CmtVC8s0yP4M48wrs6GatGitjQjzX
         lMN3cihb4XmDdraY58iK/GPzxolyhMzlcgAOrz2Id/PHa59kt6AGYzGHHFKsGeSP9H+E
         Z7WTs88GmrznQ6Lzs3hRVENltF/Ff3pssRe/LF23abf5fkRlS0RSTH8fapuArD3TyDho
         X+ca3z7eViLkKCYpeZTryRu4zUeNI05/ooKsUVIveR95LWKaNGQeS+OT8WmX4vxI8GMg
         CEoQ==
X-Gm-Message-State: AOJu0YzPYsSRXhGHzb8IEXNG3UdAa1FEUn0FHlr4AY69/w0HixO9oVEA
	L0STmO4/77Or1WKXQAECs2K8wLcu9M487sLql6z2mvroXHKmvNmMrdYL
X-Gm-Gg: ASbGncv8d4c/94j/Vlnz8FHOAlhXqKL5SFe/DNiKpzumarQA1JbWNMW1gJAV+p2lC38
	fJSAU/4CpbBITgm7/08cv68wKwrFFAo8dNH+eqGS0NYitpTbHANj4FWVOEE0HLyzl0o7o6n8VWz
	7oMUy2+pzQqQa2cxBfLVuncgjRokQ+9+YkN5+kddg9ZAfhqeRzVEI7wukV2dzzF4piAzWtz9z52
	J/e+fvZnoHcrsaFhzE5hQ0z3ioXpKsvFkVoEivBZPydPStgCawZt7ylYezywzm5K7RbcQghWPft
	GVvqsmq05G/QXh9K58kBvzc+rsPRV9iRZVftBgDOe7TP7M7EllUJ8BFUEEvKEMHjfO33oeKmVHA
	w8o19GvlxnwrCaZkn2EGLOT4/kyIyqHPO3p3gsCXtj2c8PEr5LKQoUcf46tpM6Nzq5Dune87I3y
	1bH4M0TgFiszCvsmHqtAx5IFWJ355nC8VUNfgRKS1w8uQ6emg+kRj10aeJQQ==
X-Google-Smtp-Source: AGHT+IE4lT5b8cTiZmWZmJX7MrCpLpLchp206t/ZR544MdNKlLrKXcMiO0LVoYY2V7Qz1tJK/WSQPA==
X-Received: by 2002:a17:902:f548:b0:25f:fe5f:c927 with SMTP id d9443c01a7336-290ca1214e1mr240139555ad.31.1761052377763;
        Tue, 21 Oct 2025 06:12:57 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fd9ddsm109248175ad.89.2025.10.21.06.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:12:57 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	joe@dama.to,
	willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 9/9] xsk: support dynamic xmit.more control for batch xmit
Date: Tue, 21 Oct 2025 21:12:09 +0800
Message-Id: <20251021131209.41491-10-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251021131209.41491-1-kerneljasonxing@gmail.com>
References: <20251021131209.41491-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Only set xmit.more false for the last skb.

In theory, only making xmit.more false for the last packets to be
sent in each round can bring much benefit like avoid triggering too
many irqs.

Compared to the numbers for batch mode, a huge improvement (26%) can
be seen on i40e/ixgbe driver since the cost of triggering irqs is
expensive.

Suggested-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/core/dev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 32de76c79d29..549a95b9d96f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4797,14 +4797,18 @@ int xsk_direct_xmit_batch(struct xdp_sock *xs, struct net_device *dev)
 {
 	u16 queue_id = xs->queue_id;
 	struct netdev_queue *txq = netdev_get_tx_queue(dev, queue_id);
+	struct sk_buff_head *send_queue = &xs->batch.send_queue;
 	int ret = NETDEV_TX_BUSY;
 	struct sk_buff *skb;
+	bool more = true;
 
 	local_bh_disable();
 	HARD_TX_LOCK(dev, txq, smp_processor_id());
-	while ((skb = __skb_dequeue(&xs->batch.send_queue)) != NULL) {
+	while ((skb = __skb_dequeue(send_queue)) != NULL) {
+		if (!skb_peek(send_queue))
+			more = false;
 		skb_set_queue_mapping(skb, queue_id);
-		ret = netdev_start_xmit(skb, dev, txq, false);
+		ret = netdev_start_xmit(skb, dev, txq, more);
 		if (ret != NETDEV_TX_OK)
 			break;
 	}
-- 
2.41.3


