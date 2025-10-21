Return-Path: <bpf+bounces-71570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C96F1BF6B2C
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 15:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E50042264E
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 13:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC27337113;
	Tue, 21 Oct 2025 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyk2OnHH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DEA334C26
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052366; cv=none; b=UsIhKo3bsoY/AKiMszSmw3nUbHkz02vRcx/34nrKXLzqQTpwTfnkuPKutbe7szp1bqQqe9vu5IzEwSoYze25gU+uh0EBohofgd3/tCnCodYZPd5naOQaoaSA1QfgGpBn/c/Tame3ZdHohTEDXlPipQzR0yTl9COgiQjsUTDGlQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052366; c=relaxed/simple;
	bh=et6B9jpYWtCzdXVd+olRhHB34fm5eTa7Z2yaMlv8P8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B/As9+roVqYKoeI+F/MSI+JTijziQCe3tBR5ZsO2Rmb6KfAERZEyBwCmlKHaIcx7Eow+DE+TP4lqli0X/BScMQL2gk9AMvpQbCkUWa+nNNPj7YT10Q6AEBPmyiXrykBXzaN3Bog6OAUTm+5LmROykHFqVJ3upnS+k2Lt8TdTs5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyk2OnHH; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b556284db11so4684028a12.0
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 06:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761052364; x=1761657164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYks9YiGVI8btVCzGqfhMQ1rij+nkpQpVNndbIX1uww=;
        b=iyk2OnHH+5qbJVUaztqoDol/kSAempvvlxoHdlOCK6ru9u99cUVxJ3MYdZI0OUn7fl
         +7WFpBlUh4yN4qT5/rHmWvCjA0ImiCcIbt7COq2FJai1iRJNknmJi2lWzfeg6wMhpN+h
         aV6A8+SVBCPJHILTgkN69dZxuTbOH7ih4HlJ3/CIEIUVrE1lXQx81I5lcWSFhrRh8j2b
         fEaU2l3wQrmNf79wl2RqSnvoWH5JQ7IUE4foAcJ7trZT7syCZk5rdBozei44GAdKm5+4
         yNPYf+QyEPiZXvFWMf/H/dj9BJeCNSw1LQl+cdG20VcwOzTjHSuCs+YUFpTMjxtwYyw+
         rG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761052364; x=1761657164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYks9YiGVI8btVCzGqfhMQ1rij+nkpQpVNndbIX1uww=;
        b=jVDbcCvhIvESEZQQ0yluKmx9yafSaf2G2HufqCsLgiQ94vB0K/3Z9yWi3VUYfZ2evT
         O/tG0yI2ZnXnhsx75Hzj1JD7T6Sl1YSV1D9WageTSqMCh5lK1WyZG0vn2H+8NvPHqWbZ
         1tJi4SyTQQad9aOkfFAw2MkGRV0GuJT46pynAypMuguPRuopW4A8BuSbUUHRaFXQG+ci
         Is3DjFSJa8YmFEP9TR6dgxRptgChFxK1HnXiKK73CN2DjzkdMiEP9NzZMgv4I4N55TXL
         XQshjMm/Q+iRMGbpYVTfkVtuMczpms3yfgrOrz6c8ulZRQApEuIkav6/o1f0FKI8m3on
         IQoQ==
X-Gm-Message-State: AOJu0YzzqOSuImNiXx+VfuKR7JUNWUNkevgwHEl8ywPnF0F+n8nxxNdL
	J6RqPnvyOe+x+4N7W5Qv9x+mZ8Ld7F5Y/VQBhgPu8u/s6eDE4fbMQtR6
X-Gm-Gg: ASbGncuEG9RAypVhpEIPidTNTbXJhZxKVDRHUxinE3FqdcRRqjRlxQ6oetKL7bq97fG
	aeL61rSx46BJGadxl0garBqpYp3nVRkTKO8H3HcPJRPKYBguGuVQBAOniXSl39T55M+jPq5eeDh
	mNFKGV/p/y0flqkZEKTLfvBG/zJe2OzFVG6DrLzwIgdsHlsE3+yGFxYBF1D3QoPrnj8UlmIfszZ
	HtDB2obJNdmjCPvSEK0mcnetG8ZXMqqv18Yi+8RrHeKqTkPSDVQdfoZ4IuEqL/MX/rICZR5KVEQ
	y1pwXbMfPmW8kel5+VUfZZ/tknfi0mrtpvO5oTF/ZTW2Q8x+YD1/5Ukc3xi3cochYnZdeRt8hvR
	QN0KiUiNkYb5jGXU/px2s/WtrGjpcYkWYO9ynwcBOpdy9ZxRebIGa+DDwqBYcWTkd2gSOmaZNQD
	DtclurnwDd51GRWHhSP8YiFR541fufBrvILJbuGA4u8XhpBB9ZZD25tlZesg==
X-Google-Smtp-Source: AGHT+IGooEV5+ooG0aaYa2pPQEXWWO6T0gE0QTgFSG0e71ronKcRxW+iMapccUAf07rZSXUj2t3S/A==
X-Received: by 2002:a17:903:1d1:b0:290:2a14:2ed5 with SMTP id d9443c01a7336-290c9c89fd2mr183379455ad.4.1761052364484;
        Tue, 21 Oct 2025 06:12:44 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fd9ddsm109248175ad.89.2025.10.21.06.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:12:44 -0700 (PDT)
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
Subject: [PATCH net-next v3 6/9] xsk: extend xskq_cons_read_desc_batch to count nb_pkts
Date: Tue, 21 Oct 2025 21:12:06 +0800
Message-Id: <20251021131209.41491-7-kerneljasonxing@gmail.com>
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

Add a new parameter nb_pkts to count how many packets are needed
practically by copy mode with the help of XDP_PKT_CONTD option.

Add descs to provide a way to pass xs->desc_cache to store the
descriptors for copy mode.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c       | 3 ++-
 net/xdp/xsk_queue.h | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index b057d10fcf6a..d30090a8420f 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -523,7 +523,8 @@ u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 nb_descs)
 	if (!nb_descs)
 		goto out;
 
-	nb_descs = xskq_cons_read_desc_batch(xs->tx, pool, nb_descs);
+	nb_descs = xskq_cons_read_desc_batch(xs->tx, pool, pool->tx_descs,
+					     nb_descs, NULL);
 	if (!nb_descs) {
 		xs->tx->queue_empty_descs++;
 		goto out;
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index f16f390370dc..9caa0cfe29de 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -235,10 +235,9 @@ static inline void parse_desc(struct xsk_queue *q, struct xsk_buff_pool *pool,
 
 static inline
 u32 xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_pool *pool,
-			      u32 max)
+			      struct xdp_desc *descs, u32 max, u32 *nb_pkts)
 {
 	u32 cached_cons = q->cached_cons, nb_entries = 0;
-	struct xdp_desc *descs = pool->tx_descs;
 	u32 total_descs = 0, nr_frags = 0;
 
 	/* track first entry, if stumble upon *any* invalid descriptor, rewind
@@ -258,6 +257,8 @@ u32 xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_pool *pool,
 		if (likely(!parsed.mb)) {
 			total_descs += (nr_frags + 1);
 			nr_frags = 0;
+			if (nb_pkts)
+				(*nb_pkts)++;
 		} else {
 			nr_frags++;
 			if (nr_frags == pool->xdp_zc_max_segs) {
-- 
2.41.3


