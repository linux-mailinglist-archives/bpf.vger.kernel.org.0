Return-Path: <bpf+bounces-39974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB287979AD7
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 07:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1DAC283854
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 05:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06ED3A1DA;
	Mon, 16 Sep 2024 05:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCSceZ70"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0691E381B1;
	Mon, 16 Sep 2024 05:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726465849; cv=none; b=MpB9svhlkR7voShYT5OvINSndMmwUthd8s7bFsLL1o+CZuNlTCd7a4hbt75MmDKGd1IB/0C9lDczRW8nA8fwmUL2zWKq0rcIQW06bZ7dOtsflB9gLlCkOEq5hLu3KZ1byW5drO2cbl1mVrRBb5/5CsPtbTv7Fo+7O/85r6SmDOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726465849; c=relaxed/simple;
	bh=0MMgHpKY0KowvzcMMNMhX5Z0T14qk8y//2PRBRL99nM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dDR1AmrHzYnCmuj+t/ocPyvYxep+Q3jqCLU2xxC50HRXm4FBwTfMo+N/iclIrNmyTrS6/akg+0aj1wJnnsCozPTlSSGQS7vDj1KhYxXQRox7o+OpnMPq0O0uucyUqpGeTN3pbf00cK5yXV3AeeJIfxwD/CzDX6TsG5RvPeZSbFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCSceZ70; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso2899668a12.0;
        Sun, 15 Sep 2024 22:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726465847; x=1727070647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zIrxZybZ0XitsIay3aIhX8lKiy24xzgBw1Qc3hSqjyU=;
        b=GCSceZ70tfnd+zQTEVSlH5DkpPh8jRJjH/Bbct3WeH0NQ7g4e3OmIR3tldsxRqcKIu
         ZbkiIEVq/5f7Oa0kMZtKlkG9BcJbah8niUrsxI5UM1gYncf4MvRpR1HixNmJ+vH6lAeV
         6UI1Uy8Vmgnhmk4nK/ns1MIk6lOMwrtM57Dn9WO49WvOJhsKEZweXgoNHIqMclxv3kiY
         NENX4lDWhJCV1JWRf1qrZvWdIhl6YTRBYsto9UhYZBYQLmlRqeVIdrlUVqknVDEKP9F/
         gL5ZHV5stGkFrFYl+5gb4YzN2Kzl3uWwydqzPxm3kUe6Li6n9XgklcWTx2CqDdaY6QK8
         eeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726465847; x=1727070647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zIrxZybZ0XitsIay3aIhX8lKiy24xzgBw1Qc3hSqjyU=;
        b=ghNBE+jm1jHdqfGVa7qfCTXoE0b/7v16Ay/ovaiY8KaXNdIUj5bJXnB6f17g9imwcS
         uPs5fUAXbACxFhFidKL0InukqEnEvbOBT+iaCuoQE4Ou0PeUAMOkyajJ4qtYKHHCDFzL
         8qaWaXBOhsCyvUF5QHtCP2zNevOvskmSEaZfPgJUTWh8BoHo6tUm/QlGRksVe6HnvyTi
         +fGr4X7rOcddL1N5USAzqCSog9YeWd2gsrUmt0goMz9orXsuzzJQYF3OjON3OoFIJRWJ
         obUkMExMEuAFknAB601v4O3vvXcJIoH/L1uUcYOmUI1EfWp6sqh+T0Rry+AMdZST9zpK
         7fKA==
X-Forwarded-Encrypted: i=1; AJvYcCVQtw5maPlQDuChPKl/6pUIxUrf8S4Kxam6BVOWxLRbTuDZc1uFjYJtWxR7XBjl6wmb89Q=@vger.kernel.org, AJvYcCVVHL/1kB2WZPY/C5AAFwhAdvxW3BZ7lx40gQXdLMikMbO01RUZUCmXsegIyJqSbEojQcX6kb+him8/x79/@vger.kernel.org
X-Gm-Message-State: AOJu0YzRvgBcX2fScB+TNRoKs7pm0fKbgPtBEEyG4YV4E79R5YioYQrn
	Cly0Xd9SVJSCWDr9QmAtfuwtrwelQaEL15hFuk53lB1YlrjrlN7Z
