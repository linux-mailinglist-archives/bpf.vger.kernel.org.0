Return-Path: <bpf+bounces-65155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59EEB1CE88
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 23:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F851620FBD
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 21:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E8F22DFBA;
	Wed,  6 Aug 2025 21:37:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A1721FF33;
	Wed,  6 Aug 2025 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754516250; cv=none; b=mMnOTQkosvd82xV+EDLeLwK5mVoXjWXHE75Rgo8fRP1rpOy0SOTl9hpEXiGElmA0z3bhlostCBTbGRerp1SZ8RuJ/LzeMXlb4HDCzC9/l6YqkfNPg9x7fjOFn8OEhctX49HGMhobwnbTDhXpg7yWd2oofBkLKSPfGwXZM7moaC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754516250; c=relaxed/simple;
	bh=d08/BzmEk7xsPuga/+Y6sgHIvvOsUVxfjOjKWswdj7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m/DbpiY8wAzj1jqag/UQ5z+QrdWDnfUZPGRIUmVwH+go5IgFFfsvM0ct2Hy9jN0o9zWHR9u0AyD5mA9pWRRYqqZ+tg7IPizKYSyEJlVkwT1QLikjURdT+jXndRDAsW5njpgidVPRzPKpkhD/Am6AR1OYZAcRptTa8BZj4r53iuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-31efc10bb03so350243a91.0;
        Wed, 06 Aug 2025 14:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754516247; x=1755121047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3qCIvuNBq4ySoSBRMy/pjsnvmjDJSZDTcQbr0YEK14M=;
        b=i6mtMgnr86o35F8FK5BtyodcWqDD9htO2ZmHSaPeWSkSYSyKxWzatML9LWMZYkq8Jp
         UkoDVC+awtyh1Xs2jICYEJRhntXNa2bRNGcfFBIkZdjzuYSSjkX86ScV/ePezQHcvr4a
         eb+vCaY8+kRJgijEmJ6ZzTlSCgJGtvsDeo7TqUA6EhndJULY6UFrWwaE9y9ewYVyX0GN
         WZrQITlNUopkAcAz2YPN5TVM8e9x7Go5jSw1AvyNwYgsad+HUx6xivfW0Ekp1G+NVI8x
         FYlzsDf473TX0jGUokHF3eY9oEjSK+wJ6J5oNDMkxek0XZ/XV0KWbfB/zgrx7SVgStY9
         IdAg==
X-Forwarded-Encrypted: i=1; AJvYcCVP9lovGFK90NUSS8ezJM1Caihip+8PFolDQ2bLv7mpEQt3WwFlrtkea850tWxgGNilTn/J86acV+2W@vger.kernel.org, AJvYcCWZLT69SMwV3uZtFBXXruyLNHGI9o1Z6sKYi0CsoX29mlrX1gSpaJ7f4SB+/x69MW9Ln3E=@vger.kernel.org, AJvYcCXd4API2ZyRPv2SbGq81RHWBOOkGv25q6U/bi4Wv3vh082JWlvN5GZAKoiPLHXZJ7/1eFlJgnrEgrjXn+dU@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv5sNgG215oefLQnIs5LHCq9OFmpQEeshhnnafR/04GbYUQqGi
	nO4EIvm3YoyxnOYPfurM0he/bFvyFwNH1dE+ioNCAJQ8kr7LZMrY3ty0FRpe
X-Gm-Gg: ASbGncttDbBgl6Y3t+05hP7lc07k2LLF4/hRpd4smqM45CB8FKtk0mfUHaSv0PtKWIQ
	3H+vYL+0XyEQ94Led96QudMsAlAe6ayZl5mMOAlmwqpJWWwWOFO0SZ/YqSyLWBEUYp8H/av0p+5
	gnJ2BkUHzJADjP66mmQU1OeRa4hvloY9x4lS31Lv3HsXMpulA2+bELIs9pzWb12a31/zOnSwo+H
	DQ7HMeYzkfX6/Vq6Huu8mRs6oXY3wkB7ZqWmU19TojJxqyVwEXFp4uWroBlIOliKyZA9ANRvF4U
	RHwa2B3TnAGesDuezZgEvJKf3a56uevd3i/s8nuyGGvf6qH9J8zWt9yUBAHk3cLpJIIpO4Q+ckx
	YjLwK0irE1RBpJT/OU9HOz5IEoDjy20onls1N6DtpBUl8LfMiOcXxm4zk+0VZN+Qmdf1eLQ==
