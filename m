Return-Path: <bpf+bounces-59509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B08ACC9D8
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 17:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FEAB16B11D
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 15:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C6323E33F;
	Tue,  3 Jun 2025 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbTk7AFu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D594123BCF7;
	Tue,  3 Jun 2025 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748963233; cv=none; b=h7YloyBZJ99KDTdSMvVWHehCCQtkrsLXB2VQ1lwhbX8ETPcNO97keHfmEV9e4W4IPOxP2ry2tsuRk1F8O1mRnRTZBEIlvRGyJkOuyx9um0GRChTqKct5UGryMPmORF0hyKTSYJ3lO53EsyhCHirRb3JajETsDhB/DZ93g+89XgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748963233; c=relaxed/simple;
	bh=8V2kmbUZiu9hSlXFWJGJ4smleoQNWTcBNXYPPBlHjmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JNm1UerunCfxN/9Fe2PeRI2meKn1gikJzTZB/FmYgZZEV8/SNHZ5tPQP0omML/DFZR1qyHFDzEPVPDGZtyrMmoENFb8ip2Vq5ceHGq0GF5ms5iQ6XWmpFpEqlxWrQrIjGSvEBIEo1KBJKgzG1J/oQ7mGXhkxofvyjtY5HvXMmGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbTk7AFu; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-747fba9f962so951584b3a.0;
        Tue, 03 Jun 2025 08:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748963229; x=1749568029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rHRcx0Q2kd7s5w9xmY/qLmUUkyxdFzsoRB5ggIvT+6M=;
        b=YbTk7AFu9Ekm9Aod/0bD39/25yQrjNj68yTj5shjJBHZee2LDeefp53mdyKrc04DT1
         LUwEhkS054F2vXJY0zPyyiPGvKoAc8PQ7ubhRcTdWHnyAEEnul/ouLt2/cOmtLB3oSZq
         VI8tQZDoTUqlP0MBjhL4tQoZXIkEM2MQRATBX7wfs81UlMylf3PAs2wcRJeYX16qZIhV
         DGpy+kBhcOJu06+mcveYTSS/k8W7pUtKrVVa3McyCo0v7jGsKrNhyN6dJZ9SicqrVf8H
         6jvcvs7gmd4QKZpvptxsX5PjT2AB+zEHQMuxbVi5tBk8SDFy40Zosx8tx3URVy3uz0Ik
         L81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748963229; x=1749568029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rHRcx0Q2kd7s5w9xmY/qLmUUkyxdFzsoRB5ggIvT+6M=;
        b=isi4MSGk0JHX7M+Aslx3t2I4eBkP2Imv7SpG/V2Omwh5i6jNoAeAGKCZiROPLjgOZy
         F1CvDKGiqjg/knc8RC5Naof4VdceaV7UnHXpDlq6yaAGSkQ9pW/oENr1Y5uXpnX/MUwt
         eyfgv7iWSY3jt93hNp+kh+pO41HP7RpsMLlQWKhLTglqHdZbQOyPjR/jJYbbOoqPiYE9
         /qBX0/59kEnv09rrQzN4yzMsB8zXGJiwy0ursl9xJrrA2Vlz6BsEQnT9oImnLIT2eWri
         eQyBT26eZ6nI3wx71dgp/Fg9yvunDuU1lPc3oDLOa1B4ql1dzfsX7IplLWxa8dYR0R2j
         rUxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+LIeY78Y/3ALe9UodHe0gy5AZiVW1sOB/XQd3q4Fz5Y1OnpmOgsxZbxn5dhUBGZHFsmGVmr0jaTNTcnbg@vger.kernel.org, AJvYcCUEl/SkggVTTSGFtlyyGnrgLiFdB6xIbGuZGr2YfRhqwuhBH8/W7b9i0DI8c07Xi189dyI=@vger.kernel.org, AJvYcCUVUnlgmdAJneRoUcTK314lgNe7RDxrEUg3PEkV4i7LqA5/HC7BfdWJjfBa9aG9QeD7aLoF+g32@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7XBTiXBv4zz5GyBVAa0b3QnMrTg/5LCp6H+jubgIhd64JUozK
	tnuZhZGjy7k+wFXuOj0hL/C4HPqLKqtcYFpN9LJS94LSSwBZUpltTwMhaCLjSg==
X-Gm-Gg: ASbGncvXo/7RXftK2Q+vNEPJrsZYfZkahLIZJ71bhSTkSQMBLR0Yps+kbGHQKQWC4On
	Ry0PYyzxwcPgD1j6DL3E6kjddnfPgmoGM9gUCwY4RQvWsVI0baNmqzfDQL5PlyN60RsjRIObVlp
	bPpM6czUE3jyxEyyAlxRwf1cRj+bvyHnn1EIqYJo+tTGc3UIkYb6qlt5hdhjvUqBkq4rmZMHWj0
	Pf6bM/Z10uq1qh5AxxpISDOyGGlT4/F4rT4Vt7kFngAa2Y/t7gIq70TT2EnuDHGGFKWE78EShDD
	qGA+cT+LGVIofN9naxjJB6w1NeXdQKAHAxzTuP5iF93zT5iG9htyHx1mjyE8imTa0anQeB41A1R
	rTw==
X-Google-Smtp-Source: AGHT+IF0pZpF9yVqhFdo6KrG71N2ZNsh9D4aeXFDJnmId/+aHoYpiDUuxam3stwW5F7pvrA6H0vAzA==
X-Received: by 2002:a05:6a00:194a:b0:746:2ae9:fc49 with SMTP id d2e1a72fcca58-747fe29e165mr3581505b3a.9.1748963229373;
        Tue, 03 Jun 2025 08:07:09 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:c672:ef11:a97b:5717])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-747afeab0d0sm9461782b3a.44.2025.06.03.08.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 08:07:08 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] virtio-net: drop the multi-buffer XDP packet in zerocopy
Date: Tue,  3 Jun 2025 22:06:13 +0700
Message-ID: <20250603150613.83802-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In virtio-net, we have not yet supported multi-buffer XDP packet in
zerocopy mode when there is a binding XDP program. However, in that
case, when receiving multi-buffer XDP packet, we skip the XDP program
and return XDP_PASS. As a result, the packet is passed to normal network
stack which is an incorrect behavior. This commit instead returns
XDP_DROP in that case.

Fixes: 99c861b44eb1 ("virtio_net: xsk: rx: support recv merge mode")
Cc: stable@vger.kernel.org
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e53ba600605a..4c35324d6e5b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1309,9 +1309,14 @@ static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct
 	ret = XDP_PASS;
 	rcu_read_lock();
 	prog = rcu_dereference(rq->xdp_prog);
-	/* TODO: support multi buffer. */
-	if (prog && num_buf == 1)
-		ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, stats);
+	if (prog) {
+		/* TODO: support multi buffer. */
+		if (num_buf == 1)
+			ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit,
+						  stats);
+		else
+			ret = XDP_DROP;
+	}
 	rcu_read_unlock();
 
 	switch (ret) {
-- 
2.43.0


