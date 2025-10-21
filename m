Return-Path: <bpf+bounces-71566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 127BFBF6AFF
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 15:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 003DD502D8B
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 13:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A5D336EC5;
	Tue, 21 Oct 2025 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcsqL+/D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34341096F
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052348; cv=none; b=tH572Sh/iPGkmLVrgfjluWhxeMWlLKo+htlWaBbx8YkqggaDzk6txrLID4F02a1OaEepDSJR5c/9V0PHo5YG0sMPeXJGSd0wydxmjanw1joO5c1OAwNTrDNNslgHkKR/uBQl3IPIQtMwxALBwkCmkr+nhV14paDsQopnkYF5gDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052348; c=relaxed/simple;
	bh=OalRNjUbwogRdEZGkYjFYCPbwuw+lvhcwqs4I3EUtkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JXe5LQ8BACZ1pay/liG9H8blXhL2/w8JRA8EBNBfpHxLrQnf0eOip8SJhMhDlB7RgUqCygX+TCGQ0HeXHpO1eBKgIoEA3zkuwi0o3trO4jfLhSS/6PBSgaXrV4PGZ7lwm1ya8nxQUsbO7o9DGNzuGx/PcD8ILGHxwDKlzXcq80k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcsqL+/D; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7811fa91774so4926883b3a.0
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 06:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761052346; x=1761657146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfT6R8DUz6iGvUEZdMZ9t6TvFyv6jslwQUFkkPxFNUU=;
        b=BcsqL+/D+tGMQpP10bzCTIltncDtRf40YD4ZAqccrJ9oK2W2/hruG9elp4+sQgH3nX
         qDrmJ8X4Va+3EqKHoE8/kZ6r3WfnF/76IiE2xMcAXRqECSu/9yUrW8rxxa/bw729xf66
         IWZNLigBfiJoe3hDmJo8Zj/Hr1phtk4zlUS0j+K1JaHq6vOxOCCr9td5m2BitcdSufjZ
         U1CmqQATZV3udSSi4K6x/PikQXj7YIWJBae9XcVqrxMbpr9F6r7LtLxXeqWavTs2xvVR
         clSQbeC/+ggBzx+zC0kc1StdGVjyYEh+ZEFdbNNCUPeKy182fF2Im+K4I9dTrVp3Cm4T
         irQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761052346; x=1761657146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfT6R8DUz6iGvUEZdMZ9t6TvFyv6jslwQUFkkPxFNUU=;
        b=vzcuBMnEdQkCxek0tQVr58RIA71tczmuOy9HJ1QCYchn9yB1sPueYUw0d9RwS6nBWk
         Lyyz9E3RH+RvYjNMvmRo+DHkemnxOW3niWKy+3kq8kcw00AKscqvTyxUadzd5Dq9mUkO
         1pJrKr5hcxIaAFSrNK62IKs194ruK+O1YQcQ+En9UOnAz6Y4V4znMtoYagkYrRaM2JHC
         3r+f5wFD1zS/RDX7PmNXZxRNQpU+8esdprdD5ylDQ/wjm0q77C5+xIw6yDZtVQSJL794
         DoTykTowZldaUVob04KLkJexDgQl/rCsnt+TMobb5jXPmyrNFCh/V4n6Hjv5eAMO8EK/
         YZdg==
X-Gm-Message-State: AOJu0Yw2xKmdx5EL3d7uINv+ujYYv3WRtuzOLQiQTHylGtcorV+fGKcy
	Ng78afvND9qqjLID0m9Ic10TlhjG57W/ZQc/opGDSozzeP+a65G1b/1P
X-Gm-Gg: ASbGncsrlGx7zTM+bqOXRIX+/8n+V3QqOa6+lh6c49PgeHdzm94bghhwMbVeYyoAugt
	+neFQphcu3BlggV7piqVL7sT+w+4RoTAej28GcGeq19Al5k1erXCaRbSMRS3uueiZgDowRw7hvV
	1YqqssZd426KjTcGkIdbRbmlm0RrGF3ERNLvvpDHRev6DUXZgUgk4yQuznFli6A+CewJRXbFf+7
	GQgEqu6R3JmM3l/CvJWO1K2WREfSaBzWtYkuCLfIzs6BQ28TXx8Z1Zq+lw3aArK5qpC2RKru30w
	AScIZZ7hU10ypu8NR+zq51C5zLq3izqpRnt750KvrNlvjStbG0pMlSHOCm5Uabk/C1k0U/JS0P7
	PpkIF9MaHh/a78e+AdxFqSc2DGA/MHkdKzKd6i42CiBio0jmwsu2BLQNkc3OZQfzMmyZwJzqZV9
	RqcUtq4lg9vw1yXno6m8ofhVtbmWKd2TCLuDXdXNBohRarH3mkm1udUd6YA47ODuJLMN2i
