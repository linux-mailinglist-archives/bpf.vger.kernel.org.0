Return-Path: <bpf+bounces-27418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 117518ACD08
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 14:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C276F283D1B
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 12:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B276152E1E;
	Mon, 22 Apr 2024 12:40:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F80152521;
	Mon, 22 Apr 2024 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713789609; cv=none; b=cLNlxmwrshfru3++cNQaKtMZk2+BjS/3wvPYMpDxa/SfZXKoOZakCvo92uQdMuY69LH2SF7TTakLK9CfeHDByQNqDeY/bATpetLak2aRWo8ps3RX3dHvOeKdytxaTaOQATUnyOjuexFg9Pbb2GIQq1eK7xoF1OEyHFzg7OtpJHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713789609; c=relaxed/simple;
	bh=UfsEjeHUgOR27rtbE3M4PujzAfOxibpW7ixsPpbhaI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=siBZgfaopCk39Si9e6VsEx0ZdaG0RnN57e6V7tmdLg1+1tN7MUHcDr0TPGwa02tL3ihxmH525tH95SBhhOSucpesSPTmA839Y24PwFgVlARQkzEu8Zf+0iH6Gacx0eJMTz+ggQRdYe1r+uWEmZQFWwbaO5nO4OUYe7LM6Zi81S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51967f75763so5100104e87.2;
        Mon, 22 Apr 2024 05:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713789605; x=1714394405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9uOh18J18K7IiJjOdRTp7+wBD9ghOrm4r66dFYnU+6Y=;
        b=Gp6yXtRLTat/QSIiJ53YiFCdtsCdW/JIn0vfJEXH2j9jTrp5akKmktyPRZsLj61Cju
         TAEfE4tlgEGN9UoaOZ5PkEaT7N+M590UVpMpDSG6kDyRfIM7fNj6URCI6PmVZIOoBPR4
         2XjtfkJMPx0X1cWpFc2D3ryr8GvBBS9QkzpbeYtzj8x1wlD9iSxIraYW9WXmjxqDmNp3
         a6cJreO5YLB/y+SdJhOsBVLcRQUR64NsRI6Kw6i6vez6ymX7y3O0a3r+f8VjGMuuJNGW
         yMIgyA11Irys+ob8/WgMl7oDiCBeiYmrIS6fmejqdp4WFfXsOEU/dyCXmb03PaIeoqVJ
         GiQg==
X-Forwarded-Encrypted: i=1; AJvYcCXGgGRslzgzkvzxXmzv1WXUO1mbHxO2DmZcOa2yKQoJCxFiQnNApIMeN7rRuM5QptFct7S3mfH9eiuYKyuL3TNeODqbaIAOce7CkRQkBRfAJ25VPTUb1jVYAOomJkv6+zBiCVXiYdxks6AjKXiV+u4bwrJZ409m+/cx3hdWWSiKIco1POg/FMr/g/0thucqQLU3G5FXLm/IYx8=
X-Gm-Message-State: AOJu0YxT6uhdtytARpZv0Mfc93VqOf6ojI8FZIU2/GvDFcuJNFP1ou6q
	tQaWOdYvUXzoE0jT3czbKV46tEneiBpbITzgt0jzPLz/Mp+7B6DZ
X-Google-Smtp-Source: AGHT+IFPaMXGPrfIOWC3xSs/FsiQyHtswf+lwwOxRqmyAAyNI/Q/4fT0q5REUlhk4xp7o5aQnfs+OQ==
X-Received: by 2002:a19:7019:0:b0:518:96b5:f2c5 with SMTP id h25-20020a197019000000b0051896b5f2c5mr7368797lfc.46.1713789605113;
        Mon, 22 Apr 2024 05:40:05 -0700 (PDT)
Received: from localhost (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id gc24-20020a170906c8d800b00a55ac217235sm1944772ejb.90.2024.04.22.05.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 05:40:04 -0700 (PDT)
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
	leitao@debian.org,
	angelogioacchino.delregno@collabora.com,
	matthias.bgg@gmail.com
Subject: [PATCH net-next v7 08/10] wifi: qtnfmac: Use netdev dummy allocator helper
Date: Mon, 22 Apr 2024 05:39:01 -0700
Message-ID: <20240422123921.854943-9-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422123921.854943-1-leitao@debian.org>
References: <20240422123921.854943-1-leitao@debian.org>
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


