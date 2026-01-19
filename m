Return-Path: <bpf+bounces-79439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 918FDD3A316
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 10:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AEB43071E9A
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 09:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212F53557E7;
	Mon, 19 Jan 2026 09:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bmrU6kBY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com [209.85.222.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46452355818
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 09:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814985; cv=none; b=fyK/87pIvd6V6VX7AP4flpEqU61Tw8NpQ0JQgDVUn3ffLkH8fzfIi/2W4JAy+qhMaHaobQwP7rXH2RTo5HyEG+ECBu64sBPrPQ2+iHN9LDITErfVmGhCcH5Xde8uNGWUnPTic7WJhiF91pxBn1F/d5i+znMA+HcH8pEko/3IGKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814985; c=relaxed/simple;
	bh=RWuTHL2vG6VXYYw+aleWdAzTOjFVPPbKCGWiPi4YKYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NbiK+CiqAxd5No30HiGyhQiz/tmtI8tz7abK2omlh16EmTy0gpWWZeEWrRKb3GDNR3q5uyK+qccOxb192mbcP4S8uE2woVqD/uCovrIwd5MuD3lcYHLrgZ8n0k7aoOaB0eX0CMsB9z/OtC94CCRZoEWIhWGuIWDr+f/jTOuFdYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bmrU6kBY; arc=none smtp.client-ip=209.85.222.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f227.google.com with SMTP id af79cd13be357-8c52c670401so22787285a.3
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 01:29:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768814983; x=1769419783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6I5h2vtJMAW+jL+bI0U3FZ65rr+yn6OcLWKLyGnstA=;
        b=BNQ3qSW8DU1O+vo/DAhKs6aRKHSELY0cZFDpslq9QnAUWbWGNznHJ1aQGO+OMSQSek
         2BTjnICAL1F2K0aCYde5uZYwywupJI3IbbXC+gBNAihsbdsTnbMZ6GTi9w5aLEpy063L
         qPtUwVNT2Z3OzLobAwNq9ZgqPyB+O1Ys3m/nNuVvSp1665eP1b8A9LCby20B0rHWUNw4
         y4aj6r21lUtEXYPklSAuLGJNbb5ZTbTayqapL0h9aoZ+EKjMPAkdEJ0ztgShf81yYDg/
         F/n32hhJPCGlsQfpkdCWxM/v8OERFQi/VBl3324NrpsEPuCJvZ+xjFKBuxslfZmO4wtP
         suRA==
X-Forwarded-Encrypted: i=1; AJvYcCVUyE14LGWCvPQ+IZ++zmz0JGWeGapbZ/lcITdHUf8MFglGPoigVDwZwGbg8Ulm4rar8hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YySeHXyCXC1NvAX58huX3550I47GAb6SJ6+mWqW0ybfSRVtkv7R
	Ja2X+qkkD+uLGaAXEnYxFNxRkeoWQojxKiD4L7jvmLzFT+0HiU2S6tO4rNaW6QsakVMJaTqP9PS
	SMZM9k7sX0Q85uqP6F05I8JLipt9pjVe//X/iR7C3M6DrwQB6b/0k28Dkz5IbnlFKFRnaDsv7bn
	TKGTTBEZMZ3WmE0rzWMW5DSo+vXZUxkfTK8DVwJ+hq6E0Qc26Q7neVJ1iUEl038cWTCs4dvxKAv
	+KemaE5FF7EX1oJjt/9V8fnWMQ=
X-Gm-Gg: AY/fxX5PBEAdC16RI8muhYVnh7dP1RQK17GNKuXmIFTfyMuZ5QHf2msefd1CxSZbR7B
	SyuI7v9vIomKiuWUdvEaFAlcAdcpPtK5SxgUmZTItl9oABCDHNkPv9wmoFol4Rl8VzZGyi5GdhH
	jNkjBK1rAs8/m7IzSqYUGvoEq+ac84bIrErFwQNhWE3ClzgopmQ2/LoAlyQKpA30+rfpai2YEmW
	CmaL6c+YW94nX//fYmGi1OZpKwS11JJbNL8eNWmsMNA6SikIy6sWi0T3BM2RqEnMDMBc3wsheuF
	8+ocMGCqdgQBwHIBr3B83KAiREasjSzX0R7dxZsJ2XBYqdsxBh1rDClGw1FAOvpe6mvl32fclHY
	e+mOgFBB2WKLPOr4V5tzjyQiAuk6rzLMdwpbrz+J+7dzGSTYOegxR6NsPqb2+lcz/m82cKC8R+h
	wM0MyZFSjXh9WKf5Lsc72FNdnoSVb357pN3eQ8Ct2xe3zHFfZh2DO7SOKOEhyfUg==
X-Received: by 2002:a05:620a:19a9:b0:8c5:340b:415f with SMTP id af79cd13be357-8c6a67054f0mr1094390385a.4.1768814983022;
        Mon, 19 Jan 2026 01:29:43 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-8c6a7219036sm107172785a.5.2026.01.19.01.29.41
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 01:29:43 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88882c9b4d0so9047966d6.0
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 01:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768814981; x=1769419781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6I5h2vtJMAW+jL+bI0U3FZ65rr+yn6OcLWKLyGnstA=;
        b=bmrU6kBY8jgheGuW0E+kX7911OSKXZJPfgWdr6zMMr6NFEH8fHcMd7rqeAzZawHMIV
         BTpM3jGYkKRFqAcnXVxvvSOTrpXRviMx6sY+tzy9xqpHnK/xj1D8Dez33auKxsaWIb9D
         R5j0/wufJUvM7XC8ygefW3PspBtJPosdtHhCo=
X-Forwarded-Encrypted: i=1; AJvYcCUqy3tzQIYWrKGJlUGN9klQsqyxk0oU9IPgROJi8/AR/uSL0qiauWuSkCIXggi05OWRn90=@vger.kernel.org
X-Received: by 2002:a05:6214:4c45:b0:880:4f69:e598 with SMTP id 6a1803df08f44-8942dd7fa20mr139500756d6.4.1768814981588;
        Mon, 19 Jan 2026 01:29:41 -0800 (PST)
X-Received: by 2002:a05:6214:4c45:b0:880:4f69:e598 with SMTP id 6a1803df08f44-8942dd7fa20mr139500646d6.4.1768814981167;
        Mon, 19 Jan 2026 01:29:41 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6ad6f3sm76917516d6.36.2026.01.19.01.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 01:29:40 -0800 (PST)
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
Subject: [PATCH v2 v5.10.y 4/5] net: netdevice: Add operation ndo_sk_get_lower_dev
Date: Mon, 19 Jan 2026 09:26:01 +0000
Message-ID: <20260119092602.1414468-5-keerthana.kalyanasundaram@broadcom.com>
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

[ Upstream commit 719a402cf60311b1cdff3f6320abaecdcc5e46b7]

ndo_sk_get_lower_dev returns the lower netdev that corresponds to
a given socket.
Additionally, we implement a helper netdev_sk_get_lowest_dev() to get
the lowest one in chain.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Keerthana: Backported the patch to v5.10.y ]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 include/linux/netdevice.h |  4 ++++
 net/core/dev.c            | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d3a3e77a18df..c9f2a88a6c83 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1435,6 +1435,8 @@ struct net_device_ops {
 	struct net_device*	(*ndo_get_xmit_slave)(struct net_device *dev,
 						      struct sk_buff *skb,
 						      bool all_slaves);
+	struct net_device*	(*ndo_sk_get_lower_dev)(struct net_device *dev,
+							struct sock *sk);
 	netdev_features_t	(*ndo_fix_features)(struct net_device *dev,
 						    netdev_features_t features);
 	int			(*ndo_set_features)(struct net_device *dev,
@@ -2914,6 +2916,8 @@ int init_dummy_netdev(struct net_device *dev);
 struct net_device *netdev_get_xmit_slave(struct net_device *dev,
 					 struct sk_buff *skb,
 					 bool all_slaves);
+struct net_device *netdev_sk_get_lowest_dev(struct net_device *dev,
+					    struct sock *sk);
 struct net_device *dev_get_by_index(struct net *net, int ifindex);
 struct net_device *__dev_get_by_index(struct net *net, int ifindex);
 struct net_device *dev_get_by_index_rcu(struct net *net, int ifindex);
diff --git a/net/core/dev.c b/net/core/dev.c
index c0dc524548ee..ad2be47b48a9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8169,6 +8169,39 @@ struct net_device *netdev_get_xmit_slave(struct net_device *dev,
 }
 EXPORT_SYMBOL(netdev_get_xmit_slave);
 
+static struct net_device *netdev_sk_get_lower_dev(struct net_device *dev,
+						  struct sock *sk)
+{
+	const struct net_device_ops *ops = dev->netdev_ops;
+
+	if (!ops->ndo_sk_get_lower_dev)
+		return NULL;
+	return ops->ndo_sk_get_lower_dev(dev, sk);
+}
+
+/**
+ * netdev_sk_get_lowest_dev - Get the lowest device in chain given device and socket
+ * @dev: device
+ * @sk: the socket
+ *
+ * %NULL is returned if no lower device is found.
+ */
+
+struct net_device *netdev_sk_get_lowest_dev(struct net_device *dev,
+					    struct sock *sk)
+{
+	struct net_device *lower;
+
+	lower = netdev_sk_get_lower_dev(dev, sk);
+	while (lower) {
+		dev = lower;
+		lower = netdev_sk_get_lower_dev(dev, sk);
+	}
+
+	return dev;
+}
+EXPORT_SYMBOL(netdev_sk_get_lowest_dev);
+
 static void netdev_adjacent_add_links(struct net_device *dev)
 {
 	struct netdev_adjacent *iter;
-- 
2.43.7


