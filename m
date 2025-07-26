Return-Path: <bpf+bounces-64451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD377B12C1D
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 21:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9CF117C7E4
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 19:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AC02135A1;
	Sat, 26 Jul 2025 19:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L31rKiYl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DB67080D;
	Sat, 26 Jul 2025 19:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753559773; cv=none; b=qSfn+hjRhqqsWtdWQd+/OIXtA0DP5faNA7uzio9iCQP6xDPCtSIGGy455eegIA9OgUKJKwkMyDM9CSH8XK4KGEOMPSw/CUydL06l+BYU+Cp+Ht/x6OfeOm8wkQ31MDAZV/3wtQHD814G4pP/OH2ainmf4wwX5CdxPGM2eU1D2u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753559773; c=relaxed/simple;
	bh=lei4gnzal5S77Q6KpgNtg3027OT2vfq+e5eunwylhng=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MmldYOGZToeKZHj90sS3EfMehMOGkTpPjyXnfXfSNgg1WECG+khBEOyHqnmoHn8KMgtfH14S9dJnvsSZANb99JPWsFMXEZ9VR58qHbAQR+O1dmM7wWMzGjEUUue0dHYFr5SJstlC6XakRQlzASPsYGVXFgECtD4kU1V39UiFP3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L31rKiYl; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3ddd98c2c47so1302055ab.0;
        Sat, 26 Jul 2025 12:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753559771; x=1754164571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LHD9d60M+Y2SrJGBEOsA9i6au5+wmw9gePLO1gCbDJM=;
        b=L31rKiYlJ5cHvsEb0GZLF/WioKSpkEoARghmKkUCrKgMOnAWHj3h6i3aBmB4Gx+7Sk
         VLURVPk9eqxAkTVh7xH04FzltcGbVjKR+lS2gPVRFkPjLw8eCFVtkcljBim09I/o6lUb
         LpeGPwY0C2bXwoTydyssscr/d8SCIsTmP4hPn3nPZq4EJda3jJV3DDZrLNdRRgrhB76p
         ZmlCWy+4X5SSw3qWXgAdbcX/hkjGsBe7uTXUTShKQB+1hSRrjz5Vo1fSOzrp/LiMVqad
         Ck4861naGZxES0TotfZfp906mUoWhsFdO7ZWplB7Ajh60rTukAX0yTvi79mtVx5GlP5n
         4q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753559771; x=1754164571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LHD9d60M+Y2SrJGBEOsA9i6au5+wmw9gePLO1gCbDJM=;
        b=HHJTyNsCWHHJ7HsaijVTnMN3qH+g65iCQC1+dKCeGUWGMb6UcUaAanZjsRa9f7ZXIo
         M71wNp+xDfDZJ84kRsIaeqEqkd1+j9v5wIE/3T+lejiclptCdXfowkeuhWOIkFLy51bt
         QVVy+3NmnltgdXKJK0tTdwdvzxeA7v3mLuIxBi37L0p7ITMv6v88kEkqJp31UR8vBBqn
         iOmE9swFbwMLIAgNZckFiIP9wJtyL4nucz3LxoXIVDxb2wU2i5XEPg1tIPVPWkIsRM8x
         MQMPbXK16u9eZFcAiQiZh6LMljntJK95ymgx5+GAWV3tp2TqPYub7xSIWIotrHS+wxvK
         qtJg==
X-Forwarded-Encrypted: i=1; AJvYcCWQ0kYTU4wcK5NlODug6mjU29t49kZVzzvS4TE9rt03tI/H9ms1tGRqGEhM3HCUahN2YSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOb4QMpcwnLUL7uh72RD+LzjnvULLYm7+UMVfVdwN7kt9FKHO5
	e7Dvjgtl+RUnhNlfZ7Daxmhx7p0Uz+r0+4lRcR9ET0aXTnYuGMLxkmc=
