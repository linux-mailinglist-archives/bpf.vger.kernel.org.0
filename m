Return-Path: <bpf+bounces-61853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 164D2AEE21D
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 17:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF97818842FF
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 15:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2580328F94E;
	Mon, 30 Jun 2025 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjSQD0HL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AF828F933;
	Mon, 30 Jun 2025 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751296430; cv=none; b=ejlVdcf/EzAiTgbqcfNNY4QjknUN0qRqWhHQHifNrof4MFseOySa8SEzFbyruJYBPah1yoGZdpw31BNMCU+Jw6aSHUzPNj8rPp1S91pnUXYmv4OzAUMx/4NN/YR0hg3C/OqN1YgVDQGLkwVviDcaQBIBOF10GhorORomrDU+Tg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751296430; c=relaxed/simple;
	bh=5mv+oGmYUQBg1ezZ8QQ1je1GKPmssv38hlgDpbVe09k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXwI1IwCEH60WYScMXI489ZeVKkRCa2vFfhOS1WhfcmtM082Snie6tgmJWseLdZYdwaVc28+aDWWFi4pBoCGv9WUiRdIW3y2//icj+nhI1KST9KgB0KBx2Vmvb/Unvk6vg7Z3dGRodFm1omtCp/gsMhs2VxKJzQZG/SuiX1er14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjSQD0HL; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b2fca9dc5f8so4379998a12.1;
        Mon, 30 Jun 2025 08:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751296428; x=1751901228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBu2Oaefb1JPmcr5RSg3Hzf1URtJFkgOjV7eKQ6deWg=;
        b=GjSQD0HLv6u5xa4kxo/1YwRh+bRYdWrLRydS5f5l4Z1Yd7NrDKGZmvtFMv347b2GQV
         618tSDmfdf2q7xWJHgw5U5MD4kvQzFPnlQMFadOwoINfI/n2w/RxeKGRcHrtjQDK95tQ
         8A3MiGAEUiyHaXmA7ornQlaW7mH8FrzEPWwia21NopyTZMz+qa5I1ziuZX/puMNVi1l1
         US/AHT0XN6XkStpcNSzrj3MfktdGw7R11zn6srg79F2MSOXN8v8gN00tC4S+aU6lrqX8
         QSyskTvow5CclUUVlKi6AlWmta3qTnoijch59NeIxxWQejT9rwBdD6nJSpJ2Dd6qMoLn
         vhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751296428; x=1751901228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBu2Oaefb1JPmcr5RSg3Hzf1URtJFkgOjV7eKQ6deWg=;
        b=cNC4bAG22TFKeTWeYiW1K+QA8wzdNNpMEEBuLXyw8STEpOGLL48stKg1hkwotb9DFY
         rUiphuoOZdzRqcGyqHuGGjMdmk9piIm0xcikrxVL0uGiqDNlkJUmmZS6kDiXvVj/SJBK
         KpM1Ec6M9DOsjGumUvsecAIe59mDnyfOCnuuAfS6UfTncIPEDqqGtzuIhX9rZDsNruN5
         KkDEnV6ghgQ/csQJmtta0iy348igteJ/HTX81czFC6guAyNYBSZfG0sF6a2wxQVCI3cT
         uE1iN/b/tOPolgg/CAmp7MUpo3Dxo91pYyweNHZqUuopHGWD15Mh7gojkPFvYBy7gc+F
         lJow==
X-Forwarded-Encrypted: i=1; AJvYcCW+hsSVQjejxZ72oIus8dd0NGSTlFqilXblEQ2ZA09FuAnYfCC9beEscMtoSUGler+DdnOLVj7BI3RP7D2q@vger.kernel.org, AJvYcCXFAskeeJDaTVQGo56OJVicoA9mWqfyD/4DNi7CNK5/AVYTfRGWqkZQ+84lpI/vmE4JWdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztm7ETFcIthsNuGeufAv1qfceeTroA3FRl7YPrOmHRpXd864n1
	w2fX9+BxftQKgWetdS71CUv3NvtRyAN3/bQRwr23Lu5t58T07197+S/Pmeu7FQ==
X-Gm-Gg: ASbGnctXtvuabppnsMGfOD5SzPd0ME054cMTlG6aN0WucULbk/BHjg1Fw7h3L6UYX2L
	2eWvTlttK/seHk9NIS7ysA03r5PArxs5RHVKRpbjFZmMpoNz5in2/r7LVuyLG400xsIearnc15y
	iG/aYDqHoX8weLSFBmCH/+y/+0YljKWEM5bfnWpt3/oX5b15LbuDiP5STBetGMf1lQ84ckkKvmE
	+jxCfifnxJJqbC2gwiH53HEn56k0uHj6SgcBMmxEd7x4840IyhIsUZ8p1KanzpQLetC46dk7oGg
	N1ALLzczPDQbUWLScY4VcK5e0fnq1Q+F4PSHM6V2A/Wp7GrlhwIME3RxSr5Ikec8aJvCUOVk6R+
	9
X-Google-Smtp-Source: AGHT+IFwWEbLrxuNpGb6xkKNMp0XC0hNjgZ5eIlHaLzs3SUtzwOhDuKMakpxMq7cSzD+BMZJOw3BQw==
X-Received: by 2002:a05:6a21:393:b0:21f:39c9:2122 with SMTP id adf61e73a8af0-220a12a6789mr23026011637.2.1751296428201;
        Mon, 30 Jun 2025 08:13:48 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:2f51:de71:60e:eca9])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b34e31bea17sm8323340a12.46.2025.06.30.08.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 08:13:47 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
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
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net v3 2/2] virtio-net: xsk: rx: move the xdp->data adjustment to buf_to_xdp()
Date: Mon, 30 Jun 2025 22:13:15 +0700
Message-ID: <20250630151315.86722-3-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630151315.86722-1-minhquangbui99@gmail.com>
References: <20250630151315.86722-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit does not do any functional changes. It moves xdp->data
adjustment for buffer other than first buffer to buf_to_xdp() helper so
that the xdp_buff adjustment does not scatter over different functions.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1eb237cd5d0b..58876d1e1344 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1159,7 +1159,14 @@ static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
 		return NULL;
 	}
 
-	xsk_buff_set_size(xdp, len);
+	if (first_buf) {
+		xsk_buff_set_size(xdp, len);
+	} else {
+		xdp_prepare_buff(xdp, xdp->data_hard_start,
+				 XDP_PACKET_HEADROOM - vi->hdr_len, len, 1);
+		xdp->flags = 0;
+	}
+
 	xsk_buff_dma_sync_for_cpu(xdp);
 
 	return xdp;
@@ -1284,7 +1291,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
 			goto err;
 		}
 
-		memcpy(buf, xdp->data - vi->hdr_len, len);
+		memcpy(buf, xdp->data, len);
 
 		xsk_buff_free(xdp);
 
-- 
2.43.0


