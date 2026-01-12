Return-Path: <bpf+bounces-78522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7435D10C1D
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 07:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C07E530CD397
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 06:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D586E31A567;
	Mon, 12 Jan 2026 06:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HULDzgV0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com [209.85.210.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0217314B77
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 06:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768200547; cv=none; b=Etxz29ytRM7VCbpBd+9zR32boM1XGe6pt2Ne3VHOs4kFRmvL4wCLlp9d/Pvty20QG995zwJwRM5O/jsUppJnz8zvbXnAxcq8f6Njg2gcdg43D4kz35ahFMUyeSgd8/dEn83O7QNneEx7HzTbscypmcrzW2Z9S3J3mX7Cz5wfASc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768200547; c=relaxed/simple;
	bh=/NupvgywEukBz4QryS1IcnmPfJQHRj4TZPz9BZQSMgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZebZlfZto57hS0UP0bDxvGaDZMtU+v9Wr8gP9cEueM6lNgkwsVgol7H16XlPIwi6KyDyfcDfMVb2qJgsFk4pH5o29GQmXhIJdzn2VDA/KkOoy0oTMMNopn0QCTrIaveP8rfp7Kr9bvGpSe0URkYgghu7wm5BV3DiobzZ4R9p2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HULDzgV0; arc=none smtp.client-ip=209.85.210.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f98.google.com with SMTP id 46e09a7af769-7c914482db2so1087769a34.3
        for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 22:49:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768200544; x=1768805344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jPMqt7OubTukSzfJGmFa7NplH3SyhzWtPIziyN+vzQc=;
        b=PDwxdk6CeOznofUmS0vw8FlKuDh4gyD1oa7Z0CduO0eLOY3gg3c3xe0qU65bzrBPxh
         DklCaxHt6aRhSGGHM7gebupuakMt9nlni7rd72THghlvCEIR/Y8DrA37su6jQE+ihxFQ
         HlpAft4OWZ8uquqT4O/rfChjCObEiFu4xypW5NiFq1ZpiePoVYCeHETUBBauXaLggUhZ
         FE2lX6UeH08i+KWlasXrp+6dvjogC/gNbTbmXob5T6KIb8HwKTSVNDNiXbS7nJupnvUP
         qzs2vOhqtCLTP/eBEJ/mgGEgtwsa052oV22VCvJcW879bjzGzD9enPNVJTvthhcb5fHv
         0sHA==
X-Forwarded-Encrypted: i=1; AJvYcCXDJtUG2V4R+vlNYusgma759d7eRYb5LzycZs4HsqBYG6EwGWxKEYeUPJLsU1q6aY2u06w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrVvcfyQ6rzxMBOnZf72QL/ruRn5/A6/ke5zikmMAPkWWb6Dq9
	JJ4r5Ys3BlTe9SrsUR1q4QThf1mb8oqwzWPRGL8Gf/OecWfTN8ZHonDPm6g+Ul0eV7OiByukdYx
	8z8w3xmwds0BWNWZf74uTqSd5VFvu/k6eVa9Ne2W2o2p9xVdIk+Hs58cjToRCy/CTg9cF9GWP9K
	t4U4HREa6dzgVWftah72+Gx3p4leCaAZqSgygvmxv/0eTZDnFkL1G60fKkAFUL5l8wYwSRNxZR7
	ygRV6bQMmCjF3NmPM8WP9OeG/8=
X-Gm-Gg: AY/fxX7sg7c6QoXcOFVLAxgFGUA0rImMv3nPGqbwRU7Do6vXe43a2RgCo84sSv7QbIS
	Um30T5gMro4kvpuKAXSJjtINVYNNwo9oPTupifuf0s9xzCT2n1IlcUlX17OqIlM5ZJMEi4Skp+v
	5adU0yF4NBJmEEWjE56/mstR0u0WIr/nbOb8TdFHowyuASJE/XyIZKhKwDCt3J1Pq7VsSIn1jIC
	hGr+yHFcfW50n+x8Q6mZA+b3Wpe67e3dEiH+K60c1i1NBSOx8XPyYkEOz487dQ9OaIr586z7VHf
	hY1MlLaRw8H802Lk//r4BezlfxVSL+Q1P1px4Cox9Y/4LalhkPb0rSTv7GfUoFnxKSdMAyNvjI3
	zRrbfvXqms/UmwW9G0VKFFLHM+9zt7tVwIRioSHIaAzAqu77ergMD/KHW+TMt+Nh7xKByyMjh2N
	JDwcAnDuLa1abeXiXOctqEwrGgIGzwZ3VVmiqx0G/zlwUt0p2ImkAFfd5kDoU=
X-Google-Smtp-Source: AGHT+IGU3Q3DTE3paAR6KyIYjM++1ol6X6uwXmSKDO3eBOccd4t/HzMs/1I8jCuuILom7vu69OstOHdhk6M+
X-Received: by 2002:a05:6870:b251:b0:3e8:952c:bacc with SMTP id 586e51a60fabf-3ffc094bcd7mr7723550fac.1.1768200544468;
        Sun, 11 Jan 2026 22:49:04 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3ffa4dee33bsm2009447fac.1.2026.01.11.22.49.03
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jan 2026 22:49:04 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88fd7ddba3fso24055676d6.1
        for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 22:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768200543; x=1768805343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPMqt7OubTukSzfJGmFa7NplH3SyhzWtPIziyN+vzQc=;
        b=HULDzgV0xNjjSDM0vQDvUI6wFElpZDOEMzhjLyc0Zk2D0LMSxBEPRLi4ELVQC2Zckj
         +t0+mYjt0a+14Ys/HHcXrEkZecSP7mRKLNoLAbvQ34qFg1tmnQlWVTfUaw17GkjwMuvP
         tY4Ic7ug4kHP2ApvIjskPOrgGh9/eHxqAw+/M=
X-Forwarded-Encrypted: i=1; AJvYcCUM0wUPqEkQyHCe0/ePFMIi6VXhKD39QZ07AZSW0Em26gJ8wI6b2pEE25uuDyhlzC779qY=@vger.kernel.org
X-Received: by 2002:a05:6214:2481:b0:70d:e7e1:840f with SMTP id 6a1803df08f44-890842cb736mr185047256d6.3.1768200542672;
        Sun, 11 Jan 2026 22:49:02 -0800 (PST)
X-Received: by 2002:a05:6214:2481:b0:70d:e7e1:840f with SMTP id 6a1803df08f44-890842cb736mr185047146d6.3.1768200542333;
        Sun, 11 Jan 2026 22:49:02 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e472csm131125426d6.23.2026.01.11.22.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 22:49:01 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Sasha Levin <sashal@kernel.org>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v6.6.y 2/2] tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().
Date: Mon, 12 Jan 2026 06:45:54 +0000
Message-ID: <20260112064554.2969656-3-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260112064554.2969656-1-keerthana.kalyanasundaram@broadcom.com>
References: <20260112064554.2969656-1-keerthana.kalyanasundaram@broadcom.com>
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
[ Keerthana: Backport to v6.6.y ]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 net/tls/tls_device.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 4f72fd26a..55b46df65 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -125,17 +125,19 @@ static void tls_device_queue_ctx_destruction(struct tls_context *ctx)
 /* We assume that the socket is already connected */
 static struct net_device *get_netdev_for_sock(struct sock *sk)
 {
-	struct dst_entry *dst = sk_dst_get(sk);
-	struct net_device *netdev = NULL;
+	struct net_device *dev, *lowest_dev = NULL;
+	struct dst_entry *dst;
 
-	if (likely(dst)) {
-		netdev = netdev_sk_get_lowest_dev(dst->dev, sk);
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


