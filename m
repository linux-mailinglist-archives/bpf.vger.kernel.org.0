Return-Path: <bpf+bounces-65392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29865B217B3
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 23:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487C82A5710
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 21:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB052E3B08;
	Mon, 11 Aug 2025 21:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPcZgvjm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFE62DE70E;
	Mon, 11 Aug 2025 21:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754949305; cv=none; b=T5y1GmYzQKlZJXUOq3IPZMkHxd1CXVfLh/AyTOBBUOpUFcIV5y6gKFXQX2QHLJ7yvQesHEUrFmyTFiMQc4EMezgLiEXTv0PxwNWIN+RAqHh4R2ImqrWqefNohLNJbYTGhpZO+S7WowSBrcQXJgkhOWvZz/ezRr8HPHfcatnUKIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754949305; c=relaxed/simple;
	bh=gj7hjaAYn2/N8QQjGcke4umQMwgxxyGX+VtZO3ddCuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pc711CphxyBJHv5wyiuIVIKkyqdxf49GCZWz0hwd7gE+0xb9ha+QMd0AcUijfYJWmtWIxXSgQleS4i6iKh4zeX/uYesb8SEWhOUG9UiQ/L00fm3/NRqYLzLOftYSyo7vItz7mqXkfwLjGvp3hrxhQZZ6RX5E/5Fi8eH5UZnyCu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPcZgvjm; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b7823559a5so2254900f8f.0;
        Mon, 11 Aug 2025 14:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754949301; x=1755554101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYVp5e106F5Hm9XlKJuQcZzKwHo45nvgyimrzRnLeFI=;
        b=ZPcZgvjm+Mchw+dBpM+28AWzZhovE5RRU70HbsHzB4Am+PVVz5EuVU2nIDM1O8+DiD
         K5tz7Lm3za318IVNjx1T7PqtPjFQ/34SSOPqisdDcj+MsG0pMtqWb65qGaWXw3ZtoEkE
         QkxlYf5J4kCQc/5+FSmou8XEy9Qxw3w8TFSNmp/8EeZmtCDm8JfON64cI9beCp1bSYWs
         9UkOEIJE/9VMRMQ6nohpxtaCulN/U5QNLDKPEJfXq7fJNhB9ykfhr1Hb/kFpfK+NqW/3
         yeConUqYs04XirThMwJ8kKpwKLkXzKNZEUIG1ESPcVxpX52SIWrN6/xwVr+5aA77bwMk
         wyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754949301; x=1755554101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYVp5e106F5Hm9XlKJuQcZzKwHo45nvgyimrzRnLeFI=;
        b=Tx+5M8gIzc0fBsPm+/Cx3gST1G77T4ScLGadxY71dvm2EjeVS5INuHR7jH+4hWATG3
         4RpMKAKJLTqzcMU41zSPJrEgwje4TEkvP8grKZoPlgYsZZPDGnlWrfp2heeUT7rfc+Ql
         CIhm2thbGF6HDrIL66CdWTPdBwe1t+Uyuk61HF4dOV6Wzz2olBSWFlAqzfXy7ZN8Hwy3
         9hHkSVqJLXySicbv3u27Yu2zdPjRz0GCwVuqS3Cd4hTyLoCmjHfbta5qXbnXg45Pa1nC
         S4iGlCJZoGJN++FN3NEAQ4XaQhoBuUbn8i+v0EWqCNEBMsxB4O0gyyypKTNJ3LJ8ipG9
         tlGg==
X-Forwarded-Encrypted: i=1; AJvYcCXh4xqxQyUi6AezOuKI8Xre7Zx/CnpgPhQfOsMgyTIIjcHxMwnn6dSAqEJ2H/PqtWCIJ/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYlpgeEHC22QztM2ebgeHXETAQLLWpG4D/DzTdJE9U7aubq+S2
	SwzRaPUB5VPxLA7TgdZBUgIuaHpoye/octTx+JnL6wqniGTy3pmp4crk3nvkA6uq
X-Gm-Gg: ASbGncuG1eqD6HCOSkRo8RnmjAcD1ss7256ii4HOcyg98avTCcTUYLWo9NHv1Trau1q
	mnBlGfdfUVIQmIBzHDXDt3do05M9BjEhM6TWaF+Cn6Wn8R/WJhZifDD52Xln8rNZYui28p3oGA/
	gbzgRdBgmxMVcYFc4wtGmRoWQI2AW2pnZvB1i+DFjQ4iM8QzHaCb3lY5ZlxnRVXDpdQbM7GAsaV
	cHNumdTrradBzx5FV7XV2nbjArsiz3XPlJvj0a2EuzFp/7JoHIvkssUVtWBLWYep7WWwZUD0rOV
	p2QNMdMr9mOEFNbp9x/EnghFJLkLW5Ht7Sf9zf3Bz3GkogtveQg/wFtWZSg3aG3dRnElyO7H+44
	u/B68EI5RyP9D3KcP
X-Google-Smtp-Source: AGHT+IH6K6RUS0HjUl7Sn1LnG2NYBcNPkXllfcZ9JvfNO8z1FS4nntOAJwUo5WwCm1Gh9XvKbLaN2A==
X-Received: by 2002:a05:6000:40df:b0:3b6:17b5:413c with SMTP id ffacd0b85a97d-3b91100ee23mr947122f8f.39.1754949301376;
        Mon, 11 Aug 2025 14:55:01 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e054036bsm32265872f8f.31.2025.08.11.14.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 14:55:00 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	ast@kernel.org,
	bpf@vger.kernel.org,
	corbet@lwn.net,
	daniel@iogearbox.net,
	davem@davemloft.net,
	edumazet@google.com,
	hawk@kernel.org,
	horms@kernel.org,
	john.fastabend@gmail.com,
	kernel-team@meta.com,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	sdf@fomichev.me,
	vadim.fedorenko@linux.dev,
	aleksander.lobakin@intel.com
Subject: [PATCH net-next V2 4/9] eth: fbnic: Prefetch packet headers on Rx
Date: Mon, 11 Aug 2025 14:54:57 -0700
Message-ID: <20250811215457.1053688-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250811211338.857992-1-mohsin.bashr@gmail.com>
References: <20250811211338.857992-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Issue a prefetch for the start of the buffer on Rx to try to avoid cache
miss on packet headers.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 819234aa5bd4..7945f695b6f2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -888,7 +888,7 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
 
 	/* Build frame around buffer */
 	hdr_start = page_address(page) + hdr_pg_start;
-
+	net_prefetch(pkt->buff.data);
 	xdp_prepare_buff(&pkt->buff, hdr_start, headroom,
 			 len - FBNIC_RX_PAD, true);
 
-- 
2.47.3


