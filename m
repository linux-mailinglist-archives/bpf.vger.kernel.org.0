Return-Path: <bpf+bounces-77370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B00B4CD9CAF
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 16:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBDC33029F52
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 15:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC5134D4EA;
	Tue, 23 Dec 2025 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEEOpmP1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206B934D3BE
	for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766503640; cv=none; b=sHJRurTlLsE+JHMrIP/eECEp2VBZ1C4FPEtpVnGiLl0PS3asYc9QtgVmE8q2Vxzq+PMfRoYKOcMHkE0pciA88K/fMGokIwD2U2TCJPRefTiy6EXGIgxT230IpVH1tA22J1GLFGuZnYKx2o0BBF22DdfcmD4wPuUa6Gxodaoowqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766503640; c=relaxed/simple;
	bh=dqAVCd406spP927ct6RgvB4a8I1dOdU+v808mOA7XuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLO4dd/MTPMoLiI6HqJw3D82tyBWUICIRRqv0eb7EccfivGdhVSN2clG4sfURpFk8tdrRU9BRV3c5qrstX49ECNzv+p9ABH/87aCr4nPhFIUFSw8/6zipdUNHMu2NBvnL7B6lkVB5ayv8/bNYsTGcZTKRK651RZe4/ri74PJfDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEEOpmP1; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c718c5481so4920145a91.3
        for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 07:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766503638; x=1767108438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ze9XAlqzMbfmN07PhRbHKjr9BLXv6+joNuOst0RuStI=;
        b=dEEOpmP1FdgkOa3ktWP8RLJupssR+p8a0ID+w0AEfkGuW8t9R5zULSqd5pllEznehv
         eGj7xgm98JtQGTmKza/LZkAFZPDb+24cAJy1ubomu5FCY4xz113NQe/PVfsQBWWUJEFJ
         Rlr/PuHgHsP2/aAdgYQsr1/9OxCdN2OCEgp8hehA28jtPza3s5gDuJ8dnPJFjbqXsB9D
         PVyC2ufQqtWqe86Om883mdJIaHvf0dgwTTOg1dJssCdLoUiu5r2meFWox6zaG1PvIkLD
         iuEJms2dHp9YZPCO1ib/Ujhcgt9MXadBCN8TWkbdupyJ2BlEBQe/L0Urx31DCC7TUxPa
         DupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766503638; x=1767108438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ze9XAlqzMbfmN07PhRbHKjr9BLXv6+joNuOst0RuStI=;
        b=B9Oy8H8GtrnU361as6OeC+u87jxPGxMuziP0/oXBQ+m9EFqkJL9FOI1IN2XrQGL1dk
         AV18KT5d2mPdn9uBFoc9TvJSV4BE19u0S3+6tMtmiAlDaOVPkWgM7wYfDDYV1RXsnBFS
         73DMcQdEdOn0irhGEBMXdAqpRH7DT4Wzu056QGRfQJJQvxTuRVBZGONd98sWKJV60BMj
         RLdXKaub0dfTuAGmsrjjSVchdEksDb9AH5fbUfT1oTIGH5mdvixltTnmwsfiRZc8Tg2p
         BsL1N5bNnczl8X49Hw9GWSMyaRje3ph53cp9ZkMB7gb3tZgavQFlXW6ovHIigJ8CMhCJ
         3a1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7qlhx2hZTG6uJLGD+EVSHtIpAXBay8W1NXPyMHdPIiHZ8WwYRQow1g+y3F18bhYezRi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP2fJPX0Yc6x0REXF02KYSS18ogrg30Dq6SSy8kPf3PUL7OI1s
	LKB27Z5IDz87QQoWyJ/TmFTjUpvprVPSC51twcJe4/nMbKd5qXrlGWU1
