Return-Path: <bpf+bounces-76670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A69CC0A3C
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 03:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A85F93033DC7
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 02:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C7B2ECE98;
	Tue, 16 Dec 2025 02:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvYJNEWF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610EE2E5D32
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 02:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765853460; cv=none; b=lO5rA9y/MZ15qgxVFOSh4Xymw/kohntA1/RkGXLiAaX/rrDxbifJDykBPXAf+hQk06tByAw9es+ANu6JHC/MCtccFTFk8paM8j4FQVW1XJNCZ+hX8wQse6keNxVlEPQgVbccwxAmQFbeCJFD+FT7Fz6QqzB0dOx8Hh+iwJSAfjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765853460; c=relaxed/simple;
	bh=687vFU+Ac3ElVt5OfIK9YxqFBQwJpgACGGszq/z+ks0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qHw427yjXMaqM4laOEUIre1C0jeNkO5Ds0mKD+VwfQV8Y/+Op0N+ZVI/ozp9KfthtWGFCwYmYSoPtXUbQ6oaVtJDPGvjqRfFl15+azK40ACTw1etLMvyrwWiXogU4zAviUU9fiUwReHQBM7P6Dyor9tatJ4uzkwhSlIakuyS1w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvYJNEWF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a099233e8dso21889425ad.3
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 18:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765853459; x=1766458259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qw/KQU3zYxL/kw3hU57BvEqlVos5RIoPuX74COM6oHw=;
        b=DvYJNEWF9EBU9LHgpQGlOX19u2Y7dclaA1JW/Ybo6ju6UYXuWmmCE/nREwfcJF7MxC
         d3h+gYPSBZfPDM4DSsWzpqWJ4DQfXtI2YBRzpdi672FVP6WwkEMrOS5B/MO0mPoZIvzw
         QiWWijE/gzzd5LR0pEygIv/gidUe+dfIkefyeIjvRnwEnt9PL+lAq8OlDyVTo0zLAB2T
         I1dxtv+lPh1QFwyp8EcCiaHPBq5RTYasNXJXckMa1XgBNZKL/1qh3zY6j8Uu+sTS3WnC
         EpR7TpZ+B/BiNJSQGpV55rVaLSnDzpo2pBGadILO4Rwvb8j6t5l+gy3/x86ggkpr50Ff
         2NZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765853459; x=1766458259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qw/KQU3zYxL/kw3hU57BvEqlVos5RIoPuX74COM6oHw=;
        b=wuYiyCfp+TPWmHBroXRsVsxdFlBhNeePGZEE9v4uNENRP23BtdsUbpvFMyhQqUXtXf
         +HCDwOeVOh9KpEnuE+obsh0P8w0vnsB0lwpCxi1G4tlL7xZgzUqqCTmiBoa0P9jO/oyl
         5raEkS0nooJTC96Pj7S8pA8a+Sbs6BW+rzQ2YrthexOOMEFim8hxQUYi52MMROa49ac9
         wBkRO/FOo0RlFlkY9ivw9VGwszQDAGUBV/TSs5Tc1ndxijVBdfIj+mOsVmdi0NHtigNw
         NICPt5Zi67wNk7bDIo7xoYpbX71Pizs4zuuYI+OOCRm7RzkQg6dDOs3gkyk3I3NGV6iW
         3SwA==
X-Gm-Message-State: AOJu0Yz4AL/dz4ZY8HmPqRZV3HYB/nK/VqfG34MbNSwgPj52oqctC60x
	uthcMzcDFtZ7Y8wdF+iKpWaIcp5Q0qfs5HufnfKv8Wf+Mv34NaAQCZMr
X-Gm-Gg: AY/fxX7fh88qqvLUdgWDdQD+MareLJQTa1JnVMw0PPi0yOh9onTtffrDgeQbcHEDARM
	nbOtqNq6PU3MYx9YYpuKvmTvBFgGJndhSYtgjQkfu0Vr/R5SwbqcCR+G5N2BvNaRxUftCyGjrCF
	HaRuWM2H3YByvjr8Xp9fcqKp1QY8ORjUs1eranQwKBXTnB7eXVS2FmEEwsgdM2iDsVDV/Kfp3lT
	93pLelvlcSdIIzyFz+VO2UdBr4WRP1EMdpSGpdIymYVc1eWdKTudMQ/XV4CqefKc1QcoUT5cWMc
	m0dAoT6CaTZp3FdBjkApEQ9phngcnQbSs/islUCy9r9omE50e3VtP4bEkgP2gNauZih89vpP9DU
	zknZZSyEIbCzy0NGB6MF1+bv1epkmwA7Lh8fsKHM7EB7Yb1BAW3/qjGdMW6sT5RtpmrBqDYdN/a
	I2L7unOLEPdT349H+KBE3yLI02IDciLUfBsHxoOQQSH8tPgF14g+WOKptH2A==
X-Google-Smtp-Source: AGHT+IEaoSm+OKqqJgV+DMYv2UvEnK350dHJKs3Ad9dYQgUagIWFtnkGfaK0nKfUYDZ7WgGjEXI4qQ==
X-Received: by 2002:a17:903:2cc:b0:29e:c2dd:85ea with SMTP id d9443c01a7336-29f23dd7ed4mr109046265ad.11.1765853458484;
        Mon, 15 Dec 2025 18:50:58 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a13cd7f1ecsm2618865ad.74.2025.12.15.18.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 18:50:58 -0800 (PST)
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
Subject: [PATCH RFC net-next v5 1/2] xsk: advance cq/fq check when shared umem is used
Date: Tue, 16 Dec 2025 10:50:46 +0800
Message-Id: <20251216025047.67553-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251216025047.67553-1-kerneljasonxing@gmail.com>
References: <20251216025047.67553-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

In the shared umem mode with different queues or devices, either
uninitialized cq or fq is not allowed which was previously done in
xp_assign_dev_shared(). The patch advances the check at the beginning
so that 1) we can avoid a few memory allocation and stuff if cq or fq
is NULL, 2) it can be regarded as preparation for the next patch in
the series.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c           | 7 +++++++
 net/xdp/xsk_buff_pool.c | 4 ----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f093c3453f64..3c52fafae47c 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1349,6 +1349,13 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
 		}
 
 		if (umem_xs->queue_id != qid || umem_xs->dev != dev) {
+			/* One fill and completion ring required for each queue id. */
+			if (!xsk_validate_queues(xs)) {
+				err = -EINVAL;
+				sockfd_put(sock);
+				goto out_unlock;
+			}
+
 			/* Share the umem with another socket on another qid
 			 * and/or device.
 			 */
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 51526034c42a..6bf84316e2ad 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -247,10 +247,6 @@ int xp_assign_dev_shared(struct xsk_buff_pool *pool, struct xdp_sock *umem_xs,
 	u16 flags;
 	struct xdp_umem *umem = umem_xs->umem;
 
-	/* One fill and completion ring required for each queue id. */
-	if (!pool->fq || !pool->cq)
-		return -EINVAL;
-
 	flags = umem->zc ? XDP_ZEROCOPY : XDP_COPY;
 	if (umem_xs->pool->uses_need_wakeup)
 		flags |= XDP_USE_NEED_WAKEUP;
-- 
2.41.3


