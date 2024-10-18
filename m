Return-Path: <bpf+bounces-42486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF8B9A489F
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 22:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A775CB21E64
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 20:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520E7204026;
	Fri, 18 Oct 2024 20:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="kPC/mYQ4"
X-Original-To: bpf@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (saphodev.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6CA18DF88;
	Fri, 18 Oct 2024 20:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729285168; cv=none; b=sSGvFp+MVhah+wdIUfnCqylwiY2TqG0D83eTP8ri7VEr++0vZwRpwK2UPNbYVen5d0WD7D0TbIdYROfzxkWqKw0gn4UxexMdciTpafuPMcry+aDa+3RnCEOnbFnRh8F/Me6fM5auudPzK3x7itWDrtF1pB9t1/ZJLiERsVqYjAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729285168; c=relaxed/simple;
	bh=+tk2cpjGb3VNztKsp+kLY6AgcFI4WOO+Igx1tj7XyyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=srm/634h1wTkyjLLI5eljSATBpyh5OQ2B5BVt+NvsgCO99eIx8SZmCC5EbOQfqFBFG4pd3Y2sect6WD4ZD/VZMIOQnbA8HdvwZA39rw/vPFbDj5j9jMusEJBeItuPxRNRLnJdEQW7h0a8sXRkJrkoEQVNxeEMjmdg6mvYzjQum4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=kPC/mYQ4; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 41CA6C003AC6;
	Fri, 18 Oct 2024 13:53:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 41CA6C003AC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1729284817;
	bh=+tk2cpjGb3VNztKsp+kLY6AgcFI4WOO+Igx1tj7XyyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kPC/mYQ4uyTcj1Qj8161HBaROhFebCA0lwe35Zi7cngX3PHuDg8qVgmfRgi5ga8Kw
	 FH0UxRHEVFMovYUBwLgN7p6721mq3U6mfE/QO/jnzstcsZm1AYCvwZriqDySHMLvQC
	 o9Sf2hgsXr15qUKVLgI2aB5WtF2Bbj1mZYS/i9x8=
Received: from pcie-dev03.dhcp.broadcom.net (pcie-dev03.dhcp.broadcom.net [10.59.171.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 8E7AB18041CACA;
	Fri, 18 Oct 2024 13:53:36 -0700 (PDT)
From: jitendra.vegiraju@broadcom.com
To: netdev@vger.kernel.org
Cc: alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	jitendra.vegiraju@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	richardcochran@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	fancer.lancer@gmail.com,
	rmk+kernel@armlinux.org.uk,
	ahalaney@redhat.com,
	xiaolei.wang@windriver.com,
	rohan.g.thomas@intel.com,
	Jianheng.Zhang@synopsys.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	andrew@lunn.ch,
	linux@armlinux.org.uk,
	horms@kernel.org,
	florian.fainelli@broadcom.com,
	quic_abchauha@quicinc.com
Subject: [PATCH net-next v6 1/5] net: stmmac: Add snps_id, dev_id to struct plat_stmmacenet_data
Date: Fri, 18 Oct 2024 13:53:28 -0700
Message-Id: <20241018205332.525595-2-jitendra.vegiraju@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018205332.525595-1-jitendra.vegiraju@broadcom.com>
References: <20241018205332.525595-1-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>

Introduce new variables plat_stmmacenet_data::snps_id,dev_id to allow glue
drivers to specify synopsys ID and device id respectively.
These values take precedence over reading from HW register. This facility
provides a mechansim to use setup function from stmmac core module and yet
override MAC.VERSION CSR if the glue driver chooses to do so.

Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
---
 include/linux/stmmac.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index d79ff252cfdc..4c4965a5a0d0 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -183,6 +183,8 @@ struct dwmac4_addrs {
 #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(12)
 
 struct plat_stmmacenet_data {
+	u32 snps_id;
+	u32 dev_id;
 	int bus_id;
 	int phy_addr;
 	/* MAC ----- optional PCS ----- SerDes ----- optional PHY ----- Media
-- 
2.34.1


