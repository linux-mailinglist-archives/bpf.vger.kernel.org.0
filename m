Return-Path: <bpf+bounces-60805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351B9ADC60C
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 11:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9163E17740D
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 09:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA67293C57;
	Tue, 17 Jun 2025 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfYYbDVa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F82293B4F;
	Tue, 17 Jun 2025 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750151986; cv=none; b=OQM2oNbpYdCTSaOV6KxGd/pABMsTEneFGn7FZD4t7RtSivMo7CPSoKjboZKC8TdHcPuCUg7qw2wUVOneShQNFRogLVUOG+QzL0s12ulPkhtRhnjn+Vh7YwRHhhUdKty8DwgokAR9pF6z85gSKyz2gk3lO4e+sZP190N68/arp3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750151986; c=relaxed/simple;
	bh=d817WHPRcBKfQfiW+A6CorvDlxwqX4wjsZu8u9kQApo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UjF4AT4sm1Aom1CNJ8NW/NoDhL0NL0BBWq1daGNduEzHxMfNR3vRoGtuyMX9b+JjZWdCN5wLoPNUM00/JL1e6D8d5qHwArpiawGaoIwtoQ6CWWy6W7fr590v4uE84vW77rHDCQF1ybQPSl0Wqpn0WE+V7TrpxviEPUDoNn1cFCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfYYbDVa; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a4eb4dfd8eso470163f8f.2;
        Tue, 17 Jun 2025 02:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750151983; x=1750756783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ffPakIq+8CljNOP8FRUg8NLCeNR7y2dpIo5YjZ1J2YE=;
        b=IfYYbDVafm31f6p+eUlkzOVDnOxg7/GipJlxi0o9dBTTr9vMjA+Ljajp21oMjLScrA
         tmzJiJKFkmlmAgMfcz5EBeShWtrWDjKwtV8CkXwZBIHU/HzK1ujo/m+FupoRPZb3l4zW
         Ly0Y+L2AzeXJtt9fxe1t6W9qaR2CVoy4fBry3KqJUQSDQrvfQ9u5ZqZxVF3yPkNNm71e
         1jUdKhBU+C5QNvxWKsCts2vM5DUbBYr+SWYigaDLv3ZSnPqsXJ9zVh3Lz3yMHwL5we23
         SUd82/1aVLErelQZVdcxu9i6WRU4ffGt23XAOdzvITiOnzSpUUxLB8oMJc46T//rmGOC
         /cpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750151983; x=1750756783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ffPakIq+8CljNOP8FRUg8NLCeNR7y2dpIo5YjZ1J2YE=;
        b=LgYapx2iZ7uYkQvaqXUj3J2+teXLm825lvgLMI6CNEWTpvNvNCd2/2eXSdvV/AA9R+
         IE/t1kDVA4OoPHTrwukgTlrc647KEYXwkD+A5iDAj4IHfGawoa8eTkx/vqI6xkNVDO5j
         jkyCaBZudQhPyuzUGTywBpLI+319nPqeux20eBTMwp4Tjtrx34GYeNsCCLOVipVcz0Ry
         0BB3eHKc56fVhuibLHTyVar6HzltTHg0FoFZcvwQvrDkQ9/ySAalEyBnmBsfuIKFHtI5
         9uvc0ePsS6ir/RC5AI2Hi27bKy2PMr5eUxg3l7jYACHo813K3/YmevCIBW0xe8HHtEgW
         Dnbw==
X-Forwarded-Encrypted: i=1; AJvYcCVXO5F2ojVeUVbdzbrAx29HWZylBJg/omeq50UeYfx92ikEdzGctpZ0w94xyFjemNOSrywMk4Mp@vger.kernel.org, AJvYcCWIu5LYUO6DXlyfS5IfchyAWFKCHmuIwq8iXisqZhfDSpb2uZJlS4gBrQPovPyMnpWqRMVfsgEuPQHQluMG@vger.kernel.org, AJvYcCXLE5OTA+yPIQVOMBfIxdXQteL0F0GQBtugUP4YWKcTk9NSHLsyA3Q4kT71nlF5MMqJLoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzuLmEOByqs8jXF6mHeFv2yGzVfvqBOhTVvOQ50jFfCQO0k7MD
	oCDTS8+gNB8YI/wrDsBJxrGmncp1tuJJxBYYiaYivg6A5ncNVAws7chV
X-Gm-Gg: ASbGnctNZFMmsZUBaXyhBFV0dJOz11JlY4qmeK0mEnBSIcQMbnnADuP7r7eiorNgbCT
	UNzyPnwjksUj81Cv2HWc8Sp/U4DtxrS24GNiHgyCHJTstQVxMYX5Feo0WcN0sTdAfjQnAhRtBbX
	8oAQT4jUV3auVXBiFkD6l+y69ApSuxEd0588PnlHUtZ3aqqy3bFkTouKXoZQ5lJHN+/UX/8Ngcd
	gFNjXy/8KLWIJt8gKxYAGHITMJrb30DF4pp1G9dC/jW0Gd4sTKqJnV+As1FhJXPGT3ZIEu21XG3
	6WTLeUraoNglG4rHckG5IqL/V36Ropug9ERXpddP6Mf5zFOoeDAAovYNlmA5Va1rnKZEhaoPYpB
	zPTxVC1Ou54xgS64tdxE8ko1T69dH2V1cFoM7+1Z0Bb/LKKCVWcshJzmsnNeAnE9wQkk+nDNfzS
	I=
X-Google-Smtp-Source: AGHT+IGrmxAXUpkAP9gIxBWotWeEjVIywLjm4/Q3f32fA+oSWwZ/qUgnwqs0P+b9qfskQVl5NoE7Sw==
X-Received: by 2002:a05:600c:8b45:b0:439:90f5:3919 with SMTP id 5b1f17b1804b1-4533cabba48mr40846875e9.4.1750151982801;
        Tue, 17 Jun 2025 02:19:42 -0700 (PDT)
Received: from thomas-precision3591.home (2a01cb00014ec300db8a476a69bb81ed.ipv6.abo.wanadoo.fr. [2a01:cb00:14e:c300:db8a:476a:69bb:81ed])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4532e14fc98sm175260815e9.29.2025.06.17.02.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 02:19:42 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Taehee Yoo <ap420073@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net] ethernet: ionic: Fix DMA mapping test in `ionic_xdp_post_frame()`
Date: Tue, 17 Jun 2025 11:18:36 +0200
Message-ID: <20250617091842.29732-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `ionic_tx_map_frag()` wrapper function is used which returns 0 or a
valid DMA address.  Testing that pointer with `dma_mapping_error()`could
be eroneous since the error value exptected by `dma_mapping_error()` is
not 0 but `DMA_MAPPING_ERROR` which is often ~0.

Fixes: ac8813c0ab7d ("ionic: convert Rx queue buffers to use page_pool")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 2ac59564ded1..beefdc43013e 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -357,7 +357,7 @@ static int ionic_xdp_post_frame(struct ionic_queue *q, struct xdp_frame *frame,
 			} else {
 				dma_addr = ionic_tx_map_frag(q, frag, 0,
 							     skb_frag_size(frag));
-				if (dma_mapping_error(q->dev, dma_addr)) {
+				if (!dma_addr) {
 					ionic_tx_desc_unmap_bufs(q, desc_info);
 					return -EIO;
 				}
-- 
2.43.0


