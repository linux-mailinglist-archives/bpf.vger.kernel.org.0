Return-Path: <bpf+bounces-63886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0120AB0BEFE
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 10:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502C0167140
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 08:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1247287267;
	Mon, 21 Jul 2025 08:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHrKzHQB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97931E50B;
	Mon, 21 Jul 2025 08:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753086839; cv=none; b=cVlgR/B1rSe2M/XPBja/P7GW6V+rIRvSlZnMZIB+bTubeMJtBuQ+j28/D36cPDpti0red/qy2iyGPb7W6YVgT9bZSqTXD3UPRIfh1rx2oX9doipuKH7Oabtlq9Yt/Gg/RaYvQKosA8oKVTakQkwf3a3VmIHqSWVV2TrYB2yN7mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753086839; c=relaxed/simple;
	bh=0+NqqLP6G0f2uYl8Ky0lzuB+4Vk844rbB561dkDcbeA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bAD9ste+1fttvW0d7++is/jSCcISU+rDJxQWN/KZtRpPJJw8EU2PRGTjJ/yMi+nz3PlF/PqNIFoMrEBgEzhDrLPrjhHlapRv5WLYkklFAF788BwwcOJlXgeeip4HDmQtyaZg64kdisIHIPYVCSNr3YOAYqFNvIyiUNPf4MegnUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHrKzHQB; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b31e0ead80eso3054141a12.0;
        Mon, 21 Jul 2025 01:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753086837; x=1753691637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7UTJT8lT4wXm+7/izafM3LkSsGFsZ5F3TgOwU6IHtI=;
        b=MHrKzHQBmXmwQGzegASef1TsJp2meCDXd116uIbPm2aRept+ioeHJSaJzIaHGmVFrv
         eA1egxLPvz9fEipZuVHMzZnlFregUvG35LZTjvTT+N3Yw3Dr8Q2WyVEIcwo5HOIeqxg9
         eXRRhMQOEacgfF9tWSJ0Ang9F4oJcSTUPWgln3dUbfwOzBs21PCNKSGxaXxkN+mB06HG
         mraO1NqGYKJHVBqjo7Ur86/i8zZfxOpgdkewZ1cfsBjRXKTeK1ZQwR7H9WrX4XeELtvd
         bZyGW7ocj/UQ4OuMLKnRl4NsQqmTF9EYRPYA/oXvvG2lWBpJQuVwAUi/8AJV0vmW8IR4
         FSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753086837; x=1753691637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7UTJT8lT4wXm+7/izafM3LkSsGFsZ5F3TgOwU6IHtI=;
        b=NRmr7Vv9G3Hs/NxoT2GAar7xiaJMtLTi9XUGSGuloJwEiJ6ooZJYfYCUihJtDv/eyf
         cw+i6V3lBfo1z+5JgEBBb/6FfJQFHlyRoCVm/bCdYGdMGwf9MIfIxJyI+ZvBG1I71o+I
         xzVcR7kw6x2ihRWKYeRX6hk7AFlmCYjkW4A7ZGg2CPXCkfJskTs34iIdSyoenP7MJOLq
         g1Wmmmqf57DmubuxGMF73s7zSvzsA24LyqUpG8YtsPBCvdjywJepkAuzmKXx/L7EIwmq
         qx/btIAMFlBUHY6+ZOO5sLKCB9xDqsIH74WCIQ8MVCpbgu8LztZvTXs16XdU8svHFkNk
         YUBA==
X-Forwarded-Encrypted: i=1; AJvYcCVD2jd3c9QuizG3WKBrs97uwhs4RRDIqesmLfVxBw8yAvRshAUO9W/0DuNaB6po6w0upg4=@vger.kernel.org, AJvYcCWhJGjA7FdKJYgupu3rxoR0qqtGIK3XLG5r1zTCDwnmRqZRGSjotv6vaajjuFgm72m4Ta+YLcgK@vger.kernel.org
X-Gm-Message-State: AOJu0YwwsIrraGBG97xSqUtLKFVV0X/zmRFQgD9Vbb26D4SgtsPtoCqh
	GXJnaKeLXSAt9obVQdgvNfGu5hayrLn8KSDAOBiwI9T3vUmL3nQJ7MaA
X-Gm-Gg: ASbGnctfdBITMwnHKJPSQnRYj+KsT+rflTBhbE+7r4gsMFoINQtjSKd35VR5TMbuOO2
	VZ+eM8n/zR1mYCRRyqEcOuPIB5OpsUiAPJCkuNwwaWsXY+SC3/mSRO5WbVKc+pC0CV3Hn8rGgjC
	QAuptLOyLXUQu7v9PEMYAW5t7FRuOpuUskBVMIeU+WFYd1FtoblIhVXCG4rc8+FkJp/aZFrXoU9
	5iHiH2fD0Bb6s4qOa1YImmLnGSuCIhnrgGndz0DaY2AmDDG/dZXrcT4SVBTkRKeORXJ4MU47BjI
	BOnANqXqsoPMKc6nn81sbPuuvSvvb90DD2FMkXUObXUhU9Gv80V1KVX0H/a5QlfE2mXlMBK4MsO
	VsVYgPNFHKYXXsiNMJs7cVGQnr/SmCvw5Ue/T3lRVSiJb2pOQ5f/ncuqnVa0=
X-Google-Smtp-Source: AGHT+IF8Hz+/t/2gY/ArGAcHrkTSl0567NOaqn1eqgYFznb2pekdZjDkcc5903EJP9BByp6s3l8uNA==
X-Received: by 2002:a17:90b:2e4f:b0:319:bf4:c3e8 with SMTP id 98e67ed59e1d1-31c9e75afe6mr30594397a91.18.1753086836826;
        Mon, 21 Jul 2025 01:33:56 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.24.59])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cb7742596sm7082116a91.27.2025.07.21.01.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 01:33:56 -0700 (PDT)
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
Subject: [PATCH net-next 1/2] stmmac: xsk: fix underflow of budget in zerocopy mode
Date: Mon, 21 Jul 2025 16:33:42 +0800
Message-Id: <20250721083343.16482-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250721083343.16482-1-kerneljasonxing@gmail.com>
References: <20250721083343.16482-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

The issue can happen when the budget number of descs are consumed. As
long as the budget is decreased to zero, it will again go into
while (budget-- > 0) statement and get decreased by one, so the
underflow issue can happen. It will lead to returning true whereas the
expected value should be false.

In this case where all the budget are used up, it means zc function
should return false to let the poll run again because normally we
might have more data to process.

Fixes: 132c32ee5bc0 ("net: stmmac: Add TX via XDP zero-copy socket")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f350a6662880..ea5541f9e9a6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2596,7 +2596,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 
 	budget = min(budget, stmmac_tx_avail(priv, queue));
 
-	while (budget-- > 0) {
+	while (budget > 0) {
 		struct stmmac_metadata_request meta_req;
 		struct xsk_tx_metadata *meta = NULL;
 		dma_addr_t dma_addr;
@@ -2681,6 +2681,8 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 
 		tx_q->cur_tx = STMMAC_GET_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
 		entry = tx_q->cur_tx;
+
+		budget--;
 	}
 	u64_stats_update_begin(&txq_stats->napi_syncp);
 	u64_stats_add(&txq_stats->napi.tx_set_ic_bit, tx_set_ic_bit);
-- 
2.41.3


