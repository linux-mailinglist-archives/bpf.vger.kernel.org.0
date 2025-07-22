Return-Path: <bpf+bounces-64050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A93A0B0DBC5
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 15:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC5B3AB32E
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 13:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4242EA73F;
	Tue, 22 Jul 2025 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M74FBv/0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87DC2EA736;
	Tue, 22 Jul 2025 13:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192287; cv=none; b=PKRNaZ0Ex1rF+QIiMqXkr+TB85sUla5vIf+0No4ceE0nTK8NWDTu6lLTCA7Xv6IZpvc+Fw4KBBYwJ9bFBR8FwHipVzdcHw5SRMhB7xjg/oJAJ2s1aUZdji3yN2GIzO2Yi915poVk+efzC6EQcsJ89LvEuAqjkvlb9Sv0h3USObw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192287; c=relaxed/simple;
	bh=tFJWlhfmfI8AfTvis7d0C1knNklVbnjQICQn1D6BqzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q5Lm18W4q54e+cHP/CznQc0Cn3vPhyR/rmMWCi8izxaZZjkCXjx3abqhp8F/4ZnUMeOlh/YXhMq73/700PkL6VK5dZeiJYTh/qd7WKPrCjchWfSc7oWQk/R3Um8wqzyMVqZYQbb2RZYejwCMPlHGqHtjFCh41ey40kf+sEVC6MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M74FBv/0; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-748d982e97cso4914118b3a.1;
        Tue, 22 Jul 2025 06:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753192285; x=1753797085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pD/wWijrKvVTR2o9RA6CvKO4pRLA1Dtb3qzUWgqM4ys=;
        b=M74FBv/0YTLjCIH5SXWSJEJMG1XsKU43nJUjHNeAxhZ7Rqk8jrNwHEhwxUPY194RU+
         m0TWnbIdtsTN8SWUMe+J5KIlY9tNZeaF/47TJgiR0Gmv1SulJe8xUvS945m0A+MPKb88
         QxYlvZV3H1raEzHyyxjjep8NG09qecX9G5qplV8We1FvF+DDJsgZh/5hM3Qm1yekkRf2
         vswLRB9tgXEZy3cgF7n9KgJv526bXh7Ql5y0vWLmol2w47pp0A3wDRmITbZYPzn9Cmh/
         uT1ai2gg7UWGGkKstoTJBkd21fNnjUeEMWtnUhLxvBzrOi6cablOQVCC9J2HTU6sHErr
         +qiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753192285; x=1753797085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pD/wWijrKvVTR2o9RA6CvKO4pRLA1Dtb3qzUWgqM4ys=;
        b=DZNwyi8124JtokFhMjPsN2wnvsype/LaT8wfYZipPaFQU15FP602rNLjYYyed2kuP5
         lPDSiWoQP60qOLgQaV9ehTFQVl9/d9RLbGEUHnkO7kUsLF3ECufa0tgUgblgDcA3AolC
         1RsGGRPI3U0PJowz9SzEMITc/+vqkfgsaKX7RSIu5rIsQNFnydcL6qc+yDO+Gs2xHlvd
         NijULIjrS8rmuw3AmYDzpXs0cE+E0zkBixqEaobpDzFpYbGfcC87z7UJT51Wp14fYqAF
         PP7eZUaBvRcx4mrpWm7HO3Ux3H2SoIjjZ/GV03T62KsJyaHk+lfxnMUHhx4QBE4rfdaS
         OR+A==
X-Forwarded-Encrypted: i=1; AJvYcCUWTCdLzTCMtynPizKCfzd2QH6U0s8GT0TFCSYNRh3FDrqoV/FaS899UTkFfqrug2RgY1cGpUOt@vger.kernel.org, AJvYcCWNw5SBCpknaCuDHzHTIomNri5Redpf7231JB+v56a5YpQm6NFuiDWJU4+jIwov/+bNiEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7s5IpW7Q0FvL0Wd6JcODBNkj36zOL6t9uuWltyW2fM9OfpoOE
	a6RRDBm7BBdxYz9cXWQVg67OCTCGOpfhe7XoL6jh0pn6aTO71ScnNCwh
