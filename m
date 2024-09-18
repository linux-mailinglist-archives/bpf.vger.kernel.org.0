Return-Path: <bpf+bounces-40057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F7497B974
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2024 10:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82131F25888
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2024 08:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE68176251;
	Wed, 18 Sep 2024 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NksrWxyJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43EF158219;
	Wed, 18 Sep 2024 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726648600; cv=none; b=dyQdB/k9CT36CU8v06H8VSmf37wN3m9VDymdv+R7tRJzYzFgjRl+rpfvn8qEm7k0sO820l/3BQJKNV0csgmVpPuKlyW8ZcdBzDLnfPbmvw0XzqEEiYBYyc9ikaWQ6Oe9LDsRD3NP5PGdMJyWevTOxkL/311Cu+7Q/Mc1+hWpzX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726648600; c=relaxed/simple;
	bh=+BvdcA7N3oWm/rFWp0F01Ovcl0C0ZJEKyZ8sByaQsCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QZn7+pWjllCR3IGjpb3tEljnDMehW8xih9bZDUFPZf2nAkhksSc6jrHaw8XR/mmSvifuz63cKfqjEQz9WN/8bkGLU8BDmoGoOq+pbUd52+AfOeZiryIGGakOAR8cMXdnD3vi7SVRsJTxc2CufgroZtLLn0AVfiLAnoPKDuln93k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NksrWxyJ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d877dab61fso3733289a91.3;
        Wed, 18 Sep 2024 01:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726648598; x=1727253398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BZYcU6f7wuA9gDX+7U65UlNJOooHT7Qe+YlnGFdw5Mk=;
        b=NksrWxyJTvvUcsTw0mOX02zUi0YcniGfyN8XzlMKJpVqDGCUCDkPX2sp0kTuT3Qq2F
         RH95h+6QoEE1qhY9Xt+31lIQQYSlsFm5hOa8imX9XSuA2Ik8Rm/fARf/8pHlI0AXknvy
         fbHa9cRo/vQwFp6FylEFDzCw9kO4CO4nnoXFFP5rsMRHLaYpr0T9xvsbB7GtLlwzW+91
         r5HYFIV5qC0gCEOyNTA+pOHPDhhbgDStdcCdgfP9qsxp+4Ztkd9il/2vkovHngEXeKrw
         1nRSvELn5Ay4p1MibUrHQIcPzVMish1KttzluU4XUvjTegbcNWz2WgntyBzxJJXqsYYn
         nU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726648598; x=1727253398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZYcU6f7wuA9gDX+7U65UlNJOooHT7Qe+YlnGFdw5Mk=;
        b=ZndWVJON5yiP5kgaEduk0/LmxQtq8Vd4jK8FQsvcmpTkLmYWAci+DaAbxwEO3PHuYL
         MUpjKKSQw1tOTvvfvx4TloQz566RsTD6ztJkj8gKzdplnJvNE18VqAh1tV8x+pQiCNKI
         PsLFw0J081Hk2wP2RJHtaaGBm2lfeyEAF6Gz1Izk/AhYz1xgh+B+G4Ijufe7rPv5RtGM
         Bl9Sx+JzTSuSo6BfC2unS2N8jf8b6PHttqem9JCWr2BkEKTKFYEYCrSDb3S+epgzHHvV
         QvWhvfOyLXT6hz85FvXZmVL/Lvr4J0B/3078q0WdkQj/P3JbSoCSLH1vHpPo/OVUgYg2
         fdZw==
X-Forwarded-Encrypted: i=1; AJvYcCUfb8jLIfhk4nGtMYQgIfYvZr6MRObiXWW5gHWd2MTTptqglFSchjX0EuilB7XU8GeMzdwTb4eDRSTPP4TT@vger.kernel.org, AJvYcCXqlIv2QB285LkdAwMcHzh8Q5IDef/jxTBOkP/xVa40UaMWKO7f59uYHUgV+ngSTPkNnEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRKioEzi0rNMYzrKvLpEJk8kFZQaS3AP9y8FB1PwPQRsOGKZHa
	Lb0Qto9iHqQl2Q40HZVsAvENT1NIAtdcHGOrl+RxoCLCO5JtYm53
X-Google-Smtp-Source: AGHT+IFmM475h14LR5+NPyjV6+a35WUwMgJKqqhtMh2Hz3bAYVqTMyW8PK7FP8yWz4ukbjDjuNVGuQ==
X-Received: by 2002:a17:90b:4a45:b0:2d8:da35:b4d6 with SMTP id 98e67ed59e1d1-2dbb9df6581mr25294388a91.14.1726648597881;
        Wed, 18 Sep 2024 01:36:37 -0700 (PDT)
Received: from x64.ju1vahqoe01uzkzduuiatpjzgc.syx.internal.cloudapp.net ([52.231.91.142])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd60951c8bsm966036a91.56.2024.09.18.01.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 01:36:37 -0700 (PDT)
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
Subject: [PATCH net v2] bonding: Add net_ratelimit for bond_xdp_get_xmit_slave in bond_main.c
Date: Wed, 18 Sep 2024 08:35:45 +0000
Message-ID: <20240918083545.9591-1-jiwonaid0@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add net_ratelimit to reduce warnings and logs.
This addresses the WARNING in bond_xdp_get_xmit_slave reported by syzbot.

Setup:
    # Need xdp_tx_prog with return XDP_TX;
    ip l add veth0 type veth peer veth1
    ip l add veth3 type veth peer veth4
    ip l add bond0 type bond mode 6 # <- BOND_MODE_ALB, unsupported by xdp
    ip l add bond1 type bond # <- BOND_MODE_ROUNDROBIN by default
    ip l set veth0 master bond1
    ip l set bond1 up
    ip l set dev bond1 xdpdrv object tx_xdp.o section xdp_tx
    ip l set veth3 master bond0
    ip l set bond0 up
    ip l set veth4 up
    ip l set veth3 xdpgeneric object tx_xdp.o section xdp_tx

Reported-by: syzbot+c187823a52ed505b2257@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c187823a52ed505b2257
Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
Signed-off-by: Jiwon Kim <jiwonaid0@gmail.com>
---
v2: Change the patch to fix bond_xdp_get_xmit_slave
---
 drivers/net/bonding/bond_main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index b560644ee1b1..91b9cbdcf274 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5610,9 +5610,12 @@ bond_xdp_get_xmit_slave(struct net_device *bond_dev, struct xdp_buff *xdp)
 		break;
 
 	default:
-		/* Should never happen. Mode guarded by bond_xdp_check() */
-		netdev_err(bond_dev, "Unknown bonding mode %d for xdp xmit\n", BOND_MODE(bond));
-		WARN_ON_ONCE(1);
+		/* This might occur when a bond device increases bpf_master_redirect_enabled_key,
+		 * and another bond device with XDP_TX and bond slave.
+		 */
+		if (net_ratelimit())
+			netdev_err(bond_dev, "Unknown bonding mode %d for xdp xmit\n",
+				   BOND_MODE(bond));
 		return NULL;
 	}
 
-- 
2.43.0


