Return-Path: <bpf+bounces-64171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77298B0F531
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 16:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820CCAC2764
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 14:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C482F2F2C59;
	Wed, 23 Jul 2025 14:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNi9bOfL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E4F2EB5AD;
	Wed, 23 Jul 2025 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753280630; cv=none; b=D7L8N62TesTe0/ho9Wf1eUwfPfWdok7hyvL+sBgFQ1LKyUaNT1JgKtBbHrkouoXu+HF2i0SK226ouvC92FYCkOHL0v543yTpZ0DebXSEpcDxrKexvDP+Qy5Zio2vbM9rZ2BgAKddhmnw9bsBnq/Kadcj3VVzKGkQqVKGxdEcPI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753280630; c=relaxed/simple;
	bh=8HpLv9pFF4CvinAT9nkSGAi4401wgJXV2r6HHkqEr8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ah79ADd7xeNkROvc4f2gT02PkXT5bXKbIuhHDNm5A/ho6YNkepvoGwB4HhIxCm70qHCkPG4/KwpPzgqYEBPRjGSX2asVRJDt2iuDKTOuHm87f2aNsu3znhfC13YCQSSWu+tU5XwyQFl+e7FbRYRXOIb2ew8TQBWVb2TKprzJfrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNi9bOfL; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23f8d27eeeaso18495475ad.2;
        Wed, 23 Jul 2025 07:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753280628; x=1753885428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fj5WqG0SJ2Uu2EiwaVSrVFDSkAPLmbdJzZnTerK4rAc=;
        b=XNi9bOfL6pAxHisX6ra4yHPe9R9V+F4hqMzpYF5qFEq3IQkPlSacG32rId00IQ9KZV
         1BztaEjT9XoB80bRQXmD6OrI2A6YjdrMVDRN1/l1BhxlqWSQDIxemaio1i+uWOBTwsJ5
         2Sa6vc33H/4Wx/dLbqG0YGBD/SrBzFDiUN9ROnMcEjkeDhZYsYRwraSfVgJF1FO46GNq
         VntfGmryVAo46RAr+WNPe1MNKg/jANsA6BJaJA2hwTLMzNQ4CEPq8NjD4tT6xCCJ4PPi
         Prf8mA/K6kFknSbhgNKJT3ZXoI99fLviXCrMLD+qQN5yzQvmW36Q2yyzCRPpnpemhgNM
         GmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753280628; x=1753885428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fj5WqG0SJ2Uu2EiwaVSrVFDSkAPLmbdJzZnTerK4rAc=;
        b=F+hQipQxWPBf+hL/D5fqBhHGRUeFnOU/bafavTNP88y/C+A72SRxl2TzUDjwFbEDWB
         VtZ7ek5YXuCIHD0sXrUzo6TPDCybBiGWNdytvOI77qUkl0HlhbIg+xJylt8ZBCRQzbIC
         aUSGw/tcyapUFQjNoe/bqr5jbXqUukvk0qHEcAxtubbTVBsCXORDknUUIbwNWATGT04m
         XH/bjBuBFCyXV1NYvXdzAfXMh2qHlUa40Oe9TCsikNMlyAoMyNNERiWHlci57rX1FSe5
         JMxlPrbHWYz1Opl8Q3m+XHi1zNvwZPx+Dq5wexAQibts2HEv0D8UA0q5X+WHMYeknFnB
         vm6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV16ssmk7oz8rHAH6m4A8pZZ5lLEd7ivmlybuwtk6dWM4HxkQKHG1in/I1mvULh/RjIXKo=@vger.kernel.org, AJvYcCXsdkXdegX1bBzdV8QxXd6HuXvIwMopA6oszqU9oqIFUTrtQnJ3u6l5iyCEqjkLwQ7XqDonJtOP@vger.kernel.org
X-Gm-Message-State: AOJu0YzIgZv7KmueSgEPJ67kBCwTQd4DjpxEmk0x7YBAVm8H7MqlAJPq
	qv5sXMfpWkk8TOC45xb3XWSR6z9m+ikv7XXLdntldu3ZfYxh6+afZ+Dj
X-Gm-Gg: ASbGncsGrwaSm09UxI4ywzAxlbQLQtK+1Jw62qCcYzrmtGCj15NzABohnTS1HaH2QUl
	kDvoW1Moeye2sbe6RFoOtehYJKzXZNgZ1lo8OdxON+jIMaNim+Un6rFcTYID2U/0tLD6dTHByBo
	9YxQTrxVLI4f8aKqvWPJTN/RLCvvowBgKwOjW9Zo+WrLZa2SgDYks2pWiidDByhO/4zN+a7JNs6
	2SLbiu8xN50VEq0GCcplD2vhV6PxPyJ1fVMbQJPDPnAYSrKOqiHGagLDRBz/ykdRO8dPVoY+uzK
	gCeSvsU5DfNgKhdH3uRsrSc1H12VZRk0o3qufFQcIKndVZRZwQpFMJrguN3Y6ckeP/Cz/KgE+aD
	k3ZMiNDHlsY60amXXUOlb/gdt79Yn7JHxuvYamtUca/SgVKRi3/tFSTpXdpU=
X-Google-Smtp-Source: AGHT+IEnG0E7oKJq09UZhheN56FjJBTTkrONfklWiZ/yow6qAsYP7nD7qZdnI57JncC+db1EnBFkKA==
X-Received: by 2002:a17:903:1aa6:b0:235:f3e6:467f with SMTP id d9443c01a7336-23f9812b4bamr50464715ad.2.1753280628189;
        Wed, 23 Jul 2025 07:23:48 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.28.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4a9esm97929595ad.93.2025.07.23.07.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:23:47 -0700 (PDT)
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
	Jason Xing <kernelxing@tencent.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net v3 2/2] igb: xsk: solve negative overflow of nb_pkts in zerocopy mode
Date: Wed, 23 Jul 2025 22:23:27 +0800
Message-Id: <20250723142327.85187-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250723142327.85187-1-kerneljasonxing@gmail.com>
References: <20250723142327.85187-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

There is no break time in the while() loop, so every time at the end of
igb_xmit_zc(), negative overflow of nb_pkts will occur, which renders
the return value always false. But theoretically, the result should be
set after calling xsk_tx_peek_release_desc_batch(). We can take
i40e_xmit_zc() as a good example.

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
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v3
Link: https://lore.kernel.org/all/CAL+tcoAnB+8ZLPyWQ3XsvWTa=JO1yCKWvrKVp+2WCP=kGpfSPg@mail.gmail.com/
1. collect reviewed-by tag
2. replace 'underflow' with 'negative overflow' in a technical way.

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


