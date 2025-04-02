Return-Path: <bpf+bounces-55125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E6EA787A2
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 07:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E49E1892EB4
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 05:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AB2230D0E;
	Wed,  2 Apr 2025 05:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5TNYqzv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7302E3360;
	Wed,  2 Apr 2025 05:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743572619; cv=none; b=tHKTWN9TebDnn3fkcLldIld0+bw3vhHtOn3OqjdnGe1mCMt/tfjKxLIMI/O/dPKReamlKoJl56aqH9lzqZCHZzTVcPeRijmzWliNUKukMf+9N/xrLTfwEpITCamqDoTfbLJaqE8oZ8yfF8QOMi5HVarXaFMnia2o0Z/5YvgnehA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743572619; c=relaxed/simple;
	bh=4YodOXIyddgrUGXCDpWh7pKVlP0DqqsIUu4EW1rqHZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Njtdr4wO6l2X5cIMrR1kBjL544GlH2VfxUQQBjiuui88RaJmnrlPAVAsc0sn0SL6AtAOAdX64dYUPfKBHcljXC28cinuPT70ER05z01ELncn2LHB5fqkbKvWmZCaMygnjwaWh6DAnCHxeELLutcBFrpqAkbKFTJEfsgRdD+y/5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5TNYqzv; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-301e05b90caso10842925a91.2;
        Tue, 01 Apr 2025 22:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743572617; x=1744177417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7oMFt6rTiybYoRdpooKvYV5UYutJybr7cfusGu3htIA=;
        b=m5TNYqzv15bXRjG04zu1R2qoTvZYtpwYNcXckGw0dyM/Z4WngShcMCJQqAE9kdvh/G
         7+4N9p1JMXKm70KdpvUuhu6WE8+qReIGsRS3RaPO1JF6cgCF/lG6uqo4Q3VfzFCglVIH
         uWKdP69QgSrh6SK8N+8HGB+oeONjfWCAxdG1+EBho7LhJzK6UpX1mO7lGqkvvBnLkqmp
         DwzJ8srdFT54P+y/IaXBXKDi5qDjYv+vPAJ0Um1vV2kKVG+rPMvO1e8HNukKEqXVj2JY
         pbkn4fZT7rTAcL2AZESx/gNMtBfyU0U7Cvev+AJGbueHsasaRRKnnJAkZCMYXwUXndI2
         cdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743572617; x=1744177417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7oMFt6rTiybYoRdpooKvYV5UYutJybr7cfusGu3htIA=;
        b=GBn0RZbtb9YoXmPOfJfGGQqX7YsXb2ERUYgJo7DhB8RLEM7p1Bzz/KUiOrWSPxaIc4
         3lFRHbotz6wSByjhlsTEg3X/8wejEElSygyQAfNsUEs/7KFJrZzXe8REujHEq4+Pex5R
         5ix7qDnQCboX0+DAwxHIqzMvGthLoGTqAWT6FKqIpUM0f8yTQZGoEZXgrbUw1G7U8TPT
         PKf0a3DmyCM2OAgXSurJZ+zn27tYlW6e7n8B34DtOdeSGcXWiy/C2W23NhYSXsgebIl2
         t5UQgbntFJqmLe1pAduW23DZB5R2XNe1ZYLSf2knGSGFUMIVyxR7iK6Tbz/5tkcztpUA
         mfww==
X-Forwarded-Encrypted: i=1; AJvYcCUcTEdXZJs7aRvfDEceIazcDU5duSe1oWZH0OZc4HdyrmSSaumNGWh8LrWLMX/9DHuRIsCLswme@vger.kernel.org, AJvYcCVSJDyxtnKLIQZww9YB+zsPoKs1bzibfsIiXXGMIk2iBBOMHaay/+nVhiHIgKAH1IBGHpHYIT9TinoUANT3@vger.kernel.org, AJvYcCWKRtrDEE6A2RUJPM+OB3llapuFT2GfKLb6K8ZoFbId+ZO3gTuQ0YGGH4pqmp12VNLZ8w4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSTt+jrj5K0hUAZWI5bcxGrbT1iUvMRffJSSO1uXzBGKdG4fPz
	9QpxyXHJrOm4Hqu165gOy4Rse/KJQ21iIq6aPF3Hf2cIPU07tu/a
X-Gm-Gg: ASbGncul4SMwqY2BSF+CBfJp491qzk9J24GAeWyb2BiW8hKuGIDALhGkEngne8ErqNp
	ov064JbMbA7J7i5Oe4i2kJqP/2yr0tnBCPSNxCNs2h6BHL0PV/OfXOlnSWcTolGs5d/zEHbd7BN
	hEBLSUFsOZ4+Lh/7DKhssTe/SW9MW9h7YQaVEs1hObiugXWCuqu5+nAnQCUcZrHJljeEMkphlrQ
	hic2PZS0EZFqAtcZHg++YOlqg4jzy3dchqcgX2bvtcAwHJf82XeaW8qDWFr62hIthQ6SXTcuGXO
	oRovcVCsUTpH0LREctnINn3/nUwpc/XoDJ+s+5zxh31ReYa7ONJlBKTsVZ4Z
X-Google-Smtp-Source: AGHT+IEic+6AY+ZdBrLSKJCMvjDVGOhMYUP1QxYWYvLdMiiVD00LmEfJ4lEnY8i5M2nghj2SBWMTbA==
X-Received: by 2002:a17:90b:5210:b0:2ee:9d49:3ae6 with SMTP id 98e67ed59e1d1-30531f93127mr25734500a91.10.1743572616792;
        Tue, 01 Apr 2025 22:43:36 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f4e:bd30:194b:b252:cf33:1fe5])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3056f83c93asm720529a91.14.2025.04.01.22.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 22:43:36 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: virtualization@lists.linux.dev
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH] virtio-net: disable delayed refill when setting up xdp
Date: Wed,  2 Apr 2025 12:42:10 +0700
Message-ID: <20250402054210.67623-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When setting up XDP for a running interface, we call napi_disable() on
the receive queue's napi. In delayed refill_work, it also calls
napi_disable() on the receive queue's napi. This can leads to deadlock
when napi_disable() is called on an already disabled napi. This commit
fixes this by disabling future and cancelling all inflight delayed
refill works before calling napi_disabled() in virtnet_xdp_set.

Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7e4617216a4b..33406d59efe2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5956,6 +5956,15 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	if (!prog && !old_prog)
 		return 0;
 
+	/*
+	 * Make sure refill_work does not run concurrently to
+	 * avoid napi_disable race which leads to deadlock.
+	 */
+	if (netif_running(dev)) {
+		disable_delayed_refill(vi);
+		cancel_delayed_work_sync(&vi->refill);
+	}
+
 	if (prog)
 		bpf_prog_add(prog, vi->max_queue_pairs - 1);
 
@@ -6004,6 +6013,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 			virtnet_napi_tx_enable(&vi->sq[i]);
 		}
 	}
+	if (netif_running(dev))
+		enable_delayed_refill(vi);
 
 	return 0;
 
@@ -6019,6 +6030,7 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 			virtnet_napi_enable(&vi->rq[i]);
 			virtnet_napi_tx_enable(&vi->sq[i]);
 		}
+		enable_delayed_refill(vi);
 	}
 	if (prog)
 		bpf_prog_sub(prog, vi->max_queue_pairs - 1);
-- 
2.43.0


