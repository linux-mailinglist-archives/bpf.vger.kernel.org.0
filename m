Return-Path: <bpf+bounces-63829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F4CB0B487
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 11:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8D317997D
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 09:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DD11EDA3A;
	Sun, 20 Jul 2025 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdzwQYyC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483141E520C;
	Sun, 20 Jul 2025 09:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753002709; cv=none; b=KPnCxdJDd2TcrBqjSriEkBh61wCNLuzCk4RykXaHald3zMFpoOPSvZ+9KNyyjskkNneZpBmG33hXYTzRlbYP6LvutdMTovDSPSkmqEvg8Z5wOcqGilBmWMnYQ2npbGZA0+mnD058XX6kDqBHe9V6TRzyYDyaSx7R4Qkshd5t20I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753002709; c=relaxed/simple;
	bh=c+3narHnZorj4My5QLVAzIE2WB1tt9M5m95t3zaHXAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d8uy1j8MX2C1XxyQ+jzfXI+7BdtCWJp7tRHiFfIWMiXlijOdEKlzmZLt941lcWf5ZmoII6QlxKRAO8jhFAd9TjLNelAxsJocOW5wT8ytp7x/yGgzwuE9MJqgxcReywgkAagijDVH6F3BzHla1+Hy6oexxsHOgDu1tvsiguEL7aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdzwQYyC; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-74931666cbcso2869945b3a.0;
        Sun, 20 Jul 2025 02:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753002707; x=1753607507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XweBJ/0MYVVQb+Ps7XFsEfRMQO+tmpbLCmT+yp+uezc=;
        b=gdzwQYyCQ0zvmVdz7zWDkmy6Mdv6mjnB31k9Eq7/lbXwe/cqnmdo4Pl6mQMT6Ngef1
         IgL63uW4LKmHw323K0uPvWBlTSvj39f+FyktKG/68NBraW3BsQgpd43Uw0NdGJoXJ1jQ
         m2BZkdbxyl9L/AN1YE1EmDzaNFctCETVjwPI0d7UG0LYC1KQC/XOdCHQDu1JgmY5QQzb
         qDTclfCODflT8++tFAiu0D07b8Iy4GUva3LmoMcpybR7xCb98jR5GCRurUrq9HIVSL6Z
         9/bZyoqk50UMC8IlWW0TUc/+NJ7UqDZVnD94Vtks6rxibA/HCU1JNtGFJSGxhbWsTJrm
         BPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753002707; x=1753607507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XweBJ/0MYVVQb+Ps7XFsEfRMQO+tmpbLCmT+yp+uezc=;
        b=RmaNrenq9Y1E0LvDFROdfefDCMEpUw6SCimztgdVZsPzAIUi/Q72F/vgWcS1/F6mgz
         ggjr1dg1WJtMsPMflGelHwINaTE7d1mEgPYnqdXUuFhjDYKgDT6o1gsU9MLOvPyweAAG
         pMQddHRjJnH6r0Sv+drZ8goVsZfp8U98ogq8e0oNNj3oJkamnmxq93yHrzGtd/NM9LZc
         Os/c/mKeQfaTM5KVWCbqbklfm4SV0d4n+nZtitpm9N502BfZh9lwJZwtyq/VdIQqPoGw
         /bJIstzlDL1GrOEOtsvluxzxUYuJzKm7lbjtGIePJO68aKVPafJedvmQB7yIsQ/wqvBs
         tjDA==
X-Forwarded-Encrypted: i=1; AJvYcCXW5yQscAjdp9lKnnTwZRARPnwo+Sc+nuiitksAf9qOzF63kc0nC6OfgzdrXNnrjtSeauUDoxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMVcs4cdXNvDRzmpZzVY/8I44rWuRzAiRF6aVCl/acEiPJpqKy
	8KAMNNpVCjaX0jDq17Uf4Zv2EKRHH8JZW26V84uC8sr5fvGT6zhVl8iv
