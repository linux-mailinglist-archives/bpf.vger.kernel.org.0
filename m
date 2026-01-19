Return-Path: <bpf+bounces-79436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6519D3A30E
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 10:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 591C0304B3DD
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 09:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8500135580B;
	Mon, 19 Jan 2026 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="THCfU7US"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B6C2773FF
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 09:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814974; cv=none; b=LCywAOBO9UViV2TksO+VpNHMWAWzZiSHLsQeRD7REhp+vvn5YinI/ztB6n/DoCIhd0RVQMQtMtyAHqhb//ztvnAcMPeKl7Wdyox+Sm/9qaiHdv6Z9q0W+jKnIAWmV9TWG+eT++ZmufTcNvg0qwiNgjjq/u07/VL05azvzn0JpRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814974; c=relaxed/simple;
	bh=k9ee2EKB4tUDptolbhgjzpwxMShTN6LfTKyBbETaVxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJJf9aKt4wPKG8popxogeYAyITi64++EbKdtMvXrrF/mSD1UHy/3hNfVQl9NyoPE267wji8rwrCRkkAxWCuxSScObGLTMUDM15ZmO1a0XhR0N4X/zpUZC4MPBSYXffbVUjuuR9pD/WzeeBcpFh7xz9G2qgZkFlVWPnIsnpFdGJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=THCfU7US; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2a08c65fceeso7156655ad.2
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 01:29:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768814972; x=1769419772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TVi5uHDjVopShqD0MnuBnlMmLMJhBdagK4kolEfksCA=;
        b=TQhKaRcRmM+ToX4DgqFiskFXr4E5Y8+YZDc/TRtXhrCaF0OXydqtLr2vd3QDxeFMRW
         Bl+1Se6TdpQz0kum6JOJCCL2dfnkgYRFmrYYmomO71Jk6EDA+wFvZChlfW+qjIMO/oQd
         JdQgqYaqslj3L14h7Kxy3Z88hVVUp+egTmwO4A9wVpxARUiWmkMHdgyFJMLR1WmzU9Ef
         D+U32CY5SXrywdvdIi84wfFmVZYsQOGkqBSd7PvmWZaOtHzsN5FoP7eXgCrHIZ6M2SSU
         5NAmeCm87trM21F42NbOkc+NqiZ9Uj+PufQDSC9fuMN/eT/qDG7bfwGjwqbWMw+eNtXA
         RB5g==
X-Forwarded-Encrypted: i=1; AJvYcCV7L3JarsqbIVv8FpusEeKLzWOTTfLwZvlCq5L2Xkstc58bZJciP7wuMERR2PvOhxAIC7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrjn8St8a0BcLijzQ5gXS85/COG2qtj6xKokUiNv86X04vjGb1
	m6Oucp3LRt8VHi7Tr0iLa9hq4b6QbwT6xdkFppJrH6NfZTN7Ca9aQzt70arkt9oh5cE3MYa/9hs
	LPnCRluMD31wBVABPejpCaXK2Kn8faPpYPw8UVQbSz67A1bkbS9N2W8QDn+nh2dTDNjtFicuajw
	AJ8P2CE6F5HEhPg8NXEkIsPIUL9ziXv9by3HghNAiJVIFOiKOQ8VUGh8EObqj8g4kZai/iMSYrs
	9Bb1XecQmsAo7W9fMKrVD+n
X-Gm-Gg: AZuq6aIOrV5v28qpl6Acick/1CDwpmIfp22TU6XkSKo/CJsB1D2SUBYQnmjRymm0AjG
	W0ayPnTPRCr+ow+jfPkGT/iAlxIIUtjzOH0TrKTz50uHya0fS+UOhOMF24E38co1rtnH1aPzAx8
	o/jtpx0MkzD+88kx3DzXhoBb3SbR/mbyeVNdLTmmPVM49fMeVS8YA+8tBvz04SVivPmISb3HaQS
	9WOO0zqWl84RQDL+t2emRPLFsuitWl2uGwf2pjl3lCiHSeqaF3HsftlfvshBwJrzevPibhRsGiR
	S1ijp21g5xZeW4Om51SKUOaE0mNhwQ+koTDpjv6hv5tGyLrOzfSpMxN7CzXD+AawviNgWCUOXHN
	JR7uLQOu8SW4CbIbTAVvTNQRnEmLLPQ4b9yeFS38NLGNTXmN5OWJQW9OnNziX36sn/HTwNpsXmZ
	TGQWdMz1u/zUTQPX8j8oNlGWSZAadTXBjrtwkw+EMb6+VrVyDgJ9kKXeSakOwFEP0X
X-Received: by 2002:a17:902:e944:b0:2a1:3846:a750 with SMTP id d9443c01a7336-2a7173fdf1bmr73941455ad.0.1768814971886;
        Mon, 19 Jan 2026 01:29:31 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a7190a3360sm15020875ad.4.2026.01.19.01.29.31
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 01:29:31 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88fce043335so15793926d6.2
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 01:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768814970; x=1769419770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVi5uHDjVopShqD0MnuBnlMmLMJhBdagK4kolEfksCA=;
        b=THCfU7USWNQ4UH1S265jT3wGRV5O6VNkJ6P2dRuHdDc3HzBTT/S6pcIuz+XhZcn3K+
         4Vq5WQiVSJKcT+CmASNgwAbPSp4gPNpt4j1bGdccBhm60YL9GST6c6kCjTiic+1LcU7b
         b9F4UTNjvXoATrcLKAEZPTKt+iRso0mMbSBzc=
