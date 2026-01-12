Return-Path: <bpf+bounces-78513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 319C4D10B66
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 07:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52B013067DEA
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 06:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7399F30DD2C;
	Mon, 12 Jan 2026 06:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="K8mF+/mX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f228.google.com (mail-qt1-f228.google.com [209.85.160.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9916D3081C2
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 06:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768199636; cv=none; b=j3obn0i4xxqXMhofjwzinEKL/9XkEECi4rp1HiOFg4DvptHWP9eFcGaGNb4nKvTQ099cp7hbdSQtgFFVb8YV/YCuiPvdwqMDvigLIKzI5z3kKu3wXuBMXrUqfmBGdg+DQTVlY6WgwHWNw8doNrg8tfop/H2PfflDJkceAdzcJGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768199636; c=relaxed/simple;
	bh=k9ee2EKB4tUDptolbhgjzpwxMShTN6LfTKyBbETaVxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FR/1DrJF9gri1TqzwBjGSJjg1CUQZuqkANcVn6wRKqHJ048yq0l5eHN/GTuvPIYN5RA7yC6errD93Cq7MdjEbDLv+/QOKDs17HWPCoT8G9FRh7SouFHgvbT9rybrVdI/7INm2qlXr/zIMlg7sBpmQYmsWHALm7I9ACl1QB1BPj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=K8mF+/mX; arc=none smtp.client-ip=209.85.160.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f228.google.com with SMTP id d75a77b69052e-4ee28771052so10136231cf.1
        for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 22:33:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768199631; x=1768804431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TVi5uHDjVopShqD0MnuBnlMmLMJhBdagK4kolEfksCA=;
        b=Ncg8JGItfuTAoWjO3Q0xDWu/7f7ZLn2CRpEwIXjSEapXdqu0czCHAMgApdvPA/ubA3
         WBvKlx0LCDgImtHkSNztHQHKlpz8RzRuBYXsBpelT6RsZDgI9SOqhfJFNNTTK3dqXXlO
         uWCs5SOMIyGdLGntiRrJmjESpZzXulid+MrxrqUxYlLWEaQmEUZ3ZCiAdIN/yXKhboo5
         s/CDGIRn/SdEj9H+1fjVhXHUaRuPGPbnfdt0N8EBvfJjnG20mfN65/2SCO3Au8H0LCcG
         SXyZ3BxEr0RybQxg21xA4vScuAvanZqv0thXVuNFOT5YlwUKoZiaFGG2XprzPfoPqZBA
         jf6A==
X-Forwarded-Encrypted: i=1; AJvYcCVLYmz/u6Hk3MhP5L+LQ9gyVECTsC0NoE/zH2fDjk9s4ZOUwB6UgSZJ2WPhnQ9jGdO1XWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4wp+3rOhFm1jmQCTFS5FwyvRkz5QdAHd3hu0ku36bXnjDSR1o
	SsUWcK1N7dOOil7KpoWyRk6Y8KElZoVftGAHX86qRiHLzKEPgrSo4W2RqbjPne70XIheYLbgwoH
	XOtuCCiz6T0+azezEFGrXA5mhqMbgrfs+HoYhwEoFLt615cvwKKBWV5KX4Re0wa4C6eBtVTE4vg
	0q5+MvKoMUJQOiczygvZ2kXzP/Jm9K1Zyo1fweY3LQQdXlOX8/FlmCM5md9etkPRHeJL/mwNY2V
	OIhqwxGInBFVhaPP/B+XPGjpBI=
X-Gm-Gg: AY/fxX6dQFcFh/ePT3dKqPFRGiGAdaYGcmoQD8jXpcochIAK9DmgMsfV1yPmgT1S6Dk
	7Yo+u3aLxohdCyWIhNEu8rJvF82/rfP83CWXdxOIso3zBayf5KRfk+QSKugddMF0D4RkYtngiAK
	Qnh6D6lYUZ1yUWtRQIXXyM67Crs7l0fo9dX8WLwK1XUywlBme6f/6MQw8+B7QabPcAiuwPEYN+c
	4FZeoC5uZUhcSFLGRx8G6YclJ2h+Rc429jBufuXjZU4UPXaGDJh5zMtGHk3fLLrYNCkocNg0WSR
	fnT763RzbXChI/5ZaH02gs22FAiNF93e1ARCyqe4aAAiWnpocCHHjZZJzST1EbgmCH41m4tkLIg
	B+ejEcnX3S4PeTSaib8uk/4dhvB8p/wbtSMTqion8mupx4+Gzfy/vbZUac/vg5cD220hnyJnpzc
	+madfZj1OTr9Y3jj+X/dwQI9auW/ddcsC4twRRyEnofJVVZcf0RozSDMxUCqS2LN65
X-Google-Smtp-Source: AGHT+IGdhpyzYu4BhIePuQrtKjjUpc7LRGmP1ebQarF2sk3JCTlMsTuiY9eh4vUQWJt7nYx350qp3Ueo+7e5
X-Received: by 2002:ac8:5d4d:0:b0:4ed:b409:ca27 with SMTP id d75a77b69052e-4ffb4a3c298mr201953221cf.10.1768199631408;
        Sun, 11 Jan 2026 22:33:51 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-89077154339sm21585676d6.26.2026.01.11.22.33.51
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jan 2026 22:33:51 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b10c2ea0b5so208456485a.0
        for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 22:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768199631; x=1768804431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVi5uHDjVopShqD0MnuBnlMmLMJhBdagK4kolEfksCA=;
        b=K8mF+/mXV8pxoZipXaqZuHBOfplXhyCVMjmIFaL5JrqI8jfv/vLEndkqfSR0BmIwmb
         0x68Y3HenpnW+AkZpHcQ862K2LXXPCX/HqD/+ZM1kAMbZHhPNtGkt3IYcxUS73Zv6PNB
         nFLFMIqGvK9BagVVhkpA2J/uFuTj2pO7JsJ8s=
X-Forwarded-Encrypted: i=1; AJvYcCW4htaVB5//fogxUkZCni9J3K4gSH2MBagypxNBVpwNsJDzwZ7YZV+bMPSA1Dxnrgi5Qq4=@vger.kernel.org
X-Received: by 2002:a05:620a:298f:b0:8b2:9aba:e86e with SMTP id af79cd13be357-8c38940c9f3mr1774032485a.10.1768199630689;
        Sun, 11 Jan 2026 22:33:50 -0800 (PST)
X-Received: by 2002:a05:620a:298f:b0:8b2:9aba:e86e with SMTP id af79cd13be357-8c38940c9f3mr1774031285a.10.1768199630241;
        Sun, 11 Jan 2026 22:33:50 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a794bsm1472324885a.9.2026.01.11.22.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 22:33:49 -0800 (PST)
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
	Sharath Chandra Vurukala <quic_sharathv@quicinc.com>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.10.y 1/3] net: Add locking to protect skb->dev access in ip_output
Date: Mon, 12 Jan 2026 06:30:37 +0000
Message-ID: <20260112063039.2968980-2-keerthana.kalyanasundaram@broadcom.com>
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


