Return-Path: <bpf+bounces-78521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7123AD10BF3
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 07:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96304302E624
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 06:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B621531A55A;
	Mon, 12 Jan 2026 06:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PT+5uNcx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f99.google.com (mail-ot1-f99.google.com [209.85.210.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708FA311C05
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 06:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768200547; cv=none; b=WSbbXx2xO7qH3dO8DWSAhNqWqb+YuyY171+BaSL269YS4L/OgHhbw2/CCtFVoF+MFMPA+QNHSuDn2TuNARNGBCusADyTIXR0gFaf0/m4IcGHL9ti1/yyolI59fsaJeGCwNY9UEXnTHBe4wrIGBaHDJwXfKX7uEElN24+obKAM2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768200547; c=relaxed/simple;
	bh=jYBzilHy4uOLFSnJiriQsA7w6X3PlTJkV/wPDhkmaOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrND90a7zW4t4iqekOJG1HPQWsuzqNQiwQF5SmUNxU8klNze/3gton8UR6ZXzjyGqIKyQDrlSbvJmVunEJ0aESTIMhFl4mUEv3madlA3xztEwjCNBfdZEaWAk5DkRTBGDBk9qkj+q3AJgILKOBnMhcr2Gw5YiQg4FohI1ShB6bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PT+5uNcx; arc=none smtp.client-ip=209.85.210.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f99.google.com with SMTP id 46e09a7af769-7c76298289fso641290a34.3
        for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 22:49:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768200541; x=1768805341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hCVdv4m2I2tGw1NCiXtF6yNB9U/7aaThOP/Q2QRKRAI=;
        b=mPjZND19EXdoHmgX1SovfJB5uayZLmHP3tbEINYa/64GbSD93vZ5eyzNTw6+ChBHEc
         sEZ9zEdKjJNmxZaaHPhMImvMeIoordr+zluceNFjZXw8VgG4oDOUqZb8CDJFSQfPp39c
         +qTe2O24LZY9kF6cy9KwBbiZVoD7cTjnL+BfQwCZxEA4azL9y/coM8qX8EhBPrw9N2o5
         TfHx/g650ajTvboRkytaFTZNP9N0NJMBzza9L3tKtVf8UjT1bTsTGwp8gl4/dY0JsmTh
         9prK7BG93cr+BQVQji3J+VFFAzyUJ5V1RbjXxlcdEij26v5oQMKxOo7FqBeRfg1BIw37
         b1UA==
X-Forwarded-Encrypted: i=1; AJvYcCVCowVwiatxYZRKffjwIvo5Xz7pbN8LCLLVBs46AuzVZZymr8Slf/iwhRh9wMlYc51uvfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YymK+DryTF5DJn+keX48ebImz5Gp0fKbNwSPxrJnvmABP0Z/EIu
	juG61JF7er/divI0B8JDCzh6MZsnYtoxjDJ3ZTtj+9LIOrqjLgijWk/zO56QmWLFnkn1uwH1774
	G75BMDhsbgrgi5RF6Ucbpyc6hAqKxew0h66Fwc9cdEs0xn6LHe6sPPJWg/lydxCqR+TXGX4c+qK
	YL19xbMBij2lCyedU9nB6pi5JF8cPbdQCnN2f6kwkO9KiVjeCxyCXmKpC7PlxxQPDEneFJ0RV9h
	L8X8VbPBaHRtBT9qHhdEkAN3b0=
X-Gm-Gg: AY/fxX4LZzrlZCGX96s4XAzdXLW7ysLCIbmWK1Sk4V6sR6amsL3XBJSTsKA7yAYB8+9
	P51z40huXnmGsfe11/z57srC468e37j743qrLF2duGGF3avPknIoBMYBDRhQLI+LjY4T/1Kq5Hy
	3MiGjA74PFLrpalNYdCak8XfnaEJdIJ2cZM5K4utd4bTxrjDeLpgjUJMVwSZjpcpFG/s+UBrkwH
	76vXwfqa5QQ/nwgAzWEypPwX57QA3dwDfnGS+L7y73aB96vtR2nmhf4V15mhkN9Cc0a0aE/DrwY
	5BsTLReMlAbiZ+eSUUGGRK2TQhAy6UHLjKQ/DyJjup7weVJBgxB3aY/IzoLYklelif0omToKY6w
	e5XNKAF7B6PJ0cDXo3mOlfcjU2lVbbcpjYdULN4eOoOtXVkCqxDeNj2AisiF22xXWlOPndne0FY
	FBNo+UlCA0kRH/0FpWfMBybLnOhVgYyeTAFeQghbgtR44OXl1Lsh36Y9khm6g=
X-Google-Smtp-Source: AGHT+IGStfuJEP613bZU5MYJK/1xNbu/6hzgm7lo0nWVa5fJLGQXiEjIdmRxX6KeUW+OFqf1DymUYSChlcwh
X-Received: by 2002:a05:6830:3482:b0:7c9:3e22:27d3 with SMTP id 46e09a7af769-7ce50b81d53mr8796434a34.3.1768200541065;
        Sun, 11 Jan 2026 22:49:01 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7ce478af807sm2873154a34.7.2026.01.11.22.49.00
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jan 2026 22:49:01 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88882c9b4d0so19549606d6.0
        for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 22:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768200540; x=1768805340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCVdv4m2I2tGw1NCiXtF6yNB9U/7aaThOP/Q2QRKRAI=;
        b=PT+5uNcxngRgtkPosqafT0zam8FN1ZFd5eArmbJHBwTIxBNNZ290z8cJcQ0dRla4xI
         YHUUJyjWXJ+EaOcqk0zE5p4eXOSZH6jzRc3z2R5Q6FF3twiQiNfTJdxqNVoUSuzv/QGv
         oKd5rlj0qUMC076DfuuC76cqcPUU64BP/DlDc=
X-Forwarded-Encrypted: i=1; AJvYcCUZ8836c8adOmjEBwtw3ADoETonBrn9RqQ4l2sJRxVLf6tgANVUQN6auw7EOWSEFrD3I/s=@vger.kernel.org
X-Received: by 2002:ad4:5f0c:0:b0:880:6fa4:f55c with SMTP id 6a1803df08f44-890842a447bmr200994326d6.6.1768200540088;
        Sun, 11 Jan 2026 22:49:00 -0800 (PST)
X-Received: by 2002:ad4:5f0c:0:b0:880:6fa4:f55c with SMTP id 6a1803df08f44-890842a447bmr200994186d6.6.1768200539673;
        Sun, 11 Jan 2026 22:48:59 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e472csm131125426d6.23.2026.01.11.22.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 22:48:59 -0800 (PST)
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
	Sharath Chandra Vurukala <quic_sharathv@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH Internal v6.6.y 1/2] net: Add locking to protect skb->dev access in ip_output
Date: Mon, 12 Jan 2026 06:45:53 +0000
Message-ID: <20260112064554.2969656-2-keerthana.kalyanasundaram@broadcom.com>
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
Stable-dep-of: 833d4313bc1e ("mptcp: reset blackhole on success with non-loopback ifaces")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Keerthana: Backported the patch to v6.6.y ]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 include/net/dst.h    | 12 ++++++++++++
 net/ipv4/ip_output.c | 17 ++++++++++++-----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index 60fb5d2fa..55d1be268 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -569,6 +569,18 @@ static inline void skb_dst_update_pmtu_no_confirm(struct sk_buff *skb, u32 mtu)
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
index b8cfe6afc..802d4f2ca 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -425,15 +425,20 @@ int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 int ip_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct net_device *dev = skb_dst(skb)->dev, *indev = skb->dev;
+	struct net_device *dev, *indev = skb->dev;
+	int ret_val;
 
+	rcu_read_lock();
+	dev = skb_dst_dev_rcu(skb);
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

