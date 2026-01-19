Return-Path: <bpf+bounces-79447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F129CD3A775
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 12:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5BB630B93B7
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 11:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F80D318EE5;
	Mon, 19 Jan 2026 11:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="V1j/l9jC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C65231A568
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 11:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768823565; cv=none; b=Uq1HE3Kok+aPmVbWZ2x3J6PUm2TRZNYH0CbTysjiRNIiqQQC1Pb8+qOCs+Xro3pP8N0RwkTUYp/aN97ZksP7aaPxs15837IvN50qF8pQjTnNTck1DxHDc7hSoUuPrcz49bUh5H7j/wxq9pOWHvUyHQmyukbqp0keScKML/wd0yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768823565; c=relaxed/simple;
	bh=7s21PiKqoDI2UWcnusRjQAy1HY+xab4PIu+TPyMO0+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDzOzm/IyrZXOkm+jfOG5TNnJBzY+HcGXoJm5QYLGYDTFeqwIO1cPdoNErz9tz8lhK1oPhHHqQ8wmc9Mj3oG1JqrYv80zjVGpWs0PpmAKNmHNK4AU7ECoun7yntiX5eEl83JrUIORNIyID6e+N80oaTaqfXzkuHj8+7Qabzj6j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=V1j/l9jC; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2a08c65fceeso7324075ad.2
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 03:52:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768823558; x=1769428358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N7MKZiatBshCjLhK/wnOMzSh/LSYhDXgYWq/2BVz61M=;
        b=MRH6SyHWjuP6L3GONuCK29JirzWRtF/zEBDakvqIVAjYgQh+pDN0iWJaLoCmPXtI0I
         1DaUNmQmBajwM/zDPC2tOBciNpyPzlX0YX23ftHoyo36SQrg7PFNGcBhrtXJ+D0nJJYk
         Pcrarc6HoFPsAja2OTj+4xHBCDUJUXP8XqgTgBdtJRCAEdt6sehx/6O0+8I6RcNITwed
         gqKqAArGZ5wAp1HR6Ff6Lyl3HvczTWIfH5i/Pv5C6V2Em93DERDQlYT+wejMitVT37mX
         crVy83Zg5ntcHJ4bnvGNvHOak2e767r+pGbk6JsV1Mzq3yhKwO3ilEqnJUNKz5bX8/O1
         9Ftw==
X-Forwarded-Encrypted: i=1; AJvYcCUxB2DGROGAvUdM0mQgBydIc5JjljnF6OntRfMTjrtiHfTr8zNw2oeifJZLupcFJQ17UmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb7sS7f5WEPT3JC7Uh85JRce9JOoHhkuDAeO5QO8IU8CSwMyjP
	iPUnUCdmuKaMibfI4a3k8W/5119OwUu0utDcqknxLpCQBE9zEgQiUBqMbe7W7+dHVIVojdVP4M0
	GwN850BvVeRY3UsNElHwvdj7Y2WxjoDWh84xpWHoq5f1bVSOwHFbQeA//SpOyH8Pi2yj//RjgTd
	OzqfEu6Bi0PuI9fQdn2M73I01Ej8InDW5Yyg9owI0Ce7yofNoN3AFEokssLLYFnSojKdDeaa+Wc
	n+rPdwy7SHguMrZxAgN9ZveyPY=
X-Gm-Gg: AZuq6aJIswwdBpYlvgW2vJR4h6DMT6D4SBYqRFGTdtfUsu0yzsUUwI1XTMET5YkOj3g
	YFDu5CGPjVjvCCjbDKocrMi7JqAQWRr8HLAI2lbAX4ldBUzHV01h6cs5Du2z9vw63RnA2C6eIUI
	j7AO8ymqMZqV9Gly4JNO0eiggzZ9u49pB0DOd8k/8R6bMQzX4uo2JMEcNBzgzCUKf9SgVTkiXMC
	AiHpoFnYITlAAFrgdyW6aKntJUVIMhebCjNV87ve2f+jFnxwMKbdIhdc+Wpb5iJzt8zRNsPfQgw
	tpsZJa1mkiyfQ5gRniamnPDVYpTVcga5169g/odO6+XIDmf5oO7koA6VHmtfZyPZFBn9m/dPBwv
	pQ+pHCYsi5Ik2SjxJoNaJ3+dnGLkznVQGFcS6/LkYtLMQCq6Pe3q4qpNs6n5vo3ropz8fVjaFWi
	kOXgoBh7npwZkTHTeTxNk0ij/CKUld64lusFOrY4g0xUH59Wsr2Wj+Tyq4e+qVUw==
X-Received: by 2002:a17:902:d489:b0:298:9a1:88e8 with SMTP id d9443c01a7336-2a7175ae0d6mr77371125ad.5.1768823558481;
        Mon, 19 Jan 2026 03:52:38 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a7193ac1d0sm13903795ad.56.2026.01.19.03.52.38
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 03:52:38 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c231297839so95683385a.1
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 03:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768823557; x=1769428357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7MKZiatBshCjLhK/wnOMzSh/LSYhDXgYWq/2BVz61M=;
        b=V1j/l9jC5hw3TTW/oKI/nSloeHMC2DVcjv1xKb+ipq3aDZJqfPQHOlcZfNbiPa5+iM
         Q+wMHaKo/xq/gbfYOQNa49PY72PBiqsYRuYk+FyaNmiup83i85QpwxcXFmpZq+Ybhxsf
         jX6aOjo54Qh6DP1QLDGgmS4e0+pfWB0R/38Es=
X-Forwarded-Encrypted: i=1; AJvYcCXuKbORK/L2TXuodjEA/6Y9GeX1RUGFnbg5y1KsaGZaSl0VSDKmxNjk28lNja4S/8EA4fQ=@vger.kernel.org
X-Received: by 2002:a05:620a:cd0:b0:8c6:a707:dae7 with SMTP id af79cd13be357-8c6a707dafdmr885239885a.1.1768823556965;
        Mon, 19 Jan 2026 03:52:36 -0800 (PST)
X-Received: by 2002:a05:620a:cd0:b0:8c6:a707:dae7 with SMTP id af79cd13be357-8c6a707dafdmr885236885a.1.1768823556365;
        Mon, 19 Jan 2026 03:52:36 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71bf2b0sm772878885a.12.2026.01.19.03.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 03:52:35 -0800 (PST)
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
	Sharath Chandra Vurukala <quic_sharathv@quicinc.com>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.15-v6.1 1/2] net: Add locking to protect skb->dev access in ip_output
Date: Mon, 19 Jan 2026 11:49:09 +0000
Message-ID: <20260119114910.1414976-2-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260119114910.1414976-1-keerthana.kalyanasundaram@broadcom.com>
References: <20260119114910.1414976-1-keerthana.kalyanasundaram@broadcom.com>
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
[ Keerthana: Backported the patch to v5.15-v6.1 ]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 include/net/dst.h    | 12 ++++++++++++
 net/ipv4/ip_output.c | 16 +++++++++++-----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index 3a1a6f94a..20a76e532 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -555,6 +555,18 @@ static inline void skb_dst_update_pmtu_no_confirm(struct sk_buff *skb, u32 mtu)
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
index 543d02910..79cf1385e 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -420,17 +420,23 @@ int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
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