X-Gm-Gg: AY/fxX4qwqoq9neTSycNJAVX7iOlK+ZFe+lXCA2RVPw6mi06QsuruqkNvndRX8Q9YfS
	DLVXVCKwKT7h/hN+ijknEaFledhaxhtuS1w7yaqFyphxQffA/cAQC/iqD5tGvKsxD//K+vUYG8O
	yaIFtVDB7Fm+lAuJCs+JEMNAj8pUOPj4ZNoBIGV+y+soqrd7yD2Yf3VypYtsaaA6V1cyMVmEFY6
	JLcWUu1H6y6McZbislDDEhE3D0hhACsb4DuNMXR36xWiAl4pVp46isPqmpDWicoa3LA+l4+2BEZ
	zWUjrbt2ZvD70VBuci6XJjL7Y2D87JwYqlapAToYRpu4UVlor3xJBwtoBZPNlL7rdzPInOKQSRD
	QPhVd8VHEmHEJQvyUi9PW/oEGn4oMHIQJadi40z5Jjs/FIqmrd54eyhFGECmA0HISNNZmL7ybFh
	yIbSO3oS3CCdw8oQkBEbf4Jdrl
X-Google-Smtp-Source: AGHT+IEk5kNaKT2vsTzXqOJuqMCa8BgC7mYYuynqk5le798li0SZVD/6VGOpORiTUPiHf0D9J/Vgsw==
X-Received: by 2002:a17:90b:3ccf:b0:349:162d:ae1e with SMTP id 98e67ed59e1d1-34e921f7eb0mr11071309a91.33.1766503638325;
        Tue, 23 Dec 2025 07:27:18 -0800 (PST)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:3523:f373:4d1d:e7f0])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-34e76ae7618sm8006138a91.1.2025.12.23.07.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 07:27:17 -0800 (PST)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net 3/3] virtio-net: schedule the pending refill work after being enabled
Date: Tue, 23 Dec 2025 22:25:33 +0700
Message-ID: <20251223152533.24364-4-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223152533.24364-1-minhquangbui99@gmail.com>
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As we need to move the enable_delayed_refill after napi_enable, it's
possible that a refill work needs to be scheduled in virtnet_receive but
it cannot. This can make the receive side stuck because if we don't have
any receive buffers, there will be nothing trigger the refill logic. So
in case it happens, in virtnet_receive, set the rx queue's
refill_pending, then when the refill work is enabled again, a refill
work will be scheduled.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8016d2b378cf..ddc62dab2f9a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -383,6 +383,9 @@ struct receive_queue {
 	/* Is delayed refill enabled? */
 	bool refill_enabled;
 
+	/* A refill work needs to be scheduled when delayed refill is enabled */
+	bool refill_pending;
+
 	/* The lock to synchronize the access to refill_enabled */
 	spinlock_t refill_lock;
 
@@ -720,10 +723,13 @@ static void virtnet_rq_free_buf(struct virtnet_info *vi,
 		put_page(virt_to_head_page(buf));
 }
 
-static void enable_delayed_refill(struct receive_queue *rq)
+static void enable_delayed_refill(struct receive_queue *rq,
+				  bool schedule_refill)
 {
 	spin_lock_bh(&rq->refill_lock);
 	rq->refill_enabled = true;
+	if (rq->refill_pending || schedule_refill)
+		schedule_delayed_work(&rq->refill, 0);
 	spin_unlock_bh(&rq->refill_lock);
 }
 
@@ -3032,6 +3038,8 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 			spin_lock(&rq->refill_lock);
 			if (rq->refill_enabled)
 				schedule_delayed_work(&rq->refill, 0);
+			else
+				rq->refill_pending = true;
 			spin_unlock(&rq->refill_lock);
 		}
 	}
@@ -3228,11 +3236,8 @@ static int virtnet_open(struct net_device *dev)
 		if (err < 0)
 			goto err_enable_qp;
 
-		if (i < vi->curr_queue_pairs) {
-			enable_delayed_refill(&vi->rq[i]);
-			if (schedule_refill)
-				schedule_delayed_work(&vi->rq[i].refill, 0);
-		}
+		if (i < vi->curr_queue_pairs)
+			enable_delayed_refill(&vi->rq[i], schedule_refill);
 	}
 
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
@@ -3480,9 +3485,7 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
 	if (running)
 		virtnet_napi_enable(rq);
 
-	enable_delayed_refill(rq);
-	if (schedule_refill)
-		schedule_delayed_work(&rq->refill, 0);
+	enable_delayed_refill(rq, schedule_refill);
 }
 
 static void virtnet_rx_resume_all(struct virtnet_info *vi)
-- 
2.43.0


