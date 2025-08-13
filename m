Return-Path: <bpf+bounces-65572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB66BB2565A
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 00:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E2FC888757
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 22:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A1D309DD4;
	Wed, 13 Aug 2025 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPmdyhQp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C846F302CD6;
	Wed, 13 Aug 2025 22:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755123216; cv=none; b=Yrt4/vZsR3wAAfqtnm8omuqNheQvQ0rcMeOmbHHpyT1YDnIO7nBWf5v7D04H0o7ZS1qMaMewoOfkFdaq+vxkV0PqMRfLxRVyWCqI6/CL3y2gFH+hb4Xa8lLetG3FJym9AvybInougVXQAIMf7mIJYWya8EGSnieLkX3D73uouAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755123216; c=relaxed/simple;
	bh=8nMCVzoU/BearI+JQrhJPJzWNf0Lg3T4RMINzhVG8vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqypEpMDVgaidseJkTSQPWKeXa7IZyVoSWdAtK+fh8wlBd9IFiwyQilQlNnYL5Y6p1lp/c1wgZLD/HFhoWf3rPl7Nt78doha6x3CTHp9M9HWAtLFcDfqa2Y49Qig5cWIQ9EhjuXk3rNWh5GXcpRLs2/QT832uKj+L8rhMKHzwRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPmdyhQp; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b9d41bea3cso250669f8f.0;
        Wed, 13 Aug 2025 15:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755123213; x=1755728013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYPaKl7yRBI57VFUozUf+op94ciBF1/TM6xrDSp5DaE=;
        b=FPmdyhQpfb3oNHOwncD/urLJX/dI+wHgDjDwbzNQJPn5UL/C3uRIO/+BQXs24OMh0v
         B0lANMekeuvgZkHmoZ2jV+yO48r3bRA/tKqGfXoU6uc3WJe3+yidpC6nQlV7GGgvYiTR
         1GMh/RWlbdCOLnuXPYaO2Rjft64Mr0rmc8RakqjVEIACSs1OoaYcBt839OlRglbt2xpC
         UxNf5h4vIbvKqGUGlvbhP9CeXHbvIGwblit88CCBIDLfkyJ/6No+744qHjun5PS7SoEp
         PVv7+xFUdT40U4PocRVLfQTC8H2f8WKTQFP/2x0HO2I3mIaTKG9zpH7U8zwOh/El0tOy
         C31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755123213; x=1755728013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYPaKl7yRBI57VFUozUf+op94ciBF1/TM6xrDSp5DaE=;
        b=A23XQ382lbq7M5XCG35C+2Lfvyz6QFq74ogJRMv+h6CsGNH7H/TIuAW2GLllJZO1Zf
         zH2UMlqRiXG6mcL/bcMNb1N9YA2hwHJ9GadRd4v7M4diXuGd4f6Lo/lxZ8150Yet7guW
         MoP2hX9uFQHd9vBYPzL4gGIu1rjpX8a2yucVbzudlJ+AD+wfC5H1bTZL2gcSV6NU7ZlD
         XLqK1LqAgmnHE6c/SqoaNb6iJ2a1/YBMCd7Auvr8zRv0LP7D0oD89P5us041ASItYoEV
         Xxs966OOqxlyuZyMe5arxJ1pBVTBmC3i9dxGwLPz+N+S2jTV49ld/JmQRfELEDQX7coe
         Yo0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXvDJHG+xiSjWsnfo9AnebnZi8OahJMcoClHgfNtzzztLCGN0h2DO5OHHS00mFES/s5pvdVJc+gunQ1LqN@vger.kernel.org, AJvYcCWWNXL4T3JKTeU0wZoR0zKRPvWbMj1Mk9p6Q3lN+yjFDnXX7RrSz4JZ3KpV8WpQOjd4xKQeHtDQ8Myr@vger.kernel.org, AJvYcCWftTgmz/H18wQfNl6NGVxQcpKmAtJEJadWDFIG6yfTVUMKcDvFeJYBF2zyg77lq8PkrFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxax/fMo0G4iGygGhvpXSx5GgPfX09h1SABvOBrxAI8yVhaOgPN
	nZBMRB3pcOfjW+WB3W07hBTGc/m96ge8YiFhhJQ93DUB3Rehu9zXvA4yFgoBcZYm
X-Gm-Gg: ASbGncuhYTLdPscNmVR5NhsUJEsvtKyudKSpG7wXVyO0bV7KkYyvvhcz8Ff+Q6K76c/
	0zwW1yyZVpXmUO+5DdA9Bk/uGE5aeCjnroFLf8CkGR+/ez9u7c3SNl8A9VgMJQW8hLlgNCxg2Yr
	oAYUMFXmn/Z/5H8e6/9w3OWzs6HRdmnuOARlzYKTli4Y6CwKYArS5iG83lpWPdfK4/jnhezjILd
	OdUf1T+sz+K1q4LrAHgc0mZAYma4+4V30hV9xe61CuSSknm1llCzK5YojjbE+HpCAx+EdW3Xt1g
	VsngW9hvVLCWnthc6UAZnn58n/jwzydalBGdL4JHIdXeYYuWPx7avj5ptH2yr+s/HBz6zUGDFsp
	A7Kt61yzzf6ZAz6l4
X-Google-Smtp-Source: AGHT+IEtNr9tIyfdS4Z5+3OPGbZFCCW4AxkgVbCTYKpGBwPpPyvIp8dl3iL1QeEGzxZy5ObvSW19GQ==
X-Received: by 2002:a05:6000:2505:b0:3b7:8880:181a with SMTP id ffacd0b85a97d-3b9e41793e2mr819501f8f.13.1755123212601;
        Wed, 13 Aug 2025 15:13:32 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b911469bffsm7837565f8f.36.2025.08.13.15.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 15:13:31 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: aleksander.lobakin@intel.com,
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
	kuba@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	sdf@fomichev.me,
	vadim.fedorenko@linux.dev
Subject: [PATCH net-next V4 2/9] eth: fbnic: Update Headroom
Date: Wed, 13 Aug 2025 15:13:12 -0700
Message-ID: <20250813221319.3367670-3-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250813221319.3367670-1-mohsin.bashr@gmail.com>
References: <20250813221319.3367670-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fbnic currently reserves a minimum of 64B headroom, but this is
insufficient for inserting additional headers (e.g., IPV6) via XDP, as
only 24 bytes are available for adjustment. To address this limitation,
increase the headroom to a larger value while ensuring better page use.
Although the resulting headroom (192B) is smaller than the recommended
value (256B), forcing the headroom to 256B would require aligning to
256B (as opposed to the current 128B), which can push the max headroom
to 511B.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 7d27712d5462..66c84375e299 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -50,8 +50,9 @@ struct fbnic_net;
 
 #define FBNIC_RX_TROOM \
 	SKB_DATA_ALIGN(sizeof(struct skb_shared_info))
+#define FBNIC_RX_HROOM_PAD		128
 #define FBNIC_RX_HROOM \
-	(ALIGN(FBNIC_RX_TROOM + NET_SKB_PAD, 128) - FBNIC_RX_TROOM)
+	(ALIGN(FBNIC_RX_TROOM + FBNIC_RX_HROOM_PAD, 128) - FBNIC_RX_TROOM)
 #define FBNIC_RX_PAD			0
 #define FBNIC_RX_PAYLD_OFFSET		0
 #define FBNIC_RX_PAYLD_PG_CL		0
-- 
2.47.3