X-Gm-Gg: ASbGnctoRUaW+apJgdUUtTaHEhA9mxayLtN2v6oQk/uOZCF6cs7KBkj3+gD3BSVgx5Q
	ImTpxVjQWKBK4VaCz21Ozb5GiYN43GTzlRVYNpRTn3j2XXTvrsdVhk5pDBM+ZidOlxLL0tM9nvX
	+dsVgRWP/JSzTe6YOhtS+inRwAZ2hMpLXq0Q1kzC4xBwWlmFHF2KiReAj0KudcBGhlpjsPWy+Ns
	hH2EhyZ3n56z3hLVIF04tJOuRDJ6YYUeT3SNTzKPc9SaMw9B87HaAxxkL4rugeGaU60RXBihzru
	Vz3e639tppZJRxsrI/Ci9a3j/I7VzRlIo1u/ce1yORtMt6LktDsHyQgmpVamQzVLA0oTQ4ysoXk
	BZlRmBTm0wa0NS2Xb0cc4VrYo7qfzVFsw2jaimlRkOGM5BfroLMvfvoRuOJs=
X-Google-Smtp-Source: AGHT+IHXWDumReUd0Q4eySHgoAYL7xXcdMWiTo0JJ05taBpvZ5tBQBZAd1EkCjnN//6RaGRS96p7Sw==
X-Received: by 2002:a05:6a00:1749:b0:747:aa79:e2f5 with SMTP id d2e1a72fcca58-7571fd0736bmr32671103b3a.0.1753192284817;
        Tue, 22 Jul 2025 06:51:24 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.24.59])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c89d3190sm7612924b3a.39.2025.07.22.06.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 06:51:24 -0700 (PDT)
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
	john.fastabend@gmail.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: linux-stm32@st-md-mailman.stormreply.com,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v2 2/2] igb: xsk: solve underflow of nb_pkts in zerocopy mode
Date: Tue, 22 Jul 2025 21:50:57 +0800
Message-Id: <20250722135057.85386-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250722135057.85386-1-kerneljasonxing@gmail.com>
References: <20250722135057.85386-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

There is no break time in the while() loop, so every time at the end of
igb_xmit_zc(), underflow of nb_pkts will occur, which renders the return
value always false. But theoretically, the result should be set after
calling xsk_tx_peek_release_desc_batch(). We can take i40e_xmit_zc() as
a good example.

Returning false means we're not done with transmission and we need one
more poll, which is exactly what igb_xmit_zc() always did before this
patch. After this patch, the return value depends on the nb_pkts value.
Two cases might happen then:
1. if (nb_pkts < budget), it means we process all the possible data, so
   return true and no more necessary poll will be triggered because of
   this.
2. if (nb_pkts == budget), it means we might have more data, so return
   false to let another poll run again.

Fixes: f8e284a02afc ("igb: Add AF_XDP zero-copy Tx support")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v2
Link: https://lore.kernel.org/all/20250721083343.16482-1-kerneljasonxing@gmail.com/
1. target net tree instead of net-next
2. use for loop instead
---
 drivers/net/ethernet/intel/igb/igb_xsk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
index 5cf67ba29269..30ce5fbb5b77 100644
--- a/drivers/net/ethernet/intel/igb/igb_xsk.c
+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
@@ -482,7 +482,7 @@ bool igb_xmit_zc(struct igb_ring *tx_ring, struct xsk_buff_pool *xsk_pool)
 	if (!nb_pkts)
 		return true;
 
-	while (nb_pkts-- > 0) {
+	for (; i < nb_pkts; i++) {
 		dma = xsk_buff_raw_get_dma(xsk_pool, descs[i].addr);
 		xsk_buff_raw_dma_sync_for_device(xsk_pool, dma, descs[i].len);
 
@@ -512,7 +512,6 @@ bool igb_xmit_zc(struct igb_ring *tx_ring, struct xsk_buff_pool *xsk_pool)
 
 		total_bytes += descs[i].len;
 
-		i++;
 		tx_ring->next_to_use++;
 		tx_buffer_info->next_to_watch = tx_desc;
 		if (tx_ring->next_to_use == tx_ring->count)
-- 
2.41.3


