Return-Path: <bpf+bounces-77369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C98F6CD9D5A
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 16:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 741B930AA6DF
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 15:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E24D34D3A7;
	Tue, 23 Dec 2025 15:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mns/JyQL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C6234CFB0
	for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 15:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766503637; cv=none; b=UYwjsF8W2Jo9WuIWA/mPSg4cBoUDbjdf5SUg7jw/vXsah6DDHUBHh5n4rs8RJ2DrLCL05B6sJJuFMHHNYkZhGKLwAz/AzsWR2ziF5LA13RQ7LhI5NFh9MLaXjYXke5MQUOwqTsAJjoaCGFA6eaMgA5zkR0AaaCDW2JGVlD47pKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766503637; c=relaxed/simple;
	bh=L0CtNZGdC7XEOtswvmiReCjZIo8GsOvQxUlegVLHBuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icTWKJYY1JzwQmhWPjugkQVNOWMUGl6ybsKul65R4u1VKvPG3MpCGSH5paqUTy+9UG1eDpr1GTm9iDD5oCHGhgKmm7QI0xDGy6DQSCMo91FdITNyTXsWmywtXfZr36a0PtUbT1azHM8Ohle6/dYJ+hqKPnjH7KyBcTLbeOXc5Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mns/JyQL; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34c9edf63a7so5411295a91.1
        for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 07:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766503633; x=1767108433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+6D6PVRsFTnS4j3cktmLgH5az1adeAVQEKO6DToWSU=;
        b=Mns/JyQL3ZbTTxK31p0r18sp6DJ+Q+s97WF+rN1ST5Srksx87q+D55AAgtZy/O95iD
         nrLQPNeQ2HmIOwhbDJwcOx4d6jLHq2P42xCyqUwhZNTq9JiSV0Eu5Z8+hlkofdaAnPRD
         OzUyzgfIGEesEvqxIx3DYugm0STsrVfhPlS6Bg6BRK/rG6wF1jNKm7dnHz8AHZT/yiUD
         k1O6Bmdoh0uzin2fTFz+Y4h54Po88jj+PtrAneQO1opqjeMeBOyfo8gAhKTsFobreYHE
         XveNQv7bNKYtVd30uMyvWseOJq8wntTMIDVeGWoFcttADWyARXqaLe5Cj5UWCZGZl//L
         9oAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766503633; x=1767108433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C+6D6PVRsFTnS4j3cktmLgH5az1adeAVQEKO6DToWSU=;
        b=vZhvdcpuPpK9TM+NP7UkEp9Mj1q7ZvO00EnDs8hOoLSdwLwWfKPvLwb0230qbHiqMx
         NpQdpG53XEGoSdn6PGtjthVLbhj6gZgXoPzfC41XSFqF0sV2FXBLNkEvU6S8cmCVhAab
         IuXLVi9AsHrJEAwZpDgjkFEBoVBi0fNOb2rpJSrSnsmhKJ9kg8Bf62NYNSTWkhLTFxlx
         gi1AXUuOM27T84kjET0UrkdpTVoZMiWaSAK3L2LrTwIqtaXCkSk2H0XuJnu4O9l4QpmI
         hnqnvpX/97wsTmZ/URtdHXxxKX+95+VjJsenyEdfj4j/oEiOVfIjH3XqGe6Ty1IbjObr
         gp2g==
X-Forwarded-Encrypted: i=1; AJvYcCXCdMY8O+jR0o3TlYzZkpRCdUBwUFRxmhyernhtVnREnuWsYwtHsoH15ottc6evjbpW30c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzshH3i/BHdYQTgsoCeHto1K6/+9f3IxZlAnmmgNvmbz+Li5k9S
	uxw6CGdXWgIXs/VwAix7ygEkgunu8CZ7nFaWgYmF8Mh8qHbuwgnyB0tF
