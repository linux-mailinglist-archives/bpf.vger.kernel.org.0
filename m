Return-Path: <bpf+bounces-30363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A6D8CCB3A
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 05:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A491C20A3C
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 03:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1704437C;
	Thu, 23 May 2024 03:35:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48364282E2;
	Thu, 23 May 2024 03:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716435338; cv=none; b=JLHX7oiTNA3PvLe8Rphk8KQvG6LSB8jkYOrCd+2Ky4agj0phMmdtqeYoGmyY6LlC7rPRXOlVZT6MpKMvNJz3ElFF8iuJySJVJ81/Q82wJQns/qZyuZXTEMtbTRredSjGMeAF9KuC+A0IfKv1/QsovxpplJMO2U6WAX1LREDSo58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716435338; c=relaxed/simple;
	bh=1ecCdekXvw0Q7fYMCuFXZvMAgocCTlyHdeTnVgBbGsc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XbUQ3j+8pZul4VTk8w4wOtlJyysMbCh80Rw8ZhFHn+aq6rV4kzbw2ZJ6zQmX36nL4vl53opqJtHyZW556umKQEbrSUy/vFmaoo7M/0K598cFhX8YFFUc9q2uucg3fTjSZqb8zplophDjCcKbUKD12/QOHtv/mG7a6ndVo2EYJ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7e16bede18b511ef9305a59a3cc225df-20240523
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:9c1f3f2c-37cd-4dbb-a4e0-ec9ef964244c,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.38,REQID:9c1f3f2c-37cd-4dbb-a4e0-ec9ef964244c,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:047024193c2cce1267aed56d352d254c,BulkI
	D:240523113247WF7YM8BT,BulkQuantity:1,Recheck:0,SF:44|66|24|17|19|102,TC:n
	il,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 7e16bede18b511ef9305a59a3cc225df-20240523
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw.kylinos.cn
	(envelope-from <jiangyunshui@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1714773553; Thu, 23 May 2024 11:35:25 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 360CEE000EBB;
	Thu, 23 May 2024 11:35:25 +0800 (CST)
X-ns-mid: postfix-664EB97D-24684865
Received: from kylin-pc.. (unknown [172.25.130.133])
	by mail.kylinos.cn (NSMail) with ESMTPA id 16CC1E000EBB;
	Thu, 23 May 2024 11:35:22 +0800 (CST)
From: yunshui <jiangyunshui@kylinos.cn>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	edumazet@google.com,
	yunshui <jiangyunshui@kylinos.cn>,
	syzbot <syzkaller@googlegroups.com>
Subject: [PATCH] net: filter: use DEV_STAT_INC()
Date: Thu, 23 May 2024 11:35:20 +0800
Message-Id: <20240523033520.4029314-1-jiangyunshui@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

syzbot/KCSAN reported that races happen when multiple cpus
updating dev->stats.tx_error concurrently.

Adopt SMP safe DEV_STATS_INC() to update dev->stats fields.

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: yunshui <jiangyunshui@kylinos.cn>
---
 net/core/filter.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 2510464692af..9968db21a29d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2274,12 +2274,12 @@ static int __bpf_redirect_neigh_v6(struct sk_buff=
 *skb, struct net_device *dev,
=20
 	err =3D bpf_out_neigh_v6(net, skb, dev, nh);
 	if (unlikely(net_xmit_eval(err)))
-		dev->stats.tx_errors++;
+		DEV_STATS_INC(dev, tx_errors);
 	else
 		ret =3D NET_XMIT_SUCCESS;
 	goto out_xmit;
 out_drop:
-	dev->stats.tx_errors++;
+	DEV_STATS_INC(dev, tx_errors);
 	kfree_skb(skb);
 out_xmit:
 	return ret;
@@ -2380,12 +2380,12 @@ static int __bpf_redirect_neigh_v4(struct sk_buff=
 *skb, struct net_device *dev,
=20
 	err =3D bpf_out_neigh_v4(net, skb, dev, nh);
 	if (unlikely(net_xmit_eval(err)))
-		dev->stats.tx_errors++;
+		DEV_STATS_INC(dev, tx_errors);
 	else
 		ret =3D NET_XMIT_SUCCESS;
 	goto out_xmit;
 out_drop:
-	dev->stats.tx_errors++;
+	DEV_STATS_INC(dev, tx_errors);
 	kfree_skb(skb);
 out_xmit:
 	return ret;
--=20
2.34.1


