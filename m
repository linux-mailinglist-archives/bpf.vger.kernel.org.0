Return-Path: <bpf+bounces-64128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FFBB0E79E
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 02:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D74A1565040
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 00:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6323D561;
	Wed, 23 Jul 2025 00:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUHE+r8K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F13EAE7;
	Wed, 23 Jul 2025 00:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753230728; cv=none; b=ui2r0p4K7BlYnjXVacUMlLzrNvtph1RcxPdQEo4mmT37XH+Psq8WZSngH+9/ieG8/5OrOmHqetv2xKqPIVbEES+OUIVdXR1quKF2wFHHD1gU2FcMG78ozLoo41JjX8eZ2mjZmo24Q3lktWwMDUWQ+aYKfv205E0uhNgwLF3PLf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753230728; c=relaxed/simple;
	bh=SYSdi3du8ITAdTHBIp7C9EzI48FMk+qX5T04k0JcsZw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=neThUYk74pTH4Ad15BSvzedflKc/J3sys+A3LO10yP3FqFOem+C8YBwAj/hD5tUhpgOTOJbdRdpxJsCPvrsYVC/JZF6kq7ktU5g4/dsxUswC+daFC2HMKdq3cut0DcxtJt6szQnzOHLgCqeTQDkEE3UzFLgfZyfnmU2/PFeFXVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUHE+r8K; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6fad77c3ce1so12009666d6.2;
        Tue, 22 Jul 2025 17:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753230726; x=1753835526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0HldBv8Q9BEoai7BLEFTDZXb6gDd1HAmd9oC25rqbNs=;
        b=ZUHE+r8KhN/PLW4yVLs0OnChL0oSidff7J81hTWu33ww+Zkgg5rv+UgsORM6fUWdPO
         BZO9Cgu7aU+1oU3N7PP/ZeXJkLaP7+4yYL7EyammhmNie9vCq1TSZ5GIFqBVYt0fAEGb
         Oi4bNzU3uIiHarydmNQP8ncP+j2qER6twwHm70v4y3pi350TnCqyseYSy1PkJnhQQn40
         TD3CSNNF7REWcqmrL6CX/CYOODILrCc5CQJkgXsjfua0LxiwOrs8gMhG5GXbwPNkxTy0
         R2JH4EvHIN6AkaWWYCRWuKUGkW1/ZLVR2Q8Bq/zkkV25BvAlSKhiaDjOj/GM8af+JT4D
         8SRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753230726; x=1753835526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0HldBv8Q9BEoai7BLEFTDZXb6gDd1HAmd9oC25rqbNs=;
        b=KewRV0HLqrH0VBiC+sVWfndwNLEX4ghVETzxU17KQba9JBr8qVpN0qCml4IRxmQGuF
         3OaSgdAi+Kc/DiQNHEGcswCehkv41ovJokmdywLxvSs/Qb/rPkkbBvVs1eEo5551zr8M
         13JqmI97blAPvZLXJQDl3ECypTWgCUzxZBegFcOOL/Qnn7sWXcn5SqHVNvQrMOEhJe6M
         wQhXfbQgpnlKsvq11VQFnooziyx6VBTc9gK0wGH4FduAmIVOQkjehkKRo4BMD8awiUPT
         5psfNS5dyGFPyjcVrrPUFmAxCj+2g6exf5GWU6rBeks3uFFyP1gTzz5Z2tvbeJf7LAUK
         98qg==
X-Forwarded-Encrypted: i=1; AJvYcCVkCi/BRnEJl0bDCk3i3VQVziU8qPibnAkl+v4B+Ujk7N6fTbG5CALRfQvzYy1MHX7c0Hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA3XAWEf44P1naIlJ+f7J+/kQiB7I0N2UlZk7iaRKdQHixzoF3
	OY7q6C3kR7RJk4CJwMT/8N3to6hGzd8FqJzSHhWo0RlnRArPtefgS7k/GJ8y
X-Gm-Gg: ASbGncs7F4cQ0WKmnfH8ghkEfaQEFJkRYeNZC01NK/fBzuaAtx6xG0+VogG8A7zfDLH
	z9Ma+Vj9Wvp7kbp968sgaC08kLZPFl+G+qgr5U8xIvFouBY/Zx0W/adSMWso8mfcx/vv0QwxjU8
	7dwqkjsDwKyFnH9AyULc/tHMpEDhbt+ueTophzt8OuvDDi8GOBCkBibkxEz0MqPoU+a2G9PSOU2
	0LxCqChBzWxv9/FT1jbNGG9j1aRMrYg0FTBrxdLw7BkrybHeAs1gluwi2NH659cMfz8GqF+3Ofr
	PlCFJQ3NlbhS9ql2skFChhJaC+tcUtBMrXMuyYG7SWBK+qz5ClgAh8JoSKsGBnyEc97F5UtGpZC
	AP+ZAuTr6gfhQow45pO1dP6CNwXJMPA==
X-Google-Smtp-Source: AGHT+IFEqQvOeBCjZOc7gY+gzD2FAnrlv6LEsDA5HE5cb4PHs1RufPSD572pkKluvhC+3AneYC2rHA==
X-Received: by 2002:a05:620a:7203:b0:7e6:2435:b69b with SMTP id af79cd13be357-7e62a1dc2b4mr74388985a.14.1753230725773;
        Tue, 22 Jul 2025 17:32:05 -0700 (PDT)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051bab3782sm56728426d6.102.2025.07.22.17.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 17:32:05 -0700 (PDT)
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
	lorenzo@kernel.org
Cc: netdev@vger.kernel.org,
	linux-net-drivers@amd.com,
	bpf@vger.kernel.org,
	zzjas98@gmail.com,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH] sfc: handle NULL returned by xdp_convert_buff_to_frame()
Date: Tue, 22 Jul 2025 19:32:03 -0500
Message-Id: <20250723003203.1238480-1-chenyuan0y@gmail.com>
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

Currently, the sfc driver does not check for this NULL return value
in the XDP_TX case within efx_do_xdp(). While the efx_xdp_tx_buffers()
function has some defensive checks, passing a NULL xdpf can still lead
to undefined behavior when the function tries to access xdpf->len and
xdpf->data.

Fix by adding a proper NULL check in the XDP_TX case. If conversion
fails, free the RX buffer and increment the bad drops counter, following
the same pattern used for other XDP error conditions in this driver.

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
Fixes: 1b698fa5d8ef ("xdp: Rename convert_to_xdp_frame in xdp_convert_buff_to_frame")
---
 drivers/net/ethernet/sfc/rx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/sfc/rx.c b/drivers/net/ethernet/sfc/rx.c
index ffca82207e47..6321ccd8c8fa 100644
--- a/drivers/net/ethernet/sfc/rx.c
+++ b/drivers/net/ethernet/sfc/rx.c
@@ -308,6 +308,12 @@ static bool efx_do_xdp(struct efx_nic *efx, struct efx_channel *channel,
 	case XDP_TX:
 		/* Buffer ownership passes to tx on success. */
 		xdpf = xdp_convert_buff_to_frame(&xdp);
+		if (unlikely(!xdpf)) {
+			efx_free_rx_buffers(rx_queue, rx_buf, 1);
+			channel->n_rx_xdp_bad_drops++;
+			break;
+		}
+
 		err = efx_xdp_tx_buffers(efx, 1, &xdpf, true);
 		if (unlikely(err != 1)) {
 			efx_free_rx_buffers(rx_queue, rx_buf, 1);
-- 
2.34.1


