Return-Path: <bpf+bounces-65156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FB4B1CE8C
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 23:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4D418C6179
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 21:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AC4230D2B;
	Wed,  6 Aug 2025 21:37:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C64C21FF51;
	Wed,  6 Aug 2025 21:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754516250; cv=none; b=Wd6Ud9JmTdYRkAmI2JbdHPwu9Plyf53e7bdd0nCbrMgvq+m7jGlkRB8d3kXSYQIaGGMoEiVy0CYWDdFw03PP9QPIpiC6fGWid2sCOlfhN5KcPbaOqBTyiJvwpcNbDx+QYqHjvHGew0S07VwwRH4huWQKlWoriJu3LJgcwELutg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754516250; c=relaxed/simple;
	bh=l68yX9XCt9xjplg3S6TYYqYUUcYJiocfrGN5djxO4Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwYfcrXBn2wiGpg3OvuePO8py/seHBsZXwJboBGDIr3MxadVWH+Z46A356nWi8cBGUh1ryrsqDtn1FH1b7wkqljhayVcm0U2GhlksuSnBmfyCt2OMnvFcqvvfO045oo41Jkwtiwpjnt5VdEefP9rC0nxXlgmOc5nAcCqL8rZhQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23dc5bcf49eso3396945ad.2;
        Wed, 06 Aug 2025 14:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754516248; x=1755121048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHAk47okoxBth3gGPZaSdIJjGXtD5du61Fs+eKgB9kY=;
        b=P8iOGW+Cr4U9+yeXPQ2mZ4GMuXxuZzZ8AqlpSbrXZUwCuzGz7NKCTk4yq5JwxuIHux
         ruHdXXfVHYulEDEmIQnlFTOpKUKlZ5aXTnsBkKzF2LQ0uNNFnyvrcW00UP0SmxjBQkog
         EH7UYQpzFYJr5fXUOZJTiObHnnr7wA7M0zEzTrmorzrJTdY7ITN7kw25PXgKIwivUnGM
         z7FeV94Uc4JkaAag8b1VnF5MGskhA8h2z6iYCYwq1++WRRf9JsqCLe8rtnztZ+oKRGLi
         Og9BPSKOgLmgvpLMzemMk0GJ9mk+r0k3m15tgs7ahXp4uxW3bXmU/RiZ2YczziJAez7T
         gxKQ==
X-Forwarded-Encrypted: i=1; AJvYcCULPB99k3xE07d3KiRid8++FfrB17myC/K60AXEbyuuSKtHjYNa8xJ+zKoarTlKL1/yyVY=@vger.kernel.org, AJvYcCVevN4M3zSMO4YCS0U0lz6wh9fCup2KxaYWkm9G8hHmlm+jrlAFfoWq/lHQ9B3FpAjb1lKZ83kKWZBvilvV@vger.kernel.org, AJvYcCW6hzIfsP3swrznPD26u+XcK5UVCSPzeOdxdmYrS73oG8gN+bH4iYd6VtK9m1JTsWyxoc4k7HqBUXyE@vger.kernel.org
X-Gm-Message-State: AOJu0YzdFZbJdeg27WOSOuOS/2ZPs45ugs6Gs/mpchy/n4fAC2zlWvmW
	bs9KNXjcVCF+IxOVbrIZESMFY00Xfo2Sgmi9gS+SvYB43Z8iT30LCcE5VSbr
X-Gm-Gg: ASbGncu1aV3W3riYRv23esUFxM7vTFLw5BgMtPwJvIN4uGWvtO1NDKhLC7EQc/bsSYa
	pgtNdyY7UThRjdqui2b4bRHoHDaLPDvAEZwHmT70c1VgRdlXqM+ipWpWeZduVZgbo87zfMR1tC+
	Rfqda1yymcRa8A/X4otzmCqFm2CvUezYWaVN3V03NqQW41xm/5Lotj0CztpkIX3K1Gv8u9wO1gR
	bzo3O9TnQjVao5MlR09cNajTF8SUoeawmXIaHMaxDjQBLb9UZvnS4ubjySaU75KuLQeglzl1gX7
	9mX9IM5BP/JTy05PnGnQTmwjFlV2iX0YlYtfGy7peDVXVTE+Vz8NSu16F2JE4gJOe5F5PLao/Il
	uCo9ueqx6haHaia7Gxj3jt4Ni9T4fc3GGPP56OSvQm+xvoGm9YF24IhgGTl6So2xcKI/Ffg==
