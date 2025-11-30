Return-Path: <bpf+bounces-75790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16511C956DE
	for <lists+bpf@lfdr.de>; Mon, 01 Dec 2025 00:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD233A2FCD
	for <lists+bpf@lfdr.de>; Sun, 30 Nov 2025 23:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF88302160;
	Sun, 30 Nov 2025 23:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+0soFpq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9C72FE072
	for <bpf@vger.kernel.org>; Sun, 30 Nov 2025 23:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764545747; cv=none; b=qp485ePMEo+5XSzAdqjBrwgCA3JxiKEKXOrrNMMQrAY4MbTZR4X76/VbXfqaWyY3KN0PCtBGpgrzV7MA7TN3SX0J0X38/EHPOnZ1SvGmUjSgYdhLF4FITuYf6RXUzq5PEZobBoPdNi/yds/6Crgzon4Y38Yh4qjdnvwn9aBB4Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764545747; c=relaxed/simple;
	bh=yKCm3JWX46w3TSeS1HDjGDEN8Lb+RgGnnDzf1hIzpyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=puvO5ad1KbVqf6JrmzEgT/66N3tC22CWYMq8mccZgdXlLYDtOE3CzVbUnQddTEPYjWE1tI7LTes8OFhwIEeYDTZeqKAM6mixNGqZqiZOuLQhXW6fSg8NnW0FQrhRb+/dIYY0PgLeU/5Yv7AV8qYsasyShSbaWHH3m3tkGsoWvbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+0soFpq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so41966085e9.2
        for <bpf@vger.kernel.org>; Sun, 30 Nov 2025 15:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764545743; x=1765150543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HX9L7y9TUVKUZMrEe/EUsMICdbihgCRR79vdhXFo/qA=;
        b=N+0soFpqHul603HIj5zHoSIfWc5W9GiN6vklkHMVCs+W4/neQtP3pzS0yfITiq28bG
         1izqBmz0Vq+fFKQ90rZEKWfeAmlDKPBAVTfnKXldC1ZylLjyioNEh0rQ6vIW6bjHxWwb
         dXc16NPNkz+eQ3kl80Ti+ATMzdbzHq/OZvtcgJ0eCzm3zsHw6eedbvvEogje1iB8l+oI
         inpqFusTXLkC/LWcYbmtLwuFDBKMJ/1tXQRoaDHMXWgrEEoHrkJjEig8DI316DClAjP5
         5iNp8pL5Ib8wkKyjZvbfl27mruFlb4/Lv1r3nw4lqegb/2efQpLsdF6pEzuG6v8b2Pwv
         13Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764545743; x=1765150543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HX9L7y9TUVKUZMrEe/EUsMICdbihgCRR79vdhXFo/qA=;
        b=P2mQ+dc5cf/SmmjhR4chTDWUH5nBaH5ah/lITOqm93qI43aJwDZLqehfpOxyTtu86z
         a1nYc3lixbpiUpLyEOurYE5hsa3N/r86TGMfDuKQbU8m5YhZN63RtJD+KX43QB0Ac0Yr
         HMgNkBZlC0vTRibsYdmL0WRqTiNPYB/VI6MPtgytNkBY9kYz1/eSFEMAiYZuN43dIW7v
         yQUyPbWiFXh5IjjGf8GpYklUSk91veBWzkkhsaIfEgf9RldA9Z4m6hluVHJt1mtV97cU
         0pwBicFfJ2l8r5UyOtk3F+lmKIvTW9nd0C7w8UoxmtFIIx4ViGwEZpR47m0YxyEOux6x
         Nrmg==
X-Forwarded-Encrypted: i=1; AJvYcCV+jjduQq5XvqZyEfffPKOxZbRs2KLLX9WKpWUhUmgfZE1O7jvDdwCHPItb2Ws4eT+vwJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6gjYsz2RYClAHK80dq52doPJ3urRd8KE5G0Yp9jPf09XDHNIv
	CYq4vSRNg+DiqKA6xPv69FCx1GsNTmaqzOgDOf5jIF5+b6y57UgoJN6J
X-Gm-Gg: ASbGncuDhR8ChMqOZ5Pd2VQL2ja/fb9hlIMZ0msPL7HjcnMAlTD9I5qt179NJHK5bcp
	Sxw6u1f02ZS5I9IHsCh/ndUTudjcr04ug4bPKgP+2/Vgco4zNA/oDg6pej12i5+C9GEXKWHU04Q
	v+kUuB6+fMUrznYHOAXX/5DxeVlqfPXTx1AgvPV0jmU46Cz6aAqZYSwdYIngM6en5SWt2vsevSw
	PZUk/V9n64f/7v6VrtT2Are69tS7EZh7PUi2YCyZiCsl4KYyVVZHrvP2Tyb/ICEcPzgHYPh/nnH
	5pzayhpRU06zpNWIHwL3PPLLBUx0E+RyRPbxRUpyDJGe8DRMPiR1FEbxL2pqyOH3rBcbzoxiDso
	esWOeX6sfE9IO4RHnjssicp6W4AsXYyTo6wkKgpQ6KTyfYZPjdsMPebNUSstNTn5/RVlTRmWrH3
	kSlaZcg+QDPpHYTA51yKDsD+YXwh1OfjyA9MiHRsk4wvwg7i0pjf/y4NDry2VU1OPZVXlK3UnyP
	+MPbno2YHEvkXhw