X-Gm-Gg: ASbGncuiW+YBBWHyM6GD1QQ6/EwFWtIQylMyBtm6QLSzc9D5KnrnwJTYh+m94Dr8qFd
	GJDd1pgfvJZTSxEnykIMH/OvyR/TwrkgjpHdUElbBDMnqYe9zHyu5bUV/0V0KpktEGd9JCQ1sTz
	RIRwIW5ingmq1VGJWvSnlLKUIw7obe+2JXMW+eG9Nrr15lWQPfvr+HxrnBU/P54IMpdjE5QONaS
	tfUIWhjMiUYSk4mYzCY1t/g2Nn1qsq3ecTLgStfp+PEh1vQhId/JJHmMITTcglPmOVfrWZ+M19t
	mqcbnCuYxKLVpGfO/dikVGR73rmuXrBYmaP3H1xdPSwJUe1ioGp+Tu3CHZ6gI1BMiZ7KO/0HmUB
	0eHmhpJ32GIsIjmZoVT8=
X-Google-Smtp-Source: AGHT+IEGq2PIAvS7/57hPsXh99rIeWetZpo/3oEc+z/jRk6u6dnRa0MIAOF2seGMB/qxWZBuKrN67A==
X-Received: by 2002:a05:6e02:250f:b0:3e3:cfb2:31e3 with SMTP id e9e14a558f8ab-3e3cfb235a8mr10059135ab.5.1753559771163;
        Sat, 26 Jul 2025 12:56:11 -0700 (PDT)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e3cac999aesm10259165ab.33.2025.07.26.12.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 12:56:10 -0700 (PDT)
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
	Chenyuan Yang <chenyuan0y@gmail.com>,
	Kunwu Chan <kunwu.chan@linux.dev>,
	Edward Cree <ecree@amd.com>
Subject: [PATCH v2] sfc: handle NULL returned by xdp_convert_buff_to_frame()
Date: Sat, 26 Jul 2025 14:56:05 -0500
Message-Id: <20250726195605.1650303-1-chenyuan0y@gmail.com>
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

Fix by adding a proper NULL check in the XDP_TX case, following the
suggestions of the developers.

Fixes: 1b698fa5d8ef ("xdp: Rename convert_to_xdp_frame in xdp_convert_buff_to_frame")
Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: Kunwu Chan <kunwu.chan@linux.dev>
Cc: Edward Cree <ecree@amd.com>
---
 drivers/net/ethernet/sfc/rx.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/sfc/rx.c b/drivers/net/ethernet/sfc/rx.c
index ffca82207e47..b56457c23f66 100644
--- a/drivers/net/ethernet/sfc/rx.c
+++ b/drivers/net/ethernet/sfc/rx.c
@@ -308,14 +308,20 @@ static bool efx_do_xdp(struct efx_nic *efx, struct efx_channel *channel,
 	case XDP_TX:
 		/* Buffer ownership passes to tx on success. */
 		xdpf = xdp_convert_buff_to_frame(&xdp);
-		err = efx_xdp_tx_buffers(efx, 1, &xdpf, true);
+		if (unlikely(!xdpf))
+			err = -ENOBUFS;
+		else
+			err = efx_xdp_tx_buffers(efx, 1, &xdpf, true);
+
 		if (unlikely(err != 1)) {
 			efx_free_rx_buffers(rx_queue, rx_buf, 1);
 			if (net_ratelimit())
 				netif_err(efx, rx_err, efx->net_dev,
-					  "XDP TX failed (%d)\n", err);
+					  "XDP TX failed (%d)%s\n", err,
+					  err == -ENOBUFS ? " [frame conversion]" : "");
 			channel->n_rx_xdp_bad_drops++;
-			trace_xdp_exception(efx->net_dev, xdp_prog, xdp_act);
+			if (err != -ENOBUFS)
+				trace_xdp_exception(efx->net_dev, xdp_prog, xdp_act);
 		} else {
 			channel->n_rx_xdp_tx++;
 		}
-- 
2.34.1


