Return-Path: <bpf+bounces-37163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B10C9951756
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 11:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4D11F22FFE
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 09:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA34143C50;
	Wed, 14 Aug 2024 09:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="N0mNBwov"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B43C55E53
	for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 09:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723626502; cv=none; b=VREoEbvZbbuJbEllE2u9teSVS0agp5ZdaPss5HUameomwy5inusnFMgUyehiWKxnp6ONibOjedlKZ2xuMDLZDlz9QF4N6mAKgw8VwgBuvJA/pYYFeulQGgrcap/wWnpZeKmMG1DmcIWKwUFo0z7K9l9GmBZ9AuGmKfdCfNaDnlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723626502; c=relaxed/simple;
	bh=44WOPlnqlPk/mb/+BMsrqQCYiSdeF1zdyuVp4QVRKio=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XoVWHC/UN+ZkPeQeUA8nXC3sIzMqbwjXxO1/kfR3vme+8QUwOvK65CChydHldPI90MY2drUmpGuOzxfMMOBf4JjC1sh9irXeCVWszip4o41+nPBKwbs2rJgFGW/Vc8uDOeNMaL0JT5BWDT1TViHOpavruYUvlQlzPXKX3ucz6UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=N0mNBwov; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-201d6ac1426so5393675ad.1
        for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 02:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723626500; x=1724231300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=32PXXV2QL2XbF8eLBvu4oAhbSZGQ+NlsUMAqd8y/jh8=;
        b=N0mNBwovtY9nG6vCIuc0W1fNGjX6pR9t1JqrLn4KL43oj3o8Mp0EWsdUagS0IlXwtU
         XqDFwjP1sczJSjTlEOQf3I6b6m3UkkDr5TwfPdEl0/ey12LIFHZ51MdS8XiuKR4TvCH5
         /uu+NKwTL/q/UgN7QIYuVSQiMS9JfJ58+4b4f+9ulIwNFjzCX5J2CEDBxtQ8V+nlz6uL
         R/SSGsEeGTm1oTeLG3HzzXWjYMCD4rPva/x/1HOcMQULq+nCOF+3j/qNIy7Y+4xHxk82
         w16XscJEn2AD/pEwlyaCjNJhBv7fY/vVN7J+I1wQJ/ytQyYGZdMmylx9IJuwsyjdn+sU
         a0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723626500; x=1724231300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=32PXXV2QL2XbF8eLBvu4oAhbSZGQ+NlsUMAqd8y/jh8=;
        b=SsckgZ7HB83KxBoCG+0e/LoLZZRS8+QAAJ4/Y9vs4ycI1QqDU01/qMVz9RV7ycNtw3
         QJxTToxLQK7qKzY93/w21QGi+USvaLHv8J9W5Ba9oqXqeOYV23Ka7gf/jnfASCUpofGI
         nGCxmmn29MBVnOzlpJNr1qfpiXDtzyIsxgmhUAY5bKWbwsY+E2mD76DORMztxMYxU0Ge
         WdO5MK6ebwVklunqZYE1mnkPVOoY/iwUDViNPNiGoXYxrVUqR6InAkhbtJOAYZybAXoo
         /5qfp6CF/mRd+gqAvbtRAfB+r/4EesNMIxVCVYNyDHJiv9GK13oryY8R2bV+eL48302R
         9J4g==
X-Forwarded-Encrypted: i=1; AJvYcCX/LYrxZ/tx7hcizThRyR2JdhJy1yo2RydalHHrzlRz8O9CZNwKC8KffRJSiPAEgysv0iULr5MOI+yPVuCx99d9fJXc
X-Gm-Message-State: AOJu0Yx/U0m7ZIIyk4/KO2IullEqRf5Q7igaMOYOKsgBT7OHh1lyW8SK
	GLxiJW8Jjm40AhwHMg61nul15VWqGElRCngAgSs1z5IBTYO4/oSyNfHY5qEEUWg=
X-Google-Smtp-Source: AGHT+IHuYXuhltEliMauH5KaebG0cPWH0eOsGcHY9bRFUYY3iGer/a5GVOSz9JPxxkNZ4ftgPwkdew==
X-Received: by 2002:a17:902:f643:b0:1fd:6655:e732 with SMTP id d9443c01a7336-201d64d0e9dmr25671975ad.54.1723626500510;
        Wed, 14 Aug 2024 02:08:20 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1c86f3sm25456875ad.244.2024.08.14.02.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 02:08:20 -0700 (PDT)
From: Feng zhou <zhoufeng.zf@bytedance.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	jiri@resnulli.us,
	bigeasy@linutronix.de,
	lorenzo@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com,
	zhoufeng.zf@bytedance.com
Subject: [PATCH] net: Don't allow to attach xdp if bond slave device's upper already has a program
Date: Wed, 14 Aug 2024 17:08:11 +0800
Message-Id: <20240814090811.35343-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Feng Zhou <zhoufeng.zf@bytedance.com>

Cannot attach when an upper device already has a program, This
restriction is only for bond's slave devices, and should not be
accidentally injured for devices like eth0 and vxlan0.

Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 net/core/dev.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 6ea1d20676fb..e1f87662376a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9501,10 +9501,12 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
 	}
 
 	/* don't allow if an upper device already has a program */
-	netdev_for_each_upper_dev_rcu(dev, upper, iter) {
-		if (dev_xdp_prog_count(upper) > 0) {
-			NL_SET_ERR_MSG(extack, "Cannot attach when an upper device already has a program");
-			return -EEXIST;
+	if (netif_is_bond_slave(dev)) {
+		netdev_for_each_upper_dev_rcu(dev, upper, iter) {
+			if (dev_xdp_prog_count(upper) > 0) {
+				NL_SET_ERR_MSG(extack, "Cannot attach when an upper device already has a program");
+				return -EEXIST;
+			}
 		}
 	}
 
-- 
2.30.2


