Return-Path: <bpf+bounces-40065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7B297BDA9
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2024 16:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4964EB2207F
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2024 14:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE3618A957;
	Wed, 18 Sep 2024 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtigpoJ/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67318F9CB;
	Wed, 18 Sep 2024 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668425; cv=none; b=dqOCQQWsC+CLhwvxXEr7NTYU8ItaRBHxqGAUds3PFTgme4IHpTU6FvWGKwzn8mBZHzHUP2zSWLLBCs9tuTZbgpc+a5O87bqwgRKKYX18Db1RYVldGfNPLRFtdwG1JkuREV+5BgZPsYxDQt/j6F4ejNAmGQVuhkHUn3r4/8tfRA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668425; c=relaxed/simple;
	bh=XuCxGnJG+zi3UmAWqngWjE4roHl+w9KBZapm7VtUZWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kkX48dNLS8JMa+BAC1++VpMr8N3Zoo2OLOVQkJO9JIwn3RgmUQqiLjRcHRQdoj/1iptA/kJUNGyxI2HBvYeXKAHyImTSE23ZZNUqETeMbTkpKZ2DaEGixyUhukSUQMXGi8pLIH5lHnfLy9KjSiJXNX2rYPbC4w20JSYSZk4wQ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtigpoJ/; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d877dab61fso3966314a91.3;
        Wed, 18 Sep 2024 07:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726668423; x=1727273223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5zNbZ3iK+d9MmrvjS34MI5K0Xrdneb5ZWJpCqS0KhPU=;
        b=OtigpoJ/iHFtq5YgHLc+rt6tm6o6BVGdPJqLKR9wBX2ALx3NZVJDuIyuMpuqRDisBk
         lexN15AVDNxAC5Rbp6jgbF//AhJ2JG2gEltVo4lly4PXHY0pewhlSutYl7hdHpOoWlL+
         +uR7ya4w0TTKMkOu/S75iF3Jjt6OIkCToj2qikfdy2hgMyk6BGh4fy47DMUNQUPr5eYc
         Dqa7xYLqYQxdHB9cRoRWXgPzPS5Os+n4SMsAtqIFlDnWZlQeWvijTdYNtSuRkdklR5Df
         jEHKx0Z9vRgLaYw44jVCs13y5LI7BmmRHHXSkgj5QtU+WJ/ybmZI2DtGbz673y3qScD1
         XBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726668423; x=1727273223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5zNbZ3iK+d9MmrvjS34MI5K0Xrdneb5ZWJpCqS0KhPU=;
        b=UmN1Sk+2YbUciucf0ZdjlNo78RJs0kEROz4oSUlNqdHpZS7sQhJw5xY90mVxnIhsFs
         ipZQ3F/WW/4fECX6CqJV4VSi3c4wfXSdCHaxmbgbxyh1+H84cHi51a/73n5xgHhblDGm
         e5dbgzY7uXvX0kzMmAef4msjKS25Q9VilABuMu9cib9/d1ygbYuvNCO5u1y7b44I1ZL8
         gCFM+BT2QTVwHxSdhEGLUrEqQ/fqUIMXQ1pZmfCRyjtXeTblY77DX23CERYNhNLxz4pe
         HJS76WtYnoMXDMESAuPgK1qI61hAylBU99FvsJSd6nnNdAHz8DUiQVUGiz6MR9W5bmnW
         G+Xg==
X-Forwarded-Encrypted: i=1; AJvYcCV0E6//sJKMCtTLoqAkKjMfIdFkom872jAKHJ839p3jLJ8yOLb/nUrDZjnTqRekRyahz4rfcGeWAjjG9oXg@vger.kernel.org, AJvYcCW3/X4gb6L83teYswv9e+IWLjBNovjeiXs2853TAkB12drP/21AX9vG2WVpJtuvyQVI2aM=@vger.kernel.org
X-Gm-Message-State: AOJu0YydmFRlwucjItKGKH0mKvLeInbYTGcp3r9AofByYilpC8SdMehN
	PmaQ1CXu2NJP+fdokOvymgBcIl55Fp0RDjNc8I6U8lx7aTg/vsjg