X-Forwarded-Encrypted: i=1; AJvYcCWHdr9vQ/uRvjAW3TToIDOM+RMtoICAife9MlO8RGAwt1wVYcphWADoddoTJE3FLCaqEjY=@vger.kernel.org
X-Received: by 2002:a05:6214:6118:b0:889:e38c:d13a with SMTP id 6a1803df08f44-8942dd9eeabmr85587376d6.5.1768814970550;
        Mon, 19 Jan 2026 01:29:30 -0800 (PST)
X-Received: by 2002:a05:6214:6118:b0:889:e38c:d13a with SMTP id 6a1803df08f44-8942dd9eeabmr85587146d6.5.1768814970119;
        Mon, 19 Jan 2026 01:29:30 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6ad6f3sm76917516d6.36.2026.01.19.01.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 01:29:29 -0800 (PST)
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
	Sharath Chandra Vurukala <quic_sharathv@quicinc.com>,
	Eric Dumazet <edumazet@google.com>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v2 v5.10.y 1/5] net: Add locking to protect skb->dev access in ip_output
Date: Mon, 19 Jan 2026 09:25:58 +0000
Message-ID: <20260119092602.1414468-2-keerthana.kalyanasundaram@broadcom.com>
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

From: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>

[ Upstream commit 1dbf1d590d10a6d1978e8184f8dfe20af22d680a]

In ip_output() skb->dev is updated from the skb_dst(skb)->dev
this can become invalid when the interface is unregistered and freed,

Introduced new skb_dst_dev_rcu() function to be used instead of
skb_dst_dev() within rcu_locks in ip_output.This will ensure that
all the skb's associated with the dev being deregistered will
be transnmitted out first, before freeing the dev.

Given that ip_output() is called within an rcu_read_lock()
critical section or from a bottom-half context, it is safe to introduce
an RCU read-side critical section within it.

Multiple panic call stacks were observed when UL traffic was run
in concurrency with device deregistration from different functions,
pasting one sample for reference.

[496733.627565][T13385] Call trace:
[496733.627570][T13385] bpf_prog_ce7c9180c3b128ea_cgroupskb_egres+0x24c/0x7f0
[496733.627581][T13385] __cgroup_bpf_run_filter_skb+0x128/0x498
[496733.627595][T13385] ip_finish_output+0xa4/0xf4
[496733.627605][T13385] ip_output+0x100/0x1a0
[496733.627613][T13385] ip_send_skb+0x68/0x100
[496733.627618][T13385] udp_send_skb+0x1c4/0x384
[496733.627625][T13385] udp_sendmsg+0x7b0/0x898
[496733.627631][T13385] inet_sendmsg+0x5c/0x7c
[496733.627639][T13385] __sys_sendto+0x174/0x1e4
[496733.627647][T13385] __arm64_sys_sendto+0x28/0x3c
[496733.627653][T13385] invoke_syscall+0x58/0x11c
[496733.627662][T13385] el0_svc_common+0x88/0xf4
[496733.627669][T13385] do_el0_svc+0x2c/0xb0
[496733.627676][T13385] el0_svc+0x2c/0xa4
[496733.627683][T13385] el0t_64_sync_handler+0x68/0xb4
[496733.627689][T13385] el0t_64_sync+0x1a4/0x1a8

Changes in v3:
- Replaced WARN_ON() with  WARN_ON_ONCE(), as suggested by Willem de Bruijn.
- Dropped legacy lines mistakenly pulled in from an outdated branch.

Changes in v2:
- Addressed review comments from Eric Dumazet
- Used READ_ONCE() to prevent potential load/store tearing
- Added skb_dst_dev_rcu() and used along with rcu_read_lock() in ip_output

Signed-off-by: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20250730105118.GA26100@hu-sharathv-hyd.qualcomm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Keerthana: Backported the patch to v5.10.y ]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 include/net/dst.h    | 12 ++++++++++++
 net/ipv4/ip_output.c | 16 +++++++++++-----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index 9114272f8100..b3522d3de8c8 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -547,6 +547,18 @@ static inline void skb_dst_update_pmtu_no_confirm(struct sk_buff *skb, u32 mtu)
 		dst->ops->update_pmtu(dst, NULL, skb, mtu, false);
 }
 
+static inline struct net_device *dst_dev_rcu(const struct dst_entry *dst)
+{
+	/* In the future, use rcu_dereference(dst->dev) */
+	WARN_ON_ONCE(!rcu_read_lock_held());
+	return READ_ONCE(dst->dev);
+}
+
+static inline struct net_device *skb_dst_dev_rcu(const struct sk_buff *skb)
+{
+	return dst_dev_rcu(skb_dst(skb));
+}
+
 struct dst_entry *dst_blackhole_check(struct dst_entry *dst, u32 cookie);
 void dst_blackhole_update_pmtu(struct dst_entry *dst, struct sock *sk,
 			       struct sk_buff *skb, u32 mtu, bool confirm_neigh);
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 1e430e135aa6..3369d5ab1eff 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -429,17 +429,23 @@ int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 int ip_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct net_device *dev = skb_dst(skb)->dev, *indev = skb->dev;
+	struct net_device *dev, *indev = skb->dev;
+	int ret_val;
+
+	rcu_read_lock();
+	dev = skb_dst_dev_rcu(skb);
 
 	IP_UPD_PO_STATS(net, IPSTATS_MIB_OUT, skb->len);
 
 	skb->dev = dev;
 	skb->protocol = htons(ETH_P_IP);
 
-	return NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
-			    net, sk, skb, indev, dev,
-			    ip_finish_output,
-			    !(IPCB(skb)->flags & IPSKB_REROUTED));
+	ret_val = NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
+				net, sk, skb, indev, dev,
+				ip_finish_output,
+				!(IPCB(skb)->flags & IPSKB_REROUTED));
+	rcu_read_unlock();
+	return ret_val;
 }
 EXPORT_SYMBOL(ip_output);
 
-- 
2.43.7


