Return-Path: <bpf+bounces-26286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A4089D9A6
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 15:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7836D1F22311
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 13:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FC213172F;
	Tue,  9 Apr 2024 12:58:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCCE1311B4;
	Tue,  9 Apr 2024 12:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712667527; cv=none; b=eG8U72+OvSTQAnyXqOf5Z+xgWi79SghO3Zt1Q0Ni59ySLxzqGQV098HqdXeqwbKtMD77RbM1H7Gk2y52LStPWeGcvMFkYK0IuvXn5VMQsrtAJvv5XMM3FMF5DQNB4baoKlQTlOEJOcuKCpASFacJOdV9R6ETiFk76LRgi0WiMV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712667527; c=relaxed/simple;
	bh=UfsEjeHUgOR27rtbE3M4PujzAfOxibpW7ixsPpbhaI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VK9vyuBouqJ33K9dfr8dHDTkbLeqdMRzSmb0HYCaoqw7zIMQ8zbsIKnKJw+D99Ho2glx4i3OFf3OZYzAP6r96ry4ktOETxxKbs3Dqlbjc2cbWzuv1kFLop3adIVa/G61Qr+ZHw9Rn9VA/PAsi0bpM9x8sXvNa9sPVikozMFevlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-516d6e23253so4212763e87.1;
        Tue, 09 Apr 2024 05:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712667524; x=1713272324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9uOh18J18K7IiJjOdRTp7+wBD9ghOrm4r66dFYnU+6Y=;
        b=dAa/PlyAuFrUHO6atIrv9MeMclNOISar3zUPIiqr1yZOlq9WJ/VC02yV/F6TQId3ru
         pKpQLaDZaLs4qJUQoRA6mXUFwtA2z6D6E09rX3jqpHjX3jf7We1NeOIacHFDJ4/LnvK4
         DMyti3Jzn7Jm9gB7PLMICqo4AJcW72YrfbHTBkm8GzyhWw0smaeoAzDxRww86Yli3J/S
         7/2CkfpJ7KSy4D3jtnS/Mv1MJ2E+2bwvYUtXWBJ904I+J5PASOoGMdtSeClh6IAypsjx
         0S5Q82tbKNohUUjnm0hbs8rctcjDN+HMVAvVCP2TgF27DEe3GfRUnnmN2TP9OsdhnYK7
         n7rA==
X-Forwarded-Encrypted: i=1; AJvYcCXqVlzbTsGhc5DDp9Dyeld3Akh30iGFzRFLANPbBvwQX5MyWgjWqz6I3j1V7GlBYbAAOve+PhzAC8pQVONZe88GMNQb7/tHPh2cNrb0Jjj/GHzeZPHa/AEyDH0ALizAg0vBbfPgwZT1tHcDIZ3kNVx3IqaHK0lhnl4vEq1NkVrwNt/V+F/7CjGNR9obgsnVkgCsPRBmYEgVTC8=
X-Gm-Message-State: AOJu0YywBHN/XyLlMxmSjOnIW3yik03UnS7rBgr9arFxPr1xUmeVcUQI
	hXruF9wQ7eiqh7/mg6rZHXGmMXYO27hLnM3NnuE3iUseDFZsK+qMrRkwDOIQ
X-Google-Smtp-Source: AGHT+IEl+OLSX5EKE8Svhc2Wiu4wKJokIxStZwY7ArPgyL/m9N/Ov3vBZPbfAeUYvjwOSj4HMJgJgg==
X-Received: by 2002:ac2:4f16:0:b0:516:cf23:588 with SMTP id k22-20020ac24f16000000b00516cf230588mr12706898lfr.27.1712667523822;
        Tue, 09 Apr 2024 05:58:43 -0700 (PDT)
Received: from localhost (fwdproxy-lla-117.fbsv.net. [2a03:2880:30ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id og42-20020a1709071dea00b00a4e657a5f1asm5633237ejc.112.2024.04.09.05.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 05:58:43 -0700 (PDT)
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
	bpf@vger.kernel.org
Subject: [PATCH net-next v4 7/9] wifi: qtnfmac: Use netdev dummy allocator helper
Date: Tue,  9 Apr 2024 05:57:21 -0700
Message-ID: <20240409125738.1824983-8-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240409125738.1824983-1-leitao@debian.org>
References: <20240409125738.1824983-1-leitao@debian.org>
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