X-Google-Smtp-Source: AGHT+IHENPcqu/F4PpDEXGc3pUAud4cUD9u2o2sNrXrADC7JkXrlYY4cCxBNx7pjUQo0vIgeUVC2WQ==
X-Received: by 2002:a17:90a:68ce:b0:2c9:61ad:dcd9 with SMTP id 98e67ed59e1d1-2dbb9ee0450mr22717857a91.27.1726668422351;
        Wed, 18 Sep 2024 07:07:02 -0700 (PDT)
Received: from x64.ju1vahqoe01uzkzduuiatpjzgc.syx.internal.cloudapp.net ([52.231.91.142])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd608dceabsm1666169a91.28.2024.09.18.07.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 07:07:01 -0700 (PDT)
From: Jiwon Kim <jiwonaid0@gmail.com>
To: razor@blackwall.org,
	jv@jvosburgh.net,
	andy@greyhouse.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	joamaki@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Jiwon Kim <jiwonaid0@gmail.com>,
	syzbot+c187823a52ed505b2257@syzkaller.appspotmail.com
Subject: [PATCH net v3] bonding: Fix unnecessary warnings and logs from bond_xdp_get_xmit_slave()
Date: Wed, 18 Sep 2024 14:06:02 +0000
Message-ID: <20240918140602.18644-1-jiwonaid0@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a WARNING in bond_xdp_get_xmit_slave. To reproduce
this[1], one bond device (bond1) has xdpdrv, which increases
bpf_master_redirect_enabled_key. Another bond device (bond0) which is
unsupported by XDP but its slave (veth3) has xdpgeneric that returns
XDP_TX. This triggers WARN_ON_ONCE() from the xdp_master_redirect().
To reduce unnecessary warnings and improve log management, we need to
delete the WARN_ON_ONCE() and add ratelimit to the netdev_err().

[1] Steps to reproduce:
    # Needs tx_xdp with return XDP_TX;
    ip l add veth0 type veth peer veth1
    ip l add veth3 type veth peer veth4
    ip l add bond0 type bond mode 6 # BOND_MODE_ALB, unsupported by XDP
    ip l add bond1 type bond # BOND_MODE_ROUNDROBIN by default
    ip l set veth0 master bond1
    ip l set bond1 up
    # Increases bpf_master_redirect_enabled_key
    ip l set dev bond1 xdpdrv object tx_xdp.o section xdp_tx
    ip l set veth3 master bond0
    ip l set bond0 up
    ip l set veth4 up
    # Triggers WARN_ON_ONCE() from the xdp_master_redirect()
    ip l set veth3 xdpgeneric object tx_xdp.o section xdp_tx

Reported-by: syzbot+c187823a52ed505b2257@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c187823a52ed505b2257
Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
Signed-off-by: Jiwon Kim <jiwonaid0@gmail.com>
---
v3: Fix subject and description
v2: Change the patch to fix bond_xdp_get_xmit_slave
---
 drivers/net/bonding/bond_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index b560644ee1b1..b1bffd8e9a95 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5610,9 +5610,9 @@ bond_xdp_get_xmit_slave(struct net_device *bond_dev, struct xdp_buff *xdp)
 		break;
 
 	default:
-		/* Should never happen. Mode guarded by bond_xdp_check() */
-		netdev_err(bond_dev, "Unknown bonding mode %d for xdp xmit\n", BOND_MODE(bond));
-		WARN_ON_ONCE(1);
+		if (net_ratelimit())
+			netdev_err(bond_dev, "Unknown bonding mode %d for xdp xmit\n",
+				   BOND_MODE(bond));
 		return NULL;
 	}
 
-- 
2.43.0


