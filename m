Return-Path: <bpf+bounces-78518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB607D10B91
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 07:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DBD9B30200BB
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 06:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08A1310762;
	Mon, 12 Jan 2026 06:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T6ThGJ9F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com [74.125.224.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CE9311592
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 06:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768199944; cv=none; b=EMqhuWWYOVHcKYOIF9baidDq2MQ7fs6lk1aMCDcxcw7+St0Q/9z1lcKV2AzyGL0LZS0XUb/LdHsrJ1iYcAE0E4UdHgHplrghZLBpR5qi6rp6mMdKlPPSyNkYGjh5zfqKLwbVPciGHwsVKGq/Z95RMYgcfbHcwrYFDt2fxdOim1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768199944; c=relaxed/simple;
	bh=XjmEkDhy70C9BPaUIKs8e1nglyFuMhkb7Yn1iqBTdVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LfGcTxJGney+koA8KI7q61fRQ6/CZFFQ0a/pLIVl6PFLbG+8MPNbtRVXzszAbqG0KPpFsVa3X30lBEs7FQfSJGERB4OfJkYWjf1DoSO5UUQpxNtRUKKAgimpTfcMUwvn3/an/sIpo5zRn7qJE1VQtNE/xvxZYS35/+1/LQ8wbBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T6ThGJ9F; arc=none smtp.client-ip=74.125.224.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f98.google.com with SMTP id 956f58d0204a3-64324e8296aso707149d50.3
        for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 22:39:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768199940; x=1768804740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o/toLEsajSo6fO5hRJUdPGrIZ19DquBDTOLbcgJFlJU=;
        b=fTU149jqPC12UsD3ttzNrQZwlciEXOXyGeLBWnr+BsYJW8K6HxJGdm65vpV5yzy6pG
         dNaXBybTck1+ukAfFT9Pi8CBigKVES5kfesT8U3Q5+4AA2YKsLFXLJ/VN6XkfqtOnbD+
         8KSTGk14uq8kujzyyBzyXdGwQD+qn11q0R5QKrBwGBfoG1J9LvQJ62KPtx7Q5jeKjnQL
         6kGo7zT+AwBT+JnenmHOs1bzERIhe20Hh8gh2GEr9xf4tK2IxcI3sadenNqj9ZQNXSTy
         mAXZFSmpMe1kG4RUNdtb49DykCMkPGvngqpsl05WnKMTX4Izjyd4RHgYBKpM3sXye1Er
         MI4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUd2C8vGmnBe5KUQ1ln+pczjz1K/d+KuLxl/KAVZpfrUNpRYmQzmXsk0WiJQPfi1LP0pg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEaIPQAVGGzIuMGGqfqM3PcMZyFy/NnY+ISH6wzGr/UQKxbOoB
	TPLgQPgSYtjE9gVmmNPIrA/TmvvVXERsgYeoy8LoEgh6OAzt/rW7YUcm+50/HrEMLl2IYVgbwed
	W4su5UTfojrJ07Z6yiPS+HNGSHbw0KeJu6jvI8K2rTkiZvb3AnZ9+ng24qxMUEnTbWbMBq/cr2q
	VKKNY+Yvu+KXZTbRNs4FVn6/WroxDxcyLvtQOJn1uUka+MG4ybrQUKOeucGfdYUHfwUUamiTbJd
	IV/t/K9FifT1ktLfDr2/vICznI=
X-Gm-Gg: AY/fxX7l5nd4ysRQw8x/owHs1HjcWynOf78Y5WdoCt/o6bVQl/tNwhrTfgtYoMR1CBT
	3IHIMLgfaa09Nuh9sciDDGYBuE1mbDbcJfWQvLbUJxJv5gOpGwBxQ86TSM0saEmWmU4s/BNCIoV
	RFpYCDw8lYV5UuJsWOSLgd3LsehIflRTQh7WG3TZL8S7NU1W4rI/WR/AzIrBL1s6YeTUVchfhRC
	a3Hgy5X2drFgjjL5b5xOKKcI0iCiGmoFZf59oyM5/c9hRBBb7eL3pLWcNwHYtfFmIoOAX7pkanU
	mYzSQsymOIxmzBMC+9GTMZkFKz+YBls1YJa73RE66d1WmqKETupeb4EmwZaoIG7JW4QP/TjInV8
	5ifuXUjA5+vAERk4Ej4sFUvwWWBdYkOfKX/bAiZuOeAgCJp7LL/MKb5HuXIEZk9p7nwc2fVJT/6
	0GNWFv4Drhib6kbuxOTrv80pWISDaCUbB8yPyAu0Qh344bEPhnXySWTzeack8=
X-Google-Smtp-Source: AGHT+IEchrPAAvvTrW9tUVLdWMpxV/Z877SSpgz4R+hnHMwpYigOOJa74259jgD/UbwP+qGFHM4f3Nk0wNHS
X-Received: by 2002:a05:690e:b8f:b0:646:e25d:cc21 with SMTP id 956f58d0204a3-64716d51186mr12014019d50.8.1768199940023;
        Sun, 11 Jan 2026 22:39:00 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6470d81b3e3sm1588438d50.4.2026.01.11.22.38.59
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jan 2026 22:39:00 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4f1aba09639so16672451cf.0
        for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 22:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768199938; x=1768804738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/toLEsajSo6fO5hRJUdPGrIZ19DquBDTOLbcgJFlJU=;
        b=T6ThGJ9FNIC6rMU07ILVmsrUuHVwUkSiQ2lPUMoR+OPEv1PV94ggUYzce+ft5+IO+o
         Krwe3l543dqa6cfVGaLTs/DI4NsFjmrGdverjfdZa94qmiQA1gfXIj4fCpHZhMD8kMJM
         H9CzfCEuj9pY6D3IRtrdJwYK/Ged64JSoL1yY=
X-Forwarded-Encrypted: i=1; AJvYcCW6niU9fqrVSeE5owEQX6ObYtUogALuT2vcIWEzj7uJ/W8Hrf6WMpaI+gXkqH3KagHtGJc=@vger.kernel.org
X-Received: by 2002:a05:622a:408:b0:4f1:d267:dd2b with SMTP id d75a77b69052e-4ffb47d22b1mr178117531cf.1.1768199938536;
        Sun, 11 Jan 2026 22:38:58 -0800 (PST)
X-Received: by 2002:a05:622a:408:b0:4f1:d267:dd2b with SMTP id d75a77b69052e-4ffb47d22b1mr178117401cf.1.1768199938113;
        Sun, 11 Jan 2026 22:38:58 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e2833sm126594216d6.18.2026.01.11.22.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 22:38:57 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yoshfuji@linux-ipv6.org,
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
Subject: [PATCH v5.15-v6.1 2/2] tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().
Date: Mon, 12 Jan 2026 06:35:46 +0000
Message-ID: <20260112063546.2969089-3-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260112063546.2969089-1-keerthana.kalyanasundaram@broadcom.com>
References: <20260112063546.2969089-1-keerthana.kalyanasundaram@broadcom.com>
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
[ Keerthana: Backport to v5.15-v6.1 ]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 net/tls/tls_device.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index c51377a15..e79bce6db 100644
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


