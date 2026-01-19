Return-Path: <bpf+bounces-79437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 922DAD3A314
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 10:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 681C83068940
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 09:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26348355819;
	Mon, 19 Jan 2026 09:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MqgkSDpR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E959A35580B
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814980; cv=none; b=nN/w40yx8GduGaoNMpFHT92O0u4seMErE/mlugD2PN+qJuFQ2Jm4cUayLAEPJHIrpg9hReGsy3PvVqxb9wAxgyTpxSQSL9dBGAEkbvQfTUUoETSUsKa19Aeu6wR8wLMHqVYDVv0JVvIZIa18AIdvN/96CQ4CgJTgFh/vpUXDdvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814980; c=relaxed/simple;
	bh=hEuFfiVAIzcj3M75mKqycaVCpNxANYHyfkOL6P6Enrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvUE6BzCn+moTtmm7DAWMKmvM2aNjN1KdRG4eqRHMXLByCmwggqC3W4n4/MWdjcOvnCGwUkgWWoR74/oOodLbHroWnawfXbs/CWQLGpJiy0LJMMFloOKk3yyauodJSUE0/LmqMvi62OKMm19usY4od4ThrMfWfgxHL5nhVHckNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MqgkSDpR; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2a3051bc432so4894315ad.3
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 01:29:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768814975; x=1769419775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w50P3TMsI17A7OyOfUkdCQ9JI+NWMHZi/Bip0DiUgH0=;
        b=CF+cmnYlNpU6S+0kKFNf7CHG9v2pSk/3zhnVHaGPU9XydAJgMVHn34F+3IAc1kA6GN
         Lje9lDdVzfuiWna8NhK5bUZjoBJae8AQpJqq1Ly8/hWoB6EEDrL1luv7YzFBJynZC5hG
         Zp21U1lknhXXirGSm8eaxaRMUELxFmYC0dTPpdFhZcaMPjIc+fu63OZPwFzfzdnM7r+H
         5iGAqn1dBksSvVzdnEEymdv/nM8zsRT2EY9bpBA8P5IpEdvPKrm57B/CVbjCY+r5PnoL
         fLfdl5SzqGPpc8CNC6/h831962d/puqfNq5oxDb3dvGVPyAtZLOsn2BXCFtUk7v+R7to
         Ah9A==
X-Forwarded-Encrypted: i=1; AJvYcCWPNr8J9dRHUXobXjkVJVW8g7V2c2h7Ya3ywHHPNPKXNGGxNg/uWVfLH1SDAM6IrLp36Uo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/DE5p44a4OjHXkU15Vxuh87l46Fwl2NhXFMglJtPZNdxO62ws
	EnpGuQehkncBOCYcg3/t1J3VqXM6cHFHbpqP2yQ1l0F+SYIgEqEvHQ+1lW1/It5JWvimIMm1k6L
	CBLKeR80Wewtpqs0+OWahXM92ym+3SznwHsr9bGZwj3ol0rVTlasJi669A2fnUVB7fZrH6U0s6j
	kkP3kkQzdDBfqJPJEvyFHtHCSFSgmdlqjWN0BfMKC7gqWDKneJJ/EnT67TARKzRt0OPidns+TGT
	3RJC617R/RlIXgpqxyV3SfZoxY=
X-Gm-Gg: AZuq6aJnytib4nWsEUFagTQ23CTKWYggbMnNOgcgATS2CX9BJiy+xplWP7/QSNJ6GQn
	ice0fvEQZratK2XmWTX8sRzMLdQOjZ1f8FPytp3iG5/w06w2ch/pLT3Vm/nhAsqczfxGS+heErC
	NJCR69/Uil6rkzzhZxB6zt4gOIV9woBWftiEKHzQJGgv0w0Ydz9OEh8G6kLCdqF4wg3HllhF0iM
	CbEQ4Gi8DPySMl3xtIZrS9pYbzGYVqhK3JPqEayTcqKaJeo49LfoPQW0VNuh0I7tRlZDRqRujma
	HMfsJaTBp5vnqR+wx+N/uMpaQUNOVwPmAx9e5Lpe/L52vruwBoORpGAbg/dPbT1CfYfCxlaLIpb
	FjybPFGeaF6u7mfOgTnEmajX6XXAs2+u7VdzKBt+CkUo25T/mjXWQemDaSvF5MaVtYp20hFZlZL
	UbilWqC+nOlCiEBfPmoImXniNpNXExo0SVeDePdcYihxVFZVV2XtHvi8Y/URwv/g==
