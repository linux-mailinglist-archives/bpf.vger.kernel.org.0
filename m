Return-Path: <bpf+bounces-78515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 616FBD10B57
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 07:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 876D63010D42
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 06:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240A23101C4;
	Mon, 12 Jan 2026 06:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ThAgV2pu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74E71E4AB
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 06:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768199647; cv=none; b=PKvK8CpWqwP7lZlu4GP7FMeYUuGtrdo0UC+w9pXwtWhUz5bwkaB05w5f1ePvaaXUzDdPWC7cr2sVH4D2IrWEtKtDHUOzedAY6+epMHTjuD2qWlbYKRcuxrQmNx6EBK5d9DgcxgRgcmZgqU+VPmbjKU0gk21kjgIGUiDd/KvYT8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768199647; c=relaxed/simple;
	bh=QgXU/7yNwhrctzlcitKYbDUmDIC7I+TCoOtStmFwLvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ay4iU9A/bvTkOboeZ4YPydZ1rvhR+0yUCk6kLkzEQ+F7O2x6dzhfnu5IiEAVQiIXQ3rcFSFOrffnZnaRDkP6hcTXvGMZaJq5VkpiI6rJEF8xko8konjaQaLFrZme4u8uqslGz/R/1KQymwcNetKB5MNBCFTcD4kuZRYGxIb32qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ThAgV2pu; arc=none smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-81e86d7ff8eso61463b3a.1
        for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 22:34:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768199641; x=1768804441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fj8sUP59dWob41aCsZ9BHl56sg70okF+kqjbtKr6YBw=;
        b=DsWNfZsWFlD1kgvtkf6UMaMTDITLYVo2BaRoJqPaaIOvwMG4NJ7hbNrfEi+kaTR5lG
         OUt3PdrvNAkqnYlfkIRWKw7AwvB36VzwnwrnXGb7Otdwf2ao9OPaB/7jmy9BR1oTLswj
         lBoolYbgei+CNJCyyTpiyUsU2ITfixYCilGK/h+clODtsWo9WgvyFkI5fsrGr2kA0RJO
         Ui6SnN5eU/WOMM0xWDSGkhfvBtS6byQadIYtUuxldluin0sbnwj1Hi5wLoCC/z4etHdm
         aMJsrh+hPwYZTweMmJ+lht2z6QOmo/2dCpzWgxpfgwbo9UU5OHtaJT+3wrmfzBBbpZ0U
         NF8A==
X-Forwarded-Encrypted: i=1; AJvYcCV0y7Y+fCZoRaWH+hspHeNzzwj5DckWwebjnCx3t1CRb6xiTAd95IvSu/N+3b3qNujSuVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn/7E/pYHeXaZ9fMYpOPRbqqqGuO6MpC+IKBfM5pfHTLLpQkJ+
	40Q42QSyC4gsV/LARysSteUtDB8tbtBs7bzSpCHQI/EzX4g353x6+dR1+wzTI0Gh/xs6TK1A9WD
	B7SLtBNwYbojh6+uSgs9PmJDfbM4WbCGFjRKg5GAHfkbHGcRz64izUUoP8i+6RYRfzN7cSN8Ecw
	Xrq3wApb/0Zyi+TDBNVB4G9g2wMDywYOHAjLGC2yozOBMnevivj/a5PpyshwMuL8jHvUu4rCTBx
	sgAgNbV25c94/mAwa1RcOYr+2M=
X-Gm-Gg: AY/fxX6igKQLtcRYyLUG0jVLHQj53mpISpP8/bWb6WbbYyiBAcbEJ0niaZPeWzbi5Bc
	CzAj+VWFBpJ9olgy3GkVR2O4c7irQQieyXow2/axG9aD/uZp3VhruH6t6aLSB1cKBEoC617bUGr
	d57e2yAvMA89NfT1nBBmW1Pkp9W9/v66n/tdxqp3afIX8hPFqt4Jdhww5/QWH5jWqwukzXOZ26L
	Jb+7KDpflHdpW7pGUDOUePmoT6bN72xgyaM3yadog0BioJ9/NiJzcHdOttsCCwdLddSUkWglNV1
	zSoORr+YMIPuhw77GUty3fQ+aoKklwYWqrEzKQO0pyB1ElBL/p4IgtMPVJ+F1NAabnZRhUrYIGQ
	LvOrVkipyuebkxpS5C5sKj8V8JZcDfz62gjhK+mJFMSvVGwU+wrCv+L1TcYFFG7YrmGxUiVYtOM
	FNpSn+HUYWp9PP7Ain9Z+W2A2qirfqMO0JKTpKYaxBam0jtpgZzFvunDl9Mng=
