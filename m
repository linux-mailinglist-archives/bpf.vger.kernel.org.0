Return-Path: <bpf+bounces-26421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F032589F40B
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 15:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E92FBB2A658
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 13:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2196F16F261;
	Wed, 10 Apr 2024 13:18:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401D315ECF9;
	Wed, 10 Apr 2024 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755103; cv=none; b=fZncUUE5PfwPqOxmd7YOdtGmlfNaIsw2CXsG+xYwfSVV3IymDEXuKTc1z3ony9OEg2Z24l3gNL+JZGK4j8iKUr8jkOviwSNpNnd7NTksPs5+8INjP6NoYlyuwhxQz6Qw2lRosWRAqg5IKWgGL71KBR+0C4FeCy0zVCUGzV8Q5T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755103; c=relaxed/simple;
	bh=UfsEjeHUgOR27rtbE3M4PujzAfOxibpW7ixsPpbhaI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jc5yeOxffcY2SeB7LYFoKcqkGMBkiz1achTbHhkVQMp02BloKISJXCgm/YFl0W1KAf8qsFjk/MsbRtzoNRHtCAcuQ14TRPaVrfY6LtLmEUnDbXeGzRAKOnWMeuWhPC1Jx5pjunx/irlcmBAfaJZg42hwXDuGp+9jmQkiJSRElIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a51d05c50b2so438055466b.0;
        Wed, 10 Apr 2024 06:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712755100; x=1713359900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9uOh18J18K7IiJjOdRTp7+wBD9ghOrm4r66dFYnU+6Y=;
        b=JRisMv84zLx1NK6e88XL+oaCntppGWwIPJS53o5EAS6Q7+vZVpfkfRTWsds4+bKHpV
         8LL3jdbZ9s0xK0Y4bb+w2Ndyh3C3sJGqUPR4Yn1fElh4USJkuOZLNHpOI4TjYety3V6z
         Q5zog/7duoyDYxtem1fpYadmOCh9coSzjDfFiI8bA1LqdGwP44mJvGgfCnwWpDTqtKVC
         +Nl1hxkEfDKz+nuQlGB4H+Xenq51WuNAzZaZ8A2USUHPMgDFbplSF7WMcbpjn0Ckg7j+
         lF9Fxgx6tmRDfbGIOzbchsa92wXEmbr5Zw/fAJ+xczPW1cB4E0F4x1pQwDaKq/czKTov
         wE9A==
X-Forwarded-Encrypted: i=1; AJvYcCUGihqV51Ek3VqQQkJYqUmZVYAiB4cT+l65tcRncMN6TbWUnu4c5DcXIvgkGeeFUNqM22uwVhLhS0SevvEMxg5yEey7pAuWIGO/+CZ+jIpbPS/XEhdLvrPVMYyzx96NWd25XkS29b12XPSpkk/lTbkqYnm9cVudatgPgyBriwS14CVH0ir+VXWZ/ltzSI73rxXNc7OzC0dwqTw=
X-Gm-Message-State: AOJu0Yxc7ea5oIRgIVVJKiUqsI495uKnC7747mY5iAgjES4lMm/RCDHz
	L5G7mPJCGrG+4rB/h0vAYGh91OutgFZoaZ2KaU6yhQobllduIsg6
X-Google-Smtp-Source: AGHT+IFr2S2LI08jI8XIroOmyyE/85QrJ6Hsd+T5Ighzae4CMX/NDkh7+a/IOM6kncoda2BU+ME9hQ==
X-Received: by 2002:a17:907:7ea0:b0:a4e:6957:de25 with SMTP id qb32-20020a1709077ea000b00a4e6957de25mr2199693ejc.57.1712755100549;
        Wed, 10 Apr 2024 06:18:20 -0700 (PDT)
Received: from localhost (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id qf15-20020a1709077f0f00b00a47439647efsm6935601ejc.133.2024.04.10.06.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:18:19 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: aleksander.lobakin@intel.com,
	kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	elder@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	lorenzo@kernel.org,
	taras.chornyi@plvision.eu,
	ath11k@lists.infradead.org,
	ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	geomatsi@gmail.com,
	kvalo@kernel.org,
	Igor Mitsyanko <imitsyanko@quantenna.com>
Cc: quic_jjohnson@quicinc.com,
	leon@kernel.org,
	dennis.dalessandro@cornelisnetworks.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	idosch@idosch.org,
	leitao@debian.org
Subject: [PATCH net-next v5 08/10] wifi: qtnfmac: Use netdev dummy allocator helper
Date: Wed, 10 Apr 2024 06:13:49 -0700
Message-ID: <20240410131407.3897251-9-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410131407.3897251-1-leitao@debian.org>
References: <20240410131407.3897251-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a new dummy netdev allocator, use it instead of
alloc_netdev()/init_dummy_netdev combination.

Using alloc_netdev() with init_dummy_netdev might cause some memory
corruption at the driver removal side.

Fixes: 61cdb09ff760 ("wifi: qtnfmac: allocate dummy net_device dynamically")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c b/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
index f8f55db2f454..f66eb43094d4 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
@@ -372,8 +372,7 @@ static int qtnf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto error;
 	}
 
-	bus->mux_dev = alloc_netdev(0, "dummy", NET_NAME_UNKNOWN,
-				    init_dummy_netdev);
+	bus->mux_dev = alloc_netdev_dummy(0);
 	if (!bus->mux_dev) {
 		ret = -ENOMEM;
 		goto error;
-- 
2.43.0