X-Received: by 2002:a17:903:2446:b0:29a:56a:8b99 with SMTP id d9443c01a7336-2a717819544mr76278965ad.8.1768814975238;
        Mon, 19 Jan 2026 01:29:35 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a719399a02sm14145675ad.50.2026.01.19.01.29.34
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 01:29:35 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88a26989018so7549386d6.0
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 01:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768814974; x=1769419774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w50P3TMsI17A7OyOfUkdCQ9JI+NWMHZi/Bip0DiUgH0=;
        b=MqgkSDpR1raz4ko12KVPeIM+rVaCKGlXxZVfUanpl9acIJ+N0B5vqMG7ZxDlu13rql
         0wHxTMCJ0CSnhVx8W8rTw5qIaktBV/5PQlDCHMmKxgJ21h0P7e839r31VtYxEHYv+PwZ
         PhvzMer4Ph72bo0BzVPNTaQDgz7b11aljDMCo=
X-Forwarded-Encrypted: i=1; AJvYcCUiyzCpTZTgcUgvYBYBdXC+G9i1oKfzyoLLxFhAiLAjB2xoSwB80AHAtg2hZIP3rJGuldI=@vger.kernel.org
X-Received: by 2002:a05:6214:3307:b0:87d:ad10:215b with SMTP id 6a1803df08f44-8942dbed48dmr128843016d6.1.1768814973856;
        Mon, 19 Jan 2026 01:29:33 -0800 (PST)
X-Received: by 2002:a05:6214:3307:b0:87d:ad10:215b with SMTP id 6a1803df08f44-8942dbed48dmr128842706d6.1.1768814973490;
        Mon, 19 Jan 2026 01:29:33 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6ad6f3sm76917516d6.36.2026.01.19.01.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 01:29:32 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: j.vosburgh@gmail.com,
	vfalico@gmail.com,
	andy@greyhouse.net,
	davem@davemloft.net,
	kuba@kernel.org,
	kuznet@ms2.inr.ac.ru,
	yoshfuji@linux-ipv6.org,
	borisp@nvidia.com,
	aviadye@nvidia.com,
	john.fastabend@gmail.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	kafai@fb.com,
	songliubraving@fb.com,
	yhs@fb.com,
	kpsingh@kernel.org,
	carlos.soto@broadcom.com,
	simon.horman@corigine.com,
	luca.czesla@mail.schwarzv,
	felix.huettner@mail.schwarz,
	ilyal@mellanox.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Tariq Toukan <tariqt@nvidia.com>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v2 v5.10.y 2/5] net/bonding: Take IP hash logic into a helper
Date: Mon, 19 Jan 2026 09:25:59 +0000
Message-ID: <20260119092602.1414468-3-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260119092602.1414468-1-keerthana.kalyanasundaram@broadcom.com>
References: <20260119092602.1414468-1-keerthana.kalyanasundaram@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Tariq Toukan <tariqt@nvidia.com>

[ Upstream commit 5b99854540e35c2c6a226bcdb4bafbae1bccad5a ]

Hash logic on L3 will be used in a downstream patch for one more use
case.
Take it to a function for a better code reuse.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 drivers/net/bonding/bond_main.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 08bc930afc4c..b4b2e6a7fdd4 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3678,6 +3678,16 @@ static bool bond_flow_dissect(struct bonding *bond, struct sk_buff *skb,
 	return true;
 }
 
+static u32 bond_ip_hash(u32 hash, struct flow_keys *flow)
+{
+	hash ^= (__force u32)flow_get_u32_dst(flow) ^
+		(__force u32)flow_get_u32_src(flow);
+	hash ^= (hash >> 16);
+	hash ^= (hash >> 8);
+	/* discard lowest hash bit to deal with the common even ports pattern */
+	return hash >> 1;
+}
+
 /**
  * bond_xmit_hash - generate a hash value based on the xmit policy
  * @bond: bonding device
@@ -3708,12 +3718,8 @@ u32 bond_xmit_hash(struct bonding *bond, struct sk_buff *skb)
 		else
 			memcpy(&hash, &flow.ports.ports, sizeof(hash));
 	}
-	hash ^= (__force u32)flow_get_u32_dst(&flow) ^
-		(__force u32)flow_get_u32_src(&flow);
-	hash ^= (hash >> 16);
-	hash ^= (hash >> 8);
 
-	return hash >> 1;
+	return bond_ip_hash(hash, &flow);
 }
 
 /*-------------------------- Device entry points ----------------------------*/
-- 
2.43.7


