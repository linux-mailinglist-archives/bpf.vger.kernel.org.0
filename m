Return-Path: <bpf+bounces-71572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B39BF6B41
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 15:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE7E03B600B
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 13:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5885337BA2;
	Tue, 21 Oct 2025 13:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOd8hT8P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43308335089
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 13:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052376; cv=none; b=dZWOAQPHFT2/8soQnpa4lhQYlwidLZpbroQDLXR7V7ci++fsYtLTyl4wX1TLylTaLMx1cCkWgOJUTkAGW/jJ7EFDGoNyROoVo1dGoTK0asa1qt5J4C3z8pRx446z0RIBkuHHWujDDTNEZb3g5EGN1z1JHQghx8i8uS8TWNxiQNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052376; c=relaxed/simple;
	bh=XV21u0o1UkZ+p4SG4ifSb/1NsJU2+4TPwZ/wKgidg9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NSSKhIGkkDDB+Zi/dnRewhaVqRVLretHc3X6WQyBC85tMae4YyoFPqiqO+dUuFc6afKkwFrUvzppK4TckWHYfK6XaXalSkQ0cWueVPplbriuPm13P0C/qR35Mk7NsFkYrw4AemYUZC5zywNUUaQbyF+v/BW5PVjvypnBkG2Iu4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOd8hT8P; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27ee41e0798so88634575ad.1
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 06:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761052373; x=1761657173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GWp0OdfmGSSPSvRPpG1fQFRxJdjlWQ03bu+3XaH0mY=;
        b=dOd8hT8PjQN9mr095IScPRjpkydZo4/CEvbRYBQX0hmqEiWQrXRlhbGhswXC3K/VsO
         sY6qZwAj18EdyKPZ8MJeqAex6323FgcMYk57MmatXFsO9DGbmaKepOl1B99SKj+G0gsD
         W+2eblDGb5s0VZfF7Xyn0U8ulL4SI1BvtMQtWPlDKl9LSMgdgV2dGsH0D05jDQXZQh+Y
         UgdSnZruzmTohOin45EinXrga0pMOmZ0OSrszvuKU595Y84oplbWOP7jelwRf2EkLW5o
         IQAgQ7ZQw9nTlRVNK03phzIfWbQrlgssQtb45QRz5MFow3Zitkce4Rg/i9MQ89uYWPnf
         gwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761052373; x=1761657173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GWp0OdfmGSSPSvRPpG1fQFRxJdjlWQ03bu+3XaH0mY=;
        b=EDxVzcmqgfchfkyJFjo+xfGoJwYCqbV/ol+ppi3I/+8SCwtaeDwDFggc12KpB7JYQY
         Ke3G3JBFZU+LaBn/kbDaHHhHkRAFSI0Fwhf+0PB+d90NlcWg+lKKn9nLSJFda01yLqau
         01/n9sZMAadgE38BafnDpR5VaM2wSQ2eXKQYkngiblyhmulA7h0G8ivSvRTWSqwrOxRC
         g6NFwBjSHSQ8ZXVtaFTPpBMvSMY/e3Adkwd7ao1uf5DtoWCROpK2cHzzbWxlI9AxCbZ/
         X0D8G+AnV4nRTzQT/Qdyzcb4rxszjbgef058N6qHZZSVKsjltMa4oi+hVxlnEHXC3AdO
         YRBw==
X-Gm-Message-State: AOJu0Ywv8Bg4npqbiRKi2Iyy13iJb0acugkYIukT49mMaaDyBkxs3Elr
	Umdrh/d2cKosDhSmdfeopwKePIRXhBHlfKIvf/Aj1pnJ4lBxZ3WqbG+D