X-Google-Smtp-Source: AGHT+IEXud9v2I+TjLUDj/xk+alqLhuWUdH7fEpxpL99N2ZrU2hz5Df/0YCDMBC9pg3l3cG4o9WBpg==
X-Received: by 2002:a05:600c:4e91:b0:477:7a95:b971 with SMTP id 5b1f17b1804b1-47904b2c3dfmr250016755e9.31.1764545742979;
        Sun, 30 Nov 2025 15:35:42 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479040b3092sm142722075e9.1.2025.11.30.15.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 15:35:42 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Yue Haibing <yuehaibing@huawei.com>,
	David Wei <dw@davidwei.uk>,
	Haiyue Wang <haiyuewa@163.com>,
	Jens Axboe <axboe@kernel.dk>,
	Joe Damato <jdamato@fastly.com>,
	Simon Horman <horms@kernel.org>,
	Vishwanath Seshagiri <vishs@fb.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	io-uring@vger.kernel.org,
	dtatulea@nvidia.com
Subject: [PATCH net-next v7 7/9] eth: bnxt: allow providers to set rx buf size
Date: Sun, 30 Nov 2025 23:35:22 +0000
Message-ID: <95566e5d1b75abcaefe3dca9a52015c2b5f04933.1764542851.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764542851.git.asml.silence@gmail.com>
References: <cover.1764542851.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement NDO_QUEUE_RX_BUF_SIZE and take the rx buf size from the memory
providers.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 34 +++++++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  1 +
 2 files changed, 35 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e9840165c7d0..0eff527c267b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15932,16 +15932,46 @@ static const struct netdev_stat_ops bnxt_stat_ops = {
 	.get_base_stats		= bnxt_get_base_stats,
 };
 
+static ssize_t bnxt_get_rx_buf_size(struct bnxt *bp, int rxq_idx)
+{
+	struct netdev_rx_queue *rxq = __netif_get_rx_queue(bp->dev, rxq_idx);
+	size_t rx_buf_size;
+
+	rx_buf_size = rxq->mp_params.rx_buf_len;
+	if (!rx_buf_size)
+		return BNXT_RX_PAGE_SIZE;
+
+	/* Older chips need MSS calc so rx_buf_len is not supported,
+	 * but we don't set queue ops for them so we should never get here.
+	 */
+	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
+		return -EINVAL;
+
+	if (!is_power_of_2(rx_buf_size))
+		return -ERANGE;
+
+	if (rx_buf_size < BNXT_RX_PAGE_SIZE ||
+	    rx_buf_size > BNXT_MAX_RX_PAGE_SIZE)
+		return -ERANGE;
+
+	return rx_buf_size;
+}
+
 static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 {
 	struct bnxt_rx_ring_info *rxr, *clone;
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_ring_struct *ring;
+	ssize_t rx_buf_size;
 	int rc;
 
 	if (!bp->rx_ring)
 		return -ENETDOWN;
 
+	rx_buf_size = bnxt_get_rx_buf_size(bp, idx);
+	if (rx_buf_size < 0)
+		return rx_buf_size;
+
 	rxr = &bp->rx_ring[idx];
 	clone = qmem;
 	memcpy(clone, rxr, sizeof(*rxr));
@@ -15953,6 +15983,7 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 	clone->rx_sw_agg_prod = 0;
 	clone->rx_next_cons = 0;
 	clone->need_head_pool = false;
+	clone->rx_page_size = rx_buf_size;
 
 	rc = bnxt_alloc_rx_page_pool(bp, clone, rxr->page_pool->p.nid);
 	if (rc)
@@ -16079,6 +16110,8 @@ static void bnxt_copy_rx_ring(struct bnxt *bp,
 	src_ring = &src->rx_agg_ring_struct;
 	src_rmem = &src_ring->ring_mem;
 
+	dst->rx_page_size = src->rx_page_size;
+
 	WARN_ON(dst_rmem->nr_pages != src_rmem->nr_pages);
 	WARN_ON(dst_rmem->page_size != src_rmem->page_size);
 	WARN_ON(dst_rmem->flags != src_rmem->flags);
@@ -16231,6 +16264,7 @@ static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops = {
 	.ndo_queue_mem_free	= bnxt_queue_mem_free,
 	.ndo_queue_start	= bnxt_queue_start,
 	.ndo_queue_stop		= bnxt_queue_stop,
+	.supported_params	= NDO_QUEUE_RX_BUF_SIZE,
 };
 
 static void bnxt_remove_one(struct pci_dev *pdev)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 4c880a9fba92..d245eefbbdda 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -760,6 +760,7 @@ struct nqe_cn {
 #endif
 
 #define BNXT_RX_PAGE_SIZE (1 << BNXT_RX_PAGE_SHIFT)
+#define BNXT_MAX_RX_PAGE_SIZE BIT(15)
 
 #define BNXT_MAX_MTU		9500
 
-- 
2.52.0


