Return-Path: <bpf+bounces-26534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C068A1689
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 16:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3049286F51
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 14:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C9E153839;
	Thu, 11 Apr 2024 14:00:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609DB14C5BE;
	Thu, 11 Apr 2024 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844039; cv=none; b=IS44k6ds/gCQ/K/dRG8jN2GyvL1bjIB/Gn+cpdkZNA50aKu8q0BUmWPeioAw7CHWcKTS9qr5I99O7GONhS0o3f/dAJb9qfqBO04D6anM8Yek24PPwtq18Q/Fs7P57n2Q8hFlHcgKOSY3e1kCFaYXte+XpMvCskjV8jyGlJqzJkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844039; c=relaxed/simple;
	bh=UfsEjeHUgOR27rtbE3M4PujzAfOxibpW7ixsPpbhaI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4zmVnMnFYiiDGNmq9bwBtjlJr+MpmjHnVswuSNVeHroibf2Z0yEQZNWZvf8g0arOL2jL8oTLeFmB6bK+dbaHfLDgGwM3m/I5nRrUGdayIfU6Fck5BRYfmi/LMsmZz6MYFko8UwIxDO2qcnW/M6dC646YyTn8Wa4Qmbw7OLs/3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a522715519bso59361666b.3;
        Thu, 11 Apr 2024 07:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712844036; x=1713448836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9uOh18J18K7IiJjOdRTp7+wBD9ghOrm4r66dFYnU+6Y=;
        b=nl+mPFXRkngRaYaIqHU3VBlqHwGf9zLsOBIf4Z85cgxA+v2jjACTh3ctfBYLJUUMy5
         45/JQAXel6WKHYMtrpJSZ6vNlNFWWV7+tSoYK5rUIYsspSWn7Dvcn7nn6PFIUzoWj24D
         WaCynOEV1aopA5H9mAbaiI95SW3YIdTSmnxX+snLP1eziv84CJitwpcCeFjhRISnEaDd
         lrsPwLw2jtE+k3fkflpFOnsldjCe+sfOIQDKmRC7DpXlI+qlCTtRUvRhc/LkPL1aQhEh
         hy57JCduMvKS+Gr/QW8W/24nd8nJTghgff84MT7qJqQCa/yt0eR+NFOie/7rJNb301BJ
         rt7g==
X-Forwarded-Encrypted: i=1; AJvYcCUSCB3GHoBNM8Wiw8vXacbc9rVe/KHn8TMC7IL6dtHHtcBkN3aCTciJd57Tv9aaLyEqKyG+4KDwY77FlR+Ro4jacAI8VbdNMmT0je/3VSHAASuHJkB5SJ7r+KbYqs/Um+1dScKpu1IQyS73Dly/Br8WeItpckbY0OG6uWJUXQ9tfNcnjpvLrhqJnCcm5MKJyHrnQT+jJ/lRwHQ=
X-Gm-Message-State: AOJu0Yy8oxigFqoE2jf8rVE6UbgK91xdGATjI36015v74di17PhYtjb7
	VsY0Ur6pfM08vmvA78dgNJo93SKJKkjp949R2HQyRXLHD4UELmeFAG4DwQ==
X-Google-Smtp-Source: AGHT+IG9OibV43go6M08d8+CyIo5MAO/xGhgITI9zP+pb207gCt5NYcI9BhXrh1z5SWobKnlsemMOg==
X-Received: by 2002:a17:906:4888:b0:a51:9938:f77c with SMTP id v8-20020a170906488800b00a519938f77cmr3114612ejq.52.1712844036576;
        Thu, 11 Apr 2024 07:00:36 -0700 (PDT)
Received: from localhost (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id a10-20020a170906468a00b00a522d350674sm104142ejr.184.2024.04.11.07.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 07:00:36 -0700 (PDT)
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
Subject: [PATCH net-next v6 08/10] wifi: qtnfmac: Use netdev dummy allocator helper
Date: Thu, 11 Apr 2024 06:59:32 -0700
Message-ID: <20240411135952.1096696-9-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411135952.1096696-1-leitao@debian.org>
References: <20240411135952.1096696-1-leitao@debian.org>
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