X-Gm-Gg: ASbGncvW6D3vkBK5Rwvlx5T8ih7bqole/SHmgIQuu794v1GJnS2aVq+/4P1JI/FN6cH
	37/wWdu0NGE1oXwRrOFNxHKDo6vHNztmBB4GdkWweAn69mbxfvO0N6VQjR7+I6haPBmdppHw6gA
	sRvOm5vcBJgOz1trY2r4adx4cO7VSnnvl5shW/T20Sxv/OH9m/MB07ns7t2e3pnYHjUdqKZddYX
	x7KWy2+xgFRmNvOU3te2nCH5E9LvGWODNgzVxUbhJx5rBQr3TEyQAWHhg9RwivFqfJxrRMo2QyA
	27FFUJ8mpkGwBxyOEgPw204xwgYQwxuJX+td/t/BOU7F8dgqEVYyWKwmQKnFtOX4JNP+52XjZCY
	cBeg5grOXLbqYz4pHlqRKTRYFn4f0SYtn7tC4QXaUgFDJ2aFX14JCLoXErns/4GhvWLx+1KNyfY
	obWuU14chhJeFYQ40IefDf8b6p6nmjZHgXwwgYy+0pj+8mlRA=
X-Google-Smtp-Source: AGHT+IHz7PPIn6WpcJnf0x8j9af9ACfhUzxhHdjR5t5W79Y7Grn/3zWUmVDFNk1/IgZQS3aQUA1F5A==
X-Received: by 2002:a17:902:ccc8:b0:27e:f201:ec94 with SMTP id d9443c01a7336-290c9d1c446mr225901315ad.18.1761052373383;
        Tue, 21 Oct 2025 06:12:53 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fd9ddsm109248175ad.89.2025.10.21.06.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:12:53 -0700 (PDT)
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
Subject: [PATCH net-next v3 8/9] xsk: support generic batch xmit in copy mode
Date: Tue, 21 Oct 2025 21:12:08 +0800
Message-Id: <20251021131209.41491-9-kerneljasonxing@gmail.com>
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

- Move xs->mutex into xsk_generic_xmit to prevent race condition when
  application manipulates generic_xmit_batch simultaneously.
- Enable batch xmit eventually.

Make the whole feature work eventually.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 1fa099653b7d..3741071c68fd 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -891,8 +891,6 @@ static int __xsk_generic_xmit_batch(struct xdp_sock *xs)
 	struct sk_buff *skb;
 	int err = 0;
 
-	mutex_lock(&xs->mutex);
-
 	/* Since we dropped the RCU read lock, the socket state might have changed. */
 	if (unlikely(!xsk_is_bound(xs))) {
 		err = -ENXIO;
@@ -982,21 +980,17 @@ static int __xsk_generic_xmit_batch(struct xdp_sock *xs)
 	if (sent_frame)
 		__xsk_tx_release(xs);
 
-	mutex_unlock(&xs->mutex);
 	return err;
 }
 
-static int __xsk_generic_xmit(struct sock *sk)
+static int __xsk_generic_xmit(struct xdp_sock *xs)
 {
-	struct xdp_sock *xs = xdp_sk(sk);
 	bool sent_frame = false;
 	struct xdp_desc desc;
 	struct sk_buff *skb;
 	u32 max_batch;
 	int err = 0;
 
-	mutex_lock(&xs->mutex);
-
 	/* Since we dropped the RCU read lock, the socket state might have changed. */
 	if (unlikely(!xsk_is_bound(xs))) {
 		err = -ENXIO;
@@ -1071,17 +1065,22 @@ static int __xsk_generic_xmit(struct sock *sk)
 	if (sent_frame)
 		__xsk_tx_release(xs);
 
-	mutex_unlock(&xs->mutex);
 	return err;
 }
 
 static int xsk_generic_xmit(struct sock *sk)
 {
+	struct xdp_sock *xs = xdp_sk(sk);
 	int ret;
 
 	/* Drop the RCU lock since the SKB path might sleep. */
 	rcu_read_unlock();
-	ret = __xsk_generic_xmit(sk);
+	mutex_lock(&xs->mutex);
+	if (xs->batch.generic_xmit_batch)
+		ret = __xsk_generic_xmit_batch(xs);
+	else
+		ret = __xsk_generic_xmit(xs);
+	mutex_unlock(&xs->mutex);
 	/* Reaquire RCU lock before going into common code. */
 	rcu_read_lock();
 
-- 
2.41.3


