Return-Path: <bpf+bounces-64130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E93A4B0E7A2
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 02:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBBC71CC0BBA
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 00:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B0177111;
	Wed, 23 Jul 2025 00:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXzwGZxH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A5823A6;
	Wed, 23 Jul 2025 00:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753230769; cv=none; b=dTbxcoklLTCHEd2J4WvmtubSkbARKdiI2qYUAKjXC2t2zk9bxVM7BEhQi0N2gJ9EzMZIvc3YzZKkXHYeOB8Qh2mgEx9sJ+zWn1ADbbPmunab9K2A1ftv3o9N7S7rojcT/0O9krJ0ndMKrRwsKHYE5/4aPTfAu71Mjon7BsWcnv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753230769; c=relaxed/simple;
	bh=rJBNiG/ryj6/hcFNAkKhuPQLGu307Q2BMW1qygL3OAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GftL+m6C72i14wGcaIOdoSjHeBnXFcnZsezVtZ9433gJH0Ms4I34oc9uzAl/6ITn8lz2TTZIMa+snxaLHnHlYlrEyUu+QtipIxJS0Q7f36+od5Wm0oJUL/dugDkif5ssSHAiHSKLnoN+yeSPZPNmbO7zyBktHjC9PR2tDVInlbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXzwGZxH; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fac4e2fcd1so4279626d6.0;
        Tue, 22 Jul 2025 17:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753230766; x=1753835566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nBo6ZocI/SyxB128ijhFKjoTdFjgSN64FOAnjb5ZeE8=;
        b=OXzwGZxH+JV1bobmlHySU4+0Mx80wv6Pcaw0OUZ+LoEw7KwUUY33zi21XRTWDltvZM
         EZuoeETjTZtKio1mcltqGld6DbVXL9A12YE0R9a4TAJzDNLlXKBZAcnwiLLKjW6fc4Y8
         ALMBW/oaFbwVPUbbnDOL9zR5WlO0I5JmBkvXB/Vxo/x4zNNKAYFsTgRXgqMOWRAvqRlX
         foynWLaiI6e+Ac1cHUS3SH5Dw0sHIUxHtdQwpav1ql6weaHgJKiEeNzYgeUy8Iju4kNX
         TLjU30OBDnFoVrhFUn5gyt7X70D+rTmj7uST7DmuLhPqLSeGwho59mLwo80QO9TvDKlJ
         dqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753230766; x=1753835566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nBo6ZocI/SyxB128ijhFKjoTdFjgSN64FOAnjb5ZeE8=;
        b=At8rcMhsilFZm27viGkOj+6M/8s7k3Rc7n4C7slbmXoq1/+mHhflQQYsR5GzmALocL
         ky2CSO4JLKybpYluUmWXVZwMwnsEb6WciZkLND6+9vFq0ezsZ/zdnt4E7KcuUBOEa4rr
         fgrl4/uUJ2EkMRgwSYqYgZ6icCEC3nBSYk2YFE7SkioQI/uuzDKXx1Wbv/N6tJ2za7Gg
         zLn3d4nGh4EVBjEbIVo0dSr7cVmOI6/LY2Fp+SyhD+if0IkxN11z6NMpg/EdgwotMe/w
         1KNhV8oGAO5xLYhC9mEfJqBl7OgmMiej3Z8eb/zTCZynTMPysV7UG5o6uPM9aNw/gC+O
         tBBw==
X-Forwarded-Encrypted: i=1; AJvYcCXTiYyQgxqE8Y9HYggSRs4Gi34ngVgP1b5P9XUam6vhCq75zP4fKP3Sf9AisJ5i2erdYhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO8O+e1BmjlsH/5lfrXZvUpxOQDXEbbcAgMbd++ik9nEKuDCYN
	Fqe2OlQHEqsbq4nFLvikevShHn4PQ+f7KvdySlDIjL3iPeVF0YpiBQw=