X-Google-Smtp-Source: AGHT+IGMPXUpRGir0xRZy/xTbjJjviwhEiZBzdFpLYPMQ1OxSGxpsHl3CWb1jNkBT8y9UFe23gPoKxKuP3+X
X-Received: by 2002:a17:903:1ca:b0:2a0:d662:7283 with SMTP id d9443c01a7336-2a3ee436196mr117812125ad.3.1768199641009;
        Sun, 11 Jan 2026 22:34:01 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3c3bc69sm20506625ad.9.2026.01.11.22.34.00
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jan 2026 22:34:01 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88a26989018so10038926d6.0
        for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 22:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768199640; x=1768804440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fj8sUP59dWob41aCsZ9BHl56sg70okF+kqjbtKr6YBw=;
        b=ThAgV2pubm4Q7pp3q9FJDD2nM3KMDZhJFl7CqmIgihg7TH+444o1HybUOpKBLqZD3+
         nL4uRVC4EoCVe1XcLuoRra1iGqciBAevz393+GAUWs9RYsK9Ssik64JOSGZmwHv1o8nU
         VeV83qVSIoBKyUDZfMlbbWO+AF0+L9W9fKRuE=
X-Forwarded-Encrypted: i=1; AJvYcCU0mzvp5Q/v9Xmj0wb/zIq/TbNGiOf6WyYAjWQrmkQFxxYczgQPR4ivTAqTHcS3MEU2hBQ=@vger.kernel.org
X-Received: by 2002:ad4:5c48:0:b0:880:52f6:775e with SMTP id 6a1803df08f44-89084275c91mr188503766d6.6.1768199639739;
        Sun, 11 Jan 2026 22:33:59 -0800 (PST)
X-Received: by 2002:ad4:5c48:0:b0:880:52f6:775e with SMTP id 6a1803df08f44-89084275c91mr188503536d6.6.1768199639235;
        Sun, 11 Jan 2026 22:33:59 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a794bsm1472324885a.9.2026.01.11.22.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 22:33:58 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yoshfuji@linux-ipv6.org,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	sashal@kernel.org,
	leitao@debian.org,
	kuniyu@amazon.com,
	willemb@google.com,
	jramaseu@redhat.com,
	aviadye@mellanox.com,
	ilyal@mellanox.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.10.y 3/3] tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().
Date: Mon, 12 Jan 2026 06:30:39 +0000
Message-ID: <20260112063039.2968980-4-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260112063039.2968980-1-keerthana.kalyanasundaram@broadcom.com>
References: <20260112063039.2968980-1-keerthana.kalyanasundaram@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit c65f27b9c3be2269918e1cbad6d8884741f835c5 ]

get_netdev_for_sock() is called during setsockopt(),
so not under RCU.

Using sk_dst_get(sk)->dev could trigger UAF.

Let's use __sk_dst_get() and dst_dev_rcu().

Note that the only ->ndo_sk_get_lower_dev() user is
bond_sk_get_lower_dev(), which uses RCU.

Fixes: e8f69799810c ("net/tls: Add generic NIC offload infrastructure")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://patch.msgid.link/20250916214758.650211-6-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[ Keerthana: Backported the patch to v5.10.y ]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 net/tls/tls_device.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 8e89ff403073..8cf4e1651b0c 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -113,17 +113,19 @@ static void tls_device_queue_ctx_destruction(struct tls_context *ctx)
 /* We assume that the socket is already connected */
 static struct net_device *get_netdev_for_sock(struct sock *sk)
 {
-	struct dst_entry *dst = sk_dst_get(sk);
-	struct net_device *netdev = NULL;
+	struct net_device *dev, *lowest_dev = NULL;
+	struct dst_entry *dst;
 
-	if (likely(dst)) {
-		netdev = dst->dev;
-		dev_hold(netdev);
+	rcu_read_lock();
+	dst = __sk_dst_get(sk);
+	dev = dst ? dst_dev_rcu(dst) : NULL;
+	if (likely(dev)) {
+		lowest_dev = netdev_sk_get_lowest_dev(dev, sk);
+		dev_hold(lowest_dev);
 	}
+	rcu_read_unlock();
 
-	dst_release(dst);
-
-	return netdev;
+	return lowest_dev;
 }
 
 static void destroy_record(struct tls_record_info *record)
-- 
2.43.7


