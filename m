Return-Path: <bpf+bounces-79440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C70B6D3A306
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 10:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E575130042BE
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 09:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0641355818;
	Mon, 19 Jan 2026 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LSBP/iXd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f98.google.com (mail-dl1-f98.google.com [74.125.82.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC09346AC6
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 09:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814989; cv=none; b=hARWX8v0oNHaFcve7p450mai7XRsMOuEoN5uD9P5lYApORxkCvi51gERY3BRHYveavxZZCNo9DxINRjNftVlpDT+K3Co9TTQ3AcUNoASv/jVHuys4jX+wTGTrUwHLDa0toZ3AuXwpEeGrXtQ1PJHdY8aWj91mypUETjgWkMWe8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814989; c=relaxed/simple;
	bh=QgXU/7yNwhrctzlcitKYbDUmDIC7I+TCoOtStmFwLvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNEIgNRMOfRldGaWYv0wPBadAeemZnJOZpw96msUMp6VZ/nFDPrcU0DDK5LPX4gNqO4Y0M6Ty9ohUEzMyOZceUZ5IpYrieVrLmxADyg7xgLj3LPDwV+lJD5MeXj+fZXU5GAh32rYFtnQ9MlRbcaSAQombzWzWjqym3M76PCNi4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LSBP/iXd; arc=none smtp.client-ip=74.125.82.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dl1-f98.google.com with SMTP id a92af1059eb24-1244bce2c17so277396c88.1
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 01:29:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768814987; x=1769419787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fj8sUP59dWob41aCsZ9BHl56sg70okF+kqjbtKr6YBw=;
        b=ipbwpxlwgnCXY4mYnv6Ot2N7hz2xkUl8uDSXuEDSXKWddRXeOURPM3NHZqvmSFtI4Z
         pZueBeYQHa2f8sXhRgCUOHDBmPu5h9/AyLzzDW9VZXPNTQ8o94CBIut4gGociew900yl
         nb/3xitNwp1VXmpwGNzIBpfDbSOvN5olPcqtUQsrNad0vaWSk1uUyMpE6Geg+DJv5uyj
         wCbTj7AxqLc37U4OcwGwm0j2bDIBABaQ8WuDQaeK02VHK7MCvxMPThHQ3YV+OaINL4rg
         ZgrGQRh/Sgtns2966vE3LHN7EwshMEas2XQ5Xr5Xw0gxAL2im5CypTDaqt+JlAYAMIsf
         7kHg==
X-Forwarded-Encrypted: i=1; AJvYcCW6t7W979PCVTzFUJrIilxc+0jPwqsjfWSS82Vi5T9/ghwEBR8kBTG3eAp32ZBtcTHLZ1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx38ScyUObE33yP44TU7rZA/JsBK8j3yjsuRhFbo4LP3zW98hi2
	iSTya8ISDdglfWE8HfFtsYESafkhRWjSvXZzGoUFuTZU28QmQrJwYEtdBlPWcr4jQEd/LEnpUzO
	DM/QEfZiHCFGjtJMjcX+Sah5YI8Cth6M5N8DDLqWimRsgXkRLDu4wOkZ/LuUYOCWtgX7HEAOWts
	XbO30rQmRPPDhneFydxvJhpq2e/uPJQR+McDjNsb53s5FYPUT3+x44mQ77v+WQmHg+olmXt9ift
	SJMfi478KNf/E7N5VxQTFgU4Mk=
X-Gm-Gg: AY/fxX7q0OiTpFheNjmzEVxEb0EAp6ko9SB2rmCvl6I8UVBBSGK1fZ+3P2neiCFYhYv
	dW/YcAg5Hi+bpRPoSHe5g9ToXDRk5LqIXLFBYVTusYPhbLUl55+vaHcL2kaghCmlAfHB1O+yT+h
	cwXwwVS5MfV0R7KN2PqIuBrGVE7/ISYrUpd25q02khmZdqvtnYQOzpQIrPov6RV2MW41eb/4izE
	Dnyjhgicihd/i7nvK4Ndil0RnD55oAIj1K6jkbviaemv1I+MWoLO6wWy0FIHLt7sfRN8dXoBYLm
	QVIfOal16GjVl5xUslfTAcnXZDh8qrBmjy5uQ2LLBwelwyxC0AY9393LF0OAZCY+8NI/nxcnY5U
	ywRoON0pJWSUXXmHTtC1E9hqNRxpH/hG5WZ3hmcDNkEcNOhtaAXXmIXTUDn7pZ84t/KgrMoxPna
	b3Js0FUrdfn0DbvefJitx0g9qgfH6jJ18vlYWon2zC8FXVh97M0e3T7huTJXk=
X-Received: by 2002:a05:7022:221b:b0:123:34e8:aea0 with SMTP id a92af1059eb24-1244a72605cmr5524798c88.1.1768814986807;
        Mon, 19 Jan 2026 01:29:46 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-1244aecbcb7sm2118401c88.6.2026.01.19.01.29.46
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 01:29:46 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c52de12a65so113679885a.2
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 01:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768814985; x=1769419785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fj8sUP59dWob41aCsZ9BHl56sg70okF+kqjbtKr6YBw=;
        b=LSBP/iXdpJoroRaEFGxsqT0CrGJnGllNkU8VK2QsJtUFQYmadKFQIr2/x4GlFQc0X8
         LkG23hlzNPCesnNvplFu9S898ebRNxOjw9fuxz4o4lhIb2Q6/lBKe3wAZcQ69r/0vfyH
         STRDadUcWobJeHpzSls/zx6qDbS3aMgf9osPE=
X-Forwarded-Encrypted: i=1; AJvYcCU/x4vklhmpOMeUemB57X5DuilbYzB5Jbaql6fbHUOSAbmGz78BRVqEJT8XhP3I13BfRTg=@vger.kernel.org
X-Received: by 2002:a05:620a:700d:b0:8c5:305e:ea16 with SMTP id af79cd13be357-8c6a67ab9d5mr1074236685a.8.1768814985273;
        Mon, 19 Jan 2026 01:29:45 -0800 (PST)
X-Received: by 2002:a05:620a:700d:b0:8c5:305e:ea16 with SMTP id af79cd13be357-8c6a67ab9d5mr1074233885a.8.1768814984815;
        Mon, 19 Jan 2026 01:29:44 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6ad6f3sm76917516d6.36.2026.01.19.01.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 01:29:44 -0800 (PST)
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
	Kuniyuki Iwashima <kuniyu@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Sasha Levin <sashal@kernel.org>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v2 v5.10.y 5/5] tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().
Date: Mon, 19 Jan 2026 09:26:02 +0000
Message-ID: <20260119092602.1414468-6-keerthana.kalyanasundaram@broadcom.com>
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


