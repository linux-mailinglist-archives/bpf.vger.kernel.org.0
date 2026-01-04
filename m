Return-Path: <bpf+bounces-77757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A46ACF0947
	for <lists+bpf@lfdr.de>; Sun, 04 Jan 2026 04:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E8D83020CF4
	for <lists+bpf@lfdr.de>; Sun,  4 Jan 2026 03:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180C52C08B0;
	Sun,  4 Jan 2026 03:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qrt/4vmK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBBE284665
	for <bpf@vger.kernel.org>; Sun,  4 Jan 2026 03:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767497008; cv=none; b=MwrwMV2KL1Lu0N2wkMNTBrDCowRjJy2SQOJ2z2kMBXzr2mmlM1y2tDdh9nf1Mt782QCgIxukn1TuCZ4R1raTiyOBs8Ag45NWgLo0m9fagCHN1kQp5CArPoqimEQF7RE5izzIGDluszeMx4B0sJYtXfJ68PrIzLiQ6Cn6h4w/Nls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767497008; c=relaxed/simple;
	bh=iFOjWoPhxg3t7eBaMyFBLT+tXL3mjtPxiiafXceNxzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=koX+AKIzSoz3wJQG5s/Kzfvs1RgocMG0nUNEWUaUYU1WAZjMaB5n962Q6eqOT8Jg/3SyH60kLgmCrLuXjhN0iXmBWJ1w/1tpPluYz6HYGyQ7Pl+UN/HGOwCVG2O+IkC0sJzkmxJXPgZfWkfb5mTWT/yt0nC2lyOX+sI5MwCBTDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qrt/4vmK; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0a95200e8so110121055ad.0
        for <bpf@vger.kernel.org>; Sat, 03 Jan 2026 19:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767497006; x=1768101806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36dhxZqhoIQQhhEMrHz1gupE6TH8vQ91Ce45pP+oIbU=;
        b=Qrt/4vmKLcBWFd8qIPznx5h3nS4DSeH4MgIfvYsZFyt424akY7dM9VkcTJD9T5b4SP
         zNRSz/OHYKavfqHf8yafHSQ5OAPnSNndRt1BuqyWiu4tZcTcdsy36xVTlntcYGMV7ehV
         8Nbk0g3Lt51+/Sr4poSyULJ6kTnBqfgYol+Vmt75nsqISrufU8ilWGc6BrlOlUXYUlbn
         ZgRpAnnFNJJYAUjEmgmbAS3m7ImeDRiyYHWenT6T1yFSf7Yjs1ZFaR9k8q3MJYVPpJzh
         UCtk7UVrZ6z8OZ8t06N9nSDHQkK6/t4T88yd0C3mlEdO7rHGLbsgaBk4cONPFgnkDNr/
         ZSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767497006; x=1768101806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=36dhxZqhoIQQhhEMrHz1gupE6TH8vQ91Ce45pP+oIbU=;
        b=OGQzEYZ4uzksR3Al8gjYytr5kzOcT10iupF+o4wiKP3+8ujis2Czv30xfoAHNd/DWb
         C4cT3UyLt+1BGH2tnFqaIyNAgpakoIYuYfDPdy1sAzOm+d5OANH8DKueEKZU8vgyDgzA
         Tvgxx53r3++hUVb2yb/+Ly+H/c1FCGekuVkO7pRWmtY3D9GIXZfZKyySrCnWujaevzdI
         i5wF+SqxZTkARtf8tHfhd7cRAzjdIEaIB17E317SCbdpCZBof0s4/YEvZ4SDlyqdek6r
         9vt20101CxYVrpLcAANSAU5ejUGLfB8JfPFYuPX7MMAGUJY1hoXlQSzZujfWxohk3/x6
         hdOA==
X-Gm-Message-State: AOJu0Yyx5G5DtqHn0emqIpmN7yMImwodWutwJb6jtFfso4oXL7jrcVZE
	I2OJNRHl9u3ACFn0Ni6gDDfIni5GCINrDS65kFZ4ijpmWfi7BWeiPfrh
X-Gm-Gg: AY/fxX7hzgon4IVM9P/SPzihu+GFsjVgf4IpQ8laR0AiO6kPwx2hjG9R9e9FxUqcQnv
	k6enmj+O+5GbClr0eHEYDEx59q+ms1/DTB7jyWh09uAX2p8vWA59hkqOUOQig0h+5xduB23Qw8l
	GMRuEpi2YDUFF+OIVi9Fs5qFZqscpTJWC3sGPWqW7uu+eAQ3bR1UUlF8UxeSpMK7l4NMOEmxdqI
	xmu0849+AcIHb52mo/MbBbgPhX6Isa9q851+wpzVTl+gfR78/fQfuNpIpFhwxuy/aoAilN5i49z
	/CTHieyk4BI0ZbScZ35f9cb27QbI7JnovtmCD0dLQ/RpwgO9ycfISm1POOvYaR7nrM9mVdusGea
	P8QQI6b0VwNmOTBxT/t2e8ujCXljYfTAAtM5Nl3p5EEwuGJ8IWiXuL6sQe22UmGXbep4wBp8rlp
	XdUUUveHTVPldxXeOdB8cLWC7Uwes5XltxYvtwhYfkOOTRTNIUJH+O/g/IMw==