X-Google-Smtp-Source: AGHT+IEpjgR8dCl+AsMMIzBN0nJK2Y2HHQAWkN21Tc/AXTNfQ2pmiR1UrsO/vIBdCRNy0+nydvsumw==
X-Received: by 2002:a17:90b:524f:b0:312:e8ed:758 with SMTP id 98e67ed59e1d1-32166c20054mr5946894a91.13.1754516247331;
        Wed, 06 Aug 2025 14:37:27 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3216126c98fsm3664945a91.21.2025.08.06.14.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 14:37:26 -0700 (PDT)
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
	syzbot+e67ea9c235b13b4f0020@syzkaller.appspotmail.com
Subject: [PATCH net 1/2] net: lapbether: ignore ops-locked netdevs
Date: Wed,  6 Aug 2025 14:37:25 -0700
Message-ID: <20250806213726.1383379-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzkaller managed to trigger lock dependency in xsk_notify via
register_netdevice. As discussed in [0], using register_netdevice
in the notifiers is problematic so skip adding lapbeth for ops-locked
devices.

       xsk_notifier+0xa4/0x280 net/xdp/xsk.c:1645
       notifier_call_chain+0xbc/0x410 kernel/notifier.c:85
       call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2230
       call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
       call_netdevice_notifiers net/core/dev.c:2282 [inline]
       unregister_netdevice_many_notify+0xf9d/0x2700 net/core/dev.c:12077
       unregister_netdevice_many net/core/dev.c:12140 [inline]
       unregister_netdevice_queue+0x305/0x3f0 net/core/dev.c:11984
       register_netdevice+0x18f1/0x2270 net/core/dev.c:11149
       lapbeth_new_device drivers/net/wan/lapbether.c:420 [inline]
       lapbeth_device_event+0x5b1/0xbe0 drivers/net/wan/lapbether.c:462
       notifier_call_chain+0xbc/0x410 kernel/notifier.c:85
       call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2230
       call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
       call_netdevice_notifiers net/core/dev.c:2282 [inline]
       __dev_notify_flags+0x12c/0x2e0 net/core/dev.c:9497
       netif_change_flags+0x108/0x160 net/core/dev.c:9526
       dev_change_flags+0xba/0x250 net/core/dev_api.c:68
       devinet_ioctl+0x11d5/0x1f50 net/ipv4/devinet.c:1200
       inet_ioctl+0x3a7/0x3f0 net/ipv4/af_inet.c:1001

0: https://lore.kernel.org/netdev/20250625140357.6203d0af@kernel.org/
Fixes: 4c975fd70002 ("net: hold instance lock during NETDEV_REGISTER/UP")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reported-by: syzbot+e67ea9c235b13b4f0020@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e67ea9c235b13b4f0020
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/wan/lapbether.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
index 995a7207bdf8..f357a7ac70ac 100644
--- a/drivers/net/wan/lapbether.c
+++ b/drivers/net/wan/lapbether.c
@@ -81,7 +81,7 @@ static struct lapbethdev *lapbeth_get_x25_dev(struct net_device *dev)
 
 static __inline__ int dev_is_ethdev(struct net_device *dev)
 {
-	return dev->type == ARPHRD_ETHER && strncmp(dev->name, "dummy", 5);
+	return dev->type == ARPHRD_ETHER && !netdev_need_ops_lock(dev);
 }
 
 /* ------------------------------------------------------------------------ */
-- 
2.50.1


