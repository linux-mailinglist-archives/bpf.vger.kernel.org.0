Return-Path: <bpf+bounces-62469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A428AF9EE5
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 09:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6F31C2352D
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 07:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A64277016;
	Sat,  5 Jul 2025 07:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWmDf4CA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC65200B99;
	Sat,  5 Jul 2025 07:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751702172; cv=none; b=VCUC6PUDKuiVUZhiK6XheWHHGRM3fOzoD+MSoM2pmFboFRwy87xmYgBD8nI8JNbyy/fMyraTu0xoWlMmS0Bp7bEv0nUcYxqGVejXumlHpCePyHTzG41yuypYAZgPyzSFek13lDDwqBk0Gn+ny+/DTQng3lEpXfaRayqjnP0XI2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751702172; c=relaxed/simple;
	bh=1P2U2dshSLhnnrRgjC9ySFPrNtAdxhRNQ9ZjqtLrhc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tmXB8BskQeyqFrFqPi2BAoDw6TJ8tzXY69Z+oeX3g9lSINSuqGEha4VXmcnhBoHjzpPaIfaMS4XfLIbkk/ePMldg5Yx8ZhoB+OsbuksrrHrWHbjp85GZ13lw54OZeS9D/tRluftjGL4nZHjxyMsN5gPwaHdk3J+rBcKQERpqeZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWmDf4CA; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b34a71d9208so971945a12.3;
        Sat, 05 Jul 2025 00:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751702169; x=1752306969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h/IUKcxSD2e2ah4kSG9Q2b9GaMgau4YL3nl4/Ou8ZYo=;
        b=UWmDf4CA7dn1jyHjN5Hlu603FKL0a7Y1WQR7hlBC7SdhiQc62xH01cbmQ4RkkJv2v+
         7INsN2EcVh9ksjfKm4d3Zr6fnrWVPFCHFuHFmJReNqQ1o05R4THE+mCnjoqoHbbwLnad
         flEVJOT/5bHM6e5+NVseVfi7bHzKKkVwHPbwIcXuamrdRN7PpSvpTcyKJo0j4lS3CUA2
         nti1cuUpEUK6xayV1+By4McD6WzjLi+On07bN9gaHWUIuabhyA0sJA/wFC5w7TJJnCpL
         L5kgoErlLMsneSqNEdhF/llSyIOJScjoPjHHCeXrlZN70tRsdbP9u80HXyAajYCiMk5u
         A0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751702169; x=1752306969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/IUKcxSD2e2ah4kSG9Q2b9GaMgau4YL3nl4/Ou8ZYo=;
        b=jIgWQsic4g8vRRIdnkwJts3cVroDJmQRwsh0HMIs54AxOmULzGxXSDeaozmHki+Qzk
         5sxvNcvk5zC31XO0wRpt2pEjwuuQf6TPcU6MyVotWMPzy+Dh/kstzEvhKQq0UIMMSsuw
         p6Q1HM2yb1WYF5hc0XruqMc9HP5QCN6AMTJ1vv5pCue8bKPIj/2TwKWfK3vsZ0b6Ywx7
         ZOsCoRWDlRVCPwSSbsd4PoBih/xAXoSWevs4TagoLLOGcLRcAzhwJoUz/o0fCOtsme+e
         iGilOwylwPzL112Knt/mncFshD5VF7hk2fKuLQWwAIDs0h/wdhr4bY4eeitX7Eftk71G
         wyxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTVVmmL+RyJAwQ39O/VYQqvFZglFSBZDteES3wog7ANyoQWhI0s+9C8Fm1rynyr2R8FTM=@vger.kernel.org, AJvYcCXDdbVZUYjBCldekkrk2wUFCe5h3gn3dFPdjjdeLTboCs7HOWxPqfh5VJRnrpcU8Ffqb+tEu85CWvldTpTE@vger.kernel.org
X-Gm-Message-State: AOJu0YwNWhg8Hfu8x87oafSjEvAINUC221B6NEi/hVUk5QpNYMkO++wj
	E8HYnTEZKBH9XNW5kIY6+fI/BRR9xhiEv1ja04L+BJ8/8jYcLKbHNOKcaWpg5A==
X-Gm-Gg: ASbGncvEX5cfYVSoy5tSn7taNKEIVP7UXqckQTbkPjAOK7gv1AfC5fLHsINIVnF6Zth
	mdMtBbNxwUfSoAkfkPS99B7qHy/mblPP7ZdsaNi+2cVKWnMomWjqTYEjydh3fbXDAvOJt8YO47Q
	OB4hSxlYXQXuWPvDySLHb/6EVneifH0Dxkr17eTcFtaojwSwHlByZAXP2lxSPoyywbKkpxH83HC
	uqk4nXFGQoxIB4cSnLQklSmHa+RUZosvFuEJvhA9mM8sLEeCsGQZ4CHegCFbFPZVIeMvaZWLB2c
	0r465fwrXPK3oF0+OfOOJXW681zzPTLowbnqhWXbxL2qbXWXs5mMyML0AFjRLYqlkW9fqBJuV7X
	84A==
X-Google-Smtp-Source: AGHT+IELb59jy1yq/0ZLxHvUZqGi8xjJJOOy8kXY/fGS5HJJFKa5k9aihU11XHC1d9gpDvqKsoQ2NA==
X-Received: by 2002:a05:6a21:33a5:b0:220:658:860 with SMTP id adf61e73a8af0-2260989672amr6461002637.12.1751702169435;
        Sat, 05 Jul 2025 00:56:09 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:8079:3d14:21d6:b779])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-74ce359e9c7sm4092388b3a.15.2025.07.05.00.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 00:56:09 -0700 (PDT)
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
Subject: [PATCH net-next] virtio-net: xsk: rx: move the xdp->data adjustment to buf_to_xdp()
Date: Sat,  5 Jul 2025 14:55:14 +0700
Message-ID: <20250705075515.34260-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
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
index 9f6e0153ed2d..4d995a47a116 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1179,7 +1179,14 @@ static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
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
@@ -1304,7 +1311,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
 			goto err;
 		}
 
-		memcpy(buf, xdp->data - vi->hdr_len, len);
+		memcpy(buf, xdp->data, len);
 
 		xsk_buff_free(xdp);
 
-- 
2.43.0