X-Google-Smtp-Source: AGHT+IE+4KpUczX0+BmIT2L40g/6KCkXEbsX0oILt0QtdXDIA6jH7bEkKi+a1RLWQMBSuVSizj9S/g==
X-Received: by 2002:a05:6a21:3a96:b0:1d0:3a32:c3f8 with SMTP id adf61e73a8af0-1d03a32c3fdmr18116352637.39.1726465846938;
        Sun, 15 Sep 2024 22:50:46 -0700 (PDT)
Received: from x64.ju1vahqoe01uzkzduuiatpjzgc.syx.internal.cloudapp.net ([52.231.91.142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944bcae34sm3074216b3a.220.2024.09.15.22.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 22:50:46 -0700 (PDT)
From: Jiwon Kim <jiwonaid0@gmail.com>
To: jv@jvosburgh.net,
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
Subject: [PATCH net] bondig: Add bond_xdp_check for bond_xdp_xmit in bond_main.c
Date: Mon, 16 Sep 2024 05:50:11 +0000
Message-ID: <20240916055011.16655-1-jiwonaid0@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bond_xdp_check to ensure the bond interface is in a valid state.

syzbot reported WARNING in bond_xdp_get_xmit_slave.
In bond_xdp_get_xmit_slave, the comment says
/* Should never happen. Mode guarded by bond_xdp_check() */.
However, it does not check the status when entering bond_xdp_xmit.

Reported-by: syzbot+c187823a52ed505b2257@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c187823a52ed505b2257
Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
Signed-off-by: Jiwon Kim <jiwonaid0@gmail.com>
---
 drivers/net/bonding/bond_main.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index bb9c3d6ef435..078c85070b86 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5551,27 +5551,30 @@ bond_xdp_get_xmit_slave(struct net_device *bond_dev, struct xdp_buff *xdp)
 static int bond_xdp_xmit(struct net_device *bond_dev,
 			 int n, struct xdp_frame **frames, u32 flags)
 {
-	int nxmit, err = -ENXIO;
+	struct bonding *bond = netdev_priv(bond_dev);
+	int nxmit = 0, err = -ENXIO;
 
 	rcu_read_lock();
 
-	for (nxmit = 0; nxmit < n; nxmit++) {
-		struct xdp_frame *frame = frames[nxmit];
-		struct xdp_frame *frames1[] = {frame};
-		struct net_device *slave_dev;
-		struct xdp_buff xdp;
+	if (bond_xdp_check(bond)) {
+		for (nxmit = 0; nxmit < n; nxmit++) {
+			struct xdp_frame *frame = frames[nxmit];
+			struct xdp_frame *frames1[] = {frame};
+			struct net_device *slave_dev;
+			struct xdp_buff xdp;
 
-		xdp_convert_frame_to_buff(frame, &xdp);
+			xdp_convert_frame_to_buff(frame, &xdp);
 
-		slave_dev = bond_xdp_get_xmit_slave(bond_dev, &xdp);
-		if (!slave_dev) {
-			err = -ENXIO;
-			break;
-		}
+			slave_dev = bond_xdp_get_xmit_slave(bond_dev, &xdp);
+			if (!slave_dev) {
+				err = -ENXIO;
+				break;
+			}
 
-		err = slave_dev->netdev_ops->ndo_xdp_xmit(slave_dev, 1, frames1, flags);
-		if (err < 1)
-			break;
+			err = slave_dev->netdev_ops->ndo_xdp_xmit(slave_dev, 1, frames1, flags);
+			if (err < 1)
+				break;
+		}
 	}
 
 	rcu_read_unlock();
-- 
2.43.0


