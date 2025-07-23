Return-Path: <bpf+bounces-64129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08837B0E7A0
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 02:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A33053BE729
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 00:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE337081F;
	Wed, 23 Jul 2025 00:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8lOm2fx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40B61FB3;
	Wed, 23 Jul 2025 00:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753230755; cv=none; b=cSE8c6ON6+jy4rfeSbFciOPSQQuIktFz/mYQijo7czhgk3kidiJ0vUaQYVfeFbNwVYf/bgQxB3xGQLdAcZciKWOHfRvLwxJRuc0hb/kCLRIwjKCNzH2L4X5D2HTcAJgIzZxoIqqOKoa80MeWhxAv436ucQpVfvOcs6Sq8domhq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753230755; c=relaxed/simple;
	bh=6fx+GGKuy6dcG1wrAfwHf/rlE4Y6Olcz1t9HFTuQ01s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s94jv43z6utqjLwYNYko6MnPpSvuqpxNd/bvAUQzIAN8CsIyr5sNLdtK2lyFr1JDRtxe4hoJ4QVugTH6rE2lJYb9gXZUj4wFFRmND7mnnzQgW8VmOgSNfX1HsoJNJEQspeSKF4ez0TkfPzzNBIUuv01yDiNjfgVVeDcq75QMvME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8lOm2fx; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fd5f08f2e6so13731656d6.0;
        Tue, 22 Jul 2025 17:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753230752; x=1753835552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rVd0CKqFmawqkFyAQTrZsTyitqZ/Fc16HkypgrlA5Ps=;
        b=l8lOm2fxO6TXpWIpT1ygjpYm3tXN8m8gq+I6ymzftSDx0PVmtPnyB/IortQ/eA6d6L
         LEUTHUNL0VHzPjV0CNY23c654lRf4/Is/yQqWBGV/tXLAinJ0l++Xlhh2EjVvEMFj/0w
         pNyNG/9VcOZUeInED7HspducnD1qIajWXeRp6oC2zKPxp1GCrkbqcbupr/rKGqm5nXXz
         6IpuI0aoDz+aia6fFOBYc8hJRSJXEyM/HXPkFEOj2H7VzA4XoXAEisd6EuhJTQcP+r2r
         ijMBFJ/jdShioCtymsZusdcONmu6NHjZxilVTg1BPkpk3U0ckDIwl3sz43vAEPe/xMNZ
         TkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753230752; x=1753835552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rVd0CKqFmawqkFyAQTrZsTyitqZ/Fc16HkypgrlA5Ps=;
        b=iwCLBj35yh8K9TT9l9zrSL8z6ACT3dupYINLv9yoPEXG2mmsi059DGFJBZiyUIcSZH
         9MJ9JvsK61p8q8O9RqnW5Dv8uJYFAvN1XDxzYNM7f2Q4e00Fd06udmbemgR91CXB1+X9
         UlaEqKKjD/Nn8RjT8OZe7b5D35hP7ppiOWK6jm2B1N6rOcG8aqMu0NeX+87i3WJ9mSFH
         C9kLBJegmgnZeVJtCN6zxreyM1A4fdkB5bgmrFWmSRY7XQOJ5uaiqgnwz96XqrFD50Ol
         H3UZdPpFJfJ7GSx5ezWrSpEStDcDZ0dT7/pye3nnOF9fMUBZqaZ7cw9xU+MdopxoGceF
         wvRA==
X-Forwarded-Encrypted: i=1; AJvYcCUOGFhurMoiChk0UcAX2IxIswkiuN0dPG38mxFr+WCPeLyGlmlVcUwK3jrC/u5/c7GKNiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFxE6a0LJ6lgDsNGTh6ZRW5BEEr/4rn/JagDI+u0J3pG+T0N90
	feqqmROHkedRVbcP6rwuCXspIOUnvS2u5BZ1QMWeQ822SQScIhLieR0=
X-Gm-Gg: ASbGncshY21xm1lBZ7hQRE88RZYyM467Ww89XxeASnHICCcXzMmSQWSpVhZbozjEobm
	wuvHDA/TKXnaAjdkkpStTApoeW8xlJzFqpsSKwTx7nmq6H11w+AdkxMs1Ch7jAxwwu4V3tCgYDd
	q/utw/gor8kTwSzAFUv87YjmIl2frhY6xjsl+ZlgkRB/fUN25sttvSyh/mAIn3d866C0Z0hjv6S
	AaYcjEHvdmoOOOFcild/932wbEhwIHBn0b7qY5mDBy6blgpmvLUYzxb6V4egNbwQduJqS2PPJXJ
	XO7qupHv7BGMoEMFYO64xExllPbFD/Z5mb5gPzgutqTupKoA9UWciqkm0QDJG42woz4TmoV9Ro9
	+fv+iVQLmSBB97WEfkdw=
X-Google-Smtp-Source: AGHT+IGLDuMQzW1YPWsUkpnH3GIgGb7rdUVaWPFJ50xXz2fUzRP6ayhyV71LtM28sx0iCD7k5x6R4A==
X-Received: by 2002:a05:622a:a15:b0:4ab:76d2:1981 with SMTP id d75a77b69052e-4ae6de814b1mr7548241cf.5.1753230752472;
        Tue, 22 Jul 2025 17:32:32 -0700 (PDT)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4af44d7sm60462021cf.38.2025.07.22.17.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 17:32:32 -0700 (PDT)
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: ecree.xilinx@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	chenyuan0y@gmail.com,
	martinh@xilinx.com
Cc: netdev@vger.kernel.org,
	linux-net-drivers@amd.com,
	bpf@vger.kernel.org,
	zzjas98@gmail.com
Subject: [PATCH] sfc: siena: handle NULL returned by xdp_convert_buff_to_frame()
Date: Tue, 22 Jul 2025 19:32:30 -0500
Message-Id: <20250723003230.1243224-1-chenyuan0y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xdp_convert_buff_to_frame() function can return NULL when there is
insufficient headroom in the buffer to store the xdp_frame structure
or when the driver didn't reserve enough tailroom for skb_shared_info.

Currently, the sfc siena driver does not check for this NULL return value
in the XDP_TX case within efx_do_xdp().

Fix by adding a proper NULL check in the XDP_TX case. If conversion
fails, free the RX buffer and increment the bad drops counter, following
the same pattern used for other XDP error conditions in this driver.

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
Fixes: d48523cb88e0 ("sfc: Copy shared files needed for Siena (part 2)")
---
 drivers/net/ethernet/sfc/siena/rx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/sfc/siena/rx.c b/drivers/net/ethernet/sfc/siena/rx.c
index 98d3c0743c0f..65f6daad3168 100644
--- a/drivers/net/ethernet/sfc/siena/rx.c
+++ b/drivers/net/ethernet/sfc/siena/rx.c
@@ -310,6 +310,12 @@ static bool efx_do_xdp(struct efx_nic *efx, struct efx_channel *channel,
 	case XDP_TX:
 		/* Buffer ownership passes to tx on success. */
 		xdpf = xdp_convert_buff_to_frame(&xdp);
+		if (unlikely(!xdpf)) {
+			efx_siena_free_rx_buffers(rx_queue, rx_buf, 1);
+			channel->n_rx_xdp_bad_drops++;
+			break;
+		}
+
 		err = efx_siena_xdp_tx_buffers(efx, 1, &xdpf, true);
 		if (unlikely(err != 1)) {
 			efx_siena_free_rx_buffers(rx_queue, rx_buf, 1);
-- 
2.34.1