X-Google-Smtp-Source: AGHT+IGr13ReutP5qE+ejFO23iRKdsVsI8sXEEpX3MmrgkrlkmT9JrGKSx2JjX38pbQ5xXYbt7wbJQ==
X-Received: by 2002:a17:902:f60c:b0:2a0:8966:7c94 with SMTP id d9443c01a7336-2a2f22262e1mr444079965ad.20.1767497006156;
        Sat, 03 Jan 2026 19:23:26 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d6d557sm405852335ad.84.2026.01.03.19.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 19:23:25 -0800 (PST)
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
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH bpf-next v3 1/2] xsk: introduce local_cq for each af_xdp socket
Date: Sun,  4 Jan 2026 11:23:12 +0800
Message-Id: <20260104032313.76121-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260104032313.76121-1-kerneljasonxing@gmail.com>
References: <20260104032313.76121-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This is a prep that will be used to store the addr(s) of descriptors so
that each skb going to the end of life can publish corresponding addr(s)
in its completion queue that can be read by userspace.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xdp_sock.h |  8 +++++++
 net/xdp/xsk.c          | 54 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 23e8861e8b25..c53ab2609d8c 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -45,6 +45,12 @@ struct xsk_map {
 	struct xdp_sock __rcu *xsk_map[];
 };
 
+struct local_cq {
+	u32 prod ____cacheline_aligned_in_smp;
+	u32 ring_mask ____cacheline_aligned_in_smp;
+	u64 desc[] ____cacheline_aligned_in_smp;
+};
+
 struct xdp_sock {
 	/* struct sock must be the first member of struct xdp_sock */
 	struct sock sk;
@@ -89,6 +95,8 @@ struct xdp_sock {
 	struct mutex mutex;
 	struct xsk_queue *fq_tmp; /* Only as tmp storage before bind */
 	struct xsk_queue *cq_tmp; /* Only as tmp storage before bind */
+	/* Maintain addr(s) of descriptors locally */
+	struct local_cq *lcq;
 };
 
 /*
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f093c3453f64..f41e0b480aa4 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1212,6 +1212,34 @@ static void xsk_delete_from_maps(struct xdp_sock *xs)
 	}
 }
 
+/* Initialize local compeletion queue for each xsk */
+static int xsk_init_local_cq(struct xdp_sock *xs)
+{
+	struct xsk_queue *cq = xs->pool->cq;
+	size_t size;
+
+	if (!cq || !cq->nentries)
+		return -EINVAL;
+
+	size = struct_size_t(struct local_cq, desc, cq->nentries);
+	xs->lcq = vmalloc(size);
+	if (!xs->lcq)
+		return -ENOMEM;
+	xs->lcq->ring_mask = cq->nentries - 1;
+	xs->lcq->prod = 0;
+
+	return 0;
+}
+
+static void xsk_clear_local_cq(struct xdp_sock *xs)
+{
+	if (!xs->lcq)
+		return;
+
+	vfree(xs->lcq);
+	xs->lcq = NULL;
+}
+
 static int xsk_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
@@ -1360,9 +1388,18 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
 				goto out_unlock;
 			}
 
+			err = xsk_init_local_cq(xs);
+			if (err) {
+				xp_destroy(xs->pool);
+				xs->pool = NULL;
+				sockfd_put(sock);
+				goto out_unlock;
+			}
+
 			err = xp_assign_dev_shared(xs->pool, umem_xs, dev,
 						   qid);
 			if (err) {
+				xsk_clear_local_cq(xs);
 				xp_destroy(xs->pool);
 				xs->pool = NULL;
 				sockfd_put(sock);
@@ -1380,6 +1417,13 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
 			xp_get_pool(umem_xs->pool);
 			xs->pool = umem_xs->pool;
 
+			err = xsk_init_local_cq(xs);
+			if (err) {
+				xp_put_pool(xs->pool);
+				xs->pool = NULL;
+				sockfd_put(sock);
+				goto out_unlock;
+			}
 			/* If underlying shared umem was created without Tx
 			 * ring, allocate Tx descs array that Tx batching API
 			 * utilizes
@@ -1387,6 +1431,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
 			if (xs->tx && !xs->pool->tx_descs) {
 				err = xp_alloc_tx_descs(xs->pool, xs);
 				if (err) {
+					xsk_clear_local_cq(xs);
 					xp_put_pool(xs->pool);
 					xs->pool = NULL;
 					sockfd_put(sock);
@@ -1409,8 +1454,16 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
 			goto out_unlock;
 		}
 
+		err = xsk_init_local_cq(xs);
+		if (err) {
+			xp_destroy(xs->pool);
+			xs->pool = NULL;
+			goto out_unlock;
+		}
+
 		err = xp_assign_dev(xs->pool, dev, qid, flags);
 		if (err) {
+			xsk_clear_local_cq(xs);
 			xp_destroy(xs->pool);
 			xs->pool = NULL;
 			goto out_unlock;
@@ -1836,6 +1889,7 @@ static void xsk_destruct(struct sock *sk)
 	if (!sock_flag(sk, SOCK_DEAD))
 		return;
 
+	xsk_clear_local_cq(xs);
 	if (!xp_put_pool(xs->pool))
 		xdp_put_umem(xs->umem, !xs->pool);
 }
-- 
2.41.3


