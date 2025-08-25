Return-Path: <bpf+bounces-66395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E26F8B34290
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 16:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDBC718846F6
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 14:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FE62FABE4;
	Mon, 25 Aug 2025 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJWqJ1JY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737002F6590;
	Mon, 25 Aug 2025 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130084; cv=none; b=RWBMQOZbOIpSFG8C7jihY5UAAfREFgZkq9oUpeMp0qzTtdcbhm+fSejQ1e9IoQPdlt5wmyInDeLJ45kztjHXP8JQ4sC1dcuPv0nhn5oEvIzjzhhBThVYbVcZUj4EK43+4omcYsvTmCkZkXt/3vXkdkpik4ibj3VuyGquP/KlU+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130084; c=relaxed/simple;
	bh=kFg+tCEIlydflIVsi2gxKFGGbuHzxQQOn/hdpz0x3G0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JiHIvqxZHLZfsTAhQKOYYeZ5HA1wMVyTJCxdFxM/ZrU/b8b9gr4D1JxX+CLUJkPO6AZmSq2GLIjLR7wKbxdirdH6oxj6zvRy/SW+7rj9FbZaS7U6QnsiefRWpplqKxnFWLymfsqek9HzAL2fwn+ffUOMl/QuNj26l+YJvb58GaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJWqJ1JY; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-771e15ce64eso718656b3a.0;
        Mon, 25 Aug 2025 06:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756130075; x=1756734875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IpxXj9uN8jIjZtSkBwdAr9Z8HOf1T5NLRXLi3Mh90M=;
        b=WJWqJ1JYuBjQbcys6Tu+U6M3bGLS/IxguWB0Q+qOAE6GR5XziKt30JpGg8bEcD8lLT
         fN45khxYZjr0dkJ2AKybWsAc/gldwAJqM/O2FX4Mm6gbyuuYTM07MwtGYgu9Sl41fGaO
         nCz0WMqFkT/qkgHYY/T/0xhgDBdwKAhtfZs9ug8zyEfFvhsYuNq8SOJoV5MbA/dOsP5a
         3VQXisp3Gj1AoVV7MrN1ksxegRBaMx3ZJqppaKnR6O3oKm/0teCBonr6dJxwToTMnrA0
         eJH17NlX7GGaluAC/h6UHNXgyuYTfli5VaVRVEHzvQrACZDtdiEcrXmaI3rRkW5SR420
         qNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756130075; x=1756734875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IpxXj9uN8jIjZtSkBwdAr9Z8HOf1T5NLRXLi3Mh90M=;
        b=TIUJoQJMogR5V7MY+VYLG9XE2f0vzRyWZb1LXkkyvFL7vo470q6NYu2aaeHECx4V4x
         FMMKmRqW17ZcLMMpbb9Ekd5H84E/WywSbE8uHnDftU+Mpq+YCBKXTTQ7GQ6VCN+LPZdd
         dgiXa6gArJqWu72zxlGg47DRt6WqsonyzoeEakyYhRavMNlfTHMDptACJBluiOo3HON2
         pJ3xlyF+sJAqBHoGY/yIqBTUW859/QVFY4Q82m3+tlDoWWxWn0W1iRVoLxuSOCksm2h8
         j50zb5dtBR+fCWvAhtb0cssiBXsjndV3SKk7wGEGRnW9B7S/VH1UM7fy+M34D+THPmVI
         24yg==
X-Forwarded-Encrypted: i=1; AJvYcCV8LXfW4m329WBg1XGjahHY+QWY3Ub3pqfFN9b3dyD4cxXZ378bAuWLvkcFEAhLqt5+Z3VHk8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxklHAI3RPdaYFGluANbkpXNXlgMk6SU1GmIF0erMngO/xPrpwS
	KiIqd/5LcCgu/w3z+WcbpTujQwJxCFwKson6Kset9AkWQr8Ujpx/N7Lg
X-Gm-Gg: ASbGnctef+XvYGiS1108QTXAfnPZmxKKnFkNm162Q87/RCx8A6EWcXGHVXRmVfR3mTL
	VHxUAKa8Gj+po/1ZIHMXO4sSAjDuRu+CRaPcQHkUahSCDkhpMMMgj/UFs7DauASWt5WA+k9RetV
	hcbcLVcVyVEzzvg0sJmsiRhr1CSn3IWQGtKPooiTHxOgPa2Xq4tfK0t1KNACWOehV1Icrxi3EII
	tFbeQpeO9NZZsL5x+LWd79xNfZBAZKVx8GASB1kGBYNSoe8h/G81x59xtWjAVqBDYsRC8p9t3Wb
	wMU5vpd3bpujwY2igptOBwOvZZkHBtzZvP2COA2OMIdz9IR3gElWARyLWur9FFZzWUia7/52pVV
	cPE5vrepwZgY6uS7N0Q3CTB25YnEfyXLQJaHFEQx8vaxB3b2yt8h9UhJqPhM=
X-Google-Smtp-Source: AGHT+IGyMHcEmodoL81gmrxTZS7/CrfyEjoBaCmtTVnDg0fttVacLrEP8T03Anec8PPSFh2tYOpuwA==
X-Received: by 2002:a05:6a20:5483:b0:240:265f:4eb0 with SMTP id adf61e73a8af0-24340ad1f7bmr15924206637.4.1756130074977;
        Mon, 25 Aug 2025 06:54:34 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.28.60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4a8b7b301csm3374073a12.35.2025.08.25.06.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 06:54:34 -0700 (PDT)
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
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 6/9] xsk: add direct xmit in batch function
Date: Mon, 25 Aug 2025 21:53:39 +0800
Message-Id: <20250825135342.53110-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250825135342.53110-1-kerneljasonxing@gmail.com>
References: <20250825135342.53110-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Add batch xmit logic.

Only grabbing the lock and disable bottom half once and sent all
the aggregated packets in one loop.

Since previous patch puts descriptors in xs->skb_cache in a reversed
order, this patch sends each skb out from start to end when 'start' is
not smaller than 'end'.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/linux/netdevice.h |  3 +++
 net/core/dev.c            | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5e5de4b0a433..8e2688e3f2e4 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3352,6 +3352,9 @@ u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
 
 int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev);
 int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id);
+int xsk_direct_xmit_batch(struct sk_buff **skbs, struct net_device *dev,
+			  struct netdev_queue *txq, int *cur,
+			  int start, int end);
 
 static inline int dev_queue_xmit(struct sk_buff *skb)
 {
diff --git a/net/core/dev.c b/net/core/dev.c
index 68dc47d7e700..a5a6b9a199e9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4742,6 +4742,25 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 }
 EXPORT_SYMBOL(__dev_queue_xmit);
 
+int xsk_direct_xmit_batch(struct sk_buff **skbs, struct net_device *dev,
+			  struct netdev_queue *txq, int *cur,
+			  int start, int end)
+{
+	int ret = NETDEV_TX_BUSY;
+
+	local_bh_disable();
+	HARD_TX_LOCK(dev, txq, smp_processor_id());
+	for (*cur = start; *cur >= end; (*cur)--) {
+		ret = netdev_start_xmit(skbs[*cur], dev, txq, false);
+		if (ret != NETDEV_TX_OK)
+			break;
+	}
+	HARD_TX_UNLOCK(dev, txq);
+	local_bh_enable();
+
+	return ret;
+}
+
 int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
 {
 	struct net_device *dev = skb->dev;
-- 
2.41.3


