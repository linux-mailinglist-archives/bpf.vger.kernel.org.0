Return-Path: <bpf+bounces-39750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45A6976E46
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 17:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 097D3B228CC
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 15:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF2B1B9850;
	Thu, 12 Sep 2024 15:56:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230E91898F8;
	Thu, 12 Sep 2024 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726156610; cv=none; b=VakQXOLjqfJoXsMiIrtb6iBXbiTi7DQvhK2lgld8/hGphpK8MVfxFRxATRtHgRD/s62TDovhTgvMbvVPSAg1sqsMN69cCc1xr/AWkop6MFReilxtpzLEM0xRkpxDjQu0YWYAoASItPgJPCvqXPhlcHJwIHHKVIiA1xCR85eq4BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726156610; c=relaxed/simple;
	bh=g49SySub1/dItFepy17pW9UeExN0v3axhuVwMBKg6Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IizGM+XdEIYBxgJLdM8mnkvJgGtg40pW6CrQ20OWUP4gtX5u5y9rxLNucFWjd3sWsN9FYRjBpNyffGbuAsa7ms4IlNBciDbNQyA92wa6t4ABAsol55jZFVQ57TcNIleDLVObNBI8rPxvZ74rFmlAXDxPiLGClwALlYXrgEJkSjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c3cdba33b0so1319713a12.1;
        Thu, 12 Sep 2024 08:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726156607; x=1726761407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yGaUXUnd+3YrSKr0uQW+5rH8w8R3hUvGqKU6U5pnEgc=;
        b=wSfTNMaxsNzsSqBav1cH6Z/wpxhPX8FHaqDum16PbRiWsjJWX4QvpJse6/Yk4ivklq
         KtsPtMHZNy3yElxLQ/PU6xUw//sGeU62JcZdR0WEEByZqqhxEpiDs5leUDCbTe6pgxsR
         NJFM201sNzMNMDtYe3PBbZfkfN2bGqn7O5NctUR7tdMRny2sQjAjs2BLbRPz4QU28asp
         Jt69l4wPY5rfUnU6DHOGYxkCN25CBQFqcFFAy6KxnNF6ZChLcn0F/KF3vErcSNNe6pgr
         SeB2xL4I1ZC5zaf8iYpHzqTFaXgPjAvTGTSKMznPZd1qHipfxz1/JoT7Y5dw3FvT43l3
         Yixw==
X-Forwarded-Encrypted: i=1; AJvYcCUGzeV1AjP1YrHeIagdkYStj36smkC6TyVALLscwvGhZ3SEEbsuKVEXzdTK3XkoZkFdfP0=@vger.kernel.org, AJvYcCVlCIn8hf7/wR2FhIoDbCYS9YAL0/2s22vZRewutrXqmoa2KIPBp8Csw33NJY/tbtMSd9mpy+ESFAfBRVEW@vger.kernel.org, AJvYcCWnMa7FxSkF4gyjEFpxwGkDjyeynpvBlarqqqXPnV1nbRaKPdAXecinFTsf9/HoD4A7apmb+kJq@vger.kernel.org
X-Gm-Message-State: AOJu0YydK3DRqA3IOhzV3FBrGZ798KoCHGL1jNhaMaZmmRY1+2s/0fYA
	6Fb3FBgZX30yDBMSJq+Hfj3OPFIrhF/N0qHIf/T1U2htUrMIAI0L
X-Google-Smtp-Source: AGHT+IFEVLSg4hnq7/mj2dYIi3u+/01S44Pby+SK9xvZ2fN4+LAa4p7Jwb3LPSybIGLkNSik8PPO2g==
X-Received: by 2002:a05:6402:3510:b0:57c:c166:ba6 with SMTP id 4fb4d7f45d1cf-5c413e2000fmr2150556a12.19.1726156606522;
        Thu, 12 Sep 2024 08:56:46 -0700 (PDT)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd8c4c6sm6668081a12.86.2024.09.12.08.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 08:56:45 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: vadim.fedorenko@linux.dev,
	andrii@kernel.org,
	netdev@vger.kernel.org (open list:BPF [NETKIT] (BPF-programmable network device)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] netkit: Assign missing bpf_net_context
Date: Thu, 12 Sep 2024 08:56:19 -0700
Message-ID: <20240912155620.1334587-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During the introduction of struct bpf_net_context handling for
XDP-redirect, the netkit driver has been missed, which also requires it
because NETKIT_REDIRECT invokes skb_do_redirect() which is accessing the
per-CPU variables. Otherwise we see the following crash:

	BUG: kernel NULL pointer dereference, address: 0000000000000038
	bpf_redirect()
	netkit_xmit()
	dev_hard_start_xmit()

Set the bpf_net_context before invoking netkit_xmit() program within the
netkit driver.

Fixes: 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.")
Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/net/netkit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 16789cd446e9..3f4187102e77 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -65,6 +65,7 @@ static struct netkit *netkit_priv(const struct net_device *dev)
 
 static netdev_tx_t netkit_xmit(struct sk_buff *skb, struct net_device *dev)
 {
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	struct netkit *nk = netkit_priv(dev);
 	enum netkit_action ret = READ_ONCE(nk->policy);
 	netdev_tx_t ret_dev = NET_XMIT_SUCCESS;
@@ -72,6 +73,7 @@ static netdev_tx_t netkit_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct net_device *peer;
 	int len = skb->len;
 
+	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 	rcu_read_lock();
 	peer = rcu_dereference(nk->peer);
 	if (unlikely(!peer || !(peer->flags & IFF_UP) ||
@@ -110,6 +112,7 @@ static netdev_tx_t netkit_xmit(struct sk_buff *skb, struct net_device *dev)
 		break;
 	}
 	rcu_read_unlock();
+	bpf_net_ctx_clear(bpf_net_ctx);
 	return ret_dev;
 }
 
-- 
2.43.5