X-Gm-Gg: ASbGnctMKDOePcy+a/MgwB9Fqu7PeKEtqCoxtg2m6dnp98juaAG2sPitIP4psKf1eAK
	KPTBj+vLlSvRNMz0kqAG0meYK9RelkmekP10QnJy6JseJ7fFHZFKB13lrvtx/haveEPk6OXr4fq
	RVv4giRoK7k6Da64zJxxsH6lFJTmnvPMi2nN/TLXvh1NqiZAc8qPSoihdmlQ60Lpq+tRw7qFIxT
	tyCb6CA5o+7DUVNx2J4kN3VsZ5tcZahPciWn7JKkOlNMxmXAgaBynO81QYPamWXBKY+HdLvioaL
	K0Z1ghUnzQ5s2SdNQxR8mbCcvXIeJMUw9eko918bpgmJ1wyXJdshFGkP6gBG2pkbLsbfqeYUMc5
	l41GubQRZEitNirhBEV4=
X-Google-Smtp-Source: AGHT+IGuLkq4Ph9x2OoVl4aLCJFpWtka6sStkiw5xmFos2ZDIqMdsMId/ZZs7RMAFSc5sG7bTdMNAA==
X-Received: by 2002:a05:6214:260f:b0:705:b14:1a9c with SMTP id 6a1803df08f44-7070065fb12mr6390946d6.10.1753230765966;
        Tue, 22 Jul 2025 17:32:45 -0700 (PDT)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051bac2c95sm56624186d6.106.2025.07.22.17.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 17:32:45 -0700 (PDT)
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	bbhushan2@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	sumang@marvell.com
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	zzjas98@gmail.com,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH] net: otx2: handle NULL returned by xdp_convert_buff_to_frame()
Date: Tue, 22 Jul 2025 19:32:43 -0500
Message-Id: <20250723003243.1245357-1-chenyuan0y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xdp_convert_buff_to_frame() function can return NULL when there is
insufficient headroom in the buffer to store the xdp_frame structure
or when the driver didn't reserve enough tailroom for skb_shared_info.

Currently, the otx2 driver does not check for this NULL return value
in two critical paths within otx2_xdp_rcv_pkt_handler():

1. XDP_TX case: Passes potentially NULL xdpf to otx2_xdp_sq_append_pkt()
2. XDP_REDIRECT error path: Calls xdp_return_frame() with potentially NULL

This can lead to kernel crashes due to NULL pointer dereference.

Fix by adding proper NULL checks in both paths. For XDP_TX, return false
to indicate packet should be dropped. For XDP_REDIRECT error path, only
call xdp_return_frame() if conversion succeeded, otherwise manually free
the page.

Please correct me if any error path is incorrect.

This is similar to the commit cc3628dcd851
("xen-netfront: handle NULL returned by xdp_convert_buff_to_frame()").

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
Fixes: 94c80f748873 ("octeontx2-pf: use xdp_return_frame() to free xdp buffers")
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 99ace381cc78..0c4c050b174a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -1534,6 +1534,9 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 		qidx += pfvf->hw.tx_queues;
 		cq->pool_ptrs++;
 		xdpf = xdp_convert_buff_to_frame(&xdp);
+		if (unlikely(!xdpf))
+			return false;
+
 		return otx2_xdp_sq_append_pkt(pfvf, xdpf,
 					      cqe->sg.seg_addr,
 					      cqe->sg.seg_size,
@@ -1558,7 +1561,10 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 		otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
 				    DMA_FROM_DEVICE);
 		xdpf = xdp_convert_buff_to_frame(&xdp);
-		xdp_return_frame(xdpf);
+		if (likely(xdpf))
+			xdp_return_frame(xdpf);
+		else
+			put_page(page);
 		break;
 	default:
 		bpf_warn_invalid_xdp_action(pfvf->netdev, prog, act);
-- 
2.34.1