X-Google-Smtp-Source: AGHT+IFL+0woOMjMEF8qQN0+gX0EkdLMDv79kTC4v0Jsuu5q3EIeBo/u+nVFxb8gPQ0yY5YIzwDwbw==
X-Received: by 2002:a17:902:fc8f:b0:240:6d9b:59ff with SMTP id d9443c01a7336-2429f5339b5mr60521305ad.33.1754516248349;
        Wed, 06 Aug 2025 14:37:28 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-241e899a48esm168509125ad.114.2025.08.06.14.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 14:37:27 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	ms@dev.tdt.de,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	aleksander.lobakin@intel.com,
	linux-kernel@vger.kernel.org,
	linux-x25@vger.kernel.org,
	bpf@vger.kernel.org,
	syzbot+e6300f66a999a6612477@syzkaller.appspotmail.com
Subject: [PATCH net 2/2] hamradio: ignore ops-locked netdevs
Date: Wed,  6 Aug 2025 14:37:26 -0700
Message-ID: <20250806213726.1383379-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250806213726.1383379-1-sdf@fomichev.me>
References: <20250806213726.1383379-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzkaller managed to trigger lock dependency in xsk_notify via
register_netdevice. As discussed in [0], using register_netdevice
in the notifiers is problematic so skip adding hamradio for ops-locked
devices.

       xsk_notifier+0x89/0x230 net/xdp/xsk.c:1664
       notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
       call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
       call_netdevice_notifiers net/core/dev.c:2281 [inline]
       unregister_netdevice_many_notify+0x14d7/0x1ff0 net/core/dev.c:12156
       unregister_netdevice_many net/core/dev.c:12219 [inline]
       unregister_netdevice_queue+0x33c/0x380 net/core/dev.c:12063
       register_netdevice+0x1689/0x1ae0 net/core/dev.c:11241
       bpq_new_device drivers/net/hamradio/bpqether.c:481 [inline]
       bpq_device_event+0x491/0x600 drivers/net/hamradio/bpqether.c:523
       notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
       call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
       call_netdevice_notifiers net/core/dev.c:2281 [inline]
       __dev_notify_flags+0x18d/0x2e0 net/core/dev.c:-1
       netif_change_flags+0xe8/0x1a0 net/core/dev.c:9608
       dev_change_flags+0x130/0x260 net/core/dev_api.c:68
       devinet_ioctl+0xbb4/0x1b50 net/ipv4/devinet.c:1200
       inet_ioctl+0x3c0/0x4c0 net/ipv4/af_inet.c:1001

0: https://lore.kernel.org/netdev/20250625140357.6203d0af@kernel.org/
Fixes: 4c975fd70002 ("net: hold instance lock during NETDEV_REGISTER/UP")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reported-by: syzbot+e6300f66a999a6612477@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e6300f66a999a6612477
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/hamradio/bpqether.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/hamradio/bpqether.c b/drivers/net/hamradio/bpqether.c
index 0e0fe32d2da4..045c5177262e 100644
--- a/drivers/net/hamradio/bpqether.c
+++ b/drivers/net/hamradio/bpqether.c
@@ -138,7 +138,7 @@ static inline struct net_device *bpq_get_ax25_dev(struct net_device *dev)
 
 static inline int dev_is_ethdev(struct net_device *dev)
 {
-	return dev->type == ARPHRD_ETHER && strncmp(dev->name, "dummy", 5);
+	return dev->type == ARPHRD_ETHER && !netdev_need_ops_lock(dev);
 }
 
 /* ------------------------------------------------------------------------ */
-- 
2.50.1