X-Gm-Gg: ASbGnctgaTyAz4bvWpb592Cin39tydbm4nCNTdHjRqdo4y9dq1Um8gfAgel4TfJ9WwF
	oThQetcDUR88ntE34msTe+lzPYRFjk27k0DOXmkdyL6KYPcwA33e38TzaLkE+hHqC9PPf/9eRTS
	BKi5KYQ4g46v3kfmlP1JbrG0uOpZlSQAIhQvQeRl5G7eEMrvAh2HgZs8AKdhDJRy3TKEZLtiifm
	dzPWTnX8nHihwZ8reOg5wLrZHtSjBQofjQ1YI/kqa4cbHVbpLdT5/axghh5b69cdNCEfZ57DHi8
	cmTnVhGBQQIBFMBdukdU+AQ/Q19igqvnm/ER1xb9J83bjCXgD5iSeUHI71ILx1gwRE5fb9njT3l
	o0shjLusgDNconbMsb+Jl47SqXpzw37mU1oAWnGriDqFl2mhX+E0hBRGD7Eg=
X-Google-Smtp-Source: AGHT+IHorp1bRu9HtmMw6GlN9olv5TOncXRl5qHg8FrQc9eBehnphTLcYkb51Og0pTgG0T7xRZI0+w==
X-Received: by 2002:a05:6a00:1a8b:b0:74e:ac5b:17ff with SMTP id d2e1a72fcca58-7584aa4d084mr17167004b3a.13.1753002707459;
        Sun, 20 Jul 2025 02:11:47 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.24.59])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb76d53fsm3902585b3a.105.2025.07.20.02.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 02:11:47 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
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
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 3/5] ixgbe: xsk: use ixgbe_desc_unused as the budget in ixgbe_xmit_zc
Date: Sun, 20 Jul 2025 17:11:21 +0800
Message-Id: <20250720091123.474-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250720091123.474-1-kerneljasonxing@gmail.com>
References: <20250720091123.474-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

- Adjust ixgbe_desc_unused as the budget value.
- Avoid checking desc_unused over and over again in the loop.

The patch makes ixgbe follow i40e driver that was done in commit
1fd972ebe523 ("i40e: move check of full Tx ring to outside of send loop").
[ Note that the above i40e patch has problem when ixgbe_desc_unused(tx_ring)
returns zero. The zero value as the budget value means we don't have any
possible descs to be sent, so it should return true instead to tell the
napi poll not to launch another poll to handle tx packets. Even though
that patch behaves correctly by returning true in this case, it happens
because of the unexpected underflow of the budget. Taking the current
version of i40e_xmit_zc() as an example, it returns true as expected. ]
Hence, this patch adds a standalone if statement of zero budget in front
of ixgbe_xmit_zc() as explained before.

Use ixgbe_desc_unused to replace the original fixed budget with the number
of available slots in the Tx ring. It can gain some performance.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index a463c5ac9c7c..f3d3f5c1cdc7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -393,17 +393,14 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
 	struct xsk_buff_pool *pool = xdp_ring->xsk_pool;
 	union ixgbe_adv_tx_desc *tx_desc = NULL;
 	struct ixgbe_tx_buffer *tx_bi;
-	bool work_done = true;
 	struct xdp_desc desc;
 	dma_addr_t dma;
 	u32 cmd_type;
 
-	while (likely(budget)) {
-		if (unlikely(!ixgbe_desc_unused(xdp_ring))) {
-			work_done = false;
-			break;
-		}
+	if (!budget)
+		return true;
 
+	while (likely(budget)) {
 		if (!netif_carrier_ok(xdp_ring->netdev))
 			break;
 
@@ -442,7 +439,7 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
 		xsk_tx_release(pool);
 	}
 
-	return !!budget && work_done;
+	return !!budget;
 }
 
 static void ixgbe_clean_xdp_tx_buffer(struct ixgbe_ring *tx_ring,
@@ -505,7 +502,7 @@ bool ixgbe_clean_xdp_tx_irq(struct ixgbe_q_vector *q_vector,
 	if (xsk_uses_need_wakeup(pool))
 		xsk_set_tx_need_wakeup(pool);
 
-	return ixgbe_xmit_zc(tx_ring, q_vector->tx.work_limit);
+	return ixgbe_xmit_zc(tx_ring, ixgbe_desc_unused(tx_ring));
 }
 
 int ixgbe_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
-- 
2.41.3


