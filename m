Return-Path: <bpf+bounces-21220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A11849A83
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 13:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FCA31F21456
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 12:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE37628E02;
	Mon,  5 Feb 2024 12:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIkKmnWf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9803C1C6A7;
	Mon,  5 Feb 2024 12:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136593; cv=none; b=RB06AvoNgqNb97GeUdCjLmKOlYflD58sgq6IMMDhjfhxQpkXZHbaPx8hiIgtXJdD9uzLrl/pvbm+taE6OX7K3bBK3VQ1Dt5ThjMZPFEDTZ55TBDC0+3Q7RUlJHn5+lS6tuGwyDlHAxXQzcZJt23L6kH0mSVYeBhqE1Hp06DnShY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136593; c=relaxed/simple;
	bh=AazNUqzT6o+/qBL5xpvDtTZHmqQ3JBMwZNJTtr4obZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ksP6Gwvs2o62cldAR2Sh8dIl+jV6tVaKRhUhMMDca7hHzi6PaXMteTN9ArRO+NMAAOmKt0vOXM8/F9+Rq3f/tpS/n1Jbtxbf6zTxZpj2v/YChAOWYACh+WDGXgSea29JPTM31LHaRCRXO9kVlWoLlHIR0Wje8C7Ywc+ktr/yABc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIkKmnWf; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40fb7427044so11091545e9.0;
        Mon, 05 Feb 2024 04:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707136589; x=1707741389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOQsx802m7WG9WxgkXGo86o5TdAUAPdan222TW5HsdE=;
        b=iIkKmnWfRTZ6/L8iUQDQKE0rM1+dRzwzqYmM9KhISFKyDm3X7ay7zUG9/v0CVKm4Zv
         8baeex3xqX2XWOj5xM5IzVjdp+AioPS1u3jaToNK+JZfUW0PoxZ1g/r0QwTdXuJM7+NG
         9uCddpgxII2k+Ovzc/fsKRGINzIRpuzonKZDUaFTA7jcPnWwoY14N08Mvs44F61yuwtd
         9xyA8QOHpmdFjOgLnV94lv++0+oEdwqe6CGQQXzUfoIVxQ5QOV+Bbxm9Tsp9THr2WyfF
         DsqepSLlbBtNG4hOLaNe1VtfC7km9HzMmCwcvnJbnGyWBIJsfcFaadsbQDiU8Ss0RXLe
         8xqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707136589; x=1707741389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOQsx802m7WG9WxgkXGo86o5TdAUAPdan222TW5HsdE=;
        b=caxazYlYBfC50o3RfPo76wbRNWvFU2O8uUZAU89IxoY57AWp+reP0nffvRz8dNxWCz
         shaq2LkFv6ly10QOsiTmp83+cCy3qEgMPd6/vFesBhJAaLz1Zmp/BEYH/6e3BSaYa2Sf
         ikraZtXlV4EGwW1e+io8BTXYlXhaL6F3QSBmoTvAKloEDHyhYs9oKkgDrJja2m1LZEha
         Wr31365mI6yseBvdRxq5Va+sIu8czBGMAcgIZmKauUCyoLcPdiQvMnXXZ+MSsQ3Gg+TY
         XV1zBdJIRi3P27JhfMPkiRWlDR+PJRsTV9RaFgR+sv8u+3vgahLKuqmRfROxZBVq8WgQ
         hfUw==
X-Forwarded-Encrypted: i=0; AJvYcCXDYtkzf77qUrliILsEcXku2feD8Vk+xXU+dcq6oJuNWbMTR6X87rNLzu2ZIT2pk+RFSLyODSYDN7kZIpY4nsZraNs/yUP+
X-Gm-Message-State: AOJu0Yy2NRY+jzNppWZzpBXa6ddHGpUmBivkFUzloAMq/o3oMe6M26EP
	Vju1xSX292bWvh7xQZL+E3T5qrwqAvAK1ZLySgXzQ9zDiAf19DU/
X-Google-Smtp-Source: AGHT+IEV2K2VHJkJQmGagBtzZH3XyST7PZZC0ByJ7gNCZk+nT3qda0Ku/bqCWXypF6nZVLnaJcAxww==
X-Received: by 2002:adf:e6c5:0:b0:33b:27e8:3f1f with SMTP id y5-20020adfe6c5000000b0033b27e83f1fmr5471923wrm.4.1707136589185;
        Mon, 05 Feb 2024 04:36:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVydRb3HsL8B/kPC9Rkdr2TnuabfCL2JA8Fq/zDm3BQ3ShYXbF8FV/t4hPZ7w3UI/ymdn5+BhIpe8Ao7AjT9IsJZvfuu/OaCGud+8eiWT0hi/Q+HQuChILGaRy+bPQ4klQeuvWWqT/aAy59E6iPpAxtEeaYaZgaKL5ECyVp7ZC9sHQO16sYAlR98+/+9iw2halOSGKRCMqgzuxK+zncBtIZWkjBuizSr/1beIVrys8X+Q==
Received: from localhost.localdomain (c188-149-162-200.bredband.tele2.se. [188.149.162.200])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d400a000000b0033b17880eacsm7892894wrp.56.2024.02.05.04.36.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2024 04:36:28 -0800 (PST)
From: Magnus Karlsson <magnus.karlsson@gmail.com>
To: magnus.karlsson@intel.com,
	bjorn@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	maciej.fijalkowski@intel.com,
	yuvale@radware.com
Cc: bpf@vger.kernel.org
Subject: [PATCH bpf-next 1/2] xsk: support redirect to any socket bound to the same umem
Date: Mon,  5 Feb 2024 13:35:50 +0100
Message-ID: <20240205123553.22180-2-magnus.karlsson@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240205123553.22180-1-magnus.karlsson@gmail.com>
References: <20240205123553.22180-1-magnus.karlsson@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Magnus Karlsson <magnus.karlsson@intel.com>

Add support for directing a packet to any socket bound to the same
umem. This makes it possible to use the XDP program to select what
socket the packet should be received on. The user can populate the
XSKMAP with various sockets and as long as they share the same umem,
the XDP program can pick any one of them.

Suggested-by: Yuval El-Hanany <yuvale@radware.com>
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 net/xdp/xsk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 1eadfac03cc4..a339e9a1b557 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -313,10 +313,13 @@ static bool xsk_is_bound(struct xdp_sock *xs)
 
 static int xsk_rcv_check(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 {
+	struct net_device *dev = xdp->rxq->dev;
+	u32 qid = xdp->rxq->queue_index;
+
 	if (!xsk_is_bound(xs))
 		return -ENXIO;
 
-	if (xs->dev != xdp->rxq->dev || xs->queue_id != xdp->rxq->queue_index)
+	if (!dev->_rx[qid].pool || xs->umem != dev->_rx[qid].pool->umem)
 		return -EINVAL;
 
 	if (len > xsk_pool_get_rx_frame_size(xs->pool) && !xs->sg) {
-- 
2.42.0