X-Google-Smtp-Source: AGHT+IHHHL9U+nD1VYobHrqUIbr9Ge8ylqi/izQYBJI4A4Bi6BhEpKUifMO+u2HRQOt/Dz66Z0TaAg==
X-Received: by 2002:a17:902:d2c6:b0:290:c0d7:237e with SMTP id d9443c01a7336-290caf831cdmr243944045ad.39.1761052346173;
        Tue, 21 Oct 2025 06:12:26 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fd9ddsm109248175ad.89.2025.10.21.06.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:12:25 -0700 (PDT)
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
	john.fastabend@gmail.com,
	joe@dama.to,
	willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 2/9] xsk: extend xsk_build_skb() to support passing an already allocated skb
Date: Tue, 21 Oct 2025 21:12:02 +0800
Message-Id: <20251021131209.41491-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251021131209.41491-1-kerneljasonxing@gmail.com>
References: <20251021131209.41491-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

To avoid reinvent the wheel, the patch provides a way to let batch
feature to reuse xsk_build_skb() as the rest process of the whole
initialization just after the skb is allocated.

The original xsk_build_skb() itself allocates a new skb by calling
sock_alloc_send_skb whether in copy mode or zerocopy mode. Add a new
parameter allocated skb to let other callers to pass an already
allocated skb to support later xmit batch feature. It replaces the
previous allocation of memory function with a bulk one.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xdp_sock.h |  3 +++
 net/xdp/xsk.c          | 23 ++++++++++++++++-------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index f33f1e7dcea2..8944f4782eb6 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -127,6 +127,9 @@ struct xsk_tx_metadata_ops {
 	void	(*tmo_request_launch_time)(u64 launch_time, void *priv);
 };
 
+struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
+			      struct sk_buff *allocated_skb,
+			      struct xdp_desc *desc);
 #ifdef CONFIG_XDP_SOCKETS
 
 int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index ace91800c447..f9458347ff7b 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -697,6 +697,7 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 }
 
 static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
+					      struct sk_buff *allocated_skb,
 					      struct xdp_desc *desc)
 {
 	struct xsk_buff_pool *pool = xs->pool;
@@ -714,7 +715,10 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 	if (!skb) {
 		hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(xs->dev->needed_headroom));
 
-		skb = sock_alloc_send_skb(&xs->sk, hr, 1, &err);
+		if (!allocated_skb)
+			skb = sock_alloc_send_skb(&xs->sk, hr, 1, &err);
+		else
+			skb = allocated_skb;
 		if (unlikely(!skb))
 			return ERR_PTR(err);
 
@@ -769,15 +773,16 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 	return skb;
 }
 
-static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
-				     struct xdp_desc *desc)
+struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
+			      struct sk_buff *allocated_skb,
+			      struct xdp_desc *desc)
 {
 	struct net_device *dev = xs->dev;
 	struct sk_buff *skb = xs->skb;
 	int err;
 
 	if (dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
-		skb = xsk_build_skb_zerocopy(xs, desc);
+		skb = xsk_build_skb_zerocopy(xs, allocated_skb, desc);
 		if (IS_ERR(skb)) {
 			err = PTR_ERR(skb);
 			skb = NULL;
@@ -792,8 +797,12 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 		if (!skb) {
 			hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom));
-			tr = dev->needed_tailroom;
-			skb = sock_alloc_send_skb(&xs->sk, hr + len + tr, 1, &err);
+			if (!allocated_skb) {
+				tr = dev->needed_tailroom;
+				skb = sock_alloc_send_skb(&xs->sk, hr + len + tr, 1, &err);
+			} else {
+				skb = allocated_skb;
+			}
 			if (unlikely(!skb))
 				goto free_err;
 
@@ -906,7 +915,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 			goto out;
 		}
 
-		skb = xsk_build_skb(xs, &desc);
+		skb = xsk_build_skb(xs, NULL, &desc);
 		if (IS_ERR(skb)) {
 			err = PTR_ERR(skb);
 			if (err != -EOVERFLOW)
-- 
2.41.3