X-Gm-Gg: AY/fxX7vEkESl3StL5MWzrNR77iCexnaE+q/S0sFdG9Jz4yRC6SWnrfayqZXtY4A14a
	NKc2AIgVYTV6Zd9ZteyliR+eZaqEqxltNv8tpbezF0M5c4a90BWERwO2uodKNfVkg6jGIPOOzrZ
	Sx14DNLBa/+0zQ37374EWPEOxsXSkcF03NMVA7qWgVgVkZ4oHwF4A17JjPhumqOnUSXFSqlKh1F
	yfYHgCIMYsrojUxj7Sj9P0Kr4dlFae/bqh0N9rQISgqrkgaEi9ty0+eDqXtxAN04K+FyxRQw4qs
	OE1r2+XiTKA0G388a7VT/0dcQhtBYAGsZmyn5PpOTMSHbLtGNfS4TOEHuosRUWvoVXGp/lHXOwk
	bmMDjVksOcIyb+OThj6kqJckHFN+ZDyryQARF+bVTXi0WkZlAyORCrJXyYGoLcOdy+E8cIHzsrk
	Izsv2bmO0LzEAC7rPpurRmjlnnD18IunXQqBk=
X-Google-Smtp-Source: AGHT+IHPZySRpyLioNlkGmfBeBlfCuPepN+ltwQg7UoU9dgxoY0VAt295aBDiCrvyeMv0Apodcz+Pg==
X-Received: by 2002:a17:90b:3c4d:b0:32e:7270:9499 with SMTP id 98e67ed59e1d1-34e91f6f93amr11885237a91.0.1766503632955;
        Tue, 23 Dec 2025 07:27:12 -0800 (PST)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:3523:f373:4d1d:e7f0])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-34e76ae7618sm8006138a91.1.2025.12.23.07.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 07:27:12 -0800 (PST)
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
Subject: [PATCH net 2/3] virtio-net: ensure rx NAPI is enabled before enabling refill work
Date: Tue, 23 Dec 2025 22:25:32 +0700
Message-ID: <20251223152533.24364-3-minhquangbui99@gmail.com>
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

Calling napi_disable() on an already disabled napi can cause the
deadlock. Because the delayed refill work will call napi_disable(), we
must ensure that refill work is only enabled and scheduled after we have
enabled the rx queue's NAPI.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 63126e490bda..8016d2b378cf 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3208,16 +3208,31 @@ static int virtnet_open(struct net_device *dev)
 	int i, err;
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
+		bool schedule_refill = false;
+
+		/* - We must call try_fill_recv before enabling napi of the same
+		 * receive queue so that it doesn't race with the call in
+		 * virtnet_receive.
+		 * - We must enable and schedule delayed refill work only when
+		 * we have enabled all the receive queue's napi. Otherwise, in
+		 * refill_work, we have a deadlock when calling napi_disable on
+		 * an already disabled napi.
+		 */
 		if (i < vi->curr_queue_pairs) {
-			enable_delayed_refill(&vi->rq[i]);
 			/* Make sure we have some buffers: if oom use wq. */
 			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
-				schedule_delayed_work(&vi->rq[i].refill, 0);
+				schedule_refill = true;
 		}
 
 		err = virtnet_enable_queue_pair(vi, i);
 		if (err < 0)
 			goto err_enable_qp;
+
+		if (i < vi->curr_queue_pairs) {
+			enable_delayed_refill(&vi->rq[i]);
+			if (schedule_refill)
+				schedule_delayed_work(&vi->rq[i].refill, 0);
+		}
 	}
 
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
@@ -3456,11 +3471,16 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
 	bool running = netif_running(vi->dev);
 	bool schedule_refill = false;
 
+	/* See the comment in virtnet_open for the ordering rule
+	 * of try_fill_recv, receive queue napi_enable and delayed
+	 * refill enable/schedule.
+	 */
 	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
 		schedule_refill = true;
 	if (running)
 		virtnet_napi_enable(rq);
 
+	enable_delayed_refill(rq);
 	if (schedule_refill)
 		schedule_delayed_work(&rq->refill, 0);
 }
@@ -3470,18 +3490,15 @@ static void virtnet_rx_resume_all(struct virtnet_info *vi)
 	int i;
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
-		if (i < vi->curr_queue_pairs) {
-			enable_delayed_refill(&vi->rq[i]);
+		if (i < vi->curr_queue_pairs)
 			__virtnet_rx_resume(vi, &vi->rq[i], true);
-		} else {
+		else
 			__virtnet_rx_resume(vi, &vi->rq[i], false);
-		}
 	}
 }
 
 static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
 {
-	enable_delayed_refill(rq);
 	__virtnet_rx_resume(vi, rq, true);
 }
 
-- 
2.43.0


